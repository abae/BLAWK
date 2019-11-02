/// __ext_PropUser(event,target)

TWEEN_USER_TARGET = argument1;
TWEEN_USER_GET = 1;

if (is_real(argument0))
{
    event_perform_object(argument1.object_index, ev_other, argument0);
}
else
{
    TWEEN_USER_DATA = argument0[1];
    event_perform_object(argument1.object_index, ev_other, argument0[0]);
}

var _return = TWEEN_USER_GET;
TWEEN_USER_GET = 0;
return _return;
