/// @description Allows for the chaining of script scheduling

/// TweenMoreScript(tween,target,delta,dur,script,[arg0,...])
/// @param tween		tween id
/// @param target		target instance
/// @param delta		use seconds timing? (true=seconds | false = steps)
/// @param dur			duration of time before script is called
/// @param script		script to execute when timer expires
/// @param [arg0,...]	(optional) arguments to pass to script

// RETURNS: tween id

/*
    Info:
        Allows for the chaining of script scheduling.
        Since this uses the tweening system, the returned tween script works with any regular tweening scripts,
		such as TweenPause(), TweenResume(), TweenMore(), etc...
    
    Examples:
		// Display a message after 1 second
        ts = TweenScript(id, true, 1.0, ShowMessage, "Hello, World!");
		
		// Schedule another script to be fired 2 seconds after first one finishes
		ts = TweenMoreScript(ts, id, true, 2.0, ShowMessage, "Goodbye, World!");
		
		// Fire a tween after showing second message
		t = TweenMore(ts, id, EaseInOutQuad, 0, true, 0.0, 1.0, "image_scale", 1.0, 0.0); 
*/

var _t = argument[0];
var _target = argument[1];
var _newTween = TweenCreate(_target, TGMS_NULL__, 0, argument[2], 0, argument[3], "", 0, 1);
TweenDestroyWhenDone(_newTween, true);
TweenAddCallback(_t, TWEEN_EV_FINISH, _target, TweenPlay, _newTween);

switch(argument_count-5)
{
	case 0:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4]); break;
	case 1:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5]); break;
	case 2:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6]); break;
	case 3:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7]); break;
	case 4:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8]); break;
	case 5:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
	case 6:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
	case 7:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]); break;
	case 8:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
	case 9:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13]); break;
	case 10: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14]); break;
	case 11: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15]); break;
	case 12: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16]); break;
	case 13: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17]); break;
	case 14: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18]); break;
	case 15: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19]); break;
	case 16: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20]); break;
}

return _newTween;


