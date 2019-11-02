/// @description Create a tween to be started with TweenPlay*() (not auto-destroyed)

/// TweenCreate(target,[ease,mode,delta,delay,dur,prop,start,dest,...])
/// @param target	instance to associate with tween (id or object index)
/// @param [ease	easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
/// @param delay	amount of time to delay tween before playing
/// @param dur		duration of time to play tween
/// @param prop		property setter string or TP*() script
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

if (argument_count == 1)
{
    return TGMS_TweenCreate(argument[0].id);
}

var _target = argument[0].id;
var _propCount = (argument_count-6) div 3;
var _data;

// ** Single Property ** //

if (_propCount == 1)
{   
    var _propRaw = argument[6];
    
    if (is_array(_propRaw)) // Advanced Properties
    {
        _propRaw[@ 0] = global.__PropertySetters__[? _propRaw[0]];
        
        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
        {
            _data[0] = _propRaw[1]; // data
            _data[1] = argument[7]; // start
            _data[2] = argument[8]; // destination
            return TGMS_TweenCreate(_target, _propRaw[0], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
        }
        else
        {
            return TGMS_TweenCreate(_target, _propRaw[0], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8], _propRaw[1]);
        }
    }
    else // Standard Properties
    { 
		if (ds_map_exists(global.__PropertySetters__, _propRaw)) // look for optimised script
		{
			_propRaw = global.__PropertySetters__[? _propRaw];
			
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) // normalized property
	        {
	            _data[0] = argument[7];
	            _data[1] = argument[8];
	            return TGMS_TweenCreate(_target, _propRaw, argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
	        }
	        else
			if (ds_map_exists(global.__PropertySetters__, _propRaw)) // optimised property
	        {
	            return TGMS_TweenCreate(_target, _propRaw, argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
	        }
		}
		else // Dynamic Property
		{
			return TGMS_TweenCreate(_target, argument[6], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
		}
    }
}

// ** Multi Property ** //

var _argIndex = 5, _extIndex = 0, _extData;
_extData[_propCount*5] = 0;
_extData[0] = _propCount; // Set first ext-data to count of properties

repeat(_propCount)
{
    var _propRaw = argument[++_argIndex];

    if (is_array(_propRaw)) // Extended Properties
    {
        // Assign property setter script back to raw property array
        _propRaw[@ 0] = global.__PropertySetters__[? _propRaw[0]];
        
        // Track raw property
        _extData[++_extIndex] = _propRaw[0]; // Raw property Script?
        
        // Set property data based on standard/normalized types
        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
        {   // Normalized Property
            _data = 0;
            _data[0] = _propRaw[1]; // data
            _data[1] = argument[++_argIndex]; // real start value
            _data[2] = argument[++_argIndex]; // real destination value
            _extData[++_extIndex] = 0; // normalized start
            _extData[++_extIndex] = 1; // normalized destination
            _extData[++_extIndex] = _data; // data
        }
        else
        {   // Standard Property =================
            _extData[++_extIndex] = argument[++_argIndex]; // start
            _extData[++_extIndex] = argument[++_argIndex]; // destination
            _extData[++_extIndex] = _propRaw[1]; // Property Data
        }
		
		_extData[++_extIndex] = ""; // Reserved for dynamic property
    }
    else // Standard Properties
    {
		if (ds_map_exists(global.__PropertySetters__, _propRaw))
		{
			// Get raw property setter script
			_propRaw = global.__PropertySetters__[? _propRaw];
		
			// Track raw property
	        _extData[++_extIndex] = _propRaw;
        
	        // Set property data based on standard/normalized types
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
	        {    
				// Normalized Property
	            _data = 0;
	            _data[0] = argument[++_argIndex]; // real start value
	            _data[1] = argument[++_argIndex]; // real destination value
	            _extData[++_extIndex] = 0; // normalized start
	            _extData[++_extIndex] = 1; // normalized destination
	            _extData[++_extIndex] = _data; // data
	        }
	        else
	        {
				// Standard Property
	            _extData[++_extIndex] = argument[++_argIndex]; // start
	            _extData[++_extIndex] = argument[++_argIndex]; // destination
	            _extData[++_extIndex] = _target; // target
	        }
			
			_extData[++_extIndex] = "" // Reserved for dynamic property
		}
		else // Dynamic Property
		{
			// Determine instance/global property setter
			if (variable_instance_exists(_target, _propRaw))
			{
				_extData[++_extIndex] = TGMS_Variable_Instance_Set;
			}
			else
			{
				_extData[++_extIndex] = TGMS_Variable_Global_Set;
			}

	        _extData[++_extIndex] = argument[++_argIndex]; // start
	        _extData[++_extIndex] = argument[++_argIndex]; // destination
			_extData[++_extIndex] = _target; // target
			_extData[++_extIndex] = _propRaw; // variable string
		}
    }
    
    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
    _extData[++_extIndex] = _propRaw;
}

return TGMS_TweenCreate(_target, TGMS_MultiPropertySetter__, argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _extData);

