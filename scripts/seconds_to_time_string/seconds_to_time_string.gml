/// @description seconds_to_time_string(seconds,rounded)
/// @param seconds
/// @param rounded
var sec_input, seconds, minutes, hours, timestring, hourstring, minutestring, secondstring, roundit;
sec_input = argument0;
roundit = argument1;
hours = floor(sec_input/60/60)
minutes = floor(sec_input/60-hours*60)
if !roundit
   seconds = round(100*(sec_input-minutes*60-hours*60*60))/100
else seconds = round((sec_input-minutes*60-hours*60*60))
hourstring = string(hours)
if string_length(hourstring) == 1
hourstring = string_insert("0", hourstring, 0)
minutestring = string(minutes)
if string_length(minutestring) == 1
minutestring = string_insert("0", minutestring, 0)
if seconds mod 1 = 0
secondstring = string(seconds)+".00"
else secondstring = string(seconds)
if seconds < 10
secondstring = string_insert("0", secondstring, 0)
if hours > 0
timestring = hourstring + ":" + minutestring + ":" + secondstring
else
timestring = minutestring + ":" + secondstring
return timestring