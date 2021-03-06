local Cell = require 'cell'
local defs = require 'design/defs'

local PanelCell = Cell:new()

function PanelCell:new(drawIn, player, onclick, drawMouse, drawMove)
	local panelcell = {
		constructible = false,
		drawIn = drawIn,
		drawMouse = drawMouse,
		player = player,
		drawMove = drawMove,
		dynamic = true
	}
	function panelcell:onClick(grid)
		grid.towerType = "Cell"
		return onclick(grid, self)
	end

	setmetatable(panelcell, {__index = self})

	if drawMove == nil then
		self.drawMove = function () end
	end

	if drawIn == nil then
		self.drawIn = function () end
	end

	return panelcell
end

function PanelCell:dynamicDraw()
	self.drawMove(self.player, self)
end

function PanelCell:update(dt)
end

function PanelCell:draw()
	love.graphics.setLineWidth(1)
	for i, rect in ipairs(defs.PanelStyle) do
		love.graphics.setColor(rect.color)
		love.graphics.rectangle(rect.mode,
			(self.x - 1) * self.width,
			(self.y - 1) * self.height,
			self.width,
			self.height)
	end
	self.drawIn(self.player, self)
end

return PanelCell
