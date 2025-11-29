--Nudle Runner
--A graphical game where you jump through an obstacle course to escape enemies

--Made by Nudle
--Copyright Nudle
local screenWidth = graphics.getWidth()
local screenHeight = graphics.getHeight()

function love.load()
  love.window.setTitle("Nudle Runner")
end

function love.update(dt)
end

function love.draw()
  love.graphics.print("Nudle Runner", screenWidth/2 - 50, screenHeight/2)
end