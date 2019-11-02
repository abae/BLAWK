/// @description register a callback
/// @argument callback which callback to register
/// @argument function function to use as callback
/// @argument instance* use a specific server instance, if not provided uses gmws_server

var callback = argument[0]
var function = argument[1]

if (argument_count > 2 and instance_exists(argument[2])) {
	var inst = argument[2];
}
else {
	if (object_index == gmws_server) {
		var inst = id;	
	}
	else {
		var inst = gmws_server;	
	}
}

with (inst) {
	var targetCallbacksList = undefined
	switch(callback) {
	case "connect":
		targetCallbacksList = connectCallbacks;
		break;
	case "receive":
		targetCallbacksList = connectCallbacks;
		break;
	case "disconnect":
		targetCallbacksList = connectCallbacks;
		break;
	}
	
	if (not is_undefined(targetCallbacksList)) {
		var idx = ds_list_find_index(targetCallbacksList, function);
		if (idx > -1) {
			ds_list_delete(targetCallbacksList, idx);
		}
	}
}