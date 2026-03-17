local v_u_1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("ContextActionService")
script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_3 = Vector3.new()
local v_u_4 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_5 = setmetatable({}, v_u_4)
v_u_5.__index = v_u_5
function v_u_5.new(p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v7 = v_u_4.new()
	local v8 = v_u_5
	local v9 = setmetatable(v7, v8)
	v9.CONTROL_ACTION_PRIORITY = p6
	v9.forwardValue = 0
	v9.backwardValue = 0
	v9.leftValue = 0
	v9.rightValue = 0
	v9.jumpEnabled = true
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
	p10.moveVector = v_u_3
	p10.jumpRequested = false
	p10:UpdateJump()
	if p11 then
		p10:BindContextActions()
		p10:ConnectFocusEventListeners()
	else
		p10._connectionUtil:disconnectAll()
	end
	p10.enabled = p11
	return true
end
function v_u_5.UpdateMovement(p12, p13)
	-- upvalues: (copy) v_u_3
	if p13 == Enum.UserInputState.Cancel then
		p12.moveVector = v_u_3
	else
		local v14 = p12.leftValue + p12.rightValue
		local v15 = p12.forwardValue + p12.backwardValue
		p12.moveVector = Vector3.new(v14, 0, v15)
	end
end
function v_u_5.UpdateJump(p16)
	p16.isJumping = p16.jumpRequested
end
function v_u_5.BindContextActions(p_u_17)
	-- upvalues: (copy) v_u_2
	v_u_2:BindActionAtPriority("moveForwardAction", function(_, p18, _)
		-- upvalues: (copy) p_u_17
		p_u_17.forwardValue = p18 == Enum.UserInputState.Begin and -1 or 0
		p_u_17:UpdateMovement(p18)
		return Enum.ContextActionResult.Pass
	end, false, p_u_17.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterForward)
	v_u_2:BindActionAtPriority("moveBackwardAction", function(_, p19, _)
		-- upvalues: (copy) p_u_17
		p_u_17.backwardValue = p19 == Enum.UserInputState.Begin and 1 or 0
		p_u_17:UpdateMovement(p19)
		return Enum.ContextActionResult.Pass
	end, false, p_u_17.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterBackward)
	v_u_2:BindActionAtPriority("moveLeftAction", function(_, p20, _)
		-- upvalues: (copy) p_u_17
		p_u_17.leftValue = p20 == Enum.UserInputState.Begin and -1 or 0
		p_u_17:UpdateMovement(p20)
		return Enum.ContextActionResult.Pass
	end, false, p_u_17.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterLeft)
	v_u_2:BindActionAtPriority("moveRightAction", function(_, p21, _)
		-- upvalues: (copy) p_u_17
		p_u_17.rightValue = p21 == Enum.UserInputState.Begin and 1 or 0
		p_u_17:UpdateMovement(p21)
		return Enum.ContextActionResult.Pass
	end, false, p_u_17.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterRight)
	v_u_2:BindActionAtPriority("jumpAction", function(_, p22, _)
		-- upvalues: (copy) p_u_17
		local v23 = p_u_17
		local v24 = p_u_17.jumpEnabled
		if v24 then
			v24 = p22 == Enum.UserInputState.Begin
		end
		v23.jumpRequested = v24
		p_u_17:UpdateJump()
		return Enum.ContextActionResult.Pass
	end, false, p_u_17.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterJump)
	p_u_17._connectionUtil:trackBoundFunction("moveForwardAction", function()
		-- upvalues: (ref) v_u_2
		v_u_2:UnbindAction("moveForwardAction")
	end)
	p_u_17._connectionUtil:trackBoundFunction("moveBackwardAction", function()
		-- upvalues: (ref) v_u_2
		v_u_2:UnbindAction("moveBackwardAction")
	end)
	p_u_17._connectionUtil:trackBoundFunction("moveLeftAction", function()
		-- upvalues: (ref) v_u_2
		v_u_2:UnbindAction("moveLeftAction")
	end)
	p_u_17._connectionUtil:trackBoundFunction("moveRightAction", function()
		-- upvalues: (ref) v_u_2
		v_u_2:UnbindAction("moveRightAction")
	end)
	p_u_17._connectionUtil:trackBoundFunction("jumpAction", function()
		-- upvalues: (ref) v_u_2
		v_u_2:UnbindAction("jumpAction")
	end)
end
function v_u_5.ConnectFocusEventListeners(p_u_25)
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	local function v26()
		-- upvalues: (copy) p_u_25, (ref) v_u_3
		p_u_25.moveVector = v_u_3
		p_u_25.forwardValue = 0
		p_u_25.backwardValue = 0
		p_u_25.leftValue = 0
		p_u_25.rightValue = 0
		p_u_25.jumpRequested = false
		p_u_25:UpdateJump()
	end
	p_u_25._connectionUtil:trackConnection("textBoxFocusReleased", v_u_1.TextBoxFocusReleased:Connect(v26))
	p_u_25._connectionUtil:trackConnection("textBoxFocused", v_u_1.TextBoxFocused:Connect(function(_)
		-- upvalues: (copy) p_u_25
		p_u_25.jumpRequested = false
		p_u_25:UpdateJump()
	end))
	p_u_25._connectionUtil:trackConnection("windowFocusReleased", v_u_1.WindowFocused:Connect(v26))
end
return v_u_5