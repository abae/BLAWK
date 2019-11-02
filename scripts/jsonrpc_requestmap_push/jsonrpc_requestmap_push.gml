/// @description adds call to call map, which is a map of queues
/// @argument  method		The method to push onto
/// @argument  params		The ds_list of parameters
/// @argument  rpcid		The rpc id
/// @argument  call_map		The call map

var method = argument0;
var params = argument1;
var rpcid = string(argument2);
var call_map = argument3;

if (is_undefined(method)) {
	return;	
}

// make sure method queue is in the map
var method_queue = call_map[? method];
if (is_undefined(method_queue)) {
	method_queue = ds_queue_create();
	ds_map_add(call_map, method, method_queue);
}

// create the entry
var method_entry = ds_map_create();
ds_map_add(method_entry, "params", params);
ds_map_add(method_entry, "id", rpcid);
ds_queue_enqueue(method_queue, method_entry);