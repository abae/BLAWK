/// @description  pushes result onto the result map
/// @argument  rpcid		The id of the response
/// @argument  result		The result of the rpc
/// @argument  result_map	The ds_map for results

var rpcid = string(argument0);
var results = argument1;
var result_map = argument2;

if (is_undefined(rpcid)) {
	return;	
}

// add result
ds_map_replace(result_map, rpcid, results);