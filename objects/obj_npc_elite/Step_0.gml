/// @description Detectar proximidade do jogador e iniciar batalha PvP.

bob_timer++;
prompt_ativo = false;

if (!instance_exists(obj_player)) exit;

var _dist = point_distance(x, y, obj_player.x, obj_player.y);

if (_dist <= interact_dist) {
    prompt_ativo = true;

    // Verifica se tem party E se pelo menos um integron esta vivo
    var _tem_party = variable_global_exists("player_party") && array_length(global.player_party) > 0;
    var _tem_vivo  = false;
    if (_tem_party) {
        for (var _i = 0; _i < array_length(global.player_party); _i++) {
            var _p  = global.player_party[_i];
            var _hp = variable_struct_exists(_p, "hp_atual") ? _p.hp_atual : 1;
            if (_hp > 0) { _tem_vivo = true; break; }
        }
    }

    if (keyboard_check_pressed(interact_tecla) && _tem_party && _tem_vivo) {
        // Configura o challenger e entra na sala de batalha
        global.pvp_challenger_index = challenger_index;
        global.pvp_original_room    = room;

        room_goto(rm_battle_integrons);
    }

    if (keyboard_check_pressed(interact_tecla) && (!_tem_party || !_tem_vivo)) {
        if (!_tem_party) {
            aviso_texto = "Capture um Integron primeiro!";
        } else {
            aviso_texto = "Seus Integrons estao sem HP! Va ao Integron Center.";
        }
        aviso_timer = 210;
    }
}

if (aviso_timer > 0) aviso_timer--;
