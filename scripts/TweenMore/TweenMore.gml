/// TweenMore(tween,target,ease,mode,delta,delay,dur,prop,start,dest,[...])

/// @param tween	tween id
/// @param target	instance to associate with tween (id or object index)
/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
/// @param delay	amount of time to delay tween before playing
/// @param dur		duration of time to play tween
/// @param prop		property setter string or TP*() script
/// @param start	starting value for eased property
/// @param dest		destination value for eased property
/// @param [...]	(optional) additional properties ("direction", 0, 360)

// RETURNS: tween id

/*
    Info:
		Allows for chaining of tweens by adding a tween to be fired after the indicated tween finishes.
		Multiple new tweens can be added to the same tween, allowing for branching chains.
		Tween is automatically destroyed when finished, stopped, or if its associated target instance is destroyed.
		Returns unique tween id.   
    
    Examples:
        // Chain various tweens to fire one after another
		tween1 = TweenFire(id, EaseOutBounce, 0, true, 0, 1.0, "y", -100, y);
		tween2 = TweenMore(tween1, id, EaseInOutQuad, 0, true, 0, 0.5, "image_yscale", 1, 0.25);
		tween3 = TweenMore(tween1, id, EaseInOutSine, 0, true, 0, 1.0, "image_angle", 0, 360);
		tween4 = TweenMore(tween3, id, EaseInOutQuad, 0, true, 0, 2.0, "image_xscale", 1, 0.5);
*/

var _tween = argument[0];
var _target = argument[1];
var _newTween = TweenCreate(_target);
TweenDestroyWhenDone(_newTween, true); // Have tween auto-destroy

switch((argument_count-7) div 3)
{
	case 1:  TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
	case 2:  TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
	case 3:  TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15]); break;
	case 4:  TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18]); break;
	case 5:  TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21]); break;
	case 6:  TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24]); break;
	case 7:  TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27]); break;
	case 8:  TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27], argument[28], argument[29], argument[30]); break;
	case 9:  TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27], argument[28], argument[29], argument[30], argument[31], argument[32], argument[33]); break;
	case 10: TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27], argument[28], argument[29], argument[30], argument[31], argument[32], argument[33], argument[34], argument[35], argument[36]); break;
}

return _newTween;
