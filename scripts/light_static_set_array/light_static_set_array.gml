/// @desc Sets the static buffer for a light and shadow caster pair
/// @arg light The light
/// @arg shadow_caster The shadow caster
/// @arg buffer The buffer to save

var light = argument0;
var shadow_caster = argument1;
var arr = argument2;

var static_storage = light[| eLight.StaticStorage];
if(static_storage == undefined) {
	static_storage = ds_map_create();
	light[| eLight.StaticStorage] = static_storage;
}

static_storage[? shadow_caster] = arr;