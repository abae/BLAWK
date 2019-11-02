/// @desc Create an extension module instance
/// @arg scr_apply The script to apply the extension to a light
/// @arg scr_cleanup The script that is called to clean up after the extension has been applied to a light
/// @returns The extension module instance

var apply = argument0;
var cleanup = argument1;

var ext = array_create(eLightExtension.Count);
ext[eLightExtension.Apply] = apply;
ext[eLightExtension.Reset] = cleanup;
return ext;