/// @desc Destroy the light
/// @arg light The light to destroy

var light = argument0;

// Destroy the vertex buffer
var buffer = light[| eLight.VertexBuffer];
if(buffer != undefined) vertex_delete_buffer(buffer);

// Destroy the shadow map
var shadowMap = light[| eLight.ShadowMap];
if(shadowMap != undefined and surface_exists(shadowMap)) surface_free(shadowMap);

// Destroy static storage
var static_storage = light[| eLight.StaticStorage];
if(static_storage != undefined) ds_map_destroy(static_storage);

// Destroy out of range shadow casters map
var out_of_range_list = light[| eLight.ShadowCastersOutOfRange];
if(out_of_range_list != undefined) ds_map_destroy(out_of_range_list);
if(static_storage != undefined) ds_map_destroy(static_storage);

// Destroy culled shadow casters map
var culled_shadow_casters = light[| eLight.CulledShadowCasters];
if(culled_shadow_casters != undefined) ds_map_destroy(culled_shadow_casters);

// Destroy extension modules list
var ext_modules = light[| eLight.ExtensionModules];
if(ext_modules != undefined) ds_list_destroy(ext_modules);

// Destroy ignore set
var map = light[| eLight.IgnoreSet];
if(map != undefined) ds_map_destroy(map);

// Destroy the light
ds_list_destroy(light);