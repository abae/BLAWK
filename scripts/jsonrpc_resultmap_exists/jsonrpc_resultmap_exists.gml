/// @description  check if result is available
/// @argument  rpcid		The rpc id to find from the results
/// @argument  result_map	The ds_map for results

var rpcid = string(argument0);
var result_map = argument1;

// make sure method queue is in the map
return ds_map_exists(result_map, rpcid);