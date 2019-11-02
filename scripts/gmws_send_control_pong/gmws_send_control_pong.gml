/// @description send a control pong command
/// @argument buff a buffer containing the previously received ping value
/// @argument socket socket to send to, use keyword `all` to broadcast to all sockets
/// @argument instance* use a specific server instance, if not provided uses gmws_server

if (argument_count == 1) {
	var socket = argument[0]
	return gmws_send_control(0xa, "", socket, false);
}
else {	
	var buff = argument[0]
	var socket = argument[1]

	if (argument_count > 2) {
		return gmws_send_control(0xa, buff, socket, true, argument[2]);
	}
	else {
		return gmws_send_control(0xa, buff, socket, true);
	}
}