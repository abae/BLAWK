/// @description  PlatformCheck();

var collision = instance_place(x, y + sign(vy), p_wall);

if (collision) {
    if (vy >= 0) {
        platformTarget = collision;
    } else {
        // Platform above
        vy = 0;
    }
    return true;
}

if (vy < 0) {
    platformTarget = 0;
}

if (instance_exists(platformTarget)) {
    if (platformTarget) {
        if (place_meeting(x, y + 1, platformTarget) and !place_meeting(x, y, platformTarget)) {
            //Platform below
            vy = 0;
            return true;
        } else
            platformTarget = 0;
    }
} else
    platformTarget = 0;
    
if (vy > 0) {
    with (p_entity) {
        {
            if (place_meeting(x, y - 1, other) and !place_meeting(x, y, other)) {
                vy = 0;
            }
        }
    }
    
    with (p_platform) {
        if (place_meeting(x, y - 1, other) and !place_meeting(x, y, other)) {
            // Land
            vy = 0;
            other.platformTarget = id;
            return true;
        }
    }
}

platformTarget = 0;
return false;