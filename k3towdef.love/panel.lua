local         Grid = (require 'grid').Grid
local         Cell = (require 'cell').Cell
local         defs = require 'design/defs'
local         love = love
local     graphics = love.graphics
local setmetatable = setmetatable
local       ipairs = ipairs

--- Module permettant de créer un panneau de contrôle pour le jeu
module 'panel'

PanelCell = Cell:new()

--- Fonction permettant de créer une case du panneau de contrôle
--@param drawIn fonction contenant les instructions de dessins de la case à l'écran
--@param player le joueur de la partie en cours
--@param onclick fonction appelée lors du clic sur la case
--@param drawMouse fonction permettant de changer le curseur de la souris après le clic sur une case du panneau
--@return panelcell la case du panneau de contrôle
function PanelCell:new(drawIn, player, onclick, drawMouse)
	local panelcell = {
		constructible = false,
		drawIn = drawIn,
		drawMouse = drawMouse,
		player = player
	}
	function panelcell:onClick(grid)
		grid.towerType = "Cell"
		onclick(grid, self)
	end

	setmetatable(panelcell, {__index = self})

	return panelcell
end

function PanelCell:update(dt)
end

--- Fonction permettant d'afficher une case du panneau de contrôle à l'écran
function PanelCell:draw()
	graphics.setLineWidth(1)
	for i, rect in ipairs(defs.PanelStyle) do
		graphics.setColor(rect.color)
		graphics.rectangle(rect.mode,
			(self.x - 1) * self.width,
			(self.y - 1) * self.height,
			self.width,
			self.height)
	end
	graphics.reset()
	self.drawIn(self.player, self)
end
