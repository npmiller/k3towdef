local      require = require
local         defs = require 'design/defs'
local     graphics = love.graphics
local       ipairs = ipairs
local setmetatable = setmetatable
local       insert = table.insert
local          min = math.min
local          max = math.max
local     tostring = tostring

local Tower = {constructible = false, dynamic = false}

function Tower:new()
	local tower = {drawParameters = {}}

	setmetatable(tower, {__index = self})

	return tower
end

function Tower:onClick()
end

function Tower:updateSize()
	self.radius = (self.range + 1 / 2) ^ 2
	self.drawParameters.xscale = max(1, self.width / self.height)
	self.drawParameters.yscale = max(1, self.height / self.width)
	self.drawParameters.minSide = min(self.width, self.height)
	
end

function Tower:draw()
end

function Tower:drawRange()
	graphics.push()
	graphics.scale(self.drawParameters.xscale, self.drawParameters.yscale)
	for i, circle in ipairs(self.RangeStyle) do
		graphics.setColor(circle.color)
		graphics.circle(circle.mode,
			(self.x - 1/2) * self.drawParameters.minSide,
			(self.y - 1/2) * self.drawParameters.minSide,
			(self.range + 1/2) * self.drawParameters.minSide,
			50)
	end

	graphics.pop()
end

function Tower:place(coord, grid)
	if grid[coord].constructible and grid.player:buy(grid.towerType) then
		grid[coord] = self:new(grid[coord], grid)
	end
end

function Tower:isInRange(x,y)
	return
		x ~= nil and
		y ~= nil and
		(x - self.x) ^ 2 + (y - self.y) ^ 2 <= self.radius
end

function Tower:update(dt)
end

return Tower
