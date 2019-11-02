/// TweenSystemCount(label: "all" "playing" "paused" "stopped")
/// @description Returns count of tweens in system

/// @param ["dataLabel"] (optional)

/// return: real

/*
    INFO:
        Returns total number of tweens in system, excluding those in inactive persistent rooms.
		Can pass optional label in for counting only specific tweens
        
	SUPPORTED DATA LABELS:
        "all"
        "playing"
        "paused"
        "stopped"
*/

if (argument_count == 0)
{
    return ds_list_size(SharedTweener().tweens);
}

var _tweens = SharedTweener().tweens;
var _total = 0;
var _index = -1;

switch(argument[0])
{
    case "all":
        _total = ds_list_size(_tweens);
    break;
    
    case "playing":
        repeat(ds_list_size(_tweens))
        {
            var _tween = _tweens[| ++_index];
            _total += _tween[TWEEN.STATE] >= 0;
        }
    break;
    
    case "paused":
        repeat(ds_list_size(_tweens))
        {
            var _tween = _tweens[| ++_index];
            _total += _tween[TWEEN.STATE] == TWEEN_STATE.PAUSED;
        }
    break;
    
    case "stopped":
        repeat(ds_list_size(_tweens))
        {
            var _tween = _tweens[| ++_index];
            _total += _tween[TWEEN.STATE] == TWEEN_STATE.STOPPED;
        }
    break;
}

return _total;


