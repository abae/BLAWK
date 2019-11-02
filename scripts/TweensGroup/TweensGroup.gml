/// @description Returns tween ids associated with a group, for scripts supporting 'tween[s]' argument

/// TweensGroup(group)
/// @param group	tween group

/*
    The Tweens*() scripts can be used with any tween scripts
    which show 'tween[s]' as an argument.
    
    e.g.
		TweenPause(TweensGroup(2)); // pause all tweens associated with group '2'
*/

return "2"+string(argument0);
