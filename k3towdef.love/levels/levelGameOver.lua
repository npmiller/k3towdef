local              l = require 'levels/levels'
local           Cell = (require 'cell').Cell
local           Path = (require 'path').Path
local       GameCell = (require 'gamecell').GameCell
local EnemyGenerator = (require 'enemygenerator').EnemyGenerator
local              f = require 'levels/panelFunctions'
local              m = require 'music'
local     graphics = love.graphics
local         defs = require 'design/defs'

local P = {}
setfenv(1, P)

m.playMusic 'musix-rm.mod'

function gridDraw(self)
	graphics.setColor(0, 0, 0, 128)
	graphics.rectangle(
		'fill', 0, 0,
		graphics.getWidth(),
		graphics.getHeight()
		)
end

Cells = {
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

return P
