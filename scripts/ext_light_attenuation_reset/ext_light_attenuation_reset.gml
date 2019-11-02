/// @desc Reset the extension module after being applied to a light
/// @arg light The light it was applied to

var light = argument0;

// Disable attenuation in the shader
shader_set_uniform_i(global.u_AttenuationEnabled, false);