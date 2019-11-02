///@desc angle_to_intercept_basic(interceptor_speed,target_id,full_calculation?)
///@arg interceptor_speed
///@arg target_id
///@arg full_calculation?

/*  This script takes 3 arguments and returns the appropriate angle to aim in order to intercept a target.
    
    By calculating the time it will take to intercept the target instance based on it's current speed and
    direction, plus the speed of the intercepting instance (eg. a bullet), the script can determine the
    future position of the target at the time of interception and thus return the angle to that position.
    The script also has the option to do a faster approximation rather than the full calculation which
    would give a similar result at close range with less work.
    
    Arguments:
        0 = Speed of the intercepting object in pixels/step
        1 = Instance ID to intercept
        2 = Boolean indicating whether to do the full calculation (true) or a faster approximation (false)
    
    This script must be called in the END STEP event as it uses the xprevious and yprevious variables. */
    
var chaser_speed    = argument0;
var target          = argument1;
var accurate        = argument2;

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
    
    var distance_from_target    = point_distance(target_x, target_y, x, y);                                 //Find the distance and direction FROM the target.
    var angle_from_target       = point_direction(target_x, target_y, x, y);
    
    var time_to_intercept       = -1;                                                                       //The number of steps it will take for the intercepting instance to reach the target. What we need to calculate.
    
    switch(accurate)
    {
        case false: //APPROXIMATION
            time_to_intercept = distance_from_target / chaser_speed;                                        //The assumtion here is that it will take the same time to reach the target's current position as it's future position.
            
            var xx = target_x + lengthdir_x(target_speed * time_to_intercept, target_direction);            //Find the approximate position of the target by inferring its position from how long it will take to intercept it.
            var yy = target_y + lengthdir_y(target_speed * time_to_intercept, target_direction);
            
            return point_direction(x, y, xx, yy);
        
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
                
                return point_direction(x, y, xx, yy);
            }
            
        break;
    }
}

return -1;                                                                                                  //If the intercept was not possible return -1 so the calling instance can decide what to do instead.
