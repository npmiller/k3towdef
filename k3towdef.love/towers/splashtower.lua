local            Tower = require 'tower'
local SplashProjectile = require 'towers/splashprojectile'
local           design = require 'design/design'
local             defs = require 'design/defs'

local SplashTower = Tower:new()

function SplashTower:new(Cell, grid)
	local splashtower = {
		range = 1,
		frequency = 1 / 2,
		damage = 25,
		x = Cell.x, y = Cell.y,
		width = Cell.width, height = Cell.height,
		grid = grid,
		lastShot = 0,
		drawParameters = {},
		Style = defs.SplashTowerStyle,
		RangeStyle = defs.RangeStyle,
	}

	setmetatable(splashtower, {__index = self})

	table.insert(grid.towers, splashtower)
	return splashtower
end

function SplashTower:update(dt)
	for i, enemy in ipairs(self.grid.enemies) do
		if self:isInRange(enemy.x, enemy.y)
		and self.lastShot > 1 / self.frequency then
			SplashProjectile:new(self, enemy, self.grid)
			self.lastShot = 0
		end
	end

	self.lastShot = self.lastShot + dt
end

function SplashTower:draw()
	design.SplashTowerDraw(self)
end

return SplashTower
