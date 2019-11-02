/// @description multi_chance(value1, chance1, value2, chance2, ..., [default_value])
/// @param value1
/// @param  chance1
/// @param  value2
/// @param  chance2
/// @param  ...
/// @param  [default_value]
/*
 * a different chance of returning each value
 * Example use:
 * value = set_chance(a, 10, b, 20, c, 40, d);
 * // ^ has a certain chance of returning a, b or c, and if not it returns d
 * (the final argument, default value, is optional)
 */
var count = argument_count; //get the number of arguments

//Loop through the arguments, adding values and chances to an array
var i = 0;
while (count > 1)
{
    value[i] = argument[i*2];
    _chance[i] = argument[i*2+1];
    i++; //add to the number of values
    count -= 2; //remove 2 from the total argument count (2 arguments per value)
}
var total = i;

//Find out if there's a default value
var default_value = 0;
if (count == 1) //if there's 1 argument left, that is the default value
{
    default_value = argument[i*2];
}

//Default the final value to the default value (which is 0 if there's no default value)
var final_value = default_value;
//Get a random value
//var rand = random(100);
var current = 0;
//Loop through the values, checking if the random value satisfies that value
for (var i = 0; i < total; i++)
{
    current += _chance[i];
    if (rand < current)
    {
        final_value = value[i];
        break;
    }
}

//Return the final value
return final_value;

