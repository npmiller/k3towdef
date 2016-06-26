local     defs = require 'design/defs'
local     Grid = require 'grid'

local font = love.graphics.newFont 'res/DejaVuSans.ttf'

local f = {}

function f.empty(player, panelCell)
end

function f.drawInfo(player, panelCell)
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(font)
	love.graphics.print(player.life .. " ♥\n"..player.money .. " $\n" .. player.waveNumber .. "/" .. player.totWave,
		(panelCell.x - 1) * panelCell.width,
		(panelCell.y - 1) * panelCell.height,
		0,
		love.graphics.getWidth() / defs.width,
		love.graphics.getHeight() / defs.height)
end

function f.nextWaveClick(grid)
	grid:play()
end

function f.retry(overlay, grid)
	return Grid:load(grid.name)
end
function f.back()
	return Grid:load("Welcome")
end
function f.quit()
	return love.quitApplication()
end

function f.draw(image)
	local img = love.graphics.newImage("design/img/" .. image .. ".png")
	
	return function(player, panelCell)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(img,
				(panelCell.x - 1) * panelCell.width,
				(panelCell.y - 1) * panelCell.height,
				0,
				love.graphics.getWidth() / defs.width,
				love.graphics.getHeight() / defs.height)
			end
end
	
function f.drawTower(image, price)
	local img = love.graphics.newImage("design/img/" .. image .. ".png")
	
	return function(player,panelCell)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(img,
				(panelCell.x - 1) * panelCell.width,
				(panelCell.y - 1) * panelCell.height,
				0,
				love.graphics.getWidth() / defs.width,
				love.graphics.getHeight() / defs.height)
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle('fill',
				(panelCell.x - 1) * panelCell.width,
				(panelCell.y - 1) * panelCell.height,
				17 * (love.graphics.getWidth() / defs.width),
				15 * love.graphics.getHeight() / defs.height)
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(price,
			(panelCell.x - 1) * panelCell.width,
			(panelCell.y - 1) * panelCell.height,
			0,
			love.graphics.getWidth() / defs.width,
			love.graphics.getHeight() / defs.height)
		end
end

function f.towerDrawer(style)
	return function(player, panelCell)
		f.drawTower(player, panelCell, style)
	end
end

f.drawbasicTower = f.drawTower('basictower', 10)
f.drawBeamTower = f.drawTower('beamtower', 15)
f.drawSlowTower = f.drawTower('slowtower', 25)
f.drawFreezeTower = f.drawTower('freezetower', 30)
f.drawSplashTower = f.drawTower('splashtower', 35)


function f.drawMouse(panelCell, image)
	local x, y = love.mouse.getPosition()
	local image = love.graphics.newImage("design/img/" .. image .. ".png")
	local width = panelCell.width
	local height = panelCell.height

	local xscale = math.max(1, width / height)
	local yscale = math.max(1, height / width)
	local minSide = math.min(width, height)

	love.graphics.reset()

	love.graphics.draw(image,
		x - width / 2,
		y - height / 2,
		0,
		love.graphics.getWidth() / defs.width,
		love.graphics.getHeight() / defs.height)

	love.graphics.push()
	love.graphics.scale(xscale, yscale)

	for i, circle in ipairs(defs.RangeStyle) do
		love.graphics.setColor(circle.color)
		love.graphics.circle(circle.mode,
			x / xscale,
			y / yscale,
			(1 + 1 / 2) * math.min(height, width),
			50)
	end

	love.graphics.pop()
end

function f.basicMouse(panelCell) f.drawMouse(panelCell, 'basictower') end
function f.BeamMouse(panelCell) f.drawMouse(panelCell, 'beamtower') end
function f.SlowMouse(panelCell) f.drawMouse(panelCell, 'slowtower') end
function f.SplashMouse(panelCell) f.drawMouse(panelCell, 'splashtower') end
function f.FreezeMouse(panelCell) f.drawMouse(panelCell,'freezetower' ) end


function f.setTowerType(type)
	return function(grid, self)
		grid.towerType = type
	end
end

return f
