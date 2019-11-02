/// @description tween_bounce_out_ext(input_value, input_range_min, input_range_max, output_range_min, output_range_max);
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
in a "bounce out" fashion.

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
if ((t/=d) < (1/2.75f)) {
	return c*(7.5625f*t*t) + b;
} else if (t < (2/2.75f)) {
	return c*(7.5625f*(t-=(1.5f/2.75f))*t + .75f) + b;
} else if (t < (2.5/2.75)) {
	return c*(7.5625f*(t-=(2.25f/2.75f))*t + .9375f) + b;
} else {
	return c*(7.5625f*(t-=(2.625f/2.75f))*t + .984375f) + b;
} */

/* Long version:
var in_min		= argument1;			// -
var in_value	= argument0 - in_min;	// t
var in_range	= argument2 - in_min;	// d
var out_min		= argument3;			// b
var out_range	= argument4 - out_min;	// c

in_value /= in_range;
if (in_value < (1 / 2.75)) {
	return out_range * (7.5625 * in_value * in_value) + out_min;
} else if (in_value < (2 / 2.75)) {
	in_value -= 1.5 / 2.75;
	return out_range * (7.5625 * in_value * in_value + 0.75) + out_min;
} else if (in_value < (2.5/2.75)) {
	in_value -= 2.25 / 2.75;
	return out_range * (7.5625 * in_value * in_value + 0.9375) + out_min;
} else {
	in_value -= 2.625 / 2.75;
	return out_range * (7.5625 * in_value * in_value + 0.984375) + out_min;
} */

// Short version:
var in_value = (argument0 - argument1) / (argument2 - argument1);
if (in_value < (1 / 2.75)) {
	return (argument4 - argument3) * (7.5625 * in_value * in_value) + argument3;
} else if (in_value < (2 / 2.75)) {
	in_value -= 1.5 / 2.75;
	return (argument4 - argument3) * (7.5625 * in_value * in_value + 0.75) + argument3;
} else if (in_value < (2.5/2.75)) {
	in_value -= 2.25 / 2.75;
	return (argument4 - argument3) * (7.5625 * in_value * in_value + 0.9375) + argument3;
} else {
	in_value -= 2.625 / 2.75;
	return (argument4 - argument3) * (7.5625 * in_value * in_value + 0.984375) + argument3;
}
