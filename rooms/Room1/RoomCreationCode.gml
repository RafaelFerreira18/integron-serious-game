randomize();
// Audio agora e gerenciado pelo evento Room Start do obj_player

// ===== LIMPAR obj_elite_intro REMANESCENTE =====
// Pode sobreviver se criado na mesma room antes de sair.
with (obj_elite_intro) { instance_destroy(); }

// ===== DESTRUIR PORTAS DE CHALLENGERS DERROTADOS =====
// Roda apos todas as instancias ja terem sido criadas.
if (variable_global_exists("elite_derrotados")) {
    if (global.elite_derrotados[0] && instance_exists(porta_1)) instance_destroy(porta_1);
    if (global.elite_derrotados[1] && instance_exists(porta_2)) instance_destroy(porta_2);
    if (global.elite_derrotados[2] && instance_exists(porta_3)) instance_destroy(porta_3);
}