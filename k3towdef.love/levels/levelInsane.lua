local              l = require 'levels/levels'
local           Cell = require 'cell'
local           Path = require 'path'
local      PanelCell = require 'panel'
local EnemyGenerator = require 'enemygenerator'
local         Player = require 'player'
local              f = require 'levels/panelFunctions'
local              m = require 'music'
local         defs = require 'design/defs'

m.playMusic 'apoplexy.mod'

local conf = {
	life = 15,
	money = 30,
	prices = {
		basicTower = 10,
		BeamTower = 15,
		SlowTower = 20,
		FreezeTower = 30,
		SplashTower = 35
	}
}

local player = Player:new(conf)

local bg = love.graphics.newImage("levels/img/grass.jpeg")

local function gridDraw(self)
	love.graphics.draw(
		bg,
		0,
		0,
		0,
		love.graphics.getWidth()/defs.width,
		love.graphics.getHeight()/defs.height
		)
end

local waves = {
	{speed = 1, life = 30, frequency = 1, enemyNumber = 20},
	{speed = 2, life = 30, frequency = 1, enemyNumber = 20},
	{speed = 2, life = 25, frequency = 3, enemyNumber = 20},
	{speed = 2, life = 50, frequency = 4, enemyNumber = 20},
	{speed = 3, life = 50, frequency = 2, enemyNumber = 15},
	{speed = 4, life = 30, frequency = 6, enemyNumber = 10},
	{speed = 7, life = 20, frequency = 6, enemyNumber = 20},
	{speed = 4, life = 30, frequency = 7, enemyNumber = 15},
	{speed = 4, life = 80, frequency = 6, enemyNumber = 20},
	{speed = function() return math.random(6) end, life = 100, frequency = 4, enemyNumber = 10},
}

local function randPath()
	if math.random(2) == 2 then
		return l.left()
	else
		return l.right()
	end
end

local Cells = {
	{Cell:new(), Cell:new(), Cell:new(), Cell:new(),
	EnemyGenerator:new(l.down, waves, player), Cell:new(), Cell:new(), Cell:new(),
	Cell:new(), PanelCell:new(nil, player, f.empty, nil, f.drawInfo)},

	{Cell:new(), Path:new(l.down), Path:new(l.left), Path:new(l.left), Path:new(randPath),
	Path:new(l.down), Cell:new(), Cell:new(),  Cell:new(),
	PanelCell:new(f.drawbasicTower, player, f.setTowerType "basicTower", f.basicMouse)},

	{Cell:new(),  Path:new(l.down), Cell:new(), Cell:new(), Cell:new(),  Path:new(l.down),
	Cell:new(), Cell:new(), Cell:new(),
	PanelCell:new(f.drawBeamTower, player, f.setTowerType "BeamTower", f.BeamMouse)},

	{Cell:new(),  Path:new(l.down), Cell:new(), Cell:new(),  Cell:new(), Path:new(l.down),
	Cell:new(), Cell:new(),  Cell:new(),
	PanelCell:new(f.drawSlowTower, player, f.setTowerType "SlowTower", f.SlowMouse)},

	{Cell:new(), Path:new(l.down), Cell:new(), Cell:new(), Cell:new(), Path:new(l.down),
	Cell:new(), Cell:new(), Cell:new(),
	PanelCell:new(f.drawFreezeTower, player, f.setTowerType "FreezeTower", f.FreezeMouse)},

	{Cell:new(), Path:new(l.down), Cell:new(), Cell:new(), Cell:new(), Path:new(l.right),
	Path:new(l.right), Path:new(l.down), Cell:new(),
	PanelCell:new(f.drawSplashTower, player, f.setTowerType "SplashTower", f.SplashMouse)},

	{Cell:new(), Path:new(l.right), Path:new(l.right), Path:new(l.down), Cell:new(),
	Cell:new(), Cell:new(), Path:new(l.down), Cell:new(),
	PanelCell:new(f.draw 'nextwave', player, f.nextWaveClick, nil)},

	{Cell:new(), Cell:new(), Cell:new(), Path:new(l.down), Cell:new(), Cell:new(),
	Cell:new(), Path:new(l.down), Cell:new(), Cell:new()},

	{Cell:new(), Cell:new(), Cell:new(), Path:new(l.down), Cell:new(), Cell:new(),
	Cell:new(), Path:new(l.down), Cell:new(), Cell:new()},

	{Cell:new(), Cell:new(), Cell:new(), Path:new(l.stop), Cell:new(), Cell:new(),
	Cell:new(), Path:new(l.stop), Cell:new(), Cell:new()}
}

return { Cells = Cells, gridDraw = gridDraw, player = player }
