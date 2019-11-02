/// @description Tweens instance's hspeed/vspeed
/// @param {real} hspd1
/// @param {real} vspd1 
/// @param {real} hspd2
/// @param {real} vspd2 
/// @param {real} delay
/// @param {real} duration
/// @param {real} ease
/// @param {real} [mode]

var _mode;
if (argument_count == 8) _mode = argument[7];
else                     _mode = 0;

if (variable_instance_exists(id, "__TweenEasySpeedHV"))
{
	if (TweenExists(__TweenEasySpeedHV))
	{
		TweenDestroy(__TweenEasySpeedHV);
	}
}

__TweenEasySpeedHV = TweenFire(id, argument[6], _mode, global.TGMS_EasyDelta, argument[4], argument[5], "hspeed", argument[0], argument[2], "vspeed", argument[1], argument[3]);
return __TweenEasySpeedHV;
