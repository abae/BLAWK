var exception = argument3;

with (argument2) {
    // Allow 'other' access
    var this = id;
    
    if (id == exception)
        continue;
    else
        with (other)
            if (place_meeting(argument0, argument1, this))
                return true;
}

// Collision with a different object
return false;