/// @desc Create a new point light
/// @arg x The X position of the light
/// @arg y The Y position of the light
/// @arg shadow_length The length of shadows cast by the light
/// @arg color The color of the light
/// @arg range The range of the light in pixels
/// @arg intensity The intensity of the light (must be positive)
/// @returns The created light

// Gather the arguments
var lx = argument0;
var ly = argument1;
var shadow_length = argument2;
var col = argument3;
var range = argument4;
var intensity = argument5;

return light_create(lx, ly, shadow_length, eLightType.Point, col, range, intensity);