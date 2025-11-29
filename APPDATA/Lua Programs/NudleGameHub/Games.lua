--This is the lua script behind listing avaliable games to download. There are 4 games currently: Minecraft, Nudle Runner, and Nudle Text Adventure, and Nudle Invaders.
local games = {
    {
        name = "Minecraft",
        description = "A sandbox game where you can build anything you can imagine.",
        image = "minecraft.png",
        download_url = "https://www.minecraft.net/download",
    },
    {
        name = "Nudle Runner",
        description = "A simple endless runner game.",
        image = "nudle_runner.png",
        download_url = "https://www.games.NudleOS.com/nudle_runner",
    },
    {
        name = "Nudle Text Adventure",
        description = "A text-based adventure game.",
        image = "nudle_text_adventure.png",
        download_url = "https://www.games.NudleOS.com/nudle_text_adventure",
    },
    {
        name = "Nudle Invaders",
        description = "A space invaders clone.",
        image = "nudle_invaders.png",
        download_url = "https://www.games.NudleOS.com/nudle_invaders",
    },
}

-- Function to get the list of games
function getGames()
    return games
end

-- Function to get a game by name
function getGameByName(name)
    for i, game in ipairs(games) do
        if game.name == name then
            return game
        end
    end
    return nil
end
