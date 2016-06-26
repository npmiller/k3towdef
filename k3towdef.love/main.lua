local            defs = require 'design/defs'
local            Grid = (require 'grid').Grid
local      fullscreen = defs.fullscreen
local               m = require 'music'
local          ipairs = ipairs
local grid
local overlay

function love.quitApplication()
	if love.event.quit then
		love.event.quit()
	else
		love.event.push 'q'
	end
end

function love.load()
	grid = Grid:load 'Welcome'
	overlay = nil
	grid:updateSize()
end

function love.keypressed(key, unicode)
	if key == "f" or key == "f11" then
		fullscreen = not fullscreen

		if fullscreen then
			love.window.setFullscreen(true, "exclusive")
		else
			love.window.setFullscreen(false, "exclusive")
		end

		if overlay ~= nil then
			overlay:updateSize()
		end
		grid:updateSize()
	end
	if key == "escape" then
		if grid.focus then
			grid.focus = false
		elseif grid.name ~= 'Welcome' then
			grid = Grid:load 'Welcome'
		else
			love.quitApplication()
		end
	end
	if key == "q" then
		love.quitApplication()
	end
	if key == "m" then
		m.toggle()
	end
end

function love.resize()
	grid:updateSize()
	if overlay ~= nil then
		overlay:updateSize()
	end
end

function love.mousepressed(x,y,button,istouch)
	local layer
	-- Figure out on which layer to apply the click
	if overlay ~= nil then
		layer = overlay
	else
		layer = grid
	end

	-- Handle the click
	if button == 1 then
		xg = math.ceil(x / layer.cells[1][1].width)
		yg = math.ceil(y / layer.cells[1][1].height)

		-- Handle clicks at coordinates of 0
		if xg == 0 then xg = 1 end
		if yg == 0 then yg = 1 end

		if layer.cells[yg][xg].t == "gamecell"  then
			local new_grid = layer.cells[yg][xg]:onClick(overlay, grid)
			if new_grid ~= nil then
				if overlay ~= nil then
					overlay = nil
				end
				grid = new_grid
			end
			layer.focus = false
		else
			layer.cells[yg][xg]:onClick(layer)
			layer.focused = { x = xg, y = yg }
			layer.focus = true
		end
	elseif button == 2 then
		layer.focus = false
	end
end

function love.mousereleased(x, y, button, istouch)
	if istouch and button == 1 and overlay == nil then
		local cell = grid.cells[grid.focused.y][grid.focused.x]
		if cell.drawMouse ~= nil then
			xg = math.ceil(x / grid.cells[1][1].width)
			yg = math.ceil(y / grid.cells[1][1].height)

			-- Handle clicks at coordinates of 0
			if xg == 0 then xg = 1 end
			if yg == 0 then yg = 1 end

			grid.cells[yg][xg]:onClick(grid)
			grid.focused = { x = xg, y = yg }
			grid.focus = true
		end
	end
end

function love.draw()
	love.graphics.reset()
	grid:draw()

	if grid.focus then
		local drawLine = grid[grid.focused].drawMouse ~= nil

		if drawLine then
			grid[grid.focused]:drawMouse()
		end
		grid[grid.focused]:drawRange()
	end

	if overlay ~= nil then
		overlay:draw()
	end
end

function love.update(dt)
	if overlay == nil then
		if grid.player ~= nil and not grid.player:isAlive() then
			overlay = Grid:load "GameOver"
			overlay:updateSize()
		elseif grid:finished() then
			overlay = Grid:load "Win"
			overlay:updateSize()
		end
	end
	grid:update(dt)
end
