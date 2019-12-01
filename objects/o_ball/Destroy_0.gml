audio_stop_sound(sfx_chick_stretch);
audio_play_sound(sfx_chick_hurt,70,false);

instance_create_layer(o_startloc.x,o_startloc.y,"Instances",o_window_check);
repeat(150) instance_create_depth(x,y,depth,o_feather);
transition("shrink", TRANS_MODE.RRESTART);