gameover = {}

function gameover:init()
gameover.canvas = love.graphics.newCanvas(g_screenres.w,g_screenres.h)
	print("gameover")	
end

function gameover:update(dt)

end

function gameover:draw()
	love.graphics.setCanvas(gameover.canvas)
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.clear()
	love.graphics.setColor(255,255,255)
	love.graphics.print("GAME OVER",20,20)
	love.graphics.print(("SCORE: %s  Fans: %s Trophy: %s"):format(game.score,game.fans,game.trophy),40,40)
	love.graphics.setCanvas()
	love.graphics.clear()
	
	local h = love.graphics.getHeight()
	local w = love.graphics.getWidth()
	
	local s_w = g_screenres.w
	local s_h = g_screenres.h
	
	local quad = love.graphics.newQuad(0,0,s_w,s_h,s_w,s_h)
	
	local x = math.floor((w-s_w)*0.5)
	local y = math.floor((h-s_h)*0.5)
	
	love.graphics.draw(gameover.canvas,quad,x,y)
	
end


function gameover:keyreleased(key,code)
	print(key)
	gamestate.switch(game)
end
