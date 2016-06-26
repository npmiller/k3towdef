local       insert = table.insert
local       remove = table.remove
local setmetatable = setmetatable
local     graphics = love.graphics
local       ipairs = ipairs
local          min = math.min
local design = require 'design/design'

local SlowProjectile = {}

function SlowProjectile:new(tower, enemy, grid)
	local slowprojectile = {
		x = tower.x, y = tower.y,
		xi = tower.x, yi = tower.y,
		xe = enemy.x, ye = enemy.y,
		grid = grid,
		tower = tower
	}
	setmetatable(slowprojectile, {__index = self})

	insert(grid.projectiles, slowprojectile)
end

function SlowProjectile:update(dt, i)
	self.x = self.x + (self.xe - self.xi)/5
	self.y = self.y + (self.ye - self.yi)/5

	for j, enemy in ipairs(self.grid.enemies) do
		if (self.x - enemy.x) ^ 2 + (self.y - enemy.y) ^ 2 <= 1 / 16  then
			enemy:hit(self.tower.damage)
			enemy.speed = 0.5
			remove(self.grid.projectiles, i)
			break
		end
	end

	if self.x > #self.grid.cells[1] + 1 or self.x < -1
	or self.y > #self.grid.cells + 1    or self.y < -1 then
		remove(self.grid.projectiles, i)
	end	
end

function SlowProjectile:draw()
	design.SlowProjectileDraw(self)
end

return SlowProjectile
