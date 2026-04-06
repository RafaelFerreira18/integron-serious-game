/// @description Tela final — Parabens, voce zerou o jogo!
phase       = 0;       // 0=fade-in, 1=titulo, 2=creditos, 3=aguarda clique
timer       = 0;
alpha       = 0;
star_x      = [];
star_y      = [];
star_spd    = [];
star_size   = [];

// Musica da tela final
audio_stop_all();
audio_play_sound(sound_final_music, 1, true);

// Cria particulas de estrelas
for (var _i = 0; _i < 60; _i++) {
    array_push(star_x,   irandom(display_get_gui_width()));
    array_push(star_y,   irandom(display_get_gui_height()));
    array_push(star_spd,  0.3 + random(1.2));
    array_push(star_size, 1 + irandom(2));
}
