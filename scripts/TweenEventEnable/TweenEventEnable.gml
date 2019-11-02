/// @description Enables/disables specified tween event

/// TweenEventEnable(tween[s],event,enable)
/// @param tween[s]		tween id[s]
/// @param event		tween event macro (TWEEN_EV_*)
/// @param enable		enable event?

/// return: na

var _t = argument0;

if (is_real(_t)){
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t)){
    var _EVENT_TYPE = argument1;
    var _enable = argument2;
    var _events = _t[TWEEN.EVENTS];
    
    // Create and assign events map if it doesn't exist
    if (_events == -1)
    {
        _events = ds_map_create();
        _t[@ TWEEN.EVENTS] = _events;
    }
    
    if (ds_map_exists(_events, _EVENT_TYPE) == false)
    {
        // Create event list
        var _event = ds_list_create();
        // Add event to events map
        _events[? _EVENT_TYPE] = _event;
    }
    
    // Set tween event state
    var _event = _events[? _EVENT_TYPE];
    _event[| 0] = _enable;
}
else
if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenEventEnable, argument1, argument2);
}

