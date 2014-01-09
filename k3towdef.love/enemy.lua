local     graphics = love.graphics
local setmetatable = setmetatable
local        pairs = pairs
local          min = math.min
local       insert = table.insert
local       remove = table.remove
local        floor = math.floor
local design = require 'design/design'

--- Module enemy, défini l'objet enenmi
module 'enemy'

Enemy = {}

--- Fonction qui crée un objet ennemi
--@param life la vie de l'ennemi créé
--@param speed sa vitesse
--@param grid la grille sur laquelle il va être placé
--@param position la position à laquelle il sera placé sur la grille
--@return enemy un objet enemi
function Enemy:new(life, speed, grid, position)
	local enemy = {
		life = life,
		maxLife = life,
		speed = speed,
		initSpeed = speed,
		slowTime = 0,
		freezeTime = 0,
		grid = grid,
		position = position,
		progress = -1,
		direction = {x = 0, y = 0},
		radius = 1,
		x = 0, y = 0
	}

	setmetatable(enemy, {__index = self})
	insert(grid.enemies, enemy)

	return enemy
end

--- Fonction permettant de déterminer si l'ennemi est encore en vie
function Enemy:isAlive()
	return self.life > 0
end

--- Fonction permettant à l'ennemi de subir des dégats
--@param d quantité de dégats reçue
function Enemy:hit(d)
	self.life = self.life - d
end

--- Fonction de mise à jour de l'ennemi
--@param dt intervalle de temps entre deux mises à jour
function Enemy:update(dt)
	self.progress = self.progress + self.speed * dt

	self.x = self.position.x + self.progress * self.direction.x
	self.y = self.position.y + self.progress * self.direction.y

	if self.progress >= 1 then
		self.position.x = self.position.x + self.direction.x
		self.position.y = self.position.y + self.direction.y

		self.progress = 0
		self.direction = self.grid.cells[self.position.y][self.position.x]:move()
		if self.direction == "stop" then
			remove(self.grid.enemies, self.i)
			self.grid.player:hit(1)
		end

	end

	if not self:isAlive() then
		remove(self.grid.enemies, self.i)
		self.grid.player.money = self.grid.player.money +floor(self.maxLife / 25)
	end
	if self.speed == 0.5 then
		self.slowTime = self.slowTime + dt
		if self.slowTime > 2.8 then
			self.speed = self.initSpeed
			self.slowTime = 0
		end
	end
	if self.speed == 0 then
		self.freezeTime = self.freezeTime + dt
		if self.freezeTime > 1.2 then
			self.speed = self.initSpeed
			self.freezeTime = 0
		end
	end
end

--- Fonction qui dessine l'ennemi sur la grille
function Enemy:draw()
	design.enemyDraw(self)
end
