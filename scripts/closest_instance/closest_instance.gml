/// @description  closest_instance(x,y,instance_type,max_distance)
/// @param x
/// @param y
/// @param instance_type
/// @param max_distance
var dist, closest = noone, xx = argument0, yy = argument1, instancetype = argument2, closest_dist = argument3;
with instancetype{
     dist = point_distance(x,y,xx,yy)
     if dist < closest_dist {
        closest = id;
        closest_dist = dist
     }
}
return closest;
