local player = {
	x = 0,
	y = 0,
	speed = 100
}



function player.speedBoost()
	
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
			if (col.other.isPower == true) then
				print("Speed Bonus")
				col.other.unSpawn = true
				self.speedBonus = self.speedBonus + 25
				self.speedAnim = { x = self.x - dx * 2 , y = self.y - dy * 2} 
				Timer.after(5, function()
					self.speedBonus = self.speedBonus - 25 
					print("Speed Bonus End")
				end)
			end
	end
	if (self.speedBonus > 0) then
		self.particle:emit(32)
	end
	
	world:update(self,aX,aY)
	
	self.x , self.y = aX, aY
	self.particle:update(dt)
	--print(("x %s y: %s dx %s dy %s"):format(self.x,self.y,dx,dy))

end

function player.draw(self)
	camera:lookAt(math.floor(self.x),math.floor(self.y))
	love.graphics.draw(self.particle,self.x,self.y)
	love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
	
end

function player.getX(self)
  return self.x
end

function player.getY(self)
  return self.y
end

return player