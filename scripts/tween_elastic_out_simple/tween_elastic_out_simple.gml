/// @description tween_elastic_out_simple(input_value, elasticity);
/// @param input_value
/// @param elasticity
/*
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This script remaps/tweens an input value from an input range of 0 to 1
to an output range of 0 to 1 in an "elastic out" fashion: fast -> elastic

input_value			The value to remap
					could i.e. be a timers current value
					
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
//var in_min	= 0;			// -
var in_value	= argument0;	// t
//var in_range	= 1;			// d
//var out_min	= 0;			// b
//var out_max	= 1;			// -
//var out_range	= 1;			// c
var elasticity	= argument1;	// -

if (in_value == 0) return 0;
if (in_value == 1) return 1;  

var p, s;
p =	0.3 * elasticity;
s =	p / 4;

return (power(2, -10 * in_value) * sin((in_value - s) * (2 * pi) / p) + 1); */


// Short version:
if (argument0 == 0) return 0;
if (argument0 == 1) return 1;  
var p =	0.3 * argument1;
return (power(2, -10 * argument0) * sin((argument0 - (p / 4)) * (2 * pi) / p) + 1);

