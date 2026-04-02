if (!inicializado) {
    var _switcher = instance_find(obj_battle_switcher, 0);
    show_debug_message("[controller] buscando switcher: " + string(instance_exists(_switcher)));
    if (!instance_exists(_switcher)) exit;
    show_debug_message("[controller] integron no switcher: " + string(_switcher.integron));
    if (is_undefined(_switcher.integron)) exit;
    
    integron      = _switcher.integron;
    original_room = _switcher.original_room;

    // Embaralha as opcoes de resposta a cada batalha e atualiza o indice correto.
    if (is_struct(integron)
    && variable_struct_exists(integron, "opcoes")
    && variable_struct_exists(integron, "resposta")) {
        var _total = array_length(integron.opcoes);
        if (_total > 1) {
            var _ordem = array_create(_total, 0);
            for (var i = 0; i < _total; i++) {
                _ordem[i] = i;
            }

            // Fisher-Yates
            for (var j = _total - 1; j > 0; j--) {
                var _k = irandom(j);
                var _tmp = _ordem[j];
                _ordem[j] = _ordem[_k];
                _ordem[_k] = _tmp;
            }

            var _opcoes_embaralhadas = array_create(_total, "");
            var _resposta_nova = 0;

            for (var n = 0; n < _total; n++) {
                var _indice_original = _ordem[n];
                _opcoes_embaralhadas[n] = integron.opcoes[_indice_original];
                if (_indice_original == integron.resposta) {
                    _resposta_nova = n;
                }
            }

            integron.opcoes = _opcoes_embaralhadas;
            integron.resposta = _resposta_nova;
        }
    }

    estado        = "batalha";
    inicializado  = true;
    show_debug_message("[controller] Integron carregado: " + integron.nome);
    exit;
}

if (!overlay_ativo) exit;

// ===== ANIMACAO DE CAPTURA =====
if (captura_ativo) {
    captura_timer++;

    switch (captura_fase) {

        case "voando":
            // Bola voa em arco do jogador ate o inimigo
            var _t = captura_timer / 50;
            if (_t > 1) _t = 1;
            cap_bola_x = lerp(248, 1028, _t);
            cap_bola_y = lerp(480, 280, _t) - sin(_t * pi) * 200;
            cap_bola_rot = (cap_bola_rot + 14) mod 360;
            if (captura_timer >= 50) {
                cap_bola_x   = 1028;
                cap_bola_y   = 280;
                captura_fase = "absorvendo";
                captura_timer = 0;
            }
        break;

        case "absorvendo":
            // Inimigo pisca e encolhe para dentro da bola
            var _t = captura_timer / 40;
            if (_t > 1) _t = 1;
            if ((captura_timer mod 6) < 3) {
                cap_inimigo_alpha = 1 - _t;
            } else {
                cap_inimigo_alpha = 0;
            }
            cap_inimigo_scale = 1 - _t;
            cap_bola_rot      = (cap_bola_rot + 8) mod 360;
            if (captura_timer >= 40) {
                cap_inimigo_alpha = 0;
                cap_inimigo_scale = 0;
                captura_fase      = "caindo";
                captura_timer     = 0;
            }
        break;

        case "caindo":
            // Bola cai ao chao com gravidade
            var _t = captura_timer / 25;
            cap_bola_y   = 280 + _t * _t * 200;
            cap_bola_rot = (cap_bola_rot + 10) mod 360;
            if (captura_timer >= 25) {
                cap_bola_y   = 480;
                cap_bola_rot = 0;
                captura_fase  = "balancando";
                captura_timer = 0;
            }
        break;

        case "balancando":
            // 3 balancadas (wobble) de 30 quadros cada
            cap_bola_rot = sin((captura_timer / 30) * pi * 2) * 22;
            if (captura_timer >= 90) {
                cap_bola_rot = 0;
                // Criar particulas de estrela
                cap_estrelas = [];
                for (var _s = 0; _s < 8; _s++) {
                    cap_estrelas[_s] = {
                        angle : (_s / 8) * 360,
                        dist  : 0,
                        spd   : 2.5 + random(1.5)
                    };
                }
                captura_fase  = "capturado";
                captura_timer = 0;
            }
        break;

        case "capturado":
            // Partículas se expandem
            for (var _s = 0; _s < array_length(cap_estrelas); _s++) {
                cap_estrelas[_s].dist += cap_estrelas[_s].spd;
            }
            if (captura_timer >= 80) {
                // Animacao terminou — inicia contagem para voltar ao mapa
                captura_ativo = false;
                captura_fase  = "fim";
                feedback_timer = 90;
            }
        break;
    }
    exit;  // bloqueia interacao de botoes durante a animacao
}

if (feedback_timer > 0) {
    feedback_timer--;

    if (feedback_timer == 0) {
        var _sw = instance_find(obj_battle_switcher, 0);
	    show_debug_message("switcher existe: " + string(instance_exists(_sw)));
		show_debug_message("_sw value: " + string(_sw));
        if (instance_exists(_sw)) {
            var _room_orig = _sw.original_room;
            instance_destroy(_sw);
            room_goto(_room_orig);
        } else {
            // switcher sumiu, volta para o overworld como fallback
            room_goto(Room1);
        }
    }
    exit;
}

var _mx   = device_mouse_x_to_gui(0);
var _my   = device_mouse_y_to_gui(0);
var _larg = 400;
var _alt  = 80;
var _gap  = 20;
var _ox   = (1280 - (_larg * 2 + _gap)) / 2;
var _oy   = 320;

opcao_hover = -1;

for (var i = 0; i < 4; i++) {
    var _bx = _ox + (i mod 2) * (_larg + _gap);
    var _by = _oy + (i div 2) * (_alt  + _gap);

    if (point_in_rectangle(_mx, _my, _bx, _by, _bx + _larg, _by + _alt)) {
        opcao_hover = i;

        if (mouse_check_button_pressed(mb_left)) {
            if (i == integron.resposta) {
                var _nome_integron = "Integron";
                if (is_struct(integron) && variable_struct_exists(integron, "nome")) {
                    _nome_integron = string(integron.nome);
                }

                if (!variable_global_exists("player_party")) {
                    global.player_party = [];
                }
                if (!variable_global_exists("player_party_max")) {
                    global.player_party_max = 4;
                }

                if (array_length(global.player_party) < global.player_party_max) {
                    var _capturado = {
                        nome: _nome_integron,
                        sprite: variable_struct_exists(integron, "sprite") ? integron.sprite : noone,
                        hp: variable_struct_exists(integron, "hp") ? integron.hp : 0,
                        metodo: variable_struct_exists(integron, "metodo") ? integron.metodo : "",
                        integral: variable_struct_exists(integron, "integral") ? integron.integral : ""
                    };

                    var _party_len = array_length(global.player_party);
                    global.player_party[_party_len] = _capturado;

                    feedback_texto = _nome_integron + " foi para a party! (" + string(array_length(global.player_party)) + "/" + string(global.player_party_max) + ")";
                } else {
                    feedback_texto = _nome_integron + " foi derrotado... party cheia (" + string(global.player_party_max) + ")";
                }
                feedback_estado = "acertou";
                // Dispara animacao de captura
                captura_ativo     = true;
                captura_fase      = "voando";
                captura_timer     = 0;
                cap_bola_x        = 248;
                cap_bola_y        = 480;
                cap_bola_rot      = 0;
                cap_inimigo_alpha = 1;
                cap_inimigo_scale = 1;
                // feedback_timer sera setado ao fim da animacao
            } else {
                feedback_texto  = "Errado! " + integron.nome + " fugiu...";
                feedback_estado = "errou";
                feedback_timer  = 180;
            }
        }
        break;
    }
}