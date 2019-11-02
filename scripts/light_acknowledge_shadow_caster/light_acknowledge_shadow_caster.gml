/// @desc Set one or more shadow casters that should no longer be ignored by the provided light
/// @arg light The light that should ignore the shadow casters
/// @arg [shadow_caster,...] The shadow casters to remove from the ignore list

//
//	This is the reverse of light_ignore_shadow_caster
//	and should only be used on shadow casters previously passed to that script
//

// Validate argument array
if(__LIGHTING_ERROR_CHECKS and argument_count <= 1) {
	show_debug_message("light_acknowledge_shadow_caster(light, ...): too few arguments (minimum 2)");
	return;
}

var light = argument[0];

// Validate argument
if(__LIGHTING_ERROR_CHECKS and (!ds_exists(light, ds_type_list) or ds_list_size(light) != eLight.Count)) {
	// This array is not a light
	show_debug_message("light_acknowledge_shadow_caster(light, ...): argument `light` is not a light array");
	return;
}

var map = light[| eLight.IgnoreSet];
if(map == undefined) {
	// No set; nothing to remove
	return;
}

for(var i = 1; i < argument_count; ++i) {
	var shadow_caster = argument[i];
	ds_map_delete(map, shadow_caster);
}

if(ds_map_size(map) == 0) {
	// Destroy the map
	ds_map_destroy(map);
	light[| eLight.IgnoreSet] = undefined;
}

// Mark the light as dirty
light[| eLight.Flags] |= eLightFlags.Dirty;