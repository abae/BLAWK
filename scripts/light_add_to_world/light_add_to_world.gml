/// @desc Add the light to the world, taking it into account for compositing
/// @arg light The light to add

var light = argument0;
ds_list_add(global.worldLights, light);