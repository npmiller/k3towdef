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

return m
