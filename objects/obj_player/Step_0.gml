var _hor = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _ver = keyboard_check(ord("S")) - keyboard_check(ord("W"));

if (grass_encounter_timer > 0) {
    grass_encounter_timer--;
}

if (keyboard_check_pressed(party_overlay_tecla)) {
    party_overlay_ativo = !party_overlay_ativo;
}

if (smash_quiz_ativo || smash_feedback_timer > 0) {
    _hor = 0;
    _ver = 0;
}

var _mov_x = _hor * move_speed;
var _mov_y = _ver * move_speed;

// Bloqueia passagem por obstaculos de smash enquanto nao forem destruidos.
if (_mov_x != 0 && (place_meeting(x + _mov_x, y, Object16) || place_meeting(x + _mov_x, y, D_Baril))) {
    _mov_x = 0;
}
if (_mov_y != 0 && (place_meeting(x, y + _mov_y, Object16) || place_meeting(x, y + _mov_y, D_Baril))) {
    _mov_y = 0;
}

move_and_collide(_mov_x, _mov_y, tilemap);

if(_hor != 0 or _ver != 0){
    if(_ver > 0) sprite_index = spr_player_walk_down;
    else if(_ver < 0) sprite_index = spr_player_walk_up;
    else if(_hor > 0) sprite_index = spr_player_walk_right;
    else if(_hor < 0) sprite_index = spr_player_walk_left;
}
else{
    if(sprite_index == spr_player_walk_right) sprite_index = spr_player_idle_right;
    else if(sprite_index == spr_player_walk_left) sprite_index = spr_player_idle_left;
    else if(sprite_index == spr_player_walk_up) sprite_index = spr_player_idle_up;
    else if(sprite_index == spr_player_walk_down) sprite_index = spr_player_idle_down;
}

if (smash_feedback_timer > 0) {
    smash_feedback_timer--;
    if (smash_feedback_timer <= 0) {
        smash_feedback_texto = "";
        smash_feedback_estado = "";
    }
    exit;
}

if (smash_quiz_ativo) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    var _larg = 300;
    var _alt = 70;
    var _gap = 18;
    var _ox = (display_get_gui_width() - (_larg * 2 + _gap)) / 2;
    var _oy = 240;

    smash_opcao_hover = -1;

    for (var i = 0; i < 4; i++) {
        var _bx = _ox + (i mod 2) * (_larg + _gap);
        var _by = _oy + (i div 2) * (_alt + _gap);

        if (point_in_rectangle(_mx, _my, _bx, _by, _bx + _larg, _by + _alt)) {
            smash_opcao_hover = i;

            if (mouse_check_button_pressed(mb_left)) {
                if (i == smash_resposta) {
                    if (instance_exists(smash_alvo)) {
                        with (smash_alvo) {
                            instance_destroy();
                        }
                    }
                    smash_feedback_texto = "SMASSSHHHH!!! Obstaculo destruido!";
                    smash_feedback_estado = "acertou";
                } else {
                    smash_feedback_texto = "Errou a integral! O obstaculo nao quebrou.";
                    smash_feedback_estado = "errou";
                }

                smash_quiz_ativo = false;
                smash_prompt_ativo = false;
                smash_alvo = noone;
                smash_feedback_timer = 90;
            }
            break;
        }
    }

    exit;
}

var _obstaculo_smash = instance_place(x, y, Object16);
if (!instance_exists(_obstaculo_smash)) {
    _obstaculo_smash = instance_place(x, y, D_Baril);
}
if (instance_exists(_obstaculo_smash)) {
    smash_prompt_ativo = true;
    smash_alvo = _obstaculo_smash;

    if (keyboard_check_pressed(smash_tecla)) {
        var _q = smash_perguntas[irandom(array_length(smash_perguntas) - 1)];
        smash_integral = _q.integral;

        var _total = array_length(_q.opcoes);
        var _ordem = array_create(_total, 0);
        for (var n = 0; n < _total; n++) {
            _ordem[n] = n;
        }

        for (var j = _total - 1; j > 0; j--) {
            var _k = irandom(j);
            var _tmp = _ordem[j];
            _ordem[j] = _ordem[_k];
            _ordem[_k] = _tmp;
        }

        smash_opcoes = array_create(_total, "");
        smash_resposta = 0;

        for (var m = 0; m < _total; m++) {
            var _indice_original = _ordem[m];
            smash_opcoes[m] = _q.opcoes[_indice_original];
            if (_indice_original == _q.resposta) {
                smash_resposta = m;
            }
        }

        smash_quiz_ativo = true;
        smash_opcao_hover = -1;
    }
} else {
    smash_prompt_ativo = false;
    smash_alvo = noone;
}

