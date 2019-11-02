var clientId = argument[0]
var buffer = argument[1]
// just gonna ignore argument[2] entirely

with (gmdebug_handler) {
	var clientMap = clients[? string(clientId)]
	
	if (not is_undefined(clientMap)) {
		var str = buffer_read(buffer, buffer_text);
		jsonrpc_decode(str, clientMap[? "requestMap"], clientMap[? "resultMap"]);
	}
}