local v885, v886 = pcall(function()
	local v_u_1 = game:GetService("Players")
	local v_u_2 = game:GetService("UserInputService")
	local v_u_3 = game:GetService("ReplicatedStorage")
	local v_u_4 = game:GetService("Debris")
	local v_u_5 = game:GetService("TweenService")
	local v_u_6 = game:GetService("RunService")
	local v_u_7 = v_u_1.LocalPlayer
	local v_u_8 = workspace.CurrentCamera
	local function v_u_34(p9, p10)
		-- upvalues: (copy) v_u_7, (copy) v_u_2, (copy) v_u_8
		local v11 = p9 or 50
		local _ = p10 == false
		local v12 = v_u_7.Character
		local v13
		if v12 then
			v13 = v12:FindFirstChild("HumanoidRootPart")
		else
			v13 = v12
		end
		if not v13 then
			return nil
		end
		local v14 = RaycastParams.new()
		v14.FilterDescendantsInstances = { v12 }
		v14.FilterType = Enum.RaycastFilterType.Exclude
		local v15 = v_u_7:GetMouse()
		local v16 = v_u_2:GetLastInputType()
		local v17
		if v16 == Enum.UserInputType.Touch or v16 == Enum.UserInputType.Gamepad1 then
			local v18 = Vector2.new(v_u_8.ViewportSize.X / 2, v_u_8.ViewportSize.Y / 2)
			v17 = v_u_8:ViewportPointToRay(v18.X, v18.Y)
		else
			v17 = v_u_8:ScreenPointToRay(v15.X, v15.Y)
		end
		local v19 = workspace:Raycast(v17.Origin, v17.Direction * 500, v14)
		local v20 = v19 and v19.Instance:FindFirstAncestorOfClass("Model")
		if v20 then
			local v21 = v20:FindFirstChildOfClass("Humanoid")
			local v22 = v20:FindFirstChild("HumanoidRootPart")
			if v21 and (v22 and (v21.Health > 0 and (v22.Position - v13.Position).Magnitude <= v11)) then
				return v20, v22
			end
		end
		local v23 = (1 / 0)
		local v24 = nil
		local v25 = nil
		for _, v26 in pairs(game:GetService("Players"):GetPlayers()) do
			if v26 ~= v_u_7 and v26.Character then
				local v27 = v26.Character:FindFirstChild("HumanoidRootPart")
				local v28 = v26.Character:FindFirstChildOfClass("Humanoid")
				if v27 and (v28 and v28.Health > 0) then
					local v29 = (v27.Position - v13.Position).Magnitude
					if v29 <= v11 and v29 < v23 then
						local _ = v26.Character
						if true then
							v24 = v26.Character
							v25 = v27
							v23 = v29
						end
					end
				end
			end
		end
		for _, v30 in pairs(workspace:GetDescendants()) do
			if v30:IsA("Model") and v30:FindFirstChild("HumanoidRootPart") then
				local v31 = v30:FindFirstChildOfClass("Humanoid")
				local v32 = v30:FindFirstChild("HumanoidRootPart")
				if v31 and (v32 and (v31.Health > 0 and v30 ~= v12)) then
					local v33 = (v32.Position - v13.Position).Magnitude
					if v33 <= v11 and v33 < v23 then
						v25 = v32
						v24 = v30
						v23 = v33
					end
				end
			end
		end
		return v24, v25
	end
	local v_u_35 = v_u_3:WaitForChild("AbilitySystem")
	local v_u_36 = require(v_u_35:WaitForChild("AbilityConfig"))
	local v_u_37 = require(v_u_3:WaitForChild("Modules"):WaitForChild("SoundManager"))
	local v_u_38 = game:GetService("ContentProvider")
	task.spawn(function()
		-- upvalues: (copy) v_u_35, (copy) v_u_38
		local v39 = v_u_35:FindFirstChild("Animations")
		if v39 then
			local v40 = {}
			for _, v41 in pairs(v39:GetChildren()) do
				for _, v42 in pairs(v41:GetDescendants()) do
					if v42:IsA("Animation") then
						table.insert(v40, v42)
					end
				end
			end
			if #v40 > 0 then
				v_u_38:PreloadAsync(v40)
			end
		end
	end)
	local v_u_43 = require(v_u_3:WaitForChild("Modules"):WaitForChild("UIStateManager"))
	local v_u_44 = {}
	local v_u_45 = {
		["Sukuna"] = { "SukunaZ", "SukunaX", "SukunaC_Tap" },
		["Gojo"] = {
			"GojoZ",
			"GojoX",
			"GojoC",
			"GojoV"
		},
		["Saber"] = { "SaberZ", "SaberX", "SaberC_Cast" },
		["Katana"] = { "KatanaZ" },
		["Ragna"] = {
			"RagnaZ",
			"RagnaX",
			"RagnaC_Startup",
			"RagnaV"
		},
		["Aizen"] = {
			"AizenZ",
			"AizenX",
			"AizenC",
			"AizenV"
		},
		["QinShi"] = { "QinShiZ", "QinShiX", "QinShiC" },
		["Shadow"] = {
			[5] = "ShadowF_Atomic"
		},
		["Alucard"] = { "AlucardZ", "AlucardX", "AlucardC" }
	}
	local v46 = v_u_35:WaitForChild("Remotes")
	local v47 = v_u_35:WaitForChild("VFXHandlers")
	local v_u_48 = v46.RequestAbility
	local v49 = v46.AbilityFeedback
	local v50 = v46:WaitForChild("AbilityStateChanged", 5)
	local v_u_51 = false
	if v50 then
		v50.OnClientEvent:Connect(function(p52)
			-- upvalues: (ref) v_u_51
			v_u_51 = p52
			if p52 == true then
				task.delay(15, function()
					-- upvalues: (ref) v_u_51
					if v_u_51 == true then
						v_u_51 = false
					end
				end)
			end
		end)
	end
	local v_u_53 = require(v_u_3:WaitForChild("CooldownUIManager"))
	local v_u_54 = false
	local v_u_55 = {
		"Z",
		"X",
		"C",
		"V",
		"F",
		"N"
	}
	local v_u_56 = {
		[Enum.KeyCode.ButtonX] = 1,
		[Enum.KeyCode.ButtonY] = 2,
		[Enum.KeyCode.ButtonB] = 3,
		[Enum.KeyCode.ButtonL2] = 4,
		[Enum.KeyCode.DPadRight] = 5
	}
	local v57 = v_u_3:FindFirstChild("RemoteEvents")
	if v57 then
		v57 = v57:FindFirstChild("ShadowFUnlockUpdate")
	end
	if v57 then
		v57.OnClientEvent:Connect(function(p58)
			-- upvalues: (copy) v_u_7
			v_u_7:SetAttribute("ShadowFUnlocked", p58)
		end)
	end
	local v59 = v_u_3:FindFirstChild("RemoteEvents")
	if v59 then
		v59 = v59:FindFirstChild("SukunaFUnlockUpdate")
	end
	if v59 then
		v59.OnClientEvent:Connect(function(p60)
			-- upvalues: (copy) v_u_7
			v_u_7:SetAttribute("SukunaFUnlocked", p60)
		end)
	end
	local v61 = v_u_3:FindFirstChild("RemoteEvents")
	if v61 then
		v61 = v61:FindFirstChild("GojoFUnlockUpdate")
	end
	if v61 then
		v61.OnClientEvent:Connect(function(p62)
			-- upvalues: (copy) v_u_7
			v_u_7:SetAttribute("GojoFUnlocked", p62)
		end)
	end
	local v63 = v_u_3:FindFirstChild("RemoteEvents")
	if v63 then
		v63 = v63:FindFirstChild("GilgameshFUnlockUpdate")
	end
	if v63 then
		v63.OnClientEvent:Connect(function(p64)
			-- upvalues: (copy) v_u_7
			v_u_7:SetAttribute("GilgameshFUnlocked", p64)
		end)
	end
	local function v66()
		-- upvalues: (ref) v_u_54, (copy) v_u_53, (copy) v_u_7
		task.wait(0.1)
		if not v_u_54 and pcall(function()
			-- upvalues: (ref) v_u_53
			v_u_53:Init()
		end) then
			v_u_54 = true
		end
		v_u_7:SetAttribute("FOVEffectActive", false)
		v_u_7:SetAttribute("FOVZoomActive", false)
		local v65 = workspace.CurrentCamera
		if v65 then
			v65.FieldOfView = 70
		end
	end
	v_u_7.CharacterAdded:Connect(v66)
	if v_u_7.Character then
		task.spawn(v66)
	end
	local v_u_67 = v_u_54
	local v_u_68 = {}
	local v69 = 0
	for _, v70 in v47:GetChildren() do
		if v70:IsA("ModuleScript") and not (string.find(v70.Name, "DISABLED") or string.find(v70.Name, "BEFORE")) then
			local v71, v72 = pcall(require, v70)
			if v71 then
				v_u_68[v70.Name] = v72
				v69 = v69 + 1
			else
				warn("[AbilityClient] Failed to load VFX handler:", v70.Name, "Error:", v72)
			end
		end
	end
	local function v_u_77()
		-- upvalues: (copy) v_u_7, (copy) v_u_36
		local v73 = v_u_7.Character
		if not v73 then
			return nil
		end
		local v74 = v73:FindFirstChildOfClass("Tool")
		if not v74 then
			return nil
		end
		for v75, v76 in pairs(v_u_36.Movesets) do
			if v76.ToolName and v76.ToolName == v74.Name then
				return v75
			end
		end
		return nil
	end
	local v_u_78 = {}
	local v_u_79 = nil
	local v_u_80 = 0
	local v_u_81 = nil
	local v_u_82 = nil
	local v_u_83 = 0
	local v_u_84 = 0.5
	local v_u_85 = nil
	local v_u_86 = false
	local v_u_87 = false
	local v_u_88 = {}
	local v_u_89 = false
	local v_u_90 = nil
	local v_u_91 = 0
	local v_u_92 = nil
	local v_u_93 = nil
	local v_u_94 = nil
	local v_u_95 = nil
	local v_u_96 = nil
	local v_u_97 = false
	local v_u_98 = false
	local v_u_99 = nil
	local v_u_100 = nil
	local v_u_101 = nil
	local v_u_102 = nil
	local function v_u_104()
		-- upvalues: (ref) v_u_101, (ref) v_u_102, (ref) v_u_90, (ref) v_u_91, (ref) v_u_92, (ref) v_u_93, (ref) v_u_94, (ref) v_u_99, (ref) v_u_100, (ref) v_u_97, (ref) v_u_98, (ref) v_u_95
		if v_u_101 then
			v_u_101:Stop(0)
			v_u_101 = nil
		end
		if v_u_102 then
			v_u_102:Stop()
			v_u_102 = nil
		end
		v_u_90 = nil
		v_u_91 = 0
		v_u_92 = nil
		v_u_93 = nil
		v_u_94 = nil
		local v103 = workspace.CurrentCamera
		if v103 then
			v103.FieldOfView = 70
		end
		if v_u_99 then
			v_u_99:Destroy()
			v_u_99 = nil
		end
		if v_u_100 then
			v_u_100:Destroy()
			v_u_100 = nil
		end
		v_u_97 = false
		v_u_98 = false
		v_u_95 = nil
	end
	local function v107(p105)
		-- upvalues: (copy) v_u_104
		local v106 = p105:WaitForChild("Humanoid", 5)
		if v106 then
			v106.Died:Connect(function()
				-- upvalues: (ref) v_u_104
				v_u_104()
			end)
		end
	end
	local v108 = v_u_7.Character and v_u_7.Character:WaitForChild("Humanoid", 5)
	if v108 then
		v108.Died:Connect(function()
			-- upvalues: (copy) v_u_104
			v_u_104()
		end)
	end
	v_u_7.CharacterAdded:Connect(v107)
	local function v_u_162(p109)
		-- upvalues: (copy) v_u_1, (ref) v_u_95, (ref) v_u_97, (ref) v_u_98, (copy) v_u_3, (copy) v_u_4, (ref) v_u_100, (copy) v_u_7, (copy) v_u_6, (ref) v_u_99, (ref) v_u_90, (ref) v_u_96, (copy) v_u_5, (ref) v_u_102, (copy) v_u_37
		local v_u_110 = workspace.CurrentCamera
		if v_u_110 then
			local v_u_111 = v_u_1.LocalPlayer.Character
			if v_u_111 then
				local v_u_112 = v_u_111:FindFirstChild("Right Arm") or v_u_111:FindFirstChild("RightHand")
				if v_u_112 and v_u_111:FindFirstChild("HumanoidRootPart") then
					v_u_95 = v_u_110.FieldOfView
					v_u_97 = false
					v_u_98 = false
					local v_u_113 = p109.ChargeTier2Time or 2
					local v_u_114 = p109.ChargeTier3Time or 4
					local v115 = v_u_3.AbilitySystem.VFX.Yuji.C
					local v116 = v115:FindFirstChild("ArmVFX1")
					local v_u_117 = v115:FindFirstChild("ArmVFX2")
					local v_u_118 = v115:FindFirstChild("ArmVFX3")
					local v_u_119 = v115:FindFirstChild("AuraVFX1")
					local v_u_120 = v115:FindFirstChild("AuraVFX2")
					local v_u_121 = v115:FindFirstChild("AuraVFX3")
					local v_u_122 = nil
					local v_u_123 = nil
					local v_u_124 = false
					local function v_u_129(p125)
						-- upvalues: (copy) v_u_112
						if not p125 then
							return nil
						end
						local v126 = p125:Clone()
						v126.CFrame = v_u_112.CFrame * CFrame.new(Vector3.new(0, -1, 0))
						v126.Anchored = false
						v126.CanCollide = false
						v126.CanQuery = false
						v126.CanTouch = false
						v126.Transparency = 1
						v126.Parent = workspace
						local v127 = Instance.new("WeldConstraint")
						v127.Part0 = v126
						v127.Part1 = v_u_112
						v127.Parent = v126
						for _, v128 in v126:GetDescendants() do
							if v128:IsA("ParticleEmitter") then
								v128.Enabled = true
								v128:Emit(v128:GetAttribute("EmitCount") or v128.Rate)
							end
						end
						return v126
					end
					local function v_u_135(p130)
						-- upvalues: (copy) v_u_111
						if not p130 then
							return nil
						end
						local v131 = v_u_111:FindFirstChild("HumanoidRootPart")
						if not v131 then
							return nil
						end
						local v132 = p130:Clone()
						v132.CFrame = v131.CFrame * CFrame.new(Vector3.new(0, -2.95, 0))
						v132.Anchored = false
						v132.CanCollide = false
						v132.CanQuery = false
						v132.CanTouch = false
						v132.Transparency = 1
						v132.Parent = workspace
						local v133 = Instance.new("WeldConstraint")
						v133.Part0 = v132
						v133.Part1 = v131
						v133.Parent = v132
						for _, v134 in v132:GetDescendants() do
							if v134:IsA("ParticleEmitter") then
								v134.Enabled = true
								v134:Emit(v134:GetAttribute("EmitCount") or v134.Rate)
							end
						end
						return v132
					end
					local function v_u_138(p136)
						if p136 then
							for _, v137 in p136:GetDescendants() do
								if v137:IsA("ParticleEmitter") then
									v137.Enabled = false
								end
							end
						end
					end
					v_u_122 = v_u_129(v116)
					v_u_99 = v_u_122
					task.delay(0.15, function()
						-- upvalues: (ref) v_u_90, (ref) v_u_124, (ref) v_u_123, (copy) v_u_135, (copy) v_u_119, (ref) v_u_100
						if v_u_90 then
							if not v_u_124 then
								v_u_124 = true
								v_u_123 = v_u_135(v_u_119)
								v_u_100 = v_u_123
							end
						else
							return
						end
					end)
					local v139 = 4 * v_u_114
					v_u_96 = v_u_5:Create(v_u_110, TweenInfo.new(v_u_114, Enum.EasingStyle.Linear), {
						["FieldOfView"] = v_u_95 + v139
					})
					v_u_96:Play()
					task.spawn(function()
						-- upvalues: (ref) v_u_90, (ref) v_u_97, (copy) v_u_113, (ref) v_u_7, (copy) v_u_110, (ref) v_u_6, (copy) v_u_117, (ref) v_u_122, (copy) v_u_129, (copy) v_u_138, (ref) v_u_4, (ref) v_u_99, (copy) v_u_120, (ref) v_u_123, (copy) v_u_135, (ref) v_u_100, (ref) v_u_96, (ref) v_u_5, (copy) v_u_114, (ref) v_u_98, (copy) v_u_118, (copy) v_u_121, (ref) v_u_102, (ref) v_u_37
						local v140 = tick()
						while v_u_90 do
							local v141 = tick() - v140
							if not v_u_97 and v_u_113 <= v141 then
								v_u_97 = true
								if not v_u_7:GetAttribute("DisableScreenShake") then
									local v_u_142 = 0.3
									local v_u_143 = 6
									task.spawn(function()
										-- upvalues: (copy) v_u_142, (copy) v_u_143, (ref) v_u_110, (ref) v_u_6
										local v144 = tick()
										while tick() - v144 < v_u_142 do
											local v145 = v_u_143 * (1 - (tick() - v144) / v_u_142) * 0.01
											local v146 = (math.random() - 0.5) * 2 * v145
											local v147 = (math.random() - 0.5) * 2 * v145
											v_u_110.CFrame = v_u_110.CFrame * CFrame.new(v146, v147, 0)
											v_u_6.RenderStepped:Wait()
										end
									end)
								end
								local v148 = v_u_122
								v_u_122 = v_u_129(v_u_117)
								if v148 then
									v_u_138(v148)
									v_u_4:AddItem(v148, 0.5)
								end
								v_u_99 = v_u_122
								local v149 = v_u_123
								v_u_123 = v_u_135(v_u_120)
								v_u_100 = v_u_123
								if v149 then
									v_u_138(v149)
									v_u_4:AddItem(v149, 0.5)
								end
								if v_u_96 then
									v_u_96:Pause()
								end
								local v150 = v_u_5:Create(v_u_110, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_110.FieldOfView + 5
								})
								v150:Play()
								v150.Completed:Wait()
								if v_u_90 then
									local v151 = v_u_114 - v141
									local v152 = {
										["FieldOfView"] = v_u_110.FieldOfView + 4 * v151
									}
									v_u_96 = v_u_5:Create(v_u_110, TweenInfo.new(v151, Enum.EasingStyle.Linear), v152)
									v_u_96:Play()
								end
							end
							if not v_u_98 and v_u_114 <= v141 then
								v_u_98 = true
								if not v_u_7:GetAttribute("DisableScreenShake") then
									local v_u_153 = 0.3
									local v_u_154 = 10
									task.spawn(function()
										-- upvalues: (copy) v_u_153, (copy) v_u_154, (ref) v_u_110, (ref) v_u_6
										local v155 = tick()
										while tick() - v155 < v_u_153 do
											local v156 = v_u_154 * (1 - (tick() - v155) / v_u_153) * 0.01
											local v157 = (math.random() - 0.5) * 2 * v156
											local v158 = (math.random() - 0.5) * 2 * v156
											v_u_110.CFrame = v_u_110.CFrame * CFrame.new(v157, v158, 0)
											v_u_6.RenderStepped:Wait()
										end
									end)
								end
								local v159 = v_u_122
								v_u_122 = v_u_129(v_u_118)
								if v159 then
									v_u_138(v159)
									v_u_4:AddItem(v159, 0.5)
								end
								v_u_99 = v_u_122
								local v160 = v_u_123
								v_u_123 = v_u_135(v_u_121)
								v_u_100 = v_u_123
								if v160 then
									v_u_138(v160)
									v_u_4:AddItem(v160, 0.5)
								end
								local v161 = v_u_7.Character
								if v161 then
									v161 = v161:FindFirstChild("HumanoidRootPart")
								end
								v_u_102 = v161 and v_u_37:PlayAt("YujiC_HoldLoop", v161.Position)
								if v_u_102 then
									v_u_102.Looped = true
								end
								if v_u_96 then
									v_u_96:Cancel()
									v_u_96 = nil
								end
								v_u_5:Create(v_u_110, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_110.FieldOfView + 5
								}):Play()
							end
							task.wait(0.05)
						end
					end)
				end
			else
				return
			end
		else
			return
		end
	end
	local function v_u_167()
		-- upvalues: (ref) v_u_96, (ref) v_u_99, (copy) v_u_4, (ref) v_u_100, (ref) v_u_95, (copy) v_u_5, (ref) v_u_97, (ref) v_u_98
		if v_u_96 then
			v_u_96:Cancel()
			v_u_96 = nil
		end
		if v_u_99 and v_u_99.Parent then
			for _, v163 in v_u_99:GetDescendants() do
				if v163:IsA("ParticleEmitter") then
					v163.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_99, 0.15)
		end
		v_u_99 = nil
		if v_u_100 and v_u_100.Parent then
			for _, v164 in v_u_100:GetDescendants() do
				if v164:IsA("ParticleEmitter") then
					v164.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_100, 0.15)
		end
		v_u_100 = nil
		local v165 = workspace.CurrentCamera
		if v165 and v_u_95 then
			local v166 = {
				["FieldOfView"] = v_u_95
			}
			v_u_5:Create(v165, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v166):Play()
		end
		v_u_95 = nil
		v_u_97 = false
		v_u_98 = false
	end
	local function v_u_177(_, p168, p169, p170, p171)
		local v172 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p171 or "Gojo")
		if v172 then
			v172 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p171 or "Gojo"):FindFirstChild("C")
		end
		if not v172 then
			return nil
		end
		local v173 = v172:FindFirstChild(p168)
		if not v173 then
			return nil
		end
		local v174 = v173:Clone()
		v174.CFrame = p169.CFrame
		v174.Anchored = false
		v174.CanCollide = false
		v174.Transparency = 1
		v174.Parent = workspace
		local v175 = Instance.new("WeldConstraint")
		v175.Part0 = p169
		v175.Part1 = v174
		v175.Parent = v174
		for _, v176 in pairs(v174:GetDescendants()) do
			if v176:IsA("ParticleEmitter") then
				v176.Enabled = true
			end
		end
		game:GetService("Debris"):AddItem(v174, p170)
		return v174
	end
	local function v_u_180()
		-- upvalues: (ref) v_u_88
		for _, v178 in pairs(v_u_88) do
			if v178 and v178.Parent then
				for _, v179 in pairs(v178:GetDescendants()) do
					if v179:IsA("ParticleEmitter") then
						v179.Enabled = false
					end
				end
				game:GetService("Debris"):AddItem(v178, 0.5)
			end
		end
		v_u_88 = {}
	end
	local function v_u_189(p181, p182, p_u_183)
		-- upvalues: (copy) v_u_5
		local v184 = workspace.CurrentCamera
		if v184 then
			local v_u_185 = v184.FieldOfView
			local v186 = {
				["FieldOfView"] = v_u_185 + p181
			}
			v_u_5:Create(v184, TweenInfo.new(p182, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), v186):Play()
			task.delay(p182, function()
				-- upvalues: (ref) v_u_5, (copy) p_u_183, (copy) v_u_185
				local v187 = workspace.CurrentCamera
				if v187 then
					local v188 = {
						["FieldOfView"] = v_u_185
					}
					v_u_5:Create(v187, TweenInfo.new(p_u_183, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v188):Play()
				end
			end)
		end
	end
	local function v_u_200(p190)
		-- upvalues: (copy) v_u_180, (copy) v_u_189, (copy) v_u_177, (ref) v_u_82, (ref) v_u_88
		v_u_180()
		v_u_189(10, 0.12, 0.5)
		task.delay(9.5, function()
			-- upvalues: (ref) v_u_189
			v_u_189(10, 0.12, 0.5)
		end)
		local v191 = p190:FindFirstChild("Torso") or p190:FindFirstChild("UpperTorso")
		local v192 = p190:FindFirstChild("Right Arm") or p190:FindFirstChild("RightUpperArm")
		local v193 = p190:FindFirstChild("Left Arm") or p190:FindFirstChild("LeftUpperArm")
		local v194 = v191 and v_u_177(p190, "DamageVFX", v191, 10, v_u_82)
		if v194 then
			local v195 = v_u_88
			table.insert(v195, v194)
		end
		local v196 = v192 and v_u_177(p190, "ArmVFX", v192, 10, v_u_82)
		if v196 then
			local v197 = v_u_88
			table.insert(v197, v196)
		end
		local v198 = v193 and v_u_177(p190, "ArmVFX", v193, 10, v_u_82)
		if v198 then
			local v199 = v_u_88
			table.insert(v199, v198)
		end
	end
	local function v_u_205(p201)
		-- upvalues: (copy) v_u_180, (ref) v_u_89, (copy) v_u_189, (copy) v_u_177, (ref) v_u_82, (ref) v_u_88
		v_u_180()
		v_u_89 = true
		v_u_189(10, 0.12, 0.5)
		task.delay(5.5, function()
			-- upvalues: (ref) v_u_89, (ref) v_u_189
			if v_u_89 then
				v_u_189(10, 0.12, 0.5)
			end
			v_u_89 = false
		end)
		local v202 = p201:FindFirstChild("Torso") or p201:FindFirstChild("UpperTorso")
		local v203 = v202 and v_u_177(p201, "HealVFX", v202, 6, v_u_82)
		if v203 then
			local v204 = v_u_88
			table.insert(v204, v203)
		end
	end
	v_u_2.InputBegan:Connect(function(p206, p207)
		-- upvalues: (ref) v_u_51, (copy) v_u_43, (copy) v_u_7, (copy) v_u_36, (copy) v_u_56, (copy) v_u_77, (copy) v_u_78, (ref) v_u_79, (ref) v_u_80, (ref) v_u_81, (ref) v_u_82, (ref) v_u_83, (ref) v_u_84, (ref) v_u_87, (copy) v_u_200, (ref) v_u_85, (copy) v_u_205, (ref) v_u_86, (copy) v_u_45, (copy) v_u_37, (copy) v_u_48, (ref) v_u_90, (ref) v_u_91, (ref) v_u_92, (ref) v_u_93, (ref) v_u_94, (copy) v_u_162, (copy) v_u_3, (ref) v_u_101, (copy) v_u_167, (copy) v_u_34, (copy) v_u_2
		if p207 then
			return
		elseif v_u_51 then
			return
		elseif v_u_43.InArtifactUI then
			return
		else
			local v208 = v_u_7.Character
			if v208 and v208:GetAttribute("InArtifactUI") then
				return
			elseif v208 and v208:GetAttribute("InCutscene") then
				return
			else
				local v209 = v_u_36.Keybinds[p206.KeyCode] or v_u_56[p206.KeyCode]
				if v209 then
					local v210 = v_u_77()
					local v211 = game:GetService("RunService"):IsStudio()
					if v209 == 5 and (v210 == "Shadow" and not v211) and v_u_7:GetAttribute("ShadowFUnlocked") ~= true then
						return
					elseif v209 == 5 and (v210 == "StrongestInHistory" and not v211) and v_u_7:GetAttribute("SukunaFUnlocked") ~= true then
						return
					elseif v209 == 5 and (v210 == "StrongestOfToday" and not v211) and v_u_7:GetAttribute("GojoFUnlocked") ~= true then
						return
					elseif v209 == 5 and (v210 == "Rimuru" and not v211) and v_u_7:GetAttribute("RimuruFUnlocked") ~= true then
						return
					elseif v209 == 5 and (v210 == "Gilgamesh" and not v211) and v_u_7:GetAttribute("GilgameshFUnlocked") ~= true then
						return
					elseif v210 then
						local v212 = v_u_36.Movesets[v210]
						if v212 and v212.Abilities[v209] then
							local v213 = v212.Abilities[v209]
							if v213.Type == "HoldVariant" then
								local v214 = v_u_78[v210 .. "_" .. v209]
								local v215
								if v214 and tick() < v214 then
									local _ = v214 - tick()
									v215 = true
								else
									v215 = false
								end
								if not v215 then
									v_u_79 = p206.KeyCode
									v_u_80 = tick()
									v_u_81 = v209
									v_u_82 = v210
									v_u_83 = 1
									v_u_84 = v213.HoldThreshold or 0.5
									v_u_87 = false
									local v216 = v_u_7.Character
									if v216 then
										v_u_200(v216)
									end
									if v_u_85 then
										v_u_85:Disconnect()
									end
									v_u_85 = game:GetService("RunService").Heartbeat:Connect(function()
										-- upvalues: (ref) v_u_79, (ref) v_u_85, (ref) v_u_80, (ref) v_u_84, (ref) v_u_83, (ref) v_u_87, (ref) v_u_7, (ref) v_u_205, (ref) v_u_36, (ref) v_u_82, (ref) v_u_81, (ref) v_u_78, (ref) v_u_86, (ref) v_u_45, (ref) v_u_37, (ref) v_u_48
										if v_u_79 then
											if v_u_84 <= tick() - v_u_80 and (v_u_83 == 1 and not v_u_87) then
												v_u_83 = 2
												v_u_87 = true
												local v217 = v_u_7.Character
												if v217 then
													v_u_205(v217)
												end
												local v218 = v_u_36.Movesets[v_u_82]
												if v218 then
													v218 = v218.Abilities[v_u_81]
												end
												if v218 and v218.Cooldown then
													local v219 = v_u_82
													local v220 = v_u_81
													local v221 = v218.Cooldown
													v_u_78[v219 .. "_" .. v220] = tick() + v221
												end
												v_u_86 = true
												local v222 = v_u_82
												local v223 = v_u_81
												local v224 = v_u_45[v222]
												local v225 = v224 and v224[v223]
												if v225 then
													if v223 == 3 then
														v225 = v222 == "Sukuna" and "SukunaC_Hold" or (v222 == "Gojo" and "GojoC_Hold" or v225)
													end
													v_u_37:Play(v225)
												end
												v_u_48:FireServer(v_u_81, {
													["Variant"] = 2
												})
											end
										else
											if v_u_85 then
												v_u_85:Disconnect()
											end
											v_u_85 = nil
										end
									end)
								end
							elseif v213.Type == "ChargedInstant" then
								local v226 = v_u_78[v210 .. "_" .. v209]
								local v227
								if v226 and tick() < v226 then
									local _ = v226 - tick()
									v227 = true
								else
									v227 = false
								end
								if not v227 then
									v_u_90 = p206.KeyCode
									v_u_91 = tick()
									v_u_92 = v209
									v_u_93 = v210
									v_u_94 = v213
									v_u_162(v213)
									if v210 == "Yuji" and v209 == 3 then
										local v228 = v_u_7.Character
										if v228 then
											v228 = v228:FindFirstChild("HumanoidRootPart")
										end
										if v228 then
											v_u_37:PlayAt("YujiC_HoldStart", v228.Position)
										end
										task.delay(0.15, function()
											-- upvalues: (ref) v_u_90, (ref) v_u_92, (ref) v_u_7, (ref) v_u_3, (ref) v_u_101
											if v_u_90 then
												if v_u_92 == 3 then
													local v229 = v_u_7.Character
													if v229 then
														v229 = v229:FindFirstChildOfClass("Humanoid")
													end
													if v229 then
														local v230 = v229:FindFirstChildOfClass("Animator") or Instance.new("Animator", v229)
														local v231 = v_u_3.AbilitySystem.Animations:FindFirstChild("Yuji")
														if v231 then
															v231 = v231:FindFirstChild("Yuji_C_Anim_Hold")
														end
														if v231 then
															if v_u_101 then
																v_u_101:Stop(0)
																v_u_101 = nil
															end
															v_u_101 = v230:LoadAnimation(v231)
															v_u_101.Priority = Enum.AnimationPriority.Action4
															v_u_101.Looped = true
															v_u_101:Play()
														end
													end
												end
											else
												return
											end
										end)
									end
								end
							else
								local v232 = v_u_78[v210 .. "_" .. v209]
								local v233
								if v232 and tick() < v232 then
									local _ = v232 - tick()
									v233 = true
								else
									v233 = false
								end
								if v233 then
									return
								else
									if v_u_90 then
										v_u_167()
										if v_u_101 then
											v_u_101:Stop(0)
											v_u_101 = nil
										end
										v_u_90 = nil
										v_u_91 = 0
										v_u_92 = nil
										v_u_93 = nil
										v_u_94 = nil
									end
									if v213.Type == "TargetedCutscene" then
										local v234, v235 = v_u_34(v213.TargetRange or 30)
										if v234 then
											local v236 = v_u_78[v210 .. "_" .. v209]
											local v237
											if v236 and tick() < v236 then
												local _ = v236 - tick()
												v237 = true
											else
												v237 = false
											end
											if not v237 then
												v_u_48:FireServer(v209, {
													["TargetName"] = v234.Name,
													["TargetPosition"] = v235.Position
												})
											end
										else
											if v_u_2:GetLastInputType() == Enum.UserInputType.Gamepad1 then
												local v238 = v_u_3:FindFirstChild("Remotes")
												if v238 then
													v238 = v_u_3.Remotes:FindFirstChild("ShowNotification")
												end
												if v238 then
													v238:FireServer("Ability", {
														["message"] = "No target in range",
														["duration"] = 1.5
													})
												end
											end
											return
										end
									else
										if v210 == "Shadow" then
											local v239 = v_u_78[v210 .. "_" .. v209]
											local v240
											if v239 and tick() < v239 then
												local _ = v239 - tick()
												v240 = true
											else
												v240 = false
											end
											if not v240 then
												if v209 == 2 then
													v_u_37:Play("ShadowX_Dash")
												elseif v209 == 4 then
													v_u_37:Play("ShadowV_Ultimate")
												end
											end
										end
										v_u_48:FireServer(v209)
										return
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
		end
	end)
	v_u_2.InputEnded:Connect(function(p241, _)
		-- upvalues: (ref) v_u_90, (ref) v_u_91, (ref) v_u_93, (ref) v_u_92, (ref) v_u_94, (copy) v_u_167, (ref) v_u_101, (ref) v_u_102, (copy) v_u_78, (copy) v_u_48, (ref) v_u_79, (ref) v_u_83, (ref) v_u_82, (ref) v_u_81, (ref) v_u_87, (ref) v_u_80, (ref) v_u_84, (ref) v_u_85, (copy) v_u_36, (ref) v_u_86, (copy) v_u_45, (copy) v_u_37
		if v_u_90 and p241.KeyCode == v_u_90 then
			local v242 = tick() - v_u_91
			local v243 = v_u_93
			local v244 = v_u_92
			local v245 = v_u_94
			v_u_167()
			if v_u_101 then
				v_u_101:Stop(0.1)
				v_u_101 = nil
			end
			if v_u_102 then
				v_u_102:Stop()
				v_u_102 = nil
			end
			_G.YujiCharging = false
			v_u_90 = nil
			v_u_91 = 0
			v_u_92 = nil
			v_u_93 = nil
			v_u_94 = nil
			if v243 and (v244 and v245) then
				local v246 = (v245.ChargeTier3Time or 5) <= v242 and 3 or ((v245.ChargeTier2Time or 2.5) <= v242 and 2 or 1)
				if v245.Cooldown then
					local v247 = v245.Cooldown
					v_u_78[v243 .. "_" .. v244] = tick() + v247
				end
				v_u_48:FireServer(v244, {
					["ChargeTier"] = v246,
					["HoldDuration"] = v242
				})
			end
		elseif v_u_79 then
			if p241.KeyCode == v_u_79 then
				local v248 = v_u_82
				local v249 = v_u_81
				local v250 = v_u_87
				v_u_79 = nil
				v_u_80 = 0
				v_u_81 = nil
				v_u_82 = nil
				v_u_83 = 0
				v_u_84 = 0.5
				v_u_87 = false
				if v_u_85 then
					v_u_85:Disconnect()
					v_u_85 = nil
				end
				if v248 and v249 then
					if not v250 then
						local v251 = v_u_36.Movesets[v248]
						if v251 then
							v251 = v251.Abilities[v249]
						end
						if v251 and v251.Cooldown then
							local v252 = v251.Cooldown
							v_u_78[v248 .. "_" .. v249] = tick() + v252
						end
						v_u_86 = true
						local v253 = v_u_45[v248]
						local v254 = v253 and v253[v249]
						if v254 then
							local _ = v249 == 3
							v_u_37:Play(v254)
						end
						v_u_48:FireServer(v249, {
							["Variant"] = 1
						})
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
	end)
	local v_u_255 = workspace:GetServerTimeNow()
	v49.OnClientEvent:Connect(function(p_u_256)
		-- upvalues: (copy) v_u_255, (copy) v_u_7, (ref) v_u_89, (copy) v_u_180, (ref) v_u_67, (copy) v_u_53, (copy) v_u_55, (copy) v_u_36, (ref) v_u_51, (copy) v_u_78, (ref) v_u_86, (copy) v_u_45, (copy) v_u_37, (copy) v_u_68
		if workspace:GetServerTimeNow() - v_u_255 < 2 and p_u_256.Caster ~= v_u_7 then
			return
		elseif p_u_256.Timestamp and p_u_256.Timestamp < v_u_255 then
			return
		elseif p_u_256.Type == "HealingInterrupted" and p_u_256.Caster == v_u_7 then
			v_u_89 = false
			v_u_180()
			return
		elseif p_u_256.Type == "Hit" then
			return
		else
			local v257 = false
			if p_u_256.Caster == v_u_7 and p_u_256.Cooldown then
				if not v_u_67 and pcall(function()
					-- upvalues: (ref) v_u_53
					v_u_53:Init()
				end) then
					v_u_67 = true
				end
				local v258 = p_u_256.MovesetName or "Ability"
				local v259 = v_u_55[p_u_256.Keybind or 1] or "Z"
				v_u_53:StartCooldown(v258, p_u_256.AbilityName, v259, p_u_256.Cooldown)
			end
			if p_u_256.Caster == v_u_7 and (p_u_256.AbilitySlot and p_u_256.MovesetName) then
				local v260 = v_u_36.Movesets[p_u_256.MovesetName]
				if v260 then
					v260 = v260.Abilities[p_u_256.AbilitySlot]
				end
				if v260 then
					local v261
					if v260.Type == "HoldVariant" then
						v261 = false
					else
						v261 = v260.Type ~= "Toggle"
					end
					if v260.AbilityLockDuration == 0 then
						v261 = false
					end
					if v261 then
						v_u_51 = true
						local v262 = (v260.ChargeTime or v260.Duration or (v260.MovementLockDuration or 5)) + 2
						local v263 = math.max(v262, 5)
						task.delay(v263, function()
							-- upvalues: (ref) v_u_51
							if v_u_51 == true then
								v_u_51 = false
							end
						end)
					end
					if p_u_256.Cooldown then
						local v264 = p_u_256.MovesetName
						local v265 = p_u_256.AbilitySlot
						local v266 = p_u_256.Cooldown
						v_u_78[v264 .. "_" .. v265] = tick() + v266
					end
					if v260.Type == "HoldVariant" then
						v257 = v_u_86
					else
						v257 = false
					end
					if not v257 then
						local v267 = p_u_256.MovesetName
						local v268 = p_u_256.AbilitySlot
						local v269 = p_u_256.Variant
						local v270 = v_u_45[v267]
						local v271 = v270 and v270[v268]
						if v271 then
							if v268 == 3 and v269 == 2 then
								v271 = v267 == "Sukuna" and "SukunaC_Hold" or (v267 == "Gojo" and "GojoC_Hold" or v271)
							end
							v_u_37:Play(v271)
						end
					end
					if v260.Type == "HoldVariant" then
						v_u_86 = false
					end
				end
			end
			local v272 = p_u_256.Caster
			local v273 = p_u_256.MovesetName
			local v274 = p_u_256.AbilityName
			if v272 and v272.Character then
				local v275 = v_u_36.Movesets[v273]
				if v275 then
					v275 = v275.Abilities[p_u_256.AbilitySlot]
				end
				local v276
				if v275 then
					v276 = v275.Type == "HoldVariant"
				else
					v276 = v275
				end
				local v277 = p_u_256.Caster == v_u_7
				if v276 and (v277 and v257) then
					return
				else
					p_u_256.SkipLocalVFX = v257
					local v278 = v_u_68[v273]
					if not v_u_7:GetAttribute("DisableOtherVFX") or v272 == v_u_7 then
						if v278 then
							local v_u_279 = v278[v274]
							if v_u_279 then
								task.spawn(function()
									-- upvalues: (copy) v_u_279, (copy) p_u_256
									local v280, v281 = pcall(v_u_279, p_u_256)
									if not v280 then
										warn("[AbilityClient] VFX error:", v281)
									end
								end)
							else
								warn("[AbilityClient] No handler for " .. v274)
							end
						else
							warn("[AbilityClient] No VFX handler for moveset " .. v273)
						end
						if v275 and (v275.Type == "ContinuousDamage" and (v277 and not (v275.AnchorHitbox or (p_u_256.AnchorHitbox or (v275.DirectDamage or v275.WorldAnchorHitbox))))) then
							local v_u_282 = v272.Character
							local v_u_283 = p_u_256.HitboxSize or (v275.HitboxSize or Vector3.new(30, 15, 30))
							local v_u_284 = p_u_256.HitboxOffset or (v275.HitboxOffset or Vector3.new(0, 0, 0))
							local v_u_285 = p_u_256.DamageDuration or (v275.Duration or 3)
							local v286 = p_u_256.DamageDelay or (v275.DamageDelay or 0)
							if v_u_282 then
								local v_u_287 = require(game:GetService("ReplicatedStorage"):WaitForChild("HitboxVisualizer"))
								task.delay(v286, function()
									-- upvalues: (copy) v_u_282, (copy) v_u_287, (copy) v_u_283, (copy) v_u_285, (copy) v_u_284
									if v_u_282 and v_u_282.Parent then
										v_u_287.ShowFollowingAOE(v_u_282, v_u_283, v_u_285, v_u_284)
									end
								end)
							end
						end
					end
				end
			else
				return
			end
		end
	end)
	local v_u_288 = require(v_u_3:WaitForChild("VFXService"))
	local v_u_289 = game:GetService("TweenService")
	local function v_u_294(p290)
		-- upvalues: (copy) v_u_7, (copy) v_u_289
		local v291 = v_u_7.PlayerGui:FindFirstChild("ScreenEffects")
		if not v291 then
			v291 = Instance.new("ScreenGui")
			v291.Name = "ScreenEffects"
			v291.IgnoreGuiInset = true
			v291.DisplayOrder = 10
			v291.Parent = v_u_7.PlayerGui
		end
		local v_u_292 = Instance.new("Frame")
		v_u_292.Size = UDim2.new(1, 0, 1, 0)
		v_u_292.BackgroundColor3 = p290.Color or Color3.new(1, 1, 1)
		v_u_292.BackgroundTransparency = 0.7
		v_u_292.BorderSizePixel = 0
		v_u_292.Parent = v291
		local v293 = v_u_289:Create(v_u_292, TweenInfo.new(p290.Duration or 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 1
		})
		v293:Play()
		v293.Completed:Connect(function()
			-- upvalues: (copy) v_u_292
			v_u_292:Destroy()
		end)
	end
	local v_u_295 = {}
	local function v_u_773(p_u_296)
		-- upvalues: (copy) v_u_3, (copy) v_u_68, (copy) v_u_295, (copy) v_u_37
		local v_u_297 = game:GetService("Debris")
		game:GetService("TweenService")
		local v_u_298 = game:GetService("TweenService")
		local v299 = v_u_3:FindFirstChild("AbilitySystem")
		if v299 then
			local v300 = v299:FindFirstChild("VFX")
			if v300 then
				local v_u_301 = p_u_296.MovesetType or "Saber"
				local v_u_302 = v300:FindFirstChild(v_u_301) or v300:FindFirstChild("Saber")
				if v_u_302 then
					local v303 = p_u_296.Position
					CFrame.new(v303)
					if p_u_296.LookVector then
						CFrame.lookAt(v303, v303 + p_u_296.LookVector)
					end
					local v_u_304 = p_u_296.NPCModel
					if v_u_304 then
						v_u_304 = workspace.NPCs:FindFirstChild(p_u_296.NPCModel) or workspace:FindFirstChild(p_u_296.NPCModel)
					end
					local v_u_305
					if v_u_304 then
						v_u_305 = v_u_304:FindFirstChild("HumanoidRootPart")
					else
						v_u_305 = v_u_304
					end
					local function v_u_311(p306, p307, p308)
						-- upvalues: (copy) v_u_297
						local v309 = p306:Clone()
						v309.CFrame = p307
						v309.Anchored = true
						v309.CanCollide = false
						v309.Transparency = 1
						v309.CastShadow = false
						v309.CanQuery = false
						v309.Parent = workspace
						v_u_297:AddItem(v309, p308)
						for _, v310 in v309:GetDescendants() do
							if v310:IsA("ParticleEmitter") then
								v310:Emit(v310:GetAttribute("EmitCount") or 20)
							end
						end
						return v309
					end
					local function v_u_317(p312, p313)
						-- upvalues: (copy) v_u_298
						local v314 = TweenInfo.new(p313, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						for _, v315 in p312:GetDescendants() do
							if v315:IsA("Beam") then
								local v316 = v315.Width0
								v315.Width0 = 0
								v315.Width1 = 0
								v315.Enabled = true
								v_u_298:Create(v315, v314, {
									["Width0"] = v316,
									["Width1"] = v316
								}):Play()
							end
						end
					end
					local function v_u_323(p318, p319)
						-- upvalues: (copy) v_u_298
						local v320 = TweenInfo.new(p319, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
						for _, v_u_321 in p318:GetDescendants() do
							if v_u_321:IsA("Beam") then
								local v322 = v_u_298:Create(v_u_321, v320, {
									["Width0"] = 0,
									["Width1"] = 0
								})
								v322:Play()
								v322.Completed:Once(function()
									-- upvalues: (copy) v_u_321
									v_u_321.Enabled = false
								end)
							end
						end
					end
					if p_u_296.VFXName == "Z" then
						task.spawn(function()
							-- upvalues: (copy) v_u_305, (copy) v_u_301, (copy) v_u_304, (ref) v_u_302, (copy) v_u_297, (copy) v_u_298, (ref) v_u_68, (ref) v_u_3, (copy) v_u_311
							if v_u_305 and v_u_305.Parent then
								if v_u_301 == "Gojo" then
									local v_u_324 = v_u_304:FindFirstChild("Right Arm")
									if v_u_324 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_302, (copy) v_u_324, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v325 = v_u_302.Z:FindFirstChild("RedVFXFirst")
												if v325 then
													local v326 = v325:Clone()
													v326.CFrame = v_u_324.CFrame * CFrame.new(0, -1.05, 0)
													v326.Anchored = true
													v326.CanCollide = false
													v326.Transparency = 1
													v326.CastShadow = false
													v326.CanQuery = false
													v326.Parent = workspace
													v_u_297:AddItem(v326, 4)
													for _, v_u_327 in v326:GetDescendants() do
														if v_u_327:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_327
																local v328 = v_u_327:GetAttribute("EmitDelay") or 0
																task.wait(v328)
																v_u_327:Emit(v_u_327:GetAttribute("EmitCount") or v_u_327.Rate)
															end)
														end
													end
													v326.Anchored = false
													local v329 = Instance.new("WeldConstraint")
													v329.Part0 = v_u_324
													v329.Part1 = v326
													v329.Parent = v326
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_302, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v330 = v_u_302.Z:FindFirstChild("RedVFX")
												if v330 then
													local v331 = v330:Clone()
													v331.CFrame = v_u_305.CFrame * CFrame.new(0, 1, -10)
													v331.Anchored = true
													v331.CanCollide = false
													v331.Transparency = 1
													v331.CastShadow = false
													v331.CanQuery = false
													v331.Parent = workspace
													v_u_297:AddItem(v331, 3)
													for _, v_u_332 in v331:GetDescendants() do
														if v_u_332:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_332
																local v333 = v_u_332:GetAttribute("EmitDelay") or 0
																task.wait(v333)
																v_u_332:Emit(v_u_332:GetAttribute("EmitCount") or v_u_332.Rate)
															end)
														end
													end
												end
											else
												return
											end
										end)
									end
								elseif v_u_301 == "Sukuna" then
									local v_u_334 = v_u_302.Z
									if v_u_334 then
										local v335 = v_u_305.Position + Vector3.new(0, 1, 0)
										local v_u_336 = v_u_305.CFrame.LookVector
										local v337 = v_u_334:FindFirstChild("StartExplosionVFX")
										if v337 then
											local v338 = v337:Clone()
											v338.CFrame = CFrame.new(v335) * CFrame.Angles(0, 1.5707963267948966, 0)
											v338.Anchored = true
											v338.CanCollide = false
											v338.Transparency = 1
											v338.Parent = workspace
											v_u_297:AddItem(v338, 3)
											for _, v_u_339 in v338:GetDescendants() do
												task.spawn(function()
													-- upvalues: (copy) v_u_339
													if v_u_339:IsA("ParticleEmitter") then
														local v340 = v_u_339:GetAttribute("EmitDelay") or 0
														if v340 > 0 then
															task.wait(v340)
														end
														v_u_339:Emit(v_u_339:GetAttribute("EmitCount") or v_u_339.Rate)
													end
												end)
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_336, (copy) v_u_334, (ref) v_u_297, (ref) v_u_298
											if v_u_305 and v_u_305.Parent then
												local v341 = v_u_305.Position + v_u_336 * 3 + Vector3.new(0, 1, 0)
												local v342 = v_u_305.Position + v_u_336 * 65 + Vector3.new(0, 1, 0)
												local v343 = v_u_334:FindFirstChild("DismantleVFX")
												if v343 then
													local v_u_344 = v343:Clone()
													v_u_344.CFrame = CFrame.new(v341, v342)
													v_u_344.Anchored = true
													v_u_344.CanCollide = false
													v_u_344.Transparency = 1
													v_u_344.Parent = workspace
													v_u_297:AddItem(v_u_344, 2)
													for _, v345 in v_u_344:GetDescendants() do
														if v345:IsA("ParticleEmitter") then
															v345.Enabled = true
														end
													end
													v_u_298:Create(v_u_344, TweenInfo.new(1, Enum.EasingStyle.Linear), {
														["CFrame"] = CFrame.new(v342, v342 + v_u_336)
													}):Play()
													task.delay(1, function()
														-- upvalues: (copy) v_u_344
														for _, v346 in v_u_344:GetDescendants() do
															if v346:IsA("ParticleEmitter") then
																v346.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								else
									if v_u_301 == "Ragna" then
										local v347 = v_u_302.Z
										if v347 then
											local v348 = v347:FindFirstChild("DashVFX")
											local v349 = v347:FindFirstChild("SlashesVFX")
											local v350 = v_u_305.CFrame.LookVector
											local v351 = CFrame.lookAt(v_u_305.Position, v_u_305.Position + v350)
											if v348 then
												local v_u_352 = v348:Clone()
												v_u_352.CFrame = v351
												v_u_352.Anchored = false
												v_u_352.CanCollide = false
												v_u_352.Transparency = 1
												v_u_352.CastShadow = false
												v_u_352.CanQuery = false
												v_u_352.Massless = true
												v_u_352.Parent = workspace
												v_u_297:AddItem(v_u_352, 1.5)
												local v353 = Instance.new("WeldConstraint")
												v353.Part0 = v_u_305
												v353.Part1 = v_u_352
												v353.Parent = v_u_352
												for _, v354 in v_u_352:GetDescendants() do
													if v354:IsA("ParticleEmitter") then
														v354.Enabled = true
														v354:Emit(v354:GetAttribute("EmitCount") or 30)
													end
												end
												task.delay(0.5, function()
													-- upvalues: (copy) v_u_352
													if v_u_352 and v_u_352.Parent then
														for _, v355 in v_u_352:GetDescendants() do
															if v355:IsA("ParticleEmitter") then
																v355.Enabled = false
															end
														end
													end
												end)
											end
											if v349 then
												local v356 = v349:Clone()
												v356.CFrame = v351 * CFrame.new(0, 0, -20)
												v356.Anchored = true
												v356.CanCollide = false
												v356.Transparency = 1
												v356.Parent = workspace
												v_u_297:AddItem(v356, 1.5)
												for _, v_u_357 in v356:GetDescendants() do
													if v_u_357:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_357
															local v358 = v_u_357:GetAttribute("EmitDelay") or 0
															if v358 > 0 then
																task.wait(v358)
															end
															v_u_357:Emit(v_u_357:GetAttribute("EmitCount") or v_u_357.Rate)
														end)
													end
												end
												return
											end
										end
									else
										if v_u_301 == "Aizen" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_305, (ref) v_u_302, (ref) v_u_297
												if v_u_305 and v_u_305.Parent then
													local v359 = v_u_302.Z:FindFirstChild("LightningVFX")
													if v359 then
														local v360 = v359:Clone()
														v360.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -5)
														v360.Anchored = true
														v360.CanCollide = false
														v360.Transparency = 1
														v360.CastShadow = false
														v360.CanQuery = false
														v360.Parent = workspace
														v_u_297:AddItem(v360, 3)
														for _, v_u_361 in v360:GetDescendants() do
															if v_u_361:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_361
																	local v362 = v_u_361:GetAttribute("EmitDelay") or 0.05
																	task.delay(v362, function()
																		-- upvalues: (ref) v_u_361
																		v_u_361:Emit(v_u_361:GetAttribute("EmitCount") or v_u_361.Rate)
																	end)
																end)
															end
														end
													end
													local v363 = v_u_302.Z:FindFirstChild("EnergyThrust")
													if v363 then
														local v364 = v363:Clone()
														v364.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -25)
														v364.Anchored = true
														v364.CanCollide = false
														v364.Transparency = 1
														v364.CastShadow = false
														v364.CanQuery = false
														v364.Parent = workspace
														v_u_297:AddItem(v364, 3)
														for _, v_u_365 in v364:GetDescendants() do
															if v_u_365:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_365
																	local v366 = v_u_365:GetAttribute("EmitDelay") or 0.05
																	task.delay(v366, function()
																		-- upvalues: (ref) v_u_365
																		v_u_365:Emit(v_u_365:GetAttribute("EmitCount") or v_u_365.Rate)
																	end)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_301 == "QinShi" then
											task.delay(0.4, function()
												-- upvalues: (ref) v_u_305, (ref) v_u_302, (ref) v_u_297
												if v_u_305 and v_u_305.Parent then
													local v367 = v_u_302.Z:FindFirstChild("PunchVFX")
													if v367 then
														local v368 = v367:Clone()
														v368.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
														v368.Anchored = true
														v368.CanCollide = false
														v368.Transparency = 1
														v368.CastShadow = false
														v368.CanQuery = false
														v368.Parent = workspace
														v_u_297:AddItem(v368, 3)
														for _, v_u_369 in v368:GetDescendants() do
															if v_u_369:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_369
																	local v370 = v_u_369:GetAttribute("EmitDelay") or 0
																	task.wait(v370)
																	v_u_369:Emit(v_u_369:GetAttribute("EmitCount") or v_u_369.Rate)
																end)
															end
														end
													end
													local v371 = v_u_302.Z:FindFirstChild("EnergyThrust")
													if v371 then
														local v372 = v371:Clone()
														v372.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -25)
														v372.Anchored = true
														v372.CanCollide = false
														v372.Transparency = 1
														v372.CastShadow = false
														v372.CanQuery = false
														v372.Parent = workspace
														v_u_297:AddItem(v372, 3)
														for _, v_u_373 in v372:GetDescendants() do
															if v_u_373:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_373
																	local v374 = v_u_373:GetAttribute("EmitDelay") or 0
																	task.wait(v374)
																	v_u_373:Emit(v_u_373:GetAttribute("EmitCount") or v_u_373.Rate)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_301 == "Yuji" then
											task.delay(0.3, function()
												-- upvalues: (ref) v_u_305, (ref) v_u_302, (ref) v_u_297
												if v_u_305 and v_u_305.Parent then
													local v375 = v_u_302.Z
													if v375 then
														local v376 = v375:FindFirstChild("SlamVFX")
														if v376 then
															local v377 = v376:Clone()
															v377:PivotTo(v_u_305.CFrame * CFrame.new(0, -1.5, -5))
															v377.Parent = workspace
															v_u_297:AddItem(v377, 3)
															for _, v378 in v377:GetDescendants() do
																if v378:IsA("BasePart") then
																	v378.Anchored = true
																	v378.CanCollide = false
																	v378.CanQuery = false
																end
															end
															for _, v_u_379 in v377:GetDescendants() do
																if v_u_379:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_379
																		local v380 = v_u_379:GetAttribute("EmitDelay") or 0
																		if v380 > 0 then
																			task.wait(v380)
																		end
																		v_u_379:Emit(v_u_379:GetAttribute("EmitCount") or v_u_379.Rate)
																	end)
																end
															end
														end
													end
												else
													return
												end
											end)
											return
										end
										if v_u_301 == "Alucard" then
											local v381 = v_u_68.Alucard
											if v381 and v381["Skill 1"] then
												local v382 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v381["Skill 1"](v382)
												return
											end
										elseif v_u_301 == "GojoV2" then
											local v383 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v383 then
												v383 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v383 then
												local v384 = require(v383)
												if v384["Skill 1"] then
													local v385 = {
														["Caster"] = {
															["Character"] = v_u_304
														}
													}
													v384["Skill 1"](v385)
													return
												end
											end
										elseif v_u_301 == "StrongestInHistory" then
											local v386 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v386 then
												v386 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v386 then
												local v387 = require(v386)
												if v387["Skill 1"] then
													local v388 = {
														["Caster"] = {
															["Character"] = v_u_304
														}
													}
													v387["Skill 1"](v388)
													return
												end
											end
										elseif v_u_301 == "Rimuru" then
											local v389 = v_u_68.Rimuru
											if v389 and v389["Skill 1"] then
												local v390 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v389["Skill 1"](v390)
												return
											end
										elseif v_u_301 == "Madoka" then
											local v391 = v_u_68.Madoka
											if v391 and v391["Skill 1"] then
												local v392 = {
													["Caster"] = {
														["Character"] = v_u_304
													}
												}
												v391["Skill 1"](v392)
												return
											end
										elseif v_u_301 == "Gilgamesh" then
											local v393 = v_u_68.Gilgamesh
											if v393 and v393["Skill 1"] then
												local v394 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v393["Skill 1"](v394)
												return
											end
										elseif v_u_301 == "Anos" then
											local v395 = v_u_68.Anos
											if v395 and v395["Skill 1"] then
												local v396 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v395["Skill 1"](v396)
												return
											end
										else
											task.wait(0.45)
											if not (v_u_305 and v_u_305.Parent) then
												return
											end
											local v397 = v_u_305.CFrame
											local v398 = v_u_302.Z:FindFirstChild("EnergyThrust")
											local v399 = v_u_302.Z:FindFirstChild("EnergyPart")
											if v398 then
												v_u_311(v398, v397 * CFrame.new(0, 2, -35), 3)
											end
											if v399 then
												v_u_311(v399, v397 * CFrame.new(0, 2, -2), 3)
											end
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_296.VFXName == "X" then
						task.spawn(function()
							-- upvalues: (copy) v_u_305, (copy) v_u_301, (copy) v_u_304, (ref) v_u_302, (copy) v_u_297, (copy) v_u_298, (ref) v_u_68, (ref) v_u_3, (copy) p_u_296
							if v_u_305 and v_u_305.Parent then
								if v_u_301 == "Gojo" then
									local v_u_400 = v_u_304:FindFirstChild("Right Arm")
									if v_u_400 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_302, (copy) v_u_400, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v401 = v_u_302.X:FindFirstChild("BlueVFXFirst")
												if v401 then
													local v402 = v401:Clone()
													v402.CFrame = v_u_400.CFrame * CFrame.new(0, -1.05, 0)
													v402.Anchored = true
													v402.CanCollide = false
													v402.Transparency = 1
													v402.CastShadow = false
													v402.CanQuery = false
													v402.Parent = workspace
													v_u_297:AddItem(v402, 4)
													for _, v_u_403 in v402:GetDescendants() do
														if v_u_403:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_403
																local v404 = v_u_403:GetAttribute("EmitDelay") or 0
																task.wait(v404)
																v_u_403:Emit(v_u_403:GetAttribute("EmitCount") or v_u_403.Rate)
															end)
														end
													end
													v402.Anchored = false
													local v405 = Instance.new("WeldConstraint")
													v405.Part0 = v_u_400
													v405.Part1 = v402
													v405.Parent = v402
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_302, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v406 = v_u_305.CFrame
												local v407 = v_u_302.X:FindFirstChild("BlueMainVFX")
												if v407 then
													local v408 = v407:Clone()
													v408.CFrame = v406 * CFrame.new(0, 0, -25)
													v408.Anchored = true
													v408.CanCollide = false
													v408.Transparency = 1
													v408.CastShadow = false
													v408.CanQuery = false
													v408.Parent = workspace
													v_u_297:AddItem(v408, 3)
													for _, v_u_409 in v408:GetDescendants() do
														if v_u_409:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_409
																local v410 = v_u_409:GetAttribute("EmitDelay") or 0
																task.wait(v410)
																v_u_409:Emit(v_u_409:GetAttribute("EmitCount") or v_u_409.Rate)
															end)
														end
													end
												end
												local v411 = v_u_302.X:FindFirstChild("Blue_Additional_VFX")
												if v411 then
													local v412 = v411:Clone()
													v412.CFrame = v406 * CFrame.new(0, 0, -5)
													v412.Anchored = true
													v412.CanCollide = false
													v412.Transparency = 1
													v412.CastShadow = false
													v412.CanQuery = false
													v412.Parent = workspace
													v_u_297:AddItem(v412, 4)
													for _, v_u_413 in v412:GetDescendants() do
														if v_u_413:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_413
																local v414 = v_u_413:GetAttribute("EmitDelay") or 0
																task.wait(v414)
																v_u_413:Emit(v_u_413:GetAttribute("EmitCount") or v_u_413.Rate)
															end)
														end
													end
												end
											end
										end)
									end
								else
									if v_u_301 == "Sukuna" then
										local v415 = v_u_302.X
										if not v415 then
											return
										end
										local v416 = v415:FindFirstChild("GroundVFX")
										if v416 then
											local v_u_417 = v416:Clone()
											v_u_417:PivotTo(v_u_305.CFrame * CFrame.new(0, -2.5, 0))
											v_u_417.Parent = workspace
											v_u_297:AddItem(v_u_417, 3.5)
											local v418 = v_u_417.PrimaryPart or v_u_417:FindFirstChildWhichIsA("BasePart")
											for _, v419 in v_u_417:GetDescendants() do
												if v419:IsA("BasePart") then
													v419.Anchored = false
													v419.CanCollide = false
													v419.CanQuery = false
													v419.CanTouch = false
													v419.Massless = true
												end
											end
											if v418 then
												local v420 = Instance.new("WeldConstraint")
												v420.Part0 = v_u_305
												v420.Part1 = v418
												v420.Parent = v418
											end
											task.delay(2.6, function()
												-- upvalues: (copy) v_u_417
												if v_u_417 and v_u_417.Parent then
													for _, v421 in v_u_417:GetDescendants() do
														if v421:IsA("ParticleEmitter") then
															v421.Enabled = false
														end
													end
												end
											end)
											return
										end
									elseif v_u_301 == "Jinwoo" then
										local v422 = v_u_302.X
										if not v422 then
											return
										end
										local v423 = v422:FindFirstChild("DashVFX")
										local v424 = v422:FindFirstChild("SlashesVFX")
										local v425 = v_u_305.CFrame.LookVector
										local v426 = CFrame.lookAt(v_u_305.Position, v_u_305.Position + v425)
										if v423 then
											local v_u_427 = v423:Clone()
											v_u_427.CFrame = v426
											v_u_427.Anchored = false
											v_u_427.CanCollide = false
											v_u_427.Transparency = 1
											v_u_427.CastShadow = false
											v_u_427.CanQuery = false
											v_u_427.Massless = true
											v_u_427.Parent = workspace
											v_u_297:AddItem(v_u_427, 1.5)
											local v428 = Instance.new("WeldConstraint")
											v428.Part0 = v_u_305
											v428.Part1 = v_u_427
											v428.Parent = v_u_427
											for _, v429 in v_u_427:GetDescendants() do
												if v429:IsA("ParticleEmitter") then
													v429.Enabled = true
													v429:Emit(v429:GetAttribute("EmitCount") or 30)
												end
											end
											task.delay(0.5, function()
												-- upvalues: (copy) v_u_427
												if v_u_427 and v_u_427.Parent then
													for _, v430 in v_u_427:GetDescendants() do
														if v430:IsA("ParticleEmitter") then
															v430.Enabled = false
														end
													end
												end
											end)
										end
										if v424 then
											local v431 = v424:Clone()
											v431.CFrame = v426 * CFrame.new(0, 0, -20)
											v431.Anchored = true
											v431.CanCollide = false
											v431.Transparency = 1
											v431.CastShadow = false
											v431.CanQuery = false
											v431.Parent = workspace
											v_u_297:AddItem(v431, 1.5)
											for _, v_u_432 in v431:GetDescendants() do
												if v_u_432:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_432
														local v433 = v_u_432:GetAttribute("EmitDelay") or 0
														if v433 > 0 then
															task.wait(v433)
														end
														v_u_432:Emit(v_u_432:GetAttribute("EmitCount") or v_u_432.Rate)
													end)
												end
											end
											return
										end
									elseif v_u_301 == "Ragna" then
										local v_u_434 = v_u_302.X
										if v_u_434 then
											local v435 = v_u_434:FindFirstChild("GroundVFX")
											if v435 then
												local v436 = v435:Clone()
												v436.CFrame = v_u_305.CFrame * CFrame.new(0, -2.5, 0)
												v436.Anchored = true
												v436.CanCollide = false
												v436.Transparency = 1
												v436.Parent = workspace
												v_u_297:AddItem(v436, 5)
												for _, v_u_437 in v436:GetDescendants() do
													if v_u_437:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_437
															local v438 = v_u_437:GetAttribute("EmitDelay") or 0
															if v438 > 0 then
																task.wait(v438)
															end
															v_u_437:Emit(v_u_437:GetAttribute("EmitCount") or v_u_437.Rate)
														end)
													end
												end
											end
											local v439 = v_u_434:FindFirstChild("ChargeVFX")
											if v439 then
												local v_u_440 = v439:Clone()
												v_u_440.CFrame = v_u_305.CFrame
												v_u_440.Anchored = false
												v_u_440.CanCollide = false
												v_u_440.Transparency = 1
												v_u_440.Massless = true
												v_u_440.Parent = workspace
												v_u_297:AddItem(v_u_440, 1.3)
												local v441 = Instance.new("WeldConstraint")
												v441.Part0 = v_u_305
												v441.Part1 = v_u_440
												v441.Parent = v_u_440
												for _, v442 in v_u_440:GetDescendants() do
													if v442:IsA("ParticleEmitter") then
														v442.Enabled = true
													end
												end
												task.delay(0.4, function()
													-- upvalues: (copy) v_u_440
													if v_u_440 and v_u_440.Parent then
														for _, v443 in v_u_440:GetDescendants() do
															if v443:IsA("ParticleEmitter") then
																v443.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(0.44999999999999996, function()
												-- upvalues: (ref) v_u_305, (copy) v_u_434, (ref) v_u_297
												if v_u_305 and v_u_305.Parent then
													local v444 = v_u_434:FindFirstChild("BarrageVFX")
													if v444 then
														local v_u_445 = v444:Clone()
														v_u_445.CFrame = v_u_305.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_445.Anchored = true
														v_u_445.CanCollide = false
														v_u_445.Transparency = 1
														v_u_445.Parent = workspace
														v_u_297:AddItem(v_u_445, 2.9)
														for _, v446 in v_u_445:GetDescendants() do
															if v446:IsA("ParticleEmitter") then
																v446.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_445
															if v_u_445 and v_u_445.Parent then
																for _, v447 in v_u_445:GetDescendants() do
																	if v447:IsA("ParticleEmitter") then
																		v447.Enabled = false
																	end
																end
															end
														end)
													end
													local v448 = v_u_434:FindFirstChild("BarrageGroundVFX")
													if v448 then
														local v_u_449 = v448:Clone()
														v_u_449.CFrame = v_u_305.CFrame * CFrame.new(0, -37.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_449.Anchored = true
														v_u_449.CanCollide = false
														v_u_449.Transparency = 1
														v_u_449.Parent = workspace
														v_u_297:AddItem(v_u_449, 2.7)
														for _, v450 in v_u_449:GetDescendants() do
															if v450:IsA("ParticleEmitter") then
																v450.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_449
															if v_u_449 and v_u_449.Parent then
																for _, v451 in v_u_449:GetDescendants() do
																	if v451:IsA("ParticleEmitter") then
																		v451.Enabled = false
																	end
																end
															end
														end)
													end
												end
											end)
											task.delay(2, function()
												-- upvalues: (ref) v_u_305, (copy) v_u_434, (ref) v_u_297
												if v_u_305 and v_u_305.Parent then
													local v452 = v_u_434:FindFirstChild("ChargeVFX")
													if v452 then
														local v_u_453 = v452:Clone()
														v_u_453.CFrame = v_u_305.CFrame
														v_u_453.Anchored = false
														v_u_453.CanCollide = false
														v_u_453.Transparency = 1
														v_u_453.Massless = true
														v_u_453.Parent = workspace
														v_u_297:AddItem(v_u_453, 1)
														local v454 = Instance.new("WeldConstraint")
														v454.Part0 = v_u_305
														v454.Part1 = v_u_453
														v454.Parent = v_u_453
														for _, v455 in v_u_453:GetDescendants() do
															if v455:IsA("ParticleEmitter") then
																v455.Enabled = true
															end
														end
														task.delay(0.6, function()
															-- upvalues: (copy) v_u_453
															if v_u_453 and v_u_453.Parent then
																for _, v456 in v_u_453:GetDescendants() do
																	if v456:IsA("ParticleEmitter") then
																		v456.Enabled = false
																	end
																end
															end
														end)
													end
												end
											end)
											return
										end
									else
										if v_u_301 == "Aizen" then
											local v457 = v_u_302.X:FindFirstChild("BarrageVFX")
											if v457 then
												local v_u_458 = v457:Clone()
												v_u_458.CFrame = v_u_305.CFrame * CFrame.new(0, 4, -15)
												v_u_458.Anchored = false
												v_u_458.CanCollide = false
												v_u_458.Transparency = 1
												v_u_458.CastShadow = false
												v_u_458.CanQuery = false
												v_u_458.Massless = true
												v_u_458.Parent = workspace
												v_u_297:AddItem(v_u_458, 3.7)
												local v459 = Instance.new("WeldConstraint")
												v459.Part0 = v_u_305
												v459.Part1 = v_u_458
												v459.Parent = v_u_458
												for _, v460 in v_u_458:GetDescendants() do
													if v460:IsA("ParticleEmitter") or (v460:IsA("Beam") or v460:IsA("Trail")) then
														v460.Enabled = true
													end
												end
												task.delay(1.7, function()
													-- upvalues: (copy) v_u_458
													if v_u_458 and v_u_458.Parent then
														for _, v461 in v_u_458:GetDescendants() do
															if v461:IsA("ParticleEmitter") or (v461:IsA("Beam") or v461:IsA("Trail")) then
																v461.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(1.9, function()
												-- upvalues: (ref) v_u_305, (ref) v_u_302, (ref) v_u_297, (ref) v_u_298
												if not (v_u_305 and v_u_305.Parent) then
													return
												end
												local v462 = { 0, 0 }
												local v463 = {
													{ 180, 180, 135 },
													{ 180, 180, 45 }
												}
												for v464 = 1, 2 do
													if not (v_u_305 and v_u_305.Parent) then
														break
													end
													local v465 = v462[v464]
													local v466 = v463[v464][1]
													local v467 = v463[v464][2]
													local v468 = v463[v464][3]
													local v469 = v_u_305.CFrame * CFrame.Angles(0, math.rad(v465), 0)
													local v470 = v469.Position
													local v471 = v470 + v469.LookVector * 80
													local v472 = CFrame.Angles(math.rad(v466), math.rad(v467), (math.rad(v468)))
													local v473 = CFrame.lookAt(v470, v471) * v472
													local v474 = CFrame.lookAt(v471, v471 + v469.LookVector) * v472
													local v475 = v_u_302.X:FindFirstChild("StartVFX")
													if v475 then
														local v476 = v475:Clone()
														v476.CFrame = v473
														v476.Anchored = true
														v476.CanCollide = false
														v476.Transparency = 1
														v476.Parent = workspace
														v_u_297:AddItem(v476, 2)
														for _, v477 in v476:GetDescendants() do
															if v477:IsA("ParticleEmitter") then
																v477:Emit(v477:GetAttribute("EmitCount") or v477.Rate)
															end
														end
													end
													local v478 = v_u_302.X:FindFirstChild("SlashVFX")
													if v478 then
														local v_u_479 = v478:Clone()
														v_u_479.CFrame = v473
														v_u_479.Anchored = true
														v_u_479.CanCollide = false
														v_u_479.Transparency = 1
														v_u_479.Parent = workspace
														v_u_297:AddItem(v_u_479, 3)
														for _, v480 in v_u_479:GetDescendants() do
															if v480:IsA("ParticleEmitter") or (v480:IsA("Beam") or v480:IsA("Trail")) then
																v480.Enabled = true
															end
														end
														local v481 = v_u_298:Create(v_u_479, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															["CFrame"] = v474
														})
														v481:Play()
														v481.Completed:Connect(function()
															-- upvalues: (copy) v_u_479
															for _, v482 in v_u_479:GetDescendants() do
																if v482:IsA("ParticleEmitter") or (v482:IsA("Beam") or v482:IsA("Trail")) then
																	v482.Enabled = false
																end
															end
														end)
													end
													if v464 < 2 then
														task.wait(0.3)
													end
												end
											end)
											return
										end
										if v_u_301 == "QinShi" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_305, (ref) v_u_302, (ref) v_u_297
												if v_u_305 and v_u_305.Parent then
													local v483 = v_u_302:FindFirstChild("X")
													if v483 then
														local v484 = v483:FindFirstChild("StompVFX")
														if v484 then
															local v485 = v_u_305.Position - Vector3.new(0, 2.5, 0)
															local v486 = v484:Clone()
															local v487 = v486:FindFirstChild("Main")
															local v488 = v486:FindFirstChild("Lightning")
															if v487 then
																v487.CFrame = CFrame.new(v485)
																v487.Anchored = true
																v487.CanCollide = false
																v487.Transparency = 1
															end
															if v488 then
																v488.CFrame = CFrame.new(v485 + Vector3.new(0, 13, 0))
																v488.Anchored = true
																v488.CanCollide = false
																v488.Transparency = 1
															end
															v486.Parent = workspace
															v_u_297:AddItem(v486, 3)
															for _, v_u_489 in v486:GetDescendants() do
																if v_u_489:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_489
																		local v490 = v_u_489:GetAttribute("EmitDelay") or 0
																		task.wait(v490)
																		v_u_489:Emit(v_u_489:GetAttribute("EmitCount") or v_u_489.Rate)
																	end)
																end
															end
														end
													end
												else
													return
												end
											end)
											return
										end
										if v_u_301 == "Yuji" then
											local v491 = v_u_302.X
											local v492 = v491 and v491:FindFirstChild("BarrageVFX")
											if v492 then
												local v_u_493 = v492:Clone()
												v_u_493.CFrame = v_u_305.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, -1.5707963267948966, 0)
												v_u_493.Anchored = false
												v_u_493.CanCollide = false
												v_u_493.Transparency = 1
												v_u_493.CastShadow = false
												v_u_493.CanQuery = false
												v_u_493.Massless = true
												v_u_493.Parent = workspace
												v_u_297:AddItem(v_u_493, 4)
												local v494 = Instance.new("WeldConstraint")
												v494.Part0 = v_u_305
												v494.Part1 = v_u_493
												v494.Parent = v_u_493
												for _, v495 in v_u_493:GetDescendants() do
													if v495:IsA("ParticleEmitter") then
														v495.Enabled = true
													end
												end
												task.delay(3.2, function()
													-- upvalues: (copy) v_u_493
													if v_u_493 and v_u_493.Parent then
														for _, v496 in v_u_493:GetDescendants() do
															if v496:IsA("ParticleEmitter") then
																v496.Enabled = false
															end
														end
													end
												end)
												return
											end
										elseif v_u_301 == "Alucard" then
											local v497 = v_u_68.Alucard
											if v497 and v497["Skill 2"] then
												local v498 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v497["Skill 2"](v498)
												return
											end
										elseif v_u_301 == "GojoV2" then
											local v499 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v499 then
												v499 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v499 then
												local v500 = require(v499)
												if v500["Skill 2"] then
													v500["Skill 2"]({
														["Caster"] = {
															["Character"] = v_u_304
														},
														["Duration"] = p_u_296.Duration or 6
													})
													return
												end
											end
										elseif v_u_301 == "StrongestInHistory" then
											local v501 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v501 then
												v501 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v501 then
												local v502 = require(v501)
												if v502["Skill 2"] then
													local v503 = {
														["Caster"] = {
															["Character"] = v_u_304
														}
													}
													v502["Skill 2"](v503)
													return
												end
											end
										elseif v_u_301 == "Ichigo" then
											local v504 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v504 then
												v504 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("Ichigo")
											end
											if v504 then
												local v505 = require(v504)
												if v505 and v505["Skill 2"] then
													local v506 = {
														["Caster"] = {
															["Character"] = v_u_304
														},
														["Duration"] = 4
													}
													v505["Skill 2"](v506)
													return
												end
											end
										elseif v_u_301 == "Rimuru" then
											local v507 = v_u_68.Rimuru
											if v507 and v507["Skill 2"] then
												local v508 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v507["Skill 2"](v508)
												return
											end
										elseif v_u_301 == "Madoka" then
											local v509 = v_u_68.Madoka
											if v509 and v509["Skill 2"] then
												v509["Skill 2"]({
													["Caster"] = {
														["Character"] = v_u_304
													},
													["Position"] = v_u_305 and v_u_305.Position + v_u_305.CFrame.LookVector * 50 or nil
												})
												return
											end
										elseif v_u_301 == "Gilgamesh" then
											local v510 = v_u_68.Gilgamesh
											if v510 and v510["Skill 2"] then
												local v511 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v510["Skill 2"](v511)
												return
											end
										elseif v_u_301 == "Anos" then
											local v512 = v_u_68.Anos
											if v512 and v512["Skill 2"] then
												local v513 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v512["Skill 2"](v513)
												return
											end
										else
											task.wait(0.35)
											if not (v_u_305 and v_u_305.Parent) then
												return
											end
											local v514 = v_u_305.CFrame
											local v515 = v_u_302.X:FindFirstChild("EnergySlashes")
											if not v515 then
												return
											end
											local v_u_516 = v515:Clone()
											v_u_516.CFrame = v514 * CFrame.new(0, 1.5, -20)
											v_u_516.Anchored = false
											v_u_516.CanCollide = false
											v_u_516.Transparency = 1
											v_u_516.CastShadow = false
											v_u_516.CanQuery = false
											v_u_516.Massless = true
											v_u_516.Parent = workspace
											v_u_297:AddItem(v_u_516, 4)
											local v517 = Instance.new("WeldConstraint")
											v517.Part0 = v_u_516
											v517.Part1 = v_u_305
											v517.Parent = v_u_516
											v_u_297:AddItem(v517, 2.06)
											task.delay(2.05, function()
												-- upvalues: (copy) v_u_516
												for _, v518 in v_u_516:GetDescendants() do
													if v518:IsA("ParticleEmitter") then
														v518.Enabled = false
													end
												end
												v_u_516.Anchored = true
											end)
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_296.VFXName == "C" then
						task.spawn(function()
							-- upvalues: (copy) v_u_305, (copy) v_u_301, (ref) v_u_3, (copy) v_u_304, (copy) p_u_296, (ref) v_u_302, (copy) v_u_297, (copy) v_u_317, (copy) v_u_323
							if v_u_305 and v_u_305.Parent then
								if v_u_301 == "GojoV2" then
									local v519 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v519 then
										v519 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v519 then
										local v520 = require(v519)
										if v520["Skill 3"] then
											local v521 = v520["Skill 3"]
											local v522 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["Duration"] = p_u_296.Duration or 6
											}
											v521(v522)
										end
									end
									return
								elseif v_u_301 == "StrongestInHistory" then
									local v523 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v523 then
										v523 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v523 then
										local v_u_524 = require(v523)
										if v_u_524["Skill 3"] then
											local v525 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["ChargeTime"] = 2.5
											}
											v_u_524["Skill 3"](v525)
										end
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_524, (ref) v_u_304
											if v_u_305 and v_u_305.Parent then
												local v526 = v_u_305.Position + v_u_305.CFrame.LookVector * 85
												if v_u_524["Skill 3"] then
													local v527 = v_u_524["Skill 3"]
													local v528 = {
														["Caster"] = {
															["Character"] = v_u_304
														},
														["Phase"] = "Explosion",
														["Position"] = v526,
														["CFrame"] = CFrame.new(v526),
														["DOTDuration"] = 3.5
													}
													v527(v528)
												end
											end
										end)
									end
									return
								elseif v_u_301 == "Gojo" then
									local v529 = v_u_302.C:FindFirstChild("DamageVFX")
									if v529 then
										local v530 = v529:Clone()
										v530.CFrame = v_u_305.CFrame
										v530.Anchored = false
										v530.CanCollide = false
										v530.Transparency = 1
										v530.Massless = true
										v530.Parent = workspace
										local v531 = Instance.new("WeldConstraint")
										v531.Part0 = v530
										v531.Part1 = v_u_305
										v531.Parent = v530
										for _, v532 in v530:GetDescendants() do
											if v532:IsA("ParticleEmitter") then
												v532:Emit(v532:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_297:AddItem(v530, 3)
									end
									return
								elseif v_u_301 == "Jinwoo" then
									local v533 = v_u_302.C
									if v533 then
										local v534 = v533:FindFirstChild("EnergySlashes")
										local v535 = v533:FindFirstChild("ShadowVFX")
										if v534 then
											local v_u_536 = v534:Clone()
											v_u_536.CFrame = v_u_305.CFrame * CFrame.new(0, 3.9, 0)
											v_u_536.Anchored = false
											v_u_536.CanCollide = false
											v_u_536.Transparency = 1
											v_u_536.CastShadow = false
											v_u_536.CanQuery = false
											v_u_536.Massless = true
											v_u_536.Parent = workspace
											v_u_297:AddItem(v_u_536, 3.65)
											local v537 = Instance.new("WeldConstraint")
											v537.Part0 = v_u_305
											v537.Part1 = v_u_536
											v537.Parent = v_u_536
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_536
												if v_u_536 and v_u_536.Parent then
													for _, v538 in v_u_536:GetDescendants() do
														if v538:IsA("ParticleEmitter") then
															v538:Emit(v538:GetAttribute("EmitCount") or v538.Rate)
															v538.Enabled = false
														end
													end
												end
											end)
										end
										if v535 then
											local v_u_539 = v535:Clone()
											v_u_539.CFrame = v_u_305.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_539.Anchored = false
											v_u_539.CanCollide = false
											v_u_539.Transparency = 1
											v_u_539.CastShadow = false
											v_u_539.CanQuery = false
											v_u_539.Massless = true
											v_u_539.Parent = workspace
											v_u_297:AddItem(v_u_539, 2.65)
											local v540 = Instance.new("WeldConstraint")
											v540.Part0 = v_u_305
											v540.Part1 = v_u_539
											v540.Parent = v_u_539
											for _, v_u_541 in v_u_539:GetDescendants() do
												if v_u_541:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_541
														local v542 = v_u_541:GetAttribute("EmitDelay") or 0
														if v542 > 0 then
															task.wait(v542)
														end
														v_u_541:Emit(v_u_541:GetAttribute("EmitCount") or v_u_541.Rate)
													end)
												end
											end
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_539
												if v_u_539 and v_u_539.Parent then
													for _, v543 in v_u_539:GetDescendants() do
														if v543:IsA("ParticleEmitter") then
															v543.Enabled = false
														end
													end
												end
											end)
										end
									end
								elseif v_u_301 == "Ragna" then
									local v544 = v_u_302.C
									if v544 then
										local v_u_545 = v544:FindFirstChild("Sword")
										local v_u_546 = v544:FindFirstChild("StartVFX")
										local v_u_547 = v544:FindFirstChild("ExpVFX")
										if v_u_545 then
											local v_u_548 = {}
											local v_u_549 = {}
											for _ = 1, 6 do
												local v550 = 4 + math.random() * 4
												local v551 = (math.random() - 0.5) * 2 * 6
												local v552 = -(3 + math.random() * 3)
												local v553 = {
													["offset"] = Vector3.new(v551, v550, v552)
												}
												table.insert(v_u_548, v553)
											end
											local v_u_554 = 0
											task.spawn(function()
												-- upvalues: (ref) v_u_554, (ref) v_u_305, (copy) v_u_548, (copy) v_u_545, (ref) v_u_297, (copy) v_u_546, (copy) v_u_549
												while v_u_554 < 6 and (v_u_305 and v_u_305.Parent) do
													local v555 = 6 - v_u_554
													local v556 = math.min(2, v555)
													for v557 = 1, v556 do
														local v558 = v_u_548[v_u_554 + v557]
														local v559 = v_u_305.CFrame
														local v560 = v559:VectorToWorldSpace(v558.offset)
														local v561 = v559.Position + v560
														local v562 = v_u_545:Clone()
														v562.CFrame = CFrame.new(v561) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v562.Anchored = true
														v562.CanCollide = false
														v562.CanQuery = false
														v562.Transparency = 0
														v562.Parent = workspace
														v_u_297:AddItem(v562, 3)
														if v_u_546 then
															local v563 = v_u_546:Clone()
															v563.CFrame = v562.CFrame
															v563.Anchored = true
															v563.CanCollide = false
															v563.Transparency = 1
															v563.Parent = workspace
															v_u_297:AddItem(v563, 1)
															for _, v564 in v563:GetDescendants() do
																if v564:IsA("ParticleEmitter") then
																	v564:Emit(v564:GetAttribute("EmitCount") or 20)
																end
															end
														end
														local v565 = v_u_549
														table.insert(v565, {
															["sword"] = v562,
															["spawnData"] = v558
														})
													end
													v_u_554 = v_u_554 + v556
													task.wait(0.25)
												end
											end)
											local v566 = game:GetService("RunService")
											local v_u_567 = nil
											v_u_567 = v566.Heartbeat:Connect(function()
												-- upvalues: (ref) v_u_305, (ref) v_u_567, (copy) v_u_549
												if v_u_305 and v_u_305.Parent then
													local v568 = (1 / 0)
													local v569 = nil
													for _, v570 in ipairs(game.Players:GetPlayers()) do
														if v570.Character and v570.Character:FindFirstChild("HumanoidRootPart") then
															local v571 = v570.Character.HumanoidRootPart
															local v572 = (v571.Position - v_u_305.Position).Magnitude
															if v572 < v568 and v572 < 150 then
																v569 = v571.Position
																v568 = v572
															end
														end
													end
													for _, v573 in ipairs(v_u_549) do
														local v574 = v573.sword
														if v574 and (v574.Parent and not v573.launched) then
															local v575 = v574.Position
															local v576
															if v569 then
																local v577 = v569 - v575
																if v577.Magnitude > 0.1 then
																	local v578 = v577.Unit
																	v576 = CFrame.lookAt(v575, v575 + v578) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793)
																else
																	v576 = CFrame.new(v575) * CFrame.Angles(1.5707963267948966, 0, 0)
																end
															else
																v576 = CFrame.new(v575) * v_u_305.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v574.CFrame = v574.CFrame:Lerp(v576, 0.12)
														end
													end
												elseif v_u_567 then
													v_u_567:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_567, (ref) v_u_305, (copy) v_u_549, (copy) v_u_547, (ref) v_u_297
												if v_u_567 then
													v_u_567:Disconnect()
												end
												if v_u_305 and v_u_305.Parent then
													local v579 = v_u_305.Position + v_u_305.CFrame.LookVector * 30
													local v580 = (1 / 0)
													for _, v581 in ipairs(game.Players:GetPlayers()) do
														if v581.Character and v581.Character:FindFirstChild("HumanoidRootPart") then
															local v582 = v581.Character.HumanoidRootPart
															local v583 = (v582.Position - v_u_305.Position).Magnitude
															if v583 < v580 and v583 < 150 then
																v579 = v582.Position
																v580 = v583
															end
														end
													end
													local v_u_584 = CFrame.new(v579)
													for v585, v_u_586 in ipairs(v_u_549) do
														task.delay((v585 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_586, (copy) v_u_584, (ref) v_u_547, (ref) v_u_297
															local v_u_587 = v_u_586.sword
															if v_u_587 and v_u_587.Parent then
																v_u_586.launched = true
																local v_u_588 = v_u_587.Position
																local v589 = v_u_584.Position
																local v590 = math.random(-8, 8)
																local v591 = math.random
																local v_u_592 = v589 + Vector3.new(v590, 0, v591(-8, 8))
																local v593 = (v_u_588 + v_u_592) / 2
																local v594 = math.random(-60, 60)
																local v595 = math.rad(v594)
																local v596 = 12 + math.random() * 5
																local v597 = math.sin(v595) * 5
																local v598 = math.cos(v595) * 5
																local v_u_599 = v593 + Vector3.new(v597, v596, v598)
																local v_u_600 = tick()
																task.spawn(function()
																	-- upvalues: (copy) v_u_600, (copy) v_u_588, (copy) v_u_599, (copy) v_u_592, (copy) v_u_587, (ref) v_u_547, (ref) v_u_297
																	while tick() - v_u_600 < 0.4 do
																		local v601 = (tick() - v_u_600) / 0.4
																		local v602 = v_u_588
																		local v603 = v_u_599
																		local v604 = v_u_592
																		local v605 = 1 - v601
																		local v606 = v605 * v605 * v602 + 2 * v605 * v601 * v603 + v601 * v601 * v604
																		local v607 = v601 + 0.05
																		local v608 = math.min(v607, 1)
																		local v609 = v_u_588
																		local v610 = v_u_599
																		local v611 = v_u_592
																		local v612 = 1 - v608
																		local v613 = v612 * v612 * v609 + 2 * v612 * v608 * v610 + v608 * v608 * v611 - v606
																		if v_u_587 and (v_u_587.Parent and v613.Magnitude > 0.01) then
																			v_u_587.CFrame = CFrame.lookAt(v606, v606 + v613.Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
																		end
																		task.wait()
																	end
																	if v_u_547 and (v_u_587 and v_u_587.Parent) then
																		local v614 = v_u_547:Clone()
																		v614.CFrame = CFrame.new(v_u_592)
																		v614.Anchored = true
																		v614.CanCollide = false
																		v614.Transparency = 1
																		v614.Parent = workspace
																		v_u_297:AddItem(v614, 1.5)
																		for _, v615 in v614:GetDescendants() do
																			if v615:IsA("ParticleEmitter") then
																				v615:Emit(v615:GetAttribute("EmitCount") or 30)
																			end
																		end
																	end
																	if v_u_587 and v_u_587.Parent then
																		v_u_587:Destroy()
																	end
																end)
															end
														end)
													end
												end
											end)
										end
									else
										return
									end
								elseif v_u_301 == "Aizen" then
									local v_u_616 = v_u_302.C
									if v_u_616 then
										local v_u_617 = {}
										local function v_u_623(p618, p619)
											-- upvalues: (ref) v_u_305, (ref) v_u_297
											if not p618 then
												return nil
											end
											local v620 = p618:Clone()
											v620.CFrame = v_u_305.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v620.Anchored = false
											v620.CanCollide = false
											v620.Transparency = 1
											v620.CastShadow = false
											v620.CanQuery = false
											v620.Massless = true
											v620.Parent = workspace
											v_u_297:AddItem(v620, p619)
											local v621 = Instance.new("WeldConstraint")
											v621.Part0 = v_u_305
											v621.Part1 = v620
											v621.Parent = v620
											for _, v622 in v620:GetDescendants() do
												if v622:IsA("ParticleEmitter") or (v622:IsA("Beam") or v622:IsA("Trail")) then
													v622.Enabled = true
												end
											end
											return v620
										end
										local v624 = v_u_623(v_u_616:FindFirstChild("ChargeVFX"), 4)
										if v624 then
											table.insert(v_u_617, v624)
										end
										local v625 = v_u_623(v_u_616:FindFirstChild("AuraVFX1"), 4)
										if v625 then
											table.insert(v_u_617, v625)
										end
										task.delay(0.25, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_623, (copy) v_u_616, (copy) v_u_617
											if v_u_305 and v_u_305.Parent then
												local v626 = v_u_623(v_u_616:FindFirstChild("AuraVFX2"), 3.75)
												if v626 then
													local v627 = v_u_617
													table.insert(v627, v626)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_623, (copy) v_u_616, (copy) v_u_617
											if v_u_305 and v_u_305.Parent then
												local v628 = v_u_623(v_u_616:FindFirstChild("AuraVFX3"), 3.5)
												if v628 then
													local v629 = v_u_617
													table.insert(v629, v628)
												end
											end
										end)
										task.delay(3, function()
											-- upvalues: (copy) v_u_617
											for _, v630 in pairs(v_u_617) do
												if v630 and v630.Parent then
													for _, v631 in v630:GetDescendants() do
														if v631:IsA("ParticleEmitter") or (v631:IsA("Beam") or v631:IsA("Trail")) then
															v631.Enabled = false
														end
													end
												end
											end
										end)
									end
								elseif v_u_301 == "Rimuru" then
									return
								else
									local v632 = v_u_302.C:FindFirstChild("FirstEffects")
									if v632 then
										local v_u_633 = v632:Clone()
										for _, v634 in v_u_633:GetDescendants() do
											if v634:IsA("BasePart") then
												v634.Anchored = true
												v634.CanCollide = false
												v634.CanQuery = false
												v634.CanTouch = false
												v634.CastShadow = false
												v634.Transparency = 1
											end
										end
										v_u_633:PivotTo(v_u_305.CFrame * CFrame.new(0, -2, 0))
										v_u_633.Parent = workspace
										v_u_297:AddItem(v_u_633, 6)
										task.delay(4.85, function()
											-- upvalues: (copy) v_u_633
											for _, v635 in v_u_633:GetDescendants() do
												if v635:IsA("ParticleEmitter") then
													v635.Enabled = false
												end
											end
										end)
									end
									task.wait(3.85)
									if v_u_305 and v_u_305.Parent then
										local v_u_636 = v_u_305.CFrame
										local v637 = v_u_302.C:FindFirstChild("HorizontalBeam")
										if v637 then
											local v638 = v637:Clone()
											for _, v639 in v638:GetDescendants() do
												if v639:IsA("BasePart") then
													v639.Anchored = true
													v639.CanCollide = false
													v639.CanQuery = false
													v639.CanTouch = false
													v639.CastShadow = false
													v639.Massless = true
													v639.Transparency = 1
												end
												if v639:IsA("Beam") then
													v639.Enabled = false
												end
											end
											v638:PivotTo(v_u_636 * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0))
											v638.Parent = workspace
											v_u_297:AddItem(v638, 6)
											local v640 = {
												["BigBeam1"] = 0,
												["BigBeam2"] = 0.25,
												["BigBeams3"] = 0.5
											}
											local v641 = {
												["BigBeam1"] = 0.36,
												["BigBeam2"] = 0.61,
												["BigBeams3"] = 0.76
											}
											for _, v_u_642 in v638:GetChildren() do
												if v_u_642:IsA("Model") then
													local v_u_643 = v_u_642:FindFirstChild("Beam")
													local v644 = v640[v_u_642.Name] or 0
													local v645 = v641[v_u_642.Name] or 2
													task.delay(v644, function()
														-- upvalues: (copy) v_u_643, (ref) v_u_317, (copy) v_u_642
														if v_u_643 then
															v_u_317(v_u_643, 0.3)
														end
														for _, v646 in v_u_642:GetDescendants() do
															if v646:IsA("ParticleEmitter") and not (v_u_643 and v646:IsDescendantOf(v_u_643)) then
																v646:Emit(v646:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v645, function()
														-- upvalues: (copy) v_u_643, (ref) v_u_323
														if v_u_643 then
															v_u_323(v_u_643, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_302, (copy) v_u_636, (ref) v_u_297, (ref) v_u_323
											if v_u_305 and v_u_305.Parent then
												local v647 = v_u_302.C:FindFirstChild("Explosion")
												if v647 then
													local v_u_648 = v647:Clone()
													for _, v649 in v_u_648:GetDescendants() do
														if v649:IsA("BasePart") then
															v649.Anchored = true
															v649.CanCollide = false
															v649.CanQuery = false
															v649.CanTouch = false
															v649.CastShadow = false
															v649.Transparency = 1
														end
													end
													v_u_648:PivotTo(v_u_636 * CFrame.new(0, 8, -75) * CFrame.Angles(0, 0, 1.5707963267948966))
													v_u_648.Parent = workspace
													v_u_297:AddItem(v_u_648, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_323, (copy) v_u_648
														v_u_323(v_u_648, 0.5)
														for _, v650 in v_u_648:GetDescendants() do
															if v650:IsA("ParticleEmitter") then
																v650.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								end
							else
								return
							end
						end)
						if v_u_301 == "QinShi" then
							task.spawn(function()
								-- upvalues: (copy) v_u_305, (ref) v_u_302, (copy) v_u_297
								if v_u_305 and v_u_305.Parent then
									local v651 = v_u_302:FindFirstChild("C")
									if v651 then
										local v652 = v651:FindFirstChild("BarrageVFX")
										if v652 then
											local v_u_653 = v652:Clone()
											v_u_653.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_653.Anchored = false
											v_u_653.CanCollide = false
											v_u_653.CanQuery = false
											v_u_653.CanTouch = false
											v_u_653.Transparency = 1
											v_u_653.CastShadow = false
											v_u_653.Parent = workspace
											local v654 = Instance.new("WeldConstraint")
											v654.Part0 = v_u_653
											v654.Part1 = v_u_305
											v654.Parent = v_u_653
											for _, v655 in v_u_653:GetDescendants() do
												if v655:IsA("ParticleEmitter") then
													v655.Enabled = true
												end
											end
											task.delay(3, function()
												-- upvalues: (copy) v_u_653
												if v_u_653 and v_u_653.Parent then
													for _, v656 in v_u_653:GetDescendants() do
														if v656:IsA("ParticleEmitter") then
															v656.Enabled = false
														end
													end
												end
											end)
											v_u_297:AddItem(v_u_653, 4)
										end
									end
								else
									return
								end
							end)
						end
						if v_u_301 == "Yuji" then
							task.spawn(function()
								-- upvalues: (copy) v_u_305, (ref) v_u_302, (copy) v_u_297
								if v_u_305 and v_u_305.Parent then
									local v_u_657 = v_u_302:FindFirstChild("C")
									if v_u_657 then
										local v658 = v_u_657:FindFirstChild("AuraVFX3")
										if v658 then
											local v_u_659 = v658:Clone()
											v_u_659.CFrame = v_u_305.CFrame
											v_u_659.Anchored = false
											v_u_659.CanCollide = false
											v_u_659.Transparency = 1
											v_u_659.Massless = true
											v_u_659.Parent = workspace
											local v660 = Instance.new("WeldConstraint")
											v660.Part0 = v_u_305
											v660.Part1 = v_u_659
											v660.Parent = v_u_659
											for _, v661 in v_u_659:GetDescendants() do
												if v661:IsA("ParticleEmitter") then
													v661.Enabled = true
												end
											end
											task.delay(0.8, function()
												-- upvalues: (copy) v_u_659
												if v_u_659 and v_u_659.Parent then
													for _, v662 in v_u_659:GetDescendants() do
														if v662:IsA("ParticleEmitter") then
															v662.Enabled = false
														end
													end
												end
											end)
											v_u_297:AddItem(v_u_659, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_657, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v663 = v_u_657:FindFirstChild("BlackFlashVFX3")
												if v663 then
													local v664 = v663:Clone()
													v664.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -10)
													v664.Anchored = true
													v664.CanCollide = false
													v664.Transparency = 1
													v664.Parent = workspace
													for _, v665 in v664:GetDescendants() do
														if v665:IsA("ParticleEmitter") then
															v665:Emit(v665:GetAttribute("EmitCount") or v665.Rate)
														end
													end
													v_u_297:AddItem(v664, 3)
												end
											end
										end)
									end
								else
									return
								end
							end)
						end
						if v_u_301 == "Alucard" then
							local v666 = v_u_68.Alucard
							if v666 and v666["Skill 3"] then
								v666["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_304
									},
									["DamageDelay"] = 2.5,
									["Duration"] = 5,
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_301 == "Ichigo" then
							local v667 = v_u_68.Ichigo
							if v667 and v667["Skill 3"] then
								v667["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_304
									},
									["ChargeTime"] = 3.5,
									["SlashCount"] = 1,
									["SlashInterval"] = 0.15,
									["SlashDistance"] = 80,
									["SlashSpeed"] = 180
								})
							end
						end
						if v_u_301 == "Rimuru" then
							local v668 = v_u_68.Rimuru
							if v668 and v668["Skill 3"] then
								v668["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_304
									},
									["DamageDelay"] = 2.5,
									["Duration"] = 5,
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_301 == "Madoka" then
							local v669 = v_u_68.Madoka
							if v669 and v669["Skill 3"] then
								v669["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_304
									},
									["DamageDelay"] = 1.03,
									["Duration"] = 3.97
								})
							end
						end
						if v_u_301 == "Gilgamesh" then
							local v670 = v_u_68.Gilgamesh
							if v670 and v670["Skill 3"] then
								v670["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_304
									},
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_301 == "Anos" then
							local v671 = v_u_68.Anos
							if v671 and v671["Skill 3"] then
								v671["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_304
									},
									["AbilityConfig"] = {}
								})
							end
						end
					elseif p_u_296.VFXName == "V" then
						task.spawn(function()
							-- upvalues: (copy) v_u_305, (copy) v_u_301, (ref) v_u_3, (copy) v_u_304, (ref) v_u_302, (copy) v_u_297, (copy) v_u_298, (copy) p_u_296, (ref) v_u_295, (ref) v_u_37, (ref) v_u_68
							if v_u_305 and v_u_305.Parent then
								if v_u_301 == "GojoV2" then
									local v672 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v672 then
										v672 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v672 then
										local v673 = require(v672)
										if v673["Skill 4"] then
											local v674 = {
												["Caster"] = {
													["Character"] = v_u_304
												}
											}
											v673["Skill 4"](v674)
										end
									end
									return
								elseif v_u_301 == "StrongestInHistory" then
									local v675 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v675 then
										v675 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v675 then
										local v676 = require(v675)
										if v676["Skill 4"] then
											local v677 = v676["Skill 4"]
											local v678 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["CutsceneDuration"] = 6.5,
												["DamageDelay"] = 5,
												["CharAnimationId"] = "rbxassetid://125013796988038"
											}
											local v679 = v_u_305
											if v679 then
												v679 = v_u_305.CFrame
											end
											v678.CFrame = v679
											v677(v678)
										end
									end
									return
								elseif v_u_301 == "Gojo" then
									local v_u_680 = v_u_302.V
									if v_u_680 then
										local v_u_681 = Instance.new("Attachment")
										v_u_681.Name = "BlueAtt"
										v_u_681.Position = Vector3.new(7, 2, 5)
										v_u_681.Parent = v_u_305
										local v_u_682 = Instance.new("Attachment")
										v_u_682.Name = "RedAtt"
										v_u_682.Position = Vector3.new(-7, 2, 5)
										v_u_682.Parent = v_u_305
										local v_u_683 = nil
										local v_u_684 = nil
										local function v_u_693(p685, p686)
											-- upvalues: (copy) v_u_680, (ref) v_u_305
											local v687 = v_u_680:FindFirstChild(p685)
											if not v687 then
												return nil
											end
											local v688 = v687:Clone()
											v688.CFrame = v_u_305.CFrame * CFrame.new(p686.Position)
											v688.Anchored = true
											v688.CanCollide = false
											v688.Massless = true
											v688.Transparency = 1
											v688.Parent = workspace
											local v689 = Instance.new("Attachment")
											v689.Parent = v688
											local v690 = Instance.new("AlignPosition")
											v690.Attachment0 = v689
											v690.Attachment1 = p686
											v690.RigidityEnabled = false
											v690.Responsiveness = 100
											v690.MaxForce = (1 / 0)
											v690.Parent = v688
											local v691 = Instance.new("AlignOrientation")
											v691.Attachment0 = v689
											v691.Attachment1 = p686
											v691.RigidityEnabled = false
											v691.Responsiveness = 100
											v691.MaxTorque = (1 / 0)
											v691.Parent = v688
											v688.Anchored = false
											for _, v692 in v688:GetDescendants() do
												if v692:IsA("ParticleEmitter") then
													v692.Enabled = true
												elseif v692:IsA("Beam") or v692:IsA("Trail") then
													v692.Enabled = true
												end
											end
											return v688
										end
										local function v_u_697(p694, p695)
											if p694 and p694.Parent then
												for _, v_u_696 in p694:GetDescendants() do
													if v_u_696:IsA("ParticleEmitter") then
														v_u_696.Enabled = false
														if p695 then
															pcall(function()
																-- upvalues: (copy) v_u_696
																v_u_696:Clear()
															end)
														end
													elseif v_u_696:IsA("Beam") or v_u_696:IsA("Trail") then
														v_u_696.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_683, (copy) v_u_693, (copy) v_u_681, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												v_u_683 = v_u_693("Blue", v_u_681)
												if v_u_683 then
													v_u_297:AddItem(v_u_683, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_684, (copy) v_u_693, (copy) v_u_682, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												v_u_684 = v_u_693("Red", v_u_682)
												if v_u_684 then
													v_u_297:AddItem(v_u_684, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_298, (copy) v_u_681, (copy) v_u_682, (copy) v_u_680, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v698 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_298:Create(v_u_681, v698, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_298:Create(v_u_682, v698, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_305, (ref) v_u_680, (ref) v_u_297
													if v_u_305 and v_u_305.Parent then
														local v699 = v_u_680:FindFirstChild("StarEff")
														if v699 then
															local v700 = v699:Clone()
															v700.CFrame = v_u_305.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v700.Anchored = true
															v700.CanCollide = false
															v700.Transparency = 1
															v700.Parent = workspace
															for _, v701 in v700:GetDescendants() do
																if v701:IsA("ParticleEmitter") then
																	v701:Emit(v701:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_297:AddItem(v700, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_697, (ref) v_u_683, (ref) v_u_684, (copy) v_u_681, (copy) v_u_682, (copy) v_u_680, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												v_u_697(v_u_683, true)
												v_u_697(v_u_684, true)
												if v_u_681 and v_u_681.Parent then
													v_u_681:Destroy()
												end
												if v_u_682 and v_u_682.Parent then
													v_u_682:Destroy()
												end
												local v702 = v_u_680:FindFirstChild("MiniExplosionVFX")
												if v702 then
													local v703 = v702:Clone()
													v703.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -2)
													v703.Anchored = true
													v703.CanCollide = false
													v703.Transparency = 1
													v703.Parent = workspace
													for _, v704 in v703:GetDescendants() do
														if v704:IsA("ParticleEmitter") then
															v704:Emit(v704:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_297:AddItem(v703, 3)
												end
												local v_u_705 = v_u_305.Position + v_u_305.CFrame.LookVector * 6
												local v_u_706 = v_u_305.CFrame.LookVector
												local v707 = v_u_680:FindFirstChild("Purple")
												if v707 then
													local v_u_708 = v707:Clone()
													v_u_708.Anchored = true
													v_u_708.CanCollide = false
													v_u_708.Parent = workspace
													v_u_297:AddItem(v_u_708, 3)
													for _, v709 in v_u_708:GetDescendants() do
														if v709:IsA("ParticleEmitter") then
															v709.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_705, (copy) v_u_708, (copy) v_u_706
														local v710 = v_u_705
														local v711 = 0
														while v711 < 200 and (v_u_708 and v_u_708.Parent) do
															v710 = v710 + v_u_706 * 3.9899999999999998
															v711 = v711 + 3.9899999999999998
															v_u_708.CFrame = CFrame.lookAt(v710, v710 + v_u_706)
															task.wait(0.03)
														end
														for _, v712 in v_u_708:GetDescendants() do
															if v712:IsA("ParticleEmitter") then
																v712.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_301 == "Sukuna" then
									local v_u_713 = v_u_302.V
									if v_u_713 then
										local v714 = (p_u_296.NPCModel or "NPC") .. "_SukunaV"
										local v715 = tick()
										if not v_u_295[v714] or v715 - v_u_295[v714] > 0.5 then
											v_u_295[v714] = v715
											v_u_37:PlayAt("SukunaV_Part1", p_u_296.Position)
										end
										local v716 = v_u_713:FindFirstChild("GroundVFX")
										if v716 then
											local v_u_717 = v716:Clone()
											v_u_717.CFrame = v_u_305.CFrame * CFrame.new(0, -2, 0)
											v_u_717.Anchored = false
											v_u_717.Parent = workspace
											v_u_297:AddItem(v_u_717, 3)
											local v718 = Instance.new("WeldConstraint")
											v718.Part0 = v_u_305
											v718.Part1 = v_u_717
											v718.Parent = v_u_717
											for _, v719 in v_u_717:GetDescendants() do
												if v719:IsA("ParticleEmitter") then
													v719.Enabled = true
													v719:Emit(v719:GetAttribute("EmitCount") or 40)
												elseif v719:IsA("Beam") then
													v719.Enabled = true
												end
											end
											task.delay(2.35, function()
												-- upvalues: (copy) v_u_717
												if v_u_717 and v_u_717.Parent then
													for _, v720 in v_u_717:GetDescendants() do
														if v720:IsA("ParticleEmitter") then
															v720.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_713, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v721 = v_u_713:FindFirstChild("MiniExplosionVFX")
												if v721 then
													local v722 = v721:Clone()
													v722.CFrame = v_u_305.CFrame * CFrame.new(1, 0, 0)
													v722.Anchored = false
													v722.Parent = workspace
													v_u_297:AddItem(v722, 2)
													local v723 = Instance.new("WeldConstraint")
													v723.Part0 = v_u_305
													v723.Part1 = v722
													v723.Parent = v722
													for _, v724 in v722:GetDescendants() do
														if v724:IsA("ParticleEmitter") then
															v724:Emit(v724:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v725 = v_u_713:FindFirstChild("ArrowVFX")
												if v725 then
													local v_u_726 = v725:Clone()
													v_u_726.CFrame = v_u_305.CFrame * CFrame.new(1, 0, 0)
													v_u_726.Anchored = false
													v_u_726.Parent = workspace
													v_u_297:AddItem(v_u_726, 2)
													local v727 = Instance.new("WeldConstraint")
													v727.Part0 = v_u_305
													v727.Part1 = v_u_726
													v727.Parent = v_u_726
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_726
														if v_u_726 and v_u_726.Parent then
															for _, v728 in v_u_726:GetDescendants() do
																if v728:IsA("ParticleEmitter") or v728:IsA("Beam") then
																	v728.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_305, (ref) p_u_296, (ref) v_u_295, (ref) v_u_37, (copy) v_u_713, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v729 = (p_u_296.NPCModel or "NPC") .. "_SukunaV2"
												local v730 = tick()
												if not v_u_295[v729] or v730 - v_u_295[v729] > 0.5 then
													v_u_295[v729] = v730
													v_u_37:PlayAt("SukunaV_Part2", v_u_305.Position)
												end
												local v731 = v_u_305.CFrame.LookVector
												local v732 = v_u_305.Position + v731 * 85
												local v733 = v_u_713:FindFirstChild("ExplosionVFX")
												if v733 then
													local v_u_734 = v733:Clone()
													if v_u_734:IsA("Model") then
														v_u_734:PivotTo(CFrame.new(v732) * CFrame.new(0, 73, 0))
													else
														v_u_734.CFrame = CFrame.new(v732) * CFrame.new(0, 73, 0)
													end
													v_u_734.Parent = workspace
													v_u_297:AddItem(v_u_734, 4)
													for _, v735 in v_u_734:GetDescendants() do
														if v735:IsA("ParticleEmitter") then
															v735.Enabled = true
															v735:Emit(v735:GetAttribute("EmitCount") or 30)
														elseif v735:IsA("Beam") or v735:IsA("Trail") then
															v735.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_734
														if v_u_734 and v_u_734.Parent then
															for _, v736 in v_u_734:GetDescendants() do
																if v736:IsA("ParticleEmitter") or (v736:IsA("Beam") or v736:IsA("Trail")) then
																	v736.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_301 == "Ragna" then
									v_u_37:PlayAt("RagnaV", p_u_296.Position)
									local v_u_737 = v_u_302.V
									if v_u_737 then
										local v738 = v_u_737:FindFirstChild("FirstEffects")
										if v738 then
											local v_u_739 = v738:Clone()
											v_u_739.CFrame = v_u_305.CFrame * CFrame.new(0, -2.5, 0)
											v_u_739.Anchored = false
											v_u_739.CanCollide = false
											v_u_739.Transparency = 1
											v_u_739.CastShadow = false
											v_u_739.CanQuery = false
											v_u_739.Massless = true
											v_u_739.Parent = workspace
											v_u_297:AddItem(v_u_739, 6)
											local v740 = Instance.new("WeldConstraint")
											v740.Part0 = v_u_305
											v740.Part1 = v_u_739
											v740.Parent = v_u_739
											for _, v741 in v_u_739:GetDescendants() do
												if v741:IsA("ParticleEmitter") then
													v741.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_739
												if v_u_739 and v_u_739.Parent then
													for _, v742 in v_u_739:GetDescendants() do
														if v742:IsA("ParticleEmitter") then
															v742.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_737, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v743 = v_u_737:FindFirstChild("UltVFX")
												if v743 then
													local v_u_744 = v743:Clone()
													v_u_744:PivotTo(v_u_305.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v745 in v_u_744:GetDescendants() do
														if v745:IsA("BasePart") then
															v745.Anchored = true
															v745.CanCollide = false
															v745.CastShadow = false
															v745.CanQuery = false
														end
													end
													v_u_744.Parent = workspace
													v_u_297:AddItem(v_u_744, 4.5)
													for _, v746 in v_u_744:GetDescendants() do
														if v746:IsA("ParticleEmitter") then
															v746.Enabled = true
														elseif v746:IsA("Beam") then
															v746.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_744
														if v_u_744 and v_u_744.Parent then
															for _, v747 in v_u_744:GetDescendants() do
																if v747:IsA("ParticleEmitter") then
																	v747.Enabled = false
																end
															end
															for _, v_u_748 in v_u_744:GetDescendants() do
																if v_u_748:IsA("Beam") then
																	local v_u_749 = v_u_748.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_749, (copy) v_u_748
																		local v750 = tick()
																		while tick() - v750 < 0.5 do
																			local v751 = (tick() - v750) / 0.5
																			local v752 = {}
																			for _, v753 in ipairs(v_u_749) do
																				local v754 = v753.Value + (1 - v753.Value) * v751
																				local v755 = NumberSequenceKeypoint.new
																				local v756 = v753.Time
																				table.insert(v752, v755(v756, v754))
																			end
																			v_u_748.Transparency = NumberSequence.new(v752)
																			task.wait()
																		end
																		v_u_748.Transparency = NumberSequence.new(1)
																	end)
																end
															end
														end
													end)
												end
											end
										end)
									end
								else
									if v_u_301 == "Ichigo" then
										local v757 = v_u_68.Ichigo
										if v757 and v757["Skill 4"] then
											local v758 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["CutsceneDuration"] = 8.33,
												["CharAnimationId"] = "rbxassetid://98446587158184",
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v757["Skill 4"](v758)
											return
										end
									elseif v_u_301 == "Alucard" then
										local v759 = v_u_68.Alucard
										if v759 and v759["Skill 4"] then
											local v760 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["AbilityConfig"] = {},
												["CutsceneDuration"] = 5.5,
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v759["Skill 4"](v760)
											return
										end
									elseif v_u_301 == "Rimuru" then
										local v761 = v_u_68.Rimuru
										if v761 and v761["Skill 4"] then
											local v762 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v761["Skill 4"](v762)
											return
										end
									elseif v_u_301 == "Madoka" then
										local v763 = v_u_68.Madoka
										if v763 and v763["Skill 4"] then
											local v764 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["DamageDelay"] = 3.13,
												["Duration"] = 8.63
											}
											v763["Skill 4"](v764)
											return
										end
									elseif v_u_301 == "Gilgamesh" then
										local v765 = v_u_68.Gilgamesh
										if v765 and v765["Skill 4"] then
											local v766 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["AbilityConfig"] = {}
											}
											v765["Skill 4"](v766)
											return
										end
									elseif v_u_301 == "Anos" then
										local v767 = v_u_68.Anos
										if v767 and v767["Skill 4"] then
											local v768 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v767["Skill 4"](v768)
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_296.VFXName == "F" then
						task.spawn(function()
							-- upvalues: (copy) v_u_305, (copy) v_u_301, (ref) v_u_68, (copy) v_u_304
							if v_u_305 and v_u_305.Parent then
								if v_u_301 == "Rimuru" then
									local v769 = v_u_68.Rimuru
									if v769 and v769["Skill 5"] then
										local v770 = {
											["Caster"] = {
												["Character"] = v_u_304
											},
											["AbilityConfig"] = {},
											["DisableCutscene"] = true
										}
										v769["Skill 5"](v770)
									end
								end
								if v_u_301 == "Gilgamesh" then
									local v771 = v_u_68.Gilgamesh
									if v771 and v771["Skill 5"] then
										local v772 = {
											["Caster"] = {
												["Character"] = v_u_304
											},
											["AbilityConfig"] = {}
										}
										v771["Skill 5"](v772)
									end
								end
							end
						end)
					end
				end
			else
				return
			end
		else
			return
		end
	end
	local v_u_774 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p775, p_u_776)
		-- upvalues: (copy) v_u_774, (copy) v_u_773, (copy) v_u_44, (copy) v_u_37, (copy) v_u_288, (copy) v_u_7, (copy) v_u_294, (copy) v_u_4
		if p775 == "SpawnVFX" then
			if p_u_776.IsNPC and (p_u_776.VFXName == "Z" or (p_u_776.VFXName == "X" or (p_u_776.VFXName == "C" or (p_u_776.VFXName == "V" or p_u_776.VFXName == "F")))) then
				local v777 = (p_u_776.NPCModel or "NPC") .. "_" .. p_u_776.VFXName
				local v778 = tick()
				if v_u_774[v777] and v778 - v_u_774[v777] < 1 then
					return
				end
				v_u_774[v777] = v778
				task.spawn(function()
					-- upvalues: (ref) v_u_773, (copy) p_u_776
					v_u_773(p_u_776)
				end)
				local v779 = p_u_776.MovesetType or "Saber"
				if p_u_776.VFXName == "Z" then
					if v779 == "Gojo" then
						local v780 = (p_u_776.NPCModel or "unknown") .. "_Z"
						local v781 = tick()
						local v782
						if v_u_44[v780] and v781 - v_u_44[v780] < 1.5 then
							v782 = false
						else
							v_u_44[v780] = v781
							v782 = true
						end
						if v782 then
							v_u_37:PlayAt("GojoZ", p_u_776.Position)
						end
					elseif v779 == "Sukuna" then
						local v783 = (p_u_776.NPCModel or "unknown") .. "_Z"
						local v784 = tick()
						local v785
						if v_u_44[v783] and v784 - v_u_44[v783] < 1.5 then
							v785 = false
						else
							v_u_44[v783] = v784
							v785 = true
						end
						if v785 then
							v_u_37:PlayAt("SukunaZ", p_u_776.Position)
						end
					elseif v779 == "Jinwoo" then
						local v786 = (p_u_776.NPCModel or "unknown") .. "_Z"
						local v787 = tick()
						local v788
						if v_u_44[v786] and v787 - v_u_44[v786] < 1.5 then
							v788 = false
						else
							v_u_44[v786] = v787
							v788 = true
						end
						if v788 then
							v_u_37:PlayAt("JinwooZ", p_u_776.Position)
						end
					elseif v779 == "Ragna" then
						local v789 = (p_u_776.NPCModel or "unknown") .. "_Z"
						local v790 = tick()
						local v791
						if v_u_44[v789] and v790 - v_u_44[v789] < 1.5 then
							v791 = false
						else
							v_u_44[v789] = v790
							v791 = true
						end
						if v791 then
							v_u_37:PlayAt("RagnaZ", p_u_776.Position)
						end
					elseif v779 == "Aizen" then
						local v792 = (p_u_776.NPCModel or "unknown") .. "_Z"
						local v793 = tick()
						local v794
						if v_u_44[v792] and v793 - v_u_44[v792] < 1.5 then
							v794 = false
						else
							v_u_44[v792] = v793
							v794 = true
						end
						if v794 then
							v_u_37:PlayAt("AizenZ", p_u_776.Position)
						end
					elseif v779 == "QinShi" then
						local v795 = (p_u_776.NPCModel or "unknown") .. "_Z"
						local v796 = tick()
						local v797
						if v_u_44[v795] and v796 - v_u_44[v795] < 1.5 then
							v797 = false
						else
							v_u_44[v795] = v796
							v797 = true
						end
						if v797 then
							v_u_37:PlayAt("QinShiZ", p_u_776.Position)
						end
					elseif v779 == "Yuji" then
						local v798 = (p_u_776.NPCModel or "unknown") .. "_Z"
						local v799 = tick()
						local v800
						if v_u_44[v798] and v799 - v_u_44[v798] < 1.5 then
							v800 = false
						else
							v_u_44[v798] = v799
							v800 = true
						end
						if v800 then
							v_u_37:PlayAt("YujiZ", p_u_776.Position)
						end
					elseif v779 ~= "Alucard" then
						if v779 == "GojoV2" then
							local v801 = (p_u_776.NPCModel or "unknown") .. "_Z"
							local v802 = tick()
							local v803
							if v_u_44[v801] and v802 - v_u_44[v801] < 1.5 then
								v803 = false
							else
								v_u_44[v801] = v802
								v803 = true
							end
							if v803 then
								v_u_37:PlayAt("GojoV2Z", p_u_776.Position)
							end
						elseif v779 ~= "StrongestInHistory" and (v779 ~= "Rimuru" and (v779 ~= "Madoka" and v779 ~= "Anos")) then
							local v804 = (p_u_776.NPCModel or "unknown") .. "_Z"
							local v805 = tick()
							local v806
							if v_u_44[v804] and v805 - v_u_44[v804] < 1.5 then
								v806 = false
							else
								v_u_44[v804] = v805
								v806 = true
							end
							if v806 then
								v_u_37:PlayAt("SaberZ", p_u_776.Position)
							end
						end
					end
				elseif p_u_776.VFXName == "X" then
					if v779 == "Gojo" then
						local v807 = (p_u_776.NPCModel or "unknown") .. "_X"
						local v808 = tick()
						local v809
						if v_u_44[v807] and v808 - v_u_44[v807] < 1.5 then
							v809 = false
						else
							v_u_44[v807] = v808
							v809 = true
						end
						if v809 then
							v_u_37:PlayAt("GojoX", p_u_776.Position)
						end
					elseif v779 == "Sukuna" then
						local v810 = (p_u_776.NPCModel or "unknown") .. "_X"
						local v811 = tick()
						local v812
						if v_u_44[v810] and v811 - v_u_44[v810] < 1.5 then
							v812 = false
						else
							v_u_44[v810] = v811
							v812 = true
						end
						if v812 then
							v_u_37:PlayAt("SukunaX", p_u_776.Position)
						end
					elseif v779 == "Jinwoo" then
						local v813 = (p_u_776.NPCModel or "unknown") .. "_X"
						local v814 = tick()
						local v815
						if v_u_44[v813] and v814 - v_u_44[v813] < 1.5 then
							v815 = false
						else
							v_u_44[v813] = v814
							v815 = true
						end
						if v815 then
							v_u_37:PlayAt("JinwooX", p_u_776.Position)
						end
					elseif v779 == "Ragna" then
						local v816 = (p_u_776.NPCModel or "unknown") .. "_X"
						local v817 = tick()
						local v818
						if v_u_44[v816] and v817 - v_u_44[v816] < 1.5 then
							v818 = false
						else
							v_u_44[v816] = v817
							v818 = true
						end
						if v818 then
							v_u_37:PlayAt("RagnaX", p_u_776.Position)
						end
					elseif v779 == "Aizen" then
						local v819 = (p_u_776.NPCModel or "unknown") .. "_X"
						local v820 = tick()
						local v821
						if v_u_44[v819] and v820 - v_u_44[v819] < 1.5 then
							v821 = false
						else
							v_u_44[v819] = v820
							v821 = true
						end
						if v821 then
							v_u_37:PlayAt("AizenX", p_u_776.Position)
						end
					elseif v779 == "QinShi" then
						local v822 = (p_u_776.NPCModel or "unknown") .. "_X"
						local v823 = tick()
						local v824
						if v_u_44[v822] and v823 - v_u_44[v822] < 1.5 then
							v824 = false
						else
							v_u_44[v822] = v823
							v824 = true
						end
						if v824 then
							v_u_37:PlayAt("QinShiX", p_u_776.Position)
						end
					elseif v779 == "Yuji" then
						local v825 = (p_u_776.NPCModel or "unknown") .. "_X"
						local v826 = tick()
						local v827
						if v_u_44[v825] and v826 - v_u_44[v825] < 1.5 then
							v827 = false
						else
							v_u_44[v825] = v826
							v827 = true
						end
						if v827 then
							v_u_37:PlayAt("YujiX", p_u_776.Position)
						end
					elseif v779 ~= "Ichigo" and v779 ~= "Alucard" then
						if v779 == "GojoV2" then
							local v828 = (p_u_776.NPCModel or "unknown") .. "_X"
							local v829 = tick()
							local v830
							if v_u_44[v828] and v829 - v_u_44[v828] < 1.5 then
								v830 = false
							else
								v_u_44[v828] = v829
								v830 = true
							end
							if v830 then
								v_u_37:PlayAt("GojoV2X", p_u_776.Position)
							end
						elseif v779 ~= "StrongestInHistory" and (v779 ~= "Rimuru" and (v779 ~= "Madoka" and v779 ~= "Anos")) then
							local v831 = (p_u_776.NPCModel or "unknown") .. "_X"
							local v832 = tick()
							local v833
							if v_u_44[v831] and v832 - v_u_44[v831] < 1.5 then
								v833 = false
							else
								v_u_44[v831] = v832
								v833 = true
							end
							if v833 then
								v_u_37:PlayAt("SaberX", p_u_776.Position)
							end
						end
					end
				elseif p_u_776.VFXName == "C" then
					if v779 == "Gojo" then
						local v834 = (p_u_776.NPCModel or "unknown") .. "_C"
						local v835 = tick()
						local v836
						if v_u_44[v834] and v835 - v_u_44[v834] < 1.5 then
							v836 = false
						else
							v_u_44[v834] = v835
							v836 = true
						end
						if v836 then
							v_u_37:PlayAt("GojoC", p_u_776.Position)
							v_u_37:PlayAt("GojoC_Hold", p_u_776.Position)
						end
					elseif v779 == "Jinwoo" then
						local v837 = (p_u_776.NPCModel or "unknown") .. "_C"
						local v838 = tick()
						local v839
						if v_u_44[v837] and v838 - v_u_44[v837] < 1.5 then
							v839 = false
						else
							v_u_44[v837] = v838
							v839 = true
						end
						if v839 then
							v_u_37:PlayAt("JinwooC", p_u_776.Position)
						end
					elseif v779 == "Ragna" then
						local v840 = (p_u_776.NPCModel or "unknown") .. "_C"
						local v841 = tick()
						local v842
						if v_u_44[v840] and v841 - v_u_44[v840] < 1.5 then
							v842 = false
						else
							v_u_44[v840] = v841
							v842 = true
						end
						if v842 then
							v_u_37:PlayAt("RagnaC_Startup", p_u_776.Position)
						end
					elseif v779 == "Aizen" then
						local v843 = (p_u_776.NPCModel or "unknown") .. "_C"
						local v844 = tick()
						local v845
						if v_u_44[v843] and v844 - v_u_44[v843] < 1.5 then
							v845 = false
						else
							v_u_44[v843] = v844
							v845 = true
						end
						if v845 then
							v_u_37:PlayAt("AizenC", p_u_776.Position)
						end
					elseif v779 == "QinShi" then
						local v846 = (p_u_776.NPCModel or "unknown") .. "_C"
						local v847 = tick()
						local v848
						if v_u_44[v846] and v847 - v_u_44[v846] < 1.5 then
							v848 = false
						else
							v_u_44[v846] = v847
							v848 = true
						end
						if v848 then
							v_u_37:PlayAt("QinShiC", p_u_776.Position)
						end
					elseif v779 == "Yuji" then
						local v849 = (p_u_776.NPCModel or "unknown") .. "_C"
						local v850 = tick()
						local v851
						if v_u_44[v849] and v850 - v_u_44[v849] < 1.5 then
							v851 = false
						else
							v_u_44[v849] = v850
							v851 = true
						end
						if v851 then
							v_u_37:PlayAt("YujiC_Press", p_u_776.Position)
						end
					elseif v779 ~= "Ichigo" and (v779 ~= "Alucard" and (v779 ~= "GojoV2" and (v779 ~= "StrongestInHistory" and (v779 ~= "Rimuru" and (v779 ~= "Madoka" and v779 ~= "Anos"))))) then
						local v852 = (p_u_776.NPCModel or "unknown") .. "_C"
						local v853 = tick()
						local v854
						if v_u_44[v852] and v853 - v_u_44[v852] < 1.5 then
							v854 = false
						else
							v_u_44[v852] = v853
							v854 = true
						end
						if v854 then
							v_u_37:PlayAt("SaberC_Cast", p_u_776.Position)
							task.delay(3.85, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_776
								v_u_37:PlayAt("SaberC_Beam", p_u_776.Position)
							end)
							task.delay(4.4, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_776
								v_u_37:PlayAt("SaberC_Explosion", p_u_776.Position)
							end)
						end
					end
				elseif p_u_776.VFXName == "V" then
					if v779 == "Gojo" then
						v_u_37:PlayAt("GojoV", p_u_776.Position)
					elseif v779 ~= "Sukuna" and (v779 ~= "Ichigo" and (v779 ~= "Alucard" and (v779 ~= "GojoV2" and (v779 ~= "StrongestInHistory" and (v779 ~= "Rimuru" and v779 ~= "Madoka"))))) then
						local _ = v779 == "Anos"
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_288, (copy) p_u_776
					v_u_288.SpawnVFX(p_u_776.VFXName, p_u_776.Position, p_u_776.Scale, p_u_776.Duration, p_u_776.AbilityName)
				end)
			end
			if p_u_776.CameraShake then
				task.delay(p_u_776.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_776, (ref) v_u_7
					local v_u_855 = p_u_776.CameraShake.Intensity or 5
					local v_u_856 = p_u_776.CameraShake.Duration or 0.3
					if v_u_7:GetAttribute("DisableScreenShake") then
						return
					else
						local v_u_857 = workspace.CurrentCamera
						if v_u_857 then
							task.spawn(function()
								-- upvalues: (copy) v_u_857, (copy) v_u_856, (copy) v_u_855
								local v858 = tick()
								local _ = v_u_857.CFrame
								while tick() - v858 < v_u_856 do
									local v859 = v_u_855 * (1 - (tick() - v858) / v_u_856)
									local v860 = (math.random() - 0.5) * v859 * 0.1
									local v861 = (math.random() - 0.5) * v859 * 0.1
									v_u_857.CFrame = v_u_857.CFrame * CFrame.new(v860, v861, 0)
									task.wait()
								end
							end)
						end
					end
				end)
			end
			if p_u_776.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_294, (copy) p_u_776
					v_u_294(p_u_776.ScreenFlash)
				end)
				return
			end
		elseif p775 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_288, (copy) p_u_776, (ref) v_u_4
				local v862 = v_u_288.SpawnVFXWithRotation(p_u_776.VFXName, p_u_776.Position, p_u_776.Rotation, p_u_776.Scale, p_u_776.Duration, "KatanaAbilities")
				if v862 then
					v_u_4:AddItem(v862, (p_u_776.Duration or 0.4) + 1)
				end
			end)
			if p_u_776.IsNPC then
				v_u_37:PlayAt("KatanaZ", p_u_776.Position)
			end
			if p_u_776.CameraShake then
				local v_u_863 = p_u_776.CameraShake.Intensity or 3
				local v_u_864 = p_u_776.CameraShake.Duration or 0.2
				if v_u_7:GetAttribute("DisableScreenShake") then
					return
				else
					local v_u_865 = workspace.CurrentCamera
					if v_u_865 then
						task.spawn(function()
							-- upvalues: (copy) v_u_865, (copy) v_u_864, (copy) v_u_863
							local v866 = tick()
							local _ = v_u_865.CFrame
							while tick() - v866 < v_u_864 do
								local v867 = v_u_863 * (1 - (tick() - v866) / v_u_864)
								local v868 = (math.random() - 0.5) * v867 * 0.1
								local v869 = (math.random() - 0.5) * v867 * 0.1
								v_u_865.CFrame = v_u_865.CFrame * CFrame.new(v868, v869, 0)
								task.wait()
							end
						end)
					end
				end
			end
		elseif p775 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_288, (copy) p_u_776, (ref) v_u_4
				local v870 = v_u_288.SpawnTravelingVFX(p_u_776.VFXName, p_u_776.StartPosition, p_u_776.Direction, p_u_776.TravelDistance, p_u_776.TravelSpeed, p_u_776.Scale, p_u_776.Duration, "KatanaAbilities")
				if v870 then
					v_u_4:AddItem(v870, (p_u_776.TravelDistance or 50) / (p_u_776.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_776.CameraShake then
				local v_u_871 = p_u_776.CameraShake.Intensity or 6
				local v_u_872 = p_u_776.CameraShake.Duration or 0.3
				local v_u_873 = not v_u_7:GetAttribute("DisableScreenShake") and workspace.CurrentCamera
				if v_u_873 then
					task.spawn(function()
						-- upvalues: (copy) v_u_873, (copy) v_u_872, (copy) v_u_871
						local v874 = tick()
						local _ = v_u_873.CFrame
						while tick() - v874 < v_u_872 do
							local v875 = v_u_871 * (1 - (tick() - v874) / v_u_872)
							local v876 = (math.random() - 0.5) * v875 * 0.1
							local v877 = (math.random() - 0.5) * v875 * 0.1
							v_u_873.CFrame = v_u_873.CFrame * CFrame.new(v876, v877, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_776.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_294, (copy) p_u_776
					v_u_294(p_u_776.ScreenFlash)
				end)
			end
		end
	end)
	local v878 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_879 = 1
	v878.OnClientEvent:Connect(function(p880)
		-- upvalues: (ref) v_u_879, (copy) v_u_37
		if p880 and p880.Position then
			v_u_37:PlayAt("CombatHit" .. v_u_879, p880.Position)
			v_u_879 = v_u_879 % 7 + 1
		end
	end)
	local v_u_881 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v882 = v46:WaitForChild("HitboxVisualize", 5)
	if v882 then
		v882.OnClientEvent:Connect(function(p883)
			-- upvalues: (copy) v_u_881
			if p883.Type == "Box" then
				v_u_881.ShowBox(p883.CFrame, p883.Size, p883.Duration, p883.Color)
				return
			elseif p883.Type == "Sphere" then
				v_u_881.ShowSphere(p883.Position, p883.Radius, p883.Duration, p883.Color)
				return
			elseif p883.Type == "Traveling" then
				v_u_881.ShowTraveling(p883.StartPos, p883.Direction, p883.Size, p883.Speed, p883.Distance, p883.HitboxType, p883.Color)
			elseif p883.Type == "FollowingAOE" then
				local v884 = p883.Character
				if v884 then
					v_u_881.ShowFollowingAOE(v884, p883.Size, p883.Duration, p883.Offset, p883.Color, p883.Shape)
					return
				end
			else
				if p883.Type == "MultiWave" then
					v_u_881.ShowMultiWave(p883.OriginCFrame, p883.Waves)
					return
				end
				if p883.Type == "Explosion" then
					v_u_881.ShowExplosion(p883.Position, p883.Radius, p883.Duration, p883.Color)
					return
				end
				if p883.Type == "StaticBox" then
					v_u_881.ShowStaticBox(p883.StartPos, p883.EndPos, p883.Width, p883.Height, p883.Duration, p883.Color)
				end
			end
		end)
	end
end)
if not v885 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v886)
	warn("=====================================")
end