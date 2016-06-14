local              l = require 'levels/levels'
local           Cell = (require 'cell').Cell
local           Path = (require 'path').Path
local      GameCell = (require 'gamecell').GameCell
local EnemyGenerator = (require 'enemygenerator').EnemyGenerator
local              f = require 'levels/panelFunctions'
local              m = require 'music'
local           Grid = (require 'grid').Grid
local     graphics = love.graphics
local         defs = require 'design/defs'

local P = {}
setfenv(1, P)

m.playMusic 'musix-rm.mod'

local function click(level)
	return function(grid)
		return Grid:load(level)
	end
end

local function levelChoice(level)
	return GameCell:new(f.draw(level), click(level))
end

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

	{GameCell:new(f.draw 'between'), levelChoice 'Easy', 
	GameCell:new(f.draw 'between'), levelChoice 'Medium', 
	GameCell:new(f.draw 'between')},

	{GameCell:new(), GameCell:new(), 
	GameCell:new(), GameCell:new(), 
	GameCell:new()},

	{GameCell:new(f.draw 'between'), levelChoice 'Hard', 
	GameCell:new(f.draw 'between'), levelChoice 'Insane', 
	GameCell:new(f.draw 'between')},

	{GameCell:new(), GameCell:new(), 
	GameCell:new(), GameCell:new(), 
	GameCell:new()},

	{GameCell:new(f.draw "Quit", f.quit), GameCell:new(), 
	GameCell:new(), GameCell:new(), levelChoice 'Help' } 
}

return P
