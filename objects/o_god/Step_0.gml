//developer tools
window_frame_update();
if (dev){
	if (is(room_get_name(room),"rm_splash","rm_menu")) room_goto_next();
	
	if (keyboard_check(vk_control)){
		if (keyboard_check_pressed(ord("R"))) game_restart();
		if (keyboard_check_pressed(ord("P")) and room_next(room) != -1) room_goto_next();
		if (keyboard_check_pressed(ord("O")) and room_previous(room) != -1) room_goto_previous();
		if (keyboard_check_pressed(ord("D"))) dev_draw = !dev_draw;
	
		//fullscreen switching
		if (keyboard_check_pressed(ord("F"))) window_set_fullscreen(!window_get_fullscreen());
	}
}

//Pausing
if (keyboard_check_pressed(vk_escape) and !is(room,rm_init,rm_splash,rm_menu)){
    paused = !paused
    if (!sprite_exists(screenshot)) screenshot = sprite_create_from_surface(application_surface,0,0,view_wport,view_hport,0,0,0,0);
    
    if (paused){
        instance_deactivate_all(true);
    }else{
        if (sprite_exists(screenshot)) sprite_delete(screenshot);
        instance_activate_all();
    }
}
//pause options
if (paused){
	if(keyboard_check_pressed(ord("R"))){
		paused = !paused
		if (sprite_exists(screenshot)) sprite_delete(screenshot);
        instance_activate_all();
		transition("slide",TRANS_MODE.RRESTART);
	}
	if(keyboard_check_pressed(ord("X"))){
		paused = !paused
		if (sprite_exists(screenshot)) sprite_delete(screenshot);
        instance_activate_all();
		transition("fade",TRANS_MODE.GOTO,rm_menu);
	}
}

//clamp mouse position
//if (!dev) window_mouse_set(clamp(window_mouse_get_x(), 0, window_get_width()), clamp(window_mouse_get_y(), 0, window_get_height()));