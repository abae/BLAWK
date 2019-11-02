/// TweenSystemGet("dataLabel")
/// @description Returns value for selected tweening system property

/// @param "dataLabel"

/// return: real

/*
    SUPPORTED DATA LABELS:
        "enabled"			// is system enabled?
        "time_scale"		// global time scale
        "update_interval"	// how often system should update in steps (default = 1)
        "min_delta_fps"		// minimum frame rate before delta time lags begin (default=10)
        "auto_clean_count"	// number of tweens to check for auto-cleaning each step (default=10)
        "delta_time"		// tweening systems internal delta time
        "delta_time_scaled" // tweening systems scaled delta time
*/

switch(argument0)
{
    case "delta_time":
        return SharedTweener().deltaTime;
    break;
    
    case "delta_time_scaled":
        return SharedTweener().deltaTime * global.TGMS_TimeScale;
    break;
    
    case "enabled":
        return global.TGMS_IsEnabled;
    break;
    
    case "time_scale":
        return global.TGMS_TimeScale;
    break;
    
    case "update_interval":
        return global.TGMS_UpdateInterval;
    break;
    
    case "min_delta_fps":
        return global.TGMS_MinDeltaFPS;
    break;
    
    case "auto_clean_count":
        return global.TGMS_AutoCleanIterations;
    break; 
}


