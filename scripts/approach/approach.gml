/// @description  approach(a, b, amount)
/// @function  approach
/// @param a
/// @param b
/// @param amount
// Moves "a" towards "b" by "amount" and returns the result
// Nice because it will not overshoot "b", and works in both directions
// Examples:
//      speed = approach(speed, max_speed, acceleration);
//      hp = approach(hp, 0, damage_amount);
//      hp = approach(hp, max_hp, heal_amount);
//      x = approach(x, target_x, move_speed);
//      y = approach(y, target_y, move_speed);

return (argument0 + clamp(argument1 - argument0, -argument2, argument2));