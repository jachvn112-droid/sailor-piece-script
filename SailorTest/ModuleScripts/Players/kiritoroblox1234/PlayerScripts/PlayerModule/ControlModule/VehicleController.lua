local v_u_1 = game:GetService("ContextActionService")
local v_u_2 = {}
v_u_2.__index = v_u_2
function v_u_2.new(p3)
	-- upvalues: (copy) v_u_2
	local v4 = v_u_2
	local v5 = setmetatable({}, v4)
	v5.CONTROL_ACTION_PRIORITY = p3
	v5.enabled = false
	v5.vehicleSeat = nil
	v5.throttle = 0
	v5.steer = 0
	v5.acceleration = 0
	v5.decceleration = 0
	v5.turningRight = 0
	v5.turningLeft = 0
	v5.vehicleMoveVector = Vector3.new(0, 0, 0)
	v5.autoPilot = {}
	v5.autoPilot.MaxSpeed = 0
	v5.autoPilot.MaxSteeringAngle = 0
	return v5
end
function v_u_2.BindContextActions(p_u_6)
	-- upvalues: (copy) v_u_1
	v_u_1:BindActionAtPriority("throttleAccel", function(p7, p8, p9)
		-- upvalues: (copy) p_u_6
		p_u_6:OnThrottleAccel(p7, p8, p9)
		return Enum.ContextActionResult.Pass
	end, false, p_u_6.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonR2)
	v_u_1:BindActionAtPriority("throttleDeccel", function(p10, p11, p12)
		-- upvalues: (copy) p_u_6
		p_u_6:OnThrottleDeccel(p10, p11, p12)
		return Enum.ContextActionResult.Pass
	end, false, p_u_6.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonL2)
	v_u_1:BindActionAtPriority("arrowSteerRight", function(p13, p14, p15)
		-- upvalues: (copy) p_u_6
		p_u_6:OnSteerRight(p13, p14, p15)
		return Enum.ContextActionResult.Pass
	end, false, p_u_6.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Right)
	v_u_1:BindActionAtPriority("arrowSteerLeft", function(p16, p17, p18)
		-- upvalues: (copy) p_u_6
		p_u_6:OnSteerLeft(p16, p17, p18)
		return Enum.ContextActionResult.Pass
	end, false, p_u_6.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Left)
end
function v_u_2.Enable(p19, p20, p21)
	-- upvalues: (copy) v_u_1
	if p20 ~= p19.enabled or p21 ~= p19.vehicleSeat then
		p19.enabled = p20
		p19.vehicleMoveVector = Vector3.new(0, 0, 0)
		if p20 then
			if p21 then
				p19.vehicleSeat = p21
				p19:SetupAutoPilot()
				p19:BindContextActions()
				return
			end
		else
			v_u_1:UnbindAction("throttleAccel")
			v_u_1:UnbindAction("throttleDeccel")
			v_u_1:UnbindAction("arrowSteerRight")
			v_u_1:UnbindAction("arrowSteerLeft")
			p19.vehicleSeat = nil
		end
	end
end
function v_u_2.OnThrottleAccel(p22, _, p23, _)
	if p23 == Enum.UserInputState.End or p23 == Enum.UserInputState.Cancel then
		p22.acceleration = 0
	else
		p22.acceleration = -1
	end
	p22.throttle = p22.acceleration + p22.decceleration
end
function v_u_2.OnThrottleDeccel(p24, _, p25, _)
	if p25 == Enum.UserInputState.End or p25 == Enum.UserInputState.Cancel then
		p24.decceleration = 0
	else
		p24.decceleration = 1
	end
	p24.throttle = p24.acceleration + p24.decceleration
end
function v_u_2.OnSteerRight(p26, _, p27, _)
	if p27 == Enum.UserInputState.End or p27 == Enum.UserInputState.Cancel then
		p26.turningRight = 0
	else
		p26.turningRight = 1
	end
	p26.steer = p26.turningRight + p26.turningLeft
end
function v_u_2.OnSteerLeft(p28, _, p29, _)
	if p29 == Enum.UserInputState.End or p29 == Enum.UserInputState.Cancel then
		p28.turningLeft = 0
	else
		p28.turningLeft = -1
	end
	p28.steer = p28.turningRight + p28.turningLeft
end
function v_u_2.Update(p30, p31, p32, _)
	if not p30.vehicleSeat then
		return p31, false
	end
	if not p32 then
		local v33 = p30.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(p31)
		p30.vehicleSeat.ThrottleFloat = p30:ComputeThrottle(v33)
		p30.vehicleSeat.SteerFloat = p30:ComputeSteer(v33)
		return Vector3.new(0, 0, 0), true
	end
	local v34 = p30.steer
	local v35 = p30.throttle
	local v36 = p31 + Vector3.new(v34, 0, v35)
	p30.vehicleSeat.ThrottleFloat = -v36.Z
	p30.vehicleSeat.SteerFloat = v36.X
	return v36, true
end
function v_u_2.ComputeThrottle(_, p37)
	return p37 == Vector3.new(0, 0, 0) and 0 or -p37.Z
end
function v_u_2.ComputeSteer(p38, p39)
	if p39 == Vector3.new(0, 0, 0) then
		return 0
	end
	local v40 = -p39.x
	local v41 = -p39.z
	return -math.atan2(v40, v41) * 57.29577951308232 / p38.autoPilot.MaxSteeringAngle
end
function v_u_2.SetupAutoPilot(p42)
	p42.autoPilot.MaxSpeed = p42.vehicleSeat.MaxSpeed
	p42.autoPilot.MaxSteeringAngle = 35
end
return v_u_2