///@desc cutscene_change_variable
///@arg obj
///@arg var_name_as_string
///@arg value

with(argument0)
{
	variable_instance_set(id,argument1,argument2);
}

cutscene_end_action();