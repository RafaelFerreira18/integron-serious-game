action = function() {
    var _controller = instance_find(obj_battle_controller, 0);
    room_goto(_controller.original_room);
}