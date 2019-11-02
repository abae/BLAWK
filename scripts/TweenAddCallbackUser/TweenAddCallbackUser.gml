/// @description Sets a user event to be called on tween event

/// TweenAddCallbackUser(tween,event,target,user_event)
/// @param tween		tween id
/// @param event		tween event macro (TWEEN_EV_*)
/// @param target		instance to call user event
/// @param user_event	user event to be called (0-15)

/// return: callback id

/*        
    INFO:
        Sets a user event (0-15) to be called on specified tween event.
        Multiple callbacks can be added to the same event.
        
        "event" can take any of the following macros:
        TWEEN_EV_PLAY
        TWEEN_EV_FINISH
        TWEEN_EV_CONTINUE
        TWEEN_EV_STOP
        TWEEN_EV_PAUSE
        TWEEN_EV_RESUME
        TWEEN_EV_REVERSE    

		TWEEN_EV_FINISH_DELAY
		TWEEN_EV_STOP_DELAY
		TWEEN_EV_PAUSE_DELAY
		TWEEN_EV_RESUME_DELAY  
*/

TweenAddCallback(argument0, argument1, argument2, TGMS_EventUser, argument3);

