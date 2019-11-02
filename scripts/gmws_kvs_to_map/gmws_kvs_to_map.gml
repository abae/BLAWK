var kvs = argument0;

var headers = ds_map_create();
var last_key = ""
while (true) {
	var pos = string_pos("\r\n", kvs);
	if (pos == 0) {
		break;	
	}
	var line = string_copy(kvs, 1, pos-1);
	if (string_length(line) == 0) {
		break;	
	}
	kvs = string_delete(kvs, 1, pos+1);
				
	if (string_char_at(line, 1) == " " or string_char_at(line, 1) == "\t") { // continuation
		headers[? last_key] += line + "\r\n";
	}
	else {
		pos = string_pos(": ", line);
		var key = string_copy(line, 1, pos-1);	
		var value = string_delete(line, 1, pos+1);
		last_key = key;
		ds_map_replace(headers, key, value);
	}
}

return headers