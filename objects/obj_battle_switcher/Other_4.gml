// Create Event do obj_battle_switcher
persistent    = true;
player_data   = noone;
grass_data    = noone;
integron      = undefined; // será preenchido pelo obj_player
original_room = room;

if (room != rm_battle) {
    alarm[0] = 60;
}