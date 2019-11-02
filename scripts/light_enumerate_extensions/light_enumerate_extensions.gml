/// @desc Enumerate and apply all extension modules of a given light
/// @arg light The light to enumerate extensions of
/// @arg ext_script The script of the extension module to execute

var light = argument0;
var ext_script = argument1;

var extensions = light[| eLight.ExtensionModules];
if(extensions != undefined) {
	var len = ds_list_size(extensions);
	for(var i = 0; i < len; ++i) {
		var ext = ds_list_find_value(extensions, i);
		script_execute(ext[ext_script], light);
	}
}