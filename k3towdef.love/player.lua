local  basicTower = require 'towers/basictower'
local   BeamTower = require 'towers/beamtower'
local   SlowTower = require 'towers/slowtower'
local SplashTower = require 'towers/splashtower'
local FreezeTower = require 'towers/freezetower'

local Player = {}

function Player:new(conf)
	local player = {
		life = conf.life,
		money = conf.money,
		prices = conf.prices
	}

	setmetatable(player, {__index = self})

	return player
end

function Player:isAlive()
	return self.life > 0
end

function Player:buy(towertype)
	local result =
		    self.prices[towertype] ~= nil
		and self.money >= self.prices[towertype]

	if result then
		self.money = self.money - self.prices[towertype]
	end

	return result
end

function Player:hit(d)
	self.life = self.life - d
end

return Player
