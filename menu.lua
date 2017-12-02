menu = {}

function menu:init()
menu.canvas = love.graphics.newCanvas(g_screenres.w,g_screenres.h)
	print("menu")
	
end

function menu:update(dt)

end

function menu:draw()
	love.graphics.setCanvas(menu.canvas)
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.clear()
	love.graphics.setColor(255,255,255)
	love.graphics.print("press any key to start",20,20)
	love.graphics.setCanvas()
	love.graphics.clear()
	
	local h = love.graphics.getHeight()
	local w = love.graphics.getWidth()
	
	local s_w = g_screenres.w
	local s_h = g_screenres.h
	
	local quad = love.graphics.newQuad(0,0,s_w,s_h,s_w,s_h)
	
	local x = math.floor((w-s_w)*0.5)
	local y = math.floor((h-s_h)*0.5)
	
	love.graphics.draw(menu.canvas,quad,x,y)
	
end


function menu:keyreleased(key,code)
	print(key)
	gamestate.switch(game)

end
