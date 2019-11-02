/// @description send a control ping command
/// @argument value a value to send with the ping, can be string or real
/// @argument socket socket to send to, use keyword `all` to broadcast to all sockets
/// @argument instance* use a specific server instance, if not provided uses gmws_server

var value = argument[0]
var socket = argument[1]

if (argument_count > 2) {
	return gmws_send_control(0x9, value, socket, false, argument[2]);
}
else {
	return gmws_send_control(0x9, value, socket, false);
}
