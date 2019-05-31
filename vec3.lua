-- 3 element vector

vec3={}

function vec3.add(a, b)
	return vec3.new(a.x+b.x, a.y+b.y, a.z+b.z)
end

function vec3_tostring( a )
	return ("{" .. a.x .. "," .. a.y .. "," .. a.z .. "}")
end

vec3.mt = {
	__index = vec3,
	__add = vec3.add
}

function vec3.new(x,y,z)
	local vec = {}
	vec.class = "vec3"
	setmetatable(vec, vec3.mt)

	-- set values based on params
	if x ~= nil then
		if type(x) == "table" then
			if getmetatable(x) == vec3.mt then
				vec.x = x.x
				vec.y = x.y
				vec.z = x.z
			else
				vec.x = x[1]
				vec.y = x[2]
				vec.z = x[3]
			end
		else
			vec.x = x
			vec.y = y
			vec.z = z
		end
	else
		vec.x = 0
		vec.y = 0
		vec.z = 0
	end

	return vec
end

