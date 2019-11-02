/// TGMS_ClearRoom(room)
/*
    @room = persistent room
    
    return:
        na

    INFO:
        Clears persistent room's stored tween data
*/

var _sharedTweener = SharedTweener();
var _simpleTweens = _sharedTweener.simpleTweens;
var _pRoomTweens = _sharedTweener.pRoomTweens;
var _pRoomDelays = _sharedTweener.pRoomDelays;
var _key = argument0;

// Clear all rooms if "all" keyword is used
if (_key == all)
{
	repeat(ds_map_size(_pRoomTweens))
	{
		TGMS_ClearRoom(ds_map_find_first(_pRoomTweens));
	}
	
	return 0;
}

// Destroy tweens for persistent room
if (ds_map_exists(_pRoomTweens, _key))
{
    // Delete stored delays
    ds_queue_destroy(ds_map_find_value(_pRoomDelays, _key));
    ds_map_delete(_pRoomDelays, _key)
    
    // Get stored tweens queue
    var _queue = ds_map_find_value(_pRoomTweens, _key);
    
    // Destroy all stored tweens in queue
    repeat(ds_queue_size(_queue))
    {
        var _t = ds_queue_dequeue(_queue);                  // Get next tween from room's queue
        
        // Invalidate tween handle
        if (ds_map_exists(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]))
        {
            ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]);
        }
        
        _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
        _t[@ TWEEN.ID] = undefined; // Nullify self reference
        
        // Destroy tween events if events map exists
        if (_t[TWEEN.EVENTS] != -1)
        {
            var _events = _t[TWEEN.EVENTS];        // Cache events
            var _key = ds_map_find_first(_events); // Find key to first event
            
            // Cycle through and destroy all events
            repeat(ds_map_size(_events))
            {
                ds_list_destroy(_events[? _key]);       // Destroy event list
                _key = ds_map_find_next(_events, _key); // Find key for next event
            }
            
            ds_map_destroy(_events); // Destroy events map
        }
    }
    
    ds_queue_destroy(_queue);          // Destroy room's queue for stored tweens
    ds_map_delete(_pRoomTweens, _key); // Delete persistent room id from stored tweens map
}


