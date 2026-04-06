/// @description Room Start — toca musica do overworld ao entrar na Room1
if (room == Room1) {
    audio_stop_all();
    global.bgm_exploring = audio_play_sound(exploring_sound, 1, true);
    show_debug_message("[obj_player RoomStart] Room1 detectada, exploring_sound iniciado: " + string(global.bgm_exploring));

    // Inicializa array de derrotas se nao existir
    if (!variable_global_exists("elite_defeated")) {
        global.elite_defeated = [false, false, false, false];
    }

    // Destroi portas dos challengers ja derrotados
    with (D_Box) {
        if (variable_instance_exists(id, "gate_for")) {
            if (global.elite_defeated[gate_for]) {
                instance_destroy();
            }
        }
    }
}
