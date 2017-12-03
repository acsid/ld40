local bodyguard = {}

function bodyguard.update(self,dt,targetx,targety)
	 local mx, my = love.mouse.getX()+targetx - (love.graphics.getWidth()/2) , love.mouse.getY()+targety-(love.graphics.getHeight()/2)
	 local goalX, goalY = mx,my 
	local aX, aY, acols, alen = world:check(self,goalX,goalY)
	

	
	self.x , self.y = aX, aY
	if (self.x < 0) then
		self.x = 32
	end
	if (self.y < 0) then
		self.y = 32
	end	
	world:update(self,self.x,self.y)
end

function bodyguard.draw(self)
		love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
end
return bodyguard