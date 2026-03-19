local v_u_1 = game:GetService("UserInputService")
local v2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local v4 = game:GetService("Players").LocalPlayer
local v_u_5 = v4.Character or v4.CharacterAdded:Wait()
local v_u_6 = v_u_5:WaitForChild("Humanoid")
local v_u_7 = v3:WaitForChild("RemoteEvents"):WaitForChild("SprintToggle")
local v_u_8 = Enum.KeyCode.LeftControl
local v_u_9 = false
local v_u_10 = 0
local v_u_11 = false
local v_u_12 = 0
v_u_1.InputBegan:Connect(function(p13, p14)
	-- upvalues: (copy) v_u_8, (ref) v_u_9, (copy) v_u_7
	if not p14 then
		if p13.KeyCode == v_u_8 or p13.KeyCode == Enum.KeyCode.ButtonL3 then
			v_u_9 = not v_u_9
			v_u_7:FireServer(v_u_9)
		end
	end
end)
local function v22()
	-- upvalues: (copy) v_u_1, (ref) v_u_11, (ref) v_u_10, (ref) v_u_9, (copy) v_u_7, (ref) v_u_12
	local v15 = v_u_1:GetConnectedGamepads()
	if #v15 == 0 then
		return
	end
	local v16 = v_u_1:GetGamepadState(v15[1])
	local v17 = 0
	for _, v18 in ipairs(v16) do
		if v18.KeyCode == Enum.KeyCode.Thumbstick1 then
			v17 = v18.Position.Y
			break
		end
	end
	local v19 = v17 > 0.7
	local v20 = v17 < 0.3
	local v21 = tick()
	if v19 and not v_u_11 then
		if v21 - v_u_10 < 0.35 then
			v_u_9 = not v_u_9
			v_u_7:FireServer(v_u_9)
			v_u_12 = 0
			v_u_10 = 0
		else
			v_u_10 = v21
			v_u_12 = 1
		end
	end
	if v20 then
		v_u_11 = false
	elseif v19 then
		v_u_11 = true
	end
	if v_u_12 > 0 and v21 - v_u_10 > 0.35 then
		v_u_12 = 0
	end
end
v2.Heartbeat:Connect(v22)
local function v_u_24()
	-- upvalues: (ref) v_u_6, (ref) v_u_9, (copy) v_u_7
	v_u_6.StateChanged:Connect(function(_, p23)
		-- upvalues: (ref) v_u_9, (ref) v_u_7
		if ({
			[Enum.HumanoidStateType.Swimming] = true,
			[Enum.HumanoidStateType.Seated] = true,
			[Enum.HumanoidStateType.Dead] = true
		})[p23] and v_u_9 then
			v_u_9 = false
			v_u_7:FireServer(false)
		end
	end)
	v_u_6.Died:Connect(function()
		-- upvalues: (ref) v_u_9
		v_u_9 = false
	end)
end
v_u_24()
v4.CharacterAdded:Connect(function(p25)
	-- upvalues: (ref) v_u_5, (ref) v_u_6, (ref) v_u_9, (ref) v_u_11, (ref) v_u_12, (ref) v_u_10, (copy) v_u_24
	v_u_5 = p25
	v_u_6 = v_u_5:WaitForChild("Humanoid")
	v_u_9 = false
	v_u_11 = false
	v_u_12 = 0
	v_u_10 = 0
	v_u_24()
end)