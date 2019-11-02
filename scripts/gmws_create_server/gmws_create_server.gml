/// @description spawns a gmws_server
/// @argument port port number to listen to
/// @argument clients* number of clients that can connect

var port = argument[0]

if (argument_count > 1 and instance_exists(argument[1])) {
	var maxClients = argument[1];
}
else {
	var maxClients = 32;
}

var instance = instance_create_depth(0, 0, 0, gmws_server);
with (instance) {
	persistent = true;
	serverSocket = network_create_server_raw(network_socket_tcp, port, maxClients);
	if (serverSocket < 0) {
		return -1;	
	}
	show_debug_message("websocket server created at port " + string(serverSocket));
}

return instance