/// @desc Executed before compositing the lighting map

// Reset counters
global.worldRebuiltLights = 0;
global.worldActiveShadowCasters = 0;

// Get the camera
var camera = lighting_get_active_camera();

with(obj_shadow_caster) {
	// Get shadow caster flags
	var shadow_caster_dirty = (flags & eShadowCasterFlags.Dirty) != 0;
	var shadow_caster_static = (flags & eShadowCasterFlags.Static) != 0;

	// Update this shadow caster's polygon if necessary
	if(shadow_caster_dirty or !shadow_caster_static or cached_polygon_area == undefined) {
		// Rebuild polygon cache
		cached_polygon_area = polygon_get_area(polygon);
		// Get whether the polygon is outside the active camera
		outside_active_camera = !rectangle_in_rectangle(cached_polygon_area[0], cached_polygon_area[1], cached_polygon_area[2], cached_polygon_area[3],
														camera[eLightingCamera.X], camera[eLightingCamera.Y], camera[eLightingCamera.X] + camera[eLightingCamera.Width], camera[eLightingCamera.Y] + camera[eLightingCamera.Height])
		// And keep track of the camera we compared against
		last_camera = camera;
	}
	else if(last_camera == undefined or !array_equals(last_camera, camera)) {
		// The camera changed, or this is the first time this shadow caster has been checked against this camera
		// Get whether the polygon is outside the active camera
		outside_active_camera = !rectangle_in_rectangle(cached_polygon_area[0], cached_polygon_area[1], cached_polygon_area[2], cached_polygon_area[3],
														camera[eLightingCamera.X], camera[eLightingCamera.Y], camera[eLightingCamera.X] + camera[eLightingCamera.Width], camera[eLightingCamera.Y] + camera[eLightingCamera.Height])
		// And keep track of the camera we compared against
		last_camera = camera;
	}
}