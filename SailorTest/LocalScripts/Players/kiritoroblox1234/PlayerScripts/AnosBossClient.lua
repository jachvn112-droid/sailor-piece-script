local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_5 = require(v2:WaitForChild("Modules"):WaitForChild("AnosBossConfig"))
local v_u_6 = require(v2:WaitForChild("Modules"):WaitForChild("NotificationService"))
local v7 = v2:WaitForChild("Remotes")
local v_u_8 = v7:WaitForChild("RequestSpawnAnosBoss")
local v9 = v7:WaitForChild("AnosBossResult")
local v10 = v7:WaitForChild("OpenAnosUI")
local v_u_11 = v7:WaitForChild("RequestAutoSpawnAnos")
local v12 = v7:WaitForChild("AutoSpawnAnosUpdate")
local v_u_13 = v4:WaitForChild("AnosBossUI"):WaitForChild("MainFrame")
local v14 = v_u_13:WaitForChild("Frame")
local v_u_15 = v14:WaitForChild("Content"):WaitForChild("Holder"):WaitForChild("Holder")
local v_u_16 = false
local v_u_17 = {}
local v_u_18 = {}
local v_u_19 = {}
local v_u_20 = {
	"Normal",
	"Medium",
	"Hard",
	"Extreme"
}
local v_u_21 = {
	["Normal"] = { Color3.fromRGB(120, 255, 120), Color3.fromRGB(80, 200, 80) },
	["Medium"] = { Color3.fromRGB(255, 200, 60), Color3.fromRGB(255, 160, 30) },
	["Hard"] = { Color3.fromRGB(255, 80, 80), Color3.fromRGB(200, 40, 40) },
	["Extreme"] = { Color3.fromRGB(200, 80, 255), Color3.fromRGB(140, 40, 200) }
}
local function v_u_29(p22)
	local v23 = p22:FindFirstChild("Holder")
	if not v23 then
		return nil
	end
	local v24 = v23:FindFirstChild("BossInfo")
	if not v24 then
		return nil
	end
	local v25 = {}
	local v26 = v24:FindFirstChild("DifficultyHolder")
	if v26 then
		v26 = v24.DifficultyHolder:FindFirstChild("Holder")
	end
	v25.diffHolder = v26
	v25.spawnInfo = v24:FindFirstChild("SpawnInfo")
	local v27 = v24:FindFirstChild("SpawnInfo") and v24.SpawnInfo:FindFirstChild("SpawnButton")
	if v27 then
		v27 = v24.SpawnInfo.SpawnButton:FindFirstChild("Spawn")
	end
	v25.spawnButton = v27
	local v28 = v24:FindFirstChild("SpawnInfo")
	if v28 then
		v28 = v24.SpawnInfo:FindFirstChild("Title")
	end
	v25.costLabel = v28
	return v25
end
local function v_u_40(p30, p31)
	-- upvalues: (copy) v_u_29, (copy) v_u_17, (copy) v_u_20, (copy) v_u_5, (copy) v_u_21
	local v32 = v_u_29(p31)
	if v32 and v32.diffHolder then
		local v33 = v_u_17[p30] or "Normal"
		for _, v34 in ipairs(v_u_20) do
			local v35 = v32.diffHolder:FindFirstChild(v34)
			if v35 then
				local v36 = v35:FindFirstChild("On")
				if v36 then
					v36.Visible = v34 == v33
				end
			end
		end
		if v32.costLabel then
			local v37 = v_u_5:FormatCosts(p30, v33)
			v32.costLabel.Text = "Cost: " .. v37
			local v38 = v32.costLabel:FindFirstChildOfClass("UIGradient")
			if v38 and v_u_21[v33] then
				local v39 = v_u_21[v33]
				v38.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v39[1]), ColorSequenceKeypoint.new(1, v39[2]) })
			end
		end
	end
end
local function v_u_48()
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_18
	for v41, v42 in pairs(v_u_5:GetAllBosses()) do
		local v43 = v_u_15:FindFirstChild(v42.uiFrameName)
		if v43 then
			local v44 = v43:FindFirstChild("AutoSpawn")
			if v44 then
				local v45 = v44:FindFirstChild("Holder")
				if v45 then
					local v46 = v45:FindFirstChild("Checkmark")
					if v46 then
						local v47 = v46:FindFirstChild("Icon")
						if v47 then
							v47.Visible = v_u_18[v41] == true
						end
					end
				end
			end
		end
	end
end
local function v_u_49()
	-- upvalues: (ref) v_u_16, (copy) v_u_13, (copy) v_u_3
	if not v_u_16 then
		v_u_16 = true
		v_u_13.Visible = true
		v_u_13.Size = UDim2.new(0, 0, 0, 0)
		v_u_13.Position = UDim2.new(0.5, 0, 0.5, 0)
		v_u_3:Create(v_u_13, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Size"] = UDim2.new(0.4, 0, 0.5, 0)
		}):Play()
	end
end
local function v_u_51()
	-- upvalues: (ref) v_u_16, (copy) v_u_3, (copy) v_u_13
	if v_u_16 then
		local v50 = v_u_3:Create(v_u_13, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			["Size"] = UDim2.new(0, 0, 0, 0)
		})
		v50:Play()
		v50.Completed:Wait()
		v_u_13.Visible = false
		v_u_16 = false
	end
end
local function v65(p_u_52)
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_17, (copy) v_u_29, (copy) v_u_20, (copy) v_u_40, (copy) v_u_19, (copy) v_u_8, (copy) v_u_11
	local v53 = v_u_5:GetBoss(p_u_52)
	if v53 then
		local v_u_54 = v_u_15:FindFirstChild(v53.uiFrameName)
		if v_u_54 then
			if v_u_54:GetAttribute("Connected") then
				return
			else
				v_u_54:SetAttribute("Connected", true)
				v_u_17[p_u_52] = "Normal"
				local v55 = v_u_29(v_u_54)
				if v55 then
					if v55.diffHolder then
						for _, v_u_56 in ipairs(v_u_20) do
							local v57 = v55.diffHolder:FindFirstChild(v_u_56)
							if v57 then
								local v58 = v57:FindFirstChild("Off")
								local v59 = v57:FindFirstChild("On")
								local function v60()
									-- upvalues: (ref) v_u_17, (copy) p_u_52, (copy) v_u_56, (ref) v_u_40, (copy) v_u_54
									v_u_17[p_u_52] = v_u_56
									v_u_40(p_u_52, v_u_54)
								end
								if v58 and v58:IsA("GuiButton") then
									v58.MouseButton1Click:Connect(v60)
								end
								if v59 and v59:IsA("GuiButton") then
									v59.MouseButton1Click:Connect(v60)
								end
							end
						end
					end
					if v55.spawnButton and v55.spawnButton:IsA("GuiButton") then
						v55.spawnButton.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_19, (copy) p_u_52, (ref) v_u_17, (ref) v_u_8
							local v61 = os.clock()
							if not v_u_19[p_u_52] or v61 >= v_u_19[p_u_52] then
								v_u_19[p_u_52] = v61 + 2
								v_u_8:FireServer(p_u_52, v_u_17[p_u_52] or "Normal")
							end
						end)
					end
					local v62 = v_u_54:FindFirstChild("AutoSpawn")
					local v63 = v62 and v62:FindFirstChild("Holder")
					if v63 then
						local v64 = v63:FindFirstChild("Checkmark")
						if v64 and v64:IsA("GuiButton") then
							v64.MouseButton1Click:Connect(function()
								-- upvalues: (ref) v_u_17, (copy) p_u_52, (ref) v_u_11
								v_u_11:FireServer(p_u_52, v_u_17[p_u_52] or "Normal")
							end)
						end
					end
					v_u_40(p_u_52, v_u_54)
				end
			end
		else
			return
		end
	else
		return
	end
end
v10.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_49
	v_u_49()
end)
v9.OnClientEvent:Connect(function(p66, p67)
	-- upvalues: (copy) v_u_51, (copy) v_u_6
	if p66 then
		v_u_51()
	else
		v_u_6:Show("Quest", {
			["message"] = p67
		})
	end
end)
v12.OnClientEvent:Connect(function(p68, p69)
	-- upvalues: (copy) v_u_18, (copy) v_u_48
	if p68 == "enable" then
		v_u_18[p69] = true
	elseif p68 == "disable" then
		v_u_18[p69] = nil
	end
	v_u_48()
end)
local v70 = v14:FindFirstChild("CloseButtonFrame")
local v71 = v70 and v70:FindFirstChild("CloseButton")
if v71 then
	v71.MouseButton1Click:Connect(v_u_51)
end
v_u_13.Visible = false
for v72, _ in pairs(v_u_5:GetAllBosses()) do
	v65(v72)
end