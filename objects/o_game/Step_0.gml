//window_command_set_active(window_command_move,true);
window_frame_set_rect(clamp(display_mouse_get_x()-GUIWIDTH/2,xmin,xmax),clamp(display_mouse_get_y()-GUIHEIGHT/2,ymin,ymax),GUIWIDTH,GUIHEIGHT);
//window_frame_set_rect(clamp(window_frame_get_x(),xmin,xmax),clamp(window_frame_get_y(),ymin,ymax),GUIWIDTH,GUIHEIGHT);

ymin = 200;
//cam_move(clamp(window_get_x(),0,1920-GUIWIDTH),clamp(window_get_y(),0,1920-GUIWIDTH),1);
cam_move(window_frame_get_x(),window_frame_get_y(),1);
//window_command_set_active(window_command_move,false);