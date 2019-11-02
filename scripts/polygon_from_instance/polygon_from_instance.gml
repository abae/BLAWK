/// @desc Creates a polygon from an instance
/// @arg id The instance to create a polygon from
/// @arg [rotation] The optional rotation of the instance
/// @returns The polygon for the instance

var inst = argument[0];
var rotation = argument_count > 1 ? argument[1] : image_angle;

// Create the set of points from the bounding box
var set = array_create(4);

with(inst) {
	if(rotation == 0) {
		// The corners of the bounding box are the most primitive polygon we can create
		// that represents any arbitrary instance
		set[0] = [bbox_left, bbox_top];
		set[1] = [bbox_right+1, bbox_top];
		set[2] = [bbox_right+1, bbox_bottom+1];
		set[3] = [bbox_left, bbox_bottom+1];
	}
	else {
		// Rotate the instance; this relies on the sprite information
		set[0] = [x,				 y];
		set[1] = [x + sprite_width,  y];
		set[2] = [x + sprite_width,  y + sprite_height];
		set[3] = [x,				 y + sprite_height];
		
		var cx = x + sprite_xoffset;
		var cy = y + sprite_yoffset;
		
		var rad = degtorad(rotation);
		for(var i = 0; i < 4; ++i) {
			var p = set[i], px = p[0] - cx, py = p[1] - cy;
			p[@ 0] = px * cos(rad) + py * sin(rad) + cx - sprite_xoffset;
			p[@ 1] = py * cos(rad) - px * sin(rad) + cy - sprite_yoffset;
		}
	}
}

// From the set of 4 points, create and return a polygon
return polygon_create(set);