/// @description Desenhar NPC e prompt de interacao.

// Ofset de balanco idle
var _bob = sin(bob_timer * 3 * pi / 180) * 1;

// Sprite do NPC
draw_sprite_ext(sprite_index, 0, x, y + _bob, 1, 1, 0, c_white, 1);

// Caixa "!" de avistamento (aparece antes de disparar a batalha)
if (spotted && spotted_timer < 70) {
    var _spr_h = sprite_get_height(sprite_index);
    var _ex    = x;
    var _ey    = y - _spr_h - 6 + excl_bob + _bob;
    var _hw    = 9;
    var _hh    = 11;

    // Caixa branca
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(_ex - _hw, _ey - _hh * 2 - 2, _ex + _hw, _ey, false);

    // Borda preta fina
    draw_set_color(c_black);
    draw_rectangle(_ex - _hw, _ey - _hh * 2 - 2, _ex + _hw, _ey, true);

    // "!" preto centralizado
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);
    draw_text_transformed(_ex, _ey - _hh - 1, "!", 1.6, 1.6, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// Aviso party vazia
if (aviso_timer > 0) {
    var _alpha = min(1, aviso_timer / 30);
    var _ax = x;
    var _ay = y - 40 + _bob;
    draw_set_alpha(_alpha * 0.85);
    draw_set_color(make_color_rgb(180, 30, 30));
    draw_roundrect_ext(_ax - 72, _ay - 18, _ax + 72, _ay, 4, 4, false);
    draw_set_alpha(_alpha);
    draw_set_color(c_white);
    draw_roundrect_ext(_ax - 72, _ay - 18, _ax + 72, _ay, 4, 4, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(c_white);
    draw_text_transformed(_ax, _ay - 2, aviso_texto, 0.9, 0.9, 0);
}

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
