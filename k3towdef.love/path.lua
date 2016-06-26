local   Cell = require 'cell'
local design = require 'design/design'

local Path = Cell:new()

Path.constructible = false

function Path:new(move)
	local path = {}

	path.move = move

	setmetatable(path, {__index = self})

	return path
end

function Path:draw()
	design.pathDraw(self)
end

return Path
