/// TweenSystemSet("label",value)
/// @description Sets value for specified tweening system property

/// @param "dataLabel"
/// @param value

/*
    SUPPORTED DATA LABELS:
        "enabled"
        "time_scale"
        "update_interval"
        "min_delta_fps"
        "auto_clean_count"
*/

var _sharedTweener = SharedTweener();

switch(argument0)
{
    case "enabled":
        _sharedTweener.isEnabled = argument1;
        global.TGMS_IsEnabled = argument1;
    break;
    
    case "time_scale":
        _sharedTweener.timeScale = argument1;
        global.TGMS_TimeScale = argument1;
    break;
    
    case "update_interval":
        _sharedTweener.updateInterval = argument1;
        global.TGMS_UpdateInterval = argument1;
    break;
    
    case "min_delta_fps":
        global.TGMS_MinDeltaFPS = argument1;
        _sharedTweener.minDeltaFPS = argument1;
        _sharedTweener.maxDelta = 1/_sharedTweener.minDeltaFPS;
    break;
    
    case "auto_clean_count":
        global.TGMS_AutoCleanIterations = argument1;
        _sharedTweener.autoCleanIterations = argument1;
    break; 
}



