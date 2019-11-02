var clientId = argument0
var message = argument1

with (gmdebug_handler) {
	gmws_send_message(message, real(clientId), server)
}