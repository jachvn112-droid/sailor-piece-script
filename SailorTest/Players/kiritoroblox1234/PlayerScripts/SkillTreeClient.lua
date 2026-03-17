local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("StarterGui")
local v5 = game:GetService("RunService")
local v_u_6 = v1.LocalPlayer
local v7 = v_u_6:WaitForChild("PlayerGui")
local v_u_8 = require(v2:WaitForChild("Modules"):WaitForChild("SkillTreeConfig"))
local v9 = v2:WaitForChild("RemoteEvents")
local v10 = v9:WaitForChild("OpenSkillTreeUI")
local v_u_11 = v9:WaitForChild("SkillTreeUnlock")
local v_u_12 = v9:WaitForChild("SkillTreeUpgrade")
local v_u_13 = v9:WaitForChild("SkillTreeReset")
local v14 = v9:WaitForChild("SkillTreeUpdate")
local v15 = v9:WaitForChild("SkillTreeShowConfirm")
local v_u_16 = v9:WaitForChild("GetSkillTreeData")
local v_u_17 = v7:WaitForChild("SkillTreeUI")
v_u_17.ResetOnSpawn = false
local v_u_18 = v_u_17:WaitForChild("MainGUI")
local v19 = v_u_18:WaitForChild("SkillTree")
local v_u_20 = v19:WaitForChild("Branches")
local v21 = v19:WaitForChild("SkillpointsFrame")
local v_u_22 = v21:WaitForChild("SkillpointsFrame"):WaitForChild("TreeSkillPointsAmountYouCurrentlyHave")
local v23 = v21:WaitForChild("ButtonFrame"):WaitForChild("ResetTreeButtonAndGainSkillPointsBackAndResetNodesIfAny")
local v24 = v_u_18:WaitForChild("CloseButtonFrameHolder"):WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_25 = false
local v_u_26 = false
local v_u_27 = {
	["Unlocked"] = false,
	["SkillPoints"] = 0,
	["TotalNPCKills"] = 0,
	["Nodes"] = {}
}
local v_u_28 = nil
local v_u_29 = 0
local function v_u_38(p_u_30, p31)
	local v_u_32 = nil
	local v_u_33 = false
	task.spawn(function()
		-- upvalues: (copy) p_u_30, (ref) v_u_32, (ref) v_u_33
		local v34, v35 = pcall(function()
			-- upvalues: (ref) p_u_30
			return p_u_30:InvokeServer()
		end)
		if v34 then
			v_u_32 = v35
		end
		v_u_33 = true
	end)
	local v36 = v_u_32
	local v37 = 0
	while not v_u_33 and v37 < p31 do
		task.wait(0.1)
		v37 = v37 + 0.1
	end
	return v36, v_u_33
end
local function v_u_44(p39)
	local v40 = p39:FindFirstChild("On")
	local v41 = p39:FindFirstChild("Off")
	if v40 and v41 then
		return v40, v41
	end
	for _, v42 in ipairs(p39:GetChildren()) do
		if v42:IsA("GuiObject") then
			local v43 = v42.Name
			if v43:find("IsUnlocked") or v43:find("Activated") and not (v43:find("Isn") or v43:find("n\'t")) then
				v40 = v42
			elseif v43:find("IsLocked") or (v43:find("Isn\'t") or v43:find("n\'t")) then
				v41 = v42
			end
		end
	end
	return v40, v41
end
local v_u_45 = {}
local v_u_46 = nil
local v_u_47 = nil
local function v51()
	-- upvalues: (copy) v_u_45, (ref) v_u_47, (ref) v_u_46
	local v48 = v_u_45.Damage
	if not (v48 and v48.nodes[1]) then
		return
	end
	local v49 = v48.nodes[1]
	for _, v50 in ipairs(v49:GetChildren()) do
		if v50:IsA("Frame") and v50.Name:find("NodeUnlockFrame") then
			v_u_47 = v50
			v_u_46 = v50
			v_u_46.Visible = false
			break
		end
	end
	if not v_u_47 then
		warn("[SkillTreeClient] Info panel template not found in DamageBranch Node1!")
	end
end
local function v_u_67(p52, p53)
	-- upvalues: (ref) v_u_46, (copy) v_u_8, (copy) v_u_45, (ref) v_u_27, (ref) v_u_28
	if not v_u_46 then
		return
	end
	local v54 = v_u_8.Branches[p52]
	local v55 = v54.Nodes[p53]
	local v56 = v_u_45[p52].nodes[p53]
	if not (v56 and v55) then
		return
	end
	v_u_46.Parent = v56
	v_u_46.Visible = true
	local v57 = v_u_27.Nodes[v55.Id] == true
	local v58 = v_u_46:FindFirstChild("BuffFrame")
	local v59 = v58 and v58:FindFirstChild("BuffOfThisNode")
	if v59 then
		v59.Text = "+" .. v55.Value .. "%"
	end
	local v60 = v_u_46:FindFirstChild("NameOfBuffStat")
	if v60 then
		v60.Text = v54.DisplayName
	end
	local v61 = v_u_46:FindFirstChild("ButtonFrame")
	if v61 then
		local v62 = v61:FindFirstChild("VisibleToTrueIfLocked")
		local v63 = v61:FindFirstChild("VisibleToTrueIfUnlocked")
		local v64 = nil
		for _, v65 in ipairs(v61:GetChildren()) do
			if v65:IsA("TextLabel") and v65.Name:find("ChangeNameOfLabel") then
				v64 = v65
				break
			end
		end
		if v57 then
			if v62 then
				v62.Visible = false
			end
			if v63 then
				v63.Visible = true
			end
			if v64 then
				v64.Text = "UNLOCKED"
			end
		else
			if v62 then
				v62.Visible = true
			end
			if v63 then
				v63.Visible = false
			end
			if v64 then
				v64.Text = "LOCKED (" .. v55.Cost .. " SP)"
			end
		end
	end
	local v66 = v_u_46:FindFirstChild("SelectIndicatorVisibleToTrueIfANodeIsSelectedCurrently")
	if v66 then
		v66.Visible = true
	end
	v_u_28 = {
		["branchName"] = p52,
		["nodeIdx"] = p53
	}
end
local function v_u_83()
	-- upvalues: (copy) v_u_22, (ref) v_u_27, (copy) v_u_8, (copy) v_u_45, (copy) v_u_44, (ref) v_u_28, (copy) v_u_67
	v_u_22.Text = v_u_27.SkillPoints .. " Skill Points"
	for v68, v69 in pairs(v_u_8.Branches) do
		local v70 = v_u_45[v68]
		if v70 then
			for v71, v72 in ipairs(v69.Nodes) do
				local v73 = v70.nodes[v71]
				if v73 then
					local v74 = v_u_27.Nodes[v72.Id] == true
					local v75, v76 = v_u_44(v73)
					if v75 then
						v75.Visible = v74
					end
					if v76 then
						v76.Visible = not v74
					end
				end
			end
			for v77, v78 in pairs(v70.connectors) do
				local v79 = v69.Nodes[v77]
				if v79 then
					local v80 = v_u_27.Nodes[v79.Id] == true
					local v81, v82 = v_u_44(v78)
					if v81 then
						v81.Visible = v80
					end
					if v82 then
						v82.Visible = not v80
					end
				end
			end
		end
	end
	if v_u_28 then
		v_u_67(v_u_28.branchName, v_u_28.nodeIdx)
	end
end
local function v94()
	-- upvalues: (copy) v_u_8, (copy) v_u_45, (copy) v_u_44, (ref) v_u_29, (ref) v_u_28, (ref) v_u_46, (copy) v_u_67
	for v_u_84, v85 in pairs(v_u_8.Branches) do
		local v86 = v_u_45[v_u_84]
		if v86 then
			for v_u_87, _ in ipairs(v85.Nodes) do
				local v88 = v86.nodes[v_u_87]
				if v88 then
					local v89, v90 = v_u_44(v88)
					local function v93()
						-- upvalues: (ref) v_u_29, (ref) v_u_8, (ref) v_u_28, (copy) v_u_84, (copy) v_u_87, (ref) v_u_46, (ref) v_u_67
						local v91 = tick()
						if v91 - v_u_29 < v_u_8.ButtonCooldown then
							return
						else
							v_u_29 = v91
							if v_u_28 and (v_u_28.branchName == v_u_84 and v_u_28.nodeIdx == v_u_87) then
								if v_u_46 then
									v_u_46.Visible = false
									local v92 = v_u_46:FindFirstChild("SelectIndicatorVisibleToTrueIfANodeIsSelectedCurrently")
									if v92 then
										v92.Visible = false
									end
								end
								v_u_28 = nil
							else
								v_u_67(v_u_84, v_u_87)
							end
						end
					end
					if v89 and v89:IsA("GuiButton") then
						v89.Activated:Connect(v93)
					end
					if v90 and v90:IsA("GuiButton") then
						v90.Activated:Connect(v93)
					end
				end
			end
		end
	end
end
local function v98()
	-- upvalues: (ref) v_u_46, (ref) v_u_28, (ref) v_u_29, (copy) v_u_8, (copy) v_u_12
	if v_u_46 then
		local v95 = v_u_46:FindFirstChild("ButtonFrame")
		if v95 then
			local v96 = v95:FindFirstChild("VisibleToTrueIfLocked")
			if v96 and v96:IsA("GuiButton") then
				v96.Activated:Connect(function()
					-- upvalues: (ref) v_u_28, (ref) v_u_29, (ref) v_u_8, (ref) v_u_12
					if v_u_28 then
						local v97 = tick()
						if v97 - v_u_29 >= v_u_8.ButtonCooldown then
							v_u_29 = v97
							v_u_12:FireServer(v_u_8.Branches[v_u_28.branchName].Nodes[v_u_28.nodeIdx].Id)
						end
					else
						return
					end
				end)
			end
		end
	else
		return
	end
end
v23.Activated:Connect(function()
	-- upvalues: (ref) v_u_29, (ref) v_u_46, (ref) v_u_28, (copy) v_u_13
	local v99 = tick()
	if v99 - v_u_29 >= 1 then
		v_u_29 = v99
		if v_u_46 then
			v_u_46.Visible = false
			local v100 = v_u_46:FindFirstChild("SelectIndicatorVisibleToTrueIfANodeIsSelectedCurrently")
			if v100 then
				v100.Visible = false
			end
		end
		v_u_28 = nil
		v_u_13:FireServer()
	end
end)
local function v_u_106()
	-- upvalues: (ref) v_u_25, (ref) v_u_26, (copy) v_u_6, (copy) v_u_38, (copy) v_u_16, (ref) v_u_27, (copy) v_u_18, (copy) v_u_17, (copy) v_u_4, (copy) v_u_83
	if v_u_25 or v_u_26 then
		return
	else
		local v101 = v_u_6:GetAttribute("InAbility")
		local v102 = v_u_6:GetAttribute("InCutscene")
		if v101 ~= true and v102 ~= true then
			v_u_26 = true
			local v103, _ = v_u_38(v_u_16, 5)
			if v103 then
				v_u_27 = v103
			end
			v_u_26 = false
			if not v_u_25 then
				local v104 = v_u_6:GetAttribute("InAbility")
				local v105 = v_u_6:GetAttribute("InCutscene")
				if v104 ~= true and v105 ~= true then
					v_u_25 = true
					v_u_18.Visible = true
					v_u_17.Enabled = true
					pcall(function()
						-- upvalues: (ref) v_u_4
						v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
					end)
					v_u_83()
					return
				end
			end
		end
	end
end
local function v109()
	-- upvalues: (ref) v_u_25, (copy) v_u_18, (copy) v_u_17, (ref) v_u_26, (ref) v_u_46, (ref) v_u_28, (copy) v_u_4
	local v107 = v_u_25
	v_u_18.Visible = false
	v_u_17.Enabled = false
	v_u_25 = false
	v_u_26 = false
	if v_u_46 then
		v_u_46.Visible = false
		local v108 = v_u_46:FindFirstChild("SelectIndicatorVisibleToTrueIfANodeIsSelectedCurrently")
		if v108 then
			v108.Visible = false
		end
	end
	v_u_28 = nil
	if v107 then
		pcall(function()
			-- upvalues: (ref) v_u_4
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end)
	end
end
v24.Activated:Connect(v109)
v3.InputBegan:Connect(function(p110, p111)
	-- upvalues: (ref) v_u_25, (copy) v_u_18, (copy) v_u_17, (ref) v_u_26, (ref) v_u_46, (ref) v_u_28, (copy) v_u_4
	if not p111 then
		if p110.KeyCode == Enum.KeyCode.Escape and v_u_25 then
			local v112 = v_u_25
			v_u_18.Visible = false
			v_u_17.Enabled = false
			v_u_25 = false
			v_u_26 = false
			if v_u_46 then
				v_u_46.Visible = false
				local v113 = v_u_46:FindFirstChild("SelectIndicatorVisibleToTrueIfANodeIsSelectedCurrently")
				if v113 then
					v113.Visible = false
				end
			end
			v_u_28 = nil
			if v112 then
				pcall(function()
					-- upvalues: (ref) v_u_4
					v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
				end)
			end
		end
	end
end)
local v_u_114 = v7:WaitForChild("ConfirmUI")
local v_u_115 = v_u_114:WaitForChild("MainFrame")
local v_u_116 = v_u_115:WaitForChild("ButtonsHolder")
local v_u_117 = v_u_115:WaitForChild("InfoHolder"):WaitForChild("Txt")
local v_u_118 = v_u_116:WaitForChild("Yes")
local v_u_119 = v_u_116:WaitForChild("No")
local v_u_120 = nil
local v_u_121 = nil
v15.OnClientEvent:Connect(function(p122)
	-- upvalues: (copy) v_u_8, (copy) v_u_117, (copy) v_u_116, (copy) v_u_114, (copy) v_u_115, (ref) v_u_120, (ref) v_u_121, (copy) v_u_118, (copy) v_u_11, (copy) v_u_38, (copy) v_u_16, (ref) v_u_27, (copy) v_u_106, (copy) v_u_119
	local v123 = v_u_8.UnlockDescription
	v_u_117.Text = "Unlock Skill Tree?\n\nReq: Lv. " .. p122.Level .. " & " .. p122.Gems .. " Gems\n\n" .. v123
	local v124 = v_u_116:FindFirstChild("Input")
	if v124 then
		v124.Visible = false
	end
	v_u_114.Enabled = true
	v_u_115.Visible = true
	if v_u_120 then
		v_u_120:Disconnect()
		v_u_120 = nil
	end
	if v_u_121 then
		v_u_121:Disconnect()
		v_u_121 = nil
	end
	task.wait(0.1)
	v_u_120 = v_u_118.Activated:Connect(function()
		-- upvalues: (ref) v_u_120, (ref) v_u_11, (ref) v_u_115, (ref) v_u_114, (ref) v_u_121, (ref) v_u_38, (ref) v_u_16, (ref) v_u_27, (ref) v_u_106
		if v_u_120 then
			v_u_11:FireServer()
			v_u_115.Visible = false
			v_u_114.Enabled = false
			if v_u_120 then
				v_u_120:Disconnect()
				v_u_120 = nil
			end
			if v_u_121 then
				v_u_121:Disconnect()
				v_u_121 = nil
			end
			task.wait(0.5)
			local v125, _ = v_u_38(v_u_16, 5)
			if v125 and v125.Unlocked then
				v_u_27 = v125
				v_u_106()
			end
		end
	end)
	v_u_121 = v_u_119.Activated:Connect(function()
		-- upvalues: (ref) v_u_115, (ref) v_u_114, (ref) v_u_120, (ref) v_u_121
		v_u_115.Visible = false
		v_u_114.Enabled = false
		if v_u_120 then
			v_u_120:Disconnect()
			v_u_120 = nil
		end
		if v_u_121 then
			v_u_121:Disconnect()
			v_u_121 = nil
		end
	end)
end)
v10.OnClientEvent:Connect(v_u_106)
v14.OnClientEvent:Connect(function(p126)
	-- upvalues: (ref) v_u_27, (ref) v_u_25, (copy) v_u_83
	if p126 then
		v_u_27 = p126
		if v_u_25 then
			v_u_83()
		end
	end
end)
v_u_18.Visible = false
v_u_17.Enabled = false
(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_20, (copy) v_u_45
	for v127, v128 in pairs(v_u_8.UIMapping) do
		local v129 = v_u_20
		for _, v130 in ipairs(v128:split(".")) do
			v129 = v129:FindFirstChild(v130)
			if not v129 then
				break
			end
		end
		if v129 then
			local v131 = v129:FindFirstChild("Holder")
			if v131 then
				local v132 = #v_u_8.Branches[v127].Nodes
				local v133 = {}
				local v134 = {}
				for v135 = 1, v132 do
					local v136 = v131:FindFirstChild("Node" .. v135)
					if v136 then
						v133[v135] = v136
					end
				end
				local v137 = {}
				for _, v138 in ipairs(v131:GetChildren()) do
					if v138:IsA("Frame") and (v138.Name:sub(1, 1) == "D" and v138.Name ~= "D") then
						table.insert(v137, v138)
					end
				end
				table.sort(v137, function(p139, p140)
					return p139.LayoutOrder < p140.LayoutOrder
				end)
				local v141 = #v137
				for v142 = 1, math.min(v141, v132) do
					v134[v142] = v137[v142]
				end
				v_u_45[v127] = {
					["nodes"] = v133,
					["connectors"] = v134,
					["frame"] = v129,
					["holder"] = v131
				}
			end
		else
			warn("[SkillTreeClient] Branch UI not found: " .. v128)
		end
	end
end)()
v51()
v94()
v98()
v5.Heartbeat:Connect(function()
	-- upvalues: (ref) v_u_25, (copy) v_u_17, (copy) v_u_18, (ref) v_u_26, (ref) v_u_46, (ref) v_u_28, (copy) v_u_4
	if v_u_25 then
		if not (v_u_17.Enabled and v_u_18.Visible) then
			local v143 = v_u_25
			v_u_18.Visible = false
			v_u_17.Enabled = false
			v_u_25 = false
			v_u_26 = false
			if v_u_46 then
				v_u_46.Visible = false
				local v144 = v_u_46:FindFirstChild("SelectIndicatorVisibleToTrueIfANodeIsSelectedCurrently")
				if v144 then
					v144.Visible = false
				end
			end
			v_u_28 = nil
			if v143 then
				pcall(function()
					-- upvalues: (ref) v_u_4
					v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
				end)
			end
		end
	elseif v_u_17.Enabled then
		v_u_17.Enabled = false
	end
end)
v_u_6.CharacterRemoving:Connect(function()
	-- upvalues: (ref) v_u_26, (ref) v_u_25, (copy) v_u_18, (copy) v_u_17, (ref) v_u_46, (ref) v_u_28, (copy) v_u_4
	v_u_26 = false
	local v145 = v_u_25
	v_u_18.Visible = false
	v_u_17.Enabled = false
	v_u_25 = false
	v_u_26 = false
	if v_u_46 then
		v_u_46.Visible = false
		local v146 = v_u_46:FindFirstChild("SelectIndicatorVisibleToTrueIfANodeIsSelectedCurrently")
		if v146 then
			v146.Visible = false
		end
	end
	v_u_28 = nil
	if v145 then
		pcall(function()
			-- upvalues: (ref) v_u_4
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end)
	end
end)