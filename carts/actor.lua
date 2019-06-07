actorlist = {}

-- actor base class

cactor={}

cactor.__index=cactor

function cactor:update()
	print("update " .. self.class)
end

function cactor:draw()
	spr(self.sprite, self.x, self.y)
end

function cactor:new(x,y,sprite)
	local a={}
	a.class = "cactor"
	setmetatable(a, self)
	a.x=x
	a.y=y
	a.sprite=sprite
	add(actorlist,a)
	return a
end

function cactor:delete()
	del(actorlist,self)
	return nil
end

function inherits_from(baseclass)
	local new_class={}
	new_class.__index=baseclass
	setmetatable(new_class, new_class)
	return new_class
end
