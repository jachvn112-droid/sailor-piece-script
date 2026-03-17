local v1 = script.Parent.Parent:WaitForChild("CommonUtils")
local v2 = require(v1:WaitForChild("FlagUtil"))
local v_u_3 = Enum.ContextActionPriority.Medium.Value
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("ContextActionService")
local v_u_6 = game:GetService("UserInputService")
local v_u_7 = UserSettings().GameSettings
local v_u_8 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_9 = v2.getUserFlag("UserFixStuckShiftLock")
local v_u_10 = {}
v_u_10.__index = v_u_10
function v_u_10.new()
	-- upvalues: (copy) v_u_10, (copy) v_u_7, (copy) v_u_4, (copy) v_u_6
	local v11 = v_u_10
	local v_u_12 = setmetatable({}, v11)
	v_u_12.isMouseLocked = false
	v_u_12.savedMouseCursor = nil
	v_u_12.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift }
	v_u_12.mouseLockToggledEvent = Instance.new("BindableEvent")
	local v13 = script:FindFirstChild("BoundKeys")
	if not (v13 and v13:IsA("StringValue")) then
		if v13 then
			v13:Destroy()
		end
		v13 = Instance.new("StringValue")
		assert(v13, "")
		v13.Name = "BoundKeys"
		v13.Value = "LeftShift,RightShift"
		v13.Parent = script
	end
	if v13 then
		v13.Changed:Connect(function(p14)
			-- upvalues: (copy) v_u_12
			v_u_12:OnBoundKeysObjectChanged(p14)
		end)
		v_u_12:OnBoundKeysObjectChanged(v13.Value)
	end
	v_u_7.Changed:Connect(function(p15)
		-- upvalues: (copy) v_u_12
		if p15 == "ControlMode" or p15 == "ComputerMovementMode" then
			v_u_12:UpdateMouseLockAvailability()
		end
	end)
	v_u_4.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function()
		-- upvalues: (copy) v_u_12
		v_u_12:UpdateMouseLockAvailability()
	end)
	v_u_4.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
		-- upvalues: (copy) v_u_12
		v_u_12:UpdateMouseLockAvailability()
	end)
	v_u_6:GetPropertyChangedSignal("PreferredInput"):Connect(function()
		-- upvalues: (copy) v_u_12
		v_u_12:UpdateMouseLockAvailability()
	end)
	v_u_12:UpdateMouseLockAvailability()
	return v_u_12
end
function v_u_10.GetIsMouseLocked(p16)
	return p16.isMouseLocked
end
function v_u_10.GetBindableToggleEvent(p17)
	return p17.mouseLockToggledEvent.Event
end
function v_u_10.GetMouseLockOffset(_)
	return Vector3.new(1.75, 0, 0)
end
function v_u_10.UpdateMouseLockAvailability(p18)
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_6
	local v19 = v_u_4.LocalPlayer.DevEnableMouseLock
	local v20 = v_u_4.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
	local v21 = v_u_7.ControlMode == Enum.ControlMode.MouseLockSwitch
	local v22 = v_u_7.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
	local v23 = v_u_6.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and (v19 and (v21 and not v22))
	if v23 then
		v23 = not v20
	end
	if v23 ~= p18.enabled then
		p18:EnableMouseLock(v23)
	end
end
function v_u_10.OnBoundKeysObjectChanged(p24, p25)
	p24.boundKeys = {}
	for v26 in string.gmatch(p25, "[^%s,]+") do
		for _, v27 in pairs(Enum.KeyCode:GetEnumItems()) do
			if v26 == v27.Name then
				p24.boundKeys[#p24.boundKeys + 1] = v27
				break
			end
		end
	end
	p24:UnbindContextActions()
	p24:BindContextActions()
end
function v_u_10.OnMouseLockToggled(p28)
	-- upvalues: (copy) v_u_8
	p28.isMouseLocked = not p28.isMouseLocked
	if p28.isMouseLocked then
		local v29 = script:FindFirstChild("CursorImage")
		if v29 and (v29:IsA("StringValue") and v29.Value) then
			v_u_8.setMouseIconOverride(v29.Value)
		else
			if v29 then
				v29:Destroy()
			end
			local v30 = Instance.new("StringValue")
			assert(v30, "")
			v30.Name = "CursorImage"
			v30.Value = "rbxasset://textures/MouseLockedCursor.png"
			v30.Parent = script
			v_u_8.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png")
		end
	else
		v_u_8.restoreMouseIcon()
	end
	p28.mouseLockToggledEvent:Fire()
end
function v_u_10.DoMouseLockSwitch(p31, _, p32, _)
	if p32 ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass
	end
	p31:OnMouseLockToggled()
	return Enum.ContextActionResult.Sink
end
function v_u_10.BindContextActions(p_u_33)
	-- upvalues: (copy) v_u_5, (copy) v_u_3
	local v34 = v_u_5
	local v35 = v_u_3
	local v36 = p_u_33.boundKeys
	v34:BindActionAtPriority("MouseLockSwitchAction", function(p37, p38, p39)
		-- upvalues: (copy) p_u_33
		return p_u_33:DoMouseLockSwitch(p37, p38, p39)
	end, false, v35, unpack(v36))
end
function v_u_10.UnbindContextActions(_)
	-- upvalues: (copy) v_u_5
	v_u_5:UnbindAction("MouseLockSwitchAction")
end
function v_u_10.IsMouseLocked(p40)
	local v41 = p40.enabled
	if v41 then
		v41 = p40.isMouseLocked
	end
	return v41
end
function v_u_10.EnableMouseLock(p42, p43)
	-- upvalues: (copy) v_u_8, (copy) v_u_9
	if p43 ~= p42.enabled then
		p42.enabled = p43
		if p42.enabled then
			p42:BindContextActions()
			return
		end
		v_u_8.restoreMouseIcon()
		p42:UnbindContextActions()
		if v_u_9 then
			if p42.isMouseLocked then
				p42.isMouseLocked = false
				p42.mouseLockToggledEvent:Fire()
				return
			end
		else
			if p42.isMouseLocked then
				p42.mouseLockToggledEvent:Fire()
			end
			p42.isMouseLocked = false
		end
	end
end
return v_u_10