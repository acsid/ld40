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
	print(self.name)
	if (self.isPlayer == true) then
		player.update(self,dt)
	end
end

function entity.draw(self)
	if(self.isPlayer == true) then
		player.draw(self)
	end
end

return entity

