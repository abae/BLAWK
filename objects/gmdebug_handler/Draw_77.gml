/// @description process requests

for(var clientId=ds_map_find_first(clients); not is_undefined(clientId);  clientId=ds_map_find_next(clients, clientId)) { 
    var clientMap = ds_map_find_value(clients, clientId);
    var requestMap = clientMap[? "requestMap"]
    var resultMap = clientMap[? "resultMap"]
	

	if (jsonrpc_requestmap_exists("getInstanceList", requestMap)) {
		var req = jsonrpc_requestmap_pop("getInstanceList", requestMap);
		var reqId = req[? "id"];
		ds_map_destroy(req);
	
		var response = ds_map_create()
		for (var i=0; i< instance_count; i++) {
		
			var instance = ds_map_create();
			var instanceId = instance_id[i];
			with (instanceId) {
				// get ancestry
				var objectList = ds_list_create();
				ds_list_add(objectList, object_get_name(object_index));
			
				for (var parent = object_get_parent(object_index); parent >= 0; parent = object_get_parent(parent)) {
					ds_list_add(objectList, object_get_name(parent));	
				}
			
				ds_map_add_list(instance, "object", objectList);
			
				if (layer != -1) {
					var layer_name = layer_get_name(layer);
					if (layer_name != "") {
						ds_map_add(instance, "layer", layer_name);
					}
					else {
						ds_map_add(instance, "layer", layer);
					}
				}
				ds_map_add(instance, "depth", depth);
			}
			ds_map_add_map(response, string(instanceId), instance);
		}
	
		var jsonrpc = jsonrpc_create_result_map(response, reqId);
		ds_map_destroy(response);
		gmdebug_send(clientId, jsonrpc);
	}


	if (jsonrpc_requestmap_exists("getVariables", requestMap)) {
		var req = jsonrpc_requestmap_pop("getVariables", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		var builtins = params[| 1];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (instance_exists(target) || target == global) {
			var varNames = variable_instance_get_names(target)
		
			var response = ds_map_create()
			// metadata
			if (target == global) {
				ds_map_add(response, "objectName", "");
			}
			else {
				ds_map_add(response, "objectName", object_get_name(target.object_index));
			}
		
			// variables
			var variablesList = ds_map_create()
			if (target == global) {
				for (var i=array_length_1d(varNames)-1; i>=0; i--) {
					var varName = varNames[i];
					var value = variable_global_get(varName);
					var type = typeof(value);
			
					var variable = ds_map_create();
					ds_map_add(variable, "value", value);
					ds_map_add(variable, "type", type);
					ds_map_add(variable, "builtin", false);
			
					ds_map_add_map(variablesList, varName, variable);
				}
				if (builtins) {
					// add builtins
					for (var i=array_length_1d(globalBuiltinsArray)-1; i>=0; i--) {
						var varName = globalBuiltinsArray[i];
						var value = variable_global_get(varName);
						var type = typeof(value);
			
						var variable = ds_map_create();
						ds_map_add(variable, "value", value);
						ds_map_add(variable, "type", type);
						ds_map_add(variable, "builtin", true);
			
						ds_map_add_map(variablesList, varName, variable);
					}
				}
			}
			else {
				for (var i=array_length_1d(varNames)-1; i>=0; i--) {
					var varName = varNames[i];
					var value = variable_instance_get(target, varName);
					var type = typeof(value);
			
					var variable = ds_map_create();
					ds_map_add(variable, "value", value);
					ds_map_add(variable, "type", type);
					ds_map_add(variable, "builtin", false);
			
					ds_map_add_map(variablesList, varName, variable);
				}
				if (builtins) {
					// add builtins
					for (var i=array_length_1d(builtinsArray)-1; i>=0; i--) {
						var varName = builtinsArray[i];
						var value = variable_instance_get(target, varName);
						var type = typeof(value);
			
						var variable = ds_map_create();
						ds_map_add(variable, "value", value);
						ds_map_add(variable, "type", type);
						ds_map_add(variable, "builtin", true);
			
						ds_map_add_map(variablesList, varName, variable);
					}
				}
			}
			ds_map_add_map(response, "variablesList", variablesList);
		
			var jsonrpc = jsonrpc_create_result_map(response, reqId);
			ds_map_destroy(response);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(1, "Instance not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	
	}

	if (jsonrpc_requestmap_exists("getVariableMeta", requestMap)) {
		var req = jsonrpc_requestmap_pop("getVariableMeta", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		var varName = params[| 1];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (instance_exists(target) || target == global || target == noone) {
			var response = ds_list_create()
		
			if (target == global) {
				var value = variable_global_get(varName);
			}
			else if (target == noone) {
				var value = varName;	
			}
			else {
				var value = variable_instance_get(target, varName);
			}
		
			if (typeof(value) == "number" or typeof(value) == "int32" or typeof(value) == "int64") {
				if (ds_exists(value, ds_type_map)) ds_list_add(response, "Map");
				if (ds_exists(value, ds_type_list)) ds_list_add(response, "List");
				if (ds_exists(value, ds_type_stack)) ds_list_add(response, "Stack");
				if (ds_exists(value, ds_type_grid)) ds_list_add(response, "Grid");
				if (ds_exists(value, ds_type_queue)) ds_list_add(response, "Queue");
				if (ds_exists(value, ds_type_priority)) ds_list_add(response, "Priority");
				if (buffer_exists(value)) ds_list_add(response, "Buffer");
				if (surface_exists(value)) ds_list_add(response, "Surface");
			}
		
			var jsonrpc = jsonrpc_create_result_list(response, reqId);
			ds_list_destroy(response);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(1, "Instance not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	}

	if (jsonrpc_requestmap_exists("getSurface", requestMap)) {
		var req = jsonrpc_requestmap_pop("getSurface", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (target == -1) {
			target = application_surface;
		}
		
		if (surface_exists(target)) {
			var response = ds_map_create()
		
			var width = surface_get_width(target);
			var height = surface_get_height(target);
			ds_map_add(response, "width", width);
			ds_map_add(response, "height", height);
		
			surface_save(target, "tmp_surface.png");
			var buff = buffer_load("tmp_surface.png");

			ds_map_add(response, "data", buffer_base64_encode(buff, 0, buffer_get_size(buff)))
			buffer_delete(buff);
			file_delete("tmp_surface.png");
		
			var jsonrpc = jsonrpc_create_result_map(response, reqId);
			ds_map_destroy(response);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(2, "Surface not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	}

	if (jsonrpc_requestmap_exists("getBuffer", requestMap)) {
		var req = jsonrpc_requestmap_pop("getBuffer", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (buffer_exists(target)) {
			var response = buffer_base64_encode(target, 0, buffer_get_size(target))
			
			var jsonrpc = jsonrpc_create_result(response, reqId);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(3, "Buffer not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	}

	if (jsonrpc_requestmap_exists("getMap", requestMap)) {
		var req = jsonrpc_requestmap_pop("getMap", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		var useJson = params[| 1];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (ds_exists(target, ds_type_map)) {
			if (useJson == true) {
				var response = json_encode(target);
			}
			else {
				var response = ds_map_write(target);	
			}
			var jsonrpc = jsonrpc_create_result(response, reqId);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(4, "ds_map not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	}

	if (jsonrpc_requestmap_exists("getDynamics", requestMap)) {
		var req = jsonrpc_requestmap_pop("getDynamics", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		// we have to use an array here to avoid generating more datastructures while scanning for datastructurse
		var indices = [];
		var scan_max = 100;
		for (var i=0; i<scan_max; i++) {
			var exists = false
			switch (target) {
			default:
			case "Map": exists = ds_exists(i, ds_type_map) break;
			case "List": exists = ds_exists(i, ds_type_list) break;
			case "Stack": exists = ds_exists(i, ds_type_stack) break;
			case "Grid": exists = ds_exists(i, ds_type_grid) break;
			case "Queue": exists = ds_exists(i, ds_type_queue) break;
			case "Priority": exists = ds_exists(i, ds_type_priority) break;
			case "Buffer": exists = buffer_exists(i) break;
			case "Surface": exists = surface_exists(i) break;
			}
		
			if (exists) {
				indices[array_length_1d(indices)] = i
				scan_max += 1;
			}
		}
	
		var response = ds_list_create();
		var len = array_length_1d(indices)
		for (var i=0; i<len; i++) {
			var entry = ds_map_create();
			var index = indices[i];
			ds_map_add(entry, "id", index);
			
			switch (target) {
			default:
			case "Map":
				var keys = ds_list_create();
				for(var key=ds_map_find_first(i); not is_undefined(key); key=ds_map_find_next(i, key)) { 
					ds_list_add(keys, key);
				}
				ds_map_add_list(entry, "keys", keys);
				ds_map_add(entry, "size", ds_map_size(i));
				break;
			case "List":
				ds_map_add(entry, "size", ds_list_size(i));
				break;
			case "Stack":
				ds_map_add(entry, "size", ds_stack_size(i));
				break;
			case "Grid":
				ds_map_add(entry, "width", ds_grid_width(i));
				ds_map_add(entry, "height", ds_grid_height(i));
				break;
			case "Queue":
				ds_map_add(entry, "size", ds_queue_size(i));
				break;
			case "Priority":
				ds_map_add(entry, "size", ds_priority_size(i));
				break;
			case "Buffer":
				ds_map_add(entry, "size", buffer_get_size(i));
				ds_map_add(entry, "tell", buffer_tell(i));
				break;
			case "Surface":
				ds_map_add(entry, "width", surface_get_width(i));
				ds_map_add(entry, "height", surface_get_height(i));
				break;
			}
		
			ds_list_add(response, entry);
			ds_list_mark_as_map(response, ds_list_size(response)-1);
		}
	
		var jsonrpc = jsonrpc_create_result_list(response, reqId);
		ds_list_destroy(response);
		gmdebug_send(clientId, jsonrpc);
	}

	if (jsonrpc_requestmap_exists("getList", requestMap)) {
		var req = jsonrpc_requestmap_pop("getList", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		var useJson = params[| 1];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (ds_exists(target, ds_type_list)) {
			if (useJson == true) {
				var tempParent = ds_map_create()
				ds_map_add_list(tempParent, "default", target);
		
				var response = json_encode(tempParent);
				ds_map_replace(tempParent, "default", undefined);
				ds_map_destroy(tempParent)
			}
			else {
				var response = 	ds_list_write(target);
			}
		
			var jsonrpc = jsonrpc_create_result(response, reqId);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(5, "ds_list not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	}

	if (jsonrpc_requestmap_exists("getGrid", requestMap)) {
		var req = jsonrpc_requestmap_pop("getGrid", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (ds_exists(target, ds_type_grid)) {
			var response = ds_grid_write(target);
			var jsonrpc = jsonrpc_create_result(response, reqId);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(6, "ds_grid not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	}

	if (jsonrpc_requestmap_exists("getStack", requestMap)) {
		var req = jsonrpc_requestmap_pop("getStack", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (ds_exists(target, ds_type_stack)) {
			var response = ds_stack_write(target);
			var jsonrpc = jsonrpc_create_result(response, reqId);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(7, "ds_stack not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	}

	if (jsonrpc_requestmap_exists("getPriority", requestMap)) {
		var req = jsonrpc_requestmap_pop("getPriority", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (ds_exists(target, ds_type_priority)) {
			var response = ds_priority_write(target);
			var jsonrpc = jsonrpc_create_result(response, reqId);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(8, "ds_priority not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	}

	if (jsonrpc_requestmap_exists("getQueue", requestMap)) {
		var req = jsonrpc_requestmap_pop("getQueue", requestMap);
		var reqId = req[? "id"];
		var params = req[? "params"];
		var target = params[| 0];
		ds_list_destroy(params);
		ds_map_destroy(req);
	
		if (ds_exists(target, ds_type_queue)) {
			var response = ds_queue_write(target);
			var jsonrpc = jsonrpc_create_result(response, reqId);
			gmdebug_send(clientId, jsonrpc);
		}
		else {
			var jsonrpcError = jsonrpc_create_error(9, "ds_queue not found", reqId)
			gmdebug_send(clientId, jsonrpcError)
		}
	}
}