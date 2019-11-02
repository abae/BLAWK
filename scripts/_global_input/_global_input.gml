
//Input
global.iRight      = (keyboard_check(ord("D")) or keyboard_check(vk_right));
global.pRight      = (keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right));
global.iLeft       = (keyboard_check(ord("A")) or keyboard_check(vk_left));
global.pLeft       = (keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left));
global.iUp         = (keyboard_check(ord("W")) or keyboard_check(vk_up));
global.pUp         = (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up));
global.iDown       = (keyboard_check(ord("S")) or keyboard_check(vk_down));
global.pDown       = (keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_up));
global.iSpace      = keyboard_check(vk_space);
global.pSpace      = keyboard_check_pressed(vk_space);
global.rSpace      = keyboard_check_released(vk_space);
global.pSelect     = (global.pSpace or keyboard_check_pressed(vk_enter));
global.iMBLeft     = mouse_check_button(mb_left);
global.pMBLeft     = mouse_check_button_pressed(mb_left);
global.rMBLeft     = mouse_check_button_released(mb_left);
global.iMBRight    = mouse_check_button(mb_right);
global.pMBRight    = mouse_check_button_pressed(mb_right);
global.rMBRight    = mouse_check_button_released(mb_right);