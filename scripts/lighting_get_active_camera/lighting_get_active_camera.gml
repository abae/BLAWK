/// @desc Gets the active camera
/// @returns The active camera port [X, Y, Width, Height]

if(global.worldCustomCamera == undefined) {
	// Get active view camera
	var camera = camera_get_active();
	var cameraX = camera_get_view_x(camera);
	var cameraY = camera_get_view_y(camera);
	var cameraW = camera_get_view_width(camera);
	var cameraH = camera_get_view_height(camera);
	return [cameraX, cameraY, cameraW, cameraH];
}

return global.worldCustomCamera;