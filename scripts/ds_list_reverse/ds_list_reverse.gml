/// @description ds_list_reverse(list)
/// @param list
/*
 * Returns the list given in the argument, but in reverse order
 */
var list = argument0;
var result = ds_list_create();
//Loop through the list in reverse order, adding each value to our resulting list
for (var i = ds_list_size(list)-1; i >= 0; i--)
{
    ds_list_add(result, list[|i]);
}
//Return the newly populated list
return result;

