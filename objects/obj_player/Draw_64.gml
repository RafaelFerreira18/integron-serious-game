if (!variable_global_exists("player_party")) {
    global.player_party = [];
}
if (!variable_global_exists("player_party_max")) {
    global.player_party_max = 4;
}

draw_set_font(-1);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(12, 12, "[P] Party");

if (smash_prompt_ativo && !smash_quiz_ativo && smash_feedback_timer <= 0) {
    draw_set_alpha(0.9);
    draw_set_color(c_black);
    draw_rectangle(12, 182, 300, 212, false);
    draw_set_alpha(1);
    draw_set_color(c_yellow);
    draw_rectangle(12, 182, 300, 212, true);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text(20, 197, "[E] SMASSSHHHH!!!");
}

// Prompt do Integron Center
if (instance_exists(obj_integron_center) && obj_integron_center.prompt_ativo) {
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(10, 55, 35));
    draw_rectangle(12, 182, 300, 212, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(80, 220, 140));
    draw_rectangle(12, 182, 300, 212, true);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 255, 160));
    draw_text(20, 197, "[E] Curar Integrons");
}

// Confirmacao de cura
if (instance_exists(obj_integron_center) && obj_integron_center.cura_feedback_timer > 0) {
    var _fa = min(1, obj_integron_center.cura_feedback_timer / 30);
    draw_set_alpha(_fa);
    draw_set_color(make_color_rgb(10, 55, 35));
    draw_rectangle(12, 182, 320, 212, false);
    draw_set_alpha(_fa);
    draw_set_color(make_color_rgb(80, 220, 140));
    draw_rectangle(12, 182, 320, 212, true);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(180, 255, 200));
    draw_text(20, 197, "Integrons curados!");
    draw_set_alpha(1);
}

if (party_overlay_ativo) {
    var _x = 12;
    var _y = 36;
    var _w = 300;
    var _h = 140;

    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_rectangle(_x, _y, _x + _w, _y + _h, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(_x, _y, _x + _w, _y + _h, true);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(_x + 10, _y + 8, "PARTY (" + string(array_length(global.player_party)) + "/" + string(global.player_party_max) + ")");

    var _linha_y = _y + 30;
    for (var i = 0; i < global.player_party_max; i++) {
        var _txt = string(i + 1) + ". [vazio]";

        if (i < array_length(global.player_party)) {
            var _itg  = global.player_party[i];
            var _nome = variable_struct_exists(_itg, "nome")    ? string(_itg.nome)    : "Integron";
            var _hpa  = variable_struct_exists(_itg, "hp_atual") ? _itg.hp_atual        : 0;
            var _hpm  = variable_struct_exists(_itg, "hp_max")   ? _itg.hp_max          : 60;
            var _hp_txt = string(max(0, _hpa)) + "/" + string(_hpm);
            if (_hpa <= 0) _hp_txt = "MORTO";
            _txt = string(i + 1) + ". " + _nome + "  HP: " + _hp_txt;
        }

        draw_text(_x + 10, _linha_y + i * 22, _txt);
    }
}

if (smash_quiz_ativo) {
    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(display_get_gui_width() / 2, 120, "Use SMASSSHHHH!!!");
    draw_text(display_get_gui_width() / 2, 160, smash_integral);

    var _larg = 300;
    var _alt = 70;
    var _gap = 18;
    var _ox = (display_get_gui_width() - (_larg * 2 + _gap)) / 2;
    var _oy = 240;

    for (var j = 0; j < 4; j++) {
        var _bx = _ox + (j mod 2) * (_larg + _gap);
        var _by = _oy + (j div 2) * (_alt + _gap);

        draw_set_color(j == smash_opcao_hover ? c_yellow : make_color_rgb(40, 60, 80));
        draw_roundrect_ext(_bx, _by, _bx + _larg, _by + _alt, 8, 8, false);

        draw_set_color(c_white);
        draw_roundrect_ext(_bx, _by, _bx + _larg, _by + _alt, 8, 8, true);

        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_bx + _larg / 2, _by + _alt / 2, smash_opcoes[j]);
    }
}

if (smash_feedback_timer > 0) {
    draw_set_alpha(0.85);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(smash_feedback_estado == "acertou" ? c_lime : c_red);
    draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2, smash_feedback_texto);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
