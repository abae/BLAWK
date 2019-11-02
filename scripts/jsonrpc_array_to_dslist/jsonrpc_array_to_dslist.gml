/// @description  Converts an array into a ds_list
/// @argument  array	The array to turn into ds_list 

var array = argument0;
var len = array_length_1d(array);

var list = ds_list_create();
for (var i=0; i<len; i++) {
	ds_list_add(list, array[i]);
}

return list;