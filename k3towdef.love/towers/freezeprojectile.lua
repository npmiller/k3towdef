local design = require 'design/design'

local FreezeProjectile = {maxTimer = 0.2}

function FreezeProjectile:new(tower, enemy, grid)
	local freezeprojectile = {
		x = tower.x, y = tower.y,
		enemy = enemy,
		grid = grid,
		tower = tower,
		timer = 0
	}
	setmetatable(freezeprojectile, {__index = self})

	table.insert(grid.projectiles, freezeprojectile)
end

function FreezeProjectile:update(dt, i)
	for j, enemy in ipairs(self.grid.enemies) do
		if self.tower:isInRange(enemy.x, enemy.y) then
			enemy:hit(self.tower.damage)
			if enemy.speed > 0 then
				enemy.speed = 0
			end
		end
	end

	self.timer = self.timer + dt

	if self.timer > self.maxTimer
	or self.x > #self.grid.cells[1] + 1 or self.x < -1
	or self.y > #self.grid.cells + 1    or self.y < -1 then
		table.remove(self.grid.projectiles, i)
	end
end

function FreezeProjectile:draw()
	design.FreezeProjectileDraw(self)
end

return FreezeProjectile
