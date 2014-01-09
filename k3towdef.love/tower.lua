local      require = require
local         defs = (require 'design/defs')
local     graphics = love.graphics
local       ipairs = ipairs
local setmetatable = setmetatable
local       insert = table.insert
local          min = math.min
local          max = math.max
local     tostring = tostring

--- Module tower, contient le code de base pour chaque tour
module 'tower'

--- Objet Tower :
-- Classe abstraite permettant la factorisation de la partie commune du code des tours
Tower = {constructible = false}

--- Fonction qui crée un nouvel objet tour.
-- Bien que tower soit une classe abstraite, cette fonction est nécessaire pour l'héritage
function Tower:new()
	local tower = {drawParameters = {}}

	setmetatable(tower, {__index = self})

	return tower
end

--- Fonctin vide qui assure la présence d'une fonction onClick dans chaque tour
function Tower:onClick()
end

--- Fonction qui permet le redimensionnement de l'affichage de la tour à l'écran
function Tower:updateSize()
	self.radius = (self.range + 1 / 2) ^ 2
	self.drawParameters.xscale = max(1, self.width / self.height)
	self.drawParameters.yscale = max(1, self.height / self.width)
 	self.drawParameters.minSide = min(self.width, self.height)
	
end

--- Fonction permettant de dessiner une tour à l'écran
function Tower:draw()
	--self.batch:add((self.x - 1) * self.width,
		       --(self.y - 1) * self.height,
		       --0,
		       --graphics.getWidth() / defs.width,
		       --graphics.getHeight() / defs.height)
end

--- Fonction permettant d'afficher à l'écran le rayon d'action de la tour
function Tower:drawRange()
	graphics.push()
	graphics.scale(self.drawParameters.xscale, self.drawParameters.yscale)
	for i, circle in ipairs(self.RangeStyle) do
		graphics.setColor(circle.color)
		graphics.circle(circle.mode,
			(self.x - 1/2) * self.drawParameters.minSide,
			(self.y - 1/2) * self.drawParameters.minSide,
			(self.range + 1/2) * self.drawParameters.minSide,
			50)
	end

	graphics.pop()
end

--- Fonction permettant de placer une tour sur la grille
--@param coord : les coordonnées auxquelles placer la tour
--@param grille : la grille dans laquelle placer la tour
function Tower:place(coord,grid)
	if grid.cells[coord.y][coord.x].constructible and grid.player:buy(grid.towerType) then
		grid.cells[coord.y][coord.x] = self:new(grid.cells[coord.y][coord.x],grid)
		grid.cells[coord.y][coord.x]:updateSize()
	end
end

--- Fonction permettant de savoir si un jeu de coordonnée est dans le rayon d'action de la tour
--@param x : abcisse du point à tester
--@param y : ordonnée du point à tester
--@return booléen : vrai si le point est dans le rayon d'action, faux sinon
function Tower:isInRange(x,y)
	return
		x ~= nil and
		y ~= nil and
		(x - self.x) ^ 2 + (y - self.y) ^ 2 <= self.radius 
end

function Tower:update(dt)
end
