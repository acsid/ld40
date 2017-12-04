local collectable = {
x	=	0,
y	=	0}

function collectable.update(self,dt) 
	
	world:update(self,self.x,self.y)
end

function collectable.draw(self)
	--camera:lookAt(math.floor(self.x),math.floor(self.y))
	love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
end

return collectable
