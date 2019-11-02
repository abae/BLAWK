/// EaseInOutQuad(time,start,change,duration)

var _arg0 = 2*argument0/argument3;

if (_arg0 < 1){
    return argument2 * 0.5 * _arg0 * _arg0 + argument1;
}

return argument2 * -0.5 * ((_arg0-1) * (_arg0 - 3) - 1) + argument1;


