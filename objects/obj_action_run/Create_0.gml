action = function() {
    audio_stop_all();
    var _controller = instance_find(obj_battle_controller, 0);
    var _room_dest = _controller.original_room;
    show_debug_message("[action_run] Saindo! original_room=" + string(_room_dest) + " Room1=" + string(Room1));
    room_goto(_room_dest);
}