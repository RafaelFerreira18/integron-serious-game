/// @description Botao SAIR — volta ao mapa salvando HP atual.
action = function () {
    // Salva HP do integron ativo na party antes de sair
    if (instance_exists(obj_pvp_battle)) {
        with (obj_pvp_battle) {
            if (variable_global_exists("player_party") && player_party_index < array_length(global.player_party)) {
                global.player_party[player_party_index].hp_atual = max(0, player_integron.hp_atual);
            }
        }
    }
    var _room = variable_global_exists("pvp_original_room") ? global.pvp_original_room : Room1;
    room_goto(_room);
}
