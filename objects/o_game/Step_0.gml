//if (live_call()) return live_result;

click = keyboard_check_direct(1);
pclick = click and !prev_click;
rclick = !click and prev_click;
global.pFrame	   = pclick and 
						between(display_mouse_get_x(),window_get_x(),window_get_x()+GUIWIDTH) and 
						between(display_mouse_get_y(),window_get_y()-31,window_get_y());
if (global.pFrame and !is(room,rm_intro1,rm_intro2)) {
	state = "hold";
	mouse_xoff = xmin + display_mouse_get_x() - window_get_x();
	mouse_yoff = ymin + display_mouse_get_y() - window_get_y();
	display_mouse_lock(mouse_xoff, mouse_yoff, xmax-xmin, ymax-ymin);
}
if (is(room,rm_intro1,rm_intro2)) state = "grav";
if (o_transition.mode == TRANS_MODE.OFF){
	switch (state){
		case "hold":{
			display_mouse_lock(mouse_xoff, mouse_yoff, xmax-xmin, ymax-ymin);
			window_frame_set_rect(display_mouse_get_x()-mouse_xoff+xmin,display_mouse_get_y()-mouse_yoff+ymin,GUIWIDTH,GUIHEIGHT);
			// window_frame_set_rect(o_bound.x-GUIWIDTH/2,o_bound.y-GUIHEIGHT/2,GUIWIDTH,GUIHEIGHT);
		}break;
		case "grav":{
			vy += grav;
			if (window_get_y()+GUIHEIGHT+vy > 1080){
				vy = -approach(vy,0,4);
				vx = approach(vx,0,.5)
			}
			if (window_get_x() + vx < 0) vx = abs(vx);
			if (window_get_x() + GUIWIDTH + vx > 1920) vx = -abs(vx);
			if (window_get_y() + GUIHEIGHT + vy < ymin) vy = abs(vy);
			window_frame_set_rect(window_get_x()+vx,window_get_y()+vy,GUIWIDTH,GUIHEIGHT);
		}break;
		case "nothing":{
			window_frame_set_rect(window_get_x(),window_get_y(),GUIWIDTH,GUIHEIGHT);
		}
	}
}

if (!click) {
	display_mouse_unlock();
	state = "nothing"
}
if (rclick){
	vx = window_frame_get_x()-xx;
	vy = window_frame_get_y()-yy;
}

switch(room){
	case rm_level2:{
		ymin = 850-GUIHEIGHT;
	}break;
	case rm_level3:{
		ymin = 720-GUIHEIGHT;
	}break;
	case rm_level4:{
		if (instance_exists(o_ball)){
			o_ball.exercise = true;
			if (o_ball.steps >= 100) {
				if (!audio_is_playing(sfx_win) and !o_ball.win) audio_play_sound(sfx_win,100,false);
				o_ball.win = true;
				transition("shrink", TRANS_MODE.NEXT);
			}
		}
	}break;
	case rm_level6:{
		if (state == "nothing") breakTimer--;
		else breakTimer = 40*room_speed;
		if (breakTimer <= -5*room_speed) {
			transition("shrink",TRANS_MODE.NEXT);
			if (!audio_is_playing(sfx_win) and !o_ball.win) audio_play_sound(sfx_win,100,false);
			o_ball.win = true;
		}
	}break;
}
						

cam_move(window_frame_get_x(),window_frame_get_y(),1);
xx = window_frame_get_x();
yy = window_frame_get_y();
prev_click = click
prev_mousex = mouse_x;
prev_mousey = mouse_y;