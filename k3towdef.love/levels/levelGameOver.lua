local              l = require 'levels/levels'
local           Cell = require 'cell'
local           Path = require 'path'
local       GameCell = require 'gamecell'
local EnemyGenerator = require 'enemygenerator'
local              f = require 'levels/panelFunctions'
local              m = require 'music'
local     graphics = love.graphics
local         defs = require 'design/defs'

m.playMusic 'musix-rm.mod'

local function gridDraw(self)
	graphics.setColor(0, 0, 0, 128)
	graphics.rectangle(
		'fill', 0, 0,
		graphics.getWidth(),
		graphics.getHeight()
		)
end

local Cells = {
	{GameCell:new(), GameCell:new(f.draw 'K3TowDef'),
	GameCell:new(), GameCell:new(),
	GameCell:new()},

	{GameCell:new(), GameCell:new(),
	GameCell:new(), GameCell:new(),
	GameCell:new()},

	{GameCell:new(f.draw 'GameOver'), GameCell:new(),
	GameCell:new(), GameCell:new(),
	GameCell:new()},

	{GameCell:new(), GameCell:new(),
	GameCell:new(), GameCell:new(),
	GameCell:new()},

	{GameCell:new(), GameCell:new(),
	GameCell:new(), GameCell:new(),
	GameCell:new()},

	{GameCell:new(), GameCell:new(),
	GameCell:new(), GameCell:new(),
	GameCell:new()},

	{GameCell:new(f.draw 'Back', f.back), GameCell:new(),
	GameCell:new(), GameCell:new(),
	GameCell:new(f.draw 'Restart', f.retry)}
}

return { Cells = Cells, gridDraw = gridDraw, player = player }
