local design = require 'design/design'

local Enemy = {}

function Enemy:new(life, speed, grid, position, direction)
	local enemy = {
		life = life,
		maxLife = life,
		speed = speed,
		initSpeed = speed,
		slowTime = 0,
		freezeTime = 0,
		grid = grid,
		position = position,
		progress = -1,
		direction = direction,
		radius = 1,
		x = 0, y = 0,
		ingame = true
	}

	setmetatable(enemy, {__index = self})
	table.insert(grid.enemies, enemy)

	return enemy
end

function Enemy:isAlive()
	return self.life > 0
end

function Enemy:hit(d)
	self.life = self.life - d
end

function Enemy:update(dt)
	self.progress = self.progress + self.speed * dt

	self.x = self.position.x + self.progress * self.direction.x
	self.y = self.position.y + self.progress * self.direction.y

	if self.progress >= 1 then
		self.position.x = self.position.x + self.direction.x
		self.position.y = self.position.y + self.direction.y

		self.progress = 0
		self.direction = self.grid[self.position]:move()
		if self.direction == "stop" then
			table.remove(self.grid.enemies, self.i)
			self.ingame = false
			self.grid.player:hit(1)
		end

	end

	if not self:isAlive() then
		table.remove(self.grid.enemies, self.i)
		self.ingame = false
		self.grid.player.money = self.grid.player.money + math.floor(self.maxLife / 25)
	end
	if self.speed == 0.5 then
		self.slowTime = self.slowTime + dt
		if self.slowTime > 2.8 then
			self.speed = self.initSpeed
			self.slowTime = 0
		end
	end
	if self.speed == 0 then
		self.freezeTime = self.freezeTime + dt
		if self.freezeTime > 1.2 then
			self.speed = self.initSpeed
			self.freezeTime = 0
		end
	end
end

function Enemy:draw()
	design.enemyDraw(self)
end

return Enemy
