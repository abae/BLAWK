var clientId = argument0

with (gmdebug_handler) {
	var clientMap = ds_map_create()
	ds_map_add_map(clientMap, "requestMap", ds_map_create());
	ds_map_add_map(clientMap, "resultMap", ds_map_create());
	
	ds_map_add_map(clients, string(clientId), clientMap);
	show_debug_message("Client " + string(clientId) + " connected");
}