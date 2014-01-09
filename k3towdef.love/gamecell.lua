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
function GameCell:new(drawIn, onclick)
	local gamecell = {
		constructible = false,
		t = "gamecell",
	}

	if drawIn ~= nil then
		gamecell.drawIn = drawIn
	else
		gamecell.drawIn = function () end
	end

	function gamecell:onClick(grid)
		if onclick ~= nil then
			return onclick(grid, self)
		else
			return grid
		end
	end


	setmetatable(gamecell, {__index = self})

	return gamecell
end

function GameCell:update(dt)
end


function GameCell:draw()
	self.drawIn(self.player, self)
end
