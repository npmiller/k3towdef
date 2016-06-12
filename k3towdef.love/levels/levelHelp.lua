local              l = require 'levels/levels'
local           Cell = (require 'cell').Cell
local           Path = (require 'path').Path
local       GameCell = (require 'gamecell').GameCell
local EnemyGenerator = (require 'enemygenerator').EnemyGenerator
local         Player = (require 'player').Player
local              f = require 'levels/panelFunctions'
local       graphics = love.graphics
local           defs = require 'design/defs'
local              m = require 'music'

module 'levels/levelHelp'

local function drawInstructions(text)
	return function (player,panelCell)
		graphics.setColor(255,255,255)
		graphics.push()
		local xscale = graphics.getWidth() / defs.width
		local yscale = graphics.getHeight() / defs.height
		graphics.scale(xscale, yscale)
		graphics.printf(text,
				(panelCell.x - 1) * panelCell.width / xscale,
				(panelCell.y - 1) * panelCell.height / yscale,
				3*panelCell.width / xscale,
				"center")
		graphics.pop()
	end
end

local text = "In this game, you are the owner of a big castle. One day, the army of an enemy broke into your field, they want to take possesion of your castle!\nThat's not at all fair ! You Must cheer up and fight against them! \nIt's so generous that the god promises to help you kill the bad guys. He gives you the power to control the five weather towers. Each of them has unique superpower and will cost you a different amount of money. What you have to do is to choose the tower and put them in the position wisely.\n\nYou can drag the tower on the right side of the screen to any black block by clicking the left button of your mouse.\nThere are 4 levels for you to choose. In order to save your castle, you have 15 lifes to kill all 10 waves of enemies in one level.\n\nPress [F] button on your keyboard to enter full screen mode, press [Q/Esc] to quit.\n\nGood luck! Hope you succesfully protect your castle!"

bg = graphics.newImage("levels/img/background2.jpeg")
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
