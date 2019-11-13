window_frame_update();
dev = false;
dev_draw = false;

paused = false;
screenshot = -1;

//Macros

resolution_set();
randomize();

global.cutscene = false;
global.transition_type = "fade";

show_debug_overlay(true);


if(dev){
	//show_debug_overlay(true);
	window_set_size(ideal_width,ideal_height);
	alarm[0] = 1; //center window
}else{
	//show_debug_overlay(true);
	window_set_size(ideal_width,ideal_height);
	alarm[0] = 1; //center window
}

room_goto_next();

// setup/capture:
var dispsurf = display_capture_surface_part(0,0,1920,1080);
surface_save(dispsurf, "surf.png");