click = 0;
p_click = 0;
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
xmin = 0;
xmax = 1920 - GUIWIDTH;
ymin = 0;
ymax = 1080 - GUIHEIGHT;

instance_create_layer(display_mouse_get_x()-GUIWIDTH/2,display_mouse_get_y()-GUIHEIGHT/2,"Instances",o_bound);

instance_create_layer(DISP_WIDTH/2,DISP_HEIGHT/2,"Instances",o_window_check);