/// @description Desenha a tela final
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// Fundo preto
draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, _gw, _gh, false);

// Estrelas
draw_set_color(c_white);
for (var _i = 0; _i < array_length(star_x); _i++) {
    var _a = 0.4 + 0.6 * abs(sin(timer * 0.02 + _i));
    draw_set_alpha(alpha * _a);
    draw_circle(star_x[_i], star_y[_i], star_size[_i], false);
}
draw_set_alpha(alpha);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// === FASE 1+: Titulo ===
if (phase >= 1) {
    var _title_a = (phase == 1) ? min(1, timer / 60) : 1;
    draw_set_alpha(alpha * _title_a);

    // Brilho dourado
    draw_set_color(make_color_rgb(255, 215, 50));
    draw_text_transformed(_gw / 2, _gh * 0.25, "PARABÉNS!", 6, 6, 0);

    draw_set_color(c_white);
    draw_text_transformed(_gw / 2, _gh * 0.25 + 70, "Você derrotou a Elite Four!", 2.5, 2.5, 0);
}

// === FASE 2+: Creditos/mensagem ===
if (phase >= 2) {
    var _cred_a = (phase == 2) ? min(1, timer / 60) : 1;
    draw_set_alpha(alpha * _cred_a);

    draw_set_color(make_color_rgb(180, 220, 255));
    var _cy = _gh * 0.50;

    draw_text_transformed(_gw / 2, _cy, "Você dominou os métodos de integração:", 2, 2, 0);

    draw_set_color(make_color_rgb(100, 200, 255));
    draw_text_transformed(_gw / 2, _cy + 50, "✦ Substituição Simples", 1.8, 1.8, 0);
    draw_text_transformed(_gw / 2, _cy + 90, "✦ Integração por Partes", 1.8, 1.8, 0);
    draw_text_transformed(_gw / 2, _cy + 130, "✦ Frações Parciais", 1.8, 1.8, 0);

    draw_set_color(make_color_rgb(255, 220, 100));
    draw_text_transformed(_gw / 2, _cy + 200, "O Mestre da Integração!", 2.5, 2.5, 0);
}

// === FASE 3: Clique para continuar ===
if (phase >= 3) {
    var _blink = 0.5 + 0.5 * sin(timer * 0.08);
    draw_set_alpha(alpha * _blink);
    draw_set_color(c_white);
    draw_text_transformed(_gw / 2, _gh - 60, "Clique para voltar ao menu", 1.5, 1.5, 0);
}

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
