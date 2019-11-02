/// @description Manually destroys the selected tween[s]

/// TweenDestroy(tween[s])
/// @param tween[s] tween id[s]

/// RETURNS: null tween id

/*
    Note: Tweens are always automatically destroyed when their target instance is destroyed.
*/

var _t = argument0;

if (is_real(_t))
{
    _t = TGMS_FetchTween(_t);
}

if (is_array(_t))
{
    if (_t[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
    {
        return undefined;
    }
    
    // Invalidate tween handle
    if (ds_map_exists(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]))
    {
        ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]);
    }
    
    _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
    _t[@ TWEEN.ID] = undefined; // Nullify self reference
    
    // Invalidate tween target or destroy target instance depending on destroy mode
    if (_t[TWEEN.DESTROY] != 2)
    { 
        _t[@ TWEEN.TARGET] = noone; // Invalidate target instance
    }
    else
    { // Destroy Target Instance
        var _target = _t[TWEEN.TARGET]; // Get target to destroy
        
        if (instance_exists(_target))
        {
            with(_target) instance_destroy();
        }
        else
        {
            instance_activate_object(_target); // Attempt to activate target by chance it was deactivated
            with(_target) instance_destroy(); // Attempt to destroy target
        } 
    }
    
    return undefined;
}

if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenDestroy);
}

return undefined;


