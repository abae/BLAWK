/// @desc draw_dashedline(x1, y1, x2, y2, step)
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg step

var sx = argument0;
var sy = argument1;
var tx = argument2;
var ty = argument3;
var step = argument4;

var xr = abs(tx - sx);
var yr = abs(ty - sy);

if (xr > yr)
    var l = xr;
else
    var l = yr;

var px = (sx << 12) + (1 << 11);
var py = (sy << 12) + (1 << 11);
var ex = (tx << 12) + (1 << 11);
var ey = (ty << 12) + (1 << 11);

if (l != 0)
{
    var dx = (ex - px) / l;
    var dy = (ey - py) / l;
}
else
{
    var dx = 0;
    var dy = 0;
}

if step < 1
{
    // Draw solid line
    for (var i=0; i<=l; i++)
    {
        draw_point(px >> 12, py >> 12);
        px += dx;
        py += dy;
    }
}
else
{
    // Draw dashed line
    var cnt = 0;
    for (var i=0; i<=l; i++)
    {
        var posx = px >> 12;
        var posy = py >> 12;
        if cnt < step
            draw_point(posx, posy);
           
        cnt = (cnt + 1) mod (step * 2);
        px += dx;
        py += dy;
    }
}
