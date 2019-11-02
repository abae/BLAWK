/// @desc Gets the area of a path
/// @arg path The path to get the area of
/// @returns An array with 4 points

var path = argument0;

// Number of points in path
var points = path_get_number(path);

var area = [1000000000, 1000000000, -1000000000, -1000000000];

for(var i = 0; i < points; ++i) {
	var px = path_get_point_x(path, i);
	if(px < area[0]) area[0] = px;
	if(px > area[2]) area[2] = px;
	
	var py = path_get_point_y(path, i);
	if(py < area[1]) area[1] = py;
	if(py > area[3]) area[3] = py;
}

return area;