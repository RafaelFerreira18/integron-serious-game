/// @description Inicializa variáveis da animação de intro de batalha estilo Pokémon BW.

// Para a musica do overworld
if (variable_global_exists("bgm_exploring") && audio_is_playing(global.bgm_exploring)) {
    audio_stop_sound(global.bgm_exploring);
}

phase = 0;
timer = 0;

// gui_w/h/cx/cy são recalculados no Draw GUI a cada frame para garantir valores corretos
gui_w = 1280;
gui_h = 720;
cx    = gui_w * 0.5;
cy    = gui_h * 0.5;

// Sprite de teste — usa o mesmo sprite do obj_npc_elite
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
