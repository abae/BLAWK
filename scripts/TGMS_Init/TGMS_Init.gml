/// TGMS_Init()
/*
    !DO NOT CALL THIS!
    Automatically called by the extension.
*/

//---------------------------------------
// Define system macros
//---------------------------------------
// TWEEN SELECTION
#macro TWEENS_ALL 1
#macro TWEENS_GROUP 2
#macro TWEENS_TARGET 3

//----------------------------------------------
//
//----------------------------------------------
global.TGMS_TweensIncludeDeactivated = false;
global.TGMS_TweensStack = ds_stack_create(); // make sure to destroy

//----------------------------------------------
// Build Properties
//----------------------------------------------
global.__PropertyGetters__ = ds_map_create(); // Destroy property getters map
global.__PropertySetters__ = ds_map_create(); // Destroy property setters map
global.__PropertiesDefined__ = ds_map_create(); // Destroy defined properties map
global.__NormalizedProperties__ = ds_map_create();
TGMS_BuildDefaultProperties();

//-----------------------------------------------
// Declare default global system-wide settings
//-----------------------------------------------
global.TGMS_SharedTweener = noone;    // Declare global variable for holding shared tweener instance
global.TGMS_IsEnabled = true;         // System's active state boolean
global.TGMS_TimeScale = 1.0;          // Effects overall speed of how fast system plays tweens/delays
global.TGMS_MinDeltaFPS = 10;         // The lowest framerate before delta tweens will begin to lag behind (Ideally, keep between 10-15)
global.TGMS_UpdateInterval = 1.0;     // Sets how often (in steps) system will update (1 = default, 2 = half speed, 0.5 = double speed) DO NOT set as 0 or below!
global.TGMS_AutoCleanIterations = 10; // Limits, each step, number of tweens passively checked by memory manager (Default:10)
global.TGMS_EasyDelta = false;      // Simple tweens use delta time?

//---------------------------
// Create ID Maps
//---------------------------
global.TGMS_MAP_TWEEN = ds_map_create();

//--------------------------------
// Initiate ID Indexes
//--------------------------------
global.TGMS_INDEX_TWEEN = 1;

//-------------------------------
// Declare Enum Constants
//-------------------------------
// CALLBACK DATA
enum TWEEN_CALLBACK{TWEEN,ENABLED,TARGET,SCRIPT,ARG0,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8,ARG9,ARG10,ARG11,ARG12,ARG13,ARG14,ARG15,ARG16,ARG17,ARG18,ARG19,ARG20,ARG21,ARG22,ARG23,ARG24,ARG25,ARG26,ARG27,ARG28,ARG29,ARG30,ARG31,ARG32,ARG33,ARG34,ARG35,ARG36,ARG37,ARG38};

// TWEEN STATES
enum TWEEN_STATE{DESTROYED=-4,STOPPED=-10,PAUSED=-11,DELAYED=-12};

// TWEEN DATA
enum TWEEN
{
    STATE,
    DURATION,
    DELTA,
    TIME_SCALE,
    TIME,
    CHANGE,
    START,
    TARGET,
    DATA,
    EASE,
    PROPERTY,
    PROPERTY_RAW,
	VARIABLE,
    GROUP,
    DIRECTION,
    EVENTS,
    DESTROY,
    MODE,
    DELAY,
    DELAY_START,
    ID,
    DATA_SIZE,
    DESTINATION,
    TIME_AMOUNT,
};

//---------------------------
// Create Default Tween
//---------------------------
global.TGMS_TweenDefault[TWEEN.ID] = 0;
global.TGMS_TweenDefault[TWEEN.TARGET] = noone;
global.TGMS_TweenDefault[TWEEN.EASE] = EaseLinear;
global.TGMS_TweenDefault[TWEEN.TIME] = 0;
global.TGMS_TweenDefault[TWEEN.START] = 0;
global.TGMS_TweenDefault[TWEEN.CHANGE] = 1;
global.TGMS_TweenDefault[TWEEN.DURATION] = 1;
global.TGMS_TweenDefault[TWEEN.PROPERTY] = TGMS_NULL__;
global.TGMS_TweenDefault[TWEEN.PROPERTY_RAW] = 0;
global.TGMS_TweenDefault[TWEEN.VARIABLE] = "";
global.TGMS_TweenDefault[TWEEN.STATE] = TWEEN_STATE.STOPPED;
global.TGMS_TweenDefault[TWEEN.TIME_SCALE] = 1;
global.TGMS_TweenDefault[TWEEN.DELTA] = false;
global.TGMS_TweenDefault[TWEEN.GROUP] = 0;
global.TGMS_TweenDefault[TWEEN.EVENTS] = -1;
global.TGMS_TweenDefault[TWEEN.DESTROY] = 1;
global.TGMS_TweenDefault[TWEEN.DIRECTION] = 1;
global.TGMS_TweenDefault[TWEEN.MODE] = TWEEN_MODE_ONCE;
global.TGMS_TweenDefault[TWEEN.DATA] = 0;
global.TGMS_TweenDefault[TWEEN.DELAY] = -1;
global.TGMS_TweenDefault[TWEEN.DELAY_START] = 0;

// Assign default tween as first in global id map
global.TGMS_MAP_TWEEN[? 1] = global.TGMS_TweenDefault;

// Assign [all] as shortcut for affecting all tweens with tween calls
global.TGMS_MAP_TWEEN[? all] = "10";

// Set defaults for TWEEN USER properties
TWEEN_USER_GET = 0;
TWEEN_USER_VALUE = 0;
TWEEN_USER_DATA = undefined;
TWEEN_USER_TARGET = noone;

global.TGMS_TweenDataIndexes = ds_map_create();
global.TGMS_TweenDataIndexes[? "target"] = TWEEN.TARGET;
global.TGMS_TweenDataIndexes[? "property"] = TWEEN.PROPERTY;
global.TGMS_TweenDataIndexes[? "time"] = TWEEN.TIME;
global.TGMS_TweenDataIndexes[? "time_scale"] = TWEEN.TIME_SCALE;
global.TGMS_TweenDataIndexes[? "time_amount"] = TWEEN.TIME_AMOUNT;
global.TGMS_TweenDataIndexes[? "ease"] = TWEEN.EASE;
global.TGMS_TweenDataIndexes[? "start"] = TWEEN.START;
global.TGMS_TweenDataIndexes[? "destination"] = TWEEN.DESTINATION;
global.TGMS_TweenDataIndexes[? "duration"] = TWEEN.DURATION;
global.TGMS_TweenDataIndexes[? "delay"] = TWEEN.DELAY;
global.TGMS_TweenDataIndexes[? "delay_start"] = TWEEN.DELAY_START;
global.TGMS_TweenDataIndexes[? "group"] = TWEEN.GROUP;
global.TGMS_TweenDataIndexes[? "state"] = TWEEN.STATE;
global.TGMS_TweenDataIndexes[? "mode"] = TWEEN.MODE;
global.TGMS_TweenDataIndexes[? "delta"] = TWEEN.DELTA;

global.TGMS_TweenDataIndexes[? TWEEN.TARGET] = TWEEN.TARGET;
global.TGMS_TweenDataIndexes[? TWEEN.PROPERTY] = TWEEN.PROPERTY;
global.TGMS_TweenDataIndexes[? TWEEN.TIME] = TWEEN.TIME;
global.TGMS_TweenDataIndexes[? TWEEN.TIME_SCALE] = TWEEN.TIME_SCALE;
global.TGMS_TweenDataIndexes[? TWEEN.TIME_AMOUNT] = TWEEN.TIME_AMOUNT;
global.TGMS_TweenDataIndexes[? TWEEN.EASE] = TWEEN.EASE;
global.TGMS_TweenDataIndexes[? TWEEN.START] = TWEEN.START;
global.TGMS_TweenDataIndexes[? TWEEN.DESTINATION] = TWEEN.DESTINATION;
global.TGMS_TweenDataIndexes[? TWEEN.DURATION] = TWEEN.DURATION;
global.TGMS_TweenDataIndexes[? TWEEN.DELAY] = TWEEN.DELAY;
global.TGMS_TweenDataIndexes[? TWEEN.DELAY_START] = TWEEN.DELAY_START;
global.TGMS_TweenDataIndexes[? TWEEN.GROUP] = TWEEN.GROUP;
global.TGMS_TweenDataIndexes[? TWEEN.STATE] = TWEEN.STATE;
global.TGMS_TweenDataIndexes[? TWEEN.MODE] = TWEEN.MODE;
global.TGMS_TweenDataIndexes[? TWEEN.DELTA] = TWEEN.DELTA;

