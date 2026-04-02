/// @description Desenhar UI de batalha PvP (Draw GUI).

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// ===== NOME DO INIMIGO (canto superior esquerdo) =====
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
if (!is_undefined(enemy_integron)) {
    draw_text(4, 4, enemy_integron.nome);
    draw_text(4, 16, "Metodo: " + enemy_integron.metodo);
}

// ===== OVERLAY FULLSCREEN (igual ao sistema de captura) =====
if (overlay_ativo) {

    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);

    var _cx = _gw / 2;

    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(_cx, 60, "Resolva a integral para atacar!");

    draw_set_color(make_color_rgb(255, 220, 50));
    draw_text(_cx, 110, questao_enunciado);

    var _larg = 820;
    var _bx   = _cx - _larg / 2;
    var _by   = 200;
    var _bh   = 80;

    draw_set_color(make_color_rgb(20, 25, 45));
    draw_roundrect_ext(_bx, _by, _bx + _larg, _by + _bh, 8, 8, false);
    draw_set_color(make_color_rgb(80, 120, 200));
    draw_roundrect_ext(_bx, _by, _bx + _larg, _by + _bh, 8, 8, true);

    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(160, 190, 255));
    draw_text_transformed(_bx + 12, _by + 8, "Sua resposta:", 1.1, 1.1, 0);

    var _exibe = input_texto;
    if (input_ativo && input_cursor_timer < 30) { _exibe += "|"; }
    draw_set_color(c_white);
    draw_text_transformed(_bx + 12, _by + 38, _exibe, 1.6, 1.6, 0);

    var _conf_w = 280;
    var _conf_h = 60;
    var _conf_x = _cx - _conf_w / 2;
    var _conf_y = _by + _bh + 20;

    if (btn_conf_hover) {
        draw_set_color(make_color_rgb(80, 200, 80));
    } else {
        draw_set_color(make_color_rgb(40, 130, 50));
    }
    draw_roundrect_ext(_conf_x, _conf_y, _conf_x + _conf_w, _conf_y + _conf_h, 8, 8, false);
    draw_set_color(make_color_rgb(180, 255, 180));
    draw_roundrect_ext(_conf_x, _conf_y, _conf_x + _conf_w, _conf_y + _conf_h, 8, 8, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_conf_x + _conf_w / 2, _conf_y + _conf_h / 2, "CONFIRMAR  [Enter]");

    if (feedback_timer > 0) {
        var _fcor = (feedback_estado == "acertou") ? c_lime : c_red;
        draw_set_color(_fcor);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_text_transformed(_cx, _conf_y + _conf_h + 20, feedback_texto, 1.6, 1.6, 0);
    }

    draw_set_alpha(1);
}

// ===== FEEDBACK DO TURNO INIMIGO (fora do overlay) =====
if (!overlay_ativo && feedback_timer > 0 && estado == "turno_inimigo") {
    var _fcor = (feedback_estado == "inimigo_acertou") ? make_color_rgb(255, 80, 80) : make_color_rgb(80, 200, 255);
    var _fa   = min(1, feedback_timer / 30);
    draw_set_alpha(_fa);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(_fcor);
    draw_text_transformed(_gw / 2, _gh / 2 + 160, feedback_texto, 1.6, 1.6, 0);
    draw_set_alpha(1);
}

// ===== INTRO =====
if (estado == "intro") {
    draw_set_alpha(max(0, 1 - estado_timer / 60));
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);
    if (estado_timer < 80) {
        var _a = min(1, estado_timer / 30);
        draw_set_alpha(_a);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(challenger.cor);
        draw_text_transformed(_gw / 2, _gh / 2 - 40, challenger.nome + " quer lutar!", 3, 3, 0);
        draw_set_color(c_white);
        draw_text_transformed(_gw / 2, _gh / 2 + 20, challenger.subtitulo, 1.8, 1.8, 0);
        draw_set_alpha(1);
    }
}

// ===== VITORIA / DERROTA =====
if (estado == "vitoria" || estado == "derrota") {
    var _fade = min(1, (estado_timer - 30) / 60);
    draw_set_alpha(_fade * 0.7);
    draw_set_color(estado == "vitoria" ? make_color_rgb(10, 30, 10) : make_color_rgb(30, 10, 10));
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(_fade);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    if (estado == "vitoria") {
        draw_set_color(make_color_rgb(255, 220, 50));
        draw_text_transformed(_gw / 2, _gh / 2 - 30, "VITORIA!", 5, 5, 0);
        draw_set_color(c_white);
        draw_text_transformed(_gw / 2, _gh / 2 + 50, "Voce derrotou " + challenger.nome + "!", 2, 2, 0);
    } else {
        draw_set_color(make_color_rgb(220, 50, 50));
        draw_text_transformed(_gw / 2, _gh / 2 - 30, "DERROTA...", 5, 5, 0);
        draw_set_color(c_white);
        draw_text_transformed(_gw / 2, _gh / 2 + 50, player_integron.nome + " foi derrotado!", 2, 2, 0);
    }
    draw_set_alpha(1);
}

// ===== RESET =====
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
