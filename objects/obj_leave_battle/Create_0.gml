/// @description Botao SAIR — volta ao mapa salvando HP atual.
action = function () {
    // Marca cooldown para o NPC nao iniciar batalha imediatamente ao voltar
    global.elite_battle_cooldown = 300;  // ~5 segundos a 60fps

    // Salva HP do integron ativo na party antes de sair
    if (instance_exists(obj_pvp_battle)) {
        with (obj_pvp_battle) {
            if (variable_global_exists("player_party") && player_party_index < array_length(global.player_party)) {
                global.player_party[player_party_index].hp_atual = max(0, player_integron.hp_atual);
            }
        }
    }

    // Para qualquer musica de batalha tocando
    audio_stop_all();

    var _room = variable_global_exists("pvp_original_room") ? global.pvp_original_room : Room1;
    show_debug_message("[leave_battle] Saindo! destino=" + string(_room) + " Room1=" + string(Room1) + " iguais=" + string(_room == Room1));
    room_goto(_room);
}
