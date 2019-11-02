/// @desc screen_shake(magnitude,time)
/// @arg Magnitude sets strength
/// @arg Time sets length in frames

with (o_camera)
{
	if (argument0 > shake_remain)
	{
		shake_magnitude = argument0;
		shake_remain = argument0;
		shake_length = argument1;
	}
}

