/// @description tween_overshoot_output_01(input_value, input_range_min, input_range_max, overshoot);
/// @param input_value
/// @param input_range_min
/// @param input_range_max
/// @param overshoot
/*
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This script remaps/tweens an input value from an input range
to an output range of 0 to 1 in an "overshoot" fashion.

input_value			The value to remap
					could i.e. be a timers current value
					
input_range_min		The starting point of the input value
					i.e. current_time at start of the tween
					
input_range_max		The end point of the input value
					i.e. current_time at start of the tween + duration
					
overshoot			distance of the overshoot
					Usually > 1 looks good.

returns				the input_value remapped to the output_range
					so basically out_value
_____________________________________________________________________________*/

/* original version:
return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b; */


/* Long version:
var in_min		= argument1;			// -
var in_value	= argument0 - in_min;	// t
var in_range	= argument2 - in_min;	// d
//var out_min	= 0;					// b
//var out_range	= 1;					// c
var overshoot	= argument3;			// -

in_value = in_value / in_range - 1
return (in_value * in_value * ((overshoot + 1) * in_value + overshoot) + 1); */


// Short version:
var in_value = (argument0 - argument1) / (argument2 - argument1) - 1
return (in_value * in_value * ((argument3 + 1) * in_value + argument3) + 1);

