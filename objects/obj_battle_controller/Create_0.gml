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