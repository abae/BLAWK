/// @description Plays tween[s] defined with TweenCreate*() after a set delay

/// TweenPlayDelay(tween[s],delay)
/// @param tween[s]		id of previously created/defined tween[s]
/// @param delay		amount of time to delay start

var _t = argument0;

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t))
{
    _t[@ TWEEN.DELAY_START] = argument1;
    TweenPlay(_t[TWEEN.ID]);
}
    
if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenPlayDelay, argument1);
}


