/// @desc Composite the shadow map from all the lights
/// @arg lights The ds_list of lights, in order, to composite
/// @returns True if it succeeded, otherwise false

var lights = argument0;
var lightCount = ds_list_size(lights);

// Pre-composite step
lighting_pre_composite();

if(lightCount == 0) {
	// They mostly come at night...mostly...
	show_debug_message("composite_shadow_map(lights): ignoring action, there are no lights");
	return false;
}

if(!shadow_casters_exist()) {
	// There are no shadow casters
	show_debug_message("composite_shadow_map(lights): ignoring action, there are no shadow casters");
	return;
}

// Ensure that we have a valid shadow map surface
var has_shadow_map = shadow_map_ensure_exists(eShadowMap.Global);
if(!has_shadow_map) {
	// Failed to create a shadow map
	show_debug_message("composite_shadow_map(lights): failed to create global shadow map");
	return false;
}

var colorArray = global.tmp_ColorArray;
var firstUseOfGlobalShadowMap = true;

// Get the camera we're rendering with
var camera = lighting_get_active_camera();
var cameraX = camera[eLightingCamera.X];
var cameraY = camera[eLightingCamera.Y];
var cameraW = camera[eLightingCamera.Width];
var cameraH = camera[eLightingCamera.Height];

// Composite all shadow maps into a single texture
for(var i = 0, firstLight = true; i < lightCount; ++i) {
	// Get the light's shadow map
	var light = ds_list_find_value(lights, i);
	
	// Can this light be culled?
	if(light_cull(light, camera)) {
		// Yes, no reason to draw it
		continue;
	}
	
	// Get the type of the light
	var lightType = light[| eLight.Type];
	// Get the light's range attribute
	var lightRange = light[| eLight.Range];
	// The light's position depends if it has its own shadow map
	var lightTexelX, lightTexelY;
	// Conversion from pixels to texels for this light
	var texelConvX, texelConvY;
	// The surface to draw the light to
	var shadowMap = undefined;
	
	// Directional lights are infinite and have no source, so there's no optimization to be had here
	// Area and line lights are tricky and they shouldn't be used excessively in any case
	if(lightType != eLightType.Directional and lightType != eLightType.Area and lightType != eLightType.Line) {
		// Should this light be using a unique shadow map?
		// Multiplied by two because we treat all lights as omnidirectional, so range is the radius of the light
		var shadowMapSize = get_next_pot(ceil(lightRange)) * 2;
		var useShadowMap = shadowMapSize <= global.lightMaxUniqueShadowMapSize;
		if(useShadowMap) light[| eLight.Flags] |= eLightFlags.UsesUniqueShadowMap;
		else light[| eLight.Flags] &= ~eLightFlags.UsesUniqueShadowMap;
		
		// Update the light's shadow map
		// This will create, resize and free it as necessary (so we have to call it even if useShadowMap is false!)
		if(light_maintain_shadow_map(light) and useShadowMap) {
			// Use the light's shadow map
			shadowMap = light[| eLight.ShadowMap];
		
			// The light is always at the center of its own shadow map
			lightTexelX = 0.5;
			lightTexelY = 0.5;
			texelConvX = 1 / surface_get_width(shadowMap);
			texelConvY = 1 / surface_get_height(shadowMap);
		}
	}
	
	// Use the global shadow map for this light?
	if(shadowMap == undefined) {
		// If this is the first light using the global shadow map
		if(firstUseOfGlobalShadowMap) {
			// Ensure that we have a valid global shadow map surface
			var has_shadow_map = shadow_map_ensure_exists(eShadowMap.Light);
			if(!has_shadow_map) {
				// Failed to create a shadow map
				show_debug_message("composite_shadow_map(lights): failed to create light shadow map");
				return false;
			}
			firstUseOfGlobalShadowMap = false;
		}
		
		// Use the global shadow map
		shadowMap = global.lightShadowMap;
		
		// Set light's position in texels on the global light shadow map
		lightTexelX = (light[| eLight.X] - cameraX) / cameraW;
		lightTexelY = (light[| eLight.Y] - cameraY) / cameraH;
		texelConvX = 1 / cameraW;
		texelConvY = 1 / cameraH;
	}
	
	// Get the light's other attributes
	var lightColor = light[| eLight.Color];
	var lightIntensity = light[| eLight.Intensity];
	var lightType = light[| eLight.Type];
	var lightAngle = light[| eLight.Angle];
	var lightDirection = light[| eLight.Direction];
	var lightWidth = light[| eLight.Width];
	var lightLutIntensity = light[| eLight.LutIntensity];
	
	// Draw the light to the shadow map
	light_draw_shadow_map(light, shadowMap, true);
	
	// Convert light color to an array
	colorArray[0] = (lightColor & $FF) / $FF;			// R
	colorArray[1] = ((lightColor >> 8) & $FF) / $FF;	// G
	colorArray[2] = ((lightColor >> 16) & $FF) / $FF;	// B
	colorArray[3] = ((lightColor >> 24) & $FF) / $FF;	// A
	
	// Composite the light into the global shadow map
	surface_set_target(global.worldShadowMap);
	
	if(firstLight) {
		// Clear the shadow map
		draw_clear_alpha(c_black, 0);
		firstLight = false;
	}

	gpu_set_blendmode(bm_add);

	// Composite all shadow maps with the shader
	shader_set(__LIGHT_SHADER);
	
	// Pass the light intensity lookup texture to the shader
	if(lightLutIntensity != undefined) texture_set_stage(global.u_LutIntensity, lightLutIntensity);
	
	// Set the texel size
	shader_set_uniform_f_array(global.u_TexelSize, [1.0 / surface_get_width(shadowMap), 1.0 / surface_get_height(shadowMap)]);
	
	//
	//	Pass the light's attributes to the shader
	//
	
	// Float arrays
	shader_set_uniform_f_array(global.u_LightPosition, [lightTexelX, lightTexelY]);
	shader_set_uniform_f_array(global.u_LightColor, colorArray);
	
	// Floats
	shader_set_uniform_f(global.u_LightRange, lightRange);
	shader_set_uniform_f(global.u_LightIntensity, lightIntensity);
	shader_set_uniform_f(global.u_LightAngle, lightAngle);
	shader_set_uniform_f(global.u_LightDirection, lightDirection);
	shader_set_uniform_f(global.u_LightWidth, lightWidth);
	// Default attenuation to disabled; must have extension module to enable it
	shader_set_uniform_i(global.u_AttenuationEnabled, false);
	
	// Area or line light line emitter
	if(lightType == eLightType.Area or lightType == eLightType.Line) {
		// Area light line emitter
		var dir = lightDirection + 90;
		var w = lightWidth * 0.5; // * 0.5 because the line emitter is centered on the light
		var c = cos(dir * pi / 180) * w * texelConvX;
		var s = -sin(dir * pi / 180) * w * texelConvY;
		shader_set_uniform_f_array(global.u_LineEmitterPoint1, [lightTexelX - c, lightTexelY - s]);
		shader_set_uniform_f_array(global.u_LineEmitterPoint2, [lightTexelX + c, lightTexelY + s]);
	}
	
	// Integers
	shader_set_uniform_i(global.u_LightType, lightType);
	
	// Apply extension modules
	light_enumerate_extensions(light, eLightExtension.Apply);
	
	// If the light uses its own shadow map, convert to local space
	var offsetx = 0, offsety = 0;
	if(light[| eLight.Flags] & eLightFlags.UsesUniqueShadowMap) {
		// Light is at the center of its shadow map
		var size = surface_get_width(light[| eLight.ShadowMap]);
		offsetx = light[| eLight.X] - size * 0.5 - cameraX;
		offsety = light[| eLight.Y] - size * 0.5 - cameraY;
	}
	
	// Composite the light's shadow map into the global shadow map
	draw_surface(shadowMap, offsetx, offsety);
	
	// Reset extension modules
	light_enumerate_extensions(light, eLightExtension.Reset);
	
	// Reset
	shader_reset();
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}

// Post-composite step
lighting_post_composite();

return true;