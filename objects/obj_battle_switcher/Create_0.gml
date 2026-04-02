persistent = true;
player_data   = noone;
grass_data    = noone;
integron      = undefined;
original_room = noone;

// Transição (barras pretas)
bar_height  = 0;
bar_speed   = 30;
screen_w    = display_get_gui_width();
screen_h    = display_get_gui_height();
target      = screen_h / 2;
transitioned = false;

show_debug_message("[switcher] CREATE rodou! integron = " + string(integron));
show_debug_message("[switcher] room atual = " + string(room));