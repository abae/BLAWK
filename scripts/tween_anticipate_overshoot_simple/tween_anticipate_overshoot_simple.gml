/// @description tween_overshoot_simple(input_value, strength);
/// @param input_value
/// @param strength
/*
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This script remaps/tweens an input value from an input range of 0 to 1
to an output range of 0 to 1 in an "anticipate/overshoot" fashion.

input_value			The value to remap
					could i.e. be a timers current value
					
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
//var in_min	= 0;			// -
var in_value	= argument0;	// t
//var in_range	= 1;			// d
//var out_min	= 0;			// b
//var out_range	= 1;			// c
var strength	= argument1;	// -

in_value *= 2;
strength *= 1.525;
if (in_value < 1)
return 0.5 * (in_value * in_value * ((strength + 1) * in_value - strength)    );
in_value -= 2;
return 0.5 * (in_value * in_value * ((strength + 1) * in_value + strength) + 2); */


// Short version:
var in_value = argument0 * 2;
var strength = argument1 * 1.525;
if (in_value < 1)
return 0.5 * (in_value * in_value * ((strength + 1) * in_value - strength)    );
in_value -= 2;
return 0.5 * (in_value * in_value * ((strength + 1) * in_value + strength) + 2);

