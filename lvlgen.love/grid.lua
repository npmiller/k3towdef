local     graphics = love.graphics
local       ipairs = ipairs
local        pairs = pairs
local setmetatable = setmetatable
local         Cell = (require 'cell').Cell
local         defs = require 'defs'
local           io = require 'io'
local       assert = assert

local function loadLevel(name)
	package.loaded[name] = nil
	return require(name)
end

module 'grid'

Grid = {}

function Grid:load(base)
	local level = loadLevel('lvl/' .. base)

	local grid = {
		cells = level.Cells,
		focused = {x = 1, y = 1},
		CellType = "Cell:new()",
		style = defs.CellStyle,
		lock = false,
		panel = loadLevel('lvl/panel')
	}

	setmetatable(grid, {__index = self})
	grid:updateSize()

	return grid
end

function Grid:updateSize()
	self.width = graphics.getWidth()
	self.height = graphics.getHeight()

	local width = self.width / (#(self.cells[1]) + #self.panel.Cells[1])
	local height = self.height / #self.cells

	for y, line in ipairs(self.cells) do
		for x in ipairs(line) do
			self.cells[y][x].x = x
			self.cells[y][x].y = y
			self.cells[y][x].width = width
			self.cells[y][x].height = height
			self.cells[y][x].grid = self
		end
		for z in ipairs(self.panel.Cells[y]) do
			self.panel.Cells[y][z].x = z + #self.cells[1]
			self.panel.Cells[y][z].y = y
			self.panel.Cells[y][z].width = width
			self.panel.Cells[y][z].height = height
			self.panel.Cells[y][z].grid = grid
		end
	end
end

function Grid:update(dt)
	for y, line in ipairs(self.cells) do
		for x, cell in ipairs(line) do
			self.cells[y][x]:update(dt)
		end
	end
	for y, line in ipairs(self.panel.Cells) do
		for x, cell in ipairs(line) do
			self.panel.Cells[y][x]:update(dt)
		end
	end

end

function Grid:draw()
	for y, line in ipairs(self.cells) do
		for x, cell in ipairs(line) do
			cell:draw()
		end
		for x, cell in ipairs(self.panel.Cells[y]) do
			cell:draw()
		end
	end
end

function Grid:save()
	result = "Cells = {\n"
	for y, line in ipairs(self.cells) do
		result = result .. "{ "
		for x, cell in ipairs(line) do
			if cell.constructible then
				result = result .. cell.CellType ..", "
			end
		end
		result = result .. "},\n"
	end
	result = result .. "}\n"
	f = assert(io.open("lvl/new.lua","w"))
	f:write(result)
	f:close()
end
