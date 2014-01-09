local           Cell = (require 'cell').Cell
local      PanelCell = (require 'panelcell').PanelCell
local           defs = require 'defs'
local       graphics = love.graphics
local          event = love.event

local P = {}
setfenv(1, P)
function drawText(text)
	return function (panelCell)
	graphics.setColor(255, 255, 255)
	graphics.print(text,
		(panelCell.x - 1) * panelCell.width,
		(panelCell.y - 1) * panelCell.height,
		0,
		graphics.getWidth() / defs.width,
		graphics.getHeight() / defs.height)
	end
end

Cells = {
	{ PanelCell:new(drawText '↓',{ CellType = "Path:new(l.down)", style = defs.PathStyle }) },
	{ PanelCell:new(drawText '→',{ CellType = "Path:new(l.right)", style = defs.PathStyle}) },
	{ PanelCell:new(drawText '←',{ CellType = "Path:new(l.left)", style = defs.PathStyle}) },
	{ PanelCell:new(drawText '↑',{ CellType = "Path:new(l.up)", style = defs.PathStyle}) },
	{ PanelCell:new(drawText 'x',{ CellType = "Path:new(l.stop)", style = defs.PathStyle})  },
	{ PanelCell:new(drawText '> ↓',{ CellType = "EnemyGenerator:new(l.down, waves, player)", style = defs.PathStyle}) },
	{ PanelCell:new() },
	{ PanelCell:new() },
	{ PanelCell:new(drawText 'Save',nil,function (grid,self) grid:save() end) },
	{ PanelCell:new(drawText 'Quit',nil,function (grid,self) event.quit() end) }
	}

return P
