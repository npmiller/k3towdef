local         Grid = (require 'grid').Grid
local         Cell = (require 'cell').Cell
local         defs = (require 'design/defs')
local         love = love
local     graphics = love.graphics
local setmetatable = setmetatable
local       ipairs = ipairs

--- Module qui défini une case faisant partie du panel de contrôles
module 'gamecell'

GameCell = Cell:new()

--- Fonction permettant de créer une nouvelle case de panneau de contrôle
--@param drawIn fonction déterminant ce qui doit être déssiné dans la case
--@paramn onclick action effectuée lorsque l'on clique sur la case
function GameCell:new(drawIn, onclick, drawMove)
	local gamecell = {
		constructible = false,
		t = "gamecell",
	}

	if drawIn ~= nil then
		gamecell.drawIn = drawIn
	else
		gamecell.drawIn = function () end
	end

	function gamecell:onClick(overlay, grid)
		return (onclick or function (a,b) return nil end)(overlay, grid, self)
	end

	setmetatable(gamecell, {__index = self})

	if drawMove ~= nil then
		gamecell.movingDrawIn = drawMove
		insert(grid.movingDraw, gamecell)
	else
		gamecell.movingDrawIn = function () end
	end

	return gamecell
end

function GameCell:update(dt)
end

function GameCell:movingDraw()
	self.movingDrawIn(self.player, self)
end

function GameCell:draw()
	self.drawIn(self.player, self)
end
