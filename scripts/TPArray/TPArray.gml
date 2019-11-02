/// TPArray(array,x,[y])

/// @param array
/// @param x
/// @param [y]		(optional)

var _return, _data;

_data[0] = argument[0];
_data[1] = argument[1];  

if (argument_count == 2){
    _return[0] = ext_Array1D__;    
}
else{
    _return[0] = ext_Array2D__;
    _data[2] = argument[2];
}

_return[1] = _data;
return _return;

