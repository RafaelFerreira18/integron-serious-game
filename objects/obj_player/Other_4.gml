/// @description Room Start — toca musica do overworld ao entrar na Room1
if (room == Room1) {
    audio_stop_all();
    global.bgm_exploring = audio_play_sound(exploring_sound, 1, true);
    show_debug_message("[obj_player RoomStart] Room1 detectada, exploring_sound iniciado: " + string(global.bgm_exploring));
}
