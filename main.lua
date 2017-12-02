local sti = require "libs.sti"
local bump = require "libs.bump"


function love.load()
	windowWidth = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()
	
	love.physics.setMeter(16)
	map = sti("map/dev.lua",{"bump"})
	
	world = bump.newWorld()
	map:bump_init(world)
	
	
	
	
end

function love.draw()
	map:draw()
	love.graphics.print("LD40 - The more you have the worst it is",1,1)
end

function love.update(dt)
	map:update(dt)
end