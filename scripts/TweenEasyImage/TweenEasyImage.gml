/// @description Tweens instance's image index
/// @param {real} index1
/// @param {real} index2 
/// @param {real} delay
/// @param {real} duration
/// @param {real} ease
/// @param {real} [mode]

var _mode;
if (argument_count == 6) _mode = argument[5];
else                     _mode = 0;

if (variable_instance_exists(id, "__TweenEasyImage"))
{
	if (TweenExists(__TweenEasyImage))
	{
		TweenDestroy(__TweenEasyImage);
	}
}

__TweenEasyImage = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_index", argument[0], argument[1]);
return __TweenEasyImage;


