if (sqrt(sqr(phy_linear_velocity_x)+sqr(phy_linear_velocity_y)) > 200){
	var spd = sqrt(sqr(phy_linear_velocity_x)+sqr(phy_linear_velocity_y));
	skew_angle = point_direction(0,0,phy_linear_velocity_x,phy_linear_velocity_y)*4;
	var skew_amt = tween_linear_ext(spd,200,1000,0,max_skew_amt);
	var skewx = skew_amt * (-(dsin(skew_angle/2)));
	var skewy = skew_amt * (-(dsin(skew_angle/2)));	
	var multx = 1 - max_skew_amt + (skew_amt * ((dcos(skew_angle/2))));
	var multy = 1 - max_skew_amt + (skew_amt * (-(dcos(skew_angle/2))));
	draw_sprite_ext_skew(sprite_index, image_index, x, y, 1, 1, image_angle, 1, skewx, skewy, multx, multy);
}else if (collision_circle(x,y,30,o_wall,true,true)){
	if(position_meeting(x+30,y,o_wall)){
		var dist = 2;
		while (position_meeting(x+32-dist,y,o_wall)) dist++;
		var skew_amt = dist/75;
		var multx = 1 - max_skew_amt - skew_amt;
		var multy = 1 - max_skew_amt + skew_amt;
		draw_sprite_ext_skew(sprite_index, image_index, x-dist/2, y, 1, 1, image_angle, 1, 0, 0, multx, multy);
	}else if(position_meeting(x-30,y,o_wall)){
		var dist = 2;
		while (position_meeting(x-32+dist,y,o_wall)) dist++;
		var skew_amt = dist/75;
		var multx = 1 - max_skew_amt - skew_amt;
		var multy = 1 - max_skew_amt + skew_amt;
		draw_sprite_ext_skew(sprite_index, image_index, x+dist/2, y, 1, 1, image_angle, 1, 0, 0, multx, multy);
	}else if(position_meeting(x,y+30,o_wall)){
		var dist = 2;
		while (position_meeting(x,y+32-dist,o_wall)) dist++;
		var skew_amt = dist/75;
		var multx = 1 - max_skew_amt + skew_amt;
		var multy = 1 - max_skew_amt - skew_amt;
		draw_sprite_ext_skew(sprite_index, image_index, x, y-dist/2, 1, 1, image_angle, 1, 0, 0, multx, multy);
	}else if(position_meeting(x,y-30,o_wall)){
		var dist = 2;
		while (position_meeting(x,y-32+dist,o_wall)) dist++;
		var skew_amt = dist/75;
		var multx = 1 - max_skew_amt + skew_amt;
		var multy = 1 - max_skew_amt - skew_amt;
		draw_sprite_ext_skew(sprite_index, image_index, x, y+dist/2, 1, 1, image_angle, 1, 0, 0, multx, multy);
	}else{
		draw_self();
	}
}else{
	draw_self();
}