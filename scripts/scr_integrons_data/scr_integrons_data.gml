/// @description Retorna dados completos de todos os Integrons do jogo.
/// Cada integron tem: nome, sprite, hp_batalha, dano_acerto, dano_erro,
/// metodo, e um array de questoes com respostas aceitas (para validacao livre).
function scr_integrons_data() {
    return [
        // ── SUBSTITUTUS ── rapido, fragil, dano alto
        {
            nome:        "Substitutus",
            sprite:      spr_enemy2,
            hp_batalha:  60,
            dano_acerto: 20,   // dano no inimigo ao acertar
            dano_erro:   8,    // dano no jogador ao errar
            metodo:      "Substituição Simples",
            // Mantido para compatibilidade com sistema de captura
            hp:          30,
            integral:    "∫ 2x dx = ?",
            opcoes:      ["x² + C", "2x² + C", "x + C", "2 + C"],
            resposta:    0,
            // Pool de questoes para batalha PvP
            questoes: [
                {
                    enunciado:  "∫ 2x dx = ?",
                    aceitas:    ["x^2+c","x2+c","x²+c"]
                },
                {
                    enunciado:  "∫ 4x³ dx = ?",
                    aceitas:    ["x^4+c","x4+c"]
                },
                {
                    enunciado:  "∫ 3 dx = ?",
                    aceitas:    ["3x+c"]
                },
                {
                    enunciado:  "∫ x dx = ?",
                    aceitas:    ["x^2/2+c","x2/2+c"]
                }
            ]
        },

        // ── PARTIUS ── equilibrado, dano medio
        {
            nome:        "Partius",
            sprite:      spr_enemy2,
            hp_batalha:  90,
            dano_acerto: 15,
            dano_erro:   12,
            metodo:      "Integração por Partes",
            hp:          40,
            integral:    "∫ x·eˣ dx = ?",
            opcoes:      ["eˣ(x-1) + C", "x·eˣ + C", "eˣ + C", "x²·eˣ + C"],
            resposta:    0,
            questoes: [
                {
                    enunciado:  "∫ x·eˣ dx = ?",
                    aceitas:    ["e^x(x-1)+c","ex(x-1)+c"]
                },
                {
                    enunciado:  "∫ x·cos(x) dx = ?",
                    aceitas:    ["cos(x)+x*sin(x)+c","x*sin(x)+cos(x)+c"]
                },
                {
                    enunciado:  "∫ ln(x) dx = ?",
                    aceitas:    ["x*ln(x)-x+c","xln(x)-x+c"]
                },
                {
                    enunciado:  "∫ x·sen(x) dx = ?",
                    aceitas:    ["sen(x)-x*cos(x)+c","sin(x)-x*cos(x)+c"]
                }
            ]
        },

        // ── FRACCIUS ── tanque, muito hp, dano baixo
        {
            nome:        "Fraccius",
            sprite:      spr_enemy2,
            hp_batalha:  130,
            dano_acerto: 10,
            dano_erro:   6,
            metodo:      "Frações Parciais",
            hp:          50,
            integral:    "∫ 1/x dx = ?",
            opcoes:      ["ln|x| + C", "1/x² + C", "-1/x + C", "x⁻¹ + C"],
            resposta:    0,
            questoes: [
                {
                    enunciado:  "∫ 1/x dx = ?",
                    aceitas:    ["ln|x|+c","ln(x)+c","ln|x|+c"]
                },
                {
                    enunciado:  "∫ 1/(x²-1) dx = ?",
                    aceitas:    ["(1/2)*ln|(x-1)/(x+1)|+c","0.5*ln|(x-1)/(x+1)|+c"]
                },
                {
                    enunciado:  "∫ 1/(x(x+1)) dx = ?",
                    aceitas:    ["ln|x|-ln|x+1|+c","ln|x/(x+1)|+c"]
                }
            ]
        }
    ];
}

/// @description Normaliza uma string de resposta para comparacao:
/// lowercase, sem espacos, troca simbolos comuns.
function scr_normalizar_resposta(_s) {
    _s = string_lower(_s);
    _s = string_replace_all(_s, " ", "");
    _s = string_replace_all(_s, "²", "^2");
    _s = string_replace_all(_s, "³", "^3");
    _s = string_replace_all(_s, "⁴", "^4");
    _s = string_replace_all(_s, "*", "");
    _s = string_replace_all(_s, "·", "");
    return _s;
}