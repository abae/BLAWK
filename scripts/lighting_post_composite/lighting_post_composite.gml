/// @desc Executed after compositing the lighting map

//
//	This is not guaranteed to be executed for every lighting_pre_composite!
//

// Any dirty shadow casters to clear?
var list = global.worldDirtyShadowCasters;
var size = ds_list_size(list);
for(var i = 0; i < size; ++i) {
	var shadow_caster = list[| i];
	with(shadow_caster) {
		// Unset the dirty and cleanup flags
		flags &= ~(eShadowCasterFlags.MarkedForCleanup | eShadowCasterFlags.Dirty);
	}
}

// Clear the list of dirty shadow casters
if(list > 0) ds_list_clear(list);