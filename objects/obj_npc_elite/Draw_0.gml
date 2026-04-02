/// @description Desenhar NPC e prompt de interacao.

// Ofset de balanco idle
var _bob = sin(bob_timer * 3 * pi / 180) * 1;

// Sprite do NPC (spr_npc1 ja existe no projeto)
draw_sprite_ext(spr_npc1, 0, x, y + _bob, 1, 1, 0, c_white, 1);

// Prompt [E] acima do NPC
if (prompt_ativo) {
    // Balao de fala
    var _px = x;
    var _py = y - 20 + _bob;

    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);

    // Fundo do balao
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(20, 20, 40));
    draw_roundrect_ext(_px - 36, _py - 18, _px + 36, _py, 4, 4, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect_ext(_px - 36, _py - 18, _px + 36, _py, 4, 4, true);

    // Texto [E] Batalhar
    draw_set_color(make_color_rgb(255, 220, 50));
    draw_text_transformed(_px, _py - 2, "[E] Batalhar", 0.9, 0.9, 0);
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
