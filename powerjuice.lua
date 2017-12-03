local powerjuice = {
x	=	0,
y	=	0}

function powerjuice.update(self,dt) 
	world:update(self,self.x,self.y)
end

function powerjuice.draw(self)
	--camera:lookAt(math.floor(self.x),math.floor(self.y))
	love.graphics.draw(self.sprite,math.floor(self.x),math.floor(self.y))
end

return powerjuice
