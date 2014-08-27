local            defs = require 'design/defs'
local            Grid = (require 'grid').Grid
local      fullscreen = defs.fullscreen
local               m = require 'music'
local          ipairs = ipairs
local grid

function love.quitApplication()
	if love.event.quit then
		love.event.quit()
	else
		love.event.push 'q'
	end
end

function love.load()
	grid = Grid:load 'Welcome'
	m.playMusic 'musix-rm.mod'
	love.graphics.setFont(love.graphics.newFont("res/DejaVuSans.ttf", 13))
end

function love.keypressed(key, unicode)
	if key == "f" or key == "f11" then
		fullscreen = not fullscreen

		if fullscreen then
			love.window.setFullscreen(true)
		else
			love.window.setFullscreen(false)
		end

		grid:updateSize()
	end
	if key == "escape" then
		grid.focus = false
	end
	if key == "q" then
		love.quitApplication()
	end
end

function love.mousepressed(x,y,button)
	if button == "l" then
		xg = math.ceil(x / grid.cells[1][1].width)
		yg = math.ceil(y / grid.cells[1][1].height)

		if grid.cells[yg][xg].t == "gamecell"  then
			grid = grid.cells[yg][xg]:onClick(grid)
			grid.focus = false
		else
			grid.cells[yg][xg]:onClick(grid)
			grid.focused = { x = xg, y = yg }
			grid.focus = true
		end
	end
	if button == "r" then 
		grid.focus = false
	end
end

function love.draw()
	love.graphics.reset()
	grid:draw()
	
	if grid.focus then
		local drawLine = grid.cells[grid.focused.y][grid.focused.x].drawMouse ~= nil

		if drawLine then
			grid.cells[grid.focused.y][grid.focused.x]:drawMouse()
		end
		grid.cells[grid.focused.y][grid.focused.x]:drawRange()
	end
	for y, line in ipairs(grid.cells) do
		for x in ipairs(line) do
			grid.cells[y][x].drawLine = drawLine
		end
	end
end

function love.update(dt)
	if grid.player ~= nil and not grid.player:isAlive() then
		grid = Grid:load "GameOver"
	elseif grid.End and not next(grid.enemies) then
		grid = Grid:load "Win"
	end
	grid:update(dt)
end
