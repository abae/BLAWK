/// @description Removes callback from its associated tween event

/// TweenCallbackInvalidate(callback)
/// @param callback		callback id

/// return: na

/*      
    Example:
        // Create tween and add callback to finish event
        tween = TweenCreate(id);
        cb = TweenEventAddCallback(tween, TWEEN_EV_FINISH, id, ShowMessage, "Finished!");
        
        // Invalidate callback -- effectively removes it from tween event
        TweenInvalidate(cb);
*/

var _cb = argument0;

if (is_array(_cb))
{
    // Set target as noone -- used for system cleaning
    _cb[@ TWEEN_CALLBACK.TARGET] = noone;
    _cb[@ TWEEN_CALLBACK.TWEEN] = TweenNull();
}

