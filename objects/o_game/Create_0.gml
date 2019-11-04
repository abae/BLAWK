window_frame_set_visible(false);
xmin = 0;
xmax = 1920 - GUIWIDTH;
ymin = 0;
ymax = 1080 - GUIHEIGHT;

instance_create_layer(display_mouse_get_x()-GUIWIDTH/2,display_mouse_get_y()-GUIHEIGHT/2,"Instances",o_bound);

instance_create_layer(DISP_WIDTH/2,DISP_HEIGHT/2,"Instances",o_window_check);