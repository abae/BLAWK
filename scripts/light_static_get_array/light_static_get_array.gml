/// @desc Gets the static buffer for a light and shadow caster pair
/// @arg light The light
/// @arg shadow_caster The shadow caster
/// @returns The stored buffer, or undefined

var light = argument0;
var shadow_caster = argument1;

var static_storage = light[| eLight.StaticStorage];
if(static_storage == undefined) return undefined;

return static_storage[? shadow_caster];