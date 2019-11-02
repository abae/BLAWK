/// @description ds_list_random(list)
/// @param list
///Return a random value from a list
var list = argument0;
var size = ds_list_size(list)-1;
var i = irandom(size);
return list[|i];
