local SplashExplosion = require 'towers/splashexplosion'
local          design = require 'design/design'

local SplashProjectile = {}

function SplashProjectile:new(splashtower, enemy, grid)
	local splashprojectile = {
		x = splashtower.x, y = splashtower.y,
		xi = splashtower.x, yi = splashtower.y,
		xe = enemy.x, ye = enemy.y,
		grid = grid,
		splashtower = splashtower
	}
	setmetatable(splashprojectile, {__index = self})

	table.insert(grid.projectiles, splashprojectile)
end

function SplashProjectile:update(dt, i)
	self.x = self.x + (self.xe - self.xi) / 6 
	self.y = self.y + (self.ye - self.yi) / 6

	for j, enemy in ipairs(self.grid.enemies) do
		if (self.x - enemy.x) ^ 2 + (self.y - enemy.y) ^ 2 <= 1 / 16  then
			enemy:hit(self.splashtower.damage)
			SplashExplosion:new(self, self.splashtower, self.grid)
			table.remove(self.grid.projectiles, i)
			for i, enemy in ipairs(self.grid.enemies) do
				if (self.x - enemy.x) ^ 2 + (self.y - enemy.y) ^ 2 <= 2 then
					enemy:hit(self.splashtower.damage)
				end
			end
		end
	end

	if self.x > #self.grid.cells[1] + 1 or self.x < -1
	or self.y > #self.grid.cells + 1 or self.y < -1 then
		table.remove(self.grid.projectiles, i)
	end
end

function SplashProjectile:draw()
	design.SplashProjectileDraw(self)
end

return SplashProjectile
