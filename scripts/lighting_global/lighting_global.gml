//
//	Globals, enums and macros for this lighting engine
//	This script must be called to initialise the engine
//	
//	Version 0.8.0
//

// Avoid calling this script multiple times
if(__LIGHTING_ERROR_CHECKS) {
	if(variable_global_exists("lighting_global_initialised")) {
		show_debug_message("lighting_global(): lighting already initialised");
		return;
	}
	global.lighting_global_initialised = true;
}

//	#####################################
//
//		System configuration - tweak to fit your game
//		Assign these elsewhere after calling lighting_global()
//		This ensures the lighting system can be upgraded by simply replacing files
//
//	#####################################

// Ambient shadow level
global.ambientShadowIntensity = 0.85;

// The maximum size allowed for unique light shadow map surfaces
// If this is exceeded, the light will use the global light shadow map
// Lights that don't cast shadows will especially benefit from this
// This does NOT apply to area lights
global.lightMaxUniqueShadowMapSize = 1024;

// Delay in frames between light updates
// You can force the lighting system to update with lighting_set_dirty(true)
global.lightUpdateFrameDelay = 1;

// Set this to true to debug shadow casters
// This will draw all polygons
global.debugShadowCasters = false;

// Default extension modules given to lights upon creation
// This can be modified before creating any lights (or at any time otherwise)
global.lightDefaultExtensions = [
	light_create_extension(ext_light_attenuation_apply, ext_light_attenuation_reset)
];

// Initialize default extension modules
// These are supported in the shader, so they have to be executed even if the extension isn't used
ext_light_attenuation_init();

//	#####################################
//
//		End system configuration
//
//	#####################################

//
//	Read-only statistics
//

// The number of rebuilt lights each frame
global.worldRebuiltLights = 0;

// The number of active (affected by a light) shadow casters
// This will count a shadow caster once for each light that affects it
// This does not include shadow casters that have been optimized out of a pass,
// even if they're visibly affected on the global shadow map
global.worldActiveShadowCasters = 0;

//
//	Macros
//

// Macro to perform various error checks, can be turned on/off by changing value (true/false)
#macro __LIGHTING_ERROR_CHECKS false

// The step size to move along the traced line from light source to shadow caster
#macro __LIGHT_LINE_SHADOW_CASTER_STEP 0.01

// The default far vertex for shadows, this is the default on both lights and shadow casters
// Actual shadow cast is min(light shadow length, shadow caster shadow length)
#macro __WORLD_DEFAULT_SHADOW_FAR_VERTEX 32000

// The shader used to blend each light onto the world shadow map
#macro __LIGHT_SHADER sh_blend_light

// The shader used to draw the world shadow map
#macro __WORLD_SHADOW_MAP_SHADER sh_shadow_map

// The object that is responsible for rendering the lighting system
#macro __LIGHT_RENDERER obj_light_renderer

//
//	Enums
//

// Types of lights
enum eLightType {
	Point,			// This light has an omnidirectional point emitter
	Spot,			// This light has a conical point emitter
	Area,			// This light has a unidirectional line emitter
	Directional,	// This is an infinite light without an emitter source
	Line,			// This light has a bidirectional line emitter (a 'two-sided area light')
}

// Fields of a light
enum eLight {
	// Public
	X,				// The X position of the light
	Y,				// The Y position of the light
	//Z,				// The Z position of the light (see feature wishlist)
	Color,			// The color of the light's shadows
	Intensity,		// The intensity of the light
	Range,			// The range of the light
	Type,			// The type of this light (default is eLightType.Point)
	Flags,			// This light's flags
	
	// Temporary hack because there's no Z axis
	ShadowLength,	// The length of shadows cast from this light
	
	// LUTs
	LutIntensity,	// Lookup texture (LUT) for light's intensity gradient (texture; not sprite or surface)
	
	// Spot light
	Angle,			// The conical angle of the spot light
	
	// Spot light, area light, directional light
	Direction,
	
	// Area light
	Width,			// The width of the area light
	
	// Extension modules
	// The light doesn't know what this means so it's a good and safe way to extend the capabilities of a light to ensure this asset can still
	// be upgraded by simply replacing files (mostly; you might be adding shader support for your extension)
	// For example, the default light attenuation is an extension module
	ExtensionModules,
	
	// Game-specific functionality
	IgnoreSet,		// A set of shadow casters that should be ignored
	
	// Internal
	VertexBuffer,
	ShadowMap,					// This light's shadow map surface, if it has a unique shadow map
	StaticStorage,				// Static storage to hold info for static shadow casters to avoid rebuilding them
	ShadowCastersOutOfRange,	// A set of static shadow casters that are known to be out of range of this light; only applies to static shadow casters
	CulledShadowCasters,		// A set of shadow casters that have been culled from this light because they don't affect the global shadow map; culled against the camera, not the light
	ActiveCamera,				// The camera this light was last updated for, this is the camera array [X, Y, Width, Height]
	
	// The number of light fields (this must be the last enum field)
	// This makes it easier to deal with arrays that contain this information
	Count
}

// Light flags
enum eLightFlags {
	// No flags set
	None = 0,
	
	// This light is dirty; this makes it update all static shadow casters
	// Should be set whenever the light's position or range has changed
	Dirty = 1 << 0,
	
	// This light casts shadows on shadow casters
	// This is set by default but can be taken off
	// NOTE: Without CastsShadow and with UsesUniqueShadowMap, the light might be optimized
	//		 to not redraw if it's not dirty. This means changing render-only attributes of a light (e.g. intensity or color)
	//		 that doesn't cast shadow should also dirty the light. You need to dirty it manually to ensure it redraws.
	//		 TL;DR: If you remove this flag, always dirty the light when you change a render-only attribute on it
	CastsShadows = 1 << 1,
	
	// Internal
	// This light has a unique shadow map? This CANNOT be set - it is determined by the system
	UsesUniqueShadowMap = 1 << 2,
}

// Shadow caster flags
enum eShadowCasterFlags {
	// No flags set
	None = 0,
	
	// This shadow caster is static; if this flag is not set, the shadow caster is movable
	// A static shadow caster can be cached by light sources and is therefore faster than a movable shadow caster
	// If your shadow caster never changes its polygon then mark it as static
	Static = 1 << 0,
	
	// This shadow caster is dirty; this applies to the Static flag and will make lights rebuild this shadow caster
	Dirty = 1 << 1,
	
	// Internal; do not use
	// This marks a shadow caster as pending being "cleaned" (un-dirtied) after the lighting pass
	MarkedForCleanup = 1 << 2,
}

// Enum that describes a light extension module
// All scripts receive the current light as argument0
enum eLightExtension {
	Apply,		// The script to apply the extension to a light
	Reset,		// The script that is called to clean up after the extension has been applied to a light
	
	// The number of extension module fields (this must be the last enum field)
	// This makes it easier to deal with arrays that contain this information
	Count
}

// An enum of reserved light extension module names
// I have reserved 8 extension names for future use...do not use any of these numbers for custom extension names!
enum eLightReservedExtensionNames {
	Attenuation = 0,
	Reserved2, Reserved3,
	Reserved4, Reserved5,
	Reserved6, Reserved7,
	Reserved8
}

// Enum of all shadow maps for shadow_map_ensure_exists
enum eShadowMap {
	Light,		// A light's shadow map
	Global,		// The global shadow map
	Snapshot	// The snapshot shadow map
}

// Enum of camera attributes [X, Y, Width, Height] from lighting_get_active_camera
enum eLightingCamera {
	X,
	Y,
	Width,
	Height
}

// Fields in a polygon array
// Access these in a polygon array as: polygon[ePolygon.Length]
enum ePolygon {
	Length,			// The length (in # of points) of the polygon
	
	// The number of polygon fields (this must be the last enum field)
	// This makes it easier to deal with arrays that contain this information
	Count
}

// Fields in a vertex
enum eVertex {
	X,				// The X position of this vertex
	Y,				// The Y position of this vertex
	
	// The number of polygon fields (this must be the last enum field)
	// This makes it easier to deal with arrays that contain this information
	Count
}

// Triangle direction enum
enum eTriDirection {
	Clockwise,
	CounterClockwise
}

//
//	System variables
//

// Light vertex format
						   vertex_format_begin();
						   vertex_format_add_position(); // First we write a position (X,Y)
						   vertex_format_add_color();	 // Then we write a color
global.lightVertexFormat = vertex_format_end();

// Surface that is the composited shadow map
// All lights in the game world are blended into this map
global.worldShadowMap = undefined;
// Surface that is used to draw a light's shadow map to, if it doesn't have its own
global.lightShadowMap = undefined;

// The array of lights that will be composited into the global shadow map
global.worldLights = ds_list_create();

// A list of dirty shadow casters that should be "cleaned" after the lighting pass
global.worldDirtyShadowCasters = ds_list_create();

// The custom camera [X, Y, Width, Height] to use, if any
// If undefined then it uses the active view camera
// Set this with lighting_update_camera
global.worldCustomCamera = undefined;

// Reused vertex arrays
global.lightVertexArrayMap = ds_map_create();

// Reused 4-component float array to describe a color
global.tmp_ColorArray = array_create(4);

//
//	Shader uniforms
//

// Ambient shadow color and intensity; this is set to global.ambientShadowIntensity
global.u_AmbientShadow = shader_get_uniform(__WORLD_SHADOW_MAP_SHADER, "u_AmbientShadow");

// Light intensity LUT
global.u_LutIntensity = shader_get_sampler_index(__LIGHT_SHADER, "u_LutIntensity");

// Texel size uniform
global.u_TexelSize = shader_get_uniform(__LIGHT_SHADER, "u_TexelSize");
global.u_TexelSize_ShadowMap = shader_get_uniform(__WORLD_SHADOW_MAP_SHADER, "u_TexelSize");

// The uniforms for light attributes
global.u_LightPosition = shader_get_uniform(__LIGHT_SHADER, "u_LightPosition");
global.u_LightColor = shader_get_uniform(__LIGHT_SHADER, "u_LightColor");
global.u_LightRange = shader_get_uniform(__LIGHT_SHADER, "u_LightRange");
global.u_LightIntensity = shader_get_uniform(__LIGHT_SHADER, "u_LightIntensity");
global.u_LightAngle = shader_get_uniform(__LIGHT_SHADER, "u_LightAngle");
global.u_LightDirection = shader_get_uniform(__LIGHT_SHADER, "u_LightDirection");
global.u_LightWidth = shader_get_uniform(__LIGHT_SHADER, "u_LightWidth");
global.u_LightType = shader_get_uniform(__LIGHT_SHADER, "u_LightType");

// Area light specific
global.u_LineEmitterPoint1 = shader_get_uniform(__LIGHT_SHADER, "u_LineEmitterPoint1");
global.u_LineEmitterPoint2 = shader_get_uniform(__LIGHT_SHADER, "u_LineEmitterPoint2");