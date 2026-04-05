/// @description Integron Center — Step.
bob_timer++;
prompt_ativo = false;

if (aviso_timer > 0) aviso_timer--;
if (cura_flash_timer > 0) cura_flash_timer--;
if (cura_feedback_timer > 0) cura_feedback_timer--;

if (!instance_exists(obj_player)) exit;

var _dist = point_distance(x, y, obj_player.x, obj_player.y);

if (_dist <= interact_dist) {
    if (!overlay_ativo) prompt_ativo = true;

    if (keyboard_check_pressed(interact_tecla)) {
        overlay_ativo  = !overlay_ativo;
        keyboard_string = "";
    }
}

if (overlay_ativo) {
    // Fechar com Esc
    if (keyboard_check_pressed(vk_escape)) {
        overlay_ativo   = false;
        keyboard_string = "";
    }

    // Curar todos com E
    if (keyboard_check_pressed(interact_tecla)) {
        keyboard_string = "";
        if (variable_global_exists("player_party")) {
            for (var _ci = 0; _ci < array_length(global.player_party); _ci++) {
                var _p = global.player_party[_ci];
                var _max = variable_struct_exists(_p, "hp_max") ? _p.hp_max : 60;
                _p.hp_atual = _max;
            }
        }
        cura_flash_timer    = 80;
        cura_feedback_timer = 180;
        overlay_ativo       = false;
    }
}
