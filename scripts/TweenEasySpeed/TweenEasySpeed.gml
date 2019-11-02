/// @description Tweens instance's speed
/// @param {real} spd1
/// @param {real} spd2 
/// @param {real} delay
/// @param {real} duration
/// @param {real} ease
/// @param {real} [mode]

var _mode;
if (argument_count == 6) _mode = argument[5];
else                     _mode = 0;

if (variable_instance_exists(id, "__TweenEasySpeed"))
{
	if (TweenExists(__TweenEasySpeed))
	{
		TweenDestroy(__TweenEasySpeed);
	}
}

__TweenEasySpeed = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "speed", argument[0], argument[1]);
return __TweenEasySpeed;

