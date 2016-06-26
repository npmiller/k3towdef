local design = require 'design/design'

local Cell = {}

function Cell:new()
	local cell = {
		constructible = true,
		dynamic = false
	}

	setmetatable(cell, {__index = self})

	return cell
end

function Cell:update(dt)
end

function Cell:place(coord, grid)
end

function Cell:onClick(grid)
	if grid.towerType ~= "Cell" then
		local tower = require('towers/' .. string.lower(grid.towerType))
		tower:place({x = self.x, y = self.y}, grid)
	end

	grid.towerType = "Cell"
end

function Cell:drawRange()
end

function Cell:draw()
	design.cellDraw(self)
end

return Cell
