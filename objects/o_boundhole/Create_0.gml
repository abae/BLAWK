// Inherit the parent event
event_inherited();

// setup/capture:
surf = display_capture_surface();

xoff = sprite_xoffset;
yoff = sprite_yoffset;
density = 0; //weight of object
frc = 0.5; //friction
restitution = 0.1; //how bouncy an object is

fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix,	-BIG,	sprite_height/2 + GUIHEIGHT/2-yoff);
physics_fixture_add_point(fix,	BIG,	sprite_height/2 + GUIHEIGHT/2-yoff);
physics_fixture_add_point(fix,	BIG,	BIG);
physics_fixture_add_point(fix,	-BIG,	BIG);
physics_fixture_set_density(fix,density);
physics_fixture_set_friction(fix,frc);
physics_fixture_set_restitution(fix,restitution);
physics_fixture_set_collision_group(fix,0);
physics_fixture_set_linear_damping(fix,.2);
physics_fixture_set_angular_damping(fix,.2);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);

fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix, sprite_width/2 - GUIWIDTH/2 -xoff,	-BIG);
physics_fixture_add_point(fix, sprite_width/2 - GUIWIDTH/2-xoff,	BIG);
physics_fixture_add_point(fix, -BIG,		BIG);
physics_fixture_add_point(fix, -BIG,		-BIG);
physics_fixture_set_density(fix,density);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);

fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix, -BIG,	sprite_height/2 - GUIHEIGHT/2-yoff);
physics_fixture_add_point(fix, -BIG,	-BIG);
physics_fixture_add_point(fix, BIG,		-BIG);
physics_fixture_add_point(fix, BIG,		sprite_height/2 - GUIHEIGHT/2-yoff);
physics_fixture_set_density(fix,density);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);

fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix, sprite_width/2 + GUIWIDTH/2-xoff,	-BIG);
physics_fixture_add_point(fix, BIG,			-BIG);
physics_fixture_add_point(fix, BIG,			BIG);
physics_fixture_add_point(fix, sprite_width/2 + GUIWIDTH/2-xoff,	BIG);
physics_fixture_set_density(fix,density);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);

fix = physics_fixture_create();
physics_fixture_set_circle_shape(fix,50);
physics_fixture_set_density(fix,density);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);

dispsurf = sprite_add("surf.png", 1, false, false, 0, 0);