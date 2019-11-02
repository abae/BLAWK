/// @description Safely destroys a tween without error, even if it doesn't exist

/// TweenDestroySafe(tween[s])
/// @param	tween[s] tween id(s)

// RETURNS: null tween id

var _t = argument0;

if (is_array(_t))
{
    return TweenDestroy(_t);
}

if (is_real(_t))
{
    if (ds_map_exists(global.TGMS_MAP_TWEEN, _t))
    {
        return TweenDestroy(_t);
    }
    
    return undefined;
}

if (is_string(_t))
{
    TGMS_TweensExecute(_t, TweenDestroySafe);
}

return undefined;


