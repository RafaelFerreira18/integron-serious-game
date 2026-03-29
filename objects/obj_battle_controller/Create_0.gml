// Pega o integron sorteado pelo switcher
var _switcher = instance_find(obj_battle_switcher, 0);
integron = _switcher.integron;

// Estado: "batalha" ou "captura"
estado = "batalha";

// Dados do overlay de captura
overlay_ativo   = false;
opcao_hover     = -1;
feedback_texto  = "";
feedback_timer  = 0;
feedback_estado = ""; // "acertou" ou "errou"

// Define as 4 opções de resposta (posições do overlay)
// Serão desenhadas no Draw GUI Event