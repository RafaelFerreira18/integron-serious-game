/// @description Integron Center — Draw.
var _bob = sin(bob_timer * 3 * pi / 180) * 1;

// ===== PLACA PERMANENTE ACIMA DO NPC =====
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(10, 55, 35));
draw_roundrect_ext(x - 22, y - 44, x + 22, y - 26, 4, 4, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(80, 220, 140));
draw_roundrect_ext(x - 22, y - 44, x + 22, y - 26, 4, 4, true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(180, 255, 200));
draw_text_transformed(x, y - 35, "+ CURA", 0.85, 0.85, 0);

// Sprite do curandeiro
draw_sprite_ext(spr_npc1, 0, x, y + _bob, 1, 1, 0, c_white, 1);

// Flash de cura (brilho branco sobre o NPC)
if (cura_flash_timer > 0) {
    var _fa = (cura_flash_timer / 80);
    draw_set_alpha(_fa * 0.7);
    draw_set_color(make_color_rgb(200, 255, 220));
    draw_rectangle(x - 8, y - 16, x + 8, y + 8, false);
    draw_set_alpha(1);
}

// Prompt [E]
if (prompt_ativo) {
    var _px = x;
    var _py = y - 22 + _bob;

    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(10, 60, 40));
    draw_roundrect_ext(_px - 54, _py - 20, _px + 54, _py + 2, 4, 4, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(80, 220, 140));
    draw_roundrect_ext(_px - 54, _py - 20, _px + 54, _py + 2, 4, 4, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(make_color_rgb(255, 255, 160));
    draw_text_transformed(_px, _py - 1, "[E] Curar Integrons", 0.9, 0.9, 0);
}

// ===== OVERLAY DE CURA =====
if (overlay_ativo) {
    var _gw = display_get_gui_width();
    var _gh = display_get_gui_height();

    draw_set_alpha(0.80);
    draw_set_color(make_color_rgb(5, 15, 10));
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);

    var _pw = 520;
    var _ph = 80 + max(1, variable_global_exists("player_party") ? array_length(global.player_party) : 0) * 56 + 90;
    var _px2 = _gw / 2 - _pw / 2;
    var _py2 = _gh / 2 - _ph / 2;

    // Painel fundo
    draw_set_color(make_color_rgb(10, 28, 20));
    draw_roundrect_ext(_px2, _py2, _px2 + _pw, _py2 + _ph, 12, 12, false);
    draw_set_color(make_color_rgb(80, 220, 140));
    draw_roundrect_ext(_px2, _py2, _px2 + _pw, _py2 + _ph, 12, 12, true);
    draw_set_color(make_color_rgb(40, 160, 90));
    draw_roundrect_ext(_px2 + 4, _py2 + 4, _px2 + _pw - 4, _py2 + _ph - 4, 9, 9, true);

    // Titulo
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(180, 255, 200));
    draw_text_transformed(_gw / 2, _py2 + 14, "\u2665  Integron Center  \u2665", 1.6, 1.6, 0);
    draw_set_color(c_white);
    draw_text_transformed(_gw / 2, _py2 + 44, "\"Restauro o poder dos seus Integrons!\"", 1.0, 1.0, 0);

    // Linha divisoria
    draw_set_alpha(0.4);
    draw_set_color(make_color_rgb(80, 220, 140));
    draw_rectangle(_px2 + 20, _py2 + 68, _px2 + _pw - 20, _py2 + 70, false);
    draw_set_alpha(1);

    // Lista da party
    var _ly = _py2 + 78;
    if (variable_global_exists("player_party")) {
        var _n = array_length(global.player_party);
        for (var _i = 0; _i < _n; _i++) {
            var _p    = global.player_party[_i];
            var _nome = variable_struct_exists(_p, "nome")    ? _p.nome    : "???";
            var _hpa  = variable_struct_exists(_p, "hp_atual") ? _p.hp_atual : 0;
            var _hpm  = variable_struct_exists(_p, "hp_max")   ? _p.hp_max   : 60;
            var _pct  = clamp(_hpa / _hpm, 0, 1);
            var _barw = 200;

            // Nome
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_set_color(c_white);
            draw_text_transformed(_px2 + 30, _ly + 4, _nome, 1.2, 1.2, 0);

            // Barra HP fundo
            draw_set_color(make_color_rgb(30, 30, 30));
            draw_rectangle(_px2 + 200, _ly + 8, _px2 + 200 + _barw, _ly + 26, false);

            // Barra HP preenchimento
            var _bcor;
            if (_pct > 0.5)       { _bcor = make_color_rgb(80, 200, 80); }
            else if (_pct > 0.25) { _bcor = make_color_rgb(240, 200, 0); }
            else                  { _bcor = make_color_rgb(220, 50, 50); }
            if (_hpa <= 0)        { _bcor = make_color_rgb(80, 80, 80); }

            draw_set_color(_bcor);
            draw_rectangle(_px2 + 200, _ly + 8, _px2 + 200 + _barw * _pct, _ly + 26, false);

            // Borda barra
            draw_set_color(c_white);
            draw_rectangle(_px2 + 200, _ly + 8, _px2 + 200 + _barw, _ly + 26, true);

            // Texto HP / morto
            draw_set_halign(fa_right);
            draw_set_color(_hpa <= 0 ? make_color_rgb(220, 80, 80) : c_white);
            var _hp_txt = (_hpa <= 0) ? "MORTO" : (string(max(0, _hpa)) + "/" + string(_hpm));
            draw_text_transformed(_px2 + _pw - 30, _ly + 4, _hp_txt, 1.1, 1.1, 0);

            _ly += 56;
        }
    } else {
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(160, 160, 160));
        draw_text_transformed(_gw / 2, _ly + 8, "Nenhum Integron capturado.", 1.2, 1.2, 0);
        _ly += 56;
    }

    // Separador
    draw_set_alpha(0.4);
    draw_set_color(make_color_rgb(80, 220, 140));
    draw_rectangle(_px2 + 20, _ly + 4, _px2 + _pw - 20, _ly + 6, false);
    draw_set_alpha(1);

    // Botao curar
    var _bw = 260;
    var _bh = 52;
    var _bx = _gw / 2 - _bw / 2;
    var _bby = _ly + 16;

    draw_set_color(make_color_rgb(20, 100, 55));
    draw_roundrect_ext(_bx, _bby, _bx + _bw, _bby + _bh, 8, 8, false);
    draw_set_color(make_color_rgb(80, 220, 140));
    draw_roundrect_ext(_bx, _bby, _bx + _bw, _bby + _bh, 8, 8, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(_bx + _bw / 2, _bby + _bh / 2, "[E] Curar Todos     [Esc] Sair", 1.25, 1.25, 0);
}

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
