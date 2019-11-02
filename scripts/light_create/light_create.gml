/// @desc Create a new light
/// @arg x The X position of the light
/// @arg y The Y position of the light
/// @arg shadow_length The length of shadows cast by the light
/// @arg type The type of the light
/// @arg color The color of the light
/// @arg range The range of the light in pixels
/// @arg intensity The intensity of the light (must be positive)
/// @returns The created light

// Gather the arguments
var lx = argument0;
var ly = argument1;
var shadow_length = argument2;
var type = argument3;
var col = argument4;
var range = argument5;
var intensity = argument6;

//
//	Public
//

// Create the light
var arr = ds_list_create();
arr[| eLight.X] = lx;
arr[| eLight.Y] = ly;
arr[| eLight.Color] = col;
arr[| eLight.Intensity] = intensity;
arr[| eLight.Range] = range;
arr[| eLight.Type] = type;

// All lights start off as dirty and all lights cast shadows by default
arr[| eLight.Flags] = eLightFlags.Dirty | eLightFlags.CastsShadows;

arr[| eLight.ShadowLength] = shadow_length;

var lutIntensity = undefined;
switch(type) {
	case eLightType.Point: lutIntensity = spr_lut_light_intensity_linear; break;
	case eLightType.Spot: lutIntensity = spr_lut_light_intensity_spot; break;
	case eLightType.Area: lutIntensity = spr_lut_light_intensity_area; break;
	case eLightType.Line: lutIntensity = spr_lut_light_intensity_line; break;
	case eLightType.Directional: lutIntensity = undefined; break; /* Infinite light; no gradient */
}
arr[| eLight.LutIntensity] = lutIntensity == undefined ? undefined : sprite_get_texture(lutIntensity, 0);

//
//	Default specializations
//

arr[| eLight.Angle] = 0;
arr[| eLight.Direction] = 0;
arr[| eLight.Width] = 0;

//
//	Extension modules
//

arr[| eLight.ExtensionModules] = undefined;

//
//	Game-specific functionality
//

arr[| eLight.IgnoreSet] = undefined;

//
//	Internal
//

// We need to update the light to build the vertex buffer before we can show it
arr[| eLight.VertexBuffer] = undefined;

// Not all lights are suited to have their own shadow map surface
arr[| eLight.ShadowMap] = undefined;

// Only create the data structures when they're needed
arr[| eLight.StaticStorage] = undefined;
arr[| eLight.ShadowCastersOutOfRange] = undefined;
arr[| eLight.CulledShadowCasters] = undefined;

// Must be rendered first
arr[| eLight.ActiveCamera] = undefined;

//
//	Add default extensions
//

if(global.lightDefaultExtensions != undefined) {
	var len = array_length_1d(global.lightDefaultExtensions);
	for(var i = 0; i < len; ++i) {
		var ext = global.lightDefaultExtensions[i];
		light_add_extension(arr, ext);
	}
}

// Return the light
return arr;