//setting view values
var vpos_x = camera_get_view_x(cam);
var vpos_y = camera_get_view_y(cam);
var vpos_w = camera_get_view_width(cam);
var vpos_h = camera_get_view_height(cam);

xTo = follow_x;
yTo = follow_y;

#region //zoom
var new_w = lerp(vpos_w, zoom * orig_view_w, zoom_rate);
var new_h = lerp(vpos_h, zoom * orig_view_h, zoom_rate);

//Zoom based on size
camera_set_view_size(cam, new_w, new_h);

//Shifting camera based on zoom
var shift_x = camera_get_view_x(cam) - (new_w - vpos_w)/2;
var shift_y = camera_get_view_y(cam) - (new_h - vpos_h)/2;

//update camera
camera_set_view_pos(cam,shift_x,shift_y);
#endregion

//update view values
view_w_half = camera_get_view_width(cam)/2;
view_h_half = camera_get_view_height(cam)/2;
var vpos_x = camera_get_view_x(cam);
var vpos_y = camera_get_view_y(cam);
var vpos_w = camera_get_view_width(cam);
var vpos_h = camera_get_view_height(cam);

#region //dolly
//Movement
//x = lerp(x,xTo,move_rate);
//y = lerp(y,yTo,move_rate);

xx = x;
yy = y;
x = xTo;
y = yTo;

//show_debug_message(string(x)+"   "+string(y));
//Interpolate the view position to the new, relative position.
//var new_x = lerp(vpos_x, x - (vpos_w/2), move_rate);
//var new_y = lerp(vpos_y, y - (vpos_h/2), move_rate);

//Screen shake
//x += random_range(-shake_remain,shake_remain);
//y += random_range(-shake_remain,shake_remain);
//shake_remain = max(0,shake_remain-((1/shake_length)*shake_magnitude));

//constrian camera
//if (room_width > GUIWIDTH) x = clamp(x,view_w_half+buff,room_width-view_w_half-buff);
//else new_x = (room_width-GUIWIDTH)/2;
//if (room_height > GUIHEIGHT) y = clamp(y,view_h_half+buff,room_height-view_h_half-buff);
//else new_y = (room_height-GUIHEIGHT)/2;

//Update the view position
camera_set_view_pos(cam, x, y);
#endregion
