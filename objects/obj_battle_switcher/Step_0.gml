if (!transitioned)
{
    // === FASE 1: Fechando as barras ===
    bar_height += bar_speed;

    if (bar_height > target) {
        bar_height = target;
    }

    // Quando as barras fecharam completamente
    if (bar_height >= target)
    {
        if (!is_undefined(integron))
        {
            transitioned = true;
            show_debug_message("[switcher] Indo para batalha");
            room_goto(rm_battle);
        }
    }
}
else
{
    // === FASE 2: Abrindo as barras na nova room ===
    bar_height -= bar_speed;

    if (bar_height <= 0)
    {
        bar_height = 0;

        // Nao abre o quiz automaticamente.
        // O overlay deve ser ativado apenas ao clicar em Capturar.

        // Para de rodar o Step (transição terminou)
        // O switcher continua vivo para o controller usar depois
    }
}
