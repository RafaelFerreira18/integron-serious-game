/// @description Detectar proximidade do jogador e iniciar batalha automaticamente.

bob_timer++;

// LOG: verifica se obj_player existe
if (!instance_exists(obj_player)) {
    if (bob_timer mod 60 == 0) show_debug_message("[npc_elite] ERRO: obj_player nao existe no room!");
    exit;
}

var _dist_atual = point_distance(x, y, obj_player.x, obj_player.y);

// LOG a cada 60 frames: distancia atual e estado
if (bob_timer mod 60 == 0) {
    show_debug_message("[npc_elite] dist=" + string(_dist_atual)
        + " | interact_dist=" + string(interact_dist)
        + " | spotted=" + string(spotted)
        + " | spotted_timer=" + string(spotted_timer)
        + " | intro_existe=" + string(instance_exists(obj_elite_intro)));
}

// --- Sequencia de avistamento em andamento ---
if (spotted) {
    spotted_timer++;
    excl_bob = sin(spotted_timer * 14 * pi / 180) * 4;

    if (spotted_timer == 1) {
        show_debug_message("[npc_elite] SPOTTED! Iniciando contagem para batalha...");
    }

    // Apos ~70 frames (~1,15 s): dispara a batalha (executa so uma vez)
    if (spotted_timer == 70) {
        show_debug_message("[npc_elite] 70 frames! Tentando criar obj_elite_intro...");
        show_debug_message("  intro_existe=" + string(instance_exists(obj_elite_intro)));
        show_debug_message("  rm_battle_integrons=" + string(rm_battle_integrons));
        global.pvp_challenger_index = challenger_index;
        global.pvp_original_room    = room;
        if (!instance_exists(obj_elite_intro)) {
            var _intro = instance_create_depth(0, 0, -9999, obj_elite_intro);
            _intro.target_room = rm_battle_integrons;
            show_debug_message("[npc_elite] obj_elite_intro criado! id=" + string(_intro));
        } else {
            show_debug_message("[npc_elite] obj_elite_intro ja existe, pulando criacao.");
        }
    }
    if (aviso_timer > 0) aviso_timer--;
    exit;
}

// --- Cooldown apos sair de batalha ---
if (global.elite_battle_cooldown > 0) {
    global.elite_battle_cooldown--;
    spotted       = false;
    spotted_timer = 0;
    if (aviso_timer > 0) aviso_timer--;
    exit;
}

// --- Deteccao de proximidade (so uma vez, intro nao ativa) ---
if (!instance_exists(obj_elite_intro)) {
    if (_dist_atual <= interact_dist) {
        show_debug_message("[npc_elite] Jogador entrou no raio! dist=" + string(_dist_atual) + " <= " + string(interact_dist));
        spotted       = true;
        spotted_timer = 0;
    }
}

if (aviso_timer > 0) aviso_timer--;
