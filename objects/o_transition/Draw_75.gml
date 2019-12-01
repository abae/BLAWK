/// @description Black bars

if (mode != TRANS_MODE.OFF){
	switch (global.transition_type){
		case "shrink": {
			if (mode != TRANS_MODE.INTRO and window_set == false){
				window_set = true;
				window_x = window_get_x();
				window_y = window_get_y();
			}
			if (percent > .90){
				window_frame_set_rect(-100,-100,10,10);
			}else{
				var perc = tween_cubic_in_simple(percent);
				window_frame_set_rect(window_x + (GUIWIDTH/2)*perc, window_y + (GUIHEIGHT/2)*perc,
										GUIWIDTH*(1-perc), GUIHEIGHT*(1-perc));
				show_debug_message(string(percent))
			}
		}break;
		case "slide": default:{
			draw_set_color(c_black);
			draw_rectangle(0,0,w,percent*h_half,false);
			draw_rectangle(0,h,w,h-(percent*h_half),false);
		}break;
		case "fade":{
			draw_sprite_ext(s_pixel,0,0,0,w,h,0,c_black,percent);
		}break;
	}
}

