local     graphics = love.graphics
local       ipairs = ipairs
local        lower = string.lower
local      require = require
local setmetatable = setmetatable
local         defs = require 'design/defs'
local       design = require 'design/design'

module 'cell'

Cell = {}

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
		require('towers/' .. lower(grid.towerType))[grid.towerType]
			:place({x = self.x, y = self.y}, grid)
	end

	grid.towerType = "Cell"
end

function Cell:drawRange()
end

function Cell:draw()
	design.cellDraw(self)
end

