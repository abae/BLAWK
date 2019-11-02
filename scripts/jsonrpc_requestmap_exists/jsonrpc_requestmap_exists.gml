/// @description  Check if item exists in the requestmap for that method
/// @argument  method		The method to pull from
/// @argument  call_map		The ds_map for calls

var method = argument0;
var call_map = argument1;

// make sure method queue is in the map
var method_queue = call_map[? method];
if (is_undefined(method_queue)) {
	return false;	
}

return not ds_queue_empty(method_queue);