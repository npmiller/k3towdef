local        l = require 'levels/levels'
local     Cell = require 'cell'
local     Path = require 'path'
local GameCell = require 'gamecell'
local        f = require 'levels/panelFunctions'
local     defs = require 'design/defs'
local        m = require 'music'

local function drawInstructions(text)
	return function (player,panelCell)
		love.graphics.setColor(255, 255, 255)
		love.graphics.push()
		local xscale = love.graphics.getWidth() / defs.width
		local yscale = love.graphics.getHeight() / defs.height
		love.graphics.scale(xscale, yscale)
		love.graphics.printf(text,
				(panelCell.x - 1) * panelCell.width / xscale,
				(panelCell.y - 1) * panelCell.height / yscale,
				3 * panelCell.width / xscale,
				"center")
		love.graphics.pop()
	end
end

local text = "In this game, you are the owner of a big castle. One day, the army of an enemy broke into your field, they want to take possesion of your castle!\nThat's not at all fair ! You Must cheer up and fight against them! \nIt's so generous that the god promises to help you kill the bad guys. He gives you the power to control the five weather towers. Each of them has unique superpower and will cost you a different amount of money. What you have to do is to choose the tower and put them in the position wisely.\n\nYou can drag the tower on the right side of the screen to any black block by clicking the left button of your mouse.\nThere are 4 levels for you to choose. In order to save your castle, you have 15 lifes to kill all 10 waves of enemies in one level.\n\nPress [F] button on your keyboard to enter full screen mode, press [Q/Esc] to quit.\n\nGood luck! Hope you succesfully protect your castle!"

local bg = love.graphics.newImage("levels/img/background2.jpeg")
local function gridDraw(self)
	love.graphics.draw(
		bg,
		0,
		0,
		0,
		love.graphics.getWidth()/defs.width,
		love.graphics.getHeight()/defs.height
		)
end

local Cells = {
	{GameCell:new(), GameCell:new(f.draw 'K3TowDef'),
	GameCell:new(), GameCell:new(),
	GameCell:new()},

	{GameCell:new(), GameCell:new(drawInstructions(text)),
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

	{GameCell:new(), GameCell:new(),
	GameCell:new(), GameCell:new(),
	GameCell:new()},

	{GameCell:new(f.draw 'Quit', f.quit), GameCell:new(),
	GameCell:new(), GameCell:new(),
	GameCell:new(f.draw 'Back', f.back)}
}

return { Cells = Cells, gridDraw = gridDraw }
