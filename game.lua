sti = require "libs.sti"
bump = require "libs.bump"
Camera = require "libs.hump.camera"
Timer = require "libs.hump.timer"
entity = require "entity"
fans = require "fans"
bguard = require "bodyguard"
pjuice	=	require "powerjuice"
h = require  "helpers"

camera = {}
world = {}
game = {
	score = 0,
  fans = 0,
}

local layer = {}

function game:init()
	camera = Camera(0,0,1)
	game.canvas = love.graphics.newCanvas(g_screenres.w,g_screenres.h)
	print("Game started")
	love.physics.setMeter(16)
	loadMap("map/dev.lua")
	love.mouse.setVisible(false)
	
end

function addScore(points)
	addpoints = points or 1
	game.score = game.score + addpoints
end



function spawn(entityType)
	print(("Spawn: %s"):format(entityType))
		mapWidth = map.width * 32
		mapHeight = map.height * 32
	if ( entityType == "fans" ) then
		fans.x = math.random(0,mapWidth)
		fans.y = math.random(0,mapHeight)
		local fansentity = {
			name = "No1 Fan",
			x = fans.x,
			y = fans.y,
			w = 16,
			h = 32,
			sprite		= 	love.graphics.newImage("images/fan1.png"),
			isFan = true,
			speed = math.random(40,90)
		  }
		  addScore(10)
		  entity.spawn(fansentity)
		  game.fans = game.fans + 1
	  elseif (entityType == "bodyGuard") then
		local bodyGuard = {
			name = "bodyGuard",
			x = 32,
			y = 32,
			w = 16,
			h = 32,
			isBodyguard = true,
			sprite = love.graphics.newImage("images/bodyguard.png")
		}
		entity.spawn(bodyGuard)
	  elseif (entityType == "powerJuice") then
		local xx = math.random(0,mapWidth)
		local yy = math.random(0,mapHeight)
		local powerJuice = {
			name	=	"RockBull",
			x		=	xx,
			y		=	yy,
			w		=	8,
			h		=	16,
			isPower	=	true,
			sprite	=	love.graphics.newImage("images/powerjuice.png")
		}
		entity.spawn(powerJuice)
	  end
end

function unSpawn()
	for k , v in ipairs(layer.sprites) do
		if (layer.sprites[k].unSpawn == true) then
			world:remove(layer.sprites[k])
			table.remove(layer.sprites,k)
			
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
			local sprite = love.graphics.newImage(object.properties.sprite)
			local player = object
			player.entity = {
				name 		= 	"Player",
				sprite		= 	sprite,
				x			= 	x or player.x,
				y			= 	y or player.y,
				w			= 	player.width,
				h			= 	player.height,
				speedBonus	=	0,
				isPlayer	=	true,
				isFan = false,		
				particle 	= love.graphics.newParticleSystem(sprite,32),
			
			}
			player.entity.particle:setParticleLifetime(1)
		
			player.entity.particle:setColors(255, 255, 255, 255, 255, 255, 255, 0) --fade
			entity.spawn(player.entity)
		--elseif object.name == "mapInfo" then
		end
	end
	--spawn()
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
	Timer.every(10, function() spawn("fans") end)
	Timer.every(1,function() addScore(1) end)
	Timer.every(15, function() spawn("powerJuice") end )
	spawn("bodyGuard")
	
end


function game:update(dt)
	local game = game
		for _, ent in pairs(layer.sprites) do
			entity.update(ent,dt)
		end
	map:update(dt)
	Timer.update(dt)
	unSpawn()
end
function game:draw()
	camera:attach()
	map:draw()
	for _, ent in pairs(layer.sprites) do
			entity.draw(ent)
		end
		--map:bump_draw(world)
	camera:detach()
	love.graphics.print(("score: %s fans: %s mapinfo: %s %s"):format(game.score,game.fans,map.height,map.width),0,0)
end

function game:keypressed(k)
	if ( k == "escape" ) then
		love.event.quit()
	end

end


