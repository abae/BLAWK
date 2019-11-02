//var wall = instance_create_layer(DISP_WIDTH/2-32,DISP_HEIGHT-200,"Instances",o_wall);
//with(wall) instid = 1;
//var wall = instance_create_layer(DISP_WIDTH/2-32,DISP_HEIGHT-860,"Instances",o_wall);
//with(wall) instid = 2;
//var wall = instance_create_layer(DISP_WIDTH/2,DISP_HEIGHT/2,"Instances",o_wall);
//with(wall) instid = 3;
//var wall = instance_create_layer(DISP_WIDTH/2,DISP_HEIGHT/2,"Instances",o_wall);
//with(wall) instid = 4;

instance_create_layer(o_camera.x+GUIWIDTH/2,o_camera.y+GUIHEIGHT/2,"Instances",o_bound);

instance_create_layer(DISP_WIDTH/2,DISP_HEIGHT/2,"Instances",o_window_check);