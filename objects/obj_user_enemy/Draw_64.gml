var _pct  = clamp(hp / hp_total, 0, 1);
var _fill = bar_w * _pct;

// Cor da barra muda conforme o HP
var _cor;
if (_pct > 0.5) {
    _cor = make_color_rgb(80, 200, 80);
} else if (_pct > 0.25) {
    _cor = make_color_rgb(240, 200, 0);
} else {
    _cor = make_color_rgb(220, 50, 50);
}

// Fundo da barra
draw_set_color(make_color_rgb(30, 30, 30));
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);

// Barra de HP
draw_set_color(_cor);
draw_rectangle(bar_x, bar_y, bar_x + _fill, bar_y + bar_h, false);

// Borda
draw_set_color(c_white);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, true);

// Label
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
draw_text(bar_x, bar_y - 4, "INIMIGO");

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);