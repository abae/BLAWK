/// TPExt(property,arg0,...)

/// @description Prepares an extended property script with custom arguments

/// @param property		property script
/// @param arg0			argument to pass to extended property scripts
/// @param ...			additional arguments to pass to extended property scripts

var _property = argument[0];

if (argument_count > 2)
{
    var _args;
    var _iArg = -1;
    repeat(argument_count-1)
    {
        ++_iArg;
        _args[_iArg] = argument[_iArg+1];
    }
    
    var _return;
    _return[0] = argument[0];
    _return[1] = _args;
    return _return; 
}
else
{
    var _return;
    _return[0] = argument[0];
    _return[1] = argument[1];
    return _return;
}


