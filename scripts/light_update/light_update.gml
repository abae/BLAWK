/// @desc Update the vertex buffer for the given light
/// @arg light The light to update the vertex buffer of
/// @returns The vertex buffer for the light

var light = argument0;

// Validate argument
if(__LIGHTING_ERROR_CHECKS and (!ds_exists(light, ds_type_list) or ds_list_size(light) != eLight.Count)) {
	// This array is not a light
	show_debug_message("light_update(light): argument `light` is not a light array");
	return;
}

//
//	Because we cull lights that don't affect the global shadow map,
//	at this point we can guarantee that this light affects it
//	(at least from a naive mathematical perspective)
//

// This light is being rebuilt this frame
++global.worldRebuiltLights;

// Get the light's attributes
var light_x = light[| eLight.X];
var light_y = light[| eLight.Y];
var light_range = light[| eLight.Range];
var light_flags = light[| eLight.Flags];
var light_type = light[| eLight.Type];
var light_direction = light[| eLight.Direction];
var dirty = light_flags & eLightFlags.Dirty;
var static_storage = light[| eLight.StaticStorage];
var out_of_range_map = light[| eLight.ShadowCastersOutOfRange];
var culled_shadow_casters = light[| eLight.CulledShadowCasters];
var ignore_set = light[| eLight.IgnoreSet];
var light_last_camera = light[| eLight.ActiveCamera];
var light_is_directional = light_type == eLightType.Directional;

// Light is not dirty anymore after this
light[| eLight.Flags] &= ~eLightFlags.Dirty;

// Does this light cast shadows at all?
if((light_flags & eLightFlags.CastsShadows) == 0) {
	// No it doesn't
	return undefined;
}

// If it has a vertex buffer already, reuse it
var vbuffer = light[| eLight.VertexBuffer];
if(vbuffer == undefined) {
	// Create a vertex buffer
	vbuffer = vertex_create_buffer();
	light[| eLight.VertexBuffer] = vbuffer;
}

// Start writing to the vertex buffer
vertex_begin(vbuffer, global.lightVertexFormat);

// Get the camera we're rendering with to cull against
var camera = lighting_get_active_camera();
var camera_right = camera[0] + camera[2];
var camera_bottom = camera[1] + camera[3];

// Get the direction from the light to the center of the camera
var light_shadow_map;
if(!light_is_directional) light_shadow_map = point_direction(light_x, light_y, camera[eLightingCamera.X] + camera[eLightingCamera.Width] * 0.5, camera[eLightingCamera.Y] + camera[eLightingCamera.Height] * 0.5);

var offset_x, offset_y;
if(light_flags & eLightFlags.UsesUniqueShadowMap) {
	// Get the light's shadow map so we can convert from global to light space
	// Light is at the center of its shadow map
	var size = surface_get_width(light[| eLight.ShadowMap]);
	offset_x = light_x - size * 0.5;
	offset_y = light_y - size * 0.5;
}
else {
	// Get the camera we're rendering with so we can convert from global to camera space
	offset_x = camera[eLightingCamera.X];
	offset_y = camera[eLightingCamera.Y];
}

// If the light is dirty, destroy set of shadow casters out of range -- it is out of date
if(dirty and out_of_range_map != undefined) {
	ds_map_destroy(out_of_range_map);
	out_of_range_map = undefined;
	light[| eLight.ShadowCastersOutOfRange] = undefined;
}

// If the light is dirty or the camera is different, destroy set of culled shadow casters -- it is out of date
if(culled_shadow_casters != undefined and (dirty or light_last_camera == undefined or !array_equals(light_last_camera, camera))) {
	ds_map_destroy(culled_shadow_casters);
	culled_shadow_casters = undefined;
	light[| eLight.CulledShadowCasters] = undefined;
}

// Often used comparisons; can also save us a few lookups if initialized in the iteration
var has_ignore_set = ignore_set != undefined;
var has_out_of_range_map = out_of_range_map != undefined;
var has_culled_shadow_casters = culled_shadow_casters != undefined;

// Iterate over all shadow casters and trace shadows
with(obj_shadow_caster) {
	// Is the light ignoring this shadow caster?
	if(has_ignore_set and ds_map_exists(ignore_set, id)) {
		// Yes, skip it
		continue;
	}
	
	// Get shadow caster flags
	var shadow_caster_dirty = (flags & eShadowCasterFlags.Dirty) != 0;
	var shadow_caster_static = (flags & eShadowCasterFlags.Static) != 0;
	
	// If the shadow caster is static and it isn't dirty, do we have cached information to cull it?
	if(shadow_caster_static and !shadow_caster_dirty) {
		// Is this shadow caster known to be out of range of this light?
		// Directional lights are infinite so exclude those
		if(has_out_of_range_map and light_type != eLightType.Directional and ds_map_exists(out_of_range_map, id)) {
			// It is out of range
			continue;
		}
	
		// Check if it has been culled against this light
		if(has_culled_shadow_casters and ds_map_exists(culled_shadow_casters, id)) {
			// This shadow caster has been culled -- it does not affect this light
			continue;
		}
	}
	
	// Directional lights are infinite
	if(light_type != eLightType.Directional) {
		// Is the shadow caster's bounds within range of the light?
		if(!rectangle_in_rectangle(cached_polygon_area[0], cached_polygon_area[1], cached_polygon_area[2], cached_polygon_area[3],
								   light_x - light_range, light_y - light_range, light_x + light_range, light_y + light_range)) {
			// It is not within range of the light
			if(out_of_range_map == undefined) {
				// Create the map
				out_of_range_map = ds_map_create();
				light[| eLight.ShadowCastersOutOfRange] = out_of_range_map;
			}
			ds_map_add(out_of_range_map, id, 0);
			continue;
		}
		else if(has_out_of_range_map) { 
			// This shadow caster is not out of range
			ds_map_delete(out_of_range_map, id);
		}
	}
	
	// Is this shadow caster outside the active camera, and is the direction from the light pointing away from it?
	// Exclude directional light from this test for now
	if(!light_is_directional and outside_active_camera) {
		// It is outside the active camera
		// However its shadow might still affect the global shadow map
		var vertices = polygon[ePolygon.Length];
		// It's out of view by default - prove me wrong
		var out = true;
		
		// Iterate over each vertex until one of them affects the shadow map
		for(var i = 0; i < vertices; ++i) {
			var vertex = polygon[ePolygon.Count + i];
			// Compare direction from light to vertex
			var light_shadow_dir = point_direction(light_x, light_y, vertex[eVertex.X], vertex[eVertex.Y]);
			if(abs(angle_difference(light_shadow_dir, light_shadow_map)) <= 90) {
				// The shadow cast from this vertex affects the global shadow map
				out = false;
				break;
			}
		}
		
		if(out) {
			// The shadow will not affect the global shadow map
			// We can cull this shadow caster from this light
			if(culled_shadow_casters == undefined) {
				// Create the map
				culled_shadow_casters = ds_map_create();
				light[| eLight.CulledShadowCasters] = culled_shadow_casters;
			}
			ds_map_add(culled_shadow_casters, id, 0);
			continue;
		}
		else if(has_culled_shadow_casters) {
			// This light is not culled
			ds_map_delete(culled_shadow_casters, id);
		}
	}
	
	// The array of vertices that make up the shadow
	var shadow = undefined;
	
	// Is the shadow caster static, and if so do we need to rebuild its buffer?
	if(shadow_caster_static) {
		// The shadow caster is static
		if(!dirty and !shadow_caster_dirty) {
			// Neither the light nor shadow caster is dirty
			shadow = light_static_get_array(light, id);
		}
		else if(shadow_caster_dirty and (flags & eShadowCasterFlags.MarkedForCleanup) == 0) {
			// The shadow caster is dirty, mark it to get cleaned after the lighting pass
			// This will unset the dirty flag on it
			ds_list_add(global.worldDirtyShadowCasters, id);
			flags |= eShadowCasterFlags.MarkedForCleanup;
		}
	}
	
	if(shadow == undefined) {
		// Count this shadow caster as active
		++global.worldActiveShadowCasters;
		
		// Trace a shadow for this object
		shadow = light_trace_polygon(id, light);
		
		// Did it cast a shadow?
		if(shadow == undefined) {
			// No it didn't
			continue;
		}
		
		if(shadow_caster_static) {
			// Save the array; we copy it because the returned array is reused
			var copy = array_create(array_length_1d(shadow));
			array_copy(copy, 0, shadow, 0, array_length_1d(shadow));
			light_static_set_array(light, id, copy);
		}
	}
	
	// Write the shadow vertices to the vertex buffer
	var len = array_length_1d(shadow);
	// There's at least 3 vertices in the array, so add those outside loop
	var k = 0;
	var vertex = shadow[k++];
	vertex_position(vbuffer, vertex[eVertex.X] - offset_x, vertex[eVertex.Y] - offset_y);
	vertex_argb(vbuffer, $FF000000);
	vertex = shadow[k++];
	vertex_position(vbuffer, vertex[eVertex.X] - offset_x, vertex[eVertex.Y] - offset_y);
	vertex_argb(vbuffer, $FF000000);
	vertex = shadow[k++];
	vertex_position(vbuffer, vertex[eVertex.X] - offset_x, vertex[eVertex.Y] - offset_y);
	vertex_argb(vbuffer, $FF000000);
	// Add the rest in a loop
	for(; k < len; ++k) {
		// Get the current vertex
		vertex = shadow[k];
		// Add to the vertex buffer
		vertex_position(vbuffer, vertex[eVertex.X] - offset_x, vertex[eVertex.Y] - offset_y);
		vertex_argb(vbuffer, $FF000000);
	}
}

// Save the camera this light was updated for
light[| eLight.ActiveCamera] = camera;

// End the vertex buffer
vertex_end(vbuffer);

return vbuffer;