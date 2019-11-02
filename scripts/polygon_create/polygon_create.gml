/// @desc Create a polygon from a set of points
/// @arg set The set of points, each point being a 1D array of type eVertex
/// @returns Returns the polygon array

var set = argument0;

// Validate argument
if(__LIGHTING_ERROR_CHECKS and !is_array(set)) {
	show_debug_message("polygon_create(set): argument `set` is not an array");
	return undefined;
}

// Get the length of the 1-dimensional array
var length = array_length_1d(set);

// Validate array
if(__LIGHTING_ERROR_CHECKS and length <= 0) {
	show_debug_message("polygon_create(set): argument `set` is not an array with a positive length");
	return undefined;
}

// Create the polygon
var polygon = array_create(length + ePolygon.Count);

// Set the polygon fields
polygon[ePolygon.Length] = length; // Length of array of vertices
								   // We don't really need to store this, but it's nice to have for readability and clean code

// Copy the source array to the polygon
array_copy(polygon, ePolygon.Count, set, 0, length);

// All done!
return polygon;