local fans = {
    name = "No1 Fan",
    x = 0,
    y = 0,
    w = 10,
    h = 10,
    isFan = true
  }

	function fans.init(self)
	
	end 
  
function fans.update(self,dt,targetX,targetY)
	if (self.attack == nil) then
		self.attack = false
		self.flash = false
		Timer.after(5, function() self.attack = true end)
	end
--print(("target %s %s"):format(targetX,targetY))
  local targetx = targetX or 0
  local targety = targetY or 0

  local dx , dy = 0 , 0
  if ( h.distance(self.x,self.y,targetx,targety) < 250 ) then
	  if ( self.x > targetx ) then
		dx = -self.speed * dt
	  end
	  if ( self.y > targety ) then
		 dy = -self.speed * dt
		end
	  if ( self.x < targetx ) then
		dx = self.speed * dt
	  end
	  if ( self.y < targety ) then
		 dy = self.speed * dt
	  end
	
	else 
	
	end
  local goalX, goalY = self.x + dx , self.y + dy
	local aX, aY, acols, alen = world:check(self,goalX,goalY)
	
	world:update(self,aX,aY)
	
	self.x , self.y = aX, aY
	self.flash = false
	if (self.attack == true) then
	--print(h.distance(self.x,self.y,targetx,targety))
		if (h.distance(self.x,self.y,targetx,targety) < 96) then
			Timer.during(0.5,function() self.flash = true end)
			spawn()
		end
		self.attack = false
		Timer.after(math.random(5,20), function() self.attack = true end)
	end
end

function fans.draw(self)
	love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
	if (self.flash == true) then
		love.graphics.rectangle("fill",self.x,self.y,8,8)
	end
end

return fans