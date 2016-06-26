local audio = love.audio

local m = {}

local paused = false
local source = ''

function m.playMusic(mus)
	if mus ~= source then
		audio.stop()

		local music = audio.newSource("res/snd/" .. mus, 'stream')
		music:setLooping(true)
		audio.play(music)
		if paused then
			audio.pause()
		end

		source = mus
	end
end

function m.toggle()
	if paused then
		audio.resume()
	else
		audio.pause()
	end
	paused = not paused
end

return m
