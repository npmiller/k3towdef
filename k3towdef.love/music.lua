local audio = love.audio

module 'music'

local paused = false

function playMusic(mus)
	audio.stop()

	local music = audio.newSource("res/snd/" .. mus, 'stream')
	music:setLooping(true)
	audio.play(music)
	if paused then
		audio.pause()
	end
end

function toggle()
	if paused then
		audio.resume()
	else
		audio.pause()
	end
	paused = not paused
end
