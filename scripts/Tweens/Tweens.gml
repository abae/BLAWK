/// @description Returns selected tween ids, for scripts supporting 'tween[s]' argument

/// Tweens(tween1,tween2,...)
/// @param tween1	first selected tween
/// @param tween2	second selected tween
/// @param ...		additional tweens

/*
    The Tweens*() selection scripts can be used with any tween scripts
    which show 'tween[s]' as an argument.
    
    e.g.
		var _tweens = Tweens(tween1, tween2);
        TweenSet(_tweens, "time_scale", 0.5); // Set time scale for tween1 and tween2
*/

var _tweens;
var i = -1;

repeat(argument_count)
{
    ++i;
    _tweens[i] = argument[i];
}

ds_stack_push(global.TGMS_TweensStack, _tweens);

return "00";

