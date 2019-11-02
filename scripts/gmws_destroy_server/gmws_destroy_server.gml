/// @description destroy a gmws_server
/// @argument instance instance number for server

var instance = argument0;

if (instance_exists(instance) and instance.object_index == gmws_server) {
	instance_destroy(instance)
}
