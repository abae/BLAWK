/// @desc Returns whether the point is inside the polygon or not
/// @arg polygon The polygon to check against
/// @arg point The point to check if it's inside or outside the polygon
/// @returns True if the point is inside the polygon, otherwise false

//
//	This script can be used with the vertex buffer to check if an instance is
//	in light or shadow -- if this script returns true on any polygon in the vertex buffer
//	the instance is in shadow
//

var polygon = argument0;
var point = argument1;

// Validate arguments
if(__LIGHTING_ERROR_CHECKS) {
	if(!is_array(polygon) or array_length_1d(polygon) <= 3) {
		// This array is not a polygon
		show_debug_message("point_in_polygon(polygon, point): argument `polygon` is not a polygon array, or has less than 3 polygon");
		return undefined;
	}
	
	if(!is_array(point) or array_length_1d(point) != eVertex.Count) {
		// This array is not a vertex
		show_debug_message("point_in_polygon(polygon, point): argument `point` is not a vertex array");
		return undefined;
	}
}

// Get the # of vertices in the polygon
var vertex_count = polygon[ePolygon.Length];
// Vertices in the polygon start after the ePolygon enum
var vertex_offset = ePolygon.Count;

// All triangles have to match this direction
var vertex_direction = tri_direction(polygon[vertex_offset], polygon[vertex_offset + 1], polygon[vertex_offset + 2]);

// Check all polygon against the point
for(var i = 0; i < vertex_count; ++i) {
	// Get the current vertex
	var current = polygon[vertex_offset + i];
	// Get the next vertex (and wrap around if it exceeds the array)
	var next = polygon[vertex_offset + ((i + 1) % vertex_count)];
	// Get the direction of the triangle (current, next, point)
	var vd = tri_direction(current, next, point);
	// Does it match the polygon direction?
	if(vd != vertex_direction) {
		// The point is outside the polygon
		return false;
	}
}

// The point is inside the polygon
return true;