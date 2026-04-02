/// @description Detectar proximidade do jogador e iniciar batalha PvP.

bob_timer++;
prompt_ativo = false;

if (!instance_exists(obj_player)) exit;

var _dist = point_distance(x, y, obj_player.x, obj_player.y);

if (_dist <= interact_dist) {
    prompt_ativo = true;

    // Garante party nao vazia (nunca deve acontecer com o starter, mas por segurança)
    var _tem_party = variable_global_exists("player_party") && array_length(global.player_party) > 0;

    if (keyboard_check_pressed(interact_tecla) && _tem_party) {
        // Configura o challenger e entra na sala de batalha
        global.pvp_challenger_index = challenger_index;
        global.pvp_original_room    = room;

        room_goto(rm_battle_integrons);
    }

    if (keyboard_check_pressed(interact_tecla) && !_tem_party) {
        aviso_texto = "Capture um Integron primeiro!";
        aviso_timer = 180;
    }
}

if (aviso_timer > 0) aviso_timer--;
