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
        var _fcor = c_red;
        if (feedback_estado == "acertou") _fcor = c_lime;
        if (feedback_estado == "bonus")   _fcor = make_color_rgb(255, 220, 50);
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

// ===== SCROLL DE ENSINO =====
if (estado == "ensinando") {
    // Dim do fundo
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(5, 8, 22));
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);

    var _sw = min(900, _gw - 80);
    var _sh = 420;
    var _sx = _gw / 2 - _sw / 2;
    var _sy = _gh / 2 - _sh / 2 - 10;

    // Painel — fundo
    draw_set_color(make_color_rgb(12, 16, 42));
    draw_roundrect_ext(_sx, _sy, _sx + _sw, _sy + _sh, 12, 12, false);

    // Borda dupla dourada
    draw_set_color(make_color_rgb(200, 160, 50));
    draw_roundrect_ext(_sx,     _sy,     _sx + _sw,     _sy + _sh,     12, 12, true);
    draw_roundrect_ext(_sx + 4, _sy + 4, _sx + _sw - 4, _sy + _sh - 4, 9,  9,  true);

    // Titulo
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(255, 220, 80));
    draw_text_transformed(_gw / 2, _sy + 14, "\u2605  " + player_integron.nome + " te ensina!  \u2605", 1.5, 1.5, 0);

    // Subtitulo (metodo)
    draw_set_color(make_color_rgb(140, 180, 255));
    draw_text_transformed(_gw / 2, _sy + 48, "M\u00e9todo: " + player_integron.metodo, 1.2, 1.2, 0);

    // Linha divisoria
    draw_set_alpha(0.4);
    draw_set_color(make_color_rgb(200, 160, 50));
    draw_rectangle(_sx + 20, _sy + 76, _sx + _sw - 20, _sy + 78, false);
    draw_set_alpha(1);

    if (!ensino_retry_prompt) {
        // Contador de passos
        draw_set_halign(fa_right);
        draw_set_color(make_color_rgb(120, 140, 180));
        draw_text_transformed(_sx + _sw - 22, _sy + 84, "Passo " + string(ensino_passo_idx + 1) + "/" + string(ensino_total_passos), 1.1, 1.1, 0);

        // Texto do passo atual (typewriter)
        var _texto_step  = ensino_passos[ensino_passo_idx];
        var _chars_show  = min(string_length(_texto_step), ensino_chars_visiveis);
        var _texto_exibe = string_copy(_texto_step, 1, _chars_show);

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
        draw_text_ext_transformed(_sx + 28, _sy + 108, _texto_exibe, -1, _sw - 56, 1.55, 1.55, 0);

        // Dica de avanco
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        if (ensino_chars_visiveis >= string_length(_texto_step)) {
            draw_set_color(make_color_rgb(200, 200, 100));
            var _hint = (ensino_passo_idx < ensino_total_passos - 1) ? "[Enter] Pr\u00f3ximo passo" : "[Enter] Continuar";
            draw_text_transformed(_gw / 2, _sy + _sh - 12, _hint, 1.2, 1.2, 0);
        } else {
            draw_set_color(make_color_rgb(100, 100, 80));
            draw_text_transformed(_gw / 2, _sy + _sh - 12, "[Enter] Pular texto", 1.1, 1.1, 0);
        }

    } else {
        // Prompt de retry
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
        draw_text_transformed(_gw / 2, _sy + 96, "Entendeu o m\u00e9todo?", 1.9, 1.9, 0);

        draw_set_color(make_color_rgb(150, 255, 160));
        draw_text_ext_transformed(_gw / 2, _sy + 150, "Acerte agora e cause DANO B\u00d4NUS x1.5!", -1, _sw - 60, 1.4, 1.4, 0);

        var _btn_w = _sw / 2 - 30;
        var _btn_h = 58;
        var _btn_y = _sy + 230;

        // Botao [S]
        draw_set_color(make_color_rgb(35, 130, 50));
        draw_roundrect_ext(_sx + 20, _btn_y, _sx + 20 + _btn_w, _btn_y + _btn_h, 8, 8, false);
        draw_set_color(make_color_rgb(80, 220, 100));
        draw_roundrect_ext(_sx + 20, _btn_y, _sx + 20 + _btn_w, _btn_y + _btn_h, 8, 8, true);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        draw_text_transformed(_sx + 20 + _btn_w / 2, _btn_y + _btn_h / 2, "[S] Tentar novamente", 1.3, 1.3, 0);

        // Botao [N]
        draw_set_color(make_color_rgb(110, 30, 30));
        draw_roundrect_ext(_sx + _sw - 20 - _btn_w, _btn_y, _sx + _sw - 20, _btn_y + _btn_h, 8, 8, false);
        draw_set_color(make_color_rgb(200, 80, 80));
        draw_roundrect_ext(_sx + _sw - 20 - _btn_w, _btn_y, _sx + _sw - 20, _btn_y + _btn_h, 8, 8, true);
        draw_set_color(c_white);
        draw_text_transformed(_sx + _sw - 20 - _btn_w / 2, _btn_y + _btn_h / 2, "[N] Pular", 1.3, 1.3, 0);
    }
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
