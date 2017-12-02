gamestate 	=	require "libs.hump.gamestate"

require "game"
require "menu"

g_screenres = {
	w=math.floor(love.graphics.getWidth()),
	h=math.floor(love.graphics.getHeight())
}

function love.load()
	love.window.setTitle("LD40 - the more you have the worst it is")
	gamestate.registerEvents()
	gamestate.switch(menu)

end
