local         Grid = require 'grid'
local         Cell = require 'cell'
local         defs = require 'design/defs'
local         love = love
local     graphics = love.graphics
local setmetatable = setmetatable
local       ipairs = ipairs
local       insert = table.insert

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
		onclick(grid, self)
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
	graphics.setLineWidth(1)
	for i, rect in ipairs(defs.PanelStyle) do
		graphics.setColor(rect.color)
		graphics.rectangle(rect.mode,
			(self.x - 1) * self.width,
			(self.y - 1) * self.height,
			self.width,
			self.height)
	end
	self.drawIn(self.player, self)
end

return PanelCell
