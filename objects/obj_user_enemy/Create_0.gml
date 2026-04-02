/// @description Inicializar barra do integron inimigo.
/// Os valores reais sao preenchidos pelo obj_pvp_battle ao iniciar.
nome           = "???";
sprite_batalha = spr_enemy1;
hp             = 60;
hp_total       = 60;
damage         = 15;
hp_display     = hp;

// Dano
flicker_timer    = 0;
dano_texto       = "";
dano_float_y     = 0;
dano_float_timer = 0;

// Posicao da barra GUI — canto superior DIREITO (inimigo)
bar_x = 980;
bar_y = 50;
bar_w = 300;
bar_h = 20;