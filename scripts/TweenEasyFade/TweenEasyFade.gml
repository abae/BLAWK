/// @description Tweens instance's image alpha
/// @param {real} alpha1
/// @param {real} alpha2 
/// @param {real} delay
/// @param {real} duration
/// @param {real} ease
/// @param {real} [mode]

var _mode;
if (argument_count == 6) _mode = argument[5];
else                     _mode = 0;

if (variable_instance_exists(id, "__TweenEasyFade"))
{
	if (TweenExists(__TweenEasyFade))
	{
		TweenDestroy(__TweenEasyFade);
	}
}

__TweenEasyFade = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_alpha", argument[0], argument[1]);
return __TweenEasyFade;
