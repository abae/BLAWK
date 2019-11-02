/// EaseOutBack(time,start,change,duration)

var _s = 1.70158;
var _val = argument0/argument3 - 1;
return argument2 * (_val * _val * ((_s + 1) * _val + _s) + 1) + argument1;



