///@desc cutscene_end_action

scene++;
if (scene > array_length_1d(scene_info)-1)
{
	instance_destroy();
	global.cutscene = false;
	exit;
}

event_perform(ev_other,ev_user0);