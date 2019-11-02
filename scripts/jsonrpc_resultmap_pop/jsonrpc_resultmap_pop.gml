/// @description  pops a result off the resultmap
/// @argument  rpcid		The rpc id to find from the results
/// @argument  result_map	The ds_map for results

var rpcid = string(argument0);
var result_map = argument1;

// make sure method queue is in the map
var retval = result_map[? rpcid];
ds_map_delete(result_map, rpcid);
return retval;