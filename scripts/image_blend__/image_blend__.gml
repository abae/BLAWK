/// image_blend__(amount,data[col1|col2],target)

// argument0 = amount -- This is a value between 0 and 1.
// argument1 = data -- An array containing start/dest values
// argument2 = target -- The instance being tweened ... not required if a global variable

// Normalized tweens will always return a value between 0 and 1.
// A normalized tween will pass its start/dest value as a data array (argument1)

argument2.image_blend = merge_colour(argument1[0], argument1[1], argument0);


