/// @description tween_elastic_out_ext(input_value, input_range_min, input_range_max, output_range_min, output_range_max, elasticity);
/// @param input_value
/// @param input_range_min
/// @param input_range_max
/// @param output_range_min
/// @param output_range_max
/// @param elasticity
/*
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This script remaps/tweens an input value from an input range to an output range
in an "elastic out" fashion: fast -> elastic

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

elasticity			How fast/often the output value moves around output_range_max
					Usually 0.3 (very fast) up to 2.0 (very slow) looks good

returns				the input_value remapped to the output_range
					so basically out_value
_____________________________________________________________________________*/

/* original version:
t/=d;
if (t==0) return b; if (t==1) return b+c;  
p =	d*.3 * e;
a =	c; 
s =	p/4;
return (a*power(2,-10*t) * sin( (t*d-s)*(2*pi)/p ) + c + b); */


/* Long version:
var in_min		= argument1;			// -
var in_value	= argument0 - in_min;	// t
var in_range	= argument2 - in_min;	// d
var out_min		= argument3;			// b
var out_max		= argument4;			// -
var out_range	= out_max - out_min;	// c
var elasticity	= argument5;			// -

in_value /= in_range;
if (in_value == 0) return out_min;
if (in_value == 1) return out_max;  

var a, p, s;
p =	in_range * 0.3 * elasticity;
a =	out_range; 
s =	p / 4;

return (a * power(2, -10 * in_value) * sin((in_value * in_range - s) * (2 * pi) / p) + out_max); */


// Short version:
var in_range	= argument2 - argument1;
var in_value	= (argument0 - argument1) / in_range;
var p			= in_range * 0.3 * argument5;

if (in_value == 0) return argument3;
if (in_value == 1) return argument4;  
return ((argument4 - argument3) * power(2, -10 * in_value) * sin((in_value * in_range - (p / 4)) * (2 * pi) / p) + argument4);

