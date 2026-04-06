/// @description Inicializar tutorial em paginas

pagina = 0;
timer  = 0;
fade_in = 0;

// Paginas do tutorial: array de structs { titulo, linhas }
paginas = [
    {
        titulo: "Bem-vindo ao mundo de INTEGRON!",
        linhas: [
            "",
            "Em um mundo onde a matematica e a fonte de todo poder,",
            "criaturas chamadas INTEGRONS dominam as terras.",
            "",
            "Cada Integron carrega o poder de um metodo de integracao.",
            "Substituicao, Partes, Fracoes Parciais...",
            "",
            "Voce e um jovem treinador que acaba de chegar a esta regiao.",
            "Seu objetivo: capturar Integrons, dominar as integrais",
            "e derrotar a Elite Four para se tornar o Mestre Integron!"
        ]
    },
    {
        titulo: "Controles - Movimento",
        linhas: [
            "",
            "  W / Seta Cima      -  Andar para cima",
            "  S / Seta Baixo     -  Andar para baixo",
            "  A / Seta Esquerda  -  Andar para a esquerda",
            "  D / Seta Direita   -  Andar para a direita",
            "",
            "  P                  -  Abrir a Party (ver seus Integrons)",
            "  E                  -  Interagir (curar no Integron Center)",
            "",
            "Ande pela grama para encontrar Integrons selvagens!"
        ]
    },
    {
        titulo: "Controles - Batalha",
        linhas: [
            "",
            "Ao encontrar um Integron selvagem na grama,",
            "voce entrara em uma batalha de captura!",
            "",
            "  Clique em CAPTURAR para tentar pegar o Integron.",
            "",
            "Nas batalhas contra a Elite Four:",
            "  Clique em ATACAR e resolva a integral digitando a resposta.",
            "  Clique em CONFIRMAR ou pressione ENTER para enviar.",
            "  Se errar, o Integron te ensina o passo-a-passo!"
        ]
    },
    {
        titulo: "Sua Jornada Comeca Agora!",
        linhas: [
            "",
            "1. Explore a grama e CAPTURE seus primeiros Integrons.",
            "",
            "2. Cure seus Integrons no INTEGRON CENTER (pressione E).",
            "",
            "3. Desafie a ELITE FOUR - derrote um para abrir",
            "   o caminho ate o proximo desafiante.",
            "",
            "4. O ultimo desafio e o temido AXIOM!",
            "",
            "Boa sorte, jovem treinador!"
        ]
    }
];

total_paginas = array_length(paginas);
