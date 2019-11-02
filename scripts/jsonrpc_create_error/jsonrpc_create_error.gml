/// @description  Creates an rpc error
/// @argument  code	The RPC error code
/// @argument  message	The error message

var jsonrpc = ds_map_create();
ds_map_add(jsonrpc, "jsonrpc", "2.0");
ds_map_add(jsonrpc, "id", string(argument2));

var error = ds_map_create();
ds_map_add(error, "code", argument0);
ds_map_add(error, "message", argument1);

ds_map_add_map(jsonrpc, "error", error);

var jsonstr = json_encode(jsonrpc);
ds_map_destroy(jsonrpc);

return jsonstr;