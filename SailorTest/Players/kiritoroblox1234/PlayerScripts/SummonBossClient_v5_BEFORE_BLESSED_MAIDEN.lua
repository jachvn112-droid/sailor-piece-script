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
local v_u_16 = v_u_15:WaitForChild("GilgameshBossFrame"):WaitForChild("DifficultyHolder"):WaitForChild("Holder")
local v_u_17 = false
local v_u_18 = "Normal"
local v_u_19 = nil
local v_u_20 = {}
local v_u_21 = {
	"Normal",
	"Medium",
	"Hard",
	"Extreme"
}
local function v_u_29(p22)
	local v23 = p22:FindFirstChild(p22.Name)
	if v23 then
		if not v23:IsA("Frame") then
			v23 = p22
		end
	else
		v23 = p22
	end
	local v24 = v23:FindFirstChild("Holder")
	if not v24 then
		return {}
	end
	local v25 = v24:FindFirstChild("RequirementsFrame")
	if not v25 then
		return {}
	end
	local v26 = {}
	for _, v27 in ipairs(v25:GetChildren()) do
		if v27:IsA("Frame") then
			local v28 = v27:FindFirstChild("Txt")
			if v28 then
				table.insert(v26, v28)
			end
		end
	end
	return v26
end
local function v_u_36(p30)
	local v31 = p30:FindFirstChild(p30.Name)
	if v31 then
		if not v31:IsA("Frame") then
			v31 = p30
		end
	else
		v31 = p30
	end
	local v32 = v31:FindFirstChild("Spawn")
	if v32 then
		local v33 = v32:FindFirstChild("AutoSpawn")
		if v33 then
			local v34 = v33:FindFirstChild("Holder")
			if v34 then
				local v35 = v34:FindFirstChild("Checkmark")
				if v35 then
					return v35:FindFirstChild("Icon")
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
local function v_u_40()
	-- upvalues: (copy) v_u_21, (copy) v_u_16, (ref) v_u_18
	for _, v37 in ipairs(v_u_21) do
		local v38 = v_u_16:FindFirstChild(v37)
		if v38 then
			local v39 = v38:FindFirstChild("On")
			if v39 then
				v39.Visible = v37 == v_u_18
			end
		end
	end
end
local function v_u_48()
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_29, (ref) v_u_18
	for v41, v42 in pairs(v_u_5:GetAllBosses()) do
		if v42.hasDifficulty then
			local v43 = v_u_15:FindFirstChild(v42.uiFrameName)
			if v43 then
				local v44 = v_u_29(v43)
				local v45 = v_u_5:GetCostParts(v41, v_u_18)
				for v46, v47 in ipairs(v44) do
					v47.Text = v45[v46] or ""
				end
			end
		end
	end
end
local function v_u_53()
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_36, (ref) v_u_19
	for v49, v50 in pairs(v_u_5:GetAllBosses()) do
		local v51 = v_u_15:FindFirstChild(v50.uiFrameName)
		if v51 then
			local v52 = v_u_36(v51)
			if v52 then
				v52.Visible = v49 == v_u_19
			end
		end
	end
end
local function v_u_54()
	-- upvalues: (ref) v_u_17, (copy) v_u_13, (copy) v_u_3
	if not v_u_17 then
		v_u_17 = true
		v_u_13.Visible = true
		v_u_13.Size = UDim2.new(0, 0, 0, 0)
		v_u_13.Position = UDim2.new(0.5, 0, 0.5, 0)
		v_u_3:Create(v_u_13, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Size"] = UDim2.new(0.4, 0, 0.5, 0)
		}):Play()
	end
end
local function v_u_56()
	-- upvalues: (ref) v_u_17, (copy) v_u_3, (copy) v_u_13
	if v_u_17 then
		local v55 = v_u_3:Create(v_u_13, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			["Size"] = UDim2.new(0, 0, 0, 0)
		})
		v55:Play()
		v55.Completed:Wait()
		v_u_13.Visible = false
		v_u_17 = false
	end
end
local function v_u_62()
	-- upvalues: (copy) v_u_21, (copy) v_u_16, (ref) v_u_18, (copy) v_u_40, (copy) v_u_48
	for _, v_u_57 in ipairs(v_u_21) do
		local v58 = v_u_16:FindFirstChild(v_u_57)
		if v58 then
			local function v59()
				-- upvalues: (ref) v_u_18, (copy) v_u_57, (ref) v_u_40, (ref) v_u_48
				v_u_18 = v_u_57
				v_u_40()
				v_u_48()
			end
			local v60 = v58:FindFirstChild("Off")
			local v61 = v58:FindFirstChild("On")
			if v60 and v60:IsA("GuiButton") then
				v60.MouseButton1Click:Connect(v59)
			end
			if v61 and v61:IsA("GuiButton") then
				v61.MouseButton1Click:Connect(v59)
			end
		end
	end
end
local function v_u_73(p_u_63)
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_20, (copy) v_u_8, (ref) v_u_18, (copy) v_u_11
	local v_u_64 = v_u_5:GetBoss(p_u_63)
	if v_u_64 then
		local v65 = v_u_15:FindFirstChild(v_u_64.uiFrameName)
		if v65 then
			local v66 = v65:FindFirstChild(v65.Name)
			if v66 then
				if not v66:IsA("Frame") then
					v66 = v65
				end
			else
				v66 = v65
			end
			if v65:GetAttribute("Connected") then
				return
			else
				v65:SetAttribute("Connected", true)
				local v67 = v66:FindFirstChild("Spawn")
				if v67 then
					local v68 = v67:FindFirstChild("Spawn")
					local v69 = v67:FindFirstChild("AutoSpawn")
					local v70 = v69 and v69:FindFirstChild("Holder")
					if v70 then
						v70 = v69.Holder:FindFirstChild("Checkmark")
					end
					local v71
					if v70 then
						v71 = v70:FindFirstChild("Icon")
					else
						v71 = v70
					end
					if v71 then
						v71.Visible = false
					end
					if v68 and v68:IsA("GuiButton") then
						v68.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_20, (copy) p_u_63, (copy) v_u_64, (ref) v_u_8, (ref) v_u_18
							local v72 = os.clock()
							if v_u_20[p_u_63] and v72 < v_u_20[p_u_63] then
								return
							else
								v_u_20[p_u_63] = v72 + 2
								if v_u_64.hasDifficulty then
									v_u_8:FireServer(p_u_63, v_u_18)
								else
									v_u_8:FireServer(p_u_63)
								end
							end
						end)
					end
					if v70 and v70:IsA("GuiButton") then
						v70.MouseButton1Click:Connect(function()
							-- upvalues: (copy) v_u_64, (ref) v_u_11, (copy) p_u_63, (ref) v_u_18
							if v_u_64.hasDifficulty then
								v_u_11:FireServer(p_u_63, v_u_18)
							else
								v_u_11:FireServer(p_u_63)
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
local function v75()
	-- upvalues: (copy) v_u_62, (copy) v_u_5, (copy) v_u_73, (copy) v_u_40, (copy) v_u_48
	v_u_62()
	for v74, _ in pairs(v_u_5:GetAllBosses()) do
		v_u_73(v74)
	end
	v_u_40()
	v_u_48()
end
v10.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_54
	v_u_54()
end)
v9.OnClientEvent:Connect(function(p76, p77)
	-- upvalues: (copy) v_u_56, (copy) v_u_6
	if p76 then
		v_u_56()
	else
		v_u_6:Show("Quest", {
			["message"] = p77
		})
	end
end)
v12.OnClientEvent:Connect(function(p78)
	-- upvalues: (ref) v_u_19, (copy) v_u_53
	v_u_19 = p78
	v_u_53()
end)
local v79 = v14:FindFirstChild("CloseButtonFrame")
local v80 = v79 and v79:FindFirstChild("CloseButton")
if v80 then
	v80.MouseButton1Click:Connect(v_u_56)
end
v_u_13.Visible = false
v75()