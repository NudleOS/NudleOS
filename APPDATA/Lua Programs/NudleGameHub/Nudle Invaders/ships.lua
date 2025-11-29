--We will create pixelated ships as if it's in a 16-bit game. These are enemies.

local Ships = {}

function Ships:new(x, y, speed, health, damage, image)
    local ship = {
        x = x,
        y = y,
        speed = speed,
        health = health,
        damage = damage,
        image = image,
        width = image:getWidth(),
        height = image:getHeight(),
        alive = true
    }
    setmetatable(ship, self)
    self.__index = self
    return ship
end

function Ships:update(dt)
    self.y = self.y + self.speed * dt
end

function Ships:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Ships:isAlive()
    return self.alive
end

function Ships:takeDamage(damage)
    self.health = self.health - damage
    if self.health <= 0 then
        self.alive = false
    end
end

return Ships
