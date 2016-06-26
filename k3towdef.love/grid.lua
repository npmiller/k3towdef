local     graphics = love.graphics
local       ipairs = ipairs
local        pairs = pairs
local setmetatable = setmetatable
local         Cell = (require 'cell').Cell
local         Path = (require 'path').Path
local         defs = require 'design/defs'
local         next = next
local       insert = table.insert
local         type = type
local       rawget = rawget
local       rawset = rawset
local getmetatable = getmetatable

local function loadLevel(name)
	package.loaded[name] = nil
	return require(name)
end

module 'grid'

Grid = {
	__index = function (table, key)
		if type(key) == 'table' then
			return table.cells[key.y][key.x]
		else
			return rawget(table, key) or
			       rawget(getmetatable(table), key)
		end
	end,
	__newindex = function (table, key, value)
		if type(key) == 'table' then
			table.cells[key.y][key.x] = value
			local cell = table.cells[key.y][key.x]
			cell:updateSize()
			graphics.setCanvas(table.canvas)
			cell:draw()
			graphics.setCanvas()
		else
			rawset(table, key, value)
		end
	end
}

function Grid:load(base)
	local level = loadLevel('levels/level' .. base)

	local grid = {
		name = base,
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

	setmetatable(grid, self)

	for _, cell in grid:range() do
		if cell.dynamic then
			insert(grid.dynamicCells, cell)
		end
		if cell.nextWave then
			insert(grid.generators, cell)
		end
	end

	if #grid.generators ~= 0 then
		grid.player.totWave = grid.generators[1]:numberOfWaves()
		grid.player.waveNumber = 0
	end

	grid:updateSize()

	return grid
end

-- next() for cells
local next_cell = function (t, k)
	local key
	if t == nil then
		return nil, nil
	end

	if k == nil then
		key = {x = 1, y = 1}
		return key, t[key]
	end

	if k.y == #t.cells then
		if k.x == #t.cells[1] then
			return nil, nil
		else
			key = {y = 1, x = k.x + 1}
		end
	else
		key = {y = k.y + 1, x = k.x}
	end

	return key, t[key]
end

-- loop over the cells of the grid
function Grid:range()
	return next_cell, self
end

function Grid:drawCanvas()
	graphics.reset()
	self.canvas = graphics.newCanvas(self.width, self.height)
	graphics.setCanvas(self.canvas)
	graphics.clear()
	self:gridDraw()

	for _, cell in self:range() do
		cell:draw()
	end
	graphics.setCanvas()
end

function Grid:updateSize()
	self.width = graphics.getWidth()
	self.height = graphics.getHeight()

	local width = self.width / #(self.cells[1])
	local height = self.height / #self.cells

	for coord, cell in self:range() do
		cell.x = coord.x
		cell.y = coord.y
		cell.width = width
		cell.height = height
		cell.grid = self
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
	for _, cell in self:range() do
		cell:update(dt)
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
