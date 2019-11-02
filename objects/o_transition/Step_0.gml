if (mode != TRANS_MODE.OFF){
	if (mode == TRANS_MODE.INTRO){
		percent = smooth_approach(percent,0,.1);
	}else{
		percent = smooth_approach(percent,1,.1);
	}
	if (percent == 1 or percent == 0){
		switch(mode){
			case TRANS_MODE.INTRO:{
				mode = TRANS_MODE.OFF;
				break;}
			case TRANS_MODE.NEXT:{
				mode = TRANS_MODE.INTRO;
				room_goto_next();
				break;}
			case TRANS_MODE.GOTO:{
				mode = TRANS_MODE.INTRO;
				room_goto(target);
				break;}
			case TRANS_MODE.RESTART:{
				game_restart();
				break;}
			case TRANS_MODE.RRESTART:{
				room_restart();
				break;}
		}
	}
}

//show_debug_message(string(percent))