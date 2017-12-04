local sounds = {
	pickup 	= 	love.audio.newSource("sounds/pickup.wav", "static")	,
	flash	=	love.audio.newSource("sounds/blip.wav", "static")	,
	powerup	=	love.audio.newSource("sounds/powerup.wav", "static"),
	bgm		= 	love.audio.newSource("sounds/fansongs.wav", "stream"),
	bgmbool = false
}
sounds.bgm:setLooping(true)
function sounds.play(sound) 
	if (sound == bgm) then
		if (bgfmbool == false) then
		else
			love.audio.play(sound)
		end
	else
		love.audio.play(sound)
	end
end

function sounds.volume(control)
	local vol = love.audio.getVolume() 
	if (control == "+") then
		vol = vol + 0.1
	else 
		vol = vol - 0.1
	end
	print(("volume: %s"):format(vol))
	love.audio.setVolume(vol)
end

function sounds.stop()
	love.audio.stop()
end

return sounds