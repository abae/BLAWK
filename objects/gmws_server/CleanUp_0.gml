// clean up buffers
for(var key=ds_map_find_first(clientMap); not is_undefined(key); key=ds_map_find_next(clientMap, key)) { 
    var client = ds_map_find_value(clientMap, key);
	if (not is_undefined(client) and ds_exists(client, ds_type_map)) {
		if (not is_undefined(client[? "frameBuff"]) and buffer_exists(client[? "frameBuff"])) {
			buffer_delete(client[? "frameBuff"]);	
		}
		if (not is_undefined(client[? "messageBuff"]) and buffer_exists(client[? "frameBuff"])) {
			buffer_delete(client[? "messageBuff"]);	
		}
	}
}
ds_map_destroy(clientMap);


while(not ds_queue_empty(sendQueue)) {
	var buff = ds_queue_dequeue(sendQueue);
	if (buffer_exists(buff)) {
		buffer_delete(buff);	
	}
}
ds_queue_destroy(sendQueue);

ds_list_destroy(connectCallbacks);
ds_list_destroy(receiveCallbacks);
ds_list_destroy(disconnectCallbacks);

if (not is_undefined(serverSocket)) {
	network_destroy(serverSocket);
}