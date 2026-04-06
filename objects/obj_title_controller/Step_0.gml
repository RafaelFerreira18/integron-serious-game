/// @description Atualizar animações e hover

title_timer += 1;

// ===== FADE IN =====
if (fade_alpha > 0) {
    fade_alpha -= 0.02;
    if (fade_alpha < 0) fade_alpha = 0;
}

// ===== LOGO FLUTUANDO =====
logo_float_offset = sin(title_timer * logo_float_speed * pi / 180) * 8;

// ===== PARTÍCULAS SUBINDO =====
for (var i = 0; i < max_particles; i++) {
    particle_y[i] -= particle_spd[i];
    if (particle_y[i] < -40) {
        particle_y[i] = display_h + 20;
        particle_x[i] = irandom(display_w);
    }
}

// ===== INTEGRONS FLUTUANDO =====
for (var i = 0; i < array_length(integron_sprites); i++) {
    integron_float[i] = sin((title_timer + i * 60) * integron_float_spd[i] * pi / 180) * 6;
}

// ===== HOVER DOS BOTÕES =====
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

var _half_w = btn_w / 2;

btn_play_hover = (_mx >= btn_x - _half_w && _mx <= btn_x + _half_w &&
                  _my >= btn_play_y - btn_h / 2 && _my <= btn_play_y + btn_h / 2);

btn_exit_hover = (_mx >= btn_x - _half_w && _mx <= btn_x + _half_w &&
                  _my >= btn_exit_y - btn_h / 2 && _my <= btn_exit_y + btn_h / 2);

// ===== CLIQUES =====
if (mouse_check_button_pressed(mb_left) && fade_alpha <= 0) {
    if (btn_play_hover) {
        // ===== RESETA TODAS AS VARIAVEIS GLOBAIS DO JOGO =====
        global.player_party       = [];
        global.player_party_max   = 4;
        global.elite_defeated     = [false, false, false, false];
        global.elite_battle_cooldown = 0;
        global.tutorial_visto     = false;
        global.pvp_challenger_index = 0;
        global.pvp_original_room    = Room1;
        // Destroi instancias persistentes remanescentes
        with (obj_battle_switcher) { instance_destroy(); }
        with (obj_elite_intro)     { instance_destroy(); }
        audio_stop_all();

        room_goto(Room1);
    }
    if (btn_exit_hover) {
        game_end();
    }
}
