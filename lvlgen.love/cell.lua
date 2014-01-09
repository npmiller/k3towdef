local     graphics = love.graphics
local       ipairs = ipairs
local        lower = string.lower
local      require = require
local setmetatable = setmetatable
local         defs = require 'defs'

module 'cell'

Cell = {constructible = true}

function Cell:load()
end

function Cell:new()
	local cell = { CellType = "Cell:new()", style = defs.CellStyle }

	setmetatable(cell, {__index = self})

	return cell
end

function Cell:update(dt)
end

function Cell:place(coord, grid)
end

function Cell:onClick(grid)
	if grid.CellType ~= "Cell:new()" then
		self.CellType = grid.CellType
		self.style = grid.style
	end
end

function Cell:drawRange()
end

function Cell:draw()
	graphics.setLineWidth(1)
	graphics.reset()
	for i, rect in ipairs(self.style) do
			graphics.setColor(rect.color)
			graphics.rectangle(rect.mode,
				(self.x - 1) * self.width,
				(self.y - 1) * self.height,
				self.width,
				self.height)
	end
end
