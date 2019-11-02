/// @description round_chance(number)
/// @param number
/*
 * This is a bit of a weird one, but can be useful!
 *
 * Example use:
 * round_chance(1.75)
 *    < this has a 75% chance of returning 2, otherwise returning 1
 *
 * So we're using the decimal as a chance of rounding the number up
 */
var num = argument0;
var _chance = (num-floor(num))*100;
if (percent_chance(_chance))
{
    var count = ceil(num);
}
else
{
    var count = floor(num);
}

return count;
