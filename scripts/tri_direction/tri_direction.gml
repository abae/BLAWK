/// @desc Gets the direction of a triangle (clockwise or counter-clockwise)
/// @arg a The first vertex in the triangle
/// @arg b The second vertex in the triangle
/// @arg c The third vertex in the triangle
/// @returns The direction of the triangle as an eTriDirection enum field

var a = argument0;
var b = argument1;
var c = argument2;

// Validate arguments
if(__LIGHTING_ERROR_CHECKS) {
	if(!is_array(a) or array_length_1d(a) != eVertex.Count) {
		// This array is not a vertex
		show_debug_message("tri_direction(a, b, c): argument `a` is not a vertex array");
		return undefined;
	}
	
	if(!is_array(b) or array_length_1d(b) != eVertex.Count) {
		// This array is not a vertex
		show_debug_message("tri_direction(a, b, c): argument `b` is not a vertex array");
		return undefined;
	}
	
	if(!is_array(c) or array_length_1d(c) != eVertex.Count) {
		// This array is not a vertex
		show_debug_message("tri_direction(a, b, c): argument `c` is not a vertex array");
		return undefined;
	}
}

// Subtract B from A and C
// Not using '@' accessor because we want to copy the array (i.e. not modify the input array)

a[eVertex.X] -= b[eVertex.X];
a[eVertex.Y] -= b[eVertex.Y];

c[eVertex.X] -= b[eVertex.X];
c[eVertex.Y] -= b[eVertex.Y];

var cp = cross_product(a, c);
return cp < 0 ? eTriDirection.Clockwise : eTriDirection.CounterClockwise;