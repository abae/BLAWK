/// TGMS_FetchTween(tween_id)

if (ds_map_exists(global.TGMS_MAP_TWEEN, argument0))
{
    return global.TGMS_MAP_TWEEN[? argument0];
}

if (is_undefined(argument0))
{
    return undefined;
}

// Show "invalid tween id" error message
show_error(@"!!! INVALID TWEEN ID !!!
" ,false);


