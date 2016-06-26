local              l = require 'levels/levels'
local           Cell = require 'cell'
local           Path = require 'path'
local      PanelCell = require 'panel'
local EnemyGenerator = require 'enemygenerator'
local         Player = require 'player'
local              f = require 'levels/panelFunctions'
local              m = require 'music'
local     graphics = love.graphics
local         defs = require 'design/defs'

m.playMusic 'apoplexy.mod'

local conf = {
	life = 15,
	money = 20,
	prices = {
		basicTower = 10,
		BeamTower = 15,
		SlowTower = 25,
		FreezeTower = 30,
		SplashTower = 35
	}
}

local player = Player:new(conf)

local bg = graphics.newImage("levels/img/grass.jpeg")

local function gridDraw(self)
	graphics.draw(
		bg,
		0,
		0,
		0,
		graphics.getWidth()/defs.width,
		graphics.getHeight()/defs.height
		)
end

local waves = {
	{speed = 1, life = 40, frequency = 1, enemyNumber = 20},
	{speed = 2, life = 30, frequency = 2, enemyNumber = 20},
	{speed = 1, life = 25, frequency = 8, enemyNumber = 20},
	{speed = 2, life = 40, frequency = 2, enemyNumber = 20},
	{speed = 2, life = 50, frequency = 2, enemyNumber = 25},
	{speed = 3, life = 30, frequency = 2, enemyNumber = 10},
	{speed = 2, life = 60, frequency = 5, enemyNumber = 15},
	{speed = 3, life = 25, frequency = 2, enemyNumber = 10},
	{speed = 3, life = 35, frequency = 3, enemyNumber = 10},
	{speed = 4, life = 60, frequency = 4, enemyNumber = 5},
}

local Cells = {
	{EnemyGenerator:new(l.down, waves, player), Cell:new(), Cell:new(), Cell:new(),
	Cell:new(), Cell:new(), Cell:new(), Cell:new(), Cell:new(),
	PanelCell:new(nil, player, f.empty, nil, f.drawInfo)},

	{Path:new(l.right), Path:new(l.right), Path:new(l.down), Cell:new(), Path:new(l.right),
	Path:new(l.right), Path:new(l.right), Path:new(l.down), Cell:new(),
	PanelCell:new(f.drawbasicTower, player, f.setTowerType "basicTower", f.basicMouse)},

	{Cell:new(), Cell:new(),  Path:new(l.down), Cell:new(),  Path:new(l.up), Cell:new(),
	Cell:new(), Path:new(l.down), Cell:new(),
	PanelCell:new(f.drawBeamTower, player, f.setTowerType "BeamTower", f.BeamMouse)},

	{Cell:new(), Path:new(l.down), Path:new(l.left), Cell:new(), Path:new(l.up), Cell:new(),
	Cell:new(),  Path:new(l.down), Cell:new(),
	PanelCell:new(f.drawSlowTower, player, f.setTowerType "SlowTower", f.SlowMouse)},

	{Cell:new(), Path:new(l.down), Cell:new(), Cell:new(),  Path:new(l.up), Cell:new(),
	Cell:new(), Path:new(l.down), Cell:new(),
	PanelCell:new(f.drawFreezeTower, player, f.setTowerType "FreezeTower", f.FreezeMouse)},

	{Cell:new(), Path:new(l.down), Cell:new(), Cell:new(),  Path:new(l.up), Cell:new(),
	Cell:new(),  Path:new(l.down), Cell:new(),
	PanelCell:new(f.drawSplashTower, player, f.setTowerType "SplashTower", f.SplashMouse)},

	{Cell:new(), Path:new(l.right),  Path:new(l.right), Path:new(l.right), Path:new(l.up),
	Cell:new(), Cell:new(),  Path:new(l.down), Cell:new(),
	PanelCell:new(f.draw 'nextwave', player, f.nextWaveClick, nil)},

	{Cell:new(), Cell:new(), Cell:new(), Cell:new(), Cell:new(), Cell:new(), Cell:new(),
	Path:new(l.right), Path:new(l.down), Cell:new()},

	{Cell:new(), Path:new(l.down),  Path:new(l.left), Path:new(l.left), Path:new(l.left),
	Path:new(l.left), Cell:new(), Cell:new(), Path:new(l.down), Cell:new()},

	{Cell:new(), Path:new(l.stop), Cell:new(), Cell:new(), Cell:new(), Path:new(l.up),
	Path:new(l.left), Path:new(l.left), Path:new(l.left), Cell:new()}
}

return { Cells = Cells, gridDraw = gridDraw, player = player }
