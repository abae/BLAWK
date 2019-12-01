if (breakTimer <= 35*room_speed){
	draw_sprite_ext(dispsurf,0,-window_frame_get_x(),-window_frame_get_y(),1,1,0,c_white,1 - (breakTimer/(35*room_speed)));
}