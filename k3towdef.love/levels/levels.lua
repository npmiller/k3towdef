local l = {}

function const(x)
	return function() return x end
end

l.up    = const {x =  0, y = -1}
l.down  = const {x =  0, y =  1}
l.left  = const {x = -1, y =  0}
l.right = const {x =  1, y =  0}

l.stop = const "stop"

return l
