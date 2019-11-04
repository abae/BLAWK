click = keyboard_check_direct(1);
pclick = click and !p_click;
rclick = !click and p_click;
global.pFrame	   = pclick and 
						between(display_mouse_get_x(),window_get_x(),window_get_x()+GUIWIDTH) and 
						between(display_mouse_get_y(),window_get_y()-31,window_get_y());
if (global.pFrame) {
	frame_active = true;
	mouse_xoff = xmin + display_mouse_get_x() - window_get_x();
	mouse_yoff = ymin + display_mouse_get_y() - window_get_y();
	display_mouse_lock(mouse_xoff, mouse_yoff, xmax-xmin, ymax-ymin);
}

if (frame_active) display_mouse_lock(mouse_xoff, mouse_yoff, xmax-xmin, ymax-ymin);
if (rclick){
	frame_active = false;
	display_mouse_unlock();
}


						
//display_mouse_lock(window_get_x(),window_get_y()-31,GUIWIDTH,GUIHEIGHT+31)
//window_command_set_active(window_command_move,true);
window_frame_set_visible(true);
//window_frame_set_rect(clamp(display_mouse_get_x()-GUIWIDTH/2,xmin,xmax),clamp(display_mouse_get_y()-GUIHEIGHT/2,ymin,ymax),GUIWIDTH,GUIHEIGHT);
//window_frame_set_rect(clamp(window_frame_get_x(),xmin,xmax),clamp(window_frame_get_y(),ymin,ymax),GUIWIDTH,GUIHEIGHT);

ymin = 200;
//cam_move(clamp(window_get_x(),0,1920-GUIWIDTH),clamp(window_get_y(),0,1920-GUIWIDTH),1);
cam_move(window_frame_get_x(),window_frame_get_y(),1);
//window_command_set_active(window_command_move,false);
p_click = click