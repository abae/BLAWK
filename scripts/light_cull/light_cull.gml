/// @desc Gets whether the provided light is culled (true) or not (false) for the current camera
/// @arg light The light to check
/// @arg camera The camera to cull against; this is lighting_get_active_camera, NOT a GMS2 camera!
/// @returns True if the light is culled, otherwise false

var light = argument0;
var camera = argument1;

// Validate argument
if(__LIGHTING_ERROR_CHECKS and (!ds_exists(light, ds_type_list) or ds_list_size(light) != eLight.Count)) {
	// This array is not a light
	show_debug_message("light_cull(light, camera): argument `light` is not a light array");
	return;
}

//
//	Will this light affect the global shadow map?
//

var type = light[| eLight.Type];

if(type == eLightType.Directional) {
	// We cannot cull an infinite light
	return false;
}

var range = light[| eLight.Range];
var light_x = light[| eLight.X];
var light_y = light[| eLight.Y];

// Does this fall within the current camera?
var camera_x = camera[eLightingCamera.X];
var camera_y = camera[eLightingCamera.Y];
var camera_w = camera[eLightingCamera.Width];
var camera_h = camera[eLightingCamera.Height];

// Do the rectangles overlap?
if(rectangle_in_rectangle(light_x - range, light_y - range, light_x + range, light_y + range,
						  camera_x, camera_y, camera_x + camera_w, camera_y + camera_h)) {
	// Do not cull this light
	return false;
}

// Cull this light
return true;