/// @desc Maintains the shadow map for the given light, creating, resizing and freeing it as necessary
/// @arg light The light that owns the shadow map
/// @returns True if the shadow map is valid, otherwise false

var light = argument0;
var shadowMap = light[| eLight.ShadowMap];
var useShadowMap = light[| eLight.Flags] & eLightFlags.UsesUniqueShadowMap;

if(!useShadowMap) {
	// Does the light have a shadow map it no longer uses?
	if(shadowMap != undefined) {
		if(surface_exists(shadowMap)) {
			// Free the unused surface
			surface_free(shadowMap);
		}
		light[| eLight.ShadowMap] = undefined;
	}
	return false;
}

// What is the expected shadow map size?
// Multiplied by two because we treat all lights as omnidirectional, so range is the radius of the light
var range = light[| eLight.Range];
var size = get_next_pot(ceil(range)) * 2;

if(shadowMap == undefined or !surface_exists(shadowMap) or surface_get_width(shadowMap) != size or surface_get_height(shadowMap) != size) {
	if(shadowMap != undefined and surface_exists(shadowMap)) {
		// Recreate the surface
		surface_free(shadowMap);
	}
	
	// Create the surface
	shadowMap = surface_create(size, size);
	light[| eLight.ShadowMap] = shadowMap;
}

// It might have failed to create
return surface_exists(shadowMap);