/// EaseInOutExpo(time,start,change,duration)

var _val = 2 * argument0 / argument3;

if (_val < 1) { return argument2 * 0.5 * power(2, 10 * --_val) + argument1; }

return argument2 * 0.5 * (-power(2, -10 * --_val) + 2) + argument1;



