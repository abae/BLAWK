/// @description Tweens instance's image scale
/// @param {real} x1
/// @param {real} y1
/// @param {real} x2
/// @param {real} y2
/// @param {real} delay
/// @param {real} duration
/// @param {real} ease
/// @param {real} [mode]

var _mode;
if (argument_count == 8) _mode = argument[7];
else                     _mode = 0;

if (variable_instance_exists(id, "__TweenEasyScale"))
{
	if (TweenExists(__TweenEasyScale))
	{
		TweenDestroy(__TweenEasyScale);
	}
}

__TweenEasyScale = TweenFire(id, argument[6], _mode, global.TGMS_EasyDelta, argument[4], argument[5], "image_xscale", argument[0], argument[2], "image_yscale", argument[1], argument[3]);
return __TweenEasyScale;

