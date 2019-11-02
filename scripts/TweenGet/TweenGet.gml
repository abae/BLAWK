/// @description Returns data type for the selected tween

/// TweenGet(tween, dataLabel)
/// @param tween		tween id
/// @param dataLabel	data "label" string -- see script details

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
            tween = TweenFire(id, EaseLinear, 0, true, 0, 1, "x", 0, 100);
            duration = TweenGet(tween, "duration");
            
    ***	The following labels can return multiple values as an array for multi-property tweens:
        
			"start"    
			"destination"
			"property"
        
        e.g.
            tween = TweenFire(id, EaseLinear, 0, true, 0, 1, "x", 0, 100, "y", 0, 100);
            startValues = TweenGet(tween, "start");
            xStart = startValues[0];
            yStart = startValues[1];
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) return undefined;

var _index = global.TGMS_TweenDataIndexes[? argument1];

switch(_index)
{
    case TWEEN.PROPERTY:
        if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
        {
            var _return;
            var _data = _t[TWEEN.DATA];
            var _dataIndex = -1;
            
            repeat(array_length_1d(_data) div 5)
            {
                ++_dataIndex;
                _return[_dataIndex] = _data[5 + 5*_dataIndex];
            }
            
            return _return;
        }
        else
        {
            return _t[TWEEN.PROPERTY_RAW];
        }
    break;
    
    case TWEEN.DESTINATION:
        if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
        {
            var _return;
            var _data = _t[TWEEN.DATA];
            var _dataIndex = -1;
            
            repeat(array_length_1d(_data) div 5)
            {
                ++_dataIndex;
                _return[_dataIndex] = _data[3 + 5*_dataIndex];
            }
            
            return _return;
        }
        else
        {
            return _t[TWEEN.START] + _t[TWEEN.CHANGE];
        }
    break;
    
    case TWEEN.START:
        if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
        {
            var _return;
            var _data = _t[TWEEN.DATA];
            var _dataIndex = -1;
            
            repeat(array_length_1d(_data) div 5)
            {
                ++_dataIndex;
                _return[_dataIndex] = _data[2 + 5*_dataIndex];
            }
            
            return _return;
        }
        else
        {
            return _t[TWEEN.START];
        }
    break;
    
    case TWEEN.DELAY:
        var _delay = _t[TWEEN.DELAY];

        if (_delay <= 0) { return 0; }
        else             { return _delay; }
    break;
    
    case TWEEN.TIME_SCALE:
        return _t[TWEEN.TIME_SCALE] * _t[TWEEN.DIRECTION];
    break;
    
    default: // Directly access tween index
        return _t[_index]
}


