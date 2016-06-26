local         Cell = require 'cell'
local design = require 'design/design'
local         defs = require 'design/defs'
local     graphics = love.graphics
local      require = require
local       ipairs = ipairs
local setmetatable = setmetatable

Path = Cell:new()

Path.constructible = false

--- Fonction permettant de créer une nouvelle case de chemin
--@param move sens dans lequel les ennemis vont évoluer sur cette case
function Path:new(move)
	local path = {}

	path.move = move

	setmetatable(path, {__index = self})

	return path
end

--- Fonction permettant d'afficher une case du chemin à l'écran
function Path:draw()
	design.pathDraw(self)
	--Path.batch:add(
		--(self.x - 1) * self.width,
		--(self.y - 1) * self.height,
		--0,
		--graphics.getWidth()/defs.width,
		--graphics.getHeight()/defs.height
	--)
end

return Path
