/// @description  pops an items off the call queue for a specific method
/// @argument  method		The method to pull from
/// @argument  call_map		The ds_map for calls

var method = argument0;
var call_map = argument1;

// make sure method queue is in the map
var method_queue = call_map[? method];
if (is_undefined(method_queue)) {
	return undefined;	
}

return ds_queue_dequeue(method_queue)