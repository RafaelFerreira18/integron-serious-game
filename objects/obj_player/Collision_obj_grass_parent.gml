// Collision Event (obj_grass_parent)
if (instance_exists(obj_battle_switcher)) exit;

// So tenta encontro quando o player realmente se move na grama.
if (x == xprevious && y == yprevious) exit;

// Evita rolar chance a cada frame enquanto colide com a grama.
if (grass_encounter_timer > 0) exit;

grass_encounter_timer = irandom_range(grass_encounter_delay_min, grass_encounter_delay_max);

var _encounter_chance = 15;
if (random(100) < _encounter_chance) {
    // Sorteia um integron da lista
    var _lista   = scr_integrons_data();
    var _integron = _lista[irandom(array_length(_lista) - 1)];
   
   
    var _switcher = instance_create_depth(0, 0, 0, obj_battle_switcher);
    _switcher.player_data    = self;
    _switcher.grass_data     = other;
    _switcher.integron       = _integron;
    _switcher.original_room  = room;
}