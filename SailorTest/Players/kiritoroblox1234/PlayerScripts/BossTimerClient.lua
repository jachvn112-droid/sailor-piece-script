local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v3 = v1:WaitForChild("Remotes")
local v4 = v3:WaitForChild("BossTimerSync")
local v5 = v3:FindFirstChild("BossTimerEvent")
local v_u_6 = UDim2.new(60, 0, 20, 0)
local v_u_7 = {}
local function v_u_17(p8, p9)
	-- upvalues: (copy) v_u_6
	if not (p8 and p8:IsA("BasePart")) then
		return nil, nil
	end
	local v10 = p8:FindFirstChild("BossTimerBillboard")
	if v10 then
		v10:Destroy()
	end
	local v11 = Instance.new("BillboardGui")
	v11.Name = "BossTimerBillboard"
	v11.Size = v_u_6
	v11.StudsOffset = Vector3.new(0, 4, 0)
	v11.MaxDistance = 300
	v11.AlwaysOnTop = false
	v11.Adornee = p8
	v11.Parent = p8
	v11.Enabled = false
	local v12 = Instance.new("Frame")
	v12.Size = UDim2.new(1, 0, 0.4, 0)
	v12.Position = UDim2.new(0.5, 0, 0.25, 0)
	v12.AnchorPoint = Vector2.new(0.5, 0.5)
	v12.BackgroundTransparency = 1
	v12.Parent = v11
	local v13 = Instance.new("TextLabel")
	v13.Size = UDim2.new(1, 0, 0.4, 0)
	v13.Position = UDim2.new(0.5, 0, 0, 0)
	v13.AnchorPoint = Vector2.new(0.5, 0)
	v13.BackgroundTransparency = 1
	v13.Font = Enum.Font.Merriweather
	v13.TextColor3 = Color3.new(1, 1, 1)
	v13.TextScaled = true
	v13.Text = p9
	v13.Parent = v12
	local v14 = Instance.new("UIStroke")
	v14.Color = Color3.new(0, 0, 0)
	v14.Thickness = 2
	v14.Parent = v13
	local v15 = Instance.new("TextLabel")
	v15.Name = "Timer"
	v15.Size = UDim2.new(1, 0, 0.4, 0)
	v15.Position = UDim2.new(0.5, 0, 0.5, 0)
	v15.AnchorPoint = Vector2.new(0.5, 0)
	v15.BackgroundTransparency = 1
	v15.Font = Enum.Font.Merriweather
	v15.TextColor3 = Color3.new(1, 1, 1)
	v15.TextScaled = true
	v15.Text = ""
	v15.Parent = v12
	local v16 = Instance.new("UIStroke")
	v16.Color = Color3.new(0, 0, 0)
	v16.Thickness = 2
	v16.Parent = v15
	return v11, v15
end
local function v_u_24(p18, p19)
	-- upvalues: (copy) v_u_7, (copy) v_u_17
	local v20 = v_u_7[p18]
	if v20 and (v20.billboard and v20.billboard.Parent) then
		v20.timer = p19.timer
		v20.isAlive = p19.isAlive
		v20.isRotationWaiting = p19.isRotationWaiting or false
		return v20
	end
	local v21 = workspace:FindFirstChild(p19.spawnPointName, true)
	if not v21 then
		return nil
	end
	local v22, v23 = v_u_17(v21, p19.displayName)
	if not v22 then
		return nil
	end
	v_u_7[p18] = {
		["timer"] = p19.timer,
		["isAlive"] = p19.isAlive,
		["isRotationWaiting"] = p19.isRotationWaiting or false,
		["displayName"] = p19.displayName,
		["spawnPointName"] = p19.spawnPointName,
		["billboard"] = v22,
		["timerLabel"] = v23,
		["lastText"] = ""
	}
	return v_u_7[p18]
end
v4.OnClientEvent:Connect(function(p25)
	-- upvalues: (copy) v_u_24
	if p25 then
		for v26, v27 in pairs(p25) do
			v_u_24(v26, v27)
		end
	end
end)
if v5 then
	v5.OnClientEvent:Connect(function(p28, p29, p30)
		-- upvalues: (copy) v_u_7
		local v31 = v_u_7[p28]
		if v31 then
			if p29 == "SPAWNED" then
				v31.isAlive = true
				v31.isRotationWaiting = false
				v31.timer = 0
				return
			elseif p29 == "DIED" then
				v31.isAlive = false
				v31.isRotationWaiting = false
				v31.timer = p30
				return
			elseif p29 == "WAITING" then
				v31.isAlive = false
				v31.isRotationWaiting = false
				v31.timer = p30
			elseif p29 == "ROTATION_WAITING" then
				v31.isAlive = false
				v31.isRotationWaiting = true
				v31.timer = 0
			end
		else
			return
		end
	end)
end
local v_u_32 = 0
v2.Heartbeat:Connect(function(p33)
	-- upvalues: (ref) v_u_32, (copy) v_u_7
	v_u_32 = v_u_32 + p33
	if v_u_32 >= 1 then
		v_u_32 = 0
		for _, v34 in pairs(v_u_7) do
			if v34.isAlive or v34.isRotationWaiting then
				if v34.billboard.Enabled then
					v34.billboard.Enabled = false
				end
			else
				if not v34.billboard.Enabled then
					v34.billboard.Enabled = true
				end
				local v35 = v34.timer - 1
				v34.timer = math.max(0, v35)
				local v36 = v34.timer
				local v37
				if v36 <= 0 then
					v37 = "Spawning..."
				else
					local v38 = v36 / 60
					local v39 = math.floor(v38)
					local v40 = math.floor(v36) % 60
					v37 = v39 > 0 and string.format("%d:%02d", v39, v40) or string.format("0:%02d", v40)
				end
				if v34.lastText ~= v37 then
					v34.timerLabel.Text = v37
					v34.lastText = v37
				end
			end
		end
	end
end)