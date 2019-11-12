if (live_call()) return live_result;

click = keyboard_check_direct(1);
pclick = click and !prev_click;
rclick = !click and prev_click;
global.pFrame	   = pclick and 
						between(display_mouse_get_x(),window_get_x(),window_get_x()+GUIWIDTH) and 
						between(display_mouse_get_y(),window_get_y()-31,window_get_y());
if (global.pFrame) {
	state = "hold";
	mouse_xoff = xmin + display_mouse_get_x() - window_get_x();
	mouse_yoff = ymin + display_mouse_get_y() - window_get_y();
	display_mouse_lock(mouse_xoff, mouse_yoff, xmax-xmin, ymax-ymin);
}

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
						

cam_move(window_frame_get_x(),window_frame_get_y(),1);
xx = window_frame_get_x();
yy = window_frame_get_y();
prev_click = click
prev_mousex = mouse_x;
prev_mousey = mouse_y;