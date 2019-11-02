/// @description Checks if tween is active

/// TweenIsActive(tween)
/// @param tween tween id

/// return: bool

/*
    INFO:
        Returns true if tween is playing OR actively processing a delay
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) return false;

return (_t[TWEEN.STATE] >= 0 or _t[TWEEN.STATE] == TWEEN_STATE.DELAYED);
