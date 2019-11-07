vx *= .95;
vy *= .95;

vy += grav;

x += vx;
y += vy;

image_angle = wave(-20,20,1.5,off)

if (y > DISP_HEIGHT) instance_destroy();