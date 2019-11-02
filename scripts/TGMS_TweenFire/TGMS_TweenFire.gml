/// TGMS_TweenFire(target,prop,ease,mode,delta,delay,dur,start,dest,[...])
//  REQUIRED - Don't delete!
//  Don't call this directly!

/// @description Base script for TweenFire* scripts -- DO NOT USE DIRECTY!!

/// @param target	instance to associate with tween (id or object index)
/// @param prop		property setter string or TP*() script
/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
/// @param delay	amount of time to delay tween before playing
/// @param dur		duration of time to play tween
/// @param start	starting value for eased property
/// @param dest		destination value for eased property
/// @param [...]	(optional) For extended properties

// RETURNS: tween id

var _t = global.TGMS_TweenDefault;    // Get detault tween
var _tID = ++global.TGMS_INDEX_TWEEN; // Get new tween id
var _property;

_t[TWEEN.ID] = _tID                         // Assign new tween id
_t[TWEEN.TARGET] = argument[0];             // Set target to instance
_t[TWEEN.EASE] = argument[2];               // Set tween's ease algorithm
_t[TWEEN.MODE] = argument[3];               // Set tween play mode
_t[TWEEN.DELTA] = argument[4];              // Set delta
_t[TWEEN.DURATION] = argument[6];           // Set tween's duration
_t[TWEEN.START] = argument[7];              // Set start value
_t[TWEEN.CHANGE] = argument[8]-argument[7]; // Calculate change value (dest-start)

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

if (argument[5] <= 0) // If no delay set  
{ 
    _t[TWEEN.STATE] = _t[TWEEN.TARGET]; // Set tween state as playing
    script_execute(_property, _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]); // Update property to start value
}
else // Delay is set
{
    _t[TWEEN.STATE] = TWEEN_STATE.DELAYED; // Set state as delayed
    _t[TWEEN.DELAY] = argument[5]; // Assign delay list reference to tween
    _t[TWEEN.DELAY_START] = argument[5]; // Set starting delay time
    ds_list_add(SharedTweener().delayedTweens, _t); // Add tween to global delayed list   
}

ds_list_add(SharedTweener().tweens, _t); // Add tween to global tweens list
global.TGMS_MAP_TWEEN[? _tID] = _t; // Associate tween with global id
return _tID; // Return tween id
