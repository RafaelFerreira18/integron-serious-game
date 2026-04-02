/// @description State machine principal da batalha PvP.

// ===== INICIALIZA BARRAS NA PRIMEIRA EXECUCAO =====
if (!barras_prontas) {
    barras_prontas  = true;
    keyboard_string = "";
    overlay_ativo   = false;
    feedback_texto  = "";
    feedback_timer  = 0;
    feedback_estado = "";
    opcao_hover     = -1;

    with (obj_user_integron) {
        nome         = other.player_integron.nome;
        hp_total     = other.player_integron.hp_batalha;
        hp           = other.player_integron.hp_atual;
        hp_display   = hp;
        sprite_index = other.player_integron.sprite;
    }
    with (obj_user_enemy) {
        nome         = other.enemy_integron.nome;
        hp_total     = other.enemy_integron.hp_batalha;
        hp           = other.enemy_integron.hp_atual;
        hp_display   = hp;
        sprite_index = other.enemy_integron.sprite;
    }
}

estado_timer++;
input_cursor_timer = (input_cursor_timer + 1) mod 60;

// Hover botao CONFIRMAR (coordenadas espelham o Draw)
var _mx     = device_mouse_x_to_gui(0);
var _my     = device_mouse_y_to_gui(0);
var _cx     = display_get_gui_width() / 2;
var _conf_w = 280;
var _conf_h = 60;
var _conf_x = _cx - _conf_w / 2;
var _conf_y = 320;
btn_conf_hover = (overlay_ativo && input_ativo &&
    _mx >= _conf_x && _mx <= _conf_x + _conf_w &&
    _my >= _conf_y && _my <= _conf_y + _conf_h);

// ===== ESTADO: INTRO =====
if (estado == "intro") {
    if (estado_timer >= 140) {
        estado       = "aguardando_clique";
        estado_timer = 0;
    }
    exit;
}

// ===== ESTADO: AGUARDANDO CLIQUE (botao ATACAR na room) =====
if (estado == "aguardando_clique") {
    // obj_rock_smash trata o clique e muda para "aguardando_input"
    exit;
}

// ===== ESTADO: AGUARDANDO INPUT =====
if (estado == "aguardando_input") {
    if (input_ativo) {
        if (keyboard_check_pressed(vk_backspace) && string_length(input_texto) > 0) {
            input_texto = string_copy(input_texto, 1, string_length(input_texto) - 1);
        }
        if (keyboard_string != "") {
            input_texto    += keyboard_string;
            keyboard_string = "";
        }
        if (keyboard_check_pressed(vk_enter)) {
            input_ativo  = false;
            estado       = "verificando";
            estado_timer = 0;
        }
    }
    if (btn_conf_hover && mouse_check_button_pressed(mb_left)) {
        input_ativo  = false;
        estado       = "verificando";
        estado_timer = 0;
    }
    exit;
}

// ===== ESTADO: VERIFICANDO =====
if (estado == "verificando") {
    var _resp    = scr_normalizar_resposta(input_texto);
    var _acertou = false;
    var _aceitas = questao_atual.aceitas;

    for (var i = 0; i < array_length(_aceitas); i++) {
        if (_resp == scr_normalizar_resposta(_aceitas[i])) {
            _acertou = true;
            break;
        }
    }

    if (_acertou) {
        var _dmg = player_integron.dano_acerto;
        enemy_integron.hp_atual -= _dmg;
        with (obj_user_enemy) {
            hp               = other.enemy_integron.hp_atual;
            flicker_timer    = 20;
            dano_texto       = "-" + string(_dmg);
            dano_float_y     = 0;
            dano_float_timer = 40;
        }
        feedback_texto  = "Correto! -" + string(_dmg) + " HP no inimigo!";
        feedback_estado = "acertou";
    } else {
        feedback_texto  = "Errado! Resposta: " + _aceitas[0];
        feedback_estado = "errou";
    }
    feedback_timer = 120;
    estado         = "mostrando_feedback";
    estado_timer   = 0;
    exit;
}

// ===== ESTADO: MOSTRANDO FEEDBACK =====
if (estado == "mostrando_feedback") {
    if (feedback_timer > 0) {
        feedback_timer--;
    }
    if (feedback_timer <= 0) {
        overlay_ativo  = false;
        feedback_texto = "";
        if (feedback_estado == "acertou") {
            if (enemy_integron.hp_atual <= 0) {
                enemy_derrotado = true;
                estado          = "proximo_inimigo";
            } else {
                estado = "turno_inimigo";
            }
        } else {
            // Errou: inimigo ataca
            estado = "turno_inimigo";
        }
        estado_timer = 0;
    }
    exit;
}

// ===== ESTADO: TURNO INIMIGO =====
if (estado == "turno_inimigo") {
    if (estado_timer == 1) {
        // 35% de chance do inimigo errar o ataque
        if (irandom(99) < 35) {
            feedback_texto  = enemy_integron.nome + " errou o ataque!";
            feedback_estado = "inimigo_errou";
            feedback_timer  = 90;
        } else {
            var _dmg = enemy_integron.dano_acerto;
            player_integron.hp_atual -= _dmg;
            feedback_texto  = enemy_integron.nome + " acertou! -" + string(_dmg) + " HP!";
            feedback_estado = "inimigo_acertou";
            feedback_timer  = 90;
            with (obj_user_integron) {
                hp               = other.player_integron.hp_atual;
                flicker_timer    = 20;
                dano_texto       = "-" + string(_dmg);
                dano_float_y     = 0;
                dano_float_timer = 40;
            }
        }
    }
    if (feedback_timer > 0) feedback_timer--;
    if (estado_timer >= 90 && feedback_timer <= 0) {
        feedback_texto = "";
        if (player_integron.hp_atual <= 0) {
            player_derrotado = true;
            estado           = "proximo_player";
        } else {
            estado = "aguardando_clique";
        }
        estado_timer = 0;
    }
    exit;
}

// ===== ESTADO: PROXIMO INIMIGO =====
if (estado == "proximo_inimigo") {
    if (estado_timer == 1) {
        challenger_party_index++;
        enemy_derrotado = false;
        enemy_rot       = 0;

        if (challenger_party_index >= array_length(challenger.party)) {
            estado       = "vitoria";
            estado_timer = 0;
            exit;
        }

        enemy_integron = challenger.party[challenger_party_index];
        with (obj_user_enemy) {
            nome         = other.enemy_integron.nome;
            hp_total     = other.enemy_integron.hp_batalha;
            hp           = other.enemy_integron.hp_atual;
            hp_display   = hp;
            sprite_index = other.enemy_integron.sprite;
        }
    }
    if (estado_timer >= 100) {
        estado       = "aguardando_clique";
        estado_timer = 0;
    }
    exit;
}

// ===== ESTADO: PROXIMO PLAYER =====
if (estado == "proximo_player") {
    if (estado_timer == 1) {
        player_party_index++;
        player_derrotado = false;
        player_rot       = 0;

        if (player_party_index >= array_length(global.player_party)) {
            estado       = "derrota";
            estado_timer = 0;
            exit;
        }

        // Carrega o proximo integron da party do jogador
        var _todos2   = scr_integrons_data();
        var _proximo  = global.player_party[player_party_index];
        var _base2    = _todos2[0];
        for (var _pi = 0; _pi < array_length(_todos2); _pi++) {
            if (_todos2[_pi].nome == _proximo.nome) {
                _base2 = _todos2[_pi];
                break;
            }
        }
        player_integron = scr_pvp_clone_integron(_base2);
        with (obj_user_integron) {
            nome         = other.player_integron.nome;
            hp_total     = other.player_integron.hp_batalha;
            hp           = other.player_integron.hp_atual;
            hp_display   = hp;
            sprite_index = other.player_integron.sprite;
        }
    }
    if (estado_timer >= 100) {
        estado       = "aguardando_clique";
        estado_timer = 0;
    }
    exit;
}

// ===== ESTADO: VITORIA =====
if (estado == "vitoria") {
    if (estado_timer >= 200) {
        var _r = variable_global_exists("pvp_original_room") ? global.pvp_original_room : Room1;
        room_goto(_r);
    }
    exit;
}

// ===== ESTADO: DERROTA =====
if (estado == "derrota") {
    if (estado_timer >= 200) {
        var _r = variable_global_exists("pvp_original_room") ? global.pvp_original_room : Room1;
        room_goto(_r);
    }
    exit;
}
