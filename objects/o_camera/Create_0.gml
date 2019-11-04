//Setting display
//window_command_hook(window_command_close);
window_command_set_active(window_command_resize, 0); // can disable window resizing
window_command_set_active(window_command_maximize, 0); // or ability to maximize window
window_command_set_active(window_command_minimize, 0); // or ability to minimize window
//window_set_cursor(cr_none);

//Setting up camera
target_view = 0;
cam = view_camera[target_view];
follow = -1;
follow_x = DISP_WIDTH/2-GUIWIDTH/2;
follow_y = DISP_HEIGHT/2-GUIHEIGHT/2;
xx = x;
yy = y;
orig_view_w = camera_get_view_width(cam);
view_w_half = camera_get_view_width(cam)/2;
orig_view_h = camera_get_view_height(cam);
view_h_half = camera_get_view_height(cam)/2;
xTo = follow_x;
yTo = follow_y;
x = xTo;
y = yTo;

//screen shake
shake_length = 0;
shake_magnitude = 0;
shake_remain = 0;
buff = 0;

//zoom and move
zoom = 1;

//interpolation rate
zoom_rate = .05;
move_rate = 1;

//set camera
camera_set_view_size(cam, zoom * orig_view_w, zoom * orig_view_h);

camera_set_view_pos(cam, x, y);