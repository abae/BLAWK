serverSocket = undefined;
pingRate = room_speed * 4;
clientMap = ds_map_create();
sendQueue = ds_queue_create();

connectCallbacks = ds_list_create();
receiveCallbacks = ds_list_create();
disconnectCallbacks = ds_list_create();

alarm[0] = pingRate;

enum GMWS_INTERNAL_STATE {
	handshake,
	header,
	length7,
	length16a,
	length16b,
	length32a,
	length32b,
	length32c,
	length32d,
	lengthProcess,
	mask0,
	mask1,
	mask2,
	mask3,
	payload,
	decode
}
