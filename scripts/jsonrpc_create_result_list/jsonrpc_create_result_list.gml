/// @description  Creates an rpc result
/// @argument  result	The RPC result as a list  
/// @argument  id		The ID to be called

var jsonrpc = ds_map_create();
ds_map_add(jsonrpc, "jsonrpc", "2.0");
ds_map_add_list(jsonrpc, "result", argument0);
ds_map_add(jsonrpc, "id", string(argument1));

var jsonstr = json_encode(jsonrpc);

ds_map_replace(jsonrpc, "result", undefined); // unset list for destruction
ds_map_destroy(jsonrpc);

return jsonstr;