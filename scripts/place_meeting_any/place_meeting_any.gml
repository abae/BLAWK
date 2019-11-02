/// @func place_meeting_any(x, y, objects[])
/// @arg x
/// @arg y
/// @arg objects[] array of objects to check for collision with

gml_pragma("forceinline");

var _len = array_length_1d(argument2);
for (var i = 0; i < _len; i++) {
if (place_meeting(argument0, argument1, argument2[i])) return true;
}

return false;