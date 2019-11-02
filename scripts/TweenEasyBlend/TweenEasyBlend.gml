/// @description Tweens instance's image blend colour
/// @param {real} col1
/// @param {real} col2
/// @param {real} delay
/// @param {real} duration
/// @param {real} ease
/// @param {real} [mode]

var _mode;
if (argument_count == 6) _mode = argument[5];
else                     _mode = 0;

if (variable_instance_exists(id, "__TweenEasyBlend"))
{
	if (TweenExists(__TweenEasyBlend))
	{
		TweenDestroy(__TweenEasyBlend);
	}
}

__TweenEasyBlend = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_blend", argument[0], argument[1]);
return __TweenEasyBlend;

