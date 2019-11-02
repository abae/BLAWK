/// @description register a disconnect callback
/// @argument function function to trigger as callback
/// @argument instance* use a specific server instance, if not provided uses gmws_server

var callback = argument[0]

if (argument_count > 1 and instance_exists(argument[1])) {
	gmws_callback_register("disconnect", callback, argument[1])
}
else {
	gmws_callback_register("disconnect", callback)
}