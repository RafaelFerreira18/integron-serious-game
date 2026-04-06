/// @description Inicializa variáveis da animação de intro de batalha estilo Pokémon BW.

// Para a musica do overworld
if (variable_global_exists("bgm_exploring") && audio_is_playing(global.bgm_exploring)) {
    audio_stop_sound(global.bgm_exploring);
}

// Toca musica do final boss se for o AXIOM, senao toca musica da elite four
if (variable_global_exists("pvp_challenger_index") && global.pvp_challenger_index == 3) {
    audio_play_sound(sound_final_boss, 1, true);
} else {
    audio_play_sound(sound_elite_four_battle, 1, true);
}

phase = 0;
timer = 0;

// gui_w/h/cx/cy são recalculados no Draw GUI a cada frame para garantir valores corretos
gui_w = 1280;
gui_h = 720;
cx    = gui_w * 0.5;
cy    = gui_h * 0.5;

// Sprite do NPC — sera sobrescrito pelo NPC que criou esta instancia (_intro.spr_trainer = sprite_index)
spr_trainer = spr_npc1;

// --- Fase 0: slide da direita ---
trainer_x = gui_w + 200;
trainer_y = cy;

// --- Fase 1: flash branco ---
flash_alpha    = 0;
flash_going_up = true;

// Sala de destino ao fim da animação (pode ser sobrescrita ao criar a instância)
target_room = rm_battle_integrons;

// --- Fase 2: corte diagonal ---
diag_x = -gui_h;   // começa fora da tela pela esquerda

// --- Fase 3/4: outline pulsante e zoom ---
outline_phase = 0;
spr_scale     = 3.0;
