local v1 = game:GetService("Players")
local v2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = v1.LocalPlayer
local v5 = v_u_4:WaitForChild("PlayerGui")
local v6 = {
	["ShowOnMobileOnly"] = true,
	["DebugMode"] = false
}
local v7 = v_u_3:WaitForChild("AbilitySystem")
local v_u_8 = require(v7:WaitForChild("AbilityConfig"))
local v9 = v_u_3:WaitForChild("RemoteEvents")
local v10 = v_u_3:WaitForChild("FruitPowerSystem")
game.ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("CheckShadowFUnlocked", 5)
local v_u_11 = require(v10:WaitForChild("FruitPowerConfig"))
local v_u_12 = v9:WaitForChild("FruitPowerRemote")
local v_u_13 = v9:WaitForChild("SprintToggle")
local v_u_14 = v9:WaitForChild("DashTrigger")
local v_u_15 = require(v_u_3:WaitForChild("DashModule"))
local v_u_16 = v9:WaitForChild("HakiRemote")
local v_u_17 = v9:WaitForChild("ObservationHakiRemote")
local v_u_18 = v_u_3:WaitForChild("Remotes"):WaitForChild("ConquerorHakiRemote", 10)
local v_u_19 = v9:WaitForChild("DropFruit")
local v_u_20 = v7:WaitForChild("Remotes"):WaitForChild("RequestAbility")
local v21 = v7:WaitForChild("Remotes"):WaitForChild("AbilityStateChanged", 5)
if v21 then
	v21.OnClientEvent:Connect(function(p22)
		InAbility = p22
		if p22 == true then
			task.delay(15, function()
				if InAbility == true then
					InAbility = false
				end
			end)
		end
	end)
end
local v_u_23 = require(v_u_3:WaitForChild("Modules"):WaitForChild("SoundManager"))
local v_u_24 = require(v_u_3:WaitForChild("CooldownUIManager"))
local v25 = v5:WaitForChild("MobileButtonsUI"):WaitForChild("MobileButtons")
local v26 = v25:WaitForChild("ButtonsHolder1")
local v_u_27 = v26:WaitForChild("B2"):WaitForChild("Button")
local v_u_28 = v26:WaitForChild("B3"):WaitForChild("Button")
local v_u_29 = v26:WaitForChild("B4"):WaitForChild("Button")
local v30 = v25:WaitForChild("ButtonsHolder2")
local v_u_31 = v30:WaitForChild("B3"):WaitForChild("Button")
local v_u_32 = v26:WaitForChild("B4")
local v_u_33 = v30:WaitForChild("B3")
local v_u_34 = v30:WaitForChild("B4")
local v_u_35 = v_u_34:WaitForChild("Button")
local v36 = v25:WaitForChild("ButtonsHolder3")
local v37 = v36:WaitForChild("ButtonsRow1")
local v38 = v36:WaitForChild("ButtonsRow2")
local v_u_39 = v37:WaitForChild("B2"):WaitForChild("Button")
local v_u_40 = v37:WaitForChild("B3"):WaitForChild("Button")
local v_u_41 = v38:WaitForChild("B2"):WaitForChild("Button")
local v_u_42 = v38:WaitForChild("B3"):WaitForChild("Button")
local v_u_43 = v37:WaitForChild("B2")
local v_u_44 = v37:WaitForChild("B3")
local v_u_45 = v38:WaitForChild("B2")
local v_u_46 = v38:WaitForChild("B3")
local v47 = v36:WaitForChild("ButtonsRow3")
local v_u_48 = v47:WaitForChild("B3"):WaitForChild("Button")
local v_u_49 = v47:WaitForChild("B3")
local v_u_50 = v36:WaitForChild("ButtonsRow4"):WaitForChild("B2")
local v_u_51 = v_u_50:WaitForChild("Button")
local v_u_52 = false
local v_u_53 = false
local v_u_54 = false
local v_u_55 = false
local v_u_56 = {}
local v_u_57 = {}
local v_u_58 = 0
local v_u_59 = nil
local v_u_60 = nil
local v_u_61 = nil
local v_u_62 = false
local v_u_63 = {
	["IsHolding"] = false,
	["StartTime"] = 0,
	["Slot"] = nil,
	["MovesetName"] = nil,
	["AbilityData"] = nil,
	["VariantTriggered"] = false,
	["ChargeVFX"] = {},
	["HoldAnimTrack"] = nil,
	["HoldLoopSound"] = nil,
	["ChargeTier2Triggered"] = false,
	["ChargeTier3Triggered"] = false
}
local function v_u_67()
	-- upvalues: (copy) v_u_63
	v_u_63.IsHolding = false
	v_u_63.StartTime = 0
	v_u_63.Slot = nil
	v_u_63.MovesetName = nil
	v_u_63.AbilityData = nil
	v_u_63.VariantTriggered = false
	v_u_63.ChargeTier2Triggered = false
	v_u_63.ChargeTier3Triggered = false
	for _, v64 in pairs(v_u_63.ChargeVFX) do
		if v64 and v64.Parent then
			for _, v65 in v64:GetDescendants() do
				if v65:IsA("ParticleEmitter") then
					v65.Enabled = false
				end
			end
			game:GetService("Debris"):AddItem(v64, 0.15)
		end
	end
	v_u_63.ChargeVFX = {}
	if v_u_63.HoldAnimTrack then
		v_u_63.HoldAnimTrack:Stop(0.1)
		v_u_63.HoldAnimTrack = nil
	end
	if v_u_63.HoldLoopSound then
		v_u_63.HoldLoopSound:Stop()
		v_u_63.HoldLoopSound = nil
	end
	local v66 = workspace.CurrentCamera
	if v66 then
		game:GetService("TweenService"):Create(v66, TweenInfo.new(0.15), {
			["FieldOfView"] = 70
		}):Play()
	end
end
local v_u_68 = {
	Enum.KeyCode.Z,
	Enum.KeyCode.X,
	Enum.KeyCode.C,
	Enum.KeyCode.V,
	Enum.KeyCode.F
}
local v69 = game:GetService("GuiService")
local function v_u_74()
	-- upvalues: (copy) v_u_4, (copy) v_u_8
	local v70 = v_u_4.Character
	if not v70 then
		return nil
	end
	local v71 = v70:FindFirstChildOfClass("Tool")
	if not v71 then
		return nil
	end
	for v72, v73 in pairs(v_u_8.Movesets) do
		if v73.ToolName and v73.ToolName == v71.Name then
			return v72, v73
		end
	end
	return nil
end
local function v_u_78()
	-- upvalues: (copy) v_u_4, (copy) v_u_11
	local v75 = v_u_4.Character
	if not v75 then
		return nil
	end
	for v76, v77 in pairs(v_u_11.Powers) do
		if v75:FindFirstChild(v77.ToolName) then
			return v76, v77
		end
	end
	return nil
end
local function v_u_81()
	-- upvalues: (copy) v_u_4
	local v79 = v_u_4:GetMouse()
	local v80 = workspace:Raycast(v79.UnitRay.Origin, v79.UnitRay.Direction * 500, RaycastParams.new())
	return v80 and v80.Position or v79.UnitRay.Origin + v79.UnitRay.Direction * 100
end
local function v_u_87()
	-- upvalues: (copy) v_u_74, (copy) v_u_78, (copy) v_u_43, (copy) v_u_44, (copy) v_u_45, (copy) v_u_46, (copy) v_u_49, (copy) v_u_4, (copy) v_u_11, (copy) v_u_68
	local v82, v83 = v_u_74()
	local v84, v85 = v_u_78()
	if v83 then
		local v86 = v83.Abilities
		v_u_43.Visible = v86[1] ~= nil
		v_u_44.Visible = v86[2] ~= nil
		v_u_45.Visible = v86[3] ~= nil
		v_u_46.Visible = v86[4] ~= nil
		if v86[5] then
			if v82 == "Shadow" then
				v_u_49.Visible = v_u_4:GetAttribute("ShadowFUnlocked") == true
				return
			elseif v82 == "StrongestInHistory" then
				v_u_49.Visible = v_u_4:GetAttribute("SukunaFUnlocked") == true
				return
			elseif v82 == "StrongestOfToday" then
				v_u_49.Visible = v_u_4:GetAttribute("GojoFUnlocked") == true
				return
			elseif v82 == "Gilgamesh" then
				v_u_49.Visible = v_u_4:GetAttribute("GilgameshFUnlocked") == true
				return
			elseif v82 == "TrueAizen" then
				v_u_49.Visible = v_u_4:GetAttribute("AizenFUnlocked") == true
				return
			elseif v82 == "BlessedMaiden" then
				v_u_49.Visible = v_u_4:GetAttribute("BlessedMaidenFUnlocked") == true
				return
			elseif v82 == "Rimuru" then
				v_u_49.Visible = v_u_4:GetAttribute("RimuruFUnlocked") == true
				return
			elseif v82 == "ShadowMonarch" then
				v_u_49.Visible = v_u_4:GetAttribute("ShadowMonarchFUnlocked") == true
			else
				v_u_49.Visible = true
			end
		else
			v_u_49.Visible = false
			return
		end
	elseif v85 then
		v_u_43.Visible = v_u_11.GetAbilityByKey(v84, v_u_68[1]) ~= nil
		v_u_44.Visible = v_u_11.GetAbilityByKey(v84, v_u_68[2]) ~= nil
		v_u_45.Visible = v_u_11.GetAbilityByKey(v84, v_u_68[3]) ~= nil
		v_u_46.Visible = v_u_11.GetAbilityByKey(v84, v_u_68[4]) ~= nil
		v_u_49.Visible = v_u_11.GetAbilityByKey(v84, v_u_68[5]) ~= nil
	else
		v_u_43.Visible = false
		v_u_44.Visible = false
		v_u_45.Visible = false
		v_u_46.Visible = false
		v_u_49.Visible = false
	end
end
local function v_u_89()
	-- upvalues: (ref) v_u_52, (copy) v_u_13, (copy) v_u_27
	v_u_52 = not v_u_52
	v_u_13:FireServer(v_u_52)
	local v88 = v_u_27:FindFirstChild("Txt")
	if v88 then
		v88.Text = v_u_52 and "Sprint \226\151\143" or "Sprint"
	end
end
local function v_u_91()
	-- upvalues: (ref) v_u_58, (copy) v_u_15, (copy) v_u_14
	local v90 = tick()
	if v90 - v_u_58 >= v_u_15.Config.DashCooldown then
		v_u_58 = v90
		v_u_14:Fire()
	end
end
local function v_u_92()
	-- upvalues: (ref) v_u_53, (copy) v_u_16
	if v_u_53 then
		v_u_16:FireServer("Toggle")
	end
end
v_u_16.OnClientEvent:Connect(function(p93, p94)
	-- upvalues: (ref) v_u_53, (ref) v_u_32
	if p93 == "Status" and p94 then
		v_u_53 = p94.hasHaki or false
		v_u_32.Visible = v_u_53
	elseif p93 == "PurchaseSuccess" then
		v_u_53 = true
		v_u_32.Visible = v_u_53
	end
end)
local function v_u_95()
	-- upvalues: (ref) v_u_54, (copy) v_u_17
	if v_u_54 then
		v_u_17:FireServer("Toggle")
	end
end
v_u_17.OnClientEvent:Connect(function(p96, p97)
	-- upvalues: (ref) v_u_54, (ref) v_u_33
	if p96 == "Status" and p97 then
		v_u_54 = p97.hasObsHaki or false
		v_u_33.Visible = v_u_54
	elseif p96 == "PurchaseSuccess" then
		v_u_54 = true
		v_u_33.Visible = v_u_54
	end
end)
local function v_u_98()
	-- upvalues: (ref) v_u_55, (copy) v_u_18
	if v_u_55 then
		if v_u_18 then
			v_u_18:FireServer("Activate")
		end
	else
		return
	end
end
if v_u_18 then
	v_u_18.OnClientEvent:Connect(function(p99, _)
		-- upvalues: (ref) v_u_55, (copy) v_u_34
		if p99 == "Unlocked" then
			v_u_55 = true
			v_u_34.Visible = v_u_55
		end
	end)
end
v_u_4:GetAttributeChangedSignal("HasConquerorHaki"):Connect(function()
	-- upvalues: (ref) v_u_55, (copy) v_u_4, (copy) v_u_34
	v_u_55 = v_u_4:GetAttribute("HasConquerorHaki") == true
	v_u_34.Visible = v_u_55
end)
if v_u_4:GetAttribute("HasConquerorHaki") == true then
	v_u_55 = true
else
	v_u_55 = false
end
v_u_34.Visible = v_u_55
local function v_u_121()
	-- upvalues: (copy) v_u_4, (copy) v_u_23, (copy) v_u_3, (copy) v_u_63
	local v_u_100 = v_u_4.Character
	if v_u_100 then
		local v101 = v_u_100:FindFirstChild("Right Arm") or v_u_100:FindFirstChild("RightHand")
		local v102 = v_u_100:FindFirstChild("HumanoidRootPart")
		if v101 and v102 then
			v_u_23:PlayAt("YujiC_HoldStart", v102.Position)
			local v_u_103 = v_u_3.AbilitySystem.VFX:FindFirstChild("Yuji")
			if v_u_103 then
				v_u_103 = v_u_103:FindFirstChild("C")
			end
			if v_u_103 then
				local v104 = v_u_103:FindFirstChild("ArmVFX1")
				if v104 then
					local v105 = v104:Clone()
					v105.CFrame = v101.CFrame * CFrame.new(0, -1, 0)
					v105.Anchored = false
					v105.CanCollide = false
					v105.Transparency = 1
					v105.Parent = workspace
					local v106 = Instance.new("WeldConstraint")
					v106.Part0 = v105
					v106.Part1 = v101
					v106.Parent = v105
					for _, v107 in v105:GetDescendants() do
						if v107:IsA("ParticleEmitter") then
							v107.Enabled = true
						end
					end
					local v108 = v_u_63.ChargeVFX
					table.insert(v108, v105)
				end
				task.delay(0.15, function()
					-- upvalues: (ref) v_u_63, (copy) v_u_103, (ref) v_u_4
					if v_u_63.IsHolding then
						local v109 = v_u_103:FindFirstChild("AuraVFX1")
						if v109 then
							local v110 = v_u_4.Character
							if v110 then
								v110 = v_u_4.Character:FindFirstChild("HumanoidRootPart")
							end
							if not v110 then
								return
							end
							local v111 = v109:Clone()
							v111.CFrame = v110.CFrame * CFrame.new(0, -2.95, 0)
							v111.Anchored = false
							v111.CanCollide = false
							v111.Transparency = 1
							v111.Parent = workspace
							local v112 = Instance.new("WeldConstraint")
							v112.Part0 = v111
							v112.Part1 = v110
							v112.Parent = v111
							for _, v113 in v111:GetDescendants() do
								if v113:IsA("ParticleEmitter") then
									v113.Enabled = true
								end
							end
							local v114 = v_u_63.ChargeVFX
							table.insert(v114, v111)
						end
					end
				end)
				task.delay(0.15, function()
					-- upvalues: (ref) v_u_63, (copy) v_u_100, (ref) v_u_3
					if v_u_63.IsHolding then
						local v115 = v_u_100:FindFirstChildOfClass("Humanoid")
						if v115 then
							local v116 = v115:FindFirstChildOfClass("Animator") or Instance.new("Animator", v115)
							local v117 = v_u_3.AbilitySystem.Animations:FindFirstChild("Yuji")
							if v117 then
								v117 = v117:FindFirstChild("Yuji_C_Anim_Hold")
							end
							if v117 then
								v_u_63.HoldAnimTrack = v116:LoadAnimation(v117)
								v_u_63.HoldAnimTrack.Priority = Enum.AnimationPriority.Action4
								v_u_63.HoldAnimTrack.Looped = true
								v_u_63.HoldAnimTrack:Play()
							end
						end
					end
				end)
				local v118 = workspace.CurrentCamera
				if v118 then
					local v119 = v_u_63.AbilityData
					local v120 = v119 and v119.ChargeTier3Time or 4
					game:GetService("TweenService"):Create(v118, TweenInfo.new(v120, Enum.EasingStyle.Linear), {
						["FieldOfView"] = v118.FieldOfView + 16
					}):Play()
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_143(p_u_122)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_63, (copy) v_u_23
	local v123 = v_u_4.Character
	if v123 then
		local v124 = v123:FindFirstChild("Right Arm") or v123:FindFirstChild("RightHand")
		local v125 = v123:FindFirstChild("HumanoidRootPart")
		if v124 and v125 then
			local v126 = v_u_3.AbilitySystem.VFX:FindFirstChild("Yuji")
			if v126 then
				v126 = v126:FindFirstChild("C")
			end
			if v126 then
				for _, v127 in pairs(v_u_63.ChargeVFX) do
					if v127 and v127.Parent then
						for _, v128 in v127:GetDescendants() do
							if v128:IsA("ParticleEmitter") then
								v128.Enabled = false
							end
						end
						game:GetService("Debris"):AddItem(v127, 0.3)
					end
				end
				v_u_63.ChargeVFX = {}
				local v129 = v126:FindFirstChild("ArmVFX" .. p_u_122)
				local v130 = v126:FindFirstChild("AuraVFX" .. p_u_122)
				if v129 then
					local v131 = v129:Clone()
					v131.CFrame = v124.CFrame * CFrame.new(0, -1, 0)
					v131.Anchored = false
					v131.CanCollide = false
					v131.Transparency = 1
					v131.Parent = workspace
					local v132 = Instance.new("WeldConstraint")
					v132.Part0 = v131
					v132.Part1 = v124
					v132.Parent = v131
					for _, v133 in v131:GetDescendants() do
						if v133:IsA("ParticleEmitter") then
							v133.Enabled = true
						end
					end
					local v134 = v_u_63.ChargeVFX
					table.insert(v134, v131)
				end
				if v130 then
					local v135 = v130:Clone()
					v135.CFrame = v125.CFrame * CFrame.new(0, -2.95, 0)
					v135.Anchored = false
					v135.CanCollide = false
					v135.Transparency = 1
					v135.Parent = workspace
					local v136 = Instance.new("WeldConstraint")
					v136.Part0 = v135
					v136.Part1 = v125
					v136.Parent = v135
					for _, v137 in v135:GetDescendants() do
						if v137:IsA("ParticleEmitter") then
							v137.Enabled = true
						end
					end
					local v138 = v_u_63.ChargeVFX
					table.insert(v138, v135)
				end
				if p_u_122 == 3 then
					v_u_63.HoldLoopSound = v_u_23:PlayAt("YujiC_HoldLoop", v125.Position)
					if v_u_63.HoldLoopSound then
						v_u_63.HoldLoopSound.Looped = true
					end
				end
				local v_u_139 = workspace.CurrentCamera
				if v_u_139 and not v_u_4:GetAttribute("DisableScreenShake") then
					task.spawn(function()
						-- upvalues: (copy) p_u_122, (copy) v_u_139
						local v140 = p_u_122 == 2 and 6 or 10
						local v141 = tick()
						while tick() - v141 < 0.3 do
							local v142 = v140 * (1 - (tick() - v141) / 0.3) * 0.01
							v_u_139.CFrame = v_u_139.CFrame * CFrame.new((math.random() - 0.5) * 2 * v142, (math.random() - 0.5) * 2 * v142, 0)
							game:GetService("RunService").RenderStepped:Wait()
						end
					end)
					game:GetService("TweenService"):Create(v_u_139, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["FieldOfView"] = v_u_139.FieldOfView + 5
					}):Play()
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_153(p_u_144)
	-- upvalues: (copy) v_u_4, (copy) v_u_74, (copy) v_u_24, (copy) v_u_63, (copy) v_u_23, (copy) v_u_20, (copy) v_u_121, (copy) v_u_143
	local v145 = v_u_4.Character
	if v145 and v145:GetAttribute("InCutscene") then
		return false
	end
	local v_u_146, v147 = v_u_74()
	if not (v_u_146 and v147) then
		return false
	end
	local v_u_148 = v147.Abilities[p_u_144]
	if not v_u_148 then
		return false
	end
	if v_u_24:IsOnCooldown(v147.ToolName, v_u_148.Name) then
		return false
	end
	if v_u_148.Type ~= "HoldVariant" and v_u_148.Type ~= "ChargedInstant" then
		return false
	end
	v_u_63.IsHolding = true
	v_u_63.StartTime = tick()
	v_u_63.Slot = p_u_144
	v_u_63.MovesetName = v_u_146
	v_u_63.AbilityData = v_u_148
	v_u_63.VariantTriggered = false
	v_u_63.ChargeTier2Triggered = false
	v_u_63.ChargeTier3Triggered = false
	if v_u_148.Type == "HoldVariant" then
		task.spawn(function()
			-- upvalues: (copy) v_u_148, (ref) v_u_63, (copy) p_u_144, (copy) v_u_146, (ref) v_u_23, (ref) v_u_20
			local v149 = v_u_148.HoldThreshold or 0.5
			while v_u_63.IsHolding and v_u_63.Slot == p_u_144 do
				if v149 <= tick() - v_u_63.StartTime and not v_u_63.VariantTriggered then
					v_u_63.VariantTriggered = true
					if v_u_146 == "Sukuna" then
						v_u_23:Play("SukunaC_Hold")
					elseif v_u_146 == "Gojo" then
						v_u_23:Play("GojoC_Hold")
					end
					v_u_20:FireServer(p_u_144, {
						["Variant"] = 2
					})
					return
				end
				task.wait(0.05)
			end
		end)
	elseif v_u_148.Type == "ChargedInstant" and (v_u_146 == "Yuji" and p_u_144 == 3) then
		v_u_121()
		task.spawn(function()
			-- upvalues: (copy) v_u_148, (ref) v_u_63, (copy) p_u_144, (ref) v_u_143
			local v150 = v_u_148.ChargeTier2Time or 2
			local v151 = v_u_148.ChargeTier3Time or 4
			while v_u_63.IsHolding and v_u_63.Slot == p_u_144 do
				local v152 = tick() - v_u_63.StartTime
				if v150 <= v152 and not v_u_63.ChargeTier2Triggered then
					v_u_63.ChargeTier2Triggered = true
					v_u_143(2)
				end
				if v151 <= v152 and not v_u_63.ChargeTier3Triggered then
					v_u_63.ChargeTier3Triggered = true
					v_u_143(3)
				end
				task.wait(0.05)
			end
		end)
	end
	return true
end
local function v_u_158(p154)
	-- upvalues: (copy) v_u_63, (copy) v_u_23, (copy) v_u_20, (copy) v_u_67
	if v_u_63.IsHolding and v_u_63.Slot == p154 then
		local v155 = tick() - v_u_63.StartTime
		local v156 = v_u_63.MovesetName
		local v157 = v_u_63.AbilityData
		if v157.Type == "HoldVariant" then
			if not v_u_63.VariantTriggered then
				if v156 == "Sukuna" then
					v_u_23:Play("SukunaC_Tap")
				elseif v156 == "Gojo" then
					v_u_23:Play("GojoC")
				end
				v_u_20:FireServer(p154, {
					["Variant"] = 1
				})
			end
		elseif v157.Type == "ChargedInstant" then
			v_u_20:FireServer(p154, {
				["ChargeTier"] = (v157.ChargeTier3Time or 4) <= v155 and 3 or ((v157.ChargeTier2Time or 2) <= v155 and 2 or 1),
				["HoldDuration"] = v155
			})
		end
		v_u_67()
	end
end
local function v_u_177(p159)
	-- upvalues: (copy) v_u_4, (copy) v_u_68, (copy) v_u_57, (copy) v_u_74, (copy) v_u_24, (copy) v_u_20, (copy) v_u_78, (copy) v_u_11, (copy) v_u_81, (copy) v_u_3, (ref) v_u_59, (copy) v_u_12, (ref) v_u_60
	local v160 = v_u_4.Character
	if v160 and v160:GetAttribute("InCutscene") then
		return
	else
		local v161 = v_u_68[p159]
		local v162 = tick()
		local v163
		if v_u_57[p159] and v162 - v_u_57[p159] < 0.15 then
			v163 = true
		else
			v_u_57[p159] = v162
			v163 = false
		end
		if v163 then
			return
		else
			local v164, v165 = v_u_74()
			if v164 and v165 then
				local v166 = v165.Abilities[p159]
				if v166 then
					if v_u_24:IsOnCooldown(v165.ToolName, v166.Name) then
						return
					elseif v166.Type == "HoldVariant" then
						v_u_20:FireServer(p159, {
							["Variant"] = 1
						})
					else
						v_u_20:FireServer(p159)
					end
				else
					return
				end
			else
				local v167, v168 = v_u_78()
				if v167 and v168 then
					local v169 = v_u_11.GetAbilityByKey(v167, v161)
					if not v169 then
						return
					end
					if v_u_24:IsOnCooldown(v168.ToolName, v169.Name) then
						return
					end
					local v170 = {
						["FruitPower"] = v167,
						["KeyCode"] = v161
					}
					if v169.Type == "Targeted" or v169.Type == "Channeled" then
						v170.TargetPosition = v_u_81()
					elseif v169.Type == "Projectile" then
						if v160 then
							v160 = v160:FindFirstChild("HumanoidRootPart")
						end
						if v160 then
							v170.Direction = (v_u_81() - v160.Position).Unit
						end
					end
					if v169.Type == "Toggle" then
						if v167 == "Light" and v169.Key == "V" then
							local v171 = v_u_3:FindFirstChild("Light")
							local v172 = v171
							if v172 then
								v172 = v171:FindFirstChild("LightFlightEvent")
							end
							if v172 then
								local v173 = workspace.CurrentCamera
								v172:FireServer("toggle", {
									["Direction"] = v173 and v173.CFrame.LookVector or Vector3.new(0, 0, -1)
								})
							end
						end
						return
					end
					if v169.Type == "HoldRelease" then
						v_u_59 = {
							["Slot"] = p159,
							["FruitName"] = v167,
							["Ability"] = v169,
							["KeyCode"] = v161
						}
						v170.TargetPosition = v_u_81()
						v_u_12:FireServer("UseAbility", v170)
						local v174 = game:GetService("RunService")
						if v_u_60 then
							v_u_60:Disconnect()
						end
						local v_u_175 = 0
						v_u_60 = v174.RenderStepped:Connect(function()
							-- upvalues: (ref) v_u_59, (ref) v_u_175, (ref) v_u_12, (ref) v_u_81
							if v_u_59 then
								local v176 = tick()
								if v176 - v_u_175 >= 0.05 then
									v_u_175 = v176
									v_u_12:FireServer("HoldReleaseUpdate", {
										["TargetPosition"] = v_u_81()
									})
								end
							end
						end)
						return
					end
					v_u_12:FireServer("UseAbility", v170)
				end
				return
			end
		end
	end
end
local function v_u_179(p178)
	-- upvalues: (ref) v_u_59, (ref) v_u_60, (copy) v_u_12, (copy) v_u_81
	if v_u_59 then
		if v_u_59.Slot == p178 then
			if v_u_60 then
				v_u_60:Disconnect()
				v_u_60 = nil
			end
			v_u_12:FireServer("HoldReleaseExecute", {
				["TargetPosition"] = v_u_81()
			})
			v_u_59 = nil
		end
	else
		return
	end
end
local function v225()
	-- upvalues: (ref) v_u_56, (copy) v_u_27, (copy) v_u_89, (copy) v_u_28, (copy) v_u_91, (copy) v_u_29, (copy) v_u_92, (copy) v_u_31, (copy) v_u_95, (copy) v_u_35, (copy) v_u_98, (copy) v_u_39, (copy) v_u_177, (copy) v_u_40, (copy) v_u_41, (copy) v_u_74, (copy) v_u_153, (copy) v_u_78, (copy) v_u_11, (copy) v_u_158, (copy) v_u_179, (copy) v_u_42, (copy) v_u_48, (copy) v_u_51, (ref) v_u_62, (copy) v_u_4, (copy) v_u_19, (ref) v_u_61, (copy) v_u_50
	for _, v180 in pairs(v_u_56) do
		v180:Disconnect()
	end
	v_u_56 = {}
	local v181 = v_u_56
	local v182 = v_u_27.MouseButton1Click
	local v183 = v_u_89
	table.insert(v181, v182:Connect(v183))
	local v184 = v_u_56
	local v185 = v_u_28.MouseButton1Down
	local v186 = v_u_91
	table.insert(v184, v185:Connect(v186))
	local v187 = v_u_56
	local v188 = v_u_29.MouseButton1Click
	local v189 = v_u_92
	table.insert(v187, v188:Connect(v189))
	local v190 = v_u_56
	local v191 = v_u_31.MouseButton1Click
	local v192 = v_u_95
	table.insert(v190, v191:Connect(v192))
	local v193 = v_u_56
	local v194 = v_u_35.MouseButton1Click
	local v195 = v_u_98
	table.insert(v193, v194:Connect(v195))
	local v196 = v_u_56
	local v197 = v_u_39.MouseButton1Click
	local function v198()
		-- upvalues: (ref) v_u_177
		v_u_177(1)
	end
	table.insert(v196, v197:Connect(v198))
	local v199 = v_u_56
	local v200 = v_u_40.MouseButton1Click
	local function v201()
		-- upvalues: (ref) v_u_177
		v_u_177(2)
	end
	table.insert(v199, v200:Connect(v201))
	local v202 = v_u_56
	local v203 = v_u_41.MouseButton1Down
	local function v209()
		-- upvalues: (ref) v_u_74, (ref) v_u_153, (ref) v_u_78, (ref) v_u_11, (ref) v_u_177
		local v204, v205 = v_u_74()
		if v204 and v205 then
			local v206 = v205.Abilities[3]
			if v206 and (v206.Type == "HoldVariant" or v206.Type == "ChargedInstant") then
				v_u_153(3)
				return
			end
		end
		local v207 = v_u_78()
		if v207 then
			local v208 = v_u_11.GetAbilityByKey(v207, Enum.KeyCode.C)
			if v208 and v208.Type == "HoldRelease" then
				v_u_177(3)
				return
			end
		end
		v_u_177(3)
	end
	table.insert(v202, v203:Connect(v209))
	local v210 = v_u_56
	local v211 = v_u_41.MouseButton1Up
	local function v212()
		-- upvalues: (ref) v_u_158, (ref) v_u_179
		v_u_158(3)
		v_u_179(3)
	end
	table.insert(v210, v211:Connect(v212))
	local v213 = v_u_56
	local v214 = v_u_42.MouseButton1Click
	local function v215()
		-- upvalues: (ref) v_u_177
		v_u_177(4)
	end
	table.insert(v213, v214:Connect(v215))
	local v216 = v_u_56
	local v217 = v_u_48.MouseButton1Click
	local function v218()
		-- upvalues: (ref) v_u_177
		v_u_177(5)
	end
	table.insert(v216, v217:Connect(v218))
	local v219 = v_u_56
	local v220 = v_u_51.MouseButton1Click
	local function v224()
		-- upvalues: (ref) v_u_62, (ref) v_u_4, (ref) v_u_19, (ref) v_u_61, (ref) v_u_50
		if v_u_62 then
			return
		else
			local v221 = v_u_4.Character
			local v222
			if v221 then
				v222 = v221:FindFirstChildOfClass("Tool")
				if v222 then
					if not (v222:FindFirstChild("IsFruitTool") and v222:FindFirstChild("FruitData")) then
						v222 = nil
					end
				else
					v222 = nil
				end
			else
				v222 = nil
			end
			if v222 then
				local v223 = v222:FindFirstChild("FruitID")
				if v223 then
					v_u_62 = true
					v_u_19:FireServer(v223.Value)
					v_u_61 = nil
					v_u_50.Visible = false
					task.delay(0.5, function()
						-- upvalues: (ref) v_u_62
						v_u_62 = false
					end)
				end
			else
				return
			end
		end
	end
	table.insert(v219, v220:Connect(v224))
end
local v226 = game.ReplicatedStorage:FindFirstChild("RemoteEvents")
if v226 then
	v226 = v226:FindFirstChild("ShadowFUnlockUpdate")
end
if v226 then
	v226.OnClientEvent:Connect(function(p227)
		-- upvalues: (copy) v_u_4, (copy) v_u_87
		v_u_4:SetAttribute("ShadowFUnlocked", p227)
		v_u_87()
	end)
end
local v228 = game.ReplicatedStorage:FindFirstChild("RemoteEvents")
if v228 then
	v228 = v228:FindFirstChild("SukunaFUnlockUpdate")
end
if v228 then
	v228.OnClientEvent:Connect(function(p229)
		-- upvalues: (copy) v_u_4, (copy) v_u_87
		v_u_4:SetAttribute("SukunaFUnlocked", p229)
		v_u_87()
	end)
end
local v230 = game.ReplicatedStorage:FindFirstChild("RemoteEvents")
if v230 then
	v230 = v230:FindFirstChild("GojoFUnlockUpdate")
end
if v230 then
	v230.OnClientEvent:Connect(function(p231)
		-- upvalues: (copy) v_u_4, (copy) v_u_87
		v_u_4:SetAttribute("GojoFUnlocked", p231)
		v_u_87()
	end)
end
local v232 = game.ReplicatedStorage:FindFirstChild("RemoteEvents")
if v232 then
	v232 = v232:FindFirstChild("GilgameshFUnlockUpdate")
end
if v232 then
	v232.OnClientEvent:Connect(function(p233)
		-- upvalues: (copy) v_u_4, (copy) v_u_87
		v_u_4:SetAttribute("GilgameshFUnlocked", p233)
		v_u_87()
	end)
end
local v234 = game.ReplicatedStorage:FindFirstChild("RemoteEvents")
if v234 then
	v234 = v234:FindFirstChild("AizenFUnlockUpdate")
end
if v234 then
	v234.OnClientEvent:Connect(function(p235)
		-- upvalues: (copy) v_u_4, (copy) v_u_87
		v_u_4:SetAttribute("AizenFUnlocked", p235)
		v_u_87()
	end)
end
local v236
if v69:IsTenFootInterface() then
	v236 = false
else
	v236 = not v6.ShowOnMobileOnly and true or v2.TouchEnabled
end
if v236 then
	v25.Visible = true
	v_u_32.Visible = false
	v_u_33.Visible = false
	v_u_34.Visible = false
	v_u_49.Visible = false
	v_u_50.Visible = false
	v225()
	local function v246(p237)
		-- upvalues: (copy) v_u_87, (copy) v_u_4, (ref) v_u_61, (copy) v_u_50, (copy) v_u_16, (copy) v_u_17
		p237.ChildAdded:Connect(function(p238)
			-- upvalues: (ref) v_u_87, (ref) v_u_4, (ref) v_u_61, (ref) v_u_50
			if p238:IsA("Tool") then
				task.wait()
				v_u_87()
				local v239 = v_u_4.Character
				local v240
				if v239 then
					v240 = v239:FindFirstChildOfClass("Tool")
					if v240 then
						if not (v240:FindFirstChild("IsFruitTool") and v240:FindFirstChild("FruitData")) then
							v240 = nil
						end
					else
						v240 = nil
					end
				else
					v240 = nil
				end
				v_u_61 = v240
				v_u_50.Visible = v240 ~= nil
			end
		end)
		p237.ChildRemoved:Connect(function(p241)
			-- upvalues: (ref) v_u_87, (ref) v_u_4, (ref) v_u_61, (ref) v_u_50
			if p241:IsA("Tool") then
				task.wait()
				v_u_87()
				local v242 = v_u_4.Character
				local v243
				if v242 then
					v243 = v242:FindFirstChildOfClass("Tool")
					if v243 then
						if not (v243:FindFirstChild("IsFruitTool") and v243:FindFirstChild("FruitData")) then
							v243 = nil
						end
					else
						v243 = nil
					end
				else
					v243 = nil
				end
				v_u_61 = v243
				v_u_50.Visible = v243 ~= nil
			end
		end)
		v_u_87()
		local v244 = v_u_4.Character
		local v245
		if v244 then
			v245 = v244:FindFirstChildOfClass("Tool")
			if v245 then
				if not (v245:FindFirstChild("IsFruitTool") and v245:FindFirstChild("FruitData")) then
					v245 = nil
				end
			else
				v245 = nil
			end
		else
			v245 = nil
		end
		v_u_61 = v245
		v_u_50.Visible = v245 ~= nil
		v_u_16:FireServer("GetStatus")
		v_u_17:FireServer("GetStatus")
	end
	v_u_4.CharacterAdded:Connect(v246)
	if v_u_4.Character then
		v246(v_u_4.Character)
	end
	v_u_4.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u_52, (copy) v_u_27
		v_u_52 = false
		local v247 = v_u_27:FindFirstChild("Txt")
		if v247 then
			v247.Text = "Sprint"
		end
	end)
else
	v25.Visible = false
end