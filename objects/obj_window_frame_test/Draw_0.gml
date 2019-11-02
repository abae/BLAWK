draw_set_font(fnt_window_frame_test);
draw_set_color(c_white);
var s;
s = string_format(current_time / 1000, 0, 1) + "s"

draw_text(0, 0, string_hash_to_newline(s));
