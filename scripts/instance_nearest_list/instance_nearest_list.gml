/// @description instance_nearest_list(x, y, obj)
/// @param x
/// @param  y
/// @param  obj
/*
 * Returns a list of instances in nearest order
 */
var xx = argument0;
var yy = argument1;
var obj = argument2;
var list = ds_list_create(); //initialise the list of objects
var inst;
do
{
    //Find the instance nearest to the x & y position
    inst = instance_nearest(xx, yy, obj);
    //If an instance is found, add it to the list
    //and deactivate the instance. It'll be
    //reactivated later.
    if (inst != noone)
    {
        ds_list_add(list, inst);
        instance_deactivate_object(inst);
    }
}
until (inst == noone); //break the loop when there's no more instances

//Reactivate the deactivated objects
for (var i = 0; i < ds_list_size(list); i++)
{
    instance_activate_object(list[|i]);
}

//Return the list of instances
return list;
