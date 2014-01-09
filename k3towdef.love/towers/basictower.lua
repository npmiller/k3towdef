local            defs = require 'design/defs'
local basicProjectile = (require 'towers/basicprojectile').basicProjectile
local           Tower = (require 'tower').Tower
local          ipairs = ipairs
local    setmetatable = setmetatable
local          insert = table.insert
local        graphics = love.graphics
local design = require 'design/design'

module 'towers/basictower'

basicTower = Tower:new()


function basicTower:new(Cell, grid)
	local basictower = {
		range = 1,
		frequency = 10,
		damage = 3,
		x = Cell.x, y = Cell.y,
		width = Cell.width, height = Cell.height,
		grid = grid,
		lastShot = 0,
		drawParameters = {},
		Style = defs.BasicTowerStyle,
		RangeStyle = defs.RangeStyle,
	}

	setmetatable(basictower, {__index = self})

	insert(grid.towers, basictower)
	return basictower
end

function basicTower:update(dt)
	for i, enemy in ipairs(self.grid.enemies) do
		if self:isInRange(enemy.x, enemy.y)
		and self.lastShot > 1 / self.frequency then
			basicProjectile:new(self, enemy, self.grid)
			self.lastShot = 0
		end
	end

	self.lastShot = self.lastShot + dt
end

function basicTower:draw()
	design.basicTowerDraw(self)
end
