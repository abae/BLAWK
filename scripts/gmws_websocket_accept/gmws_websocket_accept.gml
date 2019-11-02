
var websocket_key = argument0

var hash = sha1_string_utf8(websocket_key + "258EAFA5-E914-47DA-95CA-C5AB0DC85B11");	

var buff = buffer_create(20, buffer_fixed, 1);
for(var i=0; i<40; i+=2) {
	var nibble_low = string_byte_at(hash, i+2) - 0x30;
	if(nibble_low > 16) { // it's in the alpha range
		nibble_low -= 39 // bring it back down
	}
	var nibble_high = string_byte_at(hash, i+1) - 0x30;
	if(nibble_high > 16) { // it's in the alpha range
		nibble_high -= 39 // bring it back down
	}
	buffer_write(buff, buffer_u8, nibble_low | nibble_high << 4);
}
var accept = buffer_base64_encode(buff, 0, 20);
buffer_delete(buff);

return accept;