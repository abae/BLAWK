initialized = false;

// this is a singleton
if(instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

// create the gmws server
server = gmws_create_server(64325);
if (server < 0) {
	show_error("Error creating debug server", true);
}

// client map
clients = ds_map_create();

// add callbacks for handling clients and stuff
gmws_callback_register_connect(gmdebug_connect, server);
gmws_callback_register_disconnect(gmdebug_disconnect, server);
gmws_callback_register_receive(gmdebug_receive, server);

initialized = true;

globalBuiltinsArray = [
	"application_surface",
	"current_time",
	"current_second",
	"current_minute",
	"current_hour",
	"current_day",
	"current_weekday",
	"current_month",
	"current_year",
	"os_browser",
	"os_device",
	"os_type",
	"os_version",
	"cursor_sprite"
]

builtinsArray = [
	"id",
	"visible",
	"solid",
	"persistent",
	"depth",
	"layer",
	"alarm",
	"object_index",
	"health",
	"lives",
	"score",
	"sprite_index",
	"sprite_width",
	"sprite_height",
	"sprite_xoffset",
	"sprite_yoffset",
	"image_alpha",
	"image_angle",
	"image_blend",
	"image_index",
	"image_number",
	"image_speed",
	"image_xscale",
	"image_yscale",
	"mask_index",
	"bbox_bottom",
	"bbox_left",
	"bbox_right",
	"bbox_top",
	"direction",
	"friction",
	"gravity",
	"gravity_direction",
	"hspeed",
	"vspeed",
	"speed",
	"xstart",
	"ystart",
	"x",
	"y",
	"xprevious",
	"yprevious",
	"path_index",
	"path_position",
	"path_positionprevious",
	"path_speed",
	"path_scale",
	"path_orientation",
	"path_endaction",
	"timeline_index",
	"timeline_running",
	"timeline_speed",
	"timeline_position",
	"timeline_loop",
	"phy_speed",
	"phy_com_x",
	"phy_com_y",
	"phy_dynamic",
	"phy_kinematic",
	"phy_inertia",
	"phy_mass",
	"phy_sleeping",
	"phy_active",
	"phy_angular_velocity",
	"phy_angular_damping",
	"phy_linear_velocity_x",
	"phy_linear_velocity_y",
	"phy_linear_damping",
	"phy_speed_x",
	"phy_speed_y",
	"phy_position_x",
	"phy_position_y",
	"phy_position_xprevious",
	"phy_position_yprevious",
	"phy_rotation",
	"phy_fixed_rotation",
	"phy_bullet"
];