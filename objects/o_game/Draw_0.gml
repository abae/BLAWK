draw_set_color(c_dkgray)
var loop = 10;
if (ymin != 0) {
	draw_line_width(-BIG,ymin-1+GUIHEIGHT,BIG,ymin-1+GUIHEIGHT,2);
	for (var i = 1; i < loop; i++){
		draw_sprite_ext(s_arrow, 0, i * (1920)/loop, ymin + GUIHEIGHT - sprite_get_height(s_arrow), 1,1,-90,c_dkgray,1);
		
	}
}
if (ymax != 1080 - GUIHEIGHT) {
	draw_line_width(-BIG,ymax+1,BIG,ymax+1,2);
}
if (xmin != 0) {
	draw_line_width(xmin-1+GUIWIDTH,-BIG,xmin-1+GUIWIDTH,BIG,2);
}
if (xmax != 1920 - GUIWIDTH) {
	draw_line_width(xmax+1,-BIG,xmax+1,BIG,2);
}