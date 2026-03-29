if (!instance_exists(obj_battle_switcher)) exit;
if (is_undefined(integron)) exit;

// Desenha o sprite do integron na plataforma direita
draw_sprite_ext(integron.sprite, 0, 1030, 380, 4, 4, 0, c_white, 1);

// Desenha nome e método do integron
draw_set_font(-1); // use sua fonte
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(4, 4, integron.nome);
draw_text(4, 16, "Metodo: " + integron.metodo);

// === OVERLAY DE CAPTURA ===
if (overlay_ativo) {
    // Fundo escuro semitransparente
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    // Título da pergunta
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_font(-1);
    draw_text(640, 60, "Capture " + integron.nome + "!");
	draw_text(640, 110, integron.integral);

    // Botões de múltipla escolha (2x2)
	var _larg = 400;
	var _alt  = 80;
	var _gap  = 20;
	var _ox   = (1280 - (_larg * 2 + _gap)) / 2;
	var _oy   = 320;

    for (var i = 0; i < 4; i++) {
        var _bx = _ox + (i mod 2) * (_larg + _gap);
        var _by = _oy + (i div 2) * (_alt  + _gap);

        // Cor do botão (hover ou normal)
        if (i == opcao_hover) {
            draw_set_color(make_color_rgb(255, 220, 50)); // amarelo hover
        } else {
            draw_set_color(make_color_rgb(40, 60, 80));   // azul escuro
        }
        draw_roundrect_ext(_bx, _by, _bx + _larg, _by + _alt, 8, 8, false);

        // Borda
        draw_set_color(c_white);
        draw_roundrect_ext(_bx, _by, _bx + _larg, _by + _alt, 8, 8, true);

        // Texto da opção
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        draw_text(_bx + _larg / 2, _by + _alt / 2, integron.opcoes[i]);
    }

    // Feedback (acertou/errou)
    if (feedback_timer > 0) {
        draw_set_color(feedback_estado == "acertou" ? c_lime : c_red);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_text(640, 240, feedback_texto);
    }

    // Reset
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_set_alpha(1);
}