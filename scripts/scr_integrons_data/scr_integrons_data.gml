/// @description Retorna dados completos de todos os Integrons do jogo.
/// Cada integron tem: nome, sprite, hp_batalha, dano_acerto, dano_erro,
/// metodo, e um array de questoes com respostas aceitas (para validacao livre).
function scr_integrons_data() {
    return [
        // ── SUBSTITUTUS ── rapido, fragil, dano alto
        {
            nome:        "Substitutus",
            sprite:      spr_substitutus,
            hp_batalha:  60,
            dano_acerto: 50,   // dano no inimigo ao acertar
            dano_erro:   8,    // dano no jogador ao errar
            metodo:      "Substituicao Simples",
            // Mantido para compatibilidade com sistema de captura
            hp:          30,
            integral:    "integral de 2x dx = ?",
            opcoes:      ["x^2 + C", "2x^2 + C", "x + C", "2 + C"],
            resposta:    0,
            // Pool de questoes para batalha PvP
            questoes: [
                {
                    enunciado: "integral de 2x dx = ?",
                    aceitas:   ["x^2+c","x2+c"],
                    passos: [
                        "Regra da Potencia: integral de x^n dx = x^(n+1) / (n+1) + C",
                        "Temos 2*x^1, logo n=1 e coeficiente=2",
                        "Calcule: 2 * x^2 / 2 = x^2",
                        "Resultado final: x^2 + C"
                    ]
                },
                {
                    enunciado: "integral de 4x^3 dx = ?",
                    aceitas:   ["x^4+c","x4+c"],
                    passos: [
                        "Regra da Potencia: integral de x^n dx = x^(n+1) / (n+1) + C",
                        "Temos 4*x^3, logo n=3 e coeficiente=4",
                        "Calcule: 4 * x^4 / 4 = x^4",
                        "Resultado final: x^4 + C"
                    ]
                },
                {
                    enunciado: "integral de 3 dx = ?",
                    aceitas:   ["3x+c"],
                    passos: [
                        "Integral de constante: integral de k dx = k*x + C",
                        "Aqui k = 3",
                        "Resultado final: 3x + C"
                    ]
                },
                {
                    enunciado: "integral de x dx = ?",
                    aceitas:   ["x^2/2+c","x2/2+c"],
                    passos: [
                        "Regra da Potencia: integral de x^n dx = x^(n+1) / (n+1) + C",
                        "Temos x^1, logo n=1",
                        "Calcule: x^2/(1+1) = x^2/2",
                        "Resultado final: x^2/2 + C"
                    ]
                }
            ]
        },

        // ── PARTIUS ── equilibrado, dano medio
        {
            nome:        "Partius",
            sprite:      spr_partius,
            hp_batalha:  90,
            dano_acerto: 50,
            dano_erro:   12,
            metodo:      "Integracao por Partes",
            hp:          40,
            integral:    "integral de x*e^x dx = ?",
            opcoes:      ["e^x(x-1) + C", "x*e^x + C", "e^x + C", "x^2*e^x + C"],
            resposta:    0,
            questoes: [
                {
                    enunciado: "integral de x*e^x dx = ?",
                    aceitas:   ["e^x(x-1)+c","ex(x-1)+c"],
                    passos: [
                        "Por Partes: integral de u*dv = u*v - integral de v*du",
                        "Escolha: u = x  ->  du = dx",
                        "Escolha: dv = e^x dx  ->  v = e^x",
                        "Aplique: x*e^x - integral de e^x dx = x*e^x - e^x",
                        "Resultado final: e^x(x-1) + C"
                    ]
                },
                {
                    enunciado: "integral de x*cos(x) dx = ?",
                    aceitas:   ["cos(x)+x*sin(x)+c","x*sin(x)+cos(x)+c"],
                    passos: [
                        "Por Partes: integral de u*dv = u*v - integral de v*du",
                        "Escolha: u = x  ->  du = dx",
                        "Escolha: dv = cos(x)dx  ->  v = sen(x)",
                        "Aplique: x*sen(x) - integral de sen(x) dx",
                        "integral de sen(x)dx = -cos(x), portanto: x*sen(x) + cos(x)",
                        "Resultado final: x*sen(x) + cos(x) + C"
                    ]
                },
                {
                    enunciado: "integral de ln(x) dx = ?",
                    aceitas:   ["x*ln(x)-x+c","xln(x)-x+c"],
                    passos: [
                        "Por Partes: integral de u*dv = u*v - integral de v*du",
                        "Escolha: u = ln(x)  ->  du = (1/x)dx",
                        "Escolha: dv = dx  ->  v = x",
                        "Aplique: x*ln(x) - integral de x*(1/x) dx = x*ln(x) - integral de 1 dx",
                        "Resultado final: x*ln(x) - x + C"
                    ]
                },
                {
                    enunciado: "integral de x*sen(x) dx = ?",
                    aceitas:   ["sen(x)-x*cos(x)+c","sin(x)-x*cos(x)+c"],
                    passos: [
                        "Por Partes: integral de u*dv = u*v - integral de v*du",
                        "Escolha: u = x  ->  du = dx",
                        "Escolha: dv = sen(x)dx  ->  v = -cos(x)",
                        "Aplique: -x*cos(x) - integral de (-cos(x)) dx",
                        "= -x*cos(x) + integral de cos(x)dx = -x*cos(x) + sen(x)",
                        "Resultado final: sen(x) - x*cos(x) + C"
                    ]
                }
            ]
        },

        // ── FRACCIUS ── tanque, muito hp, dano baixo
        {
            nome:        "Fraccius",
            sprite:      spr_fraccius,
            hp_batalha:  130,
            dano_acerto: 50,
            dano_erro:   6,
            metodo:      "Fracoes Parciais",
            hp:          50,
            integral:    "integral de 1/x dx = ?",
            opcoes:      ["ln|x| + C", "1/x^2 + C", "-1/x + C", "x^(-1) + C"],
            resposta:    0,
            questoes: [
                {
                    enunciado: "integral de 1/x dx = ?",
                    aceitas:   ["ln|x|+c","ln(x)+c"],
                    passos: [
                        "Caso especial: integral de x^(-1) dx = ln|x| + C",
                        "A Regra da Potencia NAO vale para n = -1",
                        "Memorize: a integral de 1/x e sempre ln|x|",
                        "Resultado final: ln|x| + C"
                    ]
                },
                {
                    enunciado: "integral de 1/(x^2-1) dx = ?",
                    aceitas:   ["(1/2)*ln|(x-1)/(x+1)|+c","0.5*ln|(x-1)/(x+1)|+c"],
                    passos: [
                        "Fatore o denominador: x^2-1 = (x-1)(x+1)",
                        "Fracoes Parciais: 1/((x-1)(x+1)) = A/(x-1) + B/(x+1)",
                        "Resolva: x=1 -> A=1/2  |  x=-1 -> B=-1/2",
                        "Integre: (1/2)*ln|x-1| - (1/2)*ln|x+1| + C",
                        "Resultado final: (1/2)*ln|(x-1)/(x+1)| + C"
                    ]
                },
                {
                    enunciado: "integral de 1/(x(x+1)) dx = ?",
                    aceitas:   ["ln|x|-ln|x+1|+c","ln|x/(x+1)|+c"],
                    passos: [
                        "Fracoes Parciais: 1/(x(x+1)) = A/x + B/(x+1)",
                        "Multiplique: 1 = A(x+1) + Bx",
                        "x=0 -> A=1  |  x=-1 -> B=-1",
                        "Integre: integral de (1/x)dx - integral de (1/(x+1))dx",
                        "Resultado final: ln|x| - ln|x+1| + C"
                    ]
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