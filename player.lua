local player = {
	x = 0,
	y = 0
}

function player.update(self,dt)
local speed = 100

local dx , dy	= 0 ,0
local cols
self.isPlayer	= true

	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		dx = -speed * dt
	
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
	
	world:update(self,aX,aY)
	
	self.x , self.y = aX, aY
	print(("x %s y: %s dx %s dy %s"):format(self.x,self.y,dx,dy))

end

function player.draw(self)
	love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
	camera:lookAt(math.floor(self.x),math.floor(self.y))
end

return player