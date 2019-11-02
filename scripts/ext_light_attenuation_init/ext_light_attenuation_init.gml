//
//	Globals for the default light attenuation extension module
//

// Attenuation parameters
global.EXT_attenuation_alpha = 0.2;
global.EXT_attenuation_beta = 0.4;

// Shader uniforms
global.u_AttenuationEnabled = shader_get_uniform(__LIGHT_SHADER, "u_AttenuationEnabled");
global.u_AttenuationAlpha = shader_get_uniform(__LIGHT_SHADER, "u_AttenuationAlpha");
global.u_AttenuationBeta = shader_get_uniform(__LIGHT_SHADER, "u_AttenuationBeta");