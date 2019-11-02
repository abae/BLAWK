//  Required by TweenDefine() script
//  Don't call this directly!

/// @description Defines a tween previously created with TweenCreate()

/// @param tween	tween id of previously created tween
/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
/// @param delay	amount of time to delay tween before playing
/// @param dur		duration of time to play tween
/// @param prop		property setter string or TP*() script
/// @param start	starting value for eased property
/// @param dest		destination value for eased property
/// @param ...		(optional) additional properties ("direction", 0, 360)

// RETURNS: na

var _tID = argument[0];

var _t = TGMS_FetchTween(_tID);
if (is_undefined(_t)) { return 0; }

_t[@ TWEEN.TIME] = 0;
_t[@ TWEEN.EASE] = argument[2];
_t[@ TWEEN.MODE] = argument[3];
_t[@ TWEEN.DELTA] = argument[4];
_t[@ TWEEN.DELAY_START] = argument[5];
_t[@ TWEEN.DURATION] = argument[6];
_t[@ TWEEN.START] = argument[7];
_t[@ TWEEN.CHANGE] = argument[8]-argument[7];
      
var _property;
	  
if (argument_count == 9) // Regular property
{
	_property = argument[1];
	_t[@ TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	
	if (is_string(_property)) // Dynamic Property
	{
		_t[@ TWEEN.VARIABLE] = _property;
		
		if (variable_instance_exists(_t[TWEEN.TARGET], _property))
		{
			_t[@ TWEEN.PROPERTY] = TGMS_Variable_Instance_Set; // Set tween's property setter script
			_property = TGMS_Variable_Instance_Set;
		}
		else
		{
			_t[@ TWEEN.PROPERTY] = TGMS_Variable_Global_Set;
			_property = TGMS_Variable_Global_Set;
		}
	}
	else // Optimised property
	{
		_t[@ TWEEN.PROPERTY] = _property; // Set tween's property setter script
	}
    
	_t[@ TWEEN.DATA] = _t[TWEEN.TARGET]; // Set tween's data as target id
}
else // Extended property
{
	_property[0] = argument[1]; // Set extended property setter script
	_property[1] = argument[9]; // override target data with data
	_t[@ TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	_t[@ TWEEN.DATA] = _property[1];  // Set tween's data to extended arguments
	var _script = _property[0];     // Cache script to use as property setter
	_property = _script;            // Update cached property setter
	_t[@ TWEEN.PROPERTY] = _script;   // Set tween's property setter script   
}

