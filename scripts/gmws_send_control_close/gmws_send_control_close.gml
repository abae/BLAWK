/// @description send a close command
/// @argument code the numerical close code
/// @argument reason text reason for close
/// @argument socket socket to send to, use keyword `all` to broadcast to all sockets
/// @argument instance* use a specific server instance, if not provided uses gmws_server

var code = argument[0]
var reason = argument[1];
var socket = argument[2];

var length = 2 + string_byte_length(reason);

var buff = buffer_create(length, buffer_fixed, 1);
buffer_write(buff, buffer_u8, (code >> 8) & 0xff);
buffer_write(buff, buffer_u8, code & 0xff);

if (string_length(reason) > 0) {
	buffer_write(buff, buffer_text, reason);
}

if (argument_count > 3) {
	var retval = gmws_send_control(0x8, buff, socket, false, argument[3]);
}
else {
	var retval =  gmws_send_control(0x8, buff, socket, false);
}

buffer_delete(buff);
return retval;