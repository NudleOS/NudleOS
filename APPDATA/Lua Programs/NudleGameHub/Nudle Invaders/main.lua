--The main script for Nudle Invaders. We will import the pixel ships from ships.lua and import the player ship from player.lua

local ships = require("ships")
local player = require("player")

local game = {}
game.player = player.new()

function game:update(dt)
	game.player:update(dt)
end

function game:draw()
	game.player:draw()
end

return game

function game:run()
	love.run(self)
end

return game
