randomize();
// Audio agora e gerenciado pelo evento Room Start do obj_player

// ===== TUTORIAL NA PRIMEIRA VEZ =====
if (!variable_global_exists("tutorial_visto")) {
    global.tutorial_visto = false;
}
if (!global.tutorial_visto) {
    instance_create_depth(0, 0, -10000, obj_tutorial);
}

// ===== LIMPAR obj_elite_intro REMANESCENTE =====
// Pode sobreviver se criado na mesma room antes de sair.
with (obj_elite_intro) { instance_destroy(); }
// Destroi battle_switcher persistente de jogadas anteriores
with (obj_battle_switcher) { instance_destroy(); }

// ===== DESTRUIR PORTAS DE CHALLENGERS DERROTADOS =====
// Roda apos todas as instancias ja terem sido criadas.
if (variable_global_exists("elite_defeated")) {
    if (global.elite_defeated[0] && instance_exists(porta_1)) instance_destroy(porta_1);
    if (global.elite_defeated[1] && instance_exists(porta_2)) instance_destroy(porta_2);
    if (global.elite_defeated[2] && instance_exists(porta_3)) instance_destroy(porta_3);
}