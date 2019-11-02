/// @desc sleep(ms)
/// @arg ms

var t = current_time + argument0;
while (current_time < t) { /* idle loop */ }
