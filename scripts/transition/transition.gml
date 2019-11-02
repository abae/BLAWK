/// @desc transition(type, mode, targetroom)
/// @arg Type "fade", "slide", etc.
/// @arg Mode sets transition mode between next, restart, and goto
/// @arg Target sets target room when using the goto mode

with(o_transition)
{
	global.transition_type = argument[0];
	mode = argument[1];
	if (argument_count > 2) target = argument[2];
}

