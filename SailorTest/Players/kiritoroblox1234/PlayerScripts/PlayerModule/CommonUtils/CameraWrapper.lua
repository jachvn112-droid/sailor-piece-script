local v_u_1 = require(script.Parent.ConnectionUtil)
local v_u_2 = {}
v_u_2.__index = v_u_2
function v_u_2.new()
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v3 = {
		["_camera"] = game.Workspace.CurrentCamera,
		["_callbacks"] = {},
		["_connectionUtil"] = v_u_1.new(),
		["_enabled"] = false
	}
	local v4 = v_u_2
	return setmetatable(v3, v4)
end
function v_u_2._connectCallbacks(p5)
	p5._camera = game.Workspace.CurrentCamera
	if p5._camera then
		for v6, v7 in p5._callbacks do
			p5._connectionUtil:trackConnection(v6, p5._camera:GetPropertyChangedSignal(v6):Connect(v7))
			v7()
		end
	end
end
function v_u_2.Enable(p_u_8)
	if not p_u_8._enabled then
		p_u_8._enabled = true
		p_u_8._cameraChangedConnection = game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			-- upvalues: (copy) p_u_8
			p_u_8:_connectCallbacks()
		end)
		p_u_8:_connectCallbacks()
	end
end
function v_u_2.Disable(p9)
	if p9._enabled then
		p9._enabled = false
		if p9._cameraChangedConnection then
			p9._cameraChangedConnection:Disconnect()
			p9._cameraChangedConnection = nil
		end
		p9._connectionUtil:disconnectAll()
	end
end
function v_u_2.Connect(p10, p11, p12)
	p10._callbacks[p11] = p12
	if p10._camera then
		p10._connectionUtil:trackConnection(p11, p10._camera:GetPropertyChangedSignal(p11):Connect(p12))
	end
end
function v_u_2.Disconnect(p13, p14)
	p13._connectionUtil:disconnect(p14)
	p13._callbacks[p14] = nil
end
function v_u_2.getCamera(p15)
	return p15._camera
end
return v_u_2