///@func animation_end()
///@desc returns true when the current sprite ends its animation
return image_index + image_speed*sprite_get_speed(sprite_index)/(sprite_get_speed_type(sprite_index)==spritespeed_framespergameframe?1:room_speed) >= image_number;