//if (global.iRight)	physics_apply_torque(torq);
//if (global.iLeft)	physics_apply_torque(-torq);


if (collision_circle(x,y,30,o_wall,true,true)) {
	instance_create_layer(DISP_WIDTH/2,DISP_HEIGHT/2,"Instances",o_window_check);
	var dustspd = 20;
	emit_dust(200,x,y,-dustspd,dustspd,-dustspd,dustspd,depth,c_yellow);
	instance_destroy(id);
}
if (collision_circle(x,y,30,o_spike,true,true)) {
	instance_create_layer(DISP_WIDTH/2,DISP_HEIGHT/2,"Instances",o_window_check);
	var dustspd = 20;
	emit_dust(200,x,y,-dustspd,dustspd,-dustspd,dustspd,depth,c_yellow);
	instance_destroy(id);
}