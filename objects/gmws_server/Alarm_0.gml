/// @description Ping handler

for(var key=ds_map_find_first(clientMap); not is_undefined(key); key=ds_map_find_next(clientMap, key)) {
	gmws_send_control_ping("", real(key));
}

alarm[0] = pingRate;