/// @description Finishes the selected tween[s]

/// TweenFinish(tween[s],call_event)
/// @param tween[s]		tween id
/// @param call_event	execute FINISH EVENT callbacks?

// RETURNS: null tween id

/*      
    INFO:
        Finishes the specified tween, updating it to its destination.
        DOES NOT affect tweens using PATROL|LOOP|REPEAT play modes.
*/

var _t = argument0;

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t)){
    if (_t[TWEEN.DELAY] > 0)
    {
        return 0;
    }
    
    if (_t[TWEEN.STATE] >= 0 or _t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
    {
        switch(_t[TWEEN.MODE])
        {
            case TWEEN_MODE_ONCE:
                _t[@ TWEEN.TIME] = _t[TWEEN.DURATION]; // Update tween's time
            break;
               
            case TWEEN_MODE_BOUNCE:
                _t[@ TWEEN.TIME] = 0; // Update tween's time
            break;
            
            default:
                return 0;
        }
        
        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED; // Set tween state as STOPPED
        
        // Update property with start value
        script_execute(_t[TWEEN.PROPERTY], _t[TWEEN.START] + _t[TWEEN.CHANGE]*(_t[TWEEN.TIME] > 0), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
        
        // Execute finish event IF set to do so
        if (argument1)
        {
            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH);
        }
        
        // IF tween is set to be destroyed
        if (_t[TWEEN.DESTROY])
        {
            TweenDestroy(_t);
        }
    }
}

if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenFinish, argument1);
}


