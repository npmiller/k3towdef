
local SplashExplosion = {maxTimer = 0.3}

function SplashExplosion:new(splashprojectile, splashtower, grid)
	local splashexplosion = {
		x = splashprojectile.x, y = splashprojectile.y,
		splashtower = splashtower,
		grid = grid,
		timer = 0
	}
	setmetatable(splashexplosion, {__index = self})
	
	table.insert(grid.explosions, splashexplosion)
end

function SplashExplosion:update(dt, i)
	for i, splashexplosion in ipairs(self.grid.explosions) do
		self.timer = self.timer + dt
		if self.timer > self.maxTimer then
			table.remove(self.grid.explosions, i)
		end
	end
end

function SplashExplosion:draw()
	love.graphics.setColor(0, 0, 0, 255 * (1 - self.timer / self.maxTimer))
	love.graphics.circle('fill',
		self.x * self.splashtower.width - (1 / 2) * self.splashtower.width,
		self.y * self.splashtower.height - (1 / 2) * self.splashtower.height,
		1.3 * math.min(self.splashtower.width, self.splashtower.height) * self.timer / self.maxTimer,
		50)
end

return SplashExplosion
