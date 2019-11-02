/// @desc Mark the lighting system as "dirty", meaning it will be recomposited next time it is drawn
/// @arg dirty True to set the lighting system as dirty, otherwise false

//
//	Marking the lighting system as dirty will force it to recomposite the shadow map
//	before it is drawn next time. This can reduce update latency and even allow you
//	to take full control over when the shadow map is composited.
//
//	This can be a powerful optimization if implemented carefully, and by disabling automatic recompositing.
//

with(__LIGHT_RENDERER) {
	dirty = argument0;
}