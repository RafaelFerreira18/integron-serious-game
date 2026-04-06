// Anima HP display suavemente
if (hp_display > hp) hp_display = max(hp, hp_display - 1);
if (hp_display < hp) hp_display = hp;

var _pct  = clamp(hp_display / hp_total, 0, 1);
var _fill = bar_w * _pct;

// Flicker de dano
if (flicker_timer > 0) {
    flicker_timer--;
}

// Cor da barra
var _cor;
if (_pct > 0.5) {
    _cor = make_color_rgb(80, 200, 80);
} else if (_pct > 0.25) {
    _cor = make_color_rgb(240, 200, 0);
} else {
    _cor = make_color_rgb(220, 50, 50);
}

// ── Painel de fundo ──
draw_set_alpha(0.75);
draw_set_color(make_color_rgb(20, 20, 40));
draw_roundrect_ext(bar_x - 10, bar_y - 36, bar_x + bar_w + 10, bar_y + bar_h + 10, 6, 6, false);
draw_set_alpha(1);

// Borda do painel
draw_set_color(make_color_rgb(80, 120, 200));
draw_roundrect_ext(bar_x - 10, bar_y - 36, bar_x + bar_w + 10, bar_y + bar_h + 10, 6, 6, true);

// Nome e metodo
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
draw_text_transformed(bar_x, bar_y - 6, nome, 1.3, 1.3, 0);

// Fundo da barra HP
draw_set_color(make_color_rgb(30, 30, 30));
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);

// Barra HP
draw_set_color(_cor);
draw_rectangle(bar_x, bar_y, bar_x + _fill, bar_y + bar_h, false);

// Borda da barra
draw_set_color(c_white);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, true);

// Texto HP
draw_set_halign(fa_right);
draw_set_color(c_white);
draw_text_transformed(bar_x + bar_w, bar_y + bar_h + 14, string(max(0, hp)) + "/" + string(hp_total), 1.1, 1.1, 0);

// Dano flutuante
if (dano_float_timer > 0) {
    dano_float_timer--;
    dano_float_y -= 1;
    draw_set_alpha(dano_float_timer / 40);
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(255, 60, 60));
    draw_text_transformed(bar_x + bar_w / 2, bar_y + dano_float_y, dano_texto, 2, 2, 0);
    draw_set_alpha(1);
}

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);