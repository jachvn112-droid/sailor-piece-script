local v1 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_2 = require(v1:WaitForChild("ConnectionUtil"))
local v_u_3 = Vector3.new()
local v_u_4 = {}
v_u_4.__index = v_u_4
function v_u_4.new()
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_4
	local v6 = setmetatable({}, v5)
	v6.enabled = false
	v6.moveVector = v_u_3
	v6.moveVectorIsCameraRelative = true
	v6.isJumping = false
	v6._connectionUtil = v_u_2.new()
	return v6
end
function v_u_4.GetMoveVector(p7)
	return p7.moveVector
end
function v_u_4.IsMoveVectorCameraRelative(p8)
	return p8.moveVectorIsCameraRelative
end
function v_u_4.GetIsJumping(p9)
	return p9.isJumping
end
function v_u_4.Enable(_, _)
	error("BaseCharacterController:Enable must be overridden in derived classes and should not be called.")
	return false
end
return v_u_4