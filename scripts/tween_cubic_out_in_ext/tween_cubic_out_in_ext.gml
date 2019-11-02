/// @description tween_cubic_out_in_ext(input_value, input_range_min, input_range_max, output_range_min, output_range_max);
/// @param input_value
/// @param input_range_min
/// @param input_range_max
/// @param output_range_min
/// @param output_range_max
/*
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This script remaps/tweens an input value from an input range to an output range
in a "cubic out/in" fashion: slow -> fast -> slow

input_value			The value to remap
					could i.e. be a timers current value
					
input_range_min		The starting point of the input value
					i.e. current_time at start of the tween
					
input_range_max		The end point of the input value
					i.e. current_time at start of the tween + duration
					
output_range_min	The starting point of the remapped value
					i.e. x & y at the start of the tween
					
output_range_max	The end point of the remapped value
					i.e. x & y at the end of the tween

returns				the input_value remapped to the output_range
					so basically out_value
_____________________________________________________________________________*/

/* original version:
t /= d/2;
if (t < 1) return c/2*t*t*t + b;
t -= 2;
return c/2*(t*t*t + 2) + b; */


/* Long version:
var in_min		= argument1;			// -
var in_value	= argument0 - in_min;	// t
var in_range	= argument2 - in_min;	// d
var out_min		= argument3;			// b
var out_range	= argument4 - out_min;	// c

in_value /= in_range / 2;
if (in_value < 1)
return out_range / 2 * in_value * in_value * in_value       + out_min;
in_value -= 2;
return out_range / 2 * (in_value * in_value * in_value + 2) + out_min; */


// Short version:
var in_value = 2 * (argument0 - argument1) / (argument2 - argument1);
if (in_value < 1)
return (argument4 - argument3) / 2 * in_value * in_value * in_value       + argument3;
in_value -= 2;
return (argument4 - argument3) / 2 * (in_value * in_value * in_value + 2) + argument3;
