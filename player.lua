local player = {
	x = 0,
	y = 0,
	speed = 100
}



function player.speedBoost()
	
end

function player.checkStuck(self)
	local items, len = world:queryRect(self.x-1,self.y-1,18,34)
	--print(len)
	if ( len > 5 ) then
		gamestate.switch(gameover)
	end
end

function player.update(self,dt)
local speed = player.speed + self.speedBonus

local dx , dy	= 0 ,0
local cols
self.isPlayer	= true

	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		dx = -speed  * dt
	
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		dx = speed * dt
	
	end
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		dy = -speed * dt
	end
	if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		dy = speed * dt
	end
	
	
	local goalX, goalY = self.x + dx , self.y + dy
	local aX, aY, acols, alen = world:check(self,goalX,goalY)
	
	for i = 1 , alen do
		local col = acols[i]
		
		if (col.other.unSpawn == nil) then
			if (col.other.isCollectable == true) then
				col.other.unSpawn = true
				sounds.play(sounds.pickup)
			end
			if (col.other.isPower == true) then
				print("Speed Bonus")
				
				self.speedBonus = self.speedBonus + 25
				self.speedAnim = { x = self.x - dx * 2 , y = self.y - dy * 2} 
				Timer.after(5, function()
					self.speedBonus = self.speedBonus - 25 
					print("Speed Bonus End")
				end)
				elseif (col.other.isTrophy == true) then
				game.trophy = game.trophy + 1
				game.score = game.score + 100
				spawn("fans")
				spawn("trophy")
				if (game.trophy == 5) then
					spawn("bodyGuard")
				end
				
			end
			
		end
	end
	if (self.speedBonus > 0) then
		self.particle:emit(32)
	end
	
	
	
	v = vector.new(self.x,self.y) 
	angle = v:angleTo(vector.new(aX,aY))
	
	self.particle:setSpeed(10,100)
	self.particle:setDirection(angle)
	--print(("a: %s aX: %s aY: %s sX: %s sY: %s"):format(angle,aX,aY,self.x,self.y))
	
	
	world:update(self,aX,aY)
	self.x , self.y = aX, aY
	
	
	self.particle:update(dt)
	player.checkStuck(self)

end

function player.draw(self)
	camera:lookAt(math.floor(self.x),math.floor(self.y))
	love.graphics.draw(self.particle,self.x+8,self.y+16)
	love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
	
end

function player.getX(self)
  return self.x
end

function player.getY(self)
  return self.y
end



return player