show_debug_message("[switcher] Alarm 0 disparou!");
var _controller = instance_find(obj_battle_controller, 0);
show_debug_message("[switcher] controller existe: " + string(instance_exists(_controller)));
if (instance_exists(_controller)) {
    show_debug_message("[switcher] inicializado: " + string(_controller.inicializado));
    _controller.overlay_ativo = true;
    show_debug_message("[switcher] overlay_ativo setado para true");
}