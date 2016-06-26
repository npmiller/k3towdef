local     defs = require 'design/defs'
local graphics = love.graphics
local    mouse = love.mouse
local   ipairs = ipairs
local      max = math.max
local      min = math.min
local     Grid = require 'grid'
local     love = love

local font = graphics.newFont 'res/DejaVuSans.ttf'

local f = {}

function f.empty(player, panelCell)
end

function f.drawInfo(player, panelCell)
	graphics.setColor(255, 255, 255)
	graphics.setFont(font)
	graphics.print(player.life .. " ♥\n"..player.money .. " $\n" .. player.waveNumber .. "/" .. player.totWave,
		(panelCell.x - 1) * panelCell.width,
		(panelCell.y - 1) * panelCell.height,
		0,
		graphics.getWidth() / defs.width,
		graphics.getHeight() / defs.height)
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
	local img = graphics.newImage("design/img/"..image..".png")
	
	return function(player, panelCell)
		graphics.setColor(255, 255, 255)
		graphics.draw(img,
				(panelCell.x - 1) * panelCell.width,
				(panelCell.y - 1) * panelCell.height,
				0,
				graphics.getWidth() / defs.width,
				graphics.getHeight() / defs.height)
			end
end
	
function f.drawTower(image, price)
	local img = graphics.newImage("design/img/"..image..".png")
	
	return function(player,panelCell)
		graphics.setColor(255, 255, 255)
		graphics.draw(img,
				(panelCell.x - 1) * panelCell.width,
				(panelCell.y - 1) * panelCell.height,
				0,
				graphics.getWidth() / defs.width,
				graphics.getHeight() / defs.height)
		graphics.setColor(0,0,0)
		graphics.rectangle('fill',
				(panelCell.x - 1) * panelCell.width,
				(panelCell.y - 1) * panelCell.height,
				17*(graphics.getWidth()/defs.width),
				15*graphics.getHeight()/defs.height)
		graphics.setColor(255, 255, 255)
		graphics.print(price,
			(panelCell.x - 1) * panelCell.width,
			(panelCell.y - 1) * panelCell.height,
			0,
			graphics.getWidth() / defs.width,
			graphics.getHeight() / defs.height)
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
	local x, y = mouse.getPosition()
	local image = graphics.newImage("design/img/" .. image ..".png")
	local width = panelCell.width
	local height = panelCell.height

	local xscale = max(1, width / height)
	local yscale = max(1, height / width)
	local minSide = min(width, height)

	graphics.reset()

	graphics.draw(image,
		x - width / 2,
		y - height / 2,
		0,
		graphics.getWidth() / defs.width,
		graphics.getHeight() / defs.height)

	graphics.push()
	graphics.scale(xscale, yscale)

	for i, circle in ipairs(defs.RangeStyle) do
		graphics.setColor(circle.color)
		graphics.circle(circle.mode,
			x / xscale,
			y / yscale,
			(1 + 1 / 2) * min(height, width),
			50)
	end

	graphics.pop()
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
