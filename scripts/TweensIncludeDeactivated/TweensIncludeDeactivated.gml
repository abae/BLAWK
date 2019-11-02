/// @description Whether or not to include tweens associated with deactivated target instances

/// TweensIncludeDeactivated(include_deactivated)
/// @param include_deactivated?

/*
	When true, Tweens*() scripts will include tweens belonging to deactivated target instances.
	By default, this is set to false.

	e.g. 
		TweensIncludeDeactiavted(true); // include deactivated targets with Tweens*() scripts
*/

global.TGMS_TweensIncludeDeactivated = argument0;
