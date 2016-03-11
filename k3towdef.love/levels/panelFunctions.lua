local     defs = require 'design/defs'
local graphics = love.graphics
local    mouse = love.mouse
local   ipairs = ipairs
local      max = math.max
local      min = math.min
local     Grid = (require 'grid').Grid
local     love = love

module 'levels/panelFunctions'

local font = graphics.newFont 'res/DejaVuSans.ttf'

function empty(player, panelCell)
end

function drawInfo(player, panelCell)
	graphics.setColor(255, 255, 255)
	graphics.setFont(font)
	graphics.print(player.life .. " ♥\n"..player.money .. " $\n" .. player.waveNumber .. "/" .. player.totWave,
		(panelCell.x - 1) * panelCell.width,
		(panelCell.y - 1) * panelCell.height,
		0,
		graphics.getWidth() / defs.width,
		graphics.getHeight() / defs.height)
end

function nextWaveClick(grid)
	grid:play()
end

function retry(grid)
	return Grid:load "Welcome"
end
function quit(grid)
	love.quitApplication()
	return grid
end

function draw(image)
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
	
function drawTower(image, price)
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

local function towerDrawer(style)
	return function(player, panelCell)
		drawTower(player, panelCell, style)
	end
end

drawbasicTower = drawTower('basictower', 10) 
drawBeamTower = drawTower('beamtower', 15)
drawSlowTower = drawTower('slowtower', 25)
drawFreezeTower = drawTower('freezetower', 30)
drawSplashTower = drawTower('splashtower', 35)


function drawMouse(panelCell, image)
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

function basicMouse(panelCell) drawMouse(panelCell, 'basictower') end
function BeamMouse(panelCell) drawMouse(panelCell, 'beamtower') end
function SlowMouse(panelCell) drawMouse(panelCell, 'slowtower') end
function SplashMouse(panelCell) drawMouse(panelCell, 'splashtower') end
function FreezeMouse(panelCell) drawMouse(panelCell,'freezetower' ) end


function setTowerType(type)
	return function(grid, self)
		grid.towerType = type
	end
end
