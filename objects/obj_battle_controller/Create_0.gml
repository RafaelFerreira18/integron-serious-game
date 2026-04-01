var _switcher = instance_find(obj_battle_switcher, 0);

if (!instance_exists(_switcher)) {
    show_debug_message("[battle_controller] ERRO: obj_battle_switcher não encontrado!");
    instance_destroy();
    exit;
}

if (is_undefined(_switcher.integron)) {
    show_debug_message("[battle_controller] ERRO: switcher.integron é undefined!");
    instance_destroy();
    exit;
}

integron = _switcher.integron;

estado = "batalha";

overlay_ativo   = false;
opcao_hover     = -1;
feedback_texto  = "";
feedback_timer  = 0;
feedback_estado = "";