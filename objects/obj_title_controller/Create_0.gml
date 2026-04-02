/// @description Inicializar tela título

// Tamanho da tela (base do jogo)
display_w = 1366;
display_h = 768;

// ===== LOGO =====
logo_text = "INTEGRON";
logo_y_base = 160;
logo_float_offset = 0;
logo_float_speed = 2;

// ===== BOTÕES =====
btn_w = 280;
btn_h = 64;
btn_x = display_w / 2;

btn_play_y = 420;
btn_exit_y = 520;

btn_play_hover = false;
btn_exit_hover = false;

btn_play_text = "JOGAR";
btn_exit_text = "SAIR";

// ===== PARTÍCULAS DECORATIVAS (símbolos de integral flutuando) =====
max_particles = 12;
particle_x = array_create(max_particles);
particle_y = array_create(max_particles);
particle_spd = array_create(max_particles);
particle_alpha = array_create(max_particles);
particle_symbol = array_create(max_particles);
particle_size = array_create(max_particles);

var _symbols = ["∫", "dx", "∑", "∂", "π", "∞", "Δ", "√"];

for (var i = 0; i < max_particles; i++) {
    particle_x[i] = irandom(display_w);
    particle_y[i] = irandom(display_h);
    particle_spd[i] = 0.3 + random(0.7);
    particle_alpha[i] = 0.08 + random(0.18);
    particle_symbol[i] = _symbols[irandom(array_length(_symbols) - 1)];
    particle_size[i] = 20 + irandom(28);
}

// ===== INTEGRONS DECORATIVOS (mostrar criaturas como Pokémon) =====
// Usar sprites dos integrons existentes para decorar a tela
integron_sprites = [spr_enemy1, spr_enemy2, spr_npc1];
integron_float = [0, 0, 0];
integron_float_spd = [1.5, 2.0, 1.8];

// ===== ANIMAÇÃO DE ENTRADA =====
fade_alpha = 1.0;  // começa preto e faz fade in
title_timer = 0;
