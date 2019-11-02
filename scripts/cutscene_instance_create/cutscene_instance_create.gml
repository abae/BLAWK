///@desc cutscene_instance_create
///@arg x
///@arg y
///@arg layer_id
///@arg obj

var inst = instance_create_layer(argument0,argument1,argument2,argument3);

cutscene_end_action();

return inst;