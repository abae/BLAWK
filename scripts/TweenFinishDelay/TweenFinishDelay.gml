/// @description Finishes delay for the selected tween[s]

/// TweenFinishDelay(tween[s],callevent)
/// @param tween[s]		tween id
/// @param call_event	execute FINISH EVENT callbacks?

// RETURNS: null tween id

var _t = argument0;

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t))
{
    if (_t[TWEEN.DELAY] > 0)
    {
        _t[@ TWEEN.DELAY] = -1; // Mark delay for removal from delay list
        
        // Execute FINISH DELAY event
        if (argument1)
        {
            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH_DELAY);
        }
        
        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET]; // Set tween as active                
        
        // Update property with start value
        if (argument1)
        {
            script_execute(_t[TWEEN.PROPERTY], _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
        }
        
        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PLAY); // Execute PLAY event
    }
}

if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenFinishDelay, argument1);
}
