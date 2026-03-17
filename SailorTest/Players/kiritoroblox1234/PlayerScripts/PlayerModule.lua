local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.new()
	-- upvalues: (copy) v_u_1
	local v2 = v_u_1
	local v3 = setmetatable({}, v2)
	v3.cameras = require(script:WaitForChild("CameraModule"))
	v3.controls = require(script:WaitForChild("ControlModule"))
	return v3
end
function v_u_1.GetCameras(p4)
	return p4.cameras
end
function v_u_1.GetControls(p5)
	return p5.controls
end
function v_u_1.GetClickToMoveController(p6)
	return p6.controls:GetClickToMoveController()
end
return v_u_1.new()