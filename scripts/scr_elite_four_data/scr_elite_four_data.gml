/// @description Retorna os dados dos desafiantes da Elite Four.
/// Cada challenger tem nome, cor de destaque e um array de integrons (party).
/// Os integrons da party referenciamo pool de scr_integrons_data pelo índice.
function scr_elite_four_data() {
    var _todos = scr_integrons_data();

    return [
        // ── CHALLENGER 0: Aria — 1 integron (Substitutus) ──
        {
            nome:     "Aria",
            subtitulo:"Elite do Cálculo",
            cor:      make_color_rgb(100, 160, 255),
            party: [
                scr_pvp_clone_integron(_todos[0])    // Substitutus
            ]
        },

        // ── CHALLENGER 1: Nox — 1 integron (Partius) ──
        {
            nome:     "Nox",
            subtitulo:"Mestre das Partes",
            cor:      make_color_rgb(180, 80, 220),
            party: [
                scr_pvp_clone_integron(_todos[1])    // Partius
            ]
        },

        // ── CHALLENGER 2: Rex — 1 integron (Fraccius) ──
        {
            nome:     "Rex",
            subtitulo:"O Invicto",
            cor:      make_color_rgb(220, 80, 60),
            party: [
                scr_pvp_clone_integron(_todos[2])    // Fraccius
            ]
        },

        // ── CHALLENGER 3: AXIOM — Final Boss (todos os 3 integrons) ──
        {
            nome:     "AXIOM",
            subtitulo:"O Teorema Final",
            cor:      make_color_rgb(255, 200, 40),
            party: [
                scr_pvp_clone_integron(_todos[0]),   // Substitutus
                scr_pvp_clone_integron(_todos[1]),   // Partius
                scr_pvp_clone_integron(_todos[2])    // Fraccius
            ]
        }
    ];
}

/// @description Clona um integron com HP de batalha restaurado.
/// Necessario para que cada challenger tenha sua propria instancia de HP.
function scr_pvp_clone_integron(_base) {
    var _sprite = (argument_count > 1) ? argument[1] : _base.sprite;
    return {
        nome:        _base.nome,
        sprite:      _sprite,
        hp_batalha:  _base.hp_batalha,
        hp_atual:    _base.hp_batalha,   // HP começa cheio
        dano_acerto: _base.dano_acerto,
        dano_erro:   _base.dano_erro,
        metodo:      _base.metodo,
        questoes:    _base.questoes
    };
}
