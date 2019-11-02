/// TGMS_TweensExecute(tweens_string,script,arg0,...)
/*
    @tweens         Tweens to select for performing script (0=TWEENS_ALL, 1=TWEENS_GROUP, 2=TWEEN_TARGET)
    @data           Relevant group or target when using TWEENS_GROUP or TWEENS_TARGET -- not important when using TWEENS_ALL
    @script         Script to execute for each tween
    @arg0...        (optional) Arguments to pass to executed script (up to 3)
    
    return:
        na
        
    INFO:
        Iterates through all relevant tweens and executes a specified script for each.
        The following macros can be used for selecting tweens:
        
        0 = TWEENS_ALL
        1 = TWEENS_GROUP
        2 = TWEENS_TARGET
        
        Currently takes only a max of 3 optional arguments.
        
    Example:
        // Execute 'TweenStop' for all tweens, including those with deactivated targets
        TweensExecute(TWEENS_ALL, 0, TweenStop);
        
        // Execute 'TweenPause' with tweens belonging to group 2
        TweensExecute(TWEENS_GROUP, 2, TweenPause)
        
        // Execute 'TweenSetTime' for tweens associated with obj_Jumpy
        TweensExecute(TWEENS_TARGET, obj_Jumpy, TweenSetTime, 2.0);
*/

var _tweensString = argument[0];
var _selection = real(string_char_at(_tweensString,1));
var _selectionData = real(string_delete(_tweensString,1,1));
var _script = argument[1];
var _argCount = argument_count-2;
var _arg0,_arg1,_arg2;

switch(_argCount)
{
    case 3: _arg2 = argument[4];
    case 2: _arg1 = argument[3];
    case 1: _arg0 = argument[2];
}

var _tIndex = -1;

switch(_selection)
{
    case 0:
        var _tweens = ds_stack_pop(global.TGMS_TweensStack);
        
        switch(_argCount)
        {
            case 0:
                repeat(array_length_1d(_tweens)){
                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t);   
                }
            break;
            case 1:
                repeat(array_length_1d(_tweens)){
                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0);   
                }
            break;
            case 2:
                repeat(array_length_1d(_tweens)){
                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1);   
                }
            break;
            case 3:
                repeat(array_length_1d(_tweens)){
                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1, _arg2);   
                }
            break;
        }
    break;
    
    case TWEENS_ALL:
        var _tweens = SharedTweener().tweens;
        
        switch(_argCount)
        {    
        case 0:
            repeat(ds_list_size(_tweens)){  
                var _t = _tweens[| ++_tIndex];
                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t);
            }
        break;
        case 1:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0);
            }
        break;
        case 2:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1);
            }
        break;
        case 3:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1, _arg2);
            }
        break;
        }
    break;
    
    case TWEENS_GROUP:
        var _tweens = SharedTweener().tweens;
        
        switch(_argCount)
        {    
        case 0:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                if (_t[TWEEN.GROUP] == _selectionData and TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t);
            }
        break;
        case 1:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                if (_t[TWEEN.GROUP] == _selectionData and TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0);
            }
        break;
        case 2:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                if (_t[TWEEN.GROUP] == _selectionData and TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1);
            }
        break;
        case 3:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                if (_t[TWEEN.GROUP] == _selectionData and TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1, _arg2);
            }
        break;
        }
    break;
    
    case TWEENS_TARGET:
        var _tweens = SharedTweener().tweens;
        
        switch(_argCount)
        {    
        case 0:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                var _target = _t[TWEEN.TARGET];
				
				if (TGMS_TargetExists(_target)) 
				if (_target == _selectionData or _target.object_index == _selectionData or object_is_ancestor(_target.object_index, _selectionData)){
					script_execute(_script, _t);
				}
            }
        break;
        case 1:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                var _target = _t[TWEEN.TARGET];
                
				if (TGMS_TargetExists(_target)) 
				if (_target == _selectionData or _target.object_index == _selectionData or object_is_ancestor(_target.object_index, _selectionData)){
                    script_execute(_script, _t, _arg0);
                }
            }
        break;
        case 2:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                var _target = _t[TWEEN.TARGET];
                
				if (TGMS_TargetExists(_target)) 
				if (_target == _selectionData or _target.object_index == _selectionData or object_is_ancestor(_target.object_index, _selectionData)){
                    script_execute(_script, _t, _arg0, _arg1);
                }
            }
        break;
        case 3:
            repeat(ds_list_size(_tweens)){
                var _t = _tweens[| ++_tIndex];
                var _target = _t[TWEEN.TARGET];
                
				if (TGMS_TargetExists(_target)) 
				if (_target == _selectionData or _target.object_index == _selectionData or object_is_ancestor(_target.object_index, _selectionData)){
                    script_execute(_script, _t, _arg0, _arg1, _arg2);
                }
            }
        break;
        }
    break;
}

