image_speed = 0;
image_index = random_range(0,image_number);
off = random_range(0,3);

var dir = random_range(0,360);
var spd = random_range(.5,15);
vx = lengthdir_x(spd,dir);
vy = lengthdir_y(spd,dir);
grav = .008;
life = 1;