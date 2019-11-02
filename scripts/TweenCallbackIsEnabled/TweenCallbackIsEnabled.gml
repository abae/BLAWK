/// @description Checks if callback is enabled

/// TweenCallbackIsEnabled(callback)
/// @param callback		callback id

/// return: bool

var _cb = argument0;

if (is_array(_cb))
{
    return _cb[TWEEN_CALLBACK.ENABLED] and _cb[@ TWEEN_CALLBACK.TARGET] != noone;;
}
