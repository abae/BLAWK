/// EaseOutCirc(time,start,change,duration)

var _val = argument0/argument3 - 1;
return argument2 * sqrt(abs(1 - _val * _val)) + argument1;



