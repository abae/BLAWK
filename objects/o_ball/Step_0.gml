//if (global.iRight)	physics_apply_torque(torq);
//if (global.iLeft)	physics_apply_torque(-torq);


if (collision_circle(x,y,2,o_wall,true,true)) {
	instance_create_layer(DISP_WIDTH/2,DISP_HEIGHT/2,"Instances",o_window_check);
	repeat(100) instance_create_depth(x,y,depth,o_feather);
	instance_destroy(id);
}
if (collision_circle(x,y,29,o_spike,true,true)) {
	instance_create_layer(DISP_WIDTH/2,DISP_HEIGHT/2,"Instances",o_window_check);
	repeat(100) instance_create_depth(x,y,depth,o_feather);
	instance_destroy(id);
}


if (collision_circle(x,y,32,o_wall,true,true)) sprite_index = s_chick_hurt;
else sprite_index = s_chick;

if (sqrt(sqr(phy_linear_velocity_x)+sqr(phy_linear_velocity_y)) > 600) {
	sprite_index = s_chick_hurt;
	if (chance(.1)) {
		var feather = instance_create_depth(x,y,depth,o_feather);
		with (feather){
			var dir = random_range(0,360);
			var spd = random_range(.5,5);
			vx = lengthdir_x(spd,dir);
			vy = lengthdir_y(spd,dir);
		}
	}
}