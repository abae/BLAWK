/// @description send a message to websocket
/// @argument value a string to send, or a buffer ID
/// @argument socket socket to send to, use keyword `all` to broadcast to all sockets
/// @argument instance* use a specific server instance, if not provided uses gmws_server

var value = argument[0]
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
	if (is_string(value)) {
		var messageLength = string_byte_length(value);
		var valueBuff = buffer_create(messageLength, buffer_fixed, 1);
		buffer_write(valueBuff, buffer_text, value);
		var opcode = 1;
	}
	else if(is_real(value)) {
		var messageLength = buffer_get_size(value);
		var opcode = 2;
		var valueBuff = value
	}
	else {
		return false;
	}

	var buffPtr = 0;
	
	do {
		if (messageLength > 65000) { // 4MB max
			var length = 65000;	
		}
		else {
			var length = messageLength;	
		}
		
		var headerLength = 2;
		if (length > 65535) {
			headerLength += 8;
		}
		else if (length > 125) {
			headerLength += 2;
		}

		if (length == messageLength) {
			var finish = 0x80;	
		}
		else {
			var finish = 0x00;
		}

		var sendBuff = buffer_create(headerLength + length, buffer_fixed, 1);
		buffer_write(sendBuff, buffer_u8, finish + (opcode & 0xf)); // OP code with final bit
	
		if (length <= 125) {
			buffer_write(sendBuff, buffer_s8, length);
		}
		else if (length < 65536) {
			buffer_write(sendBuff, buffer_s8, 126);
			buffer_write(sendBuff, buffer_u8, (length >> 8) & 0xff);
			buffer_write(sendBuff, buffer_u8, length & 0xff);
		}
		else {
			buffer_write(sendBuff, buffer_s8, 127);
			buffer_write(sendBuff, buffer_u8, (length >> 24) & 0xff);
			buffer_write(sendBuff, buffer_u8, (length >> 16) & 0xff);
			buffer_write(sendBuff, buffer_u8, (length >> 8) & 0xff);
			buffer_write(sendBuff, buffer_u8, length & 0xff);
		}
	
		buffer_copy(valueBuff, buffPtr, length, sendBuff, buffer_tell(sendBuff));
		buffPtr += length;
		
		messageLength -= length;
		ds_queue_enqueue(sendQueue, [sendBuff, socket, finish, opcode]);
		opcode = 0;
	} until (messageLength == 0)
	
	if (is_string(value)) {
		buffer_delete(valueBuff);	
	}
	return true;
}

return false;