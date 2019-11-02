/// @description tween_elastic_out_input_01(input_value, output_range_min, output_range_max, elasticity);
/// @param input_value
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

//var in_min	= 0;					// -
var in_value	= argument0;			// t
//var in_range	= 1;					// d
var out_min		= argument1;			// b
var out_max		= argument2;			// -
var out_range	= argument2 - out_min;	// c
var elasticity	= argument3;			// -

if (in_value == 0) return out_min;
if (in_value == 1) return out_max;  

var p, s;
p =	0.3 * elasticity;
s =	p / 4;

return (out_range * power(2, -10 * in_value) * sin((in_value - s) * (2 * pi) / p) + out_max); */


// Short version:
if (argument0 == 0) return argument1;
if (argument0 == 1) return argument2;  

var p =	0.3 * argument3;
return ((argument2 - argument1) * power(2, -10 * argument0) * sin((argument0 - (p / 4)) * (2 * pi) / p) + argument2);

