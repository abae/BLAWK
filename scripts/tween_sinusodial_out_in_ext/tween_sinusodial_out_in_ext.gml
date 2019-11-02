/// @description tween_sinusodial_out_in_ext(input_value, input_range_min, input_range_max, output_range_min, output_range_max);
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
in a "sinusodial out" fashion: slow -> fast -> slow

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
-c / 2 * (cos(PI * t / d ) - 1) + b;*/


/* Long version:
var in_min		= argument1;			// -
var in_value	= argument0 - in_min;	// t
var in_range	= argument2 - in_min;	// d
var out_min		= argument3;			// b
var out_range	= argument4 - out_min;	// c

return -out_range / 2 * (cos(3.14159265359 * in_value / in_range) - 1) + out_min; */


// Short version:
return -(argument4 - argument3) / 2 * (cos(3.14159265359 * (argument0 - argument1) / (argument2 - argument1)) - 1) + argument3;
