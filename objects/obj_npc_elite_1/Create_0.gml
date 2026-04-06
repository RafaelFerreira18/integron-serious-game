/// @description NPC desafiante da Elite Four.
challenger_index = 0;   // 0 = Aria (primeiro challenger)
prompt_ativo     = false;
interact_dist    = 48;   // distancia em pixels para disparar o avistamento
interact_tecla   = ord("E");

// Balanco idle
bob_timer = 0;

// Avistamento — caixa "!" automatica
spotted       = false;   // true quando jogador entrou no raio
spotted_timer = 0;       // frames apos avistar
excl_bob      = 0;       // offset vertical da animacao do "!"

// Cooldown global — impede reengajamento imediato apos sair de batalha
if (!variable_global_exists("elite_battle_cooldown")) {
    global.elite_battle_cooldown = 0;
}

// Aviso para o jogador
aviso_texto = "";
aviso_timer = 0;
