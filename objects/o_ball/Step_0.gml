//if (live_call()) return live_result;

spd = sqrt(sqr(phy_linear_velocity_x)+sqr(phy_linear_velocity_y));

if (audio_is_playing(sfx_chick_stretch)) invul = 2;
invul--;

if (collision_circle(x,y,2,o_wall,true,true) and !win) {
	instance_destroy(id);
}
if (collision_circle(x,y,25,o_spike,true,true) and !win and invul <= 0) {
	instance_destroy(id);
}
if (collision_circle(x,y,32,o_goal,true,true)) {
	if (!audio_is_playing(sfx_win) and !win) audio_play_sound(sfx_win,100,false);
	win = true;
	transition("shrink", TRANS_MODE.NEXT);
	var dir = point_direction(x,y,o_goal.x,o_goal.y);
	var dist = point_distance(x,y,o_goal.x,o_goal.y)/1;
	physics_apply_force(x,y,lengthdir_x(dist,dir),lengthdir_y(dist,dir));
}


if (collision_circle(x,y,32,o_wall,true,true)) sprite_index = s_chick_hurt;
else sprite_index = s_chick;

if (instance_exists(o_texttrigger)){
	with (instance_place(x,y,o_texttrigger)){
		reveal = true;
	}
}

if (spd > 600) {
	sprite_index = s_chick_hurt;
	var chanc = tween_linear_ext(spd,600,1100,0,.008);
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
timer--;

p_vx = phy_linear_velocity_x;
p_vy = phy_linear_velocity_y;