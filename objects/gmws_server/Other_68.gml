/// @description Websocket server

var type = async_load[? "type"];
var async_id = async_load[? "id"];

switch (type) {
case network_type_connect: 
case network_type_non_blocking_connect:
	if (async_id == serverSocket) {
		var socket = async_load[? "socket"]
		if (ds_map_exists(clientMap, string(socket))) {
			ds_map_destroy(clientMap[? string(socket)]);	
		}
		var client = ds_map_create();
		ds_map_add(client, "state", GMWS_INTERNAL_STATE.handshake);
		ds_map_add_map(clientMap, string(socket), client);
		
		// fire callbacks
		for (var i = ds_list_size(connectCallbacks)-1; i>=0; i--) {
			script_execute(connectCallbacks[| i], socket);
		}
	}
	break;

case network_type_disconnect:
	if (async_id == serverSocket) {
		var socket = async_load[? "socket"];
		if(ds_map_exists(clientMap, string(socket))) {
			ds_map_destroy(clientMap[? string(socket)]);
			ds_map_delete(clientMap, string(socket));
		}
		
		for (var i = ds_list_size(disconnectCallbacks)-1; i>=0; i--) {
			script_execute(disconnectCallbacks[| i], socket);
		}
	}
	break;

case network_type_data:
	if (ds_map_exists(clientMap, string(async_id))) {
		var clientSocket = async_id;
		var client = clientMap[? string(clientSocket)];
		if is_undefined(client) {
			show_debug_message("client lost");
			break;	
		}
		var state = client[? "state"]
		var buff = async_load[? "buffer"];
		var size = async_load[? "size"];
		buffer_seek(buff, buffer_seek_start, 0);
		
		while (buffer_tell(buff) < size) {
			
			switch(state) {
			case GMWS_INTERNAL_STATE.handshake: // technically we can't tolerate fragmentation of the handshake, but hopefully we don't have to
				// hack to ensure while loop exits
				size = 0;
				
				// look for first line GET, ending in HTTP1.1
				var str = buffer_read(buff, buffer_text);
			
				// get request-line
				var pos = string_pos("\r\n", str);
				var line = string_copy(str, 1, pos-1);	
				str = string_delete(str, 1, pos+1);
			
				pos = string_pos(" ", line);
				var method = string_copy(line, 1, pos-1);
				line = string_delete(line, 1, pos);
			
				pos = string_pos(" ", line);
				var request_uri = string_copy(line, 1, pos-1);
				var http_version = string_delete(line, 1, pos);
			
				if (http_version != "HTTP/1.1") {
					gmws_send_raw_string("HTTP/1.0 505 HTTP Version Not Supported\r\n", clientSocket);
					network_destroy(clientSocket);
					break;
				}
				else if(method != "GET") {
					gmws_send_raw_string("HTTP/1.1 405 Method Not Allowed\r\n", clientSocket);
					network_destroy(clientSocket);
					break;
				}
				
				client[? "endpoint"] = request_uri;
			
				// convert into key_value
				pos = string_pos("\r\n\r\n", str);
				var kvs = string_copy(str, 1, pos+1);
			
				var headers = gmws_kvs_to_map(kvs);
			
				// check or upgrade to websocket
				if (headers[? "Upgrade"] != "websocket" or headers[? "Connection"] != "Upgrade" or is_undefined(headers[? "Sec-WebSocket-Key"])) {
					gmws_send_raw_string("HTTP/1.1 400 Bad Request\r\n", clientSocket);
					network_destroy(clientSocket);
					break;
				}
				
				// check origin
				if (headers[? "Origin"] != "https://debug.gmcloud.org") {
					gmws_send_raw_string("HTTP/1.1 403 Forbidden\r\n", clientSocket);
					network_destroy(clientSocket);
					break;
				}
				
				// Calculate challenge
				var accept = gmws_websocket_accept(headers[? "Sec-WebSocket-Key"]);
			
				// ok, let's go
				gmws_send_raw_string("HTTP/1.1 101 Switching Protocols\r\n" +
							     "Upgrade: websocket\r\n" +
								 "Connection: Upgrade\r\n" +
								 "Sec-WebSocket-Accept: " + accept + "\r\n" +
								 "\r\n", clientSocket);
			
				ds_map_destroy(headers);
			
				state = GMWS_INTERNAL_STATE.header;
				break;
			
			case GMWS_INTERNAL_STATE.header:
				var read = buffer_read(buff, buffer_u8);
				client[? "final"] = (read & 0x80) >> 7;
				client[? "opcode"] = read & 0x0f;
				
				state = GMWS_INTERNAL_STATE.length7;
				break;
			
			case GMWS_INTERNAL_STATE.length7:
				var read = buffer_read(buff, buffer_u8);
				var masked = (read & 0x80) >> 7;
				
				if (masked == 0) { // oh no! drop the connection, data not masked
					network_destroy(clientSocket);
					break;
				}
				
				client[? "readLength"] = 0;
				client[? "length"] = read & 0x7f;
				if (client[? "length"] == 126) {
					state = GMWS_INTERNAL_STATE.length16a;
					break;
				}
				else if (client[? "length"] == 127) {
					state = GMWS_INTERNAL_STATE.length32a;
					break;
					client[? "length"] = buffer_read(buff, buffer_u32);
				}
				
				state = GMWS_INTERNAL_STATE.mask0;
				break;
				
			case GMWS_INTERNAL_STATE.length16a:
				client[? "length"] = buffer_read(buff, buffer_u8) << 8;
				state = GMWS_INTERNAL_STATE.length16b;
				break;
			case GMWS_INTERNAL_STATE.length16b:
				client[? "length"] |= buffer_read(buff, buffer_u8);
				state = GMWS_INTERNAL_STATE.mask0;
				break;
			
			case GMWS_INTERNAL_STATE.length32a:
				client[? "length"] = buffer_read(buff, buffer_u8) << 24;
				state = GMWS_INTERNAL_STATE.length32b;
				break;
			case GMWS_INTERNAL_STATE.length32b:
				client[? "length"] |= buffer_read(buff, buffer_u8) << 16;
				state = GMWS_INTERNAL_STATE.length32c;
				break;
			case GMWS_INTERNAL_STATE.length32c:
				client[? "length"] |= buffer_read(buff, buffer_u8) << 8;
				state = GMWS_INTERNAL_STATE.length32d;
				break;
			case GMWS_INTERNAL_STATE.length32d:
				client[? "length"] |= buffer_read(buff, buffer_u8);
				state = GMWS_INTERNAL_STATE.mask0;
				break;
				
			case GMWS_INTERNAL_STATE.mask0:
				client[? "mask"] = []
				var mask = client[? "mask"];
				mask[@ 0] = buffer_read(buff, buffer_u8) ;
				state = GMWS_INTERNAL_STATE.mask1;
				break;
			case GMWS_INTERNAL_STATE.mask1:
				var mask = client[? "mask"];
				mask[@ 1] = buffer_read(buff, buffer_u8);
				state = GMWS_INTERNAL_STATE.mask2;
				break;
			case GMWS_INTERNAL_STATE.mask2:
				var mask = client[? "mask"];
				mask[@ 2] = buffer_read(buff, buffer_u8);
				state = GMWS_INTERNAL_STATE.mask3;
				break;
			case GMWS_INTERNAL_STATE.mask3:
				var mask = client[? "mask"];
				mask[@ 3] = buffer_read(buff, buffer_u8);
				
				client[? "frameBuff"] = undefined;
				if(client[? "length"] > 0) {
					state = GMWS_INTERNAL_STATE.payload;
					client[? "frameBuff"] = buffer_create(client[? "length"], buffer_fixed, 1);
					break;
				}
				// fallthrough if not break;
			
			case GMWS_INTERNAL_STATE.payload:
				if(client[? "length"] > 0) {
					var read = buffer_read(buff, buffer_u8);
					var mask = client[? "mask"];
					buffer_write(client[? "frameBuff"], buffer_u8, read ^ mask[client[? "readLength"] % 4]);
					client[? "readLength"] ++;
				
					if(client[? "readLength"] < client[? "length"]) {
						break;
					}
				}
				// fallthrough if not break
				
			case GMWS_INTERNAL_STATE.decode:
				switch(client[? "opcode"]) {
				case 0x0: // continuation
				case 0x1: // new string
				case 0x2: // new binary	
					if (not is_undefined(client[? "frameBuff"])) {
						if (client[? "opcode"] == 0x0) {
							// continuation, copy onto messagebuff
							buffer_copy(client[? "frameBuff"], 0, client[? "length"], client[? "messageBuff"], buffer_tell(client[? "messageBuff"]));
							buffer_delete(client[? "frameBuff"]);
						}
						else {
							// new message, messagebuff IS framebuf
							client[? "messageBuff"] = client[? "frameBuff"];
							client[? "messageType"] = client[? "opcode"];
						}
				
						if (client[? "final"]) {
							buffer_seek(client[? "messageBuff"], buffer_seek_start, 0);
							for (var i = ds_list_size(receiveCallbacks)-1; i>=0; i--) {
								script_execute(receiveCallbacks[| i], clientSocket, client[? "messageBuff"], client[? "messageType"]);
							}
							buffer_delete(client[? "messageBuff"]);
						}
					}
					break;
				case 0x8: // close
					
					var closeCode = 0;
					var closeReason = "";
					if (not is_undefined(client[? "frameBuff"])) {
						if (client[? "length"] >= 2) {
							buffer_seek(client[? "frameBuff"], buffer_seek_start, 0);
							var b1 = buffer_read(client[? "frameBuff"], buffer_u8);
							var b2 = buffer_read(client[? "frameBuff"], buffer_u8);
							closeCode = b1 << 8 | b2;
						
							if (client[? "length"] > 2) {
								 closeReason = buffer_read(client[? "frameBuff"], buffer_text);
							}
						}
					}
					
					// send close message
					gmws_send_control_close(closeCode, closeReason, clientSocket);
					network_destroy(clientSocket);
					if (not is_undefined(client[? "frameBuff"]) and buffer_exists(client[? "frameBuff"])) {
						buffer_delete(client[? "frameBuff"]);
					}
					if (not is_undefined(client[? "messageBuff"]) and buffer_exists(client[? "messageBuff"])) {
						buffer_delete(client[? "messageBuff"]);
					}
					ds_map_destroy(client);
					ds_map_delete(clientMap, string(clientSocket));
					
					for (var i = ds_list_size(disconnectCallbacks)-1; i>=0; i--) {
						script_execute(disconnectCallbacks[| i], clientSocket);
					}
					
					client = undefined;
					break;
				case 0x9: // ping
					if (not is_undefined(client[? "frameBuff"])) {
						gmws_send_control_pong(client[? "frameBuff"], clientSocket);
						buffer_delete(client[? "frameBuff"]);
					}
					else {
						gmws_send_control_pong(clientSocket);
					}
					break;
				case 0xA: // pong
					if (not is_undefined(client[? "frameBuff"])) {
						buffer_delete(client[? "frameBuff"]);
					}
					break;
				}
				
				state = GMWS_INTERNAL_STATE.header;
				break;
			}
			if (not is_undefined(client)) {
				client[? "state"] = state;
			}
		}
	}	
	break;
}