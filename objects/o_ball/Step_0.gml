//if (live_call()) return live_result;

spd = sqrt(sqr(phy_linear_velocity_x)+sqr(phy_linear_velocity_y));

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

if (spd > 600) {
	sprite_index = s_chick_hurt;
	var chanc = tween_linear_ext(spd,600,1100,0,.1)
	if (chance(chanc)) {
		var feather = instance_create_depth(x,y,depth,o_feather);
		with (feather){
			var dir = random_range(0,360);
			var spd_f = random_range(.5,5);
			vx = lengthdir_x(spd_f,dir);
			vy = lengthdir_y(spd_f,dir);
		}
	}
}

//if (instance_exists(o_feather) and spd > 200){
//	with (instance_place(x,y,o_feather)){
//		var dir = point_direction(other.x,other.y,x,y);
//		var spd_f = tween_linear_ext(other.spd,200,1000,0,.5);
//		vx += lengthdir_x(spd_f,dir);
//		vy += lengthdir_y(spd_f,dir);
//	}
//}

p_vx = phy_linear_velocity_x;
p_vy = phy_linear_velocity_y;