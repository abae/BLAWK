/// @description Tweens instance's image angle
/// @param {real} angle1
/// @param {real} angle2
/// @param {real} delay
/// @param {real} duration
/// @param {real} ease
/// @param {real} [mode]

var _mode;
if (argument_count == 6) _mode = argument[5];
else                     _mode = 0;

if (variable_instance_exists(id, "__TweenEasyRotate"))
{
	if (TweenExists(__TweenEasyRotate))
	{
		TweenDestroy(__TweenEasyRotate);
	}
}

__TweenEasyRotate = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_angle", argument[0], argument[1]);
return __TweenEasyRotate;

