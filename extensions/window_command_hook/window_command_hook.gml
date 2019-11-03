#define window_command_init
//#macro window_command_close    $F060
//#macro window_command_maximize $F030
//#macro window_command_minimize $F020
//#macro window_command_restore  $F120
//#macro window_command_resize   $F000
//#macro window_command_move     $F010

#define window_command_hook
/// @description  (index): Hooks the specified command 
/// @param index
return window_command_hook_raw(window_handle(), argument0);

#define window_command_unhook
/// @description  (index):
/// @param index
return window_command_unhook_raw(window_handle(), argument0);

#define window_command_run
/// @description  (index, param = 0):
/// @param index
/// @param  param = 0
var wp = argument[0], lp;
if (argument_count > 1) {
	lp = argument[1];
} else lp = 0;
return window_command_run_raw(window_handle(), wp, lp);

#define window_command_get_active
/// @description  (command): Returns whether the given command is currently available.
/// @param command
return window_command_get_active_raw(window_handle(), argument0);

#define window_command_set_active
/// @description  (command, status:bool): Enables/disables the command. Returns -1 if not possible.
/// @param command
/// @param  status:bool
return window_command_set_active_raw(window_handle(), argument0, argument1);

#define window_set_topmost
/// @description  (stayontop:bool): Allows to set a window to show on top of the rest like with GM8.
/// @param stayontop:bool
return window_set_topmost_raw(window_handle(), argument0);

#define window_set_background_redraw
/// @description  (redraw_enabled:bool)
/// @param redraw_enabled:bool
return window_set_background_redraw_raw(window_handle(), argument0);

#define window_set_taskbar_button_visible
/// @description  (enable:bool)
/// @param enable:bool
return window_set_taskbar_button_visible_raw(window_handle(), argument0);

#define window_get_taskbar_button_visible
/// @description  ()->enabled?
return window_get_taskbar_button_visible_raw(window_handle());

