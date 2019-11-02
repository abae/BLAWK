/// @description tween_anticipate_input_01(input_value, output_range_min, output_range_max, anticipate);
/// @param input_value
/// @param output_range_min
/// @param output_range_max
/// @param anticipate
/*
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This script remaps/tweens an input value from an input range of 0 to 1
to an output range in an "anticipate" fashion.

input_value			The value to remap
					could i.e. be a timers current value
					
output_range_min	The starting point of the remapped value
					i.e. x & y at the start of the tween
					
output_range_max	The end point of the remapped value
					i.e. x & y at the end of the tween

anticipate			distance of the anticipation
					Usually 1 to 4 looks good.

returns				the input_value remapped to the output_range
					so basically out_value
_____________________________________________________________________________*/

/* original version:
return c*(t/=d)*t*((s+1)*t - s) + b; */


/* Long version:
//var in_min	= 0;					// -
var in_value	= argument0;			// t
//var in_range	= 1;					// d
var out_min		= argument1;			// b
var out_range	= argument2 - out_min;	// c
var anticipate	= argument3;			// -

return out_range * in_value * in_value * ((anticipate + 1) * in_value - anticipate) + out_min; */


// Short version:
return (argument2 - argument1) * argument0 * argument0 * ((argument3 + 1) * argument0 - argument3) + argument1;

