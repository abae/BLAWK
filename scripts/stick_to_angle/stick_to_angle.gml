/// @description stick_to_angle(object, xoffset, yoffset, angleoffset)
/// @param object
/// @param  xoffset
/// @param  yoffset
/// @param  angleoffset
var obj = argument0;
var xx = argument1;
var yy = argument2;
var dis = point_distance(obj.x, obj.y, obj.x+xx, obj.y+yy);
var dir = point_direction(obj.x, obj.y, obj.x+xx, obj.y+yy);
x = obj.x+lengthdir_x(dis, dir+obj.image_angle);
y = obj.y+lengthdir_y(dis, dir+obj.image_angle);
image_angle = obj.image_angle+argument3;


