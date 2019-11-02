/// @description tween_overshoot_simple(input_value, overshoot);
/// @param input_value
/// @param overshoot
/*
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This script remaps/tweens an input value from an input range of 0 to 1
to an output range of 0 to 1 in an "overshoot" fashion.

input_value			The value to remap
					could i.e. be a timers current value
					
overshoot			distance of the overshoot
					Usually > 1 looks good.

returns				the input_value remapped to the output_range
					so basically out_value
_____________________________________________________________________________*/

/* original version:
return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b; */


/* Long version:
//var in_min	= 0;			// -
var in_value	= argument0;	// t
//var in_range	= 1;			// d
//var out_min	= 0;			// b
//var out_range	= 1;			// c
var overshoot	= argument1;	// -

in_value -= 1;
return (in_value * in_value * ((overshoot + 1) * in_value + overshoot) + 1); */


// Short version:
var in_value = argument0 - 1;
return (in_value * in_value * ((argument1 + 1) * in_value + argument1) + 1);

