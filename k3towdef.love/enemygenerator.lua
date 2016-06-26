local         Path = require 'path'
local        Enemy = require 'enemy'
local     graphics = love.graphics
local setmetatable = setmetatable
local         type = type
local         next = next

local EnemyGenerator = Path:new()

function EnemyGenerator:new(move, waves)
	local enemygenerator = Path:new(move)

	enemygenerator.waves = waves

	setmetatable(enemygenerator, {__index = self})
	return enemygenerator
end

function EnemyGenerator:getValue(value)
	if type(value) == "number" then
		return value
	elseif type(value) == "function" then
		return value(self.enemies, self.enemyNumber, self.lastEnemy)
	end
end

function EnemyGenerator:numberOfWaves()
	return #self.waves
end

function EnemyGenerator:nextWave()
	if self:waveFinished() then
		self.waveKey, self.wave = next(self.waves, self.waveKey)
		self.lastEnemy = 0
		self.enemies = 0
	end
end

function EnemyGenerator:newEnemy()
	Enemy:new(
		self:getValue(self.wave.life),
		self:getValue(self.wave.speed),
		self.grid,
		{x = self.x, y = self.y},
		self.move()
	)
end

function EnemyGenerator:waveFinished()
	return self.wave == nil or self.enemies == self.wave.enemyNumber
end

function EnemyGenerator:update(dt)
	if not self:waveFinished() then
		if self.lastEnemy > 1 / self:getValue(self.wave.frequency) then
			self:newEnemy()
			self.enemies = self.enemies + 1
			self.lastEnemy = 0
		end
		self.lastEnemy = self.lastEnemy + dt
	end
end

return EnemyGenerator
