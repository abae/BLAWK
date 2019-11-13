alarm[0] = 4*room_speed;
alarm[1] = .2*room_speed;
alarm[2] = 1.5*room_speed;
window_command_set_active(window_command_move,false);
window_command_set_active(window_command_resize, 0); // can disable window resizing
window_command_set_active(window_command_maximize, 0); // or ability to maximize window
window_command_set_active(window_command_minimize, 0); // or ability to minimize window
min_vy = 1;
max_vy = 11;
vy = max_vy;
yy = 0

time = 0;
time1 = 0*room_speed;
time2 = 2.5*room_speed;