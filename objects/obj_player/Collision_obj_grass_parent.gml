// Collision Event (obj_grass_parent)
var _encounter_chance = 15;
if (random(100) < _encounter_chance) {
    if (instance_exists(obj_battle_switcher)) exit;
   
    // Sorteia um integron da lista
    var _lista   = scr_integrons_data();
    var _integron = _lista[irandom(array_length(_lista) - 1)];
   
    var _switcher = instance_create_depth(0, 0, 0, obj_battle_switcher);
    _switcher.player_data    = self;
    _switcher.grass_data     = other;
    _switcher.integron       = _integron; // substitui o enemy_monster numérico
    _switcher.original_room  = room;
    room_goto(rm_battle);
}