/// @desc Draws the composited shadow map
/// @arg x The X position at which to draw the shadow map
/// @arg y The Y position at which to draw the shadow map

var X = argument0;
var Y = argument1;
var surface = global.worldShadowMap;

//
//	Set subtractive blend mode
//
gpu_set_blendmode(bm_subtract);

//
//	Subtract world light map from the shadow
//
shader_set(__WORLD_SHADOW_MAP_SHADER);

// Shadow intensity
shader_set_uniform_f(global.u_AmbientShadow, global.ambientShadowIntensity);
shader_set_uniform_f_array(global.u_TexelSize_ShadowMap, [1.0 / surface_get_width(surface), 1.0 / surface_get_height(surface)]);

//
// Draw shadow map to the screen
//
draw_surface(surface, X, Y);

shader_reset();

//
//	Reset blend mode
//
gpu_set_blendmode(bm_normal);