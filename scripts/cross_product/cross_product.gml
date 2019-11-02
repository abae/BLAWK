/// @desc Gets the cross product of two vectors
/// @arg v1 The first vector
/// @arg v2 The second vector
/// @returns The cross product of the two vectors

var v1 = argument0;
var v2 = argument1;

// Validate arguments
if(__LIGHTING_ERROR_CHECKS) {
	if(!is_array(v1) or array_length_1d(v1) != eVertex.Count) {
		// This array is not a vertex
		show_debug_message("cross_product(v1, v2): argument `v1` is not a vertex array");
		return undefined;
	}
	
	if(!is_array(v1) or array_length_1d(v1) != eVertex.Count) {
		// This array is not a vertex
		show_debug_message("cross_product(v1, v2): argument `v2` is not a vertex array");
		return undefined;
	}
}

return v1[eVertex.X] * v2[eVertex.Y] - v1[eVertex.Y] * v2[eVertex.X];