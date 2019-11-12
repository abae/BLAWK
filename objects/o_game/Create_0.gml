click = 0;
prev_click = 0;
pclick = 0;
rclick = 0;
mouse_xoff = 0;
mouse_yoff = 0;

vx = 0;
vy = 0;
xx = window_get_x();
yy = window_get_y();
grav = .5;
state = "nothing";

window_frame_set_visible(true);
window_command_set_active(window_command_move,false);
xmin = -BIG;
xmax = 1920;
ymin = -BIG;
ymax = 1080;
prev_mousex = 0;
prev_mousey = 0;

if (instance_exists(o_startloc)){
	instance_create_layer(o_startloc.x,o_startloc.y,"Instances",o_window_check);
	window_frame_set_rect(o_startloc.x - GUIWIDTH/2,o_startloc.y-GUIHEIGHT/2,GUIWIDTH,GUIHEIGHT);
	
}
instance_create_layer(display_mouse_get_x()-GUIWIDTH/2,display_mouse_get_y()-GUIHEIGHT/2,"Instances",o_boundhole);
