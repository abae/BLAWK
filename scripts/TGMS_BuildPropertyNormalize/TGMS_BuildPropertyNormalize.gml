/// TGMS_BuildPropertyNormalize("label",setter,getter)
/// @description Prepares a normalized property to be usable by TweenGMS

/// @param "label"		string to associate with property
/// @param setter		setter script to associate with property
/// @param getter		getter script to assocaite with property

/*
	Info:
		Normalized property scripts receive an eased value between 0 and 1
		with additional data passed for the start/dest values.
		See image_blend__ script for an example.
*/


if (argument_count == 3)
{
    TGMS_BuildProperty(argument[0], argument[1], argument[2]);

    global.__NormalizedProperties__[? argument[0]] = 1;
    global.__NormalizedProperties__[? argument[1]] = 1;
    global.__NormalizedProperties__[? argument[2]] = 1;
}
else
{
    TGMS_BuildProperty(argument[0], argument[1], argument[1]);

    global.__NormalizedProperties__[? argument[0]] = 1;
    global.__NormalizedProperties__[? argument[1]] = 1;  
}
