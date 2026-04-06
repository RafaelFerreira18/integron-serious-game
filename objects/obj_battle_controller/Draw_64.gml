if (is_undefined(integron)) exit;

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _cx = _gw * 0.5;
var _enemy_x = _gw * 0.803125;
var _enemy_y = _gh * 0.3888889;
var _ball_ground_y = _gh * 0.6666667;

var _nome_integron = "Integron";
if (is_struct(integron)) {
    if (variable_struct_exists(integron, "nome")) {
        _nome_integron = string(integron.nome);
    } else if (variable_struct_exists(integron, "name")) {
        _nome_integron = string(integron.name);
    }
}

// ===== ANIMACAO DE CAPTURA =====
if (captura_ativo) {
    // Fundo escuro
    draw_set_alpha(0.88);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    // --- FASE: VOANDO ---
    if (captura_fase == "voando") {
        // Desenha o inimigo no fundo enquanto a bola voa
        var _spr_inimigo = spr_enemy1;
        if (instance_exists(obj_battle_enemy) && sprite_exists(obj_battle_enemy.sprite_index)) {
            _spr_inimigo = obj_battle_enemy.sprite_index;
        } else if (is_struct(integron) && variable_struct_exists(integron, "sprite") && sprite_exists(integron.sprite)) {
            _spr_inimigo = integron.sprite;
        }
        var _w_inim = sprite_get_width(_spr_inimigo);
        var _h_inim = sprite_get_height(_spr_inimigo);
        var _xo_inim = sprite_get_xoffset(_spr_inimigo);
        var _yo_inim = sprite_get_yoffset(_spr_inimigo);
        var _dx_inim = _enemy_x + _xo_inim - (_w_inim * 0.5);
        var _dy_inim = _enemy_y + _yo_inim - (_h_inim * 0.5);
        draw_sprite_ext(_spr_inimigo, 0, _dx_inim, _dy_inim, 1, 1, 0, c_white, 1);
        // Sombra de trajetoria (rastro)
        draw_set_color(make_color_rgb(255, 80, 80));
        draw_set_alpha(0.4);
        draw_circle(cap_bola_x - 8,  cap_bola_y + 5,  5, false);
        draw_circle(cap_bola_x - 18, cap_bola_y + 10, 3, false);
        draw_circle(cap_bola_x - 28, cap_bola_y + 15, 2, false);
        draw_set_alpha(1);
        // Pokebola girando
        draw_sprite_ext(spr_box, (captura_timer mod 4) div 2,
                        cap_bola_x, cap_bola_y, 7, 7, cap_bola_rot, c_white, 1);
    }

    // --- FASE: ABSORVENDO ---
    else if (captura_fase == "absorvendo") {
        // Inimigo piscando e encolhendo em direcao a bola
        if (cap_inimigo_alpha > 0) {
            var _spr_inimigo = spr_enemy1;
            if (instance_exists(obj_battle_enemy) && sprite_exists(obj_battle_enemy.sprite_index)) {
                _spr_inimigo = obj_battle_enemy.sprite_index;
            } else if (is_struct(integron) && variable_struct_exists(integron, "sprite") && sprite_exists(integron.sprite)) {
                _spr_inimigo = integron.sprite;
            }
            var _w2 = sprite_get_width(_spr_inimigo);
            var _h2 = sprite_get_height(_spr_inimigo);
            var _xo2 = sprite_get_xoffset(_spr_inimigo);
            var _yo2 = sprite_get_yoffset(_spr_inimigo);
            var _dx2 = _enemy_x + (_xo2 - (_w2 * 0.5)) * cap_inimigo_scale;
            var _dy2 = _enemy_y + (_yo2 - (_h2 * 0.5)) * cap_inimigo_scale;
            draw_sprite_ext(_spr_inimigo, 0,
                            _dx2, _dy2,
                            1 * cap_inimigo_scale, 1 * cap_inimigo_scale,
                            0, make_color_rgb(255, 180, 180), cap_inimigo_alpha);
        }
        // Anel de energia ao redor do inimigo
        if ((captura_timer mod 6) < 3) {
            draw_set_color(c_white);
            draw_set_alpha(0.35);
            draw_circle(_enemy_x, _enemy_y, 48 + captura_timer * 1.2, true);
            draw_set_alpha(1);
        }
        // Pokebola aberta esperando
        draw_sprite_ext(spr_box, 0, cap_bola_x, cap_bola_y, 8, 8, 0, c_white, 1);
    }

    // --- FASE: CAINDO ---
    else if (captura_fase == "caindo") {
        // Pokebola fechada caindo com spin
        draw_sprite_ext(spr_box, 1, cap_bola_x, cap_bola_y, 8, 8, cap_bola_rot, c_white, 1);
        // Sombra no chao crescendo
        var _shadow_t = captura_timer / 25;
        draw_set_color(c_black);
        draw_set_alpha(0.3 * _shadow_t);
        draw_ellipse(cap_bola_x - 20 * _shadow_t, _ball_ground_y + 12,
                     cap_bola_x + 20 * _shadow_t, _ball_ground_y + 18, false);
        draw_set_alpha(1);
    }

    // --- FASE: BALANCANDO ---
    else if (captura_fase == "balancando") {
        // Sombra embaixo da bola
        draw_set_color(c_black);
        draw_set_alpha(0.35);
        draw_ellipse(cap_bola_x - 24, _ball_ground_y + 12, cap_bola_x + 24, _ball_ground_y + 18, false);
        draw_set_alpha(1);
        // Pokebola balancando (wobble)
        draw_sprite_ext(spr_box, 1, cap_bola_x, cap_bola_y, 9, 9, cap_bola_rot, c_white, 1);
        // Indicador de balancadas (3 pontos)
        var _wobbles_done = min(captura_timer div 30, 3);
        for (var _d = 0; _d < 3; _d++) {
            if (_d < _wobbles_done) {
                draw_set_color(make_color_rgb(255, 80, 80));
            } else {
                draw_set_color(make_color_rgb(60, 60, 60));
            }
            draw_circle(cap_bola_x - 24 + _d * 24, cap_bola_y + 44, 7, false);
        }
        // Texto de suspense
        var _dots = string_repeat(".", 1 + (captura_timer div 20) mod 3);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_transformed(_cx, _gh * 0.8055556, _dots, 2.5, 2.5, 0);
    }

    // --- FASE: CAPTURADO ---
    else if (captura_fase == "capturado") {
        // Pokebola brilhando no chao
        draw_sprite_ext(spr_box, 1, cap_bola_x, cap_bola_y, 9, 9, 0, c_yellow, 1);
        // Estrelas se expandindo
        for (var _s = 0; _s < array_length(cap_estrelas); _s++) {
            var _star = cap_estrelas[_s];
            var _sx   = cap_bola_x + lengthdir_x(_star.dist, _star.angle);
            var _sy   = cap_bola_y + lengthdir_y(_star.dist, _star.angle);
            var _fade = max(0, 1 - (_star.dist / 90));
            draw_set_alpha(_fade);
            // Desenha uma estrela de 4 pontas
            draw_set_color(make_color_rgb(255, 220, 50));
            draw_line_width(_sx - 6, _sy,     _sx + 6, _sy,     2);
            draw_line_width(_sx,     _sy - 6, _sx,     _sy + 6, 2);
            draw_set_color(c_white);
            draw_line_width(_sx - 4, _sy - 4, _sx + 4, _sy + 4, 1);
            draw_line_width(_sx + 4, _sy - 4, _sx - 4, _sy + 4, 1);
        }
        draw_set_alpha(1);
        // Texto "Capturado!"
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(make_color_rgb(255, 220, 50));
        draw_text_transformed(_cx, _gh * 0.4861111, _nome_integron + " foi capturado!", 3, 3, 0);
        draw_set_color(c_lime);
        draw_text_transformed(_cx, _gh * 0.5694444, feedback_texto, 1.8, 1.8, 0);
    }

    // Reset estado de draw
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_set_alpha(1);
    exit;
}


draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(4,  4, _nome_integron);
draw_text(4, 16, "Metodo: " + integron.metodo);

if (overlay_ativo) {

    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);

    // Sprite do integron selvagem no centro superior
    var _spr_captura = spr_enemy1;
    if (is_struct(integron) && variable_struct_exists(integron, "sprite") && sprite_exists(integron.sprite)) {
        _spr_captura = integron.sprite;
    }
    var _w_cap = sprite_get_width(_spr_captura);
    var _h_cap = sprite_get_height(_spr_captura);
    var _xo_cap = sprite_get_xoffset(_spr_captura);
    var _yo_cap = sprite_get_yoffset(_spr_captura);
    var _anchor_x = _cx;
    var _anchor_y = _gh * 0.25;
    var _scale_cap = 3;
    var _dx_cap = _anchor_x + (_xo_cap - (_w_cap * 0.5)) * _scale_cap;
    var _dy_cap = _anchor_y + (_yo_cap - (_h_cap * 0.5)) * _scale_cap;
    draw_sprite_ext(_spr_captura, 0, _dx_cap, _dy_cap, _scale_cap, _scale_cap, 0, c_white, 1);

    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(-1);
    if (feedback_timer <= 0) {
        draw_text(_cx,  _gh * 0.3333333, "Capture " + _nome_integron + "!");
    }
    draw_text(_cx, _gh * 0.375, integron.integral);

    var _larg = 400;
    var _alt  = 80;
    var _gap  = 20;
    var _ox   = (_gw - (_larg * 2 + _gap)) / 2;
    var _oy   = 320;

    for (var i = 0; i < 4; i++) {
        var _bx = _ox + (i mod 2) * (_larg + _gap);
        var _by = _oy + (i div 2) * (_alt  + _gap);

        if (i == opcao_hover) {
            draw_set_color(make_color_rgb(255, 220, 50));
        } else {
            draw_set_color(make_color_rgb(40, 60, 80));
        }
        draw_roundrect_ext(_bx, _by, _bx + _larg, _by + _alt, 8, 8, false);

        draw_set_color(c_white);
        draw_roundrect_ext(_bx, _by, _bx + _larg, _by + _alt, 8, 8, true);

        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        draw_text(_bx + _larg / 2, _by + _alt / 2, integron.opcoes[i]);
    }

    if (feedback_timer > 0) {
        draw_set_color(feedback_estado == "acertou" ? c_lime : c_red);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_text(_cx, _gh * 0.3333333, feedback_texto);
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_set_alpha(1);
}