local       insert = table.insert
local       remove = table.remove
local setmetatable = setmetatable
local     graphics = love.graphics
local       ipairs = ipairs
local          min = math.min
local design = require 'design/design'

module 'towers/basicprojectile'

basicProjectile = {}

function basicProjectile:new(tower, enemy, grid)
	local basicprojectile = {
		x = tower.x, y = tower.y,
		xi = tower.x, yi = tower.y,
		xe = enemy.x, ye = enemy.y,
		grid = grid,
		tower = tower
	}
	setmetatable(basicprojectile, {__index = self})

	insert(grid.projectiles, basicprojectile)
end

function basicProjectile:update(dt, i)
	self.x = self.x + (self.xe - self.xi) / 7
	self.y = self.y + (self.ye - self.yi) / 7

	for j, enemy in ipairs(self.grid.enemies) do
		if (self.x - enemy.x) ^ 2 + (self.y - enemy.y) ^ 2 <= 1 / 16 then
			enemy:hit(self.tower.damage)
			remove(self.grid.projectiles, i)
			break
		end
	end

	if self.x > #self.grid.cells[1] + 1 or self.x < -1
	or self.y > #self.grid.cells + 1    or self.y < -1 then
		remove(self.grid.projectiles, i)
	end	
end

function basicProjectile:draw()
	design.basicProjectileDraw(self)
end

