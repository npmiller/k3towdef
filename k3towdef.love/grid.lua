local     graphics = love.graphics
local       ipairs = ipairs
local        pairs = pairs
local setmetatable = setmetatable
local         Cell = (require 'cell').Cell
local         Path = (require 'path').Path
local   basicTower = (require 'towers/basictower').basicTower
local    BeamTower = (require 'towers/beamtower').BeamTower
local  FreezeTower = (require 'towers/freezetower').FreezeTower
local    SlowTower = (require 'towers/slowtower').SlowTower
local  SplashTower = (require 'towers/splashtower').SplashTower
local         defs = require 'design/defs'

local function loadLevel(name)
	package.loaded[name] = nil
	return require(name)
end

--- Module contenant la définition de la grille
module 'grid'

Grid = {}

--[[
	Les coordonnées de la case sont relatives au plateau du jeu et commencent à
	1, comme les tableaux en Lua.
--]]
--- Fonction qui charge une grille à partir d'un fichier niveau puis l'initialise
--@param base niveau à charger
function Grid:load(base)
	local level = loadLevel('levels/level' .. base)

	local grid = {
		cells = level.Cells,
		player = level.player,
		--img = graphics.newImage(level.img),
		gridDraw = level.gridDraw,
		enemies = {},
		towers = {},
		projectiles = {},
		explosions = {},
		focused = {x = 1, y = 1},
		focus = false,
		towerType = "Cell",
		play = false,
		End = false
	}

	setmetatable(grid, {__index = self})

	--Path.batch = graphics.newSpriteBatch(graphics.newImage("res/img/Path.png"))
	--basicTower.batch = graphics.newSpriteBatch(graphics.newImage("res/img/basictower.png"))
	--BeamTower.batch = graphics.newSpriteBatch(graphics.newImage("res/img/beamtower.png"))
	--FreezeTower.batch = graphics.newSpriteBatch(graphics.newImage("res/img/freezetower.png"))
	--SlowTower.batch = graphics.newSpriteBatch(graphics.newImage("res/img/slowtower.png"))
	--SplashTower.batch = graphics.newSpriteBatch(graphics.newImage("res/img/splashtower.png"))

	grid:updateSize()

	return grid
end

--- Fonction qui permet de redimensionner la grille (par exemple lors du passage en plein écran)
function Grid:updateSize()
	self.width = graphics.getWidth()
	self.height = graphics.getHeight()

	local width = self.width / #(self.cells[1])
	local height = self.height / #self.cells

	for y, line in ipairs(self.cells) do
		for x in ipairs(line) do
			self.cells[y][x].x = x
			self.cells[y][x].y = y
			self.cells[y][x].width = width
			self.cells[y][x].height = height
			self.cells[y][x].grid = self
		end
	end
	for i, tower in ipairs(self.towers) do
		tower:updateSize()
	end
end

--- Fonction de mise à jour de la grille
--@param dt intervalle de temps
function Grid:update(dt)
	for i, enemy in ipairs(self.enemies) do
		enemy.i = i
		enemy:update(dt)
	end
	for y, line in ipairs(self.cells) do
		for x, cell in ipairs(line) do
			self.cells[y][x]:update(dt)
		end
	end
	for i, projectile in ipairs(self.projectiles) do
		projectile:update(dt, i)
	end
	for i, explosion in ipairs(self.explosions) do
		explosion:update(dt, i)
	end
end

--- Fonction qui va permettre d'afficher la grille à l'écran
function Grid:draw()
	self:gridDraw()


	--Path.batch:clear()
	--graphics.setColor(255, 255, 255)
	for y, line in ipairs(self.cells) do
		for x, cell in ipairs(line) do
			cell:draw()
		end
	end
	--graphics.draw(Path.batch)

	for i, enemy in pairs(self.enemies) do
		enemy:draw()
	end

	--basicTower.batch:clear()
	--BeamTower.batch:clear()
	--FreezeTower.batch:clear()
	--SlowTower.batch:clear()
	--SplashTower.batch:clear()
	for i, tower in pairs(self.towers) do
		tower:draw()
	end
	--graphics.setColor(255, 255, 255)
	--graphics.draw(basicTower.batch)
	--graphics.draw(BeamTower.batch)
	--graphics.draw(FreezeTower.batch)
	--graphics.draw(SlowTower.batch)
	--graphics.draw(SplashTower.batch)

	for i, projectile in pairs(self.projectiles) do
		projectile:draw()
	end
	for i, explosion in pairs(self.explosions) do
		explosion:draw()
	end
end
