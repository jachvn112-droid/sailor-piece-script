local v1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("Debris")
local v_u_7 = v1.LocalPlayer
local v_u_8 = v_u_2:WaitForChild("Modules")
local v_u_9 = require(v_u_8:WaitForChild("ConquerorHakiConfig"))
local v_u_10 = v_u_9.Ability.VFXDuration
local v11 = v_u_2:WaitForChild("Remotes")
local v_u_12 = v11:WaitForChild("ConquerorHakiRemote", 10)
local v13 = v11:WaitForChild("ConquerorHakiVFX", 10)
local v14 = v11:WaitForChild("ConqHakiProgressionUpdate", 10)
local v_u_15 = require(v_u_2:WaitForChild("CooldownUIManager")):Init()
local v_u_16 = nil
pcall(function()
	-- upvalues: (ref) v_u_16, (copy) v_u_8
	v_u_16 = require(v_u_8:WaitForChild("SoundManager"))
end)
local v_u_17 = nil
local v_u_18 = nil
local function v_u_35(p_u_19, p_u_20)
	-- upvalues: (copy) v_u_7, (ref) v_u_18, (copy) v_u_5
	if v_u_7:GetAttribute("DisableScreenShake") then
		return
	else
		if v_u_18 then
			v_u_18:Disconnect()
			v_u_18 = nil
		end
		local v_u_21 = workspace.CurrentCamera
		if v_u_21 then
			local v_u_22 = tick()
			local v_u_23 = nil
			v_u_23 = v_u_5.RenderStepped:Connect(function()
				-- upvalues: (copy) v_u_22, (copy) p_u_20, (ref) v_u_23, (ref) v_u_18, (copy) p_u_19, (copy) v_u_21
				local v24 = tick() - v_u_22
				if p_u_20 <= v24 then
					v_u_23:Disconnect()
					v_u_18 = nil
				else
					local v25 = v24 / p_u_20 * 3.141592653589793 * 0.5
					local v26 = p_u_19 * math.cos(v25)
					local v27 = v24 * 60 + math.random() * 100
					if v_u_21.Parent then
						local v28 = v_u_21
						local v29 = v_u_21.CFrame
						local v30 = CFrame.new
						local v31 = math.sin(v27) * v26 * 0.01
						local v32 = v27 * 0.7
						local v33 = math.sin(v32) * v26 * 0.01
						local v34 = v27 * 1.3
						v28.CFrame = v29 * v30(v31, v33, math.sin(v34) * v26 * 0.005)
					end
				end
			end)
			v_u_18 = v_u_23
		end
	end
end
local function v_u_37()
	-- upvalues: (ref) v_u_17, (copy) v_u_4, (copy) v_u_10, (copy) v_u_7, (copy) v_u_35
	if v_u_17 then
		pcall(function()
			-- upvalues: (ref) v_u_17
			v_u_17:Cancel()
		end)
	end
	local v_u_36 = workspace.CurrentCamera
	if v_u_36 then
		v_u_17 = v_u_4:Create(v_u_36, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["FieldOfView"] = 85
		})
		v_u_17:Play()
		task.delay(v_u_10, function()
			-- upvalues: (ref) v_u_17, (ref) v_u_4, (copy) v_u_36
			if v_u_17 then
				pcall(function()
					-- upvalues: (ref) v_u_17
					v_u_17:Cancel()
				end)
			end
			v_u_17 = v_u_4:Create(v_u_36, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				["FieldOfView"] = 70
			})
			v_u_17:Play()
		end)
		if not v_u_7:GetAttribute("DisableScreenShake") then
			v_u_35(30, v_u_10)
		end
	end
end
local v_u_38 = false
local v_u_39 = 0
local v_u_40 = 0
local v_u_41 = false
local v_u_42 = nil
pcall(function()
	-- upvalues: (ref) v_u_42, (copy) v_u_2
	v_u_42 = require(v_u_2:WaitForChild("HitboxVisualizer"))
end)
local function v_u_50(p43, p44)
	-- upvalues: (ref) v_u_42, (copy) v_u_9, (copy) v_u_10
	if v_u_42 then
		if v_u_9.Ability.ShowHitbox then
			local v45 = p44 * 2
			local v46 = p44 * 2
			local v47 = p44 * 2
			local v48 = Vector3.new(v45, v46, v47)
			local v49 = CFrame.new(0, 0, 0)
			v_u_42.ShowFollowingAOE(p43, v48, v_u_10, v49, nil, "Sphere")
		end
	else
		return
	end
end
local function v_u_67(p51)
	-- upvalues: (copy) v_u_2, (copy) v_u_6, (copy) v_u_10
	if p51 then
		local v_u_52 = p51:FindFirstChild("Head")
		if v_u_52 then
			local v53 = v_u_2:FindFirstChild("ConquerorHakiVFXAssests")
			if v53 then
				local v54 = v53:FindFirstChild("EyeHakiVFX")
				if v54 then
					local v55 = v54:Clone()
					local v56 = v55:FindFirstChild("Head") or v55
					local v_u_57 = {}
					local v_u_58 = {}
					local function v63(p59)
						-- upvalues: (copy) v_u_52, (copy) v_u_57, (ref) v_u_6, (ref) v_u_10
						for _, v60 in ipairs(p59:GetChildren()) do
							if v60:IsA("Attachment") or (v60:IsA("ParticleEmitter") or (v60:IsA("Beam") or v60:IsA("Light"))) then
								local v61 = v60:Clone()
								v61.Parent = v_u_52
								local v62 = v_u_57
								table.insert(v62, v61)
								v_u_6:AddItem(v61, v_u_10)
							end
						end
					end
					v63(v56)
					if v56 ~= v55 then
						v63(v55)
					end
					for _, v64 in ipairs(v_u_57) do
						if v64:IsA("ParticleEmitter") then
							v64.LockedToPart = true
							v64.Enabled = true
							table.insert(v_u_58, v64)
						end
						for _, v65 in ipairs(v64:GetDescendants()) do
							if v65:IsA("ParticleEmitter") then
								v65.LockedToPart = true
								v65.Enabled = true
								table.insert(v_u_58, v65)
							end
						end
					end
					task.delay(v_u_10 * 0.8, function()
						-- upvalues: (copy) v_u_58
						for _, v66 in ipairs(v_u_58) do
							if v66 and v66.Parent then
								v66.Enabled = false
							end
						end
					end)
					v55:Destroy()
				else
					warn("[ConquerorHakiClient] EyeHakiVFX not found in ConquerorHakiVFXAssests")
				end
			else
				warn("[ConquerorHakiClient] ConquerorHakiVFXAssests folder not found")
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_76(p68, p69)
	local v70 = {}
	for _, v71 in ipairs(p68.Keypoints) do
		local v72 = NumberSequenceKeypoint.new
		local v73 = v71.Time
		local v74 = v71.Value * p69
		local v75 = v71.Envelope * p69
		table.insert(v70, v72(v73, v74, v75))
	end
	return NumberSequence.new(v70)
end
local function v_u_81(p77)
	-- upvalues: (copy) v_u_10
	local v_u_78 = {}
	for _, v79 in ipairs(p77:GetDescendants()) do
		if v79:IsA("ParticleEmitter") then
			v79.Enabled = true
			table.insert(v_u_78, v79)
		end
	end
	task.delay(v_u_10 * 0.8, function()
		-- upvalues: (copy) v_u_78
		for _, v80 in ipairs(v_u_78) do
			if v80 and v80.Parent then
				v80.Enabled = false
			end
		end
	end)
end
local function v_u_103(p82, _, p83)
	-- upvalues: (copy) v_u_7, (copy) v_u_50, (copy) v_u_9, (copy) v_u_2, (copy) v_u_67, (ref) v_u_16, (copy) v_u_10, (copy) v_u_76, (copy) v_u_81, (copy) v_u_6
	if v_u_7:GetAttribute("DisableVFX") then
		return
	else
		if p82 == v_u_7 and p82.Character then
			v_u_50(p82.Character, p83)
		end
		local v84 = v_u_9.Ability.VFXAssetPath
		local v85 = string.split(v84, ".")
		local v86 = v_u_2
		for _, v87 in ipairs(v85) do
			v86 = v86:FindFirstChild(v87)
			if not v86 then
				warn("[ConquerorHakiClient] VFX source not found at:", v84)
				return
			end
		end
		local v88 = p82.Character
		if v88 then
			local v89 = v88:FindFirstChild("HumanoidRootPart")
			if v89 then
				v_u_67(v88)
				if v_u_16 then
					v_u_16:Play("ConquerorHaki")
				end
				local v90 = v86:Clone()
				local v91 = v_u_9.Ability.VFXScale or 1
				if v90:IsA("Model") then
					if v91 ~= 1 then
						v90:ScaleTo(v91)
					end
					local v92 = v90.PrimaryPart or v90:FindFirstChildWhichIsA("BasePart", true)
					if v92 then
						v92.CFrame = v89.CFrame * CFrame.new(0, -3, 0)
						v92.Anchored = false
						v92.CanCollide = false
						local v93 = Instance.new("WeldConstraint")
						v93.Part0 = v89
						v93.Part1 = v92
						v93.Parent = v92
						local v_u_94 = {}
						for _, v95 in ipairs(v90:GetDescendants()) do
							if v95:IsA("BasePart") then
								v95.Anchored = false
								v95.CanCollide = false
								v95.Massless = true
							elseif v95:IsA("ParticleEmitter") then
								v95.Enabled = true
								table.insert(v_u_94, v95)
							end
						end
						task.delay(v_u_10 * 0.8, function()
							-- upvalues: (copy) v_u_94
							for _, v96 in ipairs(v_u_94) do
								if v96 and v96.Parent then
									v96.Enabled = false
								end
							end
						end)
					end
					v90.Parent = workspace
				elseif v90:IsA("BasePart") then
					if v91 ~= 1 then
						v90.Size = v90.Size * v91
						for _, v97 in ipairs(v90:GetDescendants()) do
							if v97:IsA("ParticleEmitter") then
								v97.Size = v_u_76(v97.Size, v91)
								v97.Speed = NumberRange.new(v97.Speed.Min * v91, v97.Speed.Max * v91)
							elseif v97:IsA("Attachment") then
								v97.Position = v97.Position * v91
							end
						end
					end
					v90.CFrame = v89.CFrame * CFrame.new(0, -3, 0)
					v90.Anchored = false
					v90.CanCollide = false
					v90.Massless = true
					local v98 = Instance.new("WeldConstraint")
					v98.Part0 = v89
					v98.Part1 = v90
					v98.Parent = v90
					v90.Parent = workspace
					v_u_81(v90)
				elseif v90:IsA("Folder") then
					for _, v99 in ipairs(v90:GetChildren()) do
						if v99:IsA("Attachment") then
							local v100 = v99:Clone()
							if v91 ~= 1 then
								v100.Position = v100.Position * v91
							end
							v100.Parent = v89
							for _, v101 in ipairs(v100:GetDescendants()) do
								if v101:IsA("ParticleEmitter") then
									v101.Enabled = true
									if v91 ~= 1 then
										v101.Size = v_u_76(v101.Size, v91)
										v101.Speed = v_u_76(v101.Speed, v91)
									end
								end
							end
							v_u_6:AddItem(v100, v_u_10)
						elseif v99:IsA("ParticleEmitter") then
							local v_u_102 = v99:Clone()
							v_u_102.Parent = v89
							v_u_102.Enabled = true
							if v91 ~= 1 then
								v_u_102.Size = v_u_76(v_u_102.Size, v91)
								v_u_102.Speed = v_u_76(v_u_102.Speed, v91)
							end
							task.delay(v_u_10 * 0.8, function()
								-- upvalues: (copy) v_u_102
								if v_u_102 and v_u_102.Parent then
									v_u_102.Enabled = false
								end
							end)
							v_u_6:AddItem(v_u_102, v_u_10)
						end
					end
					v90:Destroy()
					return
				end
				v_u_6:AddItem(v90, v_u_10)
			end
		else
			return
		end
	end
end
v3.InputBegan:Connect(function(p104, p105)
	-- upvalues: (copy) v_u_9, (copy) v_u_12, (ref) v_u_41, (ref) v_u_40, (ref) v_u_38, (ref) v_u_39
	if p105 then
		return
	elseif p104.KeyCode == v_u_9.Ability.KeyCode then
		if v_u_12 then
			if v_u_41 then
				local v106 = tick()
				if v106 - v_u_40 < 0.5 then
					return
				else
					v_u_40 = v106
					if not v_u_38 or v106 >= v_u_39 then
						v_u_12:FireServer("Activate")
					end
				end
			else
				return
			end
		else
			warn("[ConquerorHakiClient] Remote not found")
			return
		end
	else
		return
	end
end)
if v_u_12 then
	v_u_12.OnClientEvent:Connect(function(p107, ...)
		-- upvalues: (ref) v_u_38, (ref) v_u_39, (copy) v_u_9, (copy) v_u_15, (ref) v_u_16, (ref) v_u_41, (copy) v_u_7
		local v108 = { ... }
		if p107 == "Activated" then
			v_u_38 = true
			v_u_39 = tick() + v_u_9.Ability.Cooldown
			v_u_15:StartCooldown("ConquerorHaki", "Burst", "J", v_u_9.Ability.Cooldown)
			if v_u_16 and v_u_9.Sound.ActivationSoundId then
				v_u_16:Play("ConquerorHaki")
			end
			task.delay(v_u_9.Ability.Cooldown, function()
				-- upvalues: (ref) v_u_38
				v_u_38 = false
			end)
		elseif p107 == "Failed" then
			local v109 = v108[1]
			local v110 = v108[2]
			if v109 == "OnCooldown" then
				v_u_38 = true
				v_u_39 = tick() + (v110 or v_u_9.Ability.Cooldown)
				return
			end
		else
			if p107 == "Unlocked" then
				v_u_41 = true
				v_u_7:SetAttribute("HasConquerorHaki", true)
				return
			end
			local v111 = p107 == "Status" and v108[1]
			if v111 then
				if v111.hasAbility or (v111.canUse or v111.reason ~= "AbilityLocked") then
					v_u_41 = true
					v_u_7:SetAttribute("HasConquerorHaki", true)
				end
				local v112 = not v111.canUse
				if v112 then
					v112 = v111.reason == "OnCooldown"
				end
				v_u_38 = v112
				if v111.cooldownRemaining then
					v_u_39 = tick() + v111.cooldownRemaining
				end
			end
		end
	end)
end
if v13 then
	v13.OnClientEvent:Connect(function(p113, p114, p115)
		-- upvalues: (copy) v_u_7, (copy) v_u_103, (copy) v_u_37
		if p113 and (typeof(p113) == "Instance" and p113:IsA("Player")) then
			if p113 ~= v_u_7 and v_u_7:GetAttribute("DisableOtherVFX") then
				return
			end
			v_u_103(p113, p114, p115)
			if p113 == v_u_7 then
				v_u_37()
			end
		end
	end)
end
v_u_7.CharacterAdded:Connect(function(_)
	-- upvalues: (copy) v_u_12
	if v_u_12 then
		task.wait(3.5)
		v_u_12:FireServer("GetStatus")
	end
end)
if v_u_7.Character then
	task.spawn(function()
		-- upvalues: (copy) v_u_7, (copy) v_u_12
		local _ = v_u_7.Character
		if v_u_12 then
			task.wait(3.5)
			v_u_12:FireServer("GetStatus")
		end
	end)
end
local function v_u_120(p116)
	if not p116 or p116 == 0 then
		return "0"
	end
	local v117 = math.floor(p116)
	local v118 = tostring(v117)
	repeat
		local v119
		v118, v119 = v118:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
	until v119 == 0
	return v118
end
local v121 = v_u_7.PlayerGui:WaitForChild("StatsPanelUI", 10)
if v121 then
	local v_u_122 = v121:WaitForChild("MainFrame"):WaitForChild("Frame"):WaitForChild("Content"):WaitForChild("Page2"):WaitForChild("StatsHolder"):WaitForChild("ConquerorHakiProgressionFrame")
	local v_u_123 = v_u_122:WaitForChild("Loader"):WaitForChild("Holder"):WaitForChild("Loader")
	local v124 = v_u_122:WaitForChild("Txts")
	local v_u_125 = v124:WaitForChild("ConquerorHakiExperience")
	local v_u_126 = v124:WaitForChild("ConquerorHakiLevel")
	local function v_u_134(p127)
		-- upvalues: (copy) v_u_125, (copy) v_u_126, (copy) v_u_120, (copy) v_u_4, (copy) v_u_123
		local v128 = p127.level or 1
		local v129 = p127.xp or 0
		local v130 = p127.xpRequired or 1
		local v131 = (p127.maxLevel or 25) <= v128
		v_u_125.Text = "Conqueror Haki Lv. " .. v128
		v_u_126.Text = v131 and "MAX" or v_u_120(v129) .. " / " .. v_u_120(v130) .. " XP"
		local v132 = v131 and 1 or (v130 > 0 and v129 / v130 or 0)
		local v133 = math.clamp(v132, 0, 1)
		v_u_4:Create(v_u_123, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			["Size"] = UDim2.new(v133, 0, 1, 0)
		}):Play()
	end
	v_u_122.Visible = v_u_41
	if v14 then
		v14.OnClientEvent:Connect(function(p135)
			-- upvalues: (copy) v_u_122, (copy) v_u_134
			v_u_122.Visible = true
			v_u_134(p135)
		end)
	end
end