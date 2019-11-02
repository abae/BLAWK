///@desc cam_move(x,y,zoom)
///@arg x
///@arg y
///@arg zoom

with (o_camera){
    follow_x = argument0;
    follow_y = argument1;
    zoom = argument2;
    camera_set_view_size(cam, zoom*orig_view_w, zoom*orig_view_h);
    camera_set_view_pos(cam, argument0, argument1);
}