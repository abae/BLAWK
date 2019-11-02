/// @description  draw_shine(x,y,segments,length,color1,color2,rotation_rate(rps),*rot_offset)
/// @param x
/// @param y
/// @param segments
/// @param length
/// @param color1
/// @param color2
/// @param rotation_rate(rps)
/// @param *rot_offset

gpu_set_blendmode(bm_add);
var angle_interval = (360 / argument2);
var length = argument3;
var rotation = (argument6*360*(current_time/1000))%360;
if (argument_count > 7) rotation += argument7;

for (var i = 0; i < argument2;i++){
    var x1 = argument0;
    var y1 = argument1;
    var x2 = x1 + lengthdir_x(length, rotation + angle_interval * i);
    var y2 = y1 + lengthdir_y(length, rotation + angle_interval * i);
    var x3 = x1 + lengthdir_x(length, rotation + angle_interval * (i+1));
    var y3 = y1 + lengthdir_y(length, rotation + angle_interval * (i+1));
    
    var color = argument4;
    if (i%2 != 0) color = argument5;
    draw_triangle_color(x1,y1,x2,y2,x3,y3,color,c_black,c_black,false);
}
gpu_set_blendmode(bm_normal);