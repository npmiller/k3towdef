module 'levels/levels'

function const(x)
	return function() return x end
end

up    = const {x =  0, y = -1}
down  = const {x =  0, y =  1}
left  = const {x = -1, y =  0}
right = const {x =  1, y =  0}

stop = const "stop"
