function love.conf(t)
	t.title = "K3TowDef"
	t.author = "K3"

	local defs = require 'design/defs'

	t.window.fullscreen = defs.fullscreen

	if t.window.fullscreen then
		t.window.width = 0
		t.window.height = 0
	else
		t.window.width = defs.width
		t.window.height = defs.height
	end
end
