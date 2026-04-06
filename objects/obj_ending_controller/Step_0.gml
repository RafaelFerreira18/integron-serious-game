/// @description Logica da tela final
timer++;

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// Atualiza estrelas
for (var _i = 0; _i < array_length(star_y); _i++) {
    star_y[_i] += star_spd[_i];
    if (star_y[_i] > _gh) {
        star_y[_i]   = 0;
        star_x[_i]   = irandom(_gw);
    }
}

switch (phase) {
    case 0: // Fade-in
        alpha = min(1, timer / 90);
        if (timer >= 90) { phase = 1; timer = 0; }
        break;
    case 1: // Titulo aparece
        if (timer >= 120) { phase = 2; timer = 0; }
        break;
    case 2: // Creditos rolam
        if (timer >= 300) { phase = 3; timer = 0; }
        break;
    case 3: // Aguarda clique
        if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_anykey)) {
            // Reseta todas as variaveis globais para novo jogo
            global.player_party          = [];
            global.player_party_max      = 4;
            global.elite_defeated        = [false, false, false, false];
            global.elite_battle_cooldown = 0;
            global.tutorial_visto        = false;
            global.pvp_challenger_index  = 0;
            global.pvp_original_room     = Room1;
            // Destroi instancias persistentes remanescentes
            with (obj_battle_switcher) { instance_destroy(); }
            with (obj_elite_intro)     { instance_destroy(); }
            audio_stop_all();
            room_goto(rm_title);
        }
        break;
}
