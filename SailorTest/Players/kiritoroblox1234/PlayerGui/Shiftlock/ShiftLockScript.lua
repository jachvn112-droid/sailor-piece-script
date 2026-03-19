local v1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = UserSettings().GameSettings
local v_u_4 = {}
while not v1.LocalPlayer do
	wait()
end
local v_u_5 = v1.LocalPlayer
local v_u_6 = v_u_5:GetMouse()
v_u_5:WaitForChild("PlayerGui")
local v_u_7 = nil
local v_u_8 = true
local v_u_9 = false
local v_u_10 = false
v_u_4.OnShiftLockToggled = Instance.new("BindableEvent")
local v_u_11 = not v_u_2.TouchEnabled and v_u_5.DevEnableMouseLock
if v_u_11 then
	if v_u_3.ControlMode == Enum.ControlMode.MouseLockSwitch and (v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and v_u_3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
		v_u_11 = v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
	else
		v_u_11 = false
	end
end
function v_u_4.IsShiftLocked(_)
	-- upvalues: (ref) v_u_11, (ref) v_u_8
	local v12 = v_u_11
	if v12 then
		v12 = v_u_8
	end
	return v12
end
function v_u_4.SetIsInFirstPerson(_, p13)
	-- upvalues: (ref) v_u_10
	v_u_10 = p13
end
local function v_u_16(p14, p15)
	if not p15 then
		if p14.UserInputType == Enum.UserInputType.Keyboard and p14.KeyCode ~= Enum.KeyCode.LeftShift then
			local _ = p14.KeyCode == Enum.KeyCode.RightShift
		end
	end
end
v_u_3.Changed:connect(function(p17)
	-- upvalues: (copy) v_u_3, (ref) v_u_11, (copy) v_u_5, (ref) v_u_8, (copy) v_u_4, (ref) v_u_9, (ref) v_u_7, (copy) v_u_2, (copy) v_u_16, (copy) v_u_6
	if p17 == "ControlMode" then
		if v_u_3.ControlMode ~= Enum.ControlMode.MouseLockSwitch then
			v_u_11 = false
			v_u_6.Icon = ""
			if v_u_7 then
				v_u_7:disconnect()
				v_u_7 = nil
			end
			v_u_9 = false
			v_u_4.OnShiftLockToggled:Fire()
			return
		end
		local v18 = v_u_5.DevEnableMouseLock
		if v18 then
			if v_u_3.ControlMode == Enum.ControlMode.MouseLockSwitch and (v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and v_u_3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
				v18 = v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
			else
				v18 = false
			end
		end
		v_u_11 = v18
		if v_u_11 then
			if v_u_8 then
				v_u_4.OnShiftLockToggled:Fire()
			end
			if not v_u_9 then
				v_u_7 = v_u_2.InputBegan:connect(v_u_16)
				v_u_9 = true
				return
			end
		end
	elseif p17 == "ComputerMovementMode" then
		if v_u_3.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
			v_u_11 = false
			v_u_6.Icon = ""
			if v_u_7 then
				v_u_7:disconnect()
				v_u_7 = nil
			end
			v_u_9 = false
			v_u_4.OnShiftLockToggled:Fire()
			return
		end
		local v19 = v_u_5.DevEnableMouseLock
		if v19 then
			if v_u_3.ControlMode == Enum.ControlMode.MouseLockSwitch and (v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and v_u_3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
				v19 = v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
			else
				v19 = false
			end
		end
		v_u_11 = v19
		if v_u_11 then
			if v_u_8 then
				v_u_4.OnShiftLockToggled:Fire()
			end
			if not v_u_9 then
				v_u_7 = v_u_2.InputBegan:connect(v_u_16)
				v_u_9 = true
			end
		end
	end
end)
v_u_5.Changed:connect(function(p20)
	-- upvalues: (copy) v_u_5, (ref) v_u_11, (copy) v_u_3, (ref) v_u_8, (copy) v_u_4, (ref) v_u_9, (ref) v_u_7, (copy) v_u_2, (copy) v_u_16, (copy) v_u_6
	if p20 == "DevEnableMouseLock" then
		if not v_u_5.DevEnableMouseLock then
			v_u_11 = false
			v_u_6.Icon = ""
			if v_u_7 then
				v_u_7:disconnect()
				v_u_7 = nil
			end
			v_u_9 = false
			v_u_4.OnShiftLockToggled:Fire()
			return
		end
		local v21 = v_u_5.DevEnableMouseLock
		if v21 then
			if v_u_3.ControlMode == Enum.ControlMode.MouseLockSwitch and (v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and v_u_3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
				v21 = v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
			else
				v21 = false
			end
		end
		v_u_11 = v21
		if v_u_11 then
			if v_u_8 then
				v_u_4.OnShiftLockToggled:Fire()
			end
			if not v_u_9 then
				v_u_7 = v_u_2.InputBegan:connect(v_u_16)
				v_u_9 = true
				return
			end
		end
	elseif p20 == "DevComputerMovementMode" then
		if v_u_5.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or v_u_5.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
			v_u_11 = false
			v_u_6.Icon = ""
			if v_u_7 then
				v_u_7:disconnect()
				v_u_7 = nil
			end
			v_u_9 = false
			v_u_4.OnShiftLockToggled:Fire()
			return
		end
		local v22 = v_u_5.DevEnableMouseLock
		if v22 then
			if v_u_3.ControlMode == Enum.ControlMode.MouseLockSwitch and (v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and v_u_3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
				v22 = v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
			else
				v22 = false
			end
		end
		v_u_11 = v22
		if v_u_11 then
			if v_u_8 then
				v_u_4.OnShiftLockToggled:Fire()
			end
			if not v_u_9 then
				v_u_7 = v_u_2.InputBegan:connect(v_u_16)
				v_u_9 = true
			end
		end
	end
end)
v_u_5.CharacterAdded:connect(function(_)
	-- upvalues: (copy) v_u_2
	local _ = v_u_2.TouchEnabled
end)
local v23, v24
if not v_u_2.TouchEnabled then
	local v25 = v_u_5.DevEnableMouseLock
	if v25 then
		if v_u_3.ControlMode == Enum.ControlMode.MouseLockSwitch and (v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and v_u_3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
			v25 = v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
		else
			v25 = false
		end
	end
	if v25 then
		v23 = v_u_2.InputBegan:connect(v_u_16)
		v24 = true
		v_u_9 = v24
	end
end
v_u_11 = v_u_5.DevEnableMouseLock
if v_u_11 then
	v_u_11 = false
	if v_u_3.ControlMode == Enum.ControlMode.MouseLockSwitch then
		v_u_11 = false
		if v_u_5.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove then
			v_u_11 = false
			if v_u_3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove then
				if v_u_5.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
					v_u_11 = false
				else
					v_u_11 = true
				end
			end
		end
	end
end
if v_u_11 then
	if v_u_8 then
		v_u_4.OnShiftLockToggled:Fire()
	end
	if not v_u_9 then
		v23 = v_u_2.InputBegan:connect(v_u_16)
		v24 = true
	end
end
return v_u_4