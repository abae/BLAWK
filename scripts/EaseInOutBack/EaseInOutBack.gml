/// EaseInOutBack(time,start,change,duration)

var _s = 1.70158;
var _val = argument0/argument3*2;

if (_val < 1)
{
    _s *= 1.525;
    return argument2 * 0.5 * (((_s + 1) * _val - _s) * _val * _val) + argument1;
}

_val -= 2;
_s *= 1.525;

return argument2 * 0.5 * (((_s + 1) * _val + _s) * _val * _val + 2) + argument1;


