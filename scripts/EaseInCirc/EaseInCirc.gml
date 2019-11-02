/// EaseInCirc(time,start,change,duration)

var _val = argument0/argument3;
return argument2 * (1 - sqrt(1 - _val * _val)) + argument1;


