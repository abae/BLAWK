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

