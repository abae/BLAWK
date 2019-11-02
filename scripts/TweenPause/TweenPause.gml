/// @description Pauses the selected tween[s]

/// TweenPause(tween[s])
/// @param tween[s] tween id

// RETURNS: na

var _t = argument0;

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t))
{
    if (_t[TWEEN.STATE] >= 0)
    {
        _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
        return TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PAUSE);
    }

    if (_t[TWEEN.STATE] == TWEEN_STATE.DELAYED)
    {
        _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
        return TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PAUSE_DELAY);
    }
}

if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenPause);
}

