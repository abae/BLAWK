/// @description Black bars

if (mode != TRANS_MODE.OFF){
	switch (global.transition_type){
		case "slide": default:{
			draw_set_color(c_black);
			draw_rectangle(0,0,w,percent*h_half,false);
			draw_rectangle(0,h,w,h-(percent*h_half),false);
			break;}
		case "fade":{
			draw_sprite_ext(s_pixel,0,0,0,w,h,0,c_black,percent);
			break;
		}
	}
}

