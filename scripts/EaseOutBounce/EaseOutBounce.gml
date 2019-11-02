/// EaseOutBounce(time,start,change,duration)

var _val = argument0/argument3;

if (_val < 1/2.75)
{
    return argument2 * 7.5625 * _val * _val + argument1;
}
else
if (_val < 2/2.75)
{
    _val -= 1.5/2.75;
    return argument2 * (7.5625 * _val * _val + 0.75) + argument1;
}
else
if (_val < 2.5/2.75)
{
    _val -= 2.25/2.75;
    return argument2 * (7.5625 * _val * _val + 0.9375) + argument1;
}
else
{
    _val -= 2.625/2.75;
    return argument2 * (7.5625 * _val * _val + 0.984375) + argument1;
}




