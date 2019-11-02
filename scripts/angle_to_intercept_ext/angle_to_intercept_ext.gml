///@desc angle_to_intercept_ext(interceptor_speed,target_id,full_calculation?)
///@arg interceptor_speed
///@arg interceptor_xoff
///@arg interceptor_yoff
///@arg target_id
///@arg target_xoff
///@arg target_yoff
///@arg relative?
///@arg full_calculation?

/*  This script takes 8 arguments and returns the appropriate angle to aim in order to intercept a target.
    
    Effectively the same as the basic angle_to_intercept script, however this one contains several
    additional variables for increased flexibility.
    
    Arguments:
        0 = Speed of the intercepting object in pixels/step
        1 = The starting x offset of the chasing instance relative to the calling instance
        2 = The starting y offset of the chasing instance relative to the calling instance
        3 = Instance ID to intercept
        4 = The x offset of the target origin to aim at (in case you don't want to aim directly at the origin)
        5 = The y offset of the target origin to aim at (in case you don't want to aim directly at the origin)
        6 = Boolean indicating whether you want the target offset to remain relative to the target (true - the point will rotate with the target), or to be globally oriented (false)
        7 = Boolean indicating whether to do the full calculation (true) or a faster approximation (false)
    
    This script must be called in the END STEP event as it uses the xprevious and yprevious variables. */

var chaser_speed    = argument0;
var chaser_xstart   = x + lengthdir_x(argument1, image_angle) + lengthdir_x(argument2, image_angle - 90);   //Calculate the start coordinate of the intercepting object based on the offset and rotation of calling instance.
var chaser_ystart   = y + lengthdir_y(argument1, image_angle) + lengthdir_y(argument2, image_angle - 90);
var target          = argument3;
var target_xoffset  = argument4;
var target_yoffset  = argument5;
var relative_offset = argument6;
var accurate        = argument7;

if(instance_exists(target))                                                                                 //Important to check this otherwise errors could occur from looking up non-existant variables.
{
    var target_px, target_py, target_x, target_y;                                                           //The previous and current coordinates of the target.
    
    with(target)
    {
        target_px   = xprevious;                                                                            //Here we are getting values from the target instance, NOT the instance calling this script.
        target_py   = yprevious;
        target_x    = x;
        target_y    = y;
    }
    
    var target_speed            = point_distance(target_px, target_py, target_x, target_y);                 //Find the velocity components of the target.
    var target_direction        = point_direction(target_px, target_py, target_x, target_y);
    
    if(target_xoffset != 0 or target_yoffset != 0)                                                          //After the initial velocity calculation, determine the offset position to aim at if an offset has been set.
    {
        if(relative_offset)
        {
            var ia      = target.image_angle;                                                               //This will set the offset relative to the target based on its image_angle.
            target_x   += lengthdir_x(target_xoffset, ia) + lengthdir_x(target_yoffset, ia - 90);
            target_y   += lengthdir_y(target_xoffset, ia) + lengthdir_y(target_yoffset, ia - 90);
        }
        else
        {
            target_x   += target_xoffset;                                                                   //This will set the offset on the global axis rather than shifting with the image_angle.
            target_y   += target_yoffset;
        }
    }
    
    var distance_from_target    = point_distance(target_x, target_y, chaser_xstart, chaser_ystart);         //Find the distance and direction FROM the target.
    var angle_from_target       = point_direction(target_x, target_y, chaser_xstart, chaser_ystart);
    
    var time_to_intercept       = -1;                                                                       //The number of steps it will take for the intercepting instance to reach the target. What we need to calculate.
    
    switch(accurate)
    {
        case false: //APPROXIMATION
            time_to_intercept = distance_from_target / chaser_speed;                                        //The assumtion here is that it will take the same time to reach the target's current position as it's future position.
            
            var xx = target_x + lengthdir_x(target_speed * time_to_intercept, target_direction);            //Find the approximate position of the target by inferring its position from how long it will take to intercept it.
            var yy = target_y + lengthdir_y(target_speed * time_to_intercept, target_direction);
            
            var origin_to_intercept = point_direction(x, y, xx, yy);                                        //If the start position of the intercepting instance is left or right of center, the aim must be corrected.
            var start_to_intercept  = point_direction(chaser_xstart, chaser_ystart, xx, yy);
            var error               = angle_difference(start_to_intercept, origin_to_intercept);            //The error is the amount the calling instance must be corrected by to ensure the direction is correct from the start position.
            
            return origin_to_intercept + error;
        
        break;
                                                                                                        
        case true:  //FULL CALCULATION (Quadratic Equation)
            var a, b, c;
            
            a = sqr(chaser_speed) - sqr(target_speed);
            
            b = 2 * dot_product(lengthdir_x(distance_from_target, angle_from_target),                       //2 * dot_product of [distance-and-direction to target] and [target velocity].
                                lengthdir_y(distance_from_target, angle_from_target), 
                                lengthdir_x(target_speed, target_direction), 
                                lengthdir_y(target_speed, target_direction));
            
            c = -sqr(distance_from_target);
            
            if(a == 0)
            {
                time_to_intercept = -c / b;                                                                 //In the event that a = 0 the problem is not actually a quadratic.
            }
            else
            {
                var d = sqr(b) - 4 * a * c;                                                                 //This is the discriminator of the quadratic. An intercept is only possible when this is >= 0.
                
                if(d >= 0)
                {
                    var time_1  = (-b + sqrt(d)) / (2 * a);                                                 //This is the actual quadratic equation. These equations always have two results (time_1 and time_2).
                    var time_2  = (-b - sqrt(d)) / (2 * a);
                    
                    var minimum = min(time_1, time_2);                                                      //The MINIMUM POSITIVE result is the time to intercept. If both are negative an intercept is not possible.
                    var maximum = max(time_1, time_2);
                    
                    if(minimum >= 0)                                                                        //Because time_to_intercept was initially set to -1 nothing has to be done if both results are negative.
                    {
                        time_to_intercept = minimum;
                    }
                    else if(maximum >= 0)
                    {
                        time_to_intercept = maximum;
                    }
                }
            }
            
            if(time_to_intercept >= 0)                                                                      //Final check to make sure the time to intercept is valid (not -1).
            {
                var xx = target_x + lengthdir_x(target_speed * time_to_intercept, target_direction);        //Find the approximate position of the target by inferring its position from how long it will take to intercept it.
                var yy = target_y + lengthdir_y(target_speed * time_to_intercept, target_direction);
                
                var origin_to_intercept = point_direction(x, y, xx, yy);                                    //If the start position of the intercepting instance is left or right of center, the aim must be corrected.
                var start_to_intercept  = point_direction(chaser_xstart, chaser_ystart, xx, yy);
                var error               = angle_difference(start_to_intercept, origin_to_intercept);        //The error is the amount the calling instance must be corrected by to ensure the direction is correct from the start position.
            
                return origin_to_intercept + error;
            }
            
        break;
    }
}

return -1;                                                                                                  //If the intercept was not possible return -1 so the calling instance can decide what to do instead.
