if (!overlay_ativo) exit;

// Countdown do feedback
if (feedback_timer > 0) {
    feedback_timer--;
    // Quando o timer acabar, volta ao mapa
    if (feedback_timer == 0) {
        var _room_orig = instance_find(obj_battle_switcher, 0).original_room;
        instance_destroy(instance_find(obj_battle_switcher, 0));
        room_goto(_room_orig);
    }
    exit;
}

// Detecta clique nas opções
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _larg = 400;
var _alt  = 80;
var _gap  = 20;
var _ox   = (1280 - (_larg * 2 + _gap)) / 2;
var _oy   = 320;

for (var i = 0; i < 4; i++) {
    var _bx = _ox + (i mod 2) * (_larg + _gap);
    var _by = _oy + (i div 2) * (_alt  + _gap);
    if (point_in_rectangle(_mx, _my, _bx, _by, _bx + _larg, _by + _alt)) {
        opcao_hover = i;
        if (mouse_check_button_pressed(mb_left)) {
            if (i == integron.resposta) {
                feedback_texto  = "Correto! " + integron.nome + " foi capturado!";
                feedback_estado = "acertou";
            } else {
                feedback_texto  = "Errado! " + integron.nome + " fugiu...";
                feedback_estado = "errou";
            }
            feedback_timer = 180;
        }
        break;
    } else {
        opcao_hover = -1;
    }
}