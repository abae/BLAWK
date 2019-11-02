/// @desc Apply the light attenuation extension to the given light
/// @arg light The light to apply the extension to

var light = argument0;

// Enable attenuation in the shader
shader_set_uniform_i(global.u_AttenuationEnabled, true);
shader_set_uniform_f(global.u_AttenuationAlpha, global.EXT_attenuation_alpha);
shader_set_uniform_f(global.u_AttenuationBeta, global.EXT_attenuation_beta);