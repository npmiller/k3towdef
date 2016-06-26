local           defs = require 'design/defs'
local          Tower = require 'tower'
local SlowProjectile = require 'towers/slowprojectile'
local         ipairs = ipairs
local   setmetatable = setmetatable
local         insert = table.insert
local       graphics = love.graphics
local design = require 'design/design'

local SlowTower = Tower:new()

function SlowTower:new(Cell, grid)
	local slowtower = {
		range = 1,
		frequency = 4/3,
		damage = 15,
		x = Cell.x, y = Cell.y,
		width = Cell.width, height = Cell.height,
		grid = grid,
		lastShot = 0,
		drawParameters = {},
		Style = defs.SlowTowerStyle,
		RangeStyle = defs.RangeStyle,
	}

	setmetatable(slowtower, {__index = self})

	insert(grid.towers, slowtower)
	return slowtower
end

function SlowTower:update(dt)
	for i, enemy in ipairs(self.grid.enemies) do
		if self:isInRange(enemy.x, enemy.y)
		and self.lastShot > 1 / self.frequency
		and enemy.speed > 0.5 then
			SlowProjectile:new(self, enemy, self.grid)
			self.lastShot = 0
		end
	end

	self.lastShot = self.lastShot + dt
end

function SlowTower:draw()
	design.SlowTowerDraw(self)
end

return SlowTower
