
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
	self.drawParameters.xscale = math.max(1, self.width / self.height)
	self.drawParameters.yscale = math.max(1, self.height / self.width)
	self.drawParameters.minSide = math.min(self.width, self.height)
	
end

function Tower:draw()
end

function Tower:drawRange()
	love.graphics.push()
	love.graphics.scale(self.drawParameters.xscale, self.drawParameters.yscale)
	for i, circle in ipairs(self.RangeStyle) do
		love.graphics.setColor(circle.color)
		love.graphics.circle(circle.mode,
			(self.x - 1/2) * self.drawParameters.minSide,
			(self.y - 1/2) * self.drawParameters.minSide,
			(self.range + 1/2) * self.drawParameters.minSide,
			50)
	end

	love.graphics.pop()
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
