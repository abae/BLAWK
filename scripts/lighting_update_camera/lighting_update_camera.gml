/// @desc Updates the custom camera to use with the lighting system (otherwise uses active view camera)
/// @arg x The top left corner of the camera
/// @arg y The top right corner of the camera
/// @arg width The width of the camera
/// @arg height The height of the camera

// Inline this script
gml_pragma("forceinline");

var camera_x = argument0;
var camera_y = argument1;
var camera_width = argument2;
var camera_height = argument3;

if(global.worldCustomCamera == undefined) {
	// Create the custom camera array
	global.worldCustomCamera = array_create(4);
}

// Update the custom camera
global.worldCustomCamera[0] = camera_x;
global.worldCustomCamera[1] = camera_y;
global.worldCustomCamera[2] = camera_width;
global.worldCustomCamera[3] = camera_height;