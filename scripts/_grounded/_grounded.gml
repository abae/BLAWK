/// @description  OnGround();

return (place_meeting(x, y + 1, p_wall) or (place_meeting(x, y + 1, p_platform) and !place_meeting(x, y, p_platform))) and vy >= 0;