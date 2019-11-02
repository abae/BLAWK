/// @desc cutscene_wait
/// @arg seconds

timer++;

if (timer>= argument0 * room_speed)
{
	timer = 0;
	cutscene_end_action();
}