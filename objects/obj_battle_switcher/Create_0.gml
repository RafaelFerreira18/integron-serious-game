persistent = true;

// Para a musica do overworld
if (variable_global_exists("bgm_exploring") && audio_is_playing(global.bgm_exploring)) {
    audio_stop_sound(global.bgm_exploring);
}

// Toca a musica de batalha de captura em loop
global.bgm_capture = audio_play_sound(capture_battle_sound, 1, true);

player_data   = noone;
grass_data    = noone;
integron      = undefined;
original_room = noone;

// Transição (barras pretas)
bar_height  = 0;
bar_speed   = 30;
screen_w    = display_get_gui_width();
screen_h    = display_get_gui_height();
target      = screen_h / 2;
transitioned = false;

show_debug_message("[switcher] CREATE rodou! integron = " + string(integron));
show_debug_message("[switcher] room atual = " + string(room));