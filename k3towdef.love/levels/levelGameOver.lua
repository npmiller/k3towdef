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

bg = graphics.newImage("levels/img/background.jpeg")

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

	{GameCell:new(f.draw 'Quit2', f.quit), GameCell:new(), 
	GameCell:new(), GameCell:new(), 
	GameCell:new(f.draw 'Restart', f.retry)} 
}

return P
