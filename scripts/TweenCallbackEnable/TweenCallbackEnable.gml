/// @description Enables/disables specified callbacks

/// TweenCallbackEnable(callback,enable)
/// @callback		callback id
/// @enable			perform callback?

/// return: na

var _cb = argument0;

if (is_array(_cb))
{
    _cb[@ TWEEN_CALLBACK.ENABLED] = argument1;
}


