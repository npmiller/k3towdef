local        l = require 'levels/levels'
local     Cell = require 'cell'
local     Path = require 'path'
local GameCell = require 'gamecell'
local        f = require 'levels/panelFunctions'
local        m = require 'music'
local     defs = require 'design/defs'

m.playMusic 'musix-rm.mod'

local function gridDraw(self)
	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.rectangle(
		'fill', 0, 0,
		love.graphics.getWidth(),
		love.graphics.getHeight()
		)
end

local Cells = {
	{GameCell:new(f.empty, f.Click), GameCell:new(f.draw 'K3TowDef', f.Click),
	GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click)},

	{GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click)},

	{GameCell:new(f.draw 'victory', f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click)},

	{GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click)},

	{GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click)},

	{GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click)},

	{GameCell:new(f.draw 'Back', f.back), GameCell:new(f.empty, f.Click),
	GameCell:new(f.empty, f.Click), GameCell:new(f.empty, f.Click),
	GameCell:new(f.draw 'Restart', f.retry)}
}

return { Cells = Cells, gridDraw = gridDraw, player = player }
