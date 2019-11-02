/// @description Tweens instance's direction
/// @param {real} dir1
/// @param {real} dir2
/// @param {real} delay
/// @param {real} duration
/// @param {real} ease
/// @param {real} [mode]

var _mode;
if (argument_count == 6) _mode = argument[5];
else                     _mode = 0;

if (variable_instance_exists(id, "__TweenEasyTurn"))
{
	if (TweenExists(__TweenEasyTurn))
	{
		TweenDestroy(__TweenEasyTurn);
	}
}

__TweenEasyTurn = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "direction", argument[0], argument[1]);
return __TweenEasyTurn;

