/// @description Botao ATACAR — dispara a questao de integral no obj_pvp_battle.
action = function () {
    with (obj_pvp_battle) {
        if (estado == "aguardando_clique") {
            // Sorteia questao e abre overlay
            var _pool = player_integron.questoes;
            questao_atual     = _pool[irandom(array_length(_pool) - 1)];
            questao_enunciado = questao_atual.enunciado;
            ensino_ja_visto   = false;  // nova questao: scroll pode ser exibido de novo
            input_texto       = "";
            keyboard_string   = "";
            input_ativo       = true;
            overlay_ativo     = true;
            feedback_texto    = "";
            feedback_timer    = 0;
            opcao_hover       = -1;
            estado            = "aguardando_input";
            estado_timer      = 0;
        }
    }
}
