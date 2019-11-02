/// @description Checks if tween is playing

/// TweenIsPlaying(tween)
/// @param tween	tween id

/// return: bool

/// TweenIsPlaying(tween)
/*
    NOTE:
        ** Will NOT return true if tween is processing a delay **
        
    Example:
        if (TweenIsPlaying(tween))
        {
            TweenPause(tween);
        }
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) return false;

return _t[TWEEN.STATE] >= 0;

