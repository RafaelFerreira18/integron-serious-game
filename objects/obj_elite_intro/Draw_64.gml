/// @description Animação de intro de batalha estilo Pokémon Black/White — Draw GUI Event.

timer++;

// Atualiza dimensoes da GUI a cada frame (garante que nao ficam zeradas)
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
cx    = gui_w * 0.5;
cy    = gui_h * 0.5;

// LOG a cada 60 frames para rastrear progresso
if (timer mod 60 == 0) {
    show_debug_message("[elite_intro] timer=" + string(timer)
        + " | phase=" + string(phase)
        + " | gui_w=" + string(gui_w)
        + " | trainer_x=" + string(trainer_x)
        + " | cx=" + string(cx));
}

var _gw = gui_w;
var _gh = gui_h;

// ── Fundo sempre preto, desenhado antes de tudo ──────────────────────────────
draw_set_color(c_black);
draw_set_alpha(1);
draw_rectangle(0, 0, _gw, _gh, false);

switch (phase) {

    // ────────────────────────────────────────────────────────────────────────
    // FASE 0 — Trainer entra deslizando da direita como silhueta preta
    // ────────────────────────────────────────────────────────────────────────
    case 0:
        trainer_x = lerp(trainer_x, cx, 0.1);

        // Sprite inteiramente preto (silhueta)
        draw_sprite_ext(spr_trainer, 0, trainer_x, trainer_y, 3, 3, 0, c_black, 1);

        // LOG de progresso da fase 0
        if (timer mod 30 == 0) {
            show_debug_message("[elite_intro] fase0 trainer_x=" + string(trainer_x) + " | diff=" + string(abs(trainer_x - cx)));
        }

        // Transição: trainer chegou ao centro
        if (abs(trainer_x - cx) < 1.5) {
            show_debug_message("[elite_intro] fase0 -> fase1!");
            trainer_x      = cx;
            phase          = 1;
            timer          = 0;
            flash_alpha    = 0;
            flash_going_up = true;
        }
        break;

    // ────────────────────────────────────────────────────────────────────────
    // FASE 1 — Flash branco sobe até 1 e depois decrementa para 0
    // ────────────────────────────────────────────────────────────────────────
    case 1:
        // Mantém silhueta visível atrás do flash
        draw_sprite_ext(spr_trainer, 0, cx, cy, 3, 3, 0, c_black, 1);

        if (flash_going_up) {
            flash_alpha = lerp(flash_alpha, 1.05, 0.14);
            if (flash_alpha >= 0.98) {
                flash_alpha    = 1;
                flash_going_up = false;
            }
        } else {
            flash_alpha = lerp(flash_alpha, -0.05, 0.12);
            if (flash_alpha <= 0.02) {
                flash_alpha = 0;
                phase       = 2;
                timer       = 0;
                diag_x      = -_gh;   // reinicia posição do corte fora da tela
            }
        }

        draw_set_color(c_white);
        draw_set_alpha(flash_alpha);
        draw_rectangle(0, 0, _gw, _gh, false);
        draw_set_alpha(1);
        break;

    // ────────────────────────────────────────────────────────────────────────
    // FASE 2 — Corte diagonal varre a tela da esquerda para a direita
    // ────────────────────────────────────────────────────────────────────────
    case 2:
        diag_x = lerp(diag_x, _gw + _gh, 0.09);

        // Paralelogramo preto varredura (dois triângulos formando o shape):
        // Vértices: (0,0) → (diag_x, 0) → (diag_x - _gh, _gh) → (0, _gh)
        draw_set_color(c_black);
        draw_set_alpha(1);

        draw_primitive_begin(pr_trianglelist);
            draw_vertex(0,           0);
            draw_vertex(diag_x,      0);
            draw_vertex(diag_x - _gh, _gh);
        draw_primitive_end();

        draw_primitive_begin(pr_trianglelist);
            draw_vertex(0,            0);
            draw_vertex(diag_x - _gh, _gh);
            draw_vertex(0,            _gh);
        draw_primitive_end();

        // Linha branca na aresta do corte para dar visibilidade ao efeito
        draw_set_color(c_white);
        draw_line_width(diag_x, 0, diag_x - _gh, _gh, 3);

        if (diag_x >= _gw + _gh - 15) {
            phase         = 3;
            timer         = 0;
            outline_phase = 0;
        }
        break;

    // ────────────────────────────────────────────────────────────────────────
    // FASE 3 — Revela sprite colorido com outline branco pulsante
    // ────────────────────────────────────────────────────────────────────────
    case 3:
        outline_phase += 0.12;
        var _oa = sin(outline_phase) * 0.5 + 0.5;   // oscila entre 0 e 1

        // Outline: sprite deslocado 2px nas 8 direções com cor branca
        draw_sprite_ext(spr_trainer, 0, cx + 2,  cy,     3, 3, 0, c_white, _oa);
        draw_sprite_ext(spr_trainer, 0, cx - 2,  cy,     3, 3, 0, c_white, _oa);
        draw_sprite_ext(spr_trainer, 0, cx,      cy + 2, 3, 3, 0, c_white, _oa);
        draw_sprite_ext(spr_trainer, 0, cx,      cy - 2, 3, 3, 0, c_white, _oa);
        draw_sprite_ext(spr_trainer, 0, cx + 2,  cy + 2, 3, 3, 0, c_white, _oa);
        draw_sprite_ext(spr_trainer, 0, cx - 2,  cy + 2, 3, 3, 0, c_white, _oa);
        draw_sprite_ext(spr_trainer, 0, cx + 2,  cy - 2, 3, 3, 0, c_white, _oa);
        draw_sprite_ext(spr_trainer, 0, cx - 2,  cy - 2, 3, 3, 0, c_white, _oa);

        // Sprite colorido normal por cima dos outlines
        draw_sprite_ext(spr_trainer, 0, cx, cy, 3, 3, 0, c_white, 1);

        // Permanece nesta fase por ~2 segundos (120 frames a 60fps)
        if (timer >= 120) {
            phase     = 4;
            timer     = 0;
            spr_scale = 3.0;
        }
        break;

    // ────────────────────────────────────────────────────────────────────────
    // FASE 4 — Zoom in: escala de 3x até 4.5x com lerp()
    // ────────────────────────────────────────────────────────────────────────
    case 4:
        spr_scale = lerp(spr_scale, 4.6, 0.07);

        outline_phase += 0.12;
        var _oa4 = sin(outline_phase) * 0.5 + 0.5;

        // Outline com escala crescente
        draw_sprite_ext(spr_trainer, 0, cx + 2,  cy,     spr_scale, spr_scale, 0, c_white, _oa4);
        draw_sprite_ext(spr_trainer, 0, cx - 2,  cy,     spr_scale, spr_scale, 0, c_white, _oa4);
        draw_sprite_ext(spr_trainer, 0, cx,      cy + 2, spr_scale, spr_scale, 0, c_white, _oa4);
        draw_sprite_ext(spr_trainer, 0, cx,      cy - 2, spr_scale, spr_scale, 0, c_white, _oa4);
        draw_sprite_ext(spr_trainer, 0, cx + 2,  cy + 2, spr_scale, spr_scale, 0, c_white, _oa4);
        draw_sprite_ext(spr_trainer, 0, cx - 2,  cy + 2, spr_scale, spr_scale, 0, c_white, _oa4);
        draw_sprite_ext(spr_trainer, 0, cx + 2,  cy - 2, spr_scale, spr_scale, 0, c_white, _oa4);
        draw_sprite_ext(spr_trainer, 0, cx - 2,  cy - 2, spr_scale, spr_scale, 0, c_white, _oa4);

        // Sprite principal com zoom
        draw_sprite_ext(spr_trainer, 0, cx, cy, spr_scale, spr_scale, 0, c_white, 1);

        if (spr_scale >= 4.48) {
            phase = 5;
            timer = 0;
        }
        break;

    // ────────────────────────────────────────────────────────────────────────
    // FASE 5 — Animação concluída: inicia a batalha
    // ────────────────────────────────────────────────────────────────────────
    case 5:
        if (timer <= 3) {
            show_debug_message("[elite_intro] FASE 5 - chamando room_goto para " + string(target_room));
            room_goto(target_room);
        }
        break;
}

// Reseta cor e alpha para não vazar nos objetos desenhados depois
draw_set_color(c_white);
draw_set_alpha(1);
