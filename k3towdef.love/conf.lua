function love.conf(t)
	t.title = "K3TowDef"
	t.author = "K3"

	local defs = require 'design/defs'

	t.screen.fullscreen = defs.fullscreen

	if t.screen.fullscreen then
		t.screen.width = 0
		t.screen.height = 0
	else
		t.screen.width = defs.width
		t.screen.height = defs.height
	end
end
