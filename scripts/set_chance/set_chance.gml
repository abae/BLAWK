/// @description set_chance(%, value_if_true, value_if_false)
/// @param %
/// @param  value_if_true
/// @param  value_if_false
/*
 * a chance of returning the 1st value, otherwise returns the 2nd value
 * Example use:
 * value = set_chance(10, a, b);
 * // ^ has a 10% chance to set value to a, otherwise value is set to b
 */
if (percent_chance(argument0))
{
    return argument1;
}
else
{
    return argument2;
}
