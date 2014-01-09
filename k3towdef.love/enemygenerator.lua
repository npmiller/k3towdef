local         Path = (require 'path').Path
local        Enemy = (require 'enemy').Enemy
local     graphics = love.graphics
local setmetatable = setmetatable
local         type = type

--- Module qui contient le générateur d'enemis
module 'enemygenerator'

EnemyGenerator = Path:new()

--- Fonction qui crée une case qui va générer des ennemis
--@param move : la direction dans laquelle vont partir les ennemis depuis cette case
--@param waves : un tableau contenant les différentes vagues d'ennemis
--@param player : le joueur de la partie en cours
function EnemyGenerator:new(move, waves, player)
	local enemygenerator = Path:new(move)
	
	enemygenerator.update = EnemyGenerator.update
	enemygenerator.player = player
	player.totWave = #waves -1

	enemygenerator.waves = waves
	enemygenerator.life = waves[1]['life']
	enemygenerator.speed = waves[1]['speed']

	enemygenerator.lastEnemy = 0
	enemygenerator.frequency = waves[1]['frequency']

	enemygenerator.waveNumber = 1
	player.waveNumber = 0
	enemygenerator.enemyNumber = waves[1]['enemyNumber']
	enemygenerator.enemies = 0
	
	setmetatable(enemygenerator, {__index = self})
	return enemygenerator
end

--- Fonction permettant de récupérer une valeur pour la création de l'ennemi depuis la table des vagues.
--@param value : si ce paramètre est un nombre, ce dernier sera renvoyé, en revanche si il s'agit d'une fonction, celle-ci sera appelée et sa valeur de retour sera renvoyée
function EnemyGenerator:getValue(value)
	if type(value) == "number" then
		return value
	elseif type(value) == "function" then
		return value()
	end
end

--- Fonction qui met à jour le générateur d'ennemis
--@param dt : intervalle de temps entre deux mises à jour
function EnemyGenerator:update(dt)
	if self.grid.play then
	self.player.waveNumber = self.waveNumber
		if self.enemies <= self.enemyNumber  then
			if self.frequency ~= 0 then
				if self.lastEnemy > 1 / self:getValue(self.frequency) then
					local enemy = Enemy:new(self:getValue(self.life),
					                        self:getValue(self.speed),
					                        self.grid,
					                        {x = self.x, y = self.y})
					enemy.direction = self:move()
					self.enemies = self.enemies + 1
					self.lastEnemy = 0
				end
		
				self.lastEnemy = self.lastEnemy + dt
			else
				self.grid.End = true
			end
		else
			self.grid.play = false
			self.waveNumber = self.waveNumber + 1
			self.life = self.waves[self.waveNumber]['life']
			self.speed = self.waves[self.waveNumber]['speed']
	
			self.lastEnemy = 0
			self.frequency = self.waves[self.waveNumber]['frequency']
	
			self.enemyNumber = self.waves[self.waveNumber]['enemyNumber']
			self.enemies = 0
		end
	end
end
