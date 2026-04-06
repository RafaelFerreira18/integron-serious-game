/// @description Inicializar barra do integron do jogador.
/// Os valores reais sao preenchidos pelo obj_pvp_battle ao iniciar.
nome           = "???";
sprite_batalha = spr_enemy2;
hp             = 60;
hp_total       = 60;
damage         = 15;
hp_display     = hp;   // valor suavizado para barra animada

// Dano (flicker e texto flutuante)
flicker_timer    = 0;
dano_texto       = "";
dano_float_y     = 0;
dano_float_timer = 0;

// Posicao da barra GUI — canto superior ESQUERDO (jogador)
bar_x = 60;
bar_y = 50;
bar_w = 300;
bar_h = 20;