local v_u_1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("ContextActionService")
script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_3 = Enum.UserInputType.None
local v_u_4 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_5 = setmetatable({}, v_u_4)
v_u_5.__index = v_u_5
function v_u_5.new(p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_3
	local v7 = v_u_4.new()
	local v8 = v_u_5
	local v9 = setmetatable(v7, v8)
	v9.CONTROL_ACTION_PRIORITY = p6
	v9.forwardValue = 0
	v9.backwardValue = 0
	v9.leftValue = 0
	v9.rightValue = 0
	v9.activeGamepad = v_u_3
	v9.gamepadConnectedConn = nil
	v9.gamepadDisconnectedConn = nil
	return v9
end
function v_u_5.Enable(p10, p11)
	-- upvalues: (copy) v_u_3
	if p11 == p10.enabled then
		return true
	end
	p10.forwardValue = 0
	p10.backwardValue = 0
	p10.leftValue = 0
	p10.rightValue = 0
	p10.moveVector = Vector3.new(0, 0, 0)
	p10.isJumping = false
	if p11 then
		p10.activeGamepad = p10:GetHighestPriorityGamepad()
		if p10.activeGamepad == v_u_3 then
			return false
		end
		p10:BindContextActions()
		p10:ConnectGamepadConnectionListeners()
	else
		p10:UnbindContextActions()
		p10:DisconnectGamepadConnectionListeners()
		p10.activeGamepad = v_u_3
	end
	p10.enabled = p11
	return true
end
function v_u_5.GetHighestPriorityGamepad(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v12 = v_u_1:GetConnectedGamepads()
	local v13 = v_u_3
	for _, v14 in pairs(v12) do
		if v14.Value < v13.Value then
			v13 = v14
		end
	end
	return v13
end
function v_u_5.BindContextActions(p_u_15)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	if p_u_15.activeGamepad == v_u_3 then
		return false
	end
	v_u_2:BindActivate(p_u_15.activeGamepad, Enum.KeyCode.ButtonR2)
	v_u_2:BindActionAtPriority("jumpAction", function(_, p16, _)
		-- upvalues: (copy) p_u_15
		p_u_15.isJumping = p16 == Enum.UserInputState.Begin
		return Enum.ContextActionResult.Sink
	end, false, p_u_15.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA)
	v_u_2:BindActionAtPriority("moveThumbstick", function(_, p17, p18)
		-- upvalues: (copy) p_u_15
		if p17 == Enum.UserInputState.Cancel then
			p_u_15.moveVector = Vector3.new(0, 0, 0)
			return Enum.ContextActionResult.Sink
		end
		if p_u_15.activeGamepad ~= p18.UserInputType then
			return Enum.ContextActionResult.Pass
		end
		if p18.KeyCode == Enum.KeyCode.Thumbstick1 then
			if p18.Position.magnitude > 0.2 then
				local v19 = p_u_15
				local v20 = p18.Position.X
				local v21 = -p18.Position.Y
				v19.moveVector = Vector3.new(v20, 0, v21)
			else
				p_u_15.moveVector = Vector3.new(0, 0, 0)
			end
			return Enum.ContextActionResult.Sink
		end
	end, false, p_u_15.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1)
	return true
end
function v_u_5.UnbindContextActions(p22)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	if p22.activeGamepad ~= v_u_3 then
		v_u_2:UnbindActivate(p22.activeGamepad, Enum.KeyCode.ButtonR2)
	end
	v_u_2:UnbindAction("moveThumbstick")
	v_u_2:UnbindAction("jumpAction")
end
function v_u_5.OnNewGamepadConnected(p23)
	-- upvalues: (copy) v_u_3
	local v24 = p23:GetHighestPriorityGamepad()
	if v24 == p23.activeGamepad then
		return
	elseif v24 == v_u_3 then
		warn("Gamepad:OnNewGamepadConnected found no connected gamepads")
		p23:UnbindContextActions()
	else
		if p23.activeGamepad ~= v_u_3 then
			p23:UnbindContextActions()
		end
		p23.activeGamepad = v24
		p23:BindContextActions()
	end
end
function v_u_5.OnCurrentGamepadDisconnected(p25)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	if p25.activeGamepad ~= v_u_3 then
		v_u_2:UnbindActivate(p25.activeGamepad, Enum.KeyCode.ButtonR2)
	end
	local v26 = p25:GetHighestPriorityGamepad()
	if p25.activeGamepad == v_u_3 or v26 ~= p25.activeGamepad then
		if v26 == v_u_3 then
			p25:UnbindContextActions()
			p25.activeGamepad = v_u_3
		else
			p25.activeGamepad = v26
			v_u_2:BindActivate(p25.activeGamepad, Enum.KeyCode.ButtonR2)
		end
	else
		warn("Gamepad:OnCurrentGamepadDisconnected found the supposedly disconnected gamepad in connectedGamepads.")
		p25:UnbindContextActions()
		p25.activeGamepad = v_u_3
		return
	end
end
function v_u_5.ConnectGamepadConnectionListeners(p_u_27)
	-- upvalues: (copy) v_u_1
	p_u_27.gamepadConnectedConn = v_u_1.GamepadConnected:Connect(function(_)
		-- upvalues: (copy) p_u_27
		p_u_27:OnNewGamepadConnected()
	end)
	p_u_27.gamepadDisconnectedConn = v_u_1.GamepadDisconnected:Connect(function(p28)
		-- upvalues: (copy) p_u_27
		if p_u_27.activeGamepad == p28 then
			p_u_27:OnCurrentGamepadDisconnected()
		end
	end)
end
function v_u_5.DisconnectGamepadConnectionListeners(p29)
	if p29.gamepadConnectedConn then
		p29.gamepadConnectedConn:Disconnect()
		p29.gamepadConnectedConn = nil
	end
	if p29.gamepadDisconnectedConn then
		p29.gamepadDisconnectedConn:Disconnect()
		p29.gamepadDisconnectedConn = nil
	end
end
return v_u_5