game:GetService("Players")
local v_u_1 = game:GetService("GuiService")
local v2 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_3 = require(v2:WaitForChild("ConnectionUtil"))
local v_u_4 = require(v2:WaitForChild("CharacterUtil"))
local v_u_5 = {
	["HUMANOID_STATE_ENABLED_CHANGED"] = "HUMANOID_STATE_ENABLED_CHANGED",
	["HUMANOID_JUMP_POWER"] = "HUMANOID_JUMP_POWER",
	["HUMANOID_JUMP_HEIGHT"] = "HUMANOID_JUMP_HEIGHT",
	["HUMANOID"] = "HUMANOID",
	["JUMP_INPUT_ENDED"] = "JUMP_INPUT_ENDED",
	["MENU_OPENED"] = "MENU_OPENED"
}
local v_u_6 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_7 = setmetatable({}, v_u_6)
v_u_7.__index = v_u_7
function v_u_7.new()
	-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_3
	local v8 = v_u_6.new()
	local v9 = v_u_7
	local v10 = setmetatable(v8, v9)
	v10.parentUIFrame = nil
	v10.jumpButton = nil
	v10.externallyEnabled = false
	v10.isJumping = false
	v10._active = false
	v10._connectionUtil = v_u_3.new()
	return v10
end
function v_u_7._reset(p11)
	p11.isJumping = false
	p11.touchObject = nil
	if p11.jumpButton then
		p11.jumpButton.ImageRectOffset = Vector2.new(1, 146)
	end
end
function v_u_7.EnableButton(p_u_12, p13)
	-- upvalues: (copy) v_u_5, (copy) v_u_1
	if p13 ~= p_u_12._active then
		if p13 then
			if not p_u_12.jumpButton then
				p_u_12:Create()
			end
			p_u_12.jumpButton.Visible = true
			p_u_12._connectionUtil:trackConnection(v_u_5.JUMP_INPUT_ENDED, p_u_12.jumpButton.InputEnded:Connect(function(p14)
				-- upvalues: (copy) p_u_12
				if p14 == p_u_12.touchObject then
					p_u_12:_reset()
				end
			end))
			p_u_12._connectionUtil:trackConnection(v_u_5.MENU_OPENED, v_u_1.MenuOpened:Connect(function()
				-- upvalues: (copy) p_u_12
				if p_u_12.touchObject then
					p_u_12:_reset()
				end
			end))
		else
			if p_u_12.jumpButton then
				p_u_12.jumpButton.Visible = false
			end
			p_u_12._connectionUtil:disconnect(v_u_5.JUMP_INPUT_ENDED)
			p_u_12._connectionUtil:disconnect(v_u_5.MENU_OPENED)
		end
		p_u_12:_reset()
		p_u_12._active = p13
	end
end
function v_u_7.UpdateEnabled(p15)
	-- upvalues: (copy) v_u_4
	local v16 = v_u_4.getChild("Humanoid", "Humanoid")
	if v16 and p15.externallyEnabled and (v16.UseJumpPower and v16.JumpPower > 0 or not v16.UseJumpPower and v16.JumpHeight > 0) and v16:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
		p15:EnableButton(true)
	else
		p15:EnableButton(false)
	end
end
function v_u_7._setupConfigurations(p_u_17)
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local function v_u_18()
		-- upvalues: (copy) p_u_17
		p_u_17:UpdateEnabled()
	end
	local v22 = v_u_4.onChild("Humanoid", "Humanoid", function(p19)
		-- upvalues: (copy) p_u_17, (ref) v_u_5, (copy) v_u_18
		p_u_17:UpdateEnabled()
		p_u_17:_reset()
		p_u_17._connectionUtil:trackConnection(v_u_5.HUMANOID_JUMP_POWER, p19:GetPropertyChangedSignal("JumpPower"):Connect(v_u_18))
		p_u_17._connectionUtil:trackConnection(v_u_5.HUMANOID_JUMP_HEIGHT, p19:GetPropertyChangedSignal("JumpHeight"):Connect(v_u_18))
		p_u_17._connectionUtil:trackConnection(v_u_5.HUMANOID_STATE_ENABLED_CHANGED, p19.StateEnabledChanged:Connect(function(p20, p21)
			-- upvalues: (ref) p_u_17
			if p20 == Enum.HumanoidStateType.Jumping and p21 ~= p_u_17._active then
				p_u_17:UpdateEnabled()
			end
		end))
	end)
	p_u_17._connectionUtil:trackConnection(v_u_5.HUMANOID, v22)
end
function v_u_7.Enable(p23, p24, p25)
	if p25 then
		p23.parentUIFrame = p25
	end
	if p23.externallyEnabled == p24 then
		return
	else
		p23.externallyEnabled = p24
		p23:UpdateEnabled()
		if p24 then
			p23:_setupConfigurations()
		else
			p23._connectionUtil:disconnectAll()
		end
	end
end
function v_u_7.Create(p_u_26)
	if p_u_26.parentUIFrame then
		if p_u_26.jumpButton then
			p_u_26.jumpButton:Destroy()
			p_u_26.jumpButton = nil
		end
		if p_u_26.absoluteSizeChangedConn then
			p_u_26.absoluteSizeChangedConn:Disconnect()
			p_u_26.absoluteSizeChangedConn = nil
		end
		p_u_26.jumpButton = Instance.new("ImageButton")
		p_u_26.jumpButton.Name = "JumpButton"
		p_u_26.jumpButton.Visible = false
		p_u_26.jumpButton.BackgroundTransparency = 1
		p_u_26.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
		p_u_26.jumpButton.ImageRectOffset = Vector2.new(1, 146)
		p_u_26.jumpButton.ImageRectSize = Vector2.new(144, 144)
		local function v31()
			-- upvalues: (copy) p_u_26
			local v27 = p_u_26.parentUIFrame.AbsoluteSize.x
			local v28 = p_u_26.parentUIFrame.AbsoluteSize.y
			local v29 = math.min(v27, v28) <= 500
			local v30 = v29 and 70 or 120
			p_u_26.jumpButton.Size = UDim2.new(0, v30, 0, v30)
			p_u_26.jumpButton.Position = v29 and UDim2.new(1, -(v30 * 1.5 - 10), 1, -v30 - 20) or UDim2.new(1, -(v30 * 1.5 - 10), 1, -v30 * 1.75)
		end
		v31()
		p_u_26.absoluteSizeChangedConn = p_u_26.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(v31)
		p_u_26.touchObject = nil
		p_u_26.jumpButton.InputBegan:connect(function(p32)
			-- upvalues: (copy) p_u_26
			if not p_u_26.touchObject and (p32.UserInputType == Enum.UserInputType.Touch and p32.UserInputState == Enum.UserInputState.Begin) then
				p_u_26.touchObject = p32
				p_u_26.jumpButton.ImageRectOffset = Vector2.new(146, 146)
				p_u_26.isJumping = true
			end
		end)
		p_u_26.jumpButton.Parent = p_u_26.parentUIFrame
	end
end
return v_u_7