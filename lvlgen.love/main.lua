local            Grid = (require 'grid').Grid
local      fullscreen = defs.fullscreen
local          ipairs = ipairs
local         io = require 'io'
--local         io.write = io.write
local defs = require 'defs'
local grid

function love.quitApplication()
	if love.event.quit then
		love.event.quit()
	else
		love.event.push 'q'
	end
end

function love.load()
	grid = Grid:load 'empty'
	love.graphics.setFont(love.graphics.newFont("DejaVuSans.ttf",13))
end

function love.keypressed(key, unicode)
	if key == "f" or key == "f11" then
		fullscreen = not fullscreen

		if fullscreen then
			love.graphics.setMode(0, 0, true)
		else
			love.graphics.setMode(defs.width, defs.height, false)
		end

		grid:updateSize()
	end
	if key == "down" then
		grid.CellType = "Path:new(l.down)"
		grid.cells[grid.focused.y][grid.focused.x]:onClick(grid)
		grid.focused.y = grid.focused.y + 1
	elseif key == "up" then
		grid.CellType = "Path:new(l.up)"
		grid.cells[grid.focused.y][grid.focused.x]:onClick(grid)
		grid.focused.y = grid.focused.y - 1
	elseif key == "left" then
		grid.CellType = "Path:new(l.left)"
		grid.cells[grid.focused.y][grid.focused.x]:onClick(grid)
		grid.focused.x = grid.focused.x - 1
	elseif key == "right" then
		grid.CellType = "Path:new(l.right)"
		grid.cells[grid.focused.y][grid.focused.x]:onClick(grid)
		grid.focused.x = grid.focused.x + 1
	end

	if key == "q" or key == "escape" then
		love.quitApplication()
	end
	grid.cells[grid.focused.y][grid.focused.x].style = defs.FocusStyle
end

function love.mousepressed(x,y,button)
	if button == "l" then
		xg = math.ceil(x / grid.cells[1][1].width)
		yg = math.ceil(y / grid.cells[1][1].height)

		if grid.cells[yg][xg] ~= nil then
			grid.cells[yg][xg]:onClick(grid)
		else
			grid.panel.Cells[yg][xg - #grid.cells[1]]:onClick(grid)
		end
		grid.focused.x = xg
		grid.focused.y = yg 

	end
end

function love.draw()
	grid:draw()
end

function love.update(dt)
	grid:update(dt)
end
