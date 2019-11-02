///@desc emit_dust(num,x,y,minvx,maxvx,minvy,maxvy,depth,color)
///@arg number
///@arg x
///@arg y
///@arg minvx
///@arg maxvx
///@arg minvy
///@arg maxvy
///@arg depth
///@arg color

var dust = floor(argument0);
var extra = argument0 - floor(argument0);

repeat(dust){
	var _inst = instance_create_depth(argument1,argument2,argument7,o_dust);
	with (_inst){
		vx = random_range(argument3, argument4);
		vy = random_range(argument5, argument6);
		col = argument8;
	}
}

if (chance(extra)){
    var _inst = instance_create_depth(argument1,argument2,argument7,o_dust);
	with (_inst){
		vx = random_range(argument3, argument4);
		vy = random_range(argument5, argument6);
		col = argument8;
	}
}