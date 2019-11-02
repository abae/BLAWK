var clientId = argument0

with (gmdebug_handler) {
	ds_map_destroy(clients[? string(clientId)]);
	ds_map_delete(clients, string(clientId))
	
	show_debug_message("Client " + string(clientId) + " disconnected");
}