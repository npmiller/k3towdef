local             defs = require 'design/defs'
local            Tower = require 'tower'
local FreezeProjectile = require 'towers/freezeprojectile'
local           ipairs = ipairs
local     setmetatable = setmetatable
local           insert = table.insert
local         graphics = love.graphics
local design = require 'design/design'

local FreezeTower = Tower:new()

function FreezeTower:new(Cell, grid)
	local freezetower = {
		range = 1,
		frequency = 1 / 2,
		damage = 1/3,
		x = Cell.x, y = Cell.y,
		width = Cell.width, height = Cell.height,
		grid = grid,
		lastShot = 0,
		drawParameters = {},
		Style = defs.FreezeTowerStyle,
		RangeStyle = defs.RangeStyle,
	}

	setmetatable(freezetower, {__index = self})

	insert(grid.towers, freezetower)
	return freezetower
end

function FreezeTower:update(dt)
	for i, enemy in ipairs(self.grid.enemies) do
		if self:isInRange(enemy.x, enemy.y)
		and self.lastShot > 1 / self.frequency then
			FreezeProjectile:new(self, enemy, self.grid)
			self.lastShot = 0
			break
		end
	end

	self.lastShot = self.lastShot + dt
end

function FreezeTower:draw()
	design.FreezeTowerDraw(self)
end

return FreezeTower
