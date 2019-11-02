/// @description tween_overshoot_input_01(input_value, output_range_min, output_range_max, strength);
/// @param input_value
/// @param output_range_min
/// @param output_range_max
/// @param strength
/*
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This script remaps/tweens an input value from an input range of 0 to 1
to an output range in an "anticipate/overshoot" fashion.

input_value			The value to remap
					could i.e. be a timers current value
					
output_range_min	The starting point of the remapped value
					i.e. x & y at the start of the tween
					
output_range_max	The end point of the remapped value
					i.e. x & y at the end of the tween

strength			distance of the anticipation & overshoot
					Usually 1 to 4 looks good.

returns				the input_value remapped to the output_range
					so basically out_value
_____________________________________________________________________________*/

/* original version:
if ((t/=d/2) < 1)
return c/2*(t*t*(((s*=(1.525f))+1)*t - s)) + b;
return c/2*((t-=2)*t*(((s*=(1.525f))+1)*t + s) + 2) + b; */


/* Long version:
//var in_min	= 0;					// -
var in_value	= argument0;			// t
//var in_range	= 1;					// d
var out_min		= argument1;			// b
var out_range	= argument2 - out_min;	// c
var strength	= argument3;			// -

in_value *= 2;
strength *= 1.525;
if (in_value < 1)
return out_range / 2 * (in_value * in_value * ((strength + 1) * in_value - strength)    ) + out_min;
in_value -= 2;
return out_range / 2 * (in_value * in_value * ((strength + 1) * in_value + strength) + 2) + out_min; */


// Short version:
var in_value = argument0 * 2;
var strength = argument3 * 1.525;
if (in_value < 1)
return (argument2 - argument1) / 2 * (in_value * in_value * ((strength + 1) * in_value - strength)    ) + argument1;
in_value -= 2;
return (argument2 - argument1) / 2 * (in_value * in_value * ((strength + 1) * in_value + strength) + 2) + argument1;


