/// TGMS_Final()
/*
    !DO NOT CALL THIS!
    Automatically called by the extension.
*/

with(obj_SharedTweener) instance_destroy(); // Destroy shared tweener
ds_map_destroy(global.TGMS_MAP_TWEEN);      // Destroy global tween id map
ds_stack_destroy(global.TGMS_TweensStack);	// Destroy tween selection stack
ds_map_destroy(global.__PropertyGetters__); // Destroy property getters map
ds_map_destroy(global.__PropertySetters__); // Destroy property setters map
ds_map_destroy(global.__PropertiesDefined__); // Destroy defined properties map
ds_map_destroy(global.__NormalizedProperties__);
