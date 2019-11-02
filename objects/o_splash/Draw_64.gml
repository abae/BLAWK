var w = GUIHEIGHT*(16/9);
var xoff = (GUIWIDTH-w)/2;
draw_sprite_stretched(s_splash,image_index,xoff,0,w,GUIHEIGHT);
set_text(c_white,fnt_pixel16,fa_center,fa_bottom);
draw_text(GUIWIDTH/2,GUIHEIGHT-50,"Andy Bae\n@Bae_Yusung");