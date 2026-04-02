/// @description Botao SAIR — volta ao mapa.
action = function () {
    var _room = variable_global_exists("pvp_original_room") ? global.pvp_original_room : Room1;
    room_goto(_room);
}
