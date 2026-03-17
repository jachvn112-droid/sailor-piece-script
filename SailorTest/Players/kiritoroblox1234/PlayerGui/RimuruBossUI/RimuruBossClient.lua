local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_4 = require(v2.Modules:WaitForChild("RimuruBossConfig"))
local v_u_5 = require(v2.Modules:WaitForChild("UIManager"))
local v6 = v2:WaitForChild("Remotes")
local v7 = v2:WaitForChild("RemoteEvents")
local v8 = v6:WaitForChild("OpenRimuruUI")
local v_u_9 = v7:WaitForChild("RequestSpawnRimuru")
local v10 = v7:WaitForChild("RimuruBossResult")
local v_u_11 = v7:WaitForChild("RequestAutoSpawnRimuru")
local v12 = v7:WaitForChild("AutoSpawnRimuruUpdate")
local v_u_13 = v3:WaitForChild("RimuruBossUI"):WaitForChild("MainFrame")
local v14 = v_u_13:WaitForChild("Frame")
local v15 = v14.Content:WaitForChild("Holder"):WaitForChild("Holder"):WaitForChild("RimuruFrame")
local v16 = v14.CloseButtonFrame:WaitForChild("CloseButton")
local v17 = v15.Holder:WaitForChild("BossInfo")
local v_u_18 = v17.DifficultyHolder.Holder
local v19 = v17:WaitForChild("SpawnInfo")
local v_u_20 = v19.SpawnButton:WaitForChild("Spawn")
local v_u_21 = v19:WaitForChild("Title")
local v_u_22 = v15:WaitForChild("AutoSpawn").Holder:WaitForChild("Checkmark")
local v_u_23 = v_u_22:WaitForChild("Icon")
local v_u_24 = v_u_4.Difficulties
local v_u_25 = {
	["Normal"] = { Color3.fromRGB(120, 255, 120), Color3.fromRGB(80, 200, 80) },
	["Medium"] = { Color3.fromRGB(255, 200, 60), Color3.fromRGB(255, 160, 30) },
	["Hard"] = { Color3.fromRGB(255, 80, 80), Color3.fromRGB(200, 40, 40) },
	["Extreme"] = { Color3.fromRGB(200, 80, 255), Color3.fromRGB(140, 40, 200) }
}
local v_u_26 = "Normal"
local v_u_27 = false
local v_u_28 = 0
local function v_u_34()
	-- upvalues: (copy) v_u_24, (copy) v_u_18, (ref) v_u_26, (copy) v_u_4, (copy) v_u_21, (copy) v_u_25
	for _, v29 in ipairs(v_u_24) do
		local v30 = v_u_18:FindFirstChild(v29)
		if v30 then
			local v31 = v30:FindFirstChild("On")
			if v31 then
				v31.Visible = v29 == v_u_26
			end
		end
	end
	v_u_21.Text = "Cost: " .. v_u_4:FormatCosts(v_u_26)
	local v32 = v_u_21:FindFirstChildOfClass("UIGradient")
	if v32 and v_u_25[v_u_26] then
		local v33 = v_u_25[v_u_26]
		v32.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v33[1]), ColorSequenceKeypoint.new(1, v33[2]) })
	end
end
local function v_u_41()
	-- upvalues: (copy) v_u_24, (copy) v_u_18, (ref) v_u_26, (copy) v_u_34, (copy) v_u_20, (ref) v_u_28, (copy) v_u_9, (copy) v_u_22, (copy) v_u_11
	for _, v_u_35 in ipairs(v_u_24) do
		local v36 = v_u_18:FindFirstChild(v_u_35)
		if v36 then
			local function v37()
				-- upvalues: (ref) v_u_26, (copy) v_u_35, (ref) v_u_34
				v_u_26 = v_u_35
				v_u_34()
			end
			local v38 = v36:FindFirstChild("Off")
			local v39 = v36:FindFirstChild("On")
			if v38 and v38:IsA("GuiButton") then
				v38.MouseButton1Click:Connect(v37)
			end
			if v39 and v39:IsA("GuiButton") then
				v39.MouseButton1Click:Connect(v37)
			end
		end
	end
	v_u_20.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_28, (ref) v_u_9, (ref) v_u_26
		local v40 = os.clock()
		if v40 >= v_u_28 then
			v_u_28 = v40 + 2
			v_u_9:FireServer(v_u_26)
		end
	end)
	v_u_22.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_11, (ref) v_u_26
		v_u_11:FireServer(v_u_26)
	end)
	v_u_34()
end
v8.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:Open("RimuruBossUI")
end)
v10.OnClientEvent:Connect(function(p42, _)
	-- upvalues: (copy) v_u_5
	if p42 then
		v_u_5:Close("RimuruBossUI")
	end
end)
v12.OnClientEvent:Connect(function(p43)
	-- upvalues: (ref) v_u_27, (copy) v_u_23
	v_u_27 = p43 == "enable"
	v_u_23.Visible = v_u_27
end)
v16.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:Close("RimuruBossUI")
end)
v_u_13.Visible = false
task.spawn(function()
	-- upvalues: (copy) v_u_5, (copy) v_u_13, (copy) v_u_41
	v_u_5:Register("RimuruBossUI", v_u_13)
	v_u_41()
end)