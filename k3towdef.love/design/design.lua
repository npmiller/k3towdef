local     graphics = love.graphics
local         defs = require 'design/defs'
local       ipairs = ipairs
local       min = math.min

module 'design'

local imgs = {
	path = graphics.newImage('design/img/Path.png'),
	basictower = graphics.newImage('design/img/basictower.png'),
	beamtower = graphics.newImage('design/img/beamtower.png'),
	slowtower = graphics.newImage('design/img/slowtower.png'),
	splashtower = graphics.newImage('design/img/splashtower.png'),
	freezetower = graphics.newImage('design/img/freezetower.png')
}

local function drawImg(self, img)
	graphics.reset()
	graphics.draw(img,
	(self.x - 1) * self.width,
	(self.y - 1) * self.height,
	0,
	graphics.getWidth() / defs.width,
	graphics.getHeight() / defs.height)
end

local design = {
	cellDraw = function (cell)
		graphics.setLineWidth(1)

		for i, rect in ipairs(defs.CellStyle) do
			if cell.drawLine then
				graphics.setColor(rect.color)
				graphics.rectangle(rect.mode,
				(cell.x - 1) * cell.width,
				(cell.y - 1) * cell.height,
				cell.width,
				cell.height)
			end
		end
	end,

	pathDraw = function (self)
		--graphics.setLineWidth(1)

		--for i, rect in ipairs(defs.PathStyle) do
		--graphics.setColor(rect.color)
		--graphics.rectangle(rect.mode,
		--(self.x - 1) * self.width,
		--(self.y - 1) * self.height,
		--self.width,
		--self.height)
		--end
		drawImg(self, imgs.path)
	end,

	enemyDraw = function (self)
		local cell = self.grid.cells[1][1]

		local x local y

		x = cell.width * (self.position.x - 1/2 + self.progress * self.direction.x)
		y = cell.height * (self.position.y - 1/2 + self.progress * self.direction.y)

		local color
		if self:isAlive() then
			color = {255, 0, 0}
		else
			color = {0, 0, 0, 0}
		end

		self.radius = min(cell.width, cell.height) / 2

		graphics.setColor(0, 0, 0, 128)
		graphics.rectangle('fill',
		x - self.radius / 2,
		y - 0.8 * self.radius,
		self.radius,
		self.radius / 4)
		graphics.setColor(color[1], color[2], color[3], color[4] or 128)
		graphics.rectangle('fill',
		x - self.radius / 2,
		y - 0.8 * self.radius,
		self.radius * self.life / self.maxLife,
		self.radius / 4)

		graphics.setColor(color)
		graphics.circle('fill', x, y, self.radius / 2, 50)
	end,



	basicTowerDraw = function (self)
		drawImg(self, imgs.basictower)
	end,

	BeamTowerDraw = function (self)
		drawImg(self, imgs.beamtower)
	end,

	SlowTowerDraw = function (self)
		drawImg(self, imgs.slowtower)
	end,

	SplashTowerDraw = function (self)
		drawImg(self, imgs.splashtower)
	end,

	FreezeTowerDraw = function (self)
		drawImg(self, imgs.freezetower)
	end,

	basicProjectileDraw = function (self)
		graphics.setColor(0, 255, 0)
		graphics.circle('fill',
		self.x * self.tower.width - (1 / 2) * self.tower.width,
		self.y * self.tower.height - (1 / 2) * self.tower.height,
		min(self.tower.width, self.tower.height) / 16,
		50)
	end,

	FreezeProjectileDraw = function (self)
		graphics.push()
		graphics.scale(self.tower.drawParameters.xscale, self.tower.drawParameters.yscale)

		graphics.setColor(204, 250, 250, 255 * (1 - self.timer / self.maxTimer))
		graphics.circle('fill', 
		(self.x - 1/2) * self.tower.drawParameters.minSide,
		(self.y - 1/2) * self.tower.drawParameters.minSide,
		(self.tower.range + 1/2) * self.tower.drawParameters.minSide,
		50)

		graphics.pop()
	end,

	SlowProjectileDraw = function (self)
		graphics.setColor(0, 204, 204)
		graphics.circle('fill',
		self.x * self.tower.width - (1 / 2) * self.tower.width,
		self.y * self.tower.height - (1 / 2) * self.tower.height,
		min(self.tower.width, self.tower.height) / 16,
		50)
	end,

	SplashProjectileDraw = function (self)
		graphics.setColor(255, 255, 255)
		graphics.circle('fill',
		self.x * self.splashtower.width - (1 / 2) * self.splashtower.width,
		self.y * self.splashtower.height - (1 / 2) * self.splashtower.height,
		min(self.splashtower.width, self.splashtower.height) / 18,
		50)
	end
}

return design
