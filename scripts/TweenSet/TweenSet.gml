/// @ description Sets the data type for the selected tween[s]

/// TweenSet(tween[s], dataLabel, value, [...])
/// @param tween[s]		tween id[s]
/// @param dataLabel	data "label" string
/// @param value		value to apply to set data type
/// @param [...]		(optional) additional values for modifying multi-property tweens

/*
    Supported Data Labels:
        "group"         -- Group which tween belongs to
        "time"          -- Current time of tween in steps or seconds
        "time_amount"   -- Sets the tween's time by a relative amount between 0.0 and 1.0 
        "time_scale"    -- How fast a tween updates : Default = 1.0
        "duration"      -- How long a tween takes to fully animate in steps or seconds
        "ease"          -- The easing algorithm used by the tween
        "mode"          -- The play mode used by the tween (ONCE, BOUNCE, PATROL, LOOP
        "target"        -- Target instance associated with tween
        "delta"         -- Toggle timing between seconds(true) and steps(false)
        "delay"         -- Current timer of active delay
        "delay_start"   -- The starting duration for a delay timer
        "start"         -- Start value of the property or properties
        "destination"   -- Destination value of the property or properties
        "property"      -- Property or properties effected by the tween
        
        e.g.
            tween = Tween(id, EaseLinear, 0, true, 0, 1, "x", 0, 100);
            TweenSet(tween, "duration", 2.5);
            
    *** The following labels can update multiple properties by supplying
		values in the same order the properties were first assigned:
        
        "start"
        "destination"
        "property"
        
        e.g.
            tween = Tween(id, EaseLinear, 0, true, 0, 1, "x", 0, 100, "y", 0, 100); // multi-property tween (x/y)
            TweenSet(tween, "start", mouse_x, mouse_y); // update to x/y mouse coordinates
           
    // The keyword [undefined] can be used to leave a property value unchanged
        e.g.
            TweenSet(tween, "start", undefined, mouse_y); // update "y" but leave "x" unchanged
*/

var _t = argument[0];

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

var _index = global.TGMS_TweenDataIndexes[? argument[1]];

if (is_array(_t))
{   
    switch(_index)
    {
        case TWEEN.TIME_SCALE:
            _t[@ TWEEN.TIME_SCALE] = argument[2] * _t[TWEEN.DIRECTION];
        break;
        
        case TWEEN.TIME:
        case TWEEN.EASE:
            _t[@ _index] = argument[2];
            TweenForcePropertyUpdate(_t);
        break;
        
        case TWEEN.TIME_AMOUNT:
            _t[@ TWEEN.TIME] = _t[TWEEN.DURATION] * argument[2];
            TweenForcePropertyUpdate(_t);
        break;
         
        case TWEEN.DELAY:
            if (_t[TWEEN.DELAY] > 0)
            {
                _t[@ TWEEN.DELAY] = argument[2];
            }
        break;
        
        case TWEEN.START:
            var _currentProperty = _t[TWEEN.PROPERTY];

            if (_currentProperty == TGMS_MultiPropertySetter__)
            {
                var _data = _t[TWEEN.DATA];
                var _argIndex = 0;
                
                repeat(argument_count-2)
                {
                    var _dataIndex = 2 + 5*_argIndex; // Note: first index is property count
                    var _start = argument[++_argIndex+1];
                    
                    if (!is_undefined(_start))
                    {
                        _data[@ _dataIndex] = _start;
                    }
                }
            }
            else
            {
                var _start = argument[2];
                
                if (!is_undefined(_start))
                {
                    var _dest = _t[TWEEN.START] + _t[TWEEN.CHANGE];
                    _t[@ TWEEN.START] = _start; // store raw property
                    _t[@ TWEEN.CHANGE] = _dest - _start;
                }
            }
        break;
        
        case TWEEN.DESTINATION:
            var _currentProperty = _t[TWEEN.PROPERTY];

            if (_currentProperty == TGMS_MultiPropertySetter__)
            {
                var _data = _t[TWEEN.DATA];
                var _argIndex = 0;
                
                repeat(argument_count-2)
                {
                    var _dataIndex = 3 + 5*_argIndex; // Note: first index is property count
                    var _dest = argument[++_argIndex+1];
                    
                    if (!is_undefined(_dest))
                    {
                        _data[@ _dataIndex] = _dest;
                    }
                }
            }
            else
            {
                var _dest = argument[2];
                
                if (!is_undefined(_dest))
                {
                    _t[@ TWEEN.CHANGE] = _dest -_t[TWEEN.START];
                }
            }
        break;
        
        case TWEEN.TARGET:
            if (_t[TWEEN.TARGET] != noone)
            {
                var _target = argument[2].id;
                _t[@ TWEEN.TARGET] = _target;
                
                if (_t[TWEEN.STATE] >= 0)
                {
                    _t[@ TWEEN.STATE] = _target; // active state
                }
                
                if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
                {
                    var _data = _t[TWEEN.DATA];
                    var _argIndex = -1;
                    
                    repeat((array_length_1d(_data)-1) div 5)
                    {
                        var _dataIndex = ++_argIndex*5; // Note: first index is property count
                        
                        if (is_real(_data[_dataIndex+5]))
                        {   // Raw Property
                            _data[@ _dataIndex+4] = _target; // Override data with target id
                        }
                    }
                }
                else
                {
                    if (is_real(_t[TWEEN.PROPERTY_RAW])){
                        _t[@ TWEEN.DATA] = _target;
                    }
                }
            }
        break;
        
        case TWEEN.PROPERTY:
            var _currentProperty = _t[TWEEN.PROPERTY];

            if (_currentProperty == TGMS_MultiPropertySetter__)
            {
                var _data = _t[TWEEN.DATA];
                var _argIndex = 0;
                repeat(argument_count-2)
                {
                    var _dataIndex = 1 + _argIndex*5; // Note: first index is property count
                    var _property = argument[++_argIndex+1];
                    
                    // :: Need to normalize
                    
                    if (!is_undefined(_property))
                    {
                        if (is_array(_property))
                        {   // Extended Property
                            _data[@ _dataIndex] = _property[0] // script
                            _data[@ _dataIndex+4] = _property[1]; // data
                        }
                        else // is string
                        {  
                            // Get raw property setter script
                            var _propRaw = global.__PropertySetters__[? _property];
                            _data[@ _dataIndex] = _propRaw; // script
                            _data[@ _dataIndex+4] = _propRaw; // data
                        }  
                    }
                }
            }
            else
            {
                var _property = argument[2];
                _t[@ TWEEN.PROPERTY_RAW] = _property; // store raw property
                
                if (is_real(_property))
                { // Standard property
                    _t[@ TWEEN.PROPERTY] = _property; // script
                    _t[@ TWEEN.DATA] = _t[TWEEN.TARGET]; // data
                }  
                else
                if (is_array(_property))
                { // Extended Property
                    _t[@ TWEEN.DATA] = _property[1]; // script
                    _t[@ TWEEN.PROPERTY] = _property[0]; // data
                }
            }
        break;
        
        default:
           _t[@ _index] = argument[2];
    }
}

if (is_string(_t))
{
    switch(argument_count)
    {
        case 3: TGMS_TweensExecute(_t, TweenSet, _index, argument[2]); break;
        case 4: TGMS_TweensExecute(_t, TweenSet, _index, argument[2], argument[3]); break;
        case 5: TGMS_TweensExecute(_t, TweenSet, _index, argument[2], argument[3], argument[4]); break;
        case 6: TGMS_TweensExecute(_t, TweenSet, _index, argument[2], argument[3], argument[4], argument[5]); break;
        case 7: TGMS_TweensExecute(_t, TweenSet, _index, argument[2], argument[3], argument[4], argument[5], argument[6]); break;
        case 8: TGMS_TweensExecute(_t, TweenSet, _index, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7]); break;
    }
}




