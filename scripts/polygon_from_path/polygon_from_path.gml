/// @desc Creates a polygon from a path resource
/// @arg path The path to create a polygon from
/// @arg originx The X origin
/// @arg originy The Y origin
/// @returns The polygon for the path

var path = argument0;
var originx = argument1;
var originy = argument2;

var area = path_get_area(path);
var area_cx = area[0] + (area[2] - area[0]) * 0.5;
var area_cy = area[1] + (area[3] - area[1]) * 0.5;

// Number of points in path
var points = path_get_number(path);

// Create the set of points from the bounding box
var set = array_create(points);

for(var i = 0; i < points; ++i) {
	var px = path_get_point_x(path, i) - area_cx - originx;
	var py = path_get_point_y(path, i) - area_cy - originy;
	set[i] = [px, py];
}

// From the set of points, create and return a polygon
return polygon_create(set);