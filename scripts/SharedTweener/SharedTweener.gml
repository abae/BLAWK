/// SharedTweener()
/*
    Version 0.9.80
    Creates and/or Returns Shared Tweener Singleton
*/

// Return shared tweener if it already exists
if (instance_exists(global.TGMS_SharedTweener))
{
    return global.TGMS_SharedTweener;
}
else
{
    // Attempt to activate shared tweener
    instance_activate_object(global.TGMS_SharedTweener);
    
    // Return shared tweener if it now exists
    if (instance_exists(global.TGMS_SharedTweener))
    {
        return global.TGMS_SharedTweener;
    }
    else
    {
        // Create new shared tweener if it doesn't exist
        global.TGMS_SharedTweener = instance_create_depth(-1000000, -1000000, 0, obj_SharedTweener);
        return global.TGMS_SharedTweener;
    }
}

// S.A.L.

