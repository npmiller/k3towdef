local              l = require 'levels/levels'
local           Cell = require 'cell'
local           Path = require 'path'
local       GameCell = require 'gamecell'
local EnemyGenerator = require 'enemygenerator'
local              f = require 'levels/panelFunctions'
local              m = require 'music'
local           Grid = require 'grid'
local     graphics = love.graphics
local         defs = require 'design/defs'

m.playMusic 'musix-rm.mod'

local function click(level)
	return function(grid)
		return Grid:load(level)
	end
end

local function levelChoice(level)
	return GameCell:new(f.draw(level), click(level))
end

local bg = graphics.newImage("levels/img/background.jpeg")

local function gridDraw(self)
	graphics.draw(
		bg,
		0,
		0,
		0,
		graphics.getWidth()/defs.width,
		graphics.getHeight()/defs.height
		)
end

local Cells = {
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

return { Cells = Cells, gridDraw = gridDraw, player = player }
