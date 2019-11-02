/// @description Returns calculated value using a tween's state at a set time

/// TweenCalcTime(tween,time)
/// @param tween	tween id
/// @param time		specific time in steps or seconds

/// return: real

/*      
    INFO:
        Returns a calculated value using a tween's current state
        at a specified point in time.
        
        Note: Useful with null property setters which can be set by
        using TPNull() as the property argument.
        
    EXAMPLE:
        // Create defined tween
        tween = TweenCreate(id, EaseInOutQuint, 0, true, 0.0, 2.5, TPNull(), x, mouse_x);
        
        // Calculate value of tween at 1.5 seconds through time
        x = TweenCalcAmount(tween, 1.5);
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)){
    return 0;
}

var _duration = _t[TWEEN.DURATION];

if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
{
    var _return;
    var _data = _t[TWEEN.DATA];
    var _dataIndex = -1;
    var _amount = script_execute(_t[TWEEN.EASE], argument1, 0, 1, _t[TWEEN.DURATION]);
    
    repeat(array_length_1d(_data) div 5)
    {
        ++_dataIndex;
        var _start = _data[2 + 5*_dataIndex];
        var _dest =  _data[3 + 5*_dataIndex];
        
        // Return start if duration is invalid
        if (_duration == 0){
            _return[_dataIndex] = _start;
        }
        else{
            _return[_dataIndex] = lerp(_start, _dest, _amount);
        }
    }
    
    return _return;
}
else
{
    // Return start if duration is invalid
    if (_duration == 0){
        return _t[TWEEN.START];
    }

    // Return tween's calculated value for its current state
    return script_execute(_t[TWEEN.EASE], clamp(argument1, 0, _duration), _t[TWEEN.START], _t[TWEEN.CHANGE], _duration);
}


