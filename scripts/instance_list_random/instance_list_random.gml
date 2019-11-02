/// @description instance_list_random(object)
/// @param object
/*
 * Returns a list containing all the instances of an object, in a random order.
 *
 * Example use:
 *
   var list = instance_list_random(objPlayer);
   for (var i = 0; i < ds_list_size(list); i++)
   {
      with (list[|i]) //destroy all players, in a random order
      {
          instance_destroy();
      }
   }
 *
 */
var list = ds_list_create();
var obj = argument0;
with (obj)
{
    ds_list_add(list, id);
}
ds_list_shuffle(list);
return list;

