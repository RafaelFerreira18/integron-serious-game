if (bar_height <= 0) exit;

draw_set_color(c_black);

// Barra de cima
draw_rectangle(0, 0, screen_w, bar_height, false);

// Barra de baixo
draw_rectangle(
    0,
    screen_h - bar_height,
    screen_w,
    screen_h,
    false
);
