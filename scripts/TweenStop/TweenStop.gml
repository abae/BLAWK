/// @description Stops the selected tween[s]

/// TweenStop(tween[s])
/// @param tween[s] tween id

// RETURNS: na

var _t = argument0;

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t))
{
    if (_t[TWEEN.STATE] >= 0 or _t[TWEEN.STATE] <= TWEEN_STATE.PAUSED)
    {
        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
        
        if (_t[TWEEN.DELAY] >= 0)
        {
            _t[@ TWEEN.DELAY] = -1;   
            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_STOP_DELAY);
        }
        else
        {
            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_STOP);
        }
            
        if (_t[TWEEN.DESTROY])
        {
            TweenDestroy(_t);
        }
    }
}

if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenStop);
}
