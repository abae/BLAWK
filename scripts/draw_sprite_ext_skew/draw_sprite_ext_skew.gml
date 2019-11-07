/// draw_sprite_ext_skew(sprite,subimg, x,y, xscale,yscale, rot,alpha, kx,ky, xmult,ymult)
/// https://yal.cc/draw_sprite_ext_skew
/// @arg sprite
/// @arg subimg
/// @arg x
/// @arg y
/// @arg xscale
/// @arg yscale
/// @arg rot
/// @arg alpha
/// @arg kx How much X skews per each pixel of Y
/// @arg ky How much Y skews per each pixel of X
/// @arg xmult Post-skew, post-rotate scale X
/// @arg ymult Post-skew, post-rotate scale Y

// get the arguments:
var sprite = argument0, subimg = argument1, _x = argument2, _y = argument3,
    scalex = argument4, scaley = argument5, rot = argument6, alpha = argument7,
    skew_kx = argument8, skew_ky = argument9, skew_sx = argument10, skew_sy = argument11;

// compute values that will be reused:
var rcos = dcos(rot);
var rsin = -dsin(rot);
var x1 = -sprite_get_xoffset(sprite) * scalex;
var x2 = x1 + sprite_get_width(sprite) * scalex;
var y1 = -sprite_get_yoffset(sprite) * scaley;
var y2 = y1 + sprite_get_height(sprite) * scaley;

// compute corner coordinates:
for (var c = 0; c < 4; c++) {
    // pick local corner
    var lx; if (c & 1) lx = x2; else lx = x1;
    var ly; if (c & 2) ly = y2; else ly = y1;
    // see https://yal.cc/2d-pivot-points/:
    var rx = lx * rcos - ly * rsin;
    var ry = lx * rsin + ly * rcos;
    // transform and store corner coordinates:
    global._draw_sprite_ext_skew_x[c] = _x + (rx + ry * skew_kx) * skew_sx;
    global._draw_sprite_ext_skew_y[c] = _y + (ry + rx * skew_ky) * skew_sy;
}

// draw the sprite quad:
draw_sprite_pos(sprite, subimg,
    global._draw_sprite_ext_skew_x[0],
    global._draw_sprite_ext_skew_y[0],
    global._draw_sprite_ext_skew_x[1],
    global._draw_sprite_ext_skew_y[1],
    global._draw_sprite_ext_skew_x[3],
    global._draw_sprite_ext_skew_y[3],
    global._draw_sprite_ext_skew_x[2],
    global._draw_sprite_ext_skew_y[2],
    alpha
);