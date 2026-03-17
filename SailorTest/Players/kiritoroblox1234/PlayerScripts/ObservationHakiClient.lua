local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = v_u_1.LocalPlayer
local v6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = v_u_5.Character or v_u_5.CharacterAdded:Wait()
local v_u_8 = require(v2:WaitForChild("Modules"):WaitForChild("ObservationHakiConfig"))
local v_u_9 = require(v2:WaitForChild("Modules"):WaitForChild("HakiColorConfig"))
local v_u_10 = require(v2:WaitForChild("Modules"):WaitForChild("SoundManager"))
local v_u_11 = require(v2:WaitForChild("CooldownUIManager"))
local v12 = v2:WaitForChild("RemoteEvents")
local v_u_13 = v12:WaitForChild("ObservationHakiRemote")
local v14 = v12:WaitForChild("ObservationHakiStateUpdate")
local v15 = v12:WaitForChild("ObservationHakiProgressionUpdate")
local v16 = v12:WaitForChild("ObservationHakiDodgeEvent")
local v_u_17 = false
local v_u_18 = false
local v_u_19 = 0
local v_u_20 = 0
local v_u_21 = 5
local v_u_22 = {}
local v_u_23 = v_u_9.DefaultColor
local v_u_24 = false
local v_u_25 = {}
local v_u_26 = 1
local v_u_27 = 0
local v_u_28 = 50
local v29 = v6:WaitForChild("StatsPanelUI")
local v_u_30 = v6:WaitForChild("DodgeCounterUI"):WaitForChild("MainFrame")
local v_u_31 = v_u_30:WaitForChild("DodgeText")
local v_u_32 = v29:WaitForChild("MainFrame"):WaitForChild("Frame"):WaitForChild("Content"):WaitForChild("Page2"):WaitForChild("StatsHolder"):WaitForChild("ObservationHakiProgressionFrame")
local v_u_33 = v_u_32:WaitForChild("Loader"):WaitForChild("Holder"):WaitForChild("Loader")
local v34 = v_u_32:WaitForChild("Txts")
local v_u_35 = v34:WaitForChild("ObservationHakiLevel")
local v_u_36 = v34:WaitForChild("ObservationHakiExperience")
local function v_u_40(p37)
	if not p37 or p37 == 0 then
		return "0"
	end
	local v38 = math.abs(p37)
	if v38 >= 1000000 then
		return string.format("%.1fM", v38 / 1000000):gsub("%.0M", "M")
	end
	if v38 >= 1000 then
		return string.format("%.1fK", v38 / 1000):gsub("%.0K", "K")
	end
	local v39 = math.floor(v38)
	return tostring(v39)
end
local function v_u_44()
	-- upvalues: (copy) v_u_8, (ref) v_u_26, (copy) v_u_35, (copy) v_u_36, (copy) v_u_40, (ref) v_u_27, (ref) v_u_28, (copy) v_u_4, (copy) v_u_33
	local v41 = v_u_8.Progression.MaxLevel <= v_u_26
	v_u_35.Text = "Obs. Haki Lv. " .. v_u_26 .. (v41 and " (MAX)" or "")
	v_u_36.Text = v41 and "MAX LEVEL" or v_u_40(v_u_27) .. " / " .. v_u_40(v_u_28) .. " XP"
	local v42 = v41 and 1 or (v_u_28 > 0 and v_u_27 / v_u_28 or 0)
	local v43 = math.clamp(v42, 0, 1)
	v_u_4:Create(v_u_33, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
		["Size"] = UDim2.new(v43, 0, 1, 0)
	}):Play()
end
v_u_32.Visible = false
local function v_u_49(p45)
	-- upvalues: (copy) v_u_5, (copy) v_u_22
	local v46 = v_u_5.Character
	if v46 then
		v46 = v_u_5.Character.Name
	end
	if v46 and v_u_22[v46] then
		for _, v47 in ipairs(v_u_22[v46]) do
			if v47 and v47.Parent then
				if v47:IsA("Attachment") then
					for _, v48 in ipairs(v47:GetChildren()) do
						if v48:IsA("ParticleEmitter") and v48 then
							if v48:IsA("ParticleEmitter") then
								v48.Color = ColorSequence.new(p45)
							end
						end
					end
				elseif v47:IsA("Beam") and v47 then
					if v47:IsA("Beam") then
						v47.Color = ColorSequence.new(p45)
					end
				end
			end
		end
	end
end
local function v_u_61(p_u_50, p51)
	-- upvalues: (copy) v_u_25, (copy) v_u_9
	if not (v_u_25[p_u_50] and v_u_25[p_u_50].running) then
		v_u_25[p_u_50] = {
			["running"] = true,
			["vfx"] = p51
		}
		task.spawn(function()
			-- upvalues: (ref) v_u_9, (ref) v_u_25, (copy) p_u_50
			local v52 = v_u_9.Rainbow.Colors
			local v53 = v_u_9.Rainbow.CycleSpeed
			local v54 = 1
			while v_u_25[p_u_50] and v_u_25[p_u_50].running do
				local v55 = v52[v54]
				v54 = v54 % #v52 + 1
				local v56 = v52[v54]
				local v57 = tick()
				while tick() - v57 < v53 and (v_u_25[p_u_50] and v_u_25[p_u_50].running) do
					local v58 = v55:Lerp(v56, (tick() - v57) / v53)
					for _, v59 in ipairs(v_u_25[p_u_50].vfx or {}) do
						if v59 and v59.Parent then
							if v59:IsA("Attachment") then
								for _, v60 in ipairs(v59:GetChildren()) do
									if v60:IsA("ParticleEmitter") then
										v60.Color = ColorSequence.new(v58)
									end
								end
							elseif v59:IsA("Beam") then
								v59.Color = ColorSequence.new(v58)
							end
						end
					end
					task.wait(0.03)
				end
			end
		end)
	end
end
local v_u_62 = _G.UpdateHakiColor
function _G.UpdateHakiColor(p63)
	-- upvalues: (copy) v_u_62, (ref) v_u_23, (ref) v_u_17, (copy) v_u_9, (ref) v_u_24, (copy) v_u_49
	if v_u_62 then
		v_u_62(p63)
	end
	v_u_23 = p63
	if v_u_17 then
		if v_u_9.IsRainbow(p63) then
			if not v_u_24 then
				v_u_24 = true
				task.spawn(function()
					-- upvalues: (ref) v_u_9, (ref) v_u_24, (ref) v_u_17, (ref) v_u_23, (ref) v_u_49
					local v64 = v_u_9.Rainbow.Colors
					local v65 = v_u_9.Rainbow.CycleSpeed
					local v66 = 1
					while v_u_24 and (v_u_17 and v_u_9.IsRainbow(v_u_23)) do
						local v67 = v64[v66]
						v66 = v66 % #v64 + 1
						local v68 = v64[v66]
						local v69 = tick()
						while tick() - v69 < v65 and (v_u_24 and v_u_17) do
							v_u_49((v67:Lerp(v68, (tick() - v69) / v65)))
							task.wait(0.03)
						end
					end
					v_u_24 = false
				end)
			end
		end
		v_u_24 = false
		local v70 = v_u_9.GetColor3(p63)
		if v70 then
			v_u_49(v70)
		end
	end
end
local function v_u_98(p71, p72)
	-- upvalues: (copy) v_u_5, (copy) v_u_22, (ref) v_u_23, (copy) v_u_9, (ref) v_u_24, (ref) v_u_17, (copy) v_u_49, (copy) v_u_1, (copy) v_u_61
	if p71 then
		local v73 = p71.Name
		local v74 = p71 == v_u_5.Character
		if v_u_22[v73] then
			for _, v75 in ipairs(v_u_22[v73]) do
				if v75 and v75.Parent then
					v75:Destroy()
				end
			end
			v_u_22[v73] = nil
		end
		local v76 = p71:FindFirstChild("Head")
		if v76 then
			local v77 = workspace:FindFirstChild("ObsHakiIsInHead")
			if v77 then
				local v78 = v77:FindFirstChild("Head")
				if v78 then
					v_u_22[v73] = {}
					local v79 = p72 or (v_u_23 or v_u_9.DefaultColor)
					local v80 = v_u_9.IsRainbow(v79)
					local v81
					if v80 then
						v81 = nil
					else
						v81 = v_u_9.GetColor3(v79) or nil
					end
					local v82 = {}
					for _, v83 in ipairs(v78:GetChildren()) do
						if v83:IsA("Attachment") then
							local v84 = Instance.new("Attachment")
							v84.Name = v83.Name .. "_ObsHaki"
							v84.CFrame = v83.CFrame
							v84.Parent = v76
							v82[v83] = v84
							local v85 = v_u_22[v73]
							table.insert(v85, v84)
							for _, v86 in ipairs(v83:GetChildren()) do
								if v86:IsA("ParticleEmitter") then
									local v87 = v86:Clone()
									if v81 and not v80 then
										v87.Color = ColorSequence.new(v81)
									end
									v87.Parent = v84
								end
							end
						end
					end
					for _, v88 in ipairs(v78:GetChildren()) do
						if v88:IsA("Beam") then
							local v89 = v88:Clone()
							v89.Name = v88.Name .. "_ObsHaki"
							if v88.Attachment0 and v82[v88.Attachment0] then
								v89.Attachment0 = v82[v88.Attachment0]
							end
							if v88.Attachment1 and v82[v88.Attachment1] then
								v89.Attachment1 = v82[v88.Attachment1]
							end
							if v81 and not v80 then
								v89.Color = ColorSequence.new(v81)
							end
							v89.Parent = v76
							local v90 = v_u_22[v73]
							table.insert(v90, v89)
						end
					end
					if v74 then
						if v80 then
							if not v_u_24 then
								v_u_24 = true
								task.spawn(function()
									-- upvalues: (ref) v_u_9, (ref) v_u_24, (ref) v_u_17, (ref) v_u_23, (ref) v_u_49
									local v91 = v_u_9.Rainbow.Colors
									local v92 = v_u_9.Rainbow.CycleSpeed
									local v93 = 1
									while v_u_24 and (v_u_17 and v_u_9.IsRainbow(v_u_23)) do
										local v94 = v91[v93]
										v93 = v93 % #v91 + 1
										local v95 = v91[v93]
										local v96 = tick()
										while tick() - v96 < v92 and (v_u_24 and v_u_17) do
											v_u_49((v94:Lerp(v95, (tick() - v96) / v92)))
											task.wait(0.03)
										end
									end
									v_u_24 = false
								end)
							end
						end
					else
						local v97 = v_u_1:GetPlayerFromCharacter(p71)
						if v97 and v80 then
							v_u_61(v97.UserId, v_u_22[v73])
						end
					end
				end
			else
				warn("[ObsHakiClient] VFX model \'ObsHakiIsInHead\' not found")
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_105(p99)
	-- upvalues: (copy) v_u_22, (copy) v_u_1, (copy) v_u_5, (copy) v_u_25
	if p99 then
		local v100 = p99.Name
		local v101 = v_u_22[v100]
		local v102 = v_u_1:GetPlayerFromCharacter(p99)
		if v102 and v102 ~= v_u_5 then
			local v103 = v102.UserId
			if v_u_25[v103] then
				v_u_25[v103].running = false
				v_u_25[v103] = nil
			end
		end
		if v101 then
			for _, v104 in ipairs(v101) do
				if v104 and v104.Parent then
					v104:Destroy()
				end
			end
			v_u_22[v100] = nil
		end
	end
end
v3.InputBegan:Connect(function(p106, p107)
	-- upvalues: (copy) v_u_8, (ref) v_u_18, (ref) v_u_19, (copy) v_u_13
	if not p107 then
		if p106.KeyCode == v_u_8.Ability.KeyCode then
			if not v_u_18 then
				return
			end
			local v108 = tick()
			if v108 - v_u_19 < 0.5 then
				return
			end
			v_u_19 = v108
			v_u_13:FireServer("Toggle")
		end
	end
end)
v_u_13.OnClientEvent:Connect(function(p109, p110)
	-- upvalues: (ref) v_u_17, (ref) v_u_20, (ref) v_u_21, (copy) v_u_5, (ref) v_u_23, (copy) v_u_98, (copy) v_u_10, (copy) v_u_31, (copy) v_u_30, (ref) v_u_24, (copy) v_u_105, (copy) v_u_11, (ref) v_u_18, (copy) v_u_9, (ref) v_u_26, (ref) v_u_27, (ref) v_u_28, (copy) v_u_8, (copy) v_u_32, (copy) v_u_44
	if p109 == "Activated" then
		v_u_17 = true
		v_u_20 = p110.dodges or 5
		v_u_21 = p110.dodges or 5
		local v111 = p110.hakiColor or (v_u_5:GetAttribute("HakiColor") or v_u_23)
		v_u_23 = v111
		v_u_98(v_u_5.Character, v111)
		v_u_10:Play("ObservationHaki")
		v_u_31.Text = ": Dodge Left " .. v_u_20 .. "/" .. v_u_21
		v_u_30.Visible = true
	elseif p109 == "Deactivated" then
		v_u_17 = false
		v_u_20 = 0
		v_u_24 = false
		v_u_105(v_u_5.Character)
		v_u_30.Visible = false
		if p110 and (p110.cooldown and p110.cooldown > 0) then
			v_u_11:StartCooldown("ObsHaki", "Observation", "H", p110.cooldown)
			return
		end
	elseif p109 == "Status" then
		v_u_18 = p110.hasObsHaki or false
		v_u_17 = p110.isActive or false
		v_u_20 = p110.dodgesRemaining or 0
		v_u_21 = p110.dodgesAtLevel or 5
		local v112 = v_u_5:GetAttribute("HakiColor") or (p110.hakiColor or v_u_9.DefaultColor)
		v_u_23 = v112
		if p110.progression then
			v_u_26 = p110.progression.Level
			v_u_27 = p110.progression.XP
			v_u_28 = v_u_8.GetXPForLevel(v_u_26)
		end
		v_u_32.Visible = v_u_18
		v_u_44()
		if v_u_17 then
			v_u_98(v_u_5.Character, v112)
			v_u_31.Text = ": Dodge Left " .. v_u_20 .. "/" .. v_u_21
			v_u_30.Visible = true
		else
			v_u_30.Visible = false
		end
		if p110.cooldownRemaining and p110.cooldownRemaining > 0 then
			v_u_11:StartCooldown("ObsHaki", "Observation", "H", p110.cooldownRemaining)
			return
		end
	elseif p109 == "PurchaseSuccess" then
		v_u_18 = true
		v_u_32.Visible = true
		v_u_26 = 1
		v_u_27 = 0
		v_u_28 = v_u_8.GetXPForLevel(1)
		v_u_44()
	end
end)
v15.OnClientEvent:Connect(function(p113)
	-- upvalues: (ref) v_u_26, (ref) v_u_27, (ref) v_u_28, (ref) v_u_21, (copy) v_u_44
	if p113 then
		v_u_26 = p113.level
		v_u_27 = p113.xp
		v_u_28 = p113.xpRequired
		v_u_21 = p113.dodgesAtLevel or v_u_21
		v_u_44()
	end
end)
v14.OnClientEvent:Connect(function(p114, p115, p116, p117)
	-- upvalues: (copy) v_u_5, (ref) v_u_17, (ref) v_u_20, (ref) v_u_23, (copy) v_u_98, (copy) v_u_31, (ref) v_u_21, (copy) v_u_30, (ref) v_u_24, (copy) v_u_105, (copy) v_u_9, (copy) v_u_25
	if p114 == v_u_5 then
		v_u_17 = p115
		v_u_20 = p116 or 0
		local v118 = v_u_5:GetAttribute("HakiColor") or (p117 or v_u_23)
		v_u_23 = v118
		if p115 then
			v_u_98(v_u_5.Character, v118)
			v_u_31.Text = ": Dodge Left " .. v_u_20 .. "/" .. v_u_21
			v_u_30.Visible = true
		else
			v_u_24 = false
			v_u_105(v_u_5.Character)
			v_u_30.Visible = false
		end
	elseif not v_u_5:GetAttribute("DisableOtherVFX") then
		local v119 = p114.Character
		if v119 then
			if p115 then
				v_u_98(v119, p114:GetAttribute("HakiColor") or (p117 or v_u_9.DefaultColor))
				return
			end
			local v120 = p114.UserId
			if v_u_25[v120] then
				v_u_25[v120].running = false
				v_u_25[v120] = nil
			end
			v_u_105(v119)
		end
	end
end)
v16.OnClientEvent:Connect(function(p121)
	-- upvalues: (ref) v_u_20, (copy) v_u_31, (ref) v_u_21
	v_u_20 = p121
	v_u_31.Text = ": Dodge Left " .. v_u_20 .. "/" .. v_u_21
end)
local function v123(p122)
	-- upvalues: (ref) v_u_7, (copy) v_u_22, (ref) v_u_24, (copy) v_u_30, (copy) v_u_13
	v_u_7 = p122
	v_u_22[p122.Name] = nil
	v_u_24 = false
	v_u_30.Visible = false
	task.wait(0.5)
	v_u_13:FireServer("GetStatus")
end
v_u_5.CharacterAdded:Connect(v123)
task.spawn(function()
	-- upvalues: (copy) v_u_5, (ref) v_u_23, (copy) v_u_13
	task.wait(1)
	local v124 = v_u_5:GetAttribute("HakiColor")
	if v124 then
		v_u_23 = v124
	end
	v_u_13:FireServer("GetStatus")
end)