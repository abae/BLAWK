/// @description  Creates an rpc request
/// @argument  method	The RPC method to call   
/// @argument  params	The parameters; can be an array, a json string, or a ds_map
/// @argument  id		The ID to be called

var jsonrpc = ds_map_create();
ds_map_add(jsonrpc, "jsonrpc", "2.0");
ds_map_add(jsonrpc, "method", argument[0]);

if (argument_count > 1) {
	if (is_array(argument[1])) {
		ds_map_add_list(jsonrpc, "params", jsonrpc_array_to_dslist(argument[1])); // strictly speaking, this should be handled automatically by json_encode, can probably drop this
	}
	else if (is_string(argument[1])) {
		ds_map_add_map(jsonrpc, "params", json_decode(argument[1]));
	}
	else if (ds_exists(argument[1], ds_type_map)) {
		ds_map_add_map(jsonrpc, "params", argument[1]);
	}
}

if (argument_count > 2) {
	ds_map_add(jsonrpc, "id", string(argument[2]));
}

var jsonstr = json_encode(jsonrpc);
ds_map_destroy(jsonrpc);

return jsonstr;