/// @desc Create a new spot light
/// @arg x The X position of the light
/// @arg y The Y position of the light
/// @arg shadow_length The length of shadows cast by the light
/// @arg color The color of the light
/// @arg range The range of the light in pixels
/// @arg intensity The intensity of the light (must be positive)
/// @arg angle The angle of the spot light's cone
/// @arg direction The direction of the spot light
/// @returns The created light

// Gather the arguments
var lx = argument0;
var ly = argument1;
var shadow_length = argument2;
var col = argument3;
var range = argument4;
var intensity = argument5;
var angle = argument6;
var dir = argument7;

// Create the light
var light = light_create(lx, ly, shadow_length, eLightType.Spot, col, range, intensity);

// Set spot light properties
light[| eLight.Angle] = angle;
light[| eLight.Direction] = dir;

return light;