if(!between(o_camera.x+GUIWIDTH/2,x-GUIWIDTH/2,x+GUIWIDTH/2) or !between(o_camera.y+GUIHEIGHT/2,y-GUIHEIGHT/2,y+GUIHEIGHT/2)){
	var dir = point_direction(o_camera.x +GUIWIDTH/2,o_camera.y+GUIHEIGHT/2,x,y);
	if (y <= o_camera.y+GUIHEIGHT/2)	var xx = clamp(GUIWIDTH/2+(GUIHEIGHT/2)/dtan(dir),32,GUIWIDTH-32);
	else								var xx = clamp(GUIWIDTH/2-(GUIHEIGHT/2)/dtan(dir),32,GUIWIDTH-32);
	if (x <= o_camera.x+GUIWIDTH/2)		var yy = clamp(GUIHEIGHT/2+(GUIWIDTH/2)*dtan(dir),32,GUIHEIGHT-32);
	else								var yy = clamp(GUIHEIGHT/2-(GUIWIDTH/2)*dtan(dir),32,GUIHEIGHT-32);
	draw_sprite_ext(s_arrow,0,xx,yy,1,1,dir,c_red,1);
}