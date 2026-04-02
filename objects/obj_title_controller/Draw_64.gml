/// @description Desenhar tela título

var _cx = display_w / 2;

// ===== FUNDO GRADIENTE (estilo Pokémon - azul escuro para roxo) =====
draw_set_alpha(1);
for (var i = 0; i < display_h; i += 4) {
    var _t = i / display_h;
    var _r = lerp(15, 40, _t);
    var _g = lerp(10, 15, _t);
    var _b = lerp(60, 90, _t);
    draw_set_colour(make_colour_rgb(_r, _g, _b));
    draw_rectangle(0, i, display_w, i + 4, false);
}

// ===== PARTÍCULAS DE FUNDO (símbolos matemáticos flutuando) =====
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for (var i = 0; i < max_particles; i++) {
    draw_set_alpha(particle_alpha[i]);
    draw_set_colour(make_colour_rgb(120, 140, 255));
    draw_set_font(-1);
    draw_text_transformed(particle_x[i], particle_y[i], particle_symbol[i],
        particle_size[i] / 12, particle_size[i] / 12, 0);
}
draw_set_alpha(1);

// ===== LINHA DECORATIVA ESTILO POKÉMON (faixa diagonal) =====
draw_set_alpha(0.12);
draw_set_colour(make_colour_rgb(255, 255, 255));
for (var i = -200; i < display_w + 400; i += 80) {
    draw_line_width(i, 0, i - 200, display_h, 20);
}
draw_set_alpha(1);

// ===== SÍMBOLO INTEGRAL GRANDE ATRÁS DO LOGO =====
draw_set_alpha(0.08);
draw_set_colour(make_colour_rgb(180, 200, 255));
draw_text_transformed(_cx, logo_y_base + logo_float_offset, "∫",
    18, 18, 0);
draw_set_alpha(1);

// ===== INTEGRONS DECORATIVOS (criaturas nos lados) =====
// Integron esquerdo
draw_sprite_ext(integron_sprites[0], 0,
    180, 350 + integron_float[0],
    2, 2, 0, c_white, 0.6);

// Integron direito
draw_sprite_ext(integron_sprites[1], 0,
    display_w - 180, 350 + integron_float[1],
    -2, 2, 0, c_white, 0.6);

// Integron central pequeno (abaixo do logo)
draw_sprite_ext(integron_sprites[2], 0,
    _cx, 280 + integron_float[2],
    1.5, 1.5, 0, c_white, 0.35);

// ===== LOGO "INTEGRON" =====
var _logo_y = logo_y_base + logo_float_offset;

// Sombra do texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(make_colour_rgb(0, 0, 0));
draw_set_alpha(0.5);
draw_text_transformed(_cx + 4, _logo_y + 4, logo_text, 5, 5, 0);

// Brilho / contorno
draw_set_alpha(0.3);
draw_set_colour(make_colour_rgb(100, 150, 255));
draw_text_transformed(_cx, _logo_y - 2, logo_text, 5.1, 5.1, 0);

// Texto principal (amarelo estilo Pokémon)
draw_set_alpha(1);
draw_set_colour(make_colour_rgb(255, 220, 50));
draw_text_transformed(_cx, _logo_y, logo_text, 5, 5, 0);

// Sub-título
draw_set_colour(make_colour_rgb(200, 210, 255));
draw_text_transformed(_cx, _logo_y + 55, "Domine as Integrais!", 1.8, 1.8, 0);

// ===== BOTÃO JOGAR =====
var _half_w = btn_w / 2;
var _half_h = btn_h / 2;

// Fundo do botão
if (btn_play_hover) {
    draw_set_colour(make_colour_rgb(80, 180, 80));
} else {
    draw_set_colour(make_colour_rgb(50, 140, 50));
}
draw_set_alpha(0.95);
draw_roundrect(btn_x - _half_w, btn_play_y - _half_h,
               btn_x + _half_w, btn_play_y + _half_h, false);

// Borda do botão
draw_set_colour(make_colour_rgb(200, 255, 200));
draw_set_alpha(1);
draw_roundrect(btn_x - _half_w, btn_play_y - _half_h,
               btn_x + _half_w, btn_play_y + _half_h, true);

// Texto do botão
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _play_scale = btn_play_hover ? 2.4 : 2.2;
draw_text_transformed(btn_x, btn_play_y, btn_play_text, _play_scale, _play_scale, 0);

// ===== BOTÃO SAIR =====
if (btn_exit_hover) {
    draw_set_colour(make_colour_rgb(200, 60, 60));
} else {
    draw_set_colour(make_colour_rgb(160, 40, 40));
}
draw_set_alpha(0.95);
draw_roundrect(btn_x - _half_w, btn_exit_y - _half_h,
               btn_x + _half_w, btn_exit_y + _half_h, false);

// Borda
draw_set_colour(make_colour_rgb(255, 180, 180));
draw_set_alpha(1);
draw_roundrect(btn_x - _half_w, btn_exit_y - _half_h,
               btn_x + _half_w, btn_exit_y + _half_h, true);

// Texto
draw_set_colour(c_white);
var _exit_scale = btn_exit_hover ? 2.4 : 2.2;
draw_text_transformed(btn_x, btn_exit_y, btn_exit_text, _exit_scale, _exit_scale, 0);

// ===== RODAPÉ =====
draw_set_colour(make_colour_rgb(120, 130, 170));
draw_set_alpha(0.7);
draw_text_transformed(_cx, display_h - 40, "Pressione JOGAR para começar sua jornada!", 1.2, 1.2, 0);
draw_set_alpha(1);

// ===== POKEBALL DECORATIVAS NOS CANTOS =====
// Canto inferior esquerdo
draw_set_alpha(0.15);
draw_set_colour(make_colour_rgb(255, 50, 50));
draw_circle(60, display_h - 60, 40, false);
draw_set_colour(c_white);
draw_circle(60, display_h - 60, 40, true);
draw_line_width(20, display_h - 60, 100, display_h - 60, 2);
draw_circle(60, display_h - 60, 10, false);

// Canto inferior direito
draw_set_colour(make_colour_rgb(255, 50, 50));
draw_circle(display_w - 60, display_h - 60, 40, false);
draw_set_colour(c_white);
draw_circle(display_w - 60, display_h - 60, 40, true);
draw_line_width(display_w - 100, display_h - 60, display_w - 20, display_h - 60, 2);
draw_circle(display_w - 60, display_h - 60, 10, false);
draw_set_alpha(1);

// ===== FADE OVERLAY =====
if (fade_alpha > 0) {
    draw_set_colour(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, display_w, display_h, false);
    draw_set_alpha(1);
}

// ===== RESET DRAW STATE =====
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_alpha(1);
