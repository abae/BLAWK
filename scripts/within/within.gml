/// @description within(variable, value, within)
/// @param variable
/// @param  value
/// @param  within
/*
 * Returns true if the given variable is close enough
 * to the given value (within a certain number)
 */
var a = argument0;
var b = argument1;
var c = argument2/2;
return (a > b-c and a < b+c);
