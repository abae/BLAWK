/// @description string_split(substr, str, ignoreEmptyStrings)
/// @param substr
/// @param  str
/// @param  ignoreEmptyStrings
//
// Script:      Splits the str on the given substring and returns an array
// Date:        2018-07-21
// Copyright:   Appsurd
//
// Arguments:
// Argument0: the substring to cut on
// Argument1: the whole string
// Argument2: ignore empty arrays (true) or (false)

var substr = argument0;
var str = argument1;
var substrl = string_length(substr);
var slot = 0;
var d_pos = 0; // Position for loop
var array_sample; // Initialise total array
var d_count = string_count(substr, str); // How many values within string

str += substr; // Add the substr extra to the end of str

for(var i=0; i<=d_count; i++)
{
    d_pos = string_pos(substr, str)+(substrl-1); // End position of current value
    var copy = string_copy(str, 1, d_pos-substrl); 
    if copy != "" or argument2 = false then array_sample[i-slot] = copy; // Copy string section to array
    else slot++; // Except if argument2 was set to true
    str = string_delete(str, 1, d_pos); // Delete string section from original sample
}

return array_sample;
