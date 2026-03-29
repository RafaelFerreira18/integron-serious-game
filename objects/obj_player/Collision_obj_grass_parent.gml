var _encounter_chance = 15;

if (random(100) < _encounter_chance) {
    if (instance_exists(obj_battle_switcher)) exit;

   
    var _monsters = [1, 2, 3, 4];
    var _chosen = _monsters[irandom(array_length(_monsters) - 1)];

    var _switcher = instance_create_depth(0, 0, 0, obj_battle_switcher);
    _switcher.player_data = self;
    _switcher.grass_data = other;
    _switcher.enemy_monster = _chosen;
    _switcher.original_room = room;

    room_goto(rm_battle);
}