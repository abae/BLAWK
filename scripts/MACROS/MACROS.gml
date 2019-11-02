gml_pragma("global", "MACROS()");

#macro BIG 9999999999999

#macro DISP_HEIGHT display_get_height()
#macro DISP_WIDTH display_get_width()

#macro RES_W 640
#macro RES_H 360

//Controller support
#macro CONTROLLER_DEADZONE 0.3

// Save System Support
#macro SAVE_FILE_NAME "game_save.json"
#macro SAVE_PATH game_save_id + "\\" + SAVE_FILE_NAME

#macro APPLICATION_SURFACE_WIDTH surface_get_width(application_surface)
#macro APPLICATION_SURFACE_HEIGHT surface_get_height(application_surface)