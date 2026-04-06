move_speed = 1;

tilemap = layer_tilemap_get_id("Tiles_col");

// Party do jogador (persistente via variaveis globais).
if (!variable_global_exists("player_party")) {
	global.player_party = [];
}
if (!variable_global_exists("player_party_max")) {
	global.player_party_max = 4;
}

// ===== SISTEMA DE PORTAS DA ELITE FOUR =====
// Inicializa array de challengers derrotados se nao existir.
if (!variable_global_exists("elite_defeated")) {
	global.elite_defeated = [false, false, false, false];
}
// A destruicao das portas e feita no Room Creation Code de Room1
// (precisa rodar APOS todos os instances serem criados).

party_overlay_ativo = false;
party_overlay_tecla = ord("P");

// Interacao de habilidade para quebrar obstaculos especificos.
smash_prompt_ativo = false;
smash_tecla = ord("E");
smash_alvo = noone;
smash_quiz_ativo = false;
smash_opcao_hover = -1;
smash_integral = "";
smash_opcoes = ["", "", "", ""];
smash_resposta = 0;
smash_feedback_texto = "";
smash_feedback_estado = "";
smash_feedback_timer = 0;

smash_perguntas = [
	{
		integral: "integral de x dx",
		opcoes: ["x^2/2 + C", "x + C", "2x + C", "1/x + C"],
		resposta: 0
	},
	{
		integral: "integral de 2x dx",
		opcoes: ["x^2 + C", "2x^2 + C", "2 + C", "x + C"],
		resposta: 0
	},
	{
		integral: "integral de 1/x dx",
		opcoes: ["ln|x| + C", "x + C", "1/x^2 + C", "-1/x + C"],
		resposta: 0
	},
	{
		integral: "integral de 3x^2 dx",
		opcoes: ["x^3 + C", "3x^3 + C", "x^2 + C", "3x + C"],
		resposta: 0
	},
	{
		integral: "integral de e^x dx",
		opcoes: ["e^x + C", "x*e^x + C", "ln|x| + C", "e^(x^2) + C"],
		resposta: 0
	},
	{
		integral: "integral de cos(x) dx",
		opcoes: ["sen(x) + C", "-sen(x) + C", "cos(x) + C", "tan(x) + C"],
		resposta: 0
	},
	{
		integral: "integral de sen(x) dx",
		opcoes: ["-cos(x) + C", "cos(x) + C", "sen(x) + C", "-sen(x) + C"],
		resposta: 0
	},
	{
		integral: "integral de 1/(x^2) dx",
		opcoes: ["-1/x + C", "ln|x| + C", "x^2/2 + C", "1/x + C"],
		resposta: 0
	},
	{
		integral: "integral de 4 dx",
		opcoes: ["4x + C", "x^4 + C", "4 + C", "2x^2 + C"],
		resposta: 0
	},
	{
		integral: "integral de x^4 dx",
		opcoes: ["x^5/5 + C", "5x^4 + C", "x^4/4 + C", "x^3 + C"],
		resposta: 0
	},
	{
		integral: "integral de 1/(1 + x^2) dx",
		opcoes: ["arctan(x) + C", "ln|1+x^2| + C", "arcsen(x) + C", "1/(1+x^2) + C"],
		resposta: 0
	},
	{
		integral: "integral de sec^2(x) dx",
		opcoes: ["tan(x) + C", "sec(x) + C", "-cot(x) + C", "cos(x) + C"],
		resposta: 0
	},
	{
		integral: "integral de 2e^(2x) dx",
		opcoes: ["e^(2x) + C", "2e^(2x) + C", "e^x + C", "x*e^(2x) + C"],
		resposta: 0
	}
];

// Controle de encontro na grama para nao testar chance a cada frame.
grass_encounter_timer = 0;
grass_encounter_delay_min = 18;
grass_encounter_delay_max = 36;