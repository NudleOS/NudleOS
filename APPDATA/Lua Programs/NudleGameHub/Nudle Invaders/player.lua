--The player ship. There are guns to attack the others.

local Player = {}
Player.__index = Player

--Load the player
function Player.new(x, y, image)
    local self = setmetatable({}, Player)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(image)
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
    self.speed = 200
	self.alive = true
	self.health = 3
	self.maxHealth = 3
	self.canShoot = true
	self.shootTimer = 0
	self.shootCooldown = 0.5
	self.bullets = {}
    return self
end

--Draw the player
function Player:draw()
	if self.alive then
    	love.graphics.draw(self.image, self.x, self.y)
	end
	for i, bullet in ipairs(self.bullets) do
		bullet:draw()
	end
end

--Update the player
function Player:update(dt)
	if self.alive then
		--Move the player
		if love.keyboard.isDown("a") then
			self.x = self.x - self.speed * dt
		elseif love.keyboard.isDown("d") then
			self.x = self.x + self.speed * dt
		end

		--Keep the player in bounds
		if self.x < 0 then
			self.x = 0
		elseif self.x > love.graphics.getWidth() - self.width then
			self.x = love.graphics.getWidth() - self.width
		end

		--Shoot
		if love.keyboard.isDown("space") and self.canShoot then
			self:shoot()
		end

		--Update the shoot timer
		if not self.canShoot then
			self.shootTimer = self.shootTimer + dt
			if self.shootTimer >= self.shootCooldown then
				self.canShoot = true
				self.shootTimer = 0
			end
		end
	end

	--Update bullets
	for i, bullet in ipairs(self.bullets) do
		bullet:update(dt)
		if bullet.y < 0 then
			table.remove(self.bullets, i)
		end
	end
end

--Shoot a bullet
function Player:shoot()
	if self.alive and self.canShoot then
		local bullet = Bullet.new(self.x + self.width / 2 - 2, self.y, "assets/bullet.png", -300)
		table.insert(self.bullets, bullet)
		self.canShoot = false
	end
end

--Damage the player
function Player:damage()
	self.health = self.health - 1
	if self.health <= 0 then
		self.alive = false
	end
end

return Player
