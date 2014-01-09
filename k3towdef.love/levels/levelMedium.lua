local              l = require 'levels/levels'
local           Cell = (require 'cell').Cell
local           Path = (require 'path').Path
local      PanelCell = (require 'panel').PanelCell
local EnemyGenerator = (require 'enemygenerator').EnemyGenerator
local         Player = (require 'player').Player
local              f = require 'levels/panelFunctions'
local              m = require 'music'
local     graphics = love.graphics
local         defs = require 'design/defs'

local P = {}
setfenv(1, P)

m.playMusic 'apoplexy.mod'

conf = {
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

player = Player:new(conf)

bg = graphics.newImage("levels/img/grass.jpeg")

function gridDraw(self)
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
	{speed = 3/2, life = 50, frequency = 1, enemyNumber = 20},
	{speed = 2, life = 35, frequency = 2, enemyNumber = 20},
	{speed = 3/2, life = 30, frequency = 8, enemyNumber = 20},
	{speed = 2, life = 50, frequency = 2, enemyNumber = 20},
	{speed = 3, life = 70, frequency = 1, enemyNumber = 15},
	{speed = 3, life = 50, frequency = 3, enemyNumber = 10},
	{speed = 2, life = 70, frequency = 8, enemyNumber = 15},
	{speed = 3, life = 50, frequency = 5, enemyNumber = 15},
	{speed = 4, life = 30, frequency = 2, enemyNumber = 10},
	{speed = 3, life = 70, frequency = 6, enemyNumber = 10},
	{speed = 0, life = 0, frequency = 0, enemyNumber = 1}
}

Cells = {
	{Cell:new(), Cell:new(), EnemyGenerator:new(l.down, waves, player), Cell:new(), 
	Cell:new(), Cell:new(), Cell:new(), Cell:new(), Cell:new(), 
	PanelCell:new(f.drawInfo, player, f.empty, nil)},

	{Cell:new(), Cell:new(), Path:new(l.down), Cell:new(), Cell:new(), Cell:new(), 
	Cell:new(), Cell:new(), Cell:new(), 
	PanelCell:new(f.drawbasicTower, player, f.setTowerType "basicTower", f.basicMouse)},

	{Cell:new(), Cell:new(),  Path:new(l.down), Cell:new(),  Cell:new(), Path:new(l.right),  
	Path:new(l.right), Path:new(l.right), Path:new(l.down), 
	PanelCell:new(f.drawBeamTower, player, f.setTowerType "BeamTower", f.BeamMouse)},

	{Cell:new(), Path:new(l.down), Path:new(l.left), Cell:new(),  Cell:new(), Path:new(l.up),
	Cell:new(), Cell:new(), Path:new(l.down), 
	PanelCell:new(f.drawSlowTower, player, f.setTowerType "SlowTower", f.SlowMouse)},

	{Cell:new(), Path:new(l.down), Cell:new(), Cell:new(), Cell:new(),  
	Path:new(l.up), Cell:new(), Cell:new(), Path:new(l.down), 
	PanelCell:new(f.drawFreezeTower, player, f.setTowerType "FreezeTower", f.FreezeMouse)},

	{Cell:new(), Path:new(l.right),  Path:new(l.right), Path:new(l.right), Path:new(l.right),
	Path:new(l.up), Cell:new(), Cell:new(),  Path:new(l.down), 
	PanelCell:new(f.drawSplashTower, player, f.setTowerType "SplashTower", f.SplashMouse)},

	{Cell:new(), Cell:new(), Cell:new(), Cell:new(), Cell:new(), Cell:new(), Cell:new(), 
	Cell:new(),   Path:new(l.down), 
	PanelCell:new(f.draw 'nextwave', player, f.nextWaveClick, nil)},

	{Cell:new(), Path:new(l.down),  Path:new(l.left),  Path:new(l.left),  Path:new(l.left),  
	Path:new(l.left),  Path:new(l.left), Cell:new(),  Path:new(l.down), Cell:new()},

	{Cell:new(), Path:new(l.down), Cell:new(), Cell:new(), Cell:new(), Cell:new(), 
	Path:new(l.up), Path:new(l.left), Path:new(l.left), Cell:new()},

	{Cell:new(), Path:new(l.stop), Cell:new(), Cell:new(), Cell:new(), Cell:new(), 
	Cell:new(), Cell:new(), Cell:new(), Cell:new()},
}

return P
