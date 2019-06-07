-- actor base class

cactor={}

cactor.__index=cactor

function cactor:update()
end

function cactor:draw()
	spr(self.sprite, self.x, self.y)
end

function cactor:new(x,y,sprite)
	local a={}
	a.class = "actor"
	setmetatable(a, self)
	a.x=x
	a.y=y
	a.sprite=sprite
	return a
end

function inherits_from(baseclass)
	local new_class={}
	new_class.__index=baseclass

--	function new_class:new()
--		local newinst={}
--		setmetatable(newinst, new_class)
--		return newinst
--	end

--	setmetatable(new_class, {__index = baseclass})
	return new_class
end
