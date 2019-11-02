/// TGMS_TargetExists(target)

if (global.TGMS_TweensIncludeDeactivated)
{
    if (instance_exists(argument0)){
        return true;
    }

    instance_activate_object(argument0);
    
    if (instance_exists(argument0)){
        instance_deactivate_object(argument0);
        return true;
    }
    
    return false;
}

return (instance_exists(argument0));

