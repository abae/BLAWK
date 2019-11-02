/// TGMS_BuildProperty("label",setter,getter)
/// @description Prepares a property to be optimised for TweenGMS

/// @param "label"		string to associate with property
/// @param setter		setter script to associate with property
/// @param getter		getter script to associate with property

var _label = argument[0];
var _setter = argument[1];

global.__PropertySetters__[? _label] = _setter;
global.__PropertySetters__[? _setter] = _setter;

if (argument_count == 3)
{
    var _getter = argument[2];
    global.__PropertySetters__[? _getter] = _setter;
    
    if (is_undefined(_getter))
    {
        global.__PropertyGetters__[? _label] = TGMS_NULL__;
        global.__PropertyGetters__[? _setter] = TGMS_NULL__;
        global.__PropertyGetters__[? _getter] = TGMS_NULL__;
    }
    else
    {
        global.__PropertyGetters__[? _label] = _getter;
        global.__PropertyGetters__[? _setter] = _getter;
        global.__PropertyGetters__[? _getter] = _getter;
    }
}
else
{
    global.__PropertyGetters__[? _label] = _setter;
    global.__PropertyGetters__[? _setter] = _setter;   
}



