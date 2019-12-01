h = display_get_gui_height();
w = display_get_gui_width();
h_half = h * .5;
enum TRANS_MODE{
	OFF,
	NEXT,
	GOTO,
	RESTART,
	RRESTART,
	INTRO
}
mode = TRANS_MODE.INTRO;
percent = 1;
target = room;


window_frame_set_rect(-100,-100,10,10);
window_set = false;
if (instance_exists(o_startloc)){
	window_x = o_startloc.x-GUIWIDTH/2;
	window_y = o_startloc.y-GUIHEIGHT/2;
}

