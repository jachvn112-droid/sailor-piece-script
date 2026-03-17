local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.new()
	-- upvalues: (copy) v_u_1
	local v2 = v_u_1
	local v3 = setmetatable({}, v2)
	v3._connections = {}
	return v3
end
function v_u_1.trackConnection(p4, p5, p_u_6)
	if p4._connections[p5] then
		p4._connections[p5]()
	end
	p4._connections[p5] = function()
		-- upvalues: (copy) p_u_6
		p_u_6:Disconnect()
	end
end
function v_u_1.trackBoundFunction(p7, p8, p9)
	if p7._connections[p8] then
		p7._connections[p8]()
	end
	p7._connections[p8] = p9
end
function v_u_1.disconnect(p10, p11)
	if p10._connections[p11] then
		p10._connections[p11]()
		p10._connections[p11] = nil
	end
end
function v_u_1.disconnectAll(p12)
	for _, v13 in pairs(p12._connections) do
		v13()
	end
	p12._connections = {}
end
return v_u_1