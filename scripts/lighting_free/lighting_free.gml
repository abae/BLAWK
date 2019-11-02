/// @desc Free the lighting engine

vertex_format_delete(global.lightVertexFormat);

// Remove all lights, if any
var lights = ds_list_size(global.worldLights);
for(var i = 0; i < lights; ++i) {
	light_destroy(lights[| i]);
}
ds_list_destroy(global.worldLights);

ds_map_destroy(global.lightVertexArrayMap);

if(global.worldShadowMap != undefined and surface_exists(global.worldShadowMap))
	surface_free(global.worldShadowMap);

if(global.lightShadowMap != undefined and surface_exists(global.lightShadowMap))
	surface_free(global.lightShadowMap);
	
ds_list_destroy(global.worldDirtyShadowCasters);