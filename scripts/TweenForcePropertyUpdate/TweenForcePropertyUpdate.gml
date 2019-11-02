/// @description Forces tween to re-calculate and immediately update its property

/// TweenForcePropertyUpdate(tween)
/// @param tween	tween id

var _t = argument0;

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t))
{
    if (_t[TWEEN.STATE] >= 0 and _t[TWEEN.DURATION]!= 0)
    {
        if (_t[TWEEN.PROPERTY] != TGMS_NULL__)
        {
            script_execute(_t[TWEEN.PROPERTY], script_execute(_t[TWEEN.EASE], clamp(_t[TWEEN.TIME], 0, _t[TWEEN.DURATION]), _t[TWEEN.START], _t[TWEEN.CHANGE], _t[TWEEN.DURATION]), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
        }
    }
}

if (is_string(_t))
{
	TGMS_TweensExecute(_t, TweenForcePropertyUpdate);
}

