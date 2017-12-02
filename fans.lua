local fans = {
    name = "No1 Fan",
    x = 0,
    y = 0,
    w = 10,
    h = 10,
    isFan = true
  }

function fans.update(self,dt,targetX,targetY)
  local targetx = targetX or 0
  local targety = targetY or 0
  local speed = 50 
  local dx , dy = 0 , 0
  if ( self.x > targetx ) then
    dx = -speed * dt
  end
  if ( self.y > targety ) then
     dy = -speed * dt
    end
  if ( self.x < targetx ) then
    dx = speed * dt
  end
  if ( self.y < targety ) then
     dy = speed * dt
  end
  local goalX, goalY = self.x + dx , self.y + dy
	local aX, aY, acols, alen = world:check(self,goalX,goalY)
	
	world:update(self,aX,aY)
	
	self.x , self.y = aX, aY
end

function fans.draw(self)
  love.graphics.rectangle("fill",self.x,self.y,10,10)
end

return fans