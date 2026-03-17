local v1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
game:GetService("Debris")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = v1.LocalPlayer
local v6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = v_u_5.Character or v_u_5.CharacterAdded:Wait()
local v_u_8 = require(v_u_2:WaitForChild("Modules"):WaitForChild("HakiConfig"))
local v_u_9 = require(v_u_2:WaitForChild("Modules"):WaitForChild("HakiColorConfig"))
local v_u_10 = require(v_u_2:WaitForChild("Modules"):WaitForChild("SoundManager"))
local v11 = v_u_2:WaitForChild("RemoteEvents")
local v_u_12 = v11:WaitForChild("HakiRemote")
local v13 = v11:WaitForChild("HakiStateUpdate")
local v14 = v11:WaitForChild("HakiProgressionUpdate")
local v_u_15 = false
local v_u_16 = false
local v_u_17 = 0
local v_u_18 = {
	["leftArm"] = {},
	["rightArm"] = {}
}
local v_u_19 = {}
local v_u_20 = "Pink"
local v_u_21 = false
local v_u_22 = {}
local v_u_23 = 1
local v_u_24 = 0
local v_u_25 = 100
local v26 = v6:WaitForChild("StatsPanelUI"):WaitForChild("MainFrame"):WaitForChild("Frame"):WaitForChild("Content")
local v_u_27 = v26:WaitForChild("InfoFrame")
local v_u_28 = v26:WaitForChild("SideFrame")
local v_u_29 = v26:WaitForChild("StatsFrame")
local v_u_30 = v26:WaitForChild("Page2")
local v31 = v_u_28:WaitForChild("Holder"):WaitForChild("Info")
local v32 = v_u_30:WaitForChild("BackButton")
local v_u_33 = v_u_30:WaitForChild("StatsHolder"):WaitForChild("HakiProgressionFrame")
local v_u_34 = v_u_33:WaitForChild("Loader"):WaitForChild("Holder"):WaitForChild("Loader")
local v35 = v_u_33:WaitForChild("Txts")
local v_u_36 = v35:WaitForChild("HakiLevel")
local v_u_37 = v35:WaitForChild("HakiExperience")
local v_u_38 = false
local function v39()
	-- upvalues: (ref) v_u_38, (copy) v_u_27, (copy) v_u_28, (copy) v_u_29, (copy) v_u_30, (ref) v_u_16, (copy) v_u_12
	v_u_38 = true
	v_u_27.Visible = false
	v_u_28.Visible = false
	v_u_29.Visible = false
	v_u_30.Visible = true
	if v_u_16 then
		v_u_12:FireServer("GetProgression")
	end
end
local function v40()
	-- upvalues: (ref) v_u_38, (copy) v_u_27, (copy) v_u_28, (copy) v_u_29, (copy) v_u_30
	v_u_38 = false
	v_u_27.Visible = true
	v_u_28.Visible = true
	v_u_29.Visible = true
	v_u_30.Visible = false
end
v31.MouseButton1Click:Connect(v39)
v32.MouseButton1Click:Connect(v40)
local function v_u_44(p41)
	if not p41 or p41 == 0 then
		return "0"
	end
	local v42 = math.abs(p41)
	if v42 >= 1000000 then
		return string.format("%.1fM", v42 / 1000000):gsub("%.0M", "M")
	end
	if v42 >= 1000 then
		return string.format("%.1fK", v42 / 1000):gsub("%.0K", "K")
	end
	local v43 = math.floor(v42)
	return tostring(v43)
end
local function v_u_48()
	-- upvalues: (copy) v_u_8, (ref) v_u_23, (copy) v_u_36, (copy) v_u_37, (copy) v_u_44, (ref) v_u_24, (ref) v_u_25, (copy) v_u_4, (copy) v_u_34
	local v45 = v_u_8.Progression.MaxLevel <= v_u_23
	v_u_36.Text = "Haki Lv. " .. v_u_23 .. (v45 and " (MAX)" or "")
	v_u_37.Text = v45 and "MAX LEVEL" or v_u_44(v_u_24) .. " / " .. v_u_44(v_u_25) .. " XP"
	local v46 = v45 and 1 or (v_u_25 > 0 and v_u_24 / v_u_25 or 0)
	local v47 = math.clamp(v46, 0, 1)
	v_u_4:Create(v_u_34, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
		["Size"] = UDim2.new(v47, 0, 1, 0)
	}):Play()
end
v_u_33.Visible = false
v_u_30.Visible = false
local function v_u_54()
	-- upvalues: (copy) v_u_5
	local v49 = v_u_5.Character
	if not v49 then
		return nil, nil
	end
	local v50 = v49:FindFirstChild("Left Arm") or v49:FindFirstChild("LeftLowerArm")
	local v51 = v49:FindFirstChild("Right Arm") or v49:FindFirstChild("RightLowerArm")
	local v52 = v49:FindFirstChild("LeftUpperArm")
	local v53 = v49:FindFirstChild("RightUpperArm")
	return { v50, v52, (v49:FindFirstChild("LeftHand")) }, { v51, v53, (v49:FindFirstChild("RightHand")) }
end
local function v_u_61()
	-- upvalues: (copy) v_u_5, (ref) v_u_19, (copy) v_u_54
	if v_u_5.Character then
		v_u_19 = {}
		local v55, v56 = v_u_54()
		local v57 = {}
		if v55 then
			for _, v58 in ipairs(v55) do
				if v58 then
					table.insert(v57, v58)
				end
			end
		end
		if v56 then
			for _, v59 in ipairs(v56) do
				if v59 then
					table.insert(v57, v59)
				end
			end
		end
		for _, v60 in ipairs(v57) do
			if v60:IsA("BasePart") then
				v_u_19[v60] = v60.Color
			end
		end
	end
end
local function v_u_64(p62)
	-- upvalues: (ref) v_u_19, (copy) v_u_4
	for v63, _ in pairs(v_u_19) do
		if v63 and v63.Parent then
			v_u_4:Create(v63, TweenInfo.new(0.2), {
				["Color"] = p62
			}):Play()
		end
	end
end
local function v_u_67()
	-- upvalues: (ref) v_u_19, (copy) v_u_4
	for v65, v66 in pairs(v_u_19) do
		if v65 and v65.Parent then
			v_u_4:Create(v65, TweenInfo.new(0.2), {
				["Color"] = v66
			}):Play()
		end
	end
end
local function v_u_71(p68)
	-- upvalues: (ref) v_u_18
	for _, v69 in ipairs(v_u_18.leftArm) do
		if v69 and (v69.Parent and v69) then
			if v69:IsA("ParticleEmitter") then
				v69.Color = ColorSequence.new(p68)
			end
		end
	end
	for _, v70 in ipairs(v_u_18.rightArm) do
		if v70 and (v70.Parent and v70) then
			if v70:IsA("ParticleEmitter") then
				v70.Color = ColorSequence.new(p68)
			end
		end
	end
end
local function v_u_82(p_u_72, p73)
	-- upvalues: (copy) v_u_22, (copy) v_u_9
	if not (v_u_22[p_u_72] and v_u_22[p_u_72].running) then
		v_u_22[p_u_72] = {
			["running"] = true,
			["vfx"] = p73
		}
		task.spawn(function()
			-- upvalues: (ref) v_u_9, (ref) v_u_22, (copy) p_u_72
			local v74 = v_u_9.Rainbow.Colors
			local v75 = v_u_9.Rainbow.CycleSpeed
			local v76 = 1
			while v_u_22[p_u_72] and v_u_22[p_u_72].running do
				local v77 = v74[v76]
				v76 = v76 % #v74 + 1
				local v78 = v74[v76]
				local v79 = tick()
				while tick() - v79 < v75 and (v_u_22[p_u_72] and v_u_22[p_u_72].running) do
					local v80 = v77:Lerp(v78, (tick() - v79) / v75)
					for _, v81 in ipairs(v_u_22[p_u_72].vfx or {}) do
						if v81 and (v81.Parent and v81:IsA("ParticleEmitter")) then
							v81.Color = ColorSequence.new(v80)
						end
					end
					task.wait(0.03)
				end
			end
		end)
	end
end
local function v_u_90(p83, p84)
	-- upvalues: (copy) v_u_9, (ref) v_u_20
	if not (p83 and p84) then
		return {}
	end
	local v85 = v_u_9.GetColor3(v_u_20)
	local v86 = v_u_9.IsRainbow(v_u_20)
	local v87 = {}
	for _, v88 in ipairs(p84:GetChildren()) do
		if v88:IsA("ParticleEmitter") then
			local v89 = v88:Clone()
			if v85 and (not v86 and (v89 and v89:IsA("ParticleEmitter"))) then
				v89.Color = ColorSequence.new(v85)
			end
			v89.Parent = p83
			v89.Enabled = true
			table.insert(v87, v89)
		end
	end
	return v87
end
local function v98(p91)
	-- upvalues: (ref) v_u_20, (ref) v_u_15, (copy) v_u_9, (ref) v_u_21, (copy) v_u_71
	v_u_20 = p91
	if v_u_15 then
		if v_u_9.IsRainbow(p91) then
			if not v_u_21 then
				v_u_21 = true
				task.spawn(function()
					-- upvalues: (ref) v_u_9, (ref) v_u_21, (ref) v_u_15, (ref) v_u_20, (ref) v_u_71
					local v92 = v_u_9.Rainbow.Colors
					local v93 = v_u_9.Rainbow.CycleSpeed
					local v94 = 1
					while v_u_21 and (v_u_15 and v_u_9.IsRainbow(v_u_20)) do
						local v95 = v92[v94]
						v94 = v94 % #v92 + 1
						local v96 = v92[v94]
						local v97 = tick()
						while tick() - v97 < v93 and (v_u_21 and v_u_15) do
							v_u_71((v95:Lerp(v96, (tick() - v97) / v93)))
							task.wait(0.03)
						end
					end
					v_u_21 = false
				end)
			end
		end
		v_u_21 = false
		v_u_71((v_u_9.GetColor3(p91)))
	end
end
_G.UpdateHakiColor = v98
local function v_u_111()
	-- upvalues: (copy) v_u_5, (copy) v_u_61, (copy) v_u_64, (copy) v_u_8, (copy) v_u_2, (ref) v_u_18, (copy) v_u_90, (copy) v_u_9, (ref) v_u_20, (ref) v_u_21, (ref) v_u_15, (copy) v_u_71, (copy) v_u_10
	local v99 = v_u_5.Character
	if v99 then
		v_u_61()
		v_u_64(v_u_8.VFX.ArmColor)
		local v100 = v_u_2:FindFirstChild("HakiVFXAssets")
		if v100 then
			local v101 = v100:FindFirstChild("Left Arm")
			local v102 = v100:FindFirstChild("Right Arm")
			local v103 = v99:FindFirstChild("Left Arm") or v99:FindFirstChild("LeftLowerArm")
			local v104 = v99:FindFirstChild("Right Arm") or v99:FindFirstChild("RightLowerArm")
			if v103 and v101 then
				v_u_18.leftArm = v_u_90(v103, v101)
			end
			if v104 and v102 then
				v_u_18.rightArm = v_u_90(v104, v102)
			end
			if v_u_9.IsRainbow(v_u_20) and not v_u_21 then
				v_u_21 = true
				task.spawn(function()
					-- upvalues: (ref) v_u_9, (ref) v_u_21, (ref) v_u_15, (ref) v_u_20, (ref) v_u_71
					local v105 = v_u_9.Rainbow.Colors
					local v106 = v_u_9.Rainbow.CycleSpeed
					local v107 = 1
					while v_u_21 and (v_u_15 and v_u_9.IsRainbow(v_u_20)) do
						local v108 = v105[v107]
						v107 = v107 % #v105 + 1
						local v109 = v105[v107]
						local v110 = tick()
						while tick() - v110 < v106 and (v_u_21 and v_u_15) do
							v_u_71((v108:Lerp(v109, (tick() - v110) / v106)))
							task.wait(0.03)
						end
					end
					v_u_21 = false
				end)
			end
			v_u_10:Play("Haki")
		end
	else
		return
	end
end
local function v_u_114()
	-- upvalues: (ref) v_u_21, (copy) v_u_67, (ref) v_u_18
	v_u_21 = false
	v_u_67()
	for _, v112 in ipairs(v_u_18.leftArm) do
		if v112 and v112.Parent then
			v112:Destroy()
		end
	end
	for _, v113 in ipairs(v_u_18.rightArm) do
		if v113 and v113.Parent then
			v113:Destroy()
		end
	end
	v_u_18 = {
		["leftArm"] = {},
		["rightArm"] = {}
	}
end
v3.InputBegan:Connect(function(p115, p116)
	-- upvalues: (copy) v_u_8, (ref) v_u_16, (ref) v_u_15, (ref) v_u_17, (copy) v_u_12
	if not p116 then
		if p115.KeyCode == v_u_8.Ability.KeyCode then
			if not v_u_16 then
				return
			end
			local v117 = tick()
			if (v_u_15 and v_u_8.Ability.DeactivationCooldown or v_u_8.Ability.ActivationCooldown) > v117 - v_u_17 then
				return
			end
			v_u_12:FireServer("Toggle")
		end
	end
end)
v13.OnClientEvent:Connect(function(p118, p119, p120)
	-- upvalues: (ref) v_u_15, (ref) v_u_17, (copy) v_u_111, (copy) v_u_114, (copy) v_u_5, (copy) v_u_4, (copy) v_u_8, (copy) v_u_2, (copy) v_u_9, (copy) v_u_82, (copy) v_u_22
	if p118 == true or p118 == false then
		v_u_15 = p118
		v_u_17 = tick()
		if v_u_15 then
			v_u_111()
		else
			v_u_114()
		end
	else
		if typeof(p118) == "Instance" and p118:IsA("Player") then
			if p118 == v_u_5 then
				v_u_15 = p119
				v_u_17 = tick()
				if v_u_15 then
					v_u_111()
				else
					v_u_114()
				end
			end
			if v_u_5:GetAttribute("DisableOtherVFX") then
				return
			end
			local v121 = p118.Character
			local v122 = p118.UserId
			if v121 then
				if p119 then
					for _, v123 in ipairs({
						"Left Arm",
						"LeftLowerArm",
						"LeftHand",
						"Right Arm",
						"RightLowerArm",
						"RightHand"
					}) do
						local v124 = v121:FindFirstChild(v123)
						if v124 and v124:IsA("BasePart") then
							if not v124:GetAttribute("OriginalHakiColor") then
								v124:SetAttribute("OriginalHakiColor", v124.Color:ToHex())
							end
							v_u_4:Create(v124, TweenInfo.new(0.2), {
								["Color"] = v_u_8.VFX.ArmColor
							}):Play()
						end
					end
					local v125 = v_u_2:FindFirstChild("HakiVFXAssets")
					if v125 then
						local v126 = v125:FindFirstChild("Left Arm")
						local v127 = v125:FindFirstChild("Right Arm")
						local v128 = v121:FindFirstChild("Left Arm") or v121:FindFirstChild("LeftLowerArm")
						local v129 = v121:FindFirstChild("Right Arm") or v121:FindFirstChild("RightLowerArm")
						for _, v130 in ipairs({ v128, v129 }) do
							if v130 then
								for _, v131 in ipairs(v130:GetChildren()) do
									if v131:GetAttribute("HakiVFX") then
										v131:Destroy()
									end
								end
							end
						end
						local v132 = p120 or v_u_9.DefaultColor
						local v_u_133 = v_u_9.IsRainbow(v132)
						local v_u_134
						if v_u_133 then
							v_u_134 = nil
						else
							v_u_134 = v_u_9.GetColor3(v132) or nil
						end
						local v_u_135 = {}
						local function v141(p136, p137)
							-- upvalues: (copy) v_u_134, (copy) v_u_133, (copy) v_u_135
							if p136 and p137 then
								for _, v138 in ipairs(p137:GetChildren()) do
									local v139 = v138:Clone()
									v139:SetAttribute("HakiVFX", true)
									v139.Parent = p136
									if v139:IsA("ParticleEmitter") then
										v139.Enabled = true
										if v_u_134 and not v_u_133 then
											v139.Color = ColorSequence.new(v_u_134)
										end
										local v140 = v_u_135
										table.insert(v140, v139)
									end
								end
							end
						end
						v141(v128, v126)
						v141(v129, v127)
						if v_u_133 and #v_u_135 > 0 then
							v_u_82(v122, v_u_135)
							return
						end
					end
				else
					if v_u_22[v122] then
						v_u_22[v122].running = false
						v_u_22[v122] = nil
					end
					for _, v142 in ipairs({
						"Left Arm",
						"LeftLowerArm",
						"LeftHand",
						"Right Arm",
						"RightLowerArm",
						"RightHand"
					}) do
						local v143 = v121:FindFirstChild(v142)
						if v143 and v143:IsA("BasePart") then
							local v144 = v143:GetAttribute("OriginalHakiColor")
							if v144 then
								v_u_4:Create(v143, TweenInfo.new(0.2), {
									["Color"] = Color3.fromHex(v144)
								}):Play()
								v143:SetAttribute("OriginalHakiColor", nil)
							end
							for _, v145 in ipairs(v143:GetChildren()) do
								if v145:GetAttribute("HakiVFX") then
									v145:Destroy()
								end
							end
						end
					end
				end
			end
		end
		return
	end
end)
v14.OnClientEvent:Connect(function(p146)
	-- upvalues: (ref) v_u_23, (ref) v_u_24, (ref) v_u_25, (copy) v_u_48
	if p146 then
		v_u_23 = p146.level or 1
		v_u_24 = p146.xp or 0
		v_u_25 = p146.xpRequired or 100
		v_u_48()
	end
end)
v_u_12.OnClientEvent:Connect(function(p147, p148)
	-- upvalues: (ref) v_u_16, (ref) v_u_15, (ref) v_u_20, (copy) v_u_33, (copy) v_u_12, (copy) v_u_111, (ref) v_u_23, (ref) v_u_24, (ref) v_u_25, (copy) v_u_8, (copy) v_u_48
	if p147 == "Status" then
		v_u_16 = p148.hasHaki
		v_u_15 = p148.isActive
		if p148.hakiColor then
			v_u_20 = p148.hakiColor
		end
		v_u_33.Visible = v_u_16
		if v_u_16 then
			v_u_12:FireServer("GetProgression")
		end
		if v_u_15 then
			v_u_111()
			return
		end
	elseif p147 == "PurchaseSuccess" then
		v_u_16 = true
		v_u_33.Visible = true
		v_u_23 = 1
		v_u_24 = 0
		v_u_25 = v_u_8.GetXPForLevel(1)
		v_u_48()
	end
end)
local function v150(p149)
	-- upvalues: (ref) v_u_7, (ref) v_u_15, (ref) v_u_18, (ref) v_u_19, (ref) v_u_21, (copy) v_u_12
	v_u_7 = p149
	v_u_15 = false
	v_u_18 = {
		["leftArm"] = {},
		["rightArm"] = {}
	}
	v_u_19 = {}
	v_u_21 = false
	v_u_12:FireServer("GetStatus")
end
v_u_5.CharacterAdded:Connect(v150)
if v_u_5.Character then
	v150(v_u_5.Character)
end