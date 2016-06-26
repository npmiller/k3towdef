local setmetatable = setmetatable
local   basicTower = require 'towers/basictower'
local    BeamTower = require 'towers/beamtower'
local    SlowTower = require 'towers/slowtower'
local  SplashTower = require 'towers/splashtower'
local  FreezeTower = require 'towers/freezetower'

Player = {}

--- Fonction permettant la création d'un joueur
--@param conf : un tableau comprenant des valeurs pour les attributs du joueur
--@return player : un objet joueur
function Player:new(conf)
	local player = {
		life = conf.life,
		money = conf.money,
		prices = conf.prices
	}

	setmetatable(player, {__index = self})

	return player
end

--- Fonction qui permet de déterminer si un joueur est mort ou non
--@return booléen : vrai si le joueur est en vie
function Player:isAlive()
	return self.life > 0
end

--- Fonction qui permet au joueur d'acheter une tour
--@param towertype : le type de la tour à acheter
--@return booléen : vrai si la tour a pu être achetée, non sinon
function Player:buy(towertype)
	local result =
		    self.prices[towertype] ~= nil
		and self.money >= self.prices[towertype]

	if result then
		self.money = self.money - self.prices[towertype]
	end

	return result
end

--- Fonction qui inflige des dégats au joueur
--@param d : quantité de dégats reçue par le joueur
function Player:hit(d)
	self.life = self.life - d
end

return Player
