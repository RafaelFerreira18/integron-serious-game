// Create Event
action = function () {
    // Ativa o overlay de captura no controller
    with (obj_battle_controller) {
        overlay_ativo = true;
        opcao_hover   = -1;
        feedback_texto  = "";
        feedback_timer  = 0;
        feedback_estado = "";
    }
}