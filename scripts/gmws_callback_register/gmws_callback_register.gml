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
	switch(callback) {
	case "connect":
		ds_list_add(connectCallbacks, function);
		break;
	case "receive":
		ds_list_add(receiveCallbacks, function);
		break;
	case "disconnect":
		ds_list_add(disconnectCallbacks, function);
		break;
	}
}