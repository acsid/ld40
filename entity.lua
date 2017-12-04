player	=	require("player")


local entity = {}
local objects = {}
local entityId = 0

function entity.spawn(object)
	print(("spawn: %s"):format(object.name))
	entityId = entityId + 1
	object.entityId = entityId
	world:add(object,object.x,object.y,object.w,object.h)
	table.insert(objects,object)
end

function entity.getObjects()
	return objects
end

function entity.clear()
	objects = {}
end



function entity.update(self,dt)
	if (self.isPlayer == true) then
		player.update(self,dt)
		targetX = player.getX(self)
		targetY = player.getY(self)
	elseif (self.isFan == true) then
		fans.update(self,dt,targetX,targetY)
	elseif (self.isBodyguard == true) then
		bguard.update(self,dt,targetX,targetY)
	elseif (self.isCollectable == true) then
		collectable.update(self,dt)
	end
end

function entity.draw(self)
	if(self.isPlayer == true) then
		player.draw(self)
	elseif (self.isFan == true) then
		fans.draw(self)
	elseif (self.isBodyguard == true) then
		bguard.draw(self)
	elseif (self.isCollectable == true) then
		collectable.draw(self)
  end
end



return entity

