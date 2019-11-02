/// @description send a control ping command
/// @argument opcode the opcode
/// @argument value a value to send with the ping, can be string or real, or buffer
/// @argument socket socket to send to, use keyword `all` to broadcast to all sockets
/// @argument is_buffer set to True if value is a buffer
/// @argument instance* use a specific server instance, if not provided uses gmws_server

var opcode = argument[0]
var value = argument[1]
var socket = argument[2]

var is_buffer = bool(argument[3])

if (argument_count > 4 and instance_exists(argument[4])) {
	var inst = argument[4];
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
	if (is_buffer) {
		var length = buffer_get_size(value);
	}
	else if (is_string(value)) {
		var length = string_byte_length(value);
	}
	else if(is_real(value)) {
		var length = 8;
	}
	else {
		var length = 0;
	}
	
	var headerLength = 2;
	if (length > 65535) {
		headerLength += 8;
	}
	else if (length > 125) {
		headerLength += 2;
	}
	
	var buff = buffer_create(headerLength + length, buffer_fixed, 1);
	buffer_write(buff, buffer_u8, 0x80 + (opcode & 0xf)); // OP code with final bit
	
	if (length <= 125) {
		buffer_write(buff, buffer_s8, length);
	}
	else if (length < 65536) {
		buffer_write(buff, buffer_s8, 126);
		buffer_write(buff, buffer_u16, length);
	}
	else {
		buffer_write(buff, buffer_s8, 127);
		buffer_write(buff, buffer_u64, length);
	}
	
	if (is_buffer) {
		buffer_copy(value, 0, buffer_get_size(value), buff, buffer_tell(buff));
	}
	else if (is_string(value)) {
		buffer_write(buff, buffer_text, string(value));
	}
	else if(is_real(value)) {
		buffer_write(buff, buffer_f64, real(value));
	}
	
	ds_queue_enqueue(sendQueue, [buff, socket, undefined, opcode]);
	return true;
}

return false;