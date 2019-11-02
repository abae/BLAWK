/// @description Resumes the selected tween[s]

/// TweenResume(tween[s])
/// @param tween[s] tween id

// RETURNS: na

var _t = argument0;

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t))
{
    if (_t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
    {
        if (_t[TWEEN.DELAY] > 0)
        {
            _t[@ TWEEN.STATE] = TWEEN_STATE.DELAYED;
            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_RESUME_DELAY);
        }
        else
        {
            _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];
            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_RESUME);
        }
    }
}

if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenResume);
}
