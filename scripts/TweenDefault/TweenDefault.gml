/// @description Returns default tween for setting default tween data

/// TweenDefault()
/*
    Returns default tween data which is used as base for each new tween.
    You can, for example, use this to set default groups and time scales for new tweens
    
    e.g. 
        // Change default tween properties
        TweenSetGroup(TweenDefault(), 5);
        TweenSetTimeScale(TweenDefault(), 0.5);
    
        // Following tweens will belong to GROUP 5 and have a TIME SCALE of 0.5
        tween1 = TweenCreate(id);
        tween2 = TweenCreate(id);
*/

return 1;
