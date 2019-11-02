/// @desc Draws the light to the shadow map (not the screen)
/// @arg light The light to draw
/// @arg surface The surface to draw the light's shadow map to
/// @arg update True to update the light, otherwise false

var light = argument0;
var surface = argument1;
var update = argument2;

// Validate argument
if(__LIGHTING_ERROR_CHECKS and (!ds_exists(light, ds_type_list) or ds_list_size(light) != eLight.Count)) {
	// This array is not a light
	show_debug_message("light_draw(light): argument `light` is not a light array");
	return;
}

// Ensure that we have a valid shadow map surface
var has_shadow_map = surface_exists(surface);
if(!has_shadow_map) {
	// Failed to create a shadow map
	show_debug_message("light_draw(light): shadow map doesn't exist");
	return;
}

// If the light doesn't cast shadow and it uses a unique shadow map,
// and it isn't dirty then we don't need to redraw it
var flags = light[| eLight.Flags];
var unique_shadow_map = (flags & eLightFlags.UsesUniqueShadowMap) != 0;
var casts_shadow = (flags & eLightFlags.CastsShadows) != 0;
var dirty = (flags & eLightFlags.Dirty) != 0;

if(unique_shadow_map and !dirty and !casts_shadow) {
	// This light does not need to be redrawn
	// Keep its surface as it is
	return;
}

// Get the light's vertex buffer and shadow map
var vertexbuffer = update ? light_update(light) : light[| eLight.VertexBuffer];
var shadowMap = surface;

// Draw to the shadow ma p
surface_set_target(shadowMap);

// Clear the light's shadow map to no alpha black
draw_clear_alpha(c_black, 0);

// If it doesn't cast any shadows, we won't have a vertex buffer
if(vertexbuffer != undefined) {
	// Draw the shadow triangles onto the light's shadow map
	vertex_submit(vertexbuffer, pr_trianglelist, -1);
}

// Stop drawing to the shadow map
surface_reset_target();