///@param tile_map_id
///@param tile_size
///@param velocity_array
var tile_map_id = argument0;
var tile_size = argument1;
var vel_x = argument2;
var vel_y = argument3;
var bbox_center = floor((bbox_right-bbox_left)/2);
var bbox_middle = floor((bbox_bottom-bbox_top)/2);
// For the velocity array
var vector2_x = 0;
var vector2_y = 1;

// Move horizontally
x += vel_x;

// Right collisions
if vel_x > 0 {
	var tile_right = tile_collide_at_points(tile_map_id, [bbox_right, bbox_top], [bbox_right, bbox_bottom-1],[bbox_right,bbox_middle]);
	if tile_right {
		x = (bbox_right & ~(tile_size-1))-1;
		x -= bbox_right-x;
		vx = 0;
	}
} else {
	var tile_left = tile_collide_at_points(tile_map_id, [bbox_left, bbox_top], [bbox_left, bbox_bottom-1],[bbox_left,bbox_middle]);
	if tile_left {
		x = bbox_left & ~(tile_size-1);
		x += tile_size+x-bbox_left;
		vx = 0;
	}
}

// Move vertically
y += vel_y;

// Vertical collisions
if vel_y > 0 {
	var tile_bottom = tile_collide_at_points(tile_map_id, [bbox_left, bbox_bottom-1], [bbox_right-1, bbox_bottom-1],[bbox_center,bbox_bottom-1]);
	if tile_bottom {
		y = bbox_bottom & ~(tile_size-1);
		y -= bbox_bottom-y;
		vsp = 0;
	}
} else {
	var tile_top = tile_collide_at_points(tile_map_id, [bbox_left, bbox_top], [bbox_right-1, bbox_top],[bbox_center,bbox_top]);
	if tile_top {
		y = bbox_top & ~(tile_size-1);
		y += tile_size+y-bbox_top;
		vsp = 0;
	}
}
