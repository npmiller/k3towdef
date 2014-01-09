local audio = love.audio

--- Module qui gère la musique dans le jeu
module 'music'

--- Fonction qui démarre une musique
--@param mus la musique à démarrer
function playMusic(mus)
	audio.stop()

	local music = audio.newSource("res/snd/" .. mus, 'stream')
	music:setLooping(true)
	audio.play(music)
end
