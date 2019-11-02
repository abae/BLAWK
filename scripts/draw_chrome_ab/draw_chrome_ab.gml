///@desc draw_chrome_ab(blur_dist,angle, color1, color2)
///@arg blur_dist distance for bluring
///@arg angle
///@arg color1
///@arg color2

//Setting default var
var blur = 1;
var angle = 0;
var c1 = c_red;
var c2 = c_blue;

//Changing defaults
if (argument_count >= 1) var blur = argument[0];
if (argument_count >= 2) var angle = argument[1];
if (argument_count >= 4){
	var c1 = argument[2];
	var c2 = argument[3];
}

var xoff = lengthdir_x(blur,angle);
var yoff = lengthdir_y(blur,angle);

//Draw chromatic aberation
gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index,image_index,x+xoff,y+yoff,image_xscale,image_yscale,image_angle,c1,0.2);
draw_sprite_ext(sprite_index,image_index,x-xoff,y-yoff,image_xscale,image_yscale,image_angle,c2,0.2);
gpu_set_blendmode(bm_normal)