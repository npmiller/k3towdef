local     graphics = love.graphics
local       ipairs = ipairs
local        lower = string.lower
local      require = require
local setmetatable = setmetatable
local         defs = require 'design/defs'
local   basicTower = (require 'towers/basictower').basicTower
local    BeamTower = (require 'towers/beamtower').BeamTower
local    SlowTower = (require 'towers/slowtower').SlowTower
local  SplashTower = (require 'towers/splashtower').SplashTower
local  FreezeTower = (require 'towers/freezetower').FreezeTower
local       design = require 'design/design'

--- Module cell, défini un objet case de la grille
module 'cell'

Cell = {}

function Cell:load()
end

--[[
	Les coordonnées de la case sont relatives au plateau du jeu et commencent à
	1, comme les tableaux en Lua.

	Cell compte en fait sur Grid pour définir quelques unes de ses propriétés :
	x, y, width, height.
--]]

--- Création d'une cellule de base
--@return cell Un nouvel objet cellule
function Cell:new()
	local cell = { 
		constructible = true,
		drawLine = true
	}

	setmetatable(cell, {__index = self})

	return cell
end

--- Fonction de mise à jour de la cellule.
-- Vide pour la cellule de base.
function Cell:update(dt)
end

--- Fonction permettant de placer la cellule.
-- Ne fait rien pour la cellule de base.
--@param coord coordonnées auxquelles placer la cellule
--@param grid grille sur laquelle placer la cellule
function Cell:place(coord, grid)
end

--- Fonction appelée lorsque l'on clique sur la cellule
--@param grid La grille courante
function Cell:onClick(grid)
	if grid.towerType ~= "Cell" then
		require('towers/' .. lower(grid.towerType))[grid.towerType]
			:place({x = self.x, y = self.y}, grid)
	end

	grid.towerType = "Cell"
end

--- Fonction permettant de dessiner la zone d'attaque d'une tour
--Vide dans le cas de la cellule de base
function Cell:drawRange()
end

--- Fonction permettant de dessiner la cellule sur la grille
function Cell:draw()
	design.cellDraw(self)
end

