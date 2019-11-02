/// @description Checks if callback id is valid

/// TweenCallbackIsValid(callback)
/// @param callback		callback id

/// return: bool

/*      
    Example:
        if (TweenCallbackValid(callback))
        {
            TweenCallbackInvalidate(callback);
        }
*/

var _cb = argument0;

if (is_array(_cb))
{
    return TweenExists(_cb[TWEEN_CALLBACK.TWEEN]);
}

return false;


