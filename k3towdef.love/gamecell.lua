local Cell = require 'cell'

local GameCell = Cell:new()

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
		table.insert(grid.movingDraw, gamecell)
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

return GameCell
