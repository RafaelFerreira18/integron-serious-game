function scr_integrons_data() {
    return [
        {
            nome:     "Substitutus",
            sprite:   spr_enemy1,
            hp:       30,
            metodo:   "Substituição Simples",
            integral: "integral de 2x dx",
            opcoes:   ["x² + C", "2x² + C", "x + C", "2 + C"],
            resposta: 0
        },
        {
            nome:     "Partius",
            sprite:   spr_enemy2,
            hp:       40,
            metodo:   "Integração por Partes",
            integral: "integral de x*e^x dx",
            opcoes:   ["e^x(x-1) + C", "x*e^x + C", "e^x + C", "x²*e^x + C"],
            resposta: 0
        },
        {
            nome:     "Fraccius",
            sprite:   spr_npc1,
            hp:       50,
            metodo:   "Frações Parciais",
            integral: "integral de 1/x dx",
            opcoes:   ["ln|x| + C", "1/x² + C", "-1/x + C", "x^-1 + C"],
            resposta: 0
        }
    ];
}