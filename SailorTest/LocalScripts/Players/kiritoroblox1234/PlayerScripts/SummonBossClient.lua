local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_5 = require(v2:WaitForChild("Modules"):WaitForChild("SummonableBossConfig"))
local v_u_6 = require(v2:WaitForChild("Modules"):WaitForChild("NotificationService"))
local v7 = v2:WaitForChild("Remotes")
local v_u_8 = v7:WaitForChild("RequestSummonBoss")
local v9 = v7:WaitForChild("SummonBossResult")
local v10 = v7:WaitForChild("OpenSummonUI")
local v_u_11 = v7:WaitForChild("RequestAutoSpawn")
local v12 = v7:WaitForChild("AutoSpawnUpdate")
local v_u_13 = v4:WaitForChild("SummonBossUI"):WaitForChild("MainFrame")
local v14 = v_u_13:WaitForChild("Frame")
local v_u_15 = v14:WaitForChild("Content"):WaitForChild("Holder")
local v_u_16 = {}
local v_u_17 = {
	"Normal",
	"Medium",
	"Hard",
	"Extreme"
}
local v_u_18 = nil
local v_u_19 = false
local v_u_20 = {}
for v21, v22 in pairs(v_u_5:GetAllBosses()) do
	if v22.hasDifficulty then
		v_u_16[v21] = "Normal"
	end
end
local function v_u_30(p23)
	local v24 = p23:FindFirstChild(p23.Name)
	if v24 then
		if not v24:IsA("Frame") then
			v24 = p23
		end
	else
		v24 = p23
	end
	local v25 = v24:FindFirstChild("Holder")
	if not v25 then
		return {}
	end
	local v26 = v25:FindFirstChild("RequirementsFrame")
	if not v26 then
		return {}
	end
	local v27 = {}
	for _, v28 in ipairs(v26:GetChildren()) do
		if v28:IsA("Frame") then
			local v29 = v28:FindFirstChild("Txt")
			if v29 then
				table.insert(v27, v29)
			end
		end
	end
	return v27
end
local function v_u_37(p31)
	local v32 = p31:FindFirstChild(p31.Name)
	if v32 then
		if not v32:IsA("Frame") then
			v32 = p31
		end
	else
		v32 = p31
	end
	local v33 = v32:FindFirstChild("Spawn")
	if v33 then
		local v34 = v33:FindFirstChild("AutoSpawn")
		if v34 then
			local v35 = v34:FindFirstChild("Holder")
			if v35 then
				local v36 = v35:FindFirstChild("Checkmark")
				if v36 then
					return v36:FindFirstChild("Icon")
				else
					return nil
				end
			else
				return nil
			end
		else
			return nil
		end
	else
		return nil
	end
end
local function v_u_47(p38)
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_16, (copy) v_u_17
	local v39 = v_u_5:GetBoss(p38)
	if v39 and v39.hasDifficulty then
		local v40 = v_u_15:FindFirstChild(v39.uiFrameName)
		if v40 then
			local v41 = v40:FindFirstChild("DifficultyHolder")
			if v41 then
				local v42 = v41:FindFirstChild("Holder")
				if v42 then
					local v43 = v_u_16[p38] or "Normal"
					for _, v44 in ipairs(v_u_17) do
						local v45 = v42:FindFirstChild(v44)
						if v45 then
							local v46 = v45:FindFirstChild("On")
							if v46 then
								v46.Visible = v44 == v43
							end
						end
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_56(p48)
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_16, (copy) v_u_30
	local v49 = v_u_5:GetBoss(p48)
	if v49 and v49.hasDifficulty then
		local v50 = v_u_15:FindFirstChild(v49.uiFrameName)
		if v50 then
			local v51 = v_u_16[p48] or "Normal"
			local v52 = v_u_30(v50)
			local v53 = v_u_5:GetCostParts(p48, v51)
			for v54, v55 in ipairs(v52) do
				v55.Text = v53[v54] or ""
			end
		end
	else
		return
	end
end
local function v_u_59()
	-- upvalues: (copy) v_u_5, (copy) v_u_47, (copy) v_u_56
	for v57, v58 in pairs(v_u_5:GetAllBosses()) do
		if v58.hasDifficulty then
			v_u_47(v57)
			v_u_56(v57)
		end
	end
end
local function v_u_64()
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_37, (ref) v_u_18
	for v60, v61 in pairs(v_u_5:GetAllBosses()) do
		local v62 = v_u_15:FindFirstChild(v61.uiFrameName)
		if v62 then
			local v63 = v_u_37(v62)
			if v63 then
				v63.Visible = v60 == v_u_18
			end
		end
	end
end
local function v_u_65()
	-- upvalues: (ref) v_u_19, (copy) v_u_13, (copy) v_u_3
	if not v_u_19 then
		v_u_19 = true
		v_u_13.Visible = true
		v_u_13.Size = UDim2.new(0, 0, 0, 0)
		v_u_13.Position = UDim2.new(0.5, 0, 0.5, 0)
		v_u_3:Create(v_u_13, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Size"] = UDim2.new(0.4, 0, 0.5, 0)
		}):Play()
	end
end
local function v_u_67()
	-- upvalues: (ref) v_u_19, (copy) v_u_3, (copy) v_u_13
	if v_u_19 then
		local v66 = v_u_3:Create(v_u_13, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			["Size"] = UDim2.new(0, 0, 0, 0)
		})
		v66:Play()
		v66.Completed:Wait()
		v_u_13.Visible = false
		v_u_19 = false
	end
end
local function v_u_78(p_u_68)
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_17, (copy) v_u_16, (copy) v_u_47, (copy) v_u_56
	local v69 = v_u_5:GetBoss(p_u_68)
	if v69 and v69.hasDifficulty then
		local v70 = v_u_15:FindFirstChild(v69.uiFrameName)
		if v70 then
			local v71 = v70:FindFirstChild("DifficultyHolder")
			if v71 then
				local v72 = v71:FindFirstChild("Holder")
				if v72 then
					for _, v_u_73 in ipairs(v_u_17) do
						local v74 = v72:FindFirstChild(v_u_73)
						if v74 then
							local function v75()
								-- upvalues: (ref) v_u_16, (copy) p_u_68, (copy) v_u_73, (ref) v_u_47, (ref) v_u_56
								v_u_16[p_u_68] = v_u_73
								v_u_47(p_u_68)
								v_u_56(p_u_68)
							end
							local v76 = v74:FindFirstChild("Off")
							local v77 = v74:FindFirstChild("On")
							if v76 and v76:IsA("GuiButton") then
								v76.MouseButton1Click:Connect(v75)
							end
							if v77 and v77:IsA("GuiButton") then
								v77.MouseButton1Click:Connect(v75)
							end
						end
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_89(p_u_79)
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_20, (copy) v_u_8, (copy) v_u_16, (copy) v_u_11
	local v_u_80 = v_u_5:GetBoss(p_u_79)
	if v_u_80 then
		local v81 = v_u_15:FindFirstChild(v_u_80.uiFrameName)
		if v81 then
			local v82 = v81:FindFirstChild(v81.Name)
			if v82 then
				if not v82:IsA("Frame") then
					v82 = v81
				end
			else
				v82 = v81
			end
			if v81:GetAttribute("Connected") then
				return
			else
				v81:SetAttribute("Connected", true)
				local v83 = v82:FindFirstChild("Spawn")
				if v83 then
					local v84 = v83:FindFirstChild("Spawn")
					local v85 = v83:FindFirstChild("AutoSpawn")
					local v86 = v85 and v85:FindFirstChild("Holder")
					if v86 then
						v86 = v85.Holder:FindFirstChild("Checkmark")
					end
					local v87
					if v86 then
						v87 = v86:FindFirstChild("Icon")
					else
						v87 = v86
					end
					if v87 then
						v87.Visible = false
					end
					if v84 and v84:IsA("GuiButton") then
						v84.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_20, (copy) p_u_79, (copy) v_u_80, (ref) v_u_8, (ref) v_u_16
							local v88 = os.clock()
							if v_u_20[p_u_79] and v88 < v_u_20[p_u_79] then
								return
							else
								v_u_20[p_u_79] = v88 + 2
								if v_u_80.hasDifficulty then
									v_u_8:FireServer(p_u_79, v_u_16[p_u_79] or "Normal")
								else
									v_u_8:FireServer(p_u_79)
								end
							end
						end)
					end
					if v86 and v86:IsA("GuiButton") then
						v86.MouseButton1Click:Connect(function()
							-- upvalues: (copy) v_u_80, (ref) v_u_11, (copy) p_u_79, (ref) v_u_16
							if v_u_80.hasDifficulty then
								v_u_11:FireServer(p_u_79, v_u_16[p_u_79] or "Normal")
							else
								v_u_11:FireServer(p_u_79)
							end
						end)
					end
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v91()
	-- upvalues: (copy) v_u_5, (copy) v_u_78, (copy) v_u_89, (copy) v_u_59
	for v90, _ in pairs(v_u_5:GetAllBosses()) do
		v_u_78(v90)
		v_u_89(v90)
	end
	v_u_59()
end
v10.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_65
	v_u_65()
end)
v9.OnClientEvent:Connect(function(p92, p93)
	-- upvalues: (copy) v_u_67, (copy) v_u_6
	if p92 then
		v_u_67()
	else
		v_u_6:Show("Quest", {
			["message"] = p93
		})
	end
end)
v12.OnClientEvent:Connect(function(p94)
	-- upvalues: (ref) v_u_18, (copy) v_u_64
	v_u_18 = p94
	v_u_64()
end)
local v95 = v14:FindFirstChild("CloseButtonFrame")
local v96 = v95 and v95:FindFirstChild("CloseButton")
if v96 then
	v96.MouseButton1Click:Connect(v_u_67)
end
v_u_13.Visible = false
v91()