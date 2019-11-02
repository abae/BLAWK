/// @description tween_anticipate_simple(input_value, anticipate);
/// @param input_value
/// @param anticipate
/*
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This script remaps/tweens an input value from an input range of 0 to 1
to an output range of 0 to 1 in an "anticipate" fashion.

input_value			The value to remap
					could i.e. be a timers current value
					
anticipate			distance of the anticipation
					Usually 1 to 4 looks good.

returns				the input_value remapped to the output_range
					so basically out_value
_____________________________________________________________________________*/

/* original version:
return c*(t/=d)*t*((s+1)*t - s) + b; */


/* Long version:
//var in_min	= 0;			// -
var in_value	= argument0;	// t
//var in_range	= 1;			// d
//var out_min	= 0;			// b
//var out_range	= 1;			// c
var anticipate	= argument1;	// -

return in_value * in_value * ((anticipate + 1) * in_value - anticipate); */


// Short version:
return argument0 * argument0 * ((argument1 + 1) * argument0 - argument1);

