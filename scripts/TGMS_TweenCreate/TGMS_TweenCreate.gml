//  Required by TweenCreate*()
//  Don't call this directly!

/// @description Create a tween to be started with TweenPlay*() (not auto-destroyed)

/// @param target	instance to associate with tween (id or object index)
/// @param [prop	property setter string or TP*() script
/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
/// @param delay	amount of time to delay tween before playing
/// @param dur		duration of time to play tween
/// @param start	starting value for eased property
/// @param dest		destination value for eased property
/// @param ...]		(optional) additional properties ("direction", 0, 360)

// RETURNS: tween id

/*
	Creates and returns a new tween. The tween does not start right away, but must
	be played with the TweenPlay*() scripts.
	Unlike TwenFire*(), tweens created with TweenCreate() will exist in memory until their
	target instance is destroyed or TweenDestroy(tween) is called.
	You can set them to auto-destroy with TweenDestroyWhenDone():
	
	Defining a tween at creation is optional. Both of the following are valid:
		tween1 = TweenCreate(id);
		tween2 = TweenCreate(id, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
		
		TweenDestroyWhenDone(tween2, true); // Have tween auto-destroy when finished
*/

var _tID = ++global.TGMS_INDEX_TWEEN; // Get new unique tween id
var _t = global.TGMS_TweenDefault;
var _property;

_t[TWEEN.ID] = _tID; // Store tween index handle inside tween -- creates new array from copy
_t[TWEEN.TARGET] = argument[0].id; // Set tween target
_t[TWEEN.DESTROY] = 0; // Make persistent

// Set tween property
if (argument_count > 1)
{   
    _t[TWEEN.EASE] = argument[2];
    _t[TWEEN.MODE] = argument[3];
    _t[TWEEN.DELTA] = argument[4];
    _t[TWEEN.DELAY_START] = argument[5];
    _t[TWEEN.DURATION] = argument[6];
    _t[TWEEN.START] = argument[7];
    _t[TWEEN.CHANGE] = argument[8]-argument[7];
          
    if (argument_count == 9) // Regular property
	{
	    _property = argument[1];
	    _t[TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	
		if (is_string(_property)) // Dynamic Property
		{
			_t[TWEEN.VARIABLE] = _property;
		
			if (variable_instance_exists(_t[TWEEN.TARGET], _property))
			{
				_t[TWEEN.PROPERTY] = TGMS_Variable_Instance_Set; // Set tween's property setter script
				_property = TGMS_Variable_Instance_Set;
			}
			else
			{
				_t[TWEEN.PROPERTY] = TGMS_Variable_Global_Set;
				_property = TGMS_Variable_Global_Set;
			}
		}
		else // Optimised property
		{
			_t[TWEEN.PROPERTY] = _property;     // Set tween's property setter script
		}
    
	    _t[TWEEN.DATA] = argument[0];       // Set tween's data as target id
	}
	else // Extended property
	{
	    _property[0] = argument[1]; // Set extended property setter script
	    _property[1] = argument[9]; // override target data with data
	    _t[TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	    _t[TWEEN.DATA] = _property[1];  // Set tween's data to extended arguments
	    var _script = _property[0];     // Cache script to use as property setter
	    _property = _script;            // Update cached property setter
	    _t[TWEEN.PROPERTY] = _script;   // Set tween's property setter script   
	}
}

global.TGMS_MAP_TWEEN[? _tID] = _t; // Assign tween handle to map
ds_list_add(SharedTweener().tweens, _t); // Add new tween to tweening list
return _tID; // Return unique tween id
