// @desc Debug all shadow casters by drawing their polygons
// @arg color The color of the polygon

var c = draw_get_color();
var a = draw_get_alpha();
draw_set_color(argument0);
draw_set_alpha(1);

with(obj_shadow_caster) {
	// Draw the polygon
	var points = polygon[ePolygon.Length];
	for(var i = 1; i <= points; ++i) {
		var p1 = polygon[ePolygon.Count + i - 1];
		var p2 = polygon[ePolygon.Count + i % points];
		draw_line(p1[eVertex.X], p1[eVertex.Y], p2[eVertex.X], p2[eVertex.Y]);
	}
}

draw_set_alpha(a);
draw_set_color(c);