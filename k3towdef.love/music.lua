local defs = require 'design/defs'

local m = {}

local paused = false
local source = ''

function m.playMusic(mus)
	if mus ~= source then
		love.audio.stop()

		local music = love.audio.newSource("res/snd/" .. mus, 'stream')
		music:setLooping(true)
		love.audio.play(music)
		if paused then
			love.audio.pause()
		end

		source = mus
	end
end

function m.toggle()
	if paused then
		love.audio.resume()
	else
		love.audio.pause()
	end
	paused = not paused
end


local logo_mute = love.graphics.newImage('res/audio-muted.png')
local logo_high = love.graphics.newImage('res/audio-high.png')

local x, y, h, w
function m.button(cx, cw, cy, ch)
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	x, y = (cx - 0.5) * cw, (cy - 0.5) * ch
	local rw, rh = x, y

	local logo
	if paused then
		logo = logo_mute
	else
		logo = logo_high
	end

	love.graphics.setColor(255, 255, 255, 180)
	love.graphics.circle('fill', x, y, 18, 50)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(logo, x - 12, y - 12, 0, w / defs.width, h / defs.height)
end

function m.click(cx, cy)
	if (x + 12 - cx) ^ 2 + (y + 12 - cy) ^ 2  <= 324 then
		m.toggle()
		return true
	end
	return false
end

return m
