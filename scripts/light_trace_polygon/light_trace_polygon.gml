/// @desc Trace a shadow for the given polygon from the provided light
/// @arg shadow_caster The shadow caster that is being illuminated
/// @arg light The light that illuminates the polygon
/// @returns An array of vertices (at least 3) as a triangle list that is the shadow, or undefined if no shadow is cast

var shadow_caster = argument0;
var light = argument1;

// Get the shadow caster attributes
var polygon = shadow_caster.polygon;
var sc_shadow_length = shadow_caster.shadow_length;

// Validate arguments
if(__LIGHTING_ERROR_CHECKS) {
	if(!is_array(polygon) or array_length_1d(polygon) <= 3) {
		// This array is not a polygon
		show_debug_message("light_trace_polygon(polygon, light): argument `polygon` is not a polygon array, or has less than 3 vertices");
		return undefined;
	}
	
	if(!ds_exists(light, ds_type_list) or ds_list_size(light) != eLight.Count) {
		// This array is not a light
		show_debug_message("light_trace_polygon(polygon, light): argument `light` is not a light array");
		return undefined;
	}
}

//
//	Note that this produces a quad for each side of the polygon
//	It does not close the resulting triangle list
//

// Get the light's attributes
var light_x = light[| eLight.X];
var light_y = light[| eLight.Y];
var light_range = light[| eLight.Range];
var light_type = light[| eLight.Type];
var light_direction = light[| eLight.Direction];
var shadow_length = min(sc_shadow_length, light[| eLight.ShadowLength]);
var line_emitter = light_type == eLightType.Area or light_type == eLightType.Line;

// Get the # of vertices in the polygon
var vertex_count = polygon[ePolygon.Length];
// Vertices in the polygon start after the ePolygon enum
var vertex_offset = ePolygon.Count;

if(vertex_count < 3) {
	// We cannot form a valid shadow from this polygon
	return undefined;
}

// Get the vertex array
var face_vertices = 6 * vertex_count;
var shadow_index = 0;
var shadow_array = global.lightVertexArrayMap[? face_vertices];
if(shadow_array == undefined) {
	// Initialise the array of this size
	shadow_array = array_create(face_vertices);
	global.lightVertexArrayMap[? face_vertices] = shadow_array;
}

if(line_emitter) {
	// Precompute variables for the area or line light to use per-vertex
	var _dir = light_direction + 90;
	var _w = light[| eLight.Width] * 0.5; // * 0.5 because the line emitter is centered on the light
	var _c = cos(_dir * pi / 180) * _w;
	var _s = -sin(_dir * pi / 180) * _w;
	var areaPoint1 = [light_x - _c, light_y - _s];
	var areaPoint2 = [light_x + _c, light_y + _s];
	var p1p2 = [areaPoint2[0] - areaPoint1[0], areaPoint2[1] - areaPoint1[1]];
	var p1p2_dot = dot_product(p1p2[0], p1p2[1], p1p2[0], p1p2[1]);
}

// For each vertex in the polygon, trace a line from the light
var v1, v2;
for(var i = 0; i < vertex_count; ++i) {
	// Get the current vertex
	var vertex = polygon[vertex_offset + i];
	var vx = vertex[eVertex.X];
	var vy = vertex[eVertex.Y];
	var langle = light_direction;
	
	if(line_emitter) {
		// Either the vertex is perpendicular to the line emitter,
		// or we take the angle to whichever vertex on the line this polygon vertex is closest to
		var p1v = [vx - areaPoint1[0], vy - areaPoint1[1]];
		var projection = dot_product(p1v[0], p1v[1], p1p2[0], p1p2[1]) / p1p2_dot;
		if(projection < 0.0) langle = point_direction(areaPoint1[0], areaPoint1[1], vx, vy);		// Vertex
		else if(projection > 1.0) langle = point_direction(areaPoint2[0], areaPoint2[1], vx, vy);	// Vertex
		else {
			// Perpendicular
			var ___x = areaPoint1[0] + p1p2[0] * projection;
			var ___y = areaPoint1[1] + p1p2[1] * projection;
			langle = point_direction(___x, ___y, vx, vy);
		}
	}
	else if(light_type != eLightType.Directional) {
		// Angle from light to vertex
		langle = point_direction(light_x, light_y, vx, vy);
	}
	
	if(i == 0) {
		// Set first line
		v1 = vertex;
		v2 = [vx + lengthdir_x(shadow_length, langle), vy + lengthdir_y(shadow_length, langle)];
	}
	else {
		// Second line
		var v3 = vertex;
		var v4 = [vx + lengthdir_x(shadow_length, langle), vy + lengthdir_y(shadow_length, langle)];
		
		// Create a triangle between v1,v2,v3
		shadow_array[@ shadow_index++] = v1;
		shadow_array[@ shadow_index++] = v2;
		shadow_array[@ shadow_index++] = v3;
	
		// Create a triangle between v3,v4,v2
		shadow_array[@ shadow_index++] = v3;
		shadow_array[@ shadow_index++] = v4;
		shadow_array[@ shadow_index++] = v2;
		
		// Start next line where this ended
		v1 = v3;
		v2 = v4;
	}
}

//
//	Close the shadow polygon
//

// Create a triangle between v1,v2,v3
shadow_array[@ shadow_index++] = v1;
shadow_array[@ shadow_index++] = v2;
shadow_array[@ shadow_index++] = shadow_array[0];
// Create a triangle between v3,v4,v2
shadow_array[@ shadow_index++] = shadow_array[0];
shadow_array[@ shadow_index++] = shadow_array[1];
shadow_array[@ shadow_index++] = v2;

return shadow_array;