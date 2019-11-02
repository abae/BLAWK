///@description Transmit queue
while (not ds_queue_empty(sendQueue)) {
	var tx = ds_queue_dequeue(sendQueue);
	var buff = tx[0];
	var socket = tx[1]
	var finish = tx[2]
	
	if (not buffer_exists(buff)) {
		show_debug_message("buffer lost");
		continue	
	}
	
	if (socket == all) {
		for(var key=ds_map_find_first(clientMap); not is_undefined(key); key=ds_map_find_next(clientMap, key)) {
			network_send_raw(real(key), buff, buffer_get_size(buff));
		}
	}
	else {
		network_send_raw(socket, buff, buffer_get_size(buff));
	}
	buffer_delete(buff);
	
	if (finish == 0x80) break; // workaround for some websocket issues
}