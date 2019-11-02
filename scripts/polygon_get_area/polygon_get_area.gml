/// @desc Gets the area of a polygon
/// @arg polygon The polygon to get the area of
/// @returns An array with 4 points

var polygon = argument0;

// Number of points in polygon
var points = polygon[ePolygon.Length];

var area = [1000000000, 1000000000, -1000000000, -1000000000];

for(var i = ePolygon.Count; i < ePolygon.Count + points; ++i) {
	var pt = polygon[i];
	var px = pt[eVertex.X];
	if(px < area[0]) area[0] = px;
	else if(px > area[2]) area[2] = px;
	
	var py = pt[eVertex.Y];
	if(py < area[1]) area[1] = py;
	else if(py > area[3]) area[3] = py;
}

return area;