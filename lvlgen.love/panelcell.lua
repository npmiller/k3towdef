local         Grid = (require 'grid').Grid
local         Cell = (require 'cell').Cell
local         defs = require 'defs'
local         love = love
local     graphics = love.graphics
local setmetatable = setmetatable
local       ipairs = ipairs

module 'panelcell'

PanelCell = Cell:new()

function PanelCell:new(drawIn, Type, onclick, drawMouse)
	local panelcell = {
		constructible = false,
		drawIn = drawIn,
		drawMouse = drawMouse,
		}
	if Type ~= nil then
			panelcell.CellType = Type.CellType
			panelcell.style = Type.style
	end

	function panelcell:onClick(grid)
		grid.CellType = self.CellType
		grid.style = self.style
		if onclick ~= nil then
			onclick(grid, self)
		end
	end

	setmetatable(panelcell, {__index = self})

	return panelcell
end

function PanelCell:update(dt)
end


function PanelCell:draw()
	graphics.setLineWidth(1)
	for i, rect in ipairs(defs.PanelStyle) do
		graphics.setColor(rect.color)
		graphics.rectangle(rect.mode,
			(self.x - 1) * self.width,
			(self.y - 1) * self.height,
			self.width,
			self.height)
	end
	graphics.reset()
	if self.drawIn ~= nil then
		self.drawIn(self)
	end
end
