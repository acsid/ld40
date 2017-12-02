sti = require "libs.sti"
bump = require "libs.bump"
Camera = require "libs.hump.camera"
entity = require "entity"

camera = {}
game = {
	score = 0
}

local layer = {}

function game:init()
	camera = Camera(0,0,1)
	game.canvas = love.graphics.newCanvas(g_screenres.w,g_screenres.h)
	print("Game started")
	love.physics.setMeter(16)
	loadMap("map/dev.lua")
end

function spawn(objects)
local obj = objects or map.objects
	for _, object in ipairs(obj) do
	if (object.name == "Player") then
		print("atcha")
	else
	end
end
end

function loadMap(mapFile,x,y)
	print("Load Map")
	print(mapFile)
	entity.clear()
	world = bump.newWorld()
	
	map = sti(mapFile, {"bump"})
	
	map:bump_init(world)
	map:addCustomLayer("Sprites",4)
	layer = map.layers["Sprites"]
	
	for k, object in pairs(map.objects) do
		print(object.name)
		if object.name == "Player" then
			--local sprite = love.graphics.newImage("images/playerholder.png")
			local player = object
			player.entity = {
				name 		= 	"Player",
				sprite		= 	love.graphics.newImage(object.properties.sprite),
				x			= 	x or player.x,
				y			= 	y or player.y,
				w			= 	player.width,
				h			= 	player.height,
				isPlayer	=	true,
			}
			entity.spawn(player.entity)
		--elseif object.name == "mapInfo" then
		end
	end
	spawn()
	layer.sprites = entity.getObjects()
	--update sprite layer
	function layer:update(dt)
		for _, ent in pairs(layer.sprites) do
			entity.update(ent,dt)
		end
	end
	--draw sprite layer
	layer.draw = function(self)
		for _, ent in ipairs(self) do
			entity.draw(ent)
		end
	end
	
	
end


function game:update(dt)
	local game = game
	print("update?")
		for _, ent in pairs(layer.sprites) do
			entity.update(ent,dt)
		end
	map:update(dt)
end
function game:draw()
	camera:attach()
	map:draw()
	for _, ent in pairs(layer.sprites) do
			entity.draw(ent)
		end
	camera:detach()
	love.graphics.print(("score: %s"):format(game.score),0,0)
end


