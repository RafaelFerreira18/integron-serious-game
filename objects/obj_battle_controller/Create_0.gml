original_room   = undefined;
integron        = undefined;
estado          = "aguardando";
overlay_ativo   = false;
opcao_hover     = -1;
feedback_texto  = "";
feedback_timer  = 0;
feedback_estado = "";
inicializado = false;

// Garante que o Draw GUI deste controller seja executado.
visible = true;

// ===== ANIMACAO DE CAPTURA =====
captura_ativo      = false;
captura_fase       = "";   // "voando" | "absorvendo" | "caindo" | "balancando" | "capturado"
captura_timer      = 0;

// Posicao da pokebola (GUI coords)
cap_bola_x         = 0;
cap_bola_y         = 0;
cap_bola_rot       = 0;

// Estado do sprite do inimigo durante a absorcao
cap_inimigo_alpha  = 1;
cap_inimigo_scale  = 1;

// Particulas de brilho
cap_estrelas       = [];

// Coordenadas baseadas na GUI para manter layout consistente em qualquer resolucao.
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
ui_cx = gui_w * 0.5;
ui_enemy_x = gui_w * 0.803125;     // 1028 em base 1280
ui_enemy_y = gui_h * 0.3888889;    // 280 em base 720
ui_ball_start_x = gui_w * 0.19375; // 248 em base 1280
ui_ball_start_y = gui_h * 0.6666667; // 480 em base 720
ui_ball_arc_h = gui_h * 0.2777778; // 200 em base 720
ui_ball_drop_h = gui_h * 0.2777778;

// Ajusta as instancias na room para evitar deslocamento entre layouts diferentes.
if (instance_exists(obj_battle_player)) {
	var _bp = instance_find(obj_battle_player, 0);
	_bp.x = room_width * 0.19375;
	_bp.y = room_height * 0.4888889;
}
if (instance_exists(obj_battle_enemy)) {
	var _be = instance_find(obj_battle_enemy, 0);
	_be.x = room_width * 0.803125;
	_be.y = room_height * 0.5;
}