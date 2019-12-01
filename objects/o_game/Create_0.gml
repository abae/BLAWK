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
grav = .3;
state = "nothing";

window_frame_set_visible(true);
window_command_set_active(window_command_move,false);
xmin = -BIG;
xmax = 1920;
ymin = -BIG;
ymax = 1080;
prev_mousex = 0;
prev_mousey = 0;

breakTimer = 40*room_speed;

// setup/capture:
dispsurf = display_capture_surface_part(0,0,1920,1080);
surface_save(dispsurf, "surf.png");
dispsurf = sprite_add("surf.png", 1, false, false, 0, 0);

if (instance_exists(o_startloc)){
	instance_create_layer(o_startloc.x,o_startloc.y,"Instances",o_window_check);
	//window_frame_set_rect(o_startloc.x - GUIWIDTH/2,o_startloc.y-GUIHEIGHT/2,GUIWIDTH,GUIHEIGHT);
	
}

if (room == rm_level3)	instance_create_layer(o_startloc.x,o_startloc.y,"Instances",o_boundholerect);
else					instance_create_layer(o_startloc.x,o_startloc.y,"Instances",o_bound);
instance_create_layer(o_startloc.x+20,o_startloc.y+50,"Instances",o_ball);

if (!audio_is_playing(sfx_bird)) audio_play_sound(sfx_bird,100,true);