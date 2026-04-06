/// @description Desenhar tutorial em GUI

timer++;
fade_in = min(1, timer / 20);

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _cx = _gw / 2;

// ===== FUNDO ESCURO =====
draw_set_alpha(fade_in * 0.85);
draw_set_colour(c_black);
draw_rectangle(0, 0, _gw, _gh, false);
draw_set_alpha(fade_in);

// ===== CAIXA CENTRAL =====
var _bx = _cx - 420;
var _by = 60;
var _bw = 840;
var _bh = 560;

// Borda dourada
draw_set_colour(make_colour_rgb(200, 170, 50));
draw_roundrect_ext(_bx - 3, _by - 3, _bx + _bw + 3, _by + _bh + 3, 12, 12, false);

// Fundo da caixa
draw_set_colour(make_colour_rgb(20, 20, 40));
draw_roundrect_ext(_bx, _by, _bx + _bw, _by + _bh, 10, 10, false);

// ===== TITULO DA PAGINA =====
var _pag = paginas[pagina];
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_colour(make_colour_rgb(255, 220, 50));
draw_text_transformed(_cx, _by + 20, _pag.titulo, 2.2, 2.2, 0);

// Linha separadora
draw_set_colour(make_colour_rgb(200, 170, 50));
draw_set_alpha(fade_in * 0.6);
draw_rectangle(_bx + 40, _by + 65, _bx + _bw - 40, _by + 67, false);
draw_set_alpha(fade_in);

// ===== CORPO DO TEXTO =====
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
var _ty = _by + 85;
var _linhas = _pag.linhas;
for (var i = 0; i < array_length(_linhas); i++) {
    draw_text_transformed(_bx + 50, _ty, _linhas[i], 1.5, 1.5, 0);
    _ty += 34;
}

// ===== INDICADOR DE PAGINA =====
draw_set_halign(fa_center);
draw_set_colour(make_colour_rgb(150, 150, 180));
draw_text_transformed(_cx, _by + _bh - 70,
    string(pagina + 1) + " / " + string(total_paginas), 1.4, 1.4, 0);

// ===== BOTOES AVANCAR / VOLTAR =====
var _btn_w = 160;
var _btn_h = 44;
var _btn_y = _by + _bh - 38;
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// Botao PROXIMO / COMECAR
var _next_x = _cx + 120;
var _next_label = (pagina >= total_paginas - 1) ? "COMECAR!" : "Proximo >";
var _hover_next = (_mx >= _next_x - _btn_w / 2 && _mx <= _next_x + _btn_w / 2
                && _my >= _btn_y - _btn_h / 2 && _my <= _btn_y + _btn_h / 2);

draw_set_colour(_hover_next ? make_colour_rgb(80, 200, 80) : make_colour_rgb(50, 150, 50));
draw_roundrect(_next_x - _btn_w / 2, _btn_y - _btn_h / 2,
               _next_x + _btn_w / 2, _btn_y + _btn_h / 2, false);
draw_set_colour(c_white);
draw_roundrect(_next_x - _btn_w / 2, _btn_y - _btn_h / 2,
               _next_x + _btn_w / 2, _btn_y + _btn_h / 2, true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);
draw_text_transformed(_next_x, _btn_y, _next_label, 1.5, 1.5, 0);

if (_hover_next && mouse_check_button_pressed(mb_left)) {
    if (pagina >= total_paginas - 1) {
        global.tutorial_visto = true;
        instance_destroy();
        exit;
    } else {
        pagina++;
        timer = 0;
    }
}

// Botao VOLTAR (so se nao estiver na primeira pagina)
if (pagina > 0) {
    var _prev_x = _cx - 120;
    var _hover_prev = (_mx >= _prev_x - _btn_w / 2 && _mx <= _prev_x + _btn_w / 2
                    && _my >= _btn_y - _btn_h / 2 && _my <= _btn_y + _btn_h / 2);

    draw_set_colour(_hover_prev ? make_colour_rgb(100, 100, 180) : make_colour_rgb(60, 60, 140));
    draw_roundrect(_prev_x - _btn_w / 2, _btn_y - _btn_h / 2,
                   _prev_x + _btn_w / 2, _btn_y + _btn_h / 2, false);
    draw_set_colour(c_white);
    draw_roundrect(_prev_x - _btn_w / 2, _btn_y - _btn_h / 2,
                   _prev_x + _btn_w / 2, _btn_y + _btn_h / 2, true);
    draw_set_colour(c_white);
    draw_text_transformed(_prev_x, _btn_y, "< Voltar", 1.5, 1.5, 0);

    if (_hover_prev && mouse_check_button_pressed(mb_left)) {
        pagina--;
        timer = 0;
    }
}

// Atalho de teclado
if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    if (pagina >= total_paginas - 1) {
        global.tutorial_visto = true;
        instance_destroy();
        exit;
    } else {
        pagina++;
        timer = 0;
    }
}
if (keyboard_check_pressed(vk_left) && pagina > 0) {
    pagina--;
    timer = 0;
}

// ===== DICA NO RODAPE =====
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_colour(make_colour_rgb(120, 120, 150));
draw_text_transformed(_cx, _gh - 15,
    "Use as setas ou clique nos botoes para navegar", 1.1, 1.1, 0);

// ===== RESET =====
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_alpha(1);
