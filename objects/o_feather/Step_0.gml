vx *= .95;
vy *= .95;

vy += grav;

x += vx;
y += vy;

image_angle = wave(-20,20,1.5,off)

if (place_meeting(x,y,o_wall)) life -=.03;
if (life <= 0) instance_destroy();
if (y > DISP_HEIGHT) instance_destroy();