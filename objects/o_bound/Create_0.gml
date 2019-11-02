// Inherit the parent event
event_inherited();

xoff = sprite_xoffset;
yoff = sprite_yoffset;
density = 0; //weight of object
frc = 0.5; //friction
restitution = 0.1; //how bouncy an object is

fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix,	-BIG,	720-yoff);
physics_fixture_add_point(fix,	BIG,	720-yoff);
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
physics_fixture_add_point(fix, 640-xoff,	-BIG);
physics_fixture_add_point(fix, 640-xoff,	BIG);
physics_fixture_add_point(fix, -BIG,		BIG);
physics_fixture_add_point(fix, -BIG,		-BIG);
physics_fixture_set_density(fix,density);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);

fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix, -BIG,	360-yoff);
physics_fixture_add_point(fix, -BIG,	-BIG);
physics_fixture_add_point(fix, BIG,		-BIG);
physics_fixture_add_point(fix, BIG,		360-yoff);
physics_fixture_set_density(fix,density);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);

fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix, 1280-xoff,	-BIG);
physics_fixture_add_point(fix, BIG,			-BIG);
physics_fixture_add_point(fix, BIG,			BIG);
physics_fixture_add_point(fix, 1280-xoff,	BIG);
physics_fixture_set_density(fix,density);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);

fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix,164-xoff,57-yoff);
physics_fixture_add_point(fix,164-xoff,0-yoff);
physics_fixture_add_point(fix,250-xoff,0-yoff);
physics_fixture_add_point(fix,250-xoff,75-yoff);
physics_fixture_add_point(fix,193-xoff,88-yoff);
physics_fixture_set_density(fix,density);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);

fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix,193-xoff,88-yoff);
physics_fixture_add_point(fix,250-xoff,75-yoff);
physics_fixture_add_point(fix,250-xoff,125-yoff);
physics_fixture_add_point(fix,201-xoff,125-yoff);
physics_fixture_set_density(fix,density);
physics_fixture_bind(fix,self);
physics_fixture_delete(fix);