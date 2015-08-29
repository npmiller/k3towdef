local         defs = require 'design/defs'
local        Tower = (require 'tower').Tower
local     graphics = love.graphics
local       ipairs = ipairs
local setmetatable = setmetatable
local       insert = table.insert
local design = require 'design/design'

--pour le rayon
local       random = math.random
local         sqrt = math.sqrt
local       arctan = math.atan2

module 'towers/beamtower'

BeamTower = Tower:new()


function BeamTower:new(Cell, grid)
	local beamtower = {
		x = Cell.x, y = Cell.y,
		width = Cell.width, height = Cell.height,
		grid = grid,
		beamwidth = 10,
		drawParameters = {},
		locked = false,
		range = 1,
		Style = defs.BeamTowerStyle,
		RangeStyle = defs.RangeStyle,
		radius = (1 + 1 / 2) ^ 2,
		damage = 25,
		dynamic = true
	}

	setmetatable(beamtower, {__index = self})

	insert(grid.dynamicCells, beamtower)
	return beamtower
end

function BeamTower:dynamicDraw()
	for i, enemy in ipairs(self.grid.enemies) do
		local length_beam = sqrt(
			(self.x * self.width - enemy.x) ^ 2 +
			(self.y * self.height - enemy.y) ^ 2) --Pythagore FTW

		if self:isInRange(enemy.x, enemy.y) and not self.locked then
			self.locked = true
			graphics.setColor(73, 108, 236)

			if self.beamwidth >= 3 then
				self.beamwidth = self.beamwidth * 0.99
			else
				self.beamwidth = 10 * random()
			end

			graphics.setLineWidth(self.beamwidth)
			graphics.setLineStyle('smooth')
			graphics.line(
				self.x * self.width - (1 / 2) * self.width - (1 / 2) * self.beamwidth,
				self.y * self.height - (1 / 2) * self.height - (1 / 2) * self.beamwidth,
				(enemy.x - 1 / 2) * self.width + (1 / 2) * self.beamwidth,
				(enemy.y - 1 / 2) * self.height + self.beamwidth)
		end
	end

	self.locked = false
end

function BeamTower:draw()
	design.BeamTowerDraw(self)
end

function BeamTower:update(dt)
	for i, enemy in ipairs(self.grid.enemies) do
		if self:isInRange(enemy.x, enemy.y) and not self.locked then
			enemy:hit(self.damage * dt)
			self.locked = true
		end
	end

	self.locked = false
end
