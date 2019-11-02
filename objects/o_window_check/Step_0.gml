if(!instance_place(x,y,o_bound)) {
	instance_create_layer(x,y,"Instances",o_ball);
	instance_destroy(id);
}