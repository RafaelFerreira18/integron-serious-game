/// @description Inicializar o controlador de batalha PvP.

// Limpa teclado acumulado do mapa ANTES de qualquer leitura
keyboard_string = "";

// ===== DADOS DO CHALLENGER =====
// global.pvp_challenger_index deve ser setado antes de entrar na room.
// Para testes, default = 0 (Aria).
if (!variable_global_exists("pvp_challenger_index")) {
    global.pvp_challenger_index = 0;
}

// Garante posicionamento consistente dos integrons na room, independente do tamanho da janela.
if (instance_exists(obj_user_integron)) {
    var _u_player = instance_find(obj_user_integron, 0);
    _u_player.x = room_width * 0.1957;
    _u_player.y = room_height * 0.5;
}
if (instance_exists(obj_user_enemy)) {
    var _u_enemy = instance_find(obj_user_enemy, 0);
    _u_enemy.x = room_width * 0.8;
    _u_enemy.y = room_height * 0.5182;
}

var _challengers = scr_elite_four_data();
challenger             = _challengers[global.pvp_challenger_index];
challenger_party_index = 0;
player_party_index     = 0;

// Encontra o primeiro integron VIVO na party do jogador
for (var _pi = 0; _pi < array_length(global.player_party); _pi++) {
    var _check = global.player_party[_pi];
    var _check_hp = variable_struct_exists(_check, "hp_atual") ? _check.hp_atual : 1;
    if (_check_hp > 0) {
        player_party_index = _pi;
        break;
    }
}

// Integron ativo do jogador: primeiro VIVO da party
var _todos_c   = scr_integrons_data();
var _primeiro  = global.player_party[player_party_index];
var _base_c    = _todos_c[0];
for (var _ci = 0; _ci < array_length(_todos_c); _ci++) {
    if (_todos_c[_ci].nome == _primeiro.nome) {
        _base_c = _todos_c[_ci];
        break;
    }
}
player_integron = scr_pvp_clone_integron(_base_c);
// Usa HP salvo da party (pode ter tomado dano em batalha anterior)
var _hp_salvo = variable_struct_exists(_primeiro, "hp_atual") ? _primeiro.hp_atual : _base_c.hp_batalha;
player_integron.hp_atual = max(1, _hp_salvo);

// Integron ativo do inimigo
enemy_integron   = challenger.party[challenger_party_index];

// ===== STATE MACHINE =====
// Estados: "intro" | "turno_player" | "aguardando_input" | "verificando"
//          | "player_acertou" | "player_errou" | "turno_inimigo"
//          | "proximo_inimigo" | "vitoria" | "derrota"
estado        = "intro";
estado_timer  = 0;
barras_prontas = false;
overlay_ativo  = false;
feedback_texto = "";
feedback_timer = 0;
feedback_estado = "";
opcao_hover    = -1;

// ===== QUESTAO ATUAL =====
questao_atual    = undefined;
questao_enunciado = "";

// ===== INPUT DO JOGADOR =====
input_texto      = "";
input_ativo      = false;
input_cursor_timer = 0;  // piscar cursor

// ===== BOTAO CONFIRMAR =====
btn_conf_x  = 690;
btn_conf_y  = 670;
btn_conf_w  = 200;
btn_conf_h  = 50;
btn_conf_hover = false;

// ===== MENSAGEM DE STATUS =====
msg_texto    = "A batalha começa!";
msg_timer    = 120;

// ===== EFEITO DE DANO NO SPRITE =====
// Sprite do inimigo (posicao GUI)
enemy_spr_x  = 1028;
enemy_spr_y  = 200;
enemy_spr_scale = 4;
enemy_derrotado = false;
enemy_rot    = 0;

// Sprite do jogador
player_spr_x = 260;
player_spr_y = 480;
player_spr_scale = 4;
player_derrotado = false;
player_rot   = 0;

// ===== BARRAS DE HP: inicializadas no Step_0 apos criacao das instancias =====

// ===== SISTEMA DE ENSINO =====
ensino_passos         = [];
ensino_passo_idx      = 0;
ensino_total_passos   = 0;
ensino_chars_visiveis = 0;
ensino_retry_prompt   = false;
ensino_retry_ativo    = false;
ensino_ja_visto       = false;  // true apos o scroll ser exibido uma vez por questao
