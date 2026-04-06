/// @description Botao SAIR — volta ao mapa.
action = function () {
    // Marca cooldown para o NPC nao iniciar batalha imediatamente ao voltar
    global.elite_battle_cooldown = 300;  // ~5 segundos a 60fps

    // Para qualquer musica de batalha tocando
    audio_stop_all();

    var _room = variable_global_exists("pvp_original_room") ? global.pvp_original_room : Room1;
    show_debug_message("[leave_battle] Saindo! destino=" + string(_room) + " Room1=" + string(Room1) + " iguais=" + string(_room == Room1));
    room_goto(_room);
}
