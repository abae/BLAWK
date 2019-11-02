/// @description  EntityStep();

jumped = false;
landed = false;

if (vy < 1 and vy > -1)
    platform_check();
else
    repeat(abs(vy)) {
        if (!platform_check())
            y += sign(vy);
        else
            break;
    }

if (platformTarget) {
    if (!grounded)
        landed = true;
    
    if (landed)
        with (platformTarget) other.vy = 0;
    else
        with (platformTarget) other.vy = 0;
}

repeat(abs(vx)) {
    if (place_meeting(x + sign(vx), y, p_wall) and !place_meeting(x + sign(vx), y - 1, p_wall))
        y -= 1;
         
    if (place_meeting(x + sign(vx), y + 2, p_wall) and !place_meeting(x + sign(vx), y + 1, p_wall))
        y += 1;
        
    if (!place_meeting(x + sign(vx), y, p_wall))
        x += sign(vx);
    else
        vx = 0;
}

vx_prev = vx;
vy_prev = vy;