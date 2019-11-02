/// @description Invalidates all callbacks associated with tween event

/// TweenEventClear(tween[s],event)
/// @param tween[s]		tween id[s]
/// @param event		tween event macro (TWEEN_EV_*)

/// return: na

var _t = argument0;

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t))
{
    var _events = _t[TWEEN.EVENTS];
    
    if (_events != -1)
    {    
        if (ds_map_exists(_events, argument1))
        {
            var _event = _events[? argument1]; 
            var _index = 0;
            
            repeat(ds_list_size(_event)-1)
            {
                // Get callback
                var _cb = _event[| ++_index];
                // Invalidate target
                _cb[@ TWEEN_CALLBACK.TARGET] = noone;
            }
        }
    }
}
else if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenEventClear, argument1);
}

