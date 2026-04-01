if (!inicializado) {
    var _switcher = instance_find(obj_battle_switcher, 0);
    show_debug_message("[controller] buscando switcher: " + string(instance_exists(_switcher)));
    if (!instance_exists(_switcher)) exit;
    show_debug_message("[controller] integron no switcher: " + string(_switcher.integron));
    if (is_undefined(_switcher.integron)) exit;
    
    integron      = _switcher.integron;
    original_room = _switcher.original_room;
    estado        = "batalha";
    inicializado  = true;
    show_debug_message("[controller] Integron carregado: " + integron.nome);
    exit;
}

if (!overlay_ativo) exit;

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
            room_goto(rm_overworld);
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
                feedback_texto  = "Correto! " + integron.nome + " foi capturado!";
                feedback_estado = "acertou";
            } else {
                feedback_texto  = "Errado! " + integron.nome + " fugiu...";
                feedback_estado = "errou";
            }
            feedback_timer = 180;
        }
        break;
    }
}