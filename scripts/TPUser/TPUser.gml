/// TPUser(event,[...])

/// @param event      User event to use as a property
/// @param [...]      (Optional) Extra data to pass to user event. Accessible via TWEEN_USER_DATA in user event
/*
	[EXAMPLE 1] --> Use user event as tween property
		[SOME EVENT]
		// Fire a tween using TPUser as the property
		TweenFire(id, EaseLinear, 0, true, 0, 1.0, TPUser(0), 0, 100);
		
		[USER EVENT 0]
		// Update value in user event 0
		TWEEN_USER_TARGET.someValue = TWEEN_USER_VALUE;
		
	[EXAMPLE 2] --> Have extended data passed to user event
		[SOME EVENT]
		// Fire a tween using TPUser as the property with extra data
		TweenFire(id, EaseLinear, 0, true, 0, 1.0, TPUser(1, c_white, c_red), 0, 1);
		
		[USER EVENT 1]
		var _target = TWEEN_USER_TARGET;
		var _value = TWEEN_USER_VALUE;
		var _data = TWEEN_USER_DATA; // This will contain c_white/c_red values
		_target.image_blend = merge_colour(_data[0], _data[1], _value);	
		
	[EXAMPLE 3] --> How to set up a user event to support TweenFireTo/From()
		[SOME EVENT]
		// Fire a tween using TPUser as the property
		TweenFireTo(id, EaseLinear, 0, true, 0, 1.0, TPUser(2), 100);
		
		[USER EVENT 0]
		// User Event 2
		if (TWEEN_USER_GET) // Getter
		{   
		    TWEEN_USER_GET = TWEEN_USER_TARGET.someVariable;
		}
		else // Setter
		{   
		    TWEEN_USER_TARGET.someVariable = TWEEN_USER_GET;
		}
*/

var _return;
_return[0] = ext_PropUser__;

if (argument_count == 1)
{    
    _return[1] = ev_user0+argument[0];
}
else // Extended Data
{
    var _args;
    var i = -1;
    repeat(argument_count-1)
    {
        ++i;
        _args[i] = argument[i+1];
    }
    
    var _data;
    _data[0] = ev_user0+argument[0];
    _data[1] = _args;
    _return[1] = _data;
}

return _return;
