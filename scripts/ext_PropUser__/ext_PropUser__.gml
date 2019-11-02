/// ext_PropUserAdvanced__(value,ev_user,target)

TWEEN_USER_VALUE = argument0;
TWEEN_USER_TARGET = argument2;

if (is_real(argument1))
{
    event_perform_object(argument2.object_index, ev_other, argument1);
}
else
{
    TWEEN_USER_DATA = argument1[1];
    event_perform_object(argument2.object_index, ev_other, argument1[0]);
}

