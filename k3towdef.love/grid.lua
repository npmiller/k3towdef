local     graphics = love.graphics
local       ipairs = ipairs
local        pairs = pairs
local setmetatable = setmetatable
local         Cell = (require 'cell').Cell
local         Path = (require 'path').Path
local         defs = require 'design/defs'
local         next = next
local       insert = table.insert

local function loadLevel(name)
	package.loaded[name] = nil
	return require(name)
end

module 'grid'

Grid = {}

function Grid:load(base)
	local level = loadLevel('levels/level' .. base)

	local grid = {
		cells = level.Cells,
		player = level.player,
		--img = graphics.newImage(level.img),
		gridDraw = level.gridDraw,
		enemies = {},
		towers = {},
		projectiles = {},
		explosions = {},
		focused = {x = 1, y = 1},
		focus = false,
		towerType = "Cell",
		End = false,
		canvas = canvas,
		dynamicCells = {},
		generators = {},
	}

	setmetatable(grid, {__index = self})

	for y, line in ipairs(grid.cells) do
		for x, cell in ipairs(line) do
			if cell.dynamic then
				insert(grid.dynamicCells, cell)
			end
			if cell.nextWave then
				insert(grid.generators, cell)
			end
		end
	end

	if #grid.generators ~= 0 then
		grid.player.totWave = grid.generators[1]:numberOfWaves()
		grid.player.waveNumber = 0
	end

	grid:updateSize()

	return grid
end

function Grid:drawCanvas()
	graphics.reset()
	self.canvas = graphics.newCanvas(self.width, self.height)
	graphics.setCanvas(self.canvas)
	graphics.clear()
	self:gridDraw()
	for y, line in ipairs(self.cells) do
		for x, cell in ipairs(line) do
			cell:draw()
		end
	end
	graphics.setCanvas()
end

function Grid:updateSize()
	self.width = graphics.getWidth()
	self.height = graphics.getHeight()

	local width = self.width / #(self.cells[1])
	local height = self.height / #self.cells

	for y, line in ipairs(self.cells) do
		for x in ipairs(line) do
			self.cells[y][x].x = x
			self.cells[y][x].y = y
			self.cells[y][x].width = width
			self.cells[y][x].height = height
			self.cells[y][x].grid = self
		end
	end
	for i, tower in ipairs(self.towers) do
		tower:updateSize()
	end

	self:drawCanvas()
end

function Grid:update(dt)
	for i, enemy in ipairs(self.enemies) do
		enemy.i = i
		enemy:update(dt)
	end
	for y, line in ipairs(self.cells) do
		for x, cell in ipairs(line) do
			self.cells[y][x]:update(dt)
		end
	end
	for i, projectile in ipairs(self.projectiles) do
		projectile:update(dt, i)
	end
	for i, explosion in ipairs(self.explosions) do
		explosion:update(dt, i)
	end
end

function Grid:finished()
	return self:wavesFinished() and not next(self.enemies) and next(self.generators) and self.player.totWave == self.player.waveNumber
end

function Grid:wavesFinished()
	for _, g in pairs(self.generators) do
		if not g:waveFinished() then
			return false
		end
	end
	return true
end

function Grid:play()
	if self:wavesFinished() then
		for _, g in pairs(self.generators) do
			g:nextWave()
		end
		self.player.waveNumber = self.player.waveNumber + 1
	end
end

function Grid:draw()
	graphics.reset()
	graphics.draw(self.canvas)

	for i, cell in pairs(self.dynamicCells) do
		cell:dynamicDraw()
	end

	for i, enemy in pairs(self.enemies) do
		enemy:draw()
	end

	for i, projectile in pairs(self.projectiles) do
		projectile:draw()
	end
	for i, explosion in pairs(self.explosions) do
		explosion:draw()
	end
end
