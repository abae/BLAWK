time++;

window_frame_set_rect(960-GUIWIDTH/2,-GUIHEIGHT + yy,GUIWIDTH,GUIHEIGHT);


if (between(time,time1,time2)){
	vy = approach(vy,min_vy,.1);
} else{
	vy = approach(vy,max_vy,.1);
}

yy += vy;