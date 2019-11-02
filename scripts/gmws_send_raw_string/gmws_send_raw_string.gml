/// @description send a raw string
/// @argument string string to send
/// @argument socket socket to send to, use keyword `all` to broadcast to all sockets
/// @argument instance* use a specific server instance, if not provided uses gmws_server

var send = argument[0]
var socket = argument[1]

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
	var buff = buffer_create(string_byte_length(send), buffer_fixed, 1);
	buffer_write(buff, buffer_text, send);
	ds_queue_enqueue(sendQueue, [buff, socket, undefined, undefined]);
	return true;
}

return false;