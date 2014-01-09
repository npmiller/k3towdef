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
	}

	setmetatable(beamtower, {__index = self})

	insert(grid.towers, beamtower)
	return beamtower
   -- On considère la vitesse comme très rapide par rapport à l'ennemi
   -- l'ennemi est presque statique lorsqu'un rayon est tiré
end

function BeamTower:draw()
	--Tower.draw(self)
	design.BeamTowerDraw(self)
--debut rayon

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

			graphics.setLine(self.beamwidth, 'smooth')
			graphics.line(
				self.x * self.width - (1 / 2) * self.width - (1 / 2) * self.beamwidth,
				self.y * self.height - (1 / 2) * self.height - (1 / 2) * self.beamwidth,
				(enemy.x - 1 / 2) * self.width + (1 / 2) * self.beamwidth,
				(enemy.y - 1 / 2) * self.height + self.beamwidth)
		end
	end

	self.locked = false
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
