local v878, v879 = pcall(function()
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
						if v275 and (v275.Type == "ContinuousDamage" and (v277 and not (v275.AnchorHitbox or p_u_256.AnchorHitbox))) then
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
	local function v_u_766(p_u_296)
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
										else
											task.wait(0.45)
											if not (v_u_305 and v_u_305.Parent) then
												return
											end
											local v395 = v_u_305.CFrame
											local v396 = v_u_302.Z:FindFirstChild("EnergyThrust")
											local v397 = v_u_302.Z:FindFirstChild("EnergyPart")
											if v396 then
												v_u_311(v396, v395 * CFrame.new(0, 2, -35), 3)
											end
											if v397 then
												v_u_311(v397, v395 * CFrame.new(0, 2, -2), 3)
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
									local v_u_398 = v_u_304:FindFirstChild("Right Arm")
									if v_u_398 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_302, (copy) v_u_398, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v399 = v_u_302.X:FindFirstChild("BlueVFXFirst")
												if v399 then
													local v400 = v399:Clone()
													v400.CFrame = v_u_398.CFrame * CFrame.new(0, -1.05, 0)
													v400.Anchored = true
													v400.CanCollide = false
													v400.Transparency = 1
													v400.CastShadow = false
													v400.CanQuery = false
													v400.Parent = workspace
													v_u_297:AddItem(v400, 4)
													for _, v_u_401 in v400:GetDescendants() do
														if v_u_401:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_401
																local v402 = v_u_401:GetAttribute("EmitDelay") or 0
																task.wait(v402)
																v_u_401:Emit(v_u_401:GetAttribute("EmitCount") or v_u_401.Rate)
															end)
														end
													end
													v400.Anchored = false
													local v403 = Instance.new("WeldConstraint")
													v403.Part0 = v_u_398
													v403.Part1 = v400
													v403.Parent = v400
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_302, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v404 = v_u_305.CFrame
												local v405 = v_u_302.X:FindFirstChild("BlueMainVFX")
												if v405 then
													local v406 = v405:Clone()
													v406.CFrame = v404 * CFrame.new(0, 0, -25)
													v406.Anchored = true
													v406.CanCollide = false
													v406.Transparency = 1
													v406.CastShadow = false
													v406.CanQuery = false
													v406.Parent = workspace
													v_u_297:AddItem(v406, 3)
													for _, v_u_407 in v406:GetDescendants() do
														if v_u_407:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_407
																local v408 = v_u_407:GetAttribute("EmitDelay") or 0
																task.wait(v408)
																v_u_407:Emit(v_u_407:GetAttribute("EmitCount") or v_u_407.Rate)
															end)
														end
													end
												end
												local v409 = v_u_302.X:FindFirstChild("Blue_Additional_VFX")
												if v409 then
													local v410 = v409:Clone()
													v410.CFrame = v404 * CFrame.new(0, 0, -5)
													v410.Anchored = true
													v410.CanCollide = false
													v410.Transparency = 1
													v410.CastShadow = false
													v410.CanQuery = false
													v410.Parent = workspace
													v_u_297:AddItem(v410, 4)
													for _, v_u_411 in v410:GetDescendants() do
														if v_u_411:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_411
																local v412 = v_u_411:GetAttribute("EmitDelay") or 0
																task.wait(v412)
																v_u_411:Emit(v_u_411:GetAttribute("EmitCount") or v_u_411.Rate)
															end)
														end
													end
												end
											end
										end)
									end
								else
									if v_u_301 == "Sukuna" then
										local v413 = v_u_302.X
										if not v413 then
											return
										end
										local v414 = v413:FindFirstChild("GroundVFX")
										if v414 then
											local v_u_415 = v414:Clone()
											v_u_415:PivotTo(v_u_305.CFrame * CFrame.new(0, -2.5, 0))
											v_u_415.Parent = workspace
											v_u_297:AddItem(v_u_415, 3.5)
											local v416 = v_u_415.PrimaryPart or v_u_415:FindFirstChildWhichIsA("BasePart")
											for _, v417 in v_u_415:GetDescendants() do
												if v417:IsA("BasePart") then
													v417.Anchored = false
													v417.CanCollide = false
													v417.CanQuery = false
													v417.CanTouch = false
													v417.Massless = true
												end
											end
											if v416 then
												local v418 = Instance.new("WeldConstraint")
												v418.Part0 = v_u_305
												v418.Part1 = v416
												v418.Parent = v416
											end
											task.delay(2.6, function()
												-- upvalues: (copy) v_u_415
												if v_u_415 and v_u_415.Parent then
													for _, v419 in v_u_415:GetDescendants() do
														if v419:IsA("ParticleEmitter") then
															v419.Enabled = false
														end
													end
												end
											end)
											return
										end
									elseif v_u_301 == "Jinwoo" then
										local v420 = v_u_302.X
										if not v420 then
											return
										end
										local v421 = v420:FindFirstChild("DashVFX")
										local v422 = v420:FindFirstChild("SlashesVFX")
										local v423 = v_u_305.CFrame.LookVector
										local v424 = CFrame.lookAt(v_u_305.Position, v_u_305.Position + v423)
										if v421 then
											local v_u_425 = v421:Clone()
											v_u_425.CFrame = v424
											v_u_425.Anchored = false
											v_u_425.CanCollide = false
											v_u_425.Transparency = 1
											v_u_425.CastShadow = false
											v_u_425.CanQuery = false
											v_u_425.Massless = true
											v_u_425.Parent = workspace
											v_u_297:AddItem(v_u_425, 1.5)
											local v426 = Instance.new("WeldConstraint")
											v426.Part0 = v_u_305
											v426.Part1 = v_u_425
											v426.Parent = v_u_425
											for _, v427 in v_u_425:GetDescendants() do
												if v427:IsA("ParticleEmitter") then
													v427.Enabled = true
													v427:Emit(v427:GetAttribute("EmitCount") or 30)
												end
											end
											task.delay(0.5, function()
												-- upvalues: (copy) v_u_425
												if v_u_425 and v_u_425.Parent then
													for _, v428 in v_u_425:GetDescendants() do
														if v428:IsA("ParticleEmitter") then
															v428.Enabled = false
														end
													end
												end
											end)
										end
										if v422 then
											local v429 = v422:Clone()
											v429.CFrame = v424 * CFrame.new(0, 0, -20)
											v429.Anchored = true
											v429.CanCollide = false
											v429.Transparency = 1
											v429.CastShadow = false
											v429.CanQuery = false
											v429.Parent = workspace
											v_u_297:AddItem(v429, 1.5)
											for _, v_u_430 in v429:GetDescendants() do
												if v_u_430:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_430
														local v431 = v_u_430:GetAttribute("EmitDelay") or 0
														if v431 > 0 then
															task.wait(v431)
														end
														v_u_430:Emit(v_u_430:GetAttribute("EmitCount") or v_u_430.Rate)
													end)
												end
											end
											return
										end
									elseif v_u_301 == "Ragna" then
										local v_u_432 = v_u_302.X
										if v_u_432 then
											local v433 = v_u_432:FindFirstChild("GroundVFX")
											if v433 then
												local v434 = v433:Clone()
												v434.CFrame = v_u_305.CFrame * CFrame.new(0, -2.5, 0)
												v434.Anchored = true
												v434.CanCollide = false
												v434.Transparency = 1
												v434.Parent = workspace
												v_u_297:AddItem(v434, 5)
												for _, v_u_435 in v434:GetDescendants() do
													if v_u_435:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_435
															local v436 = v_u_435:GetAttribute("EmitDelay") or 0
															if v436 > 0 then
																task.wait(v436)
															end
															v_u_435:Emit(v_u_435:GetAttribute("EmitCount") or v_u_435.Rate)
														end)
													end
												end
											end
											local v437 = v_u_432:FindFirstChild("ChargeVFX")
											if v437 then
												local v_u_438 = v437:Clone()
												v_u_438.CFrame = v_u_305.CFrame
												v_u_438.Anchored = false
												v_u_438.CanCollide = false
												v_u_438.Transparency = 1
												v_u_438.Massless = true
												v_u_438.Parent = workspace
												v_u_297:AddItem(v_u_438, 1.3)
												local v439 = Instance.new("WeldConstraint")
												v439.Part0 = v_u_305
												v439.Part1 = v_u_438
												v439.Parent = v_u_438
												for _, v440 in v_u_438:GetDescendants() do
													if v440:IsA("ParticleEmitter") then
														v440.Enabled = true
													end
												end
												task.delay(0.4, function()
													-- upvalues: (copy) v_u_438
													if v_u_438 and v_u_438.Parent then
														for _, v441 in v_u_438:GetDescendants() do
															if v441:IsA("ParticleEmitter") then
																v441.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(0.44999999999999996, function()
												-- upvalues: (ref) v_u_305, (copy) v_u_432, (ref) v_u_297
												if v_u_305 and v_u_305.Parent then
													local v442 = v_u_432:FindFirstChild("BarrageVFX")
													if v442 then
														local v_u_443 = v442:Clone()
														v_u_443.CFrame = v_u_305.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_443.Anchored = true
														v_u_443.CanCollide = false
														v_u_443.Transparency = 1
														v_u_443.Parent = workspace
														v_u_297:AddItem(v_u_443, 2.9)
														for _, v444 in v_u_443:GetDescendants() do
															if v444:IsA("ParticleEmitter") then
																v444.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_443
															if v_u_443 and v_u_443.Parent then
																for _, v445 in v_u_443:GetDescendants() do
																	if v445:IsA("ParticleEmitter") then
																		v445.Enabled = false
																	end
																end
															end
														end)
													end
													local v446 = v_u_432:FindFirstChild("BarrageGroundVFX")
													if v446 then
														local v_u_447 = v446:Clone()
														v_u_447.CFrame = v_u_305.CFrame * CFrame.new(0, -37.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_447.Anchored = true
														v_u_447.CanCollide = false
														v_u_447.Transparency = 1
														v_u_447.Parent = workspace
														v_u_297:AddItem(v_u_447, 2.7)
														for _, v448 in v_u_447:GetDescendants() do
															if v448:IsA("ParticleEmitter") then
																v448.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_447
															if v_u_447 and v_u_447.Parent then
																for _, v449 in v_u_447:GetDescendants() do
																	if v449:IsA("ParticleEmitter") then
																		v449.Enabled = false
																	end
																end
															end
														end)
													end
												end
											end)
											task.delay(2, function()
												-- upvalues: (ref) v_u_305, (copy) v_u_432, (ref) v_u_297
												if v_u_305 and v_u_305.Parent then
													local v450 = v_u_432:FindFirstChild("ChargeVFX")
													if v450 then
														local v_u_451 = v450:Clone()
														v_u_451.CFrame = v_u_305.CFrame
														v_u_451.Anchored = false
														v_u_451.CanCollide = false
														v_u_451.Transparency = 1
														v_u_451.Massless = true
														v_u_451.Parent = workspace
														v_u_297:AddItem(v_u_451, 1)
														local v452 = Instance.new("WeldConstraint")
														v452.Part0 = v_u_305
														v452.Part1 = v_u_451
														v452.Parent = v_u_451
														for _, v453 in v_u_451:GetDescendants() do
															if v453:IsA("ParticleEmitter") then
																v453.Enabled = true
															end
														end
														task.delay(0.6, function()
															-- upvalues: (copy) v_u_451
															if v_u_451 and v_u_451.Parent then
																for _, v454 in v_u_451:GetDescendants() do
																	if v454:IsA("ParticleEmitter") then
																		v454.Enabled = false
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
											local v455 = v_u_302.X:FindFirstChild("BarrageVFX")
											if v455 then
												local v_u_456 = v455:Clone()
												v_u_456.CFrame = v_u_305.CFrame * CFrame.new(0, 4, -15)
												v_u_456.Anchored = false
												v_u_456.CanCollide = false
												v_u_456.Transparency = 1
												v_u_456.CastShadow = false
												v_u_456.CanQuery = false
												v_u_456.Massless = true
												v_u_456.Parent = workspace
												v_u_297:AddItem(v_u_456, 3.7)
												local v457 = Instance.new("WeldConstraint")
												v457.Part0 = v_u_305
												v457.Part1 = v_u_456
												v457.Parent = v_u_456
												for _, v458 in v_u_456:GetDescendants() do
													if v458:IsA("ParticleEmitter") or (v458:IsA("Beam") or v458:IsA("Trail")) then
														v458.Enabled = true
													end
												end
												task.delay(1.7, function()
													-- upvalues: (copy) v_u_456
													if v_u_456 and v_u_456.Parent then
														for _, v459 in v_u_456:GetDescendants() do
															if v459:IsA("ParticleEmitter") or (v459:IsA("Beam") or v459:IsA("Trail")) then
																v459.Enabled = false
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
												local v460 = { 0, 0 }
												local v461 = {
													{ 180, 180, 135 },
													{ 180, 180, 45 }
												}
												for v462 = 1, 2 do
													if not (v_u_305 and v_u_305.Parent) then
														break
													end
													local v463 = v460[v462]
													local v464 = v461[v462][1]
													local v465 = v461[v462][2]
													local v466 = v461[v462][3]
													local v467 = v_u_305.CFrame * CFrame.Angles(0, math.rad(v463), 0)
													local v468 = v467.Position
													local v469 = v468 + v467.LookVector * 80
													local v470 = CFrame.Angles(math.rad(v464), math.rad(v465), (math.rad(v466)))
													local v471 = CFrame.lookAt(v468, v469) * v470
													local v472 = CFrame.lookAt(v469, v469 + v467.LookVector) * v470
													local v473 = v_u_302.X:FindFirstChild("StartVFX")
													if v473 then
														local v474 = v473:Clone()
														v474.CFrame = v471
														v474.Anchored = true
														v474.CanCollide = false
														v474.Transparency = 1
														v474.Parent = workspace
														v_u_297:AddItem(v474, 2)
														for _, v475 in v474:GetDescendants() do
															if v475:IsA("ParticleEmitter") then
																v475:Emit(v475:GetAttribute("EmitCount") or v475.Rate)
															end
														end
													end
													local v476 = v_u_302.X:FindFirstChild("SlashVFX")
													if v476 then
														local v_u_477 = v476:Clone()
														v_u_477.CFrame = v471
														v_u_477.Anchored = true
														v_u_477.CanCollide = false
														v_u_477.Transparency = 1
														v_u_477.Parent = workspace
														v_u_297:AddItem(v_u_477, 3)
														for _, v478 in v_u_477:GetDescendants() do
															if v478:IsA("ParticleEmitter") or (v478:IsA("Beam") or v478:IsA("Trail")) then
																v478.Enabled = true
															end
														end
														local v479 = v_u_298:Create(v_u_477, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															["CFrame"] = v472
														})
														v479:Play()
														v479.Completed:Connect(function()
															-- upvalues: (copy) v_u_477
															for _, v480 in v_u_477:GetDescendants() do
																if v480:IsA("ParticleEmitter") or (v480:IsA("Beam") or v480:IsA("Trail")) then
																	v480.Enabled = false
																end
															end
														end)
													end
													if v462 < 2 then
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
													local v481 = v_u_302:FindFirstChild("X")
													if v481 then
														local v482 = v481:FindFirstChild("StompVFX")
														if v482 then
															local v483 = v_u_305.Position - Vector3.new(0, 2.5, 0)
															local v484 = v482:Clone()
															local v485 = v484:FindFirstChild("Main")
															local v486 = v484:FindFirstChild("Lightning")
															if v485 then
																v485.CFrame = CFrame.new(v483)
																v485.Anchored = true
																v485.CanCollide = false
																v485.Transparency = 1
															end
															if v486 then
																v486.CFrame = CFrame.new(v483 + Vector3.new(0, 13, 0))
																v486.Anchored = true
																v486.CanCollide = false
																v486.Transparency = 1
															end
															v484.Parent = workspace
															v_u_297:AddItem(v484, 3)
															for _, v_u_487 in v484:GetDescendants() do
																if v_u_487:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_487
																		local v488 = v_u_487:GetAttribute("EmitDelay") or 0
																		task.wait(v488)
																		v_u_487:Emit(v_u_487:GetAttribute("EmitCount") or v_u_487.Rate)
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
											local v489 = v_u_302.X
											local v490 = v489 and v489:FindFirstChild("BarrageVFX")
											if v490 then
												local v_u_491 = v490:Clone()
												v_u_491.CFrame = v_u_305.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, -1.5707963267948966, 0)
												v_u_491.Anchored = false
												v_u_491.CanCollide = false
												v_u_491.Transparency = 1
												v_u_491.CastShadow = false
												v_u_491.CanQuery = false
												v_u_491.Massless = true
												v_u_491.Parent = workspace
												v_u_297:AddItem(v_u_491, 4)
												local v492 = Instance.new("WeldConstraint")
												v492.Part0 = v_u_305
												v492.Part1 = v_u_491
												v492.Parent = v_u_491
												for _, v493 in v_u_491:GetDescendants() do
													if v493:IsA("ParticleEmitter") then
														v493.Enabled = true
													end
												end
												task.delay(3.2, function()
													-- upvalues: (copy) v_u_491
													if v_u_491 and v_u_491.Parent then
														for _, v494 in v_u_491:GetDescendants() do
															if v494:IsA("ParticleEmitter") then
																v494.Enabled = false
															end
														end
													end
												end)
												return
											end
										elseif v_u_301 == "Alucard" then
											local v495 = v_u_68.Alucard
											if v495 and v495["Skill 2"] then
												local v496 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v495["Skill 2"](v496)
												return
											end
										elseif v_u_301 == "GojoV2" then
											local v497 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v497 then
												v497 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v497 then
												local v498 = require(v497)
												if v498["Skill 2"] then
													v498["Skill 2"]({
														["Caster"] = {
															["Character"] = v_u_304
														},
														["Duration"] = p_u_296.Duration or 6
													})
													return
												end
											end
										elseif v_u_301 == "StrongestInHistory" then
											local v499 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v499 then
												v499 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v499 then
												local v500 = require(v499)
												if v500["Skill 2"] then
													local v501 = {
														["Caster"] = {
															["Character"] = v_u_304
														}
													}
													v500["Skill 2"](v501)
													return
												end
											end
										elseif v_u_301 == "Ichigo" then
											local v502 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v502 then
												v502 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("Ichigo")
											end
											if v502 then
												local v503 = require(v502)
												if v503 and v503["Skill 2"] then
													local v504 = {
														["Caster"] = {
															["Character"] = v_u_304
														},
														["Duration"] = 4
													}
													v503["Skill 2"](v504)
													return
												end
											end
										elseif v_u_301 == "Rimuru" then
											local v505 = v_u_68.Rimuru
											if v505 and v505["Skill 2"] then
												local v506 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v505["Skill 2"](v506)
												return
											end
										elseif v_u_301 == "Madoka" then
											local v507 = v_u_68.Madoka
											if v507 and v507["Skill 2"] then
												v507["Skill 2"]({
													["Caster"] = {
														["Character"] = v_u_304
													},
													["Position"] = v_u_305 and v_u_305.Position + v_u_305.CFrame.LookVector * 50 or nil
												})
												return
											end
										elseif v_u_301 == "Gilgamesh" then
											local v508 = v_u_68.Gilgamesh
											if v508 and v508["Skill 2"] then
												local v509 = {
													["Caster"] = {
														["Character"] = v_u_304
													},
													["AbilityConfig"] = {}
												}
												v508["Skill 2"](v509)
												return
											end
										else
											task.wait(0.35)
											if not (v_u_305 and v_u_305.Parent) then
												return
											end
											local v510 = v_u_305.CFrame
											local v511 = v_u_302.X:FindFirstChild("EnergySlashes")
											if not v511 then
												return
											end
											local v_u_512 = v511:Clone()
											v_u_512.CFrame = v510 * CFrame.new(0, 1.5, -20)
											v_u_512.Anchored = false
											v_u_512.CanCollide = false
											v_u_512.Transparency = 1
											v_u_512.CastShadow = false
											v_u_512.CanQuery = false
											v_u_512.Massless = true
											v_u_512.Parent = workspace
											v_u_297:AddItem(v_u_512, 4)
											local v513 = Instance.new("WeldConstraint")
											v513.Part0 = v_u_512
											v513.Part1 = v_u_305
											v513.Parent = v_u_512
											v_u_297:AddItem(v513, 2.06)
											task.delay(2.05, function()
												-- upvalues: (copy) v_u_512
												for _, v514 in v_u_512:GetDescendants() do
													if v514:IsA("ParticleEmitter") then
														v514.Enabled = false
													end
												end
												v_u_512.Anchored = true
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
									local v515 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v515 then
										v515 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v515 then
										local v516 = require(v515)
										if v516["Skill 3"] then
											local v517 = v516["Skill 3"]
											local v518 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["Duration"] = p_u_296.Duration or 6
											}
											v517(v518)
										end
									end
									return
								elseif v_u_301 == "StrongestInHistory" then
									local v519 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v519 then
										v519 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v519 then
										local v_u_520 = require(v519)
										if v_u_520["Skill 3"] then
											local v521 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["ChargeTime"] = 2.5
											}
											v_u_520["Skill 3"](v521)
										end
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_520, (ref) v_u_304
											if v_u_305 and v_u_305.Parent then
												local v522 = v_u_305.Position + v_u_305.CFrame.LookVector * 85
												if v_u_520["Skill 3"] then
													local v523 = v_u_520["Skill 3"]
													local v524 = {
														["Caster"] = {
															["Character"] = v_u_304
														},
														["Phase"] = "Explosion",
														["Position"] = v522,
														["CFrame"] = CFrame.new(v522),
														["DOTDuration"] = 3.5
													}
													v523(v524)
												end
											end
										end)
									end
									return
								elseif v_u_301 == "Gojo" then
									local v525 = v_u_302.C:FindFirstChild("DamageVFX")
									if v525 then
										local v526 = v525:Clone()
										v526.CFrame = v_u_305.CFrame
										v526.Anchored = false
										v526.CanCollide = false
										v526.Transparency = 1
										v526.Massless = true
										v526.Parent = workspace
										local v527 = Instance.new("WeldConstraint")
										v527.Part0 = v526
										v527.Part1 = v_u_305
										v527.Parent = v526
										for _, v528 in v526:GetDescendants() do
											if v528:IsA("ParticleEmitter") then
												v528:Emit(v528:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_297:AddItem(v526, 3)
									end
									return
								elseif v_u_301 == "Jinwoo" then
									local v529 = v_u_302.C
									if v529 then
										local v530 = v529:FindFirstChild("EnergySlashes")
										local v531 = v529:FindFirstChild("ShadowVFX")
										if v530 then
											local v_u_532 = v530:Clone()
											v_u_532.CFrame = v_u_305.CFrame * CFrame.new(0, 3.9, 0)
											v_u_532.Anchored = false
											v_u_532.CanCollide = false
											v_u_532.Transparency = 1
											v_u_532.CastShadow = false
											v_u_532.CanQuery = false
											v_u_532.Massless = true
											v_u_532.Parent = workspace
											v_u_297:AddItem(v_u_532, 3.65)
											local v533 = Instance.new("WeldConstraint")
											v533.Part0 = v_u_305
											v533.Part1 = v_u_532
											v533.Parent = v_u_532
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_532
												if v_u_532 and v_u_532.Parent then
													for _, v534 in v_u_532:GetDescendants() do
														if v534:IsA("ParticleEmitter") then
															v534:Emit(v534:GetAttribute("EmitCount") or v534.Rate)
															v534.Enabled = false
														end
													end
												end
											end)
										end
										if v531 then
											local v_u_535 = v531:Clone()
											v_u_535.CFrame = v_u_305.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_535.Anchored = false
											v_u_535.CanCollide = false
											v_u_535.Transparency = 1
											v_u_535.CastShadow = false
											v_u_535.CanQuery = false
											v_u_535.Massless = true
											v_u_535.Parent = workspace
											v_u_297:AddItem(v_u_535, 2.65)
											local v536 = Instance.new("WeldConstraint")
											v536.Part0 = v_u_305
											v536.Part1 = v_u_535
											v536.Parent = v_u_535
											for _, v_u_537 in v_u_535:GetDescendants() do
												if v_u_537:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_537
														local v538 = v_u_537:GetAttribute("EmitDelay") or 0
														if v538 > 0 then
															task.wait(v538)
														end
														v_u_537:Emit(v_u_537:GetAttribute("EmitCount") or v_u_537.Rate)
													end)
												end
											end
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_535
												if v_u_535 and v_u_535.Parent then
													for _, v539 in v_u_535:GetDescendants() do
														if v539:IsA("ParticleEmitter") then
															v539.Enabled = false
														end
													end
												end
											end)
										end
									end
								elseif v_u_301 == "Ragna" then
									local v540 = v_u_302.C
									if v540 then
										local v_u_541 = v540:FindFirstChild("Sword")
										local v_u_542 = v540:FindFirstChild("StartVFX")
										local v_u_543 = v540:FindFirstChild("ExpVFX")
										if v_u_541 then
											local v_u_544 = {}
											local v_u_545 = {}
											for _ = 1, 6 do
												local v546 = 4 + math.random() * 4
												local v547 = (math.random() - 0.5) * 2 * 6
												local v548 = -(3 + math.random() * 3)
												local v549 = {
													["offset"] = Vector3.new(v547, v546, v548)
												}
												table.insert(v_u_544, v549)
											end
											local v_u_550 = 0
											task.spawn(function()
												-- upvalues: (ref) v_u_550, (ref) v_u_305, (copy) v_u_544, (copy) v_u_541, (ref) v_u_297, (copy) v_u_542, (copy) v_u_545
												while v_u_550 < 6 and (v_u_305 and v_u_305.Parent) do
													local v551 = 6 - v_u_550
													local v552 = math.min(2, v551)
													for v553 = 1, v552 do
														local v554 = v_u_544[v_u_550 + v553]
														local v555 = v_u_305.CFrame
														local v556 = v555:VectorToWorldSpace(v554.offset)
														local v557 = v555.Position + v556
														local v558 = v_u_541:Clone()
														v558.CFrame = CFrame.new(v557) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v558.Anchored = true
														v558.CanCollide = false
														v558.CanQuery = false
														v558.Transparency = 0
														v558.Parent = workspace
														v_u_297:AddItem(v558, 3)
														if v_u_542 then
															local v559 = v_u_542:Clone()
															v559.CFrame = v558.CFrame
															v559.Anchored = true
															v559.CanCollide = false
															v559.Transparency = 1
															v559.Parent = workspace
															v_u_297:AddItem(v559, 1)
															for _, v560 in v559:GetDescendants() do
																if v560:IsA("ParticleEmitter") then
																	v560:Emit(v560:GetAttribute("EmitCount") or 20)
																end
															end
														end
														local v561 = v_u_545
														table.insert(v561, {
															["sword"] = v558,
															["spawnData"] = v554
														})
													end
													v_u_550 = v_u_550 + v552
													task.wait(0.25)
												end
											end)
											local v562 = game:GetService("RunService")
											local v_u_563 = nil
											v_u_563 = v562.Heartbeat:Connect(function()
												-- upvalues: (ref) v_u_305, (ref) v_u_563, (copy) v_u_545
												if v_u_305 and v_u_305.Parent then
													local v564 = (1 / 0)
													local v565 = nil
													for _, v566 in ipairs(game.Players:GetPlayers()) do
														if v566.Character and v566.Character:FindFirstChild("HumanoidRootPart") then
															local v567 = v566.Character.HumanoidRootPart
															local v568 = (v567.Position - v_u_305.Position).Magnitude
															if v568 < v564 and v568 < 150 then
																v565 = v567.Position
																v564 = v568
															end
														end
													end
													for _, v569 in ipairs(v_u_545) do
														local v570 = v569.sword
														if v570 and (v570.Parent and not v569.launched) then
															local v571 = v570.Position
															local v572
															if v565 then
																local v573 = v565 - v571
																if v573.Magnitude > 0.1 then
																	local v574 = v573.Unit
																	v572 = CFrame.lookAt(v571, v571 + v574) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793)
																else
																	v572 = CFrame.new(v571) * CFrame.Angles(1.5707963267948966, 0, 0)
																end
															else
																v572 = CFrame.new(v571) * v_u_305.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v570.CFrame = v570.CFrame:Lerp(v572, 0.12)
														end
													end
												elseif v_u_563 then
													v_u_563:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_563, (ref) v_u_305, (copy) v_u_545, (copy) v_u_543, (ref) v_u_297
												if v_u_563 then
													v_u_563:Disconnect()
												end
												if v_u_305 and v_u_305.Parent then
													local v575 = v_u_305.Position + v_u_305.CFrame.LookVector * 30
													local v576 = (1 / 0)
													for _, v577 in ipairs(game.Players:GetPlayers()) do
														if v577.Character and v577.Character:FindFirstChild("HumanoidRootPart") then
															local v578 = v577.Character.HumanoidRootPart
															local v579 = (v578.Position - v_u_305.Position).Magnitude
															if v579 < v576 and v579 < 150 then
																v575 = v578.Position
																v576 = v579
															end
														end
													end
													local v_u_580 = CFrame.new(v575)
													for v581, v_u_582 in ipairs(v_u_545) do
														task.delay((v581 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_582, (copy) v_u_580, (ref) v_u_543, (ref) v_u_297
															local v_u_583 = v_u_582.sword
															if v_u_583 and v_u_583.Parent then
																v_u_582.launched = true
																local v_u_584 = v_u_583.Position
																local v585 = v_u_580.Position
																local v586 = math.random(-8, 8)
																local v587 = math.random
																local v_u_588 = v585 + Vector3.new(v586, 0, v587(-8, 8))
																local v589 = (v_u_584 + v_u_588) / 2
																local v590 = math.random(-60, 60)
																local v591 = math.rad(v590)
																local v592 = 12 + math.random() * 5
																local v593 = math.sin(v591) * 5
																local v594 = math.cos(v591) * 5
																local v_u_595 = v589 + Vector3.new(v593, v592, v594)
																local v_u_596 = tick()
																task.spawn(function()
																	-- upvalues: (copy) v_u_596, (copy) v_u_584, (copy) v_u_595, (copy) v_u_588, (copy) v_u_583, (ref) v_u_543, (ref) v_u_297
																	while tick() - v_u_596 < 0.4 do
																		local v597 = (tick() - v_u_596) / 0.4
																		local v598 = v_u_584
																		local v599 = v_u_595
																		local v600 = v_u_588
																		local v601 = 1 - v597
																		local v602 = v601 * v601 * v598 + 2 * v601 * v597 * v599 + v597 * v597 * v600
																		local v603 = v597 + 0.05
																		local v604 = math.min(v603, 1)
																		local v605 = v_u_584
																		local v606 = v_u_595
																		local v607 = v_u_588
																		local v608 = 1 - v604
																		local v609 = v608 * v608 * v605 + 2 * v608 * v604 * v606 + v604 * v604 * v607 - v602
																		if v_u_583 and (v_u_583.Parent and v609.Magnitude > 0.01) then
																			v_u_583.CFrame = CFrame.lookAt(v602, v602 + v609.Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
																		end
																		task.wait()
																	end
																	if v_u_543 and (v_u_583 and v_u_583.Parent) then
																		local v610 = v_u_543:Clone()
																		v610.CFrame = CFrame.new(v_u_588)
																		v610.Anchored = true
																		v610.CanCollide = false
																		v610.Transparency = 1
																		v610.Parent = workspace
																		v_u_297:AddItem(v610, 1.5)
																		for _, v611 in v610:GetDescendants() do
																			if v611:IsA("ParticleEmitter") then
																				v611:Emit(v611:GetAttribute("EmitCount") or 30)
																			end
																		end
																	end
																	if v_u_583 and v_u_583.Parent then
																		v_u_583:Destroy()
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
									local v_u_612 = v_u_302.C
									if v_u_612 then
										local v_u_613 = {}
										local function v_u_619(p614, p615)
											-- upvalues: (ref) v_u_305, (ref) v_u_297
											if not p614 then
												return nil
											end
											local v616 = p614:Clone()
											v616.CFrame = v_u_305.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v616.Anchored = false
											v616.CanCollide = false
											v616.Transparency = 1
											v616.CastShadow = false
											v616.CanQuery = false
											v616.Massless = true
											v616.Parent = workspace
											v_u_297:AddItem(v616, p615)
											local v617 = Instance.new("WeldConstraint")
											v617.Part0 = v_u_305
											v617.Part1 = v616
											v617.Parent = v616
											for _, v618 in v616:GetDescendants() do
												if v618:IsA("ParticleEmitter") or (v618:IsA("Beam") or v618:IsA("Trail")) then
													v618.Enabled = true
												end
											end
											return v616
										end
										local v620 = v_u_619(v_u_612:FindFirstChild("ChargeVFX"), 4)
										if v620 then
											table.insert(v_u_613, v620)
										end
										local v621 = v_u_619(v_u_612:FindFirstChild("AuraVFX1"), 4)
										if v621 then
											table.insert(v_u_613, v621)
										end
										task.delay(0.25, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_619, (copy) v_u_612, (copy) v_u_613
											if v_u_305 and v_u_305.Parent then
												local v622 = v_u_619(v_u_612:FindFirstChild("AuraVFX2"), 3.75)
												if v622 then
													local v623 = v_u_613
													table.insert(v623, v622)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_619, (copy) v_u_612, (copy) v_u_613
											if v_u_305 and v_u_305.Parent then
												local v624 = v_u_619(v_u_612:FindFirstChild("AuraVFX3"), 3.5)
												if v624 then
													local v625 = v_u_613
													table.insert(v625, v624)
												end
											end
										end)
										task.delay(3, function()
											-- upvalues: (copy) v_u_613
											for _, v626 in pairs(v_u_613) do
												if v626 and v626.Parent then
													for _, v627 in v626:GetDescendants() do
														if v627:IsA("ParticleEmitter") or (v627:IsA("Beam") or v627:IsA("Trail")) then
															v627.Enabled = false
														end
													end
												end
											end
										end)
									end
								elseif v_u_301 == "Rimuru" then
									return
								else
									local v628 = v_u_302.C:FindFirstChild("FirstEffects")
									if v628 then
										local v_u_629 = v628:Clone()
										for _, v630 in v_u_629:GetDescendants() do
											if v630:IsA("BasePart") then
												v630.Anchored = true
												v630.CanCollide = false
												v630.CanQuery = false
												v630.CanTouch = false
												v630.CastShadow = false
												v630.Transparency = 1
											end
										end
										v_u_629:PivotTo(v_u_305.CFrame * CFrame.new(0, -2, 0))
										v_u_629.Parent = workspace
										v_u_297:AddItem(v_u_629, 6)
										task.delay(4.85, function()
											-- upvalues: (copy) v_u_629
											for _, v631 in v_u_629:GetDescendants() do
												if v631:IsA("ParticleEmitter") then
													v631.Enabled = false
												end
											end
										end)
									end
									task.wait(3.85)
									if v_u_305 and v_u_305.Parent then
										local v_u_632 = v_u_305.CFrame
										local v633 = v_u_302.C:FindFirstChild("HorizontalBeam")
										if v633 then
											local v634 = v633:Clone()
											for _, v635 in v634:GetDescendants() do
												if v635:IsA("BasePart") then
													v635.Anchored = true
													v635.CanCollide = false
													v635.CanQuery = false
													v635.CanTouch = false
													v635.CastShadow = false
													v635.Massless = true
													v635.Transparency = 1
												end
												if v635:IsA("Beam") then
													v635.Enabled = false
												end
											end
											v634:PivotTo(v_u_632 * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0))
											v634.Parent = workspace
											v_u_297:AddItem(v634, 6)
											local v636 = {
												["BigBeam1"] = 0,
												["BigBeam2"] = 0.25,
												["BigBeams3"] = 0.5
											}
											local v637 = {
												["BigBeam1"] = 0.36,
												["BigBeam2"] = 0.61,
												["BigBeams3"] = 0.76
											}
											for _, v_u_638 in v634:GetChildren() do
												if v_u_638:IsA("Model") then
													local v_u_639 = v_u_638:FindFirstChild("Beam")
													local v640 = v636[v_u_638.Name] or 0
													local v641 = v637[v_u_638.Name] or 2
													task.delay(v640, function()
														-- upvalues: (copy) v_u_639, (ref) v_u_317, (copy) v_u_638
														if v_u_639 then
															v_u_317(v_u_639, 0.3)
														end
														for _, v642 in v_u_638:GetDescendants() do
															if v642:IsA("ParticleEmitter") and not (v_u_639 and v642:IsDescendantOf(v_u_639)) then
																v642:Emit(v642:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v641, function()
														-- upvalues: (copy) v_u_639, (ref) v_u_323
														if v_u_639 then
															v_u_323(v_u_639, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_302, (copy) v_u_632, (ref) v_u_297, (ref) v_u_323
											if v_u_305 and v_u_305.Parent then
												local v643 = v_u_302.C:FindFirstChild("Explosion")
												if v643 then
													local v_u_644 = v643:Clone()
													for _, v645 in v_u_644:GetDescendants() do
														if v645:IsA("BasePart") then
															v645.Anchored = true
															v645.CanCollide = false
															v645.CanQuery = false
															v645.CanTouch = false
															v645.CastShadow = false
															v645.Transparency = 1
														end
													end
													v_u_644:PivotTo(v_u_632 * CFrame.new(0, 8, -75) * CFrame.Angles(0, 0, 1.5707963267948966))
													v_u_644.Parent = workspace
													v_u_297:AddItem(v_u_644, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_323, (copy) v_u_644
														v_u_323(v_u_644, 0.5)
														for _, v646 in v_u_644:GetDescendants() do
															if v646:IsA("ParticleEmitter") then
																v646.Enabled = false
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
									local v647 = v_u_302:FindFirstChild("C")
									if v647 then
										local v648 = v647:FindFirstChild("BarrageVFX")
										if v648 then
											local v_u_649 = v648:Clone()
											v_u_649.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_649.Anchored = false
											v_u_649.CanCollide = false
											v_u_649.CanQuery = false
											v_u_649.CanTouch = false
											v_u_649.Transparency = 1
											v_u_649.CastShadow = false
											v_u_649.Parent = workspace
											local v650 = Instance.new("WeldConstraint")
											v650.Part0 = v_u_649
											v650.Part1 = v_u_305
											v650.Parent = v_u_649
											for _, v651 in v_u_649:GetDescendants() do
												if v651:IsA("ParticleEmitter") then
													v651.Enabled = true
												end
											end
											task.delay(3, function()
												-- upvalues: (copy) v_u_649
												if v_u_649 and v_u_649.Parent then
													for _, v652 in v_u_649:GetDescendants() do
														if v652:IsA("ParticleEmitter") then
															v652.Enabled = false
														end
													end
												end
											end)
											v_u_297:AddItem(v_u_649, 4)
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
									local v_u_653 = v_u_302:FindFirstChild("C")
									if v_u_653 then
										local v654 = v_u_653:FindFirstChild("AuraVFX3")
										if v654 then
											local v_u_655 = v654:Clone()
											v_u_655.CFrame = v_u_305.CFrame
											v_u_655.Anchored = false
											v_u_655.CanCollide = false
											v_u_655.Transparency = 1
											v_u_655.Massless = true
											v_u_655.Parent = workspace
											local v656 = Instance.new("WeldConstraint")
											v656.Part0 = v_u_305
											v656.Part1 = v_u_655
											v656.Parent = v_u_655
											for _, v657 in v_u_655:GetDescendants() do
												if v657:IsA("ParticleEmitter") then
													v657.Enabled = true
												end
											end
											task.delay(0.8, function()
												-- upvalues: (copy) v_u_655
												if v_u_655 and v_u_655.Parent then
													for _, v658 in v_u_655:GetDescendants() do
														if v658:IsA("ParticleEmitter") then
															v658.Enabled = false
														end
													end
												end
											end)
											v_u_297:AddItem(v_u_655, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_653, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v659 = v_u_653:FindFirstChild("BlackFlashVFX3")
												if v659 then
													local v660 = v659:Clone()
													v660.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -10)
													v660.Anchored = true
													v660.CanCollide = false
													v660.Transparency = 1
													v660.Parent = workspace
													for _, v661 in v660:GetDescendants() do
														if v661:IsA("ParticleEmitter") then
															v661:Emit(v661:GetAttribute("EmitCount") or v661.Rate)
														end
													end
													v_u_297:AddItem(v660, 3)
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
							local v662 = v_u_68.Alucard
							if v662 and v662["Skill 3"] then
								v662["Skill 3"]({
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
							local v663 = v_u_68.Ichigo
							if v663 and v663["Skill 3"] then
								v663["Skill 3"]({
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
							local v664 = v_u_68.Rimuru
							if v664 and v664["Skill 3"] then
								v664["Skill 3"]({
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
							local v665 = v_u_68.Madoka
							if v665 and v665["Skill 3"] then
								v665["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_304
									},
									["DamageDelay"] = 1.03,
									["Duration"] = 3.97
								})
							end
						end
						if v_u_301 == "Gilgamesh" then
							local v666 = v_u_68.Gilgamesh
							if v666 and v666["Skill 3"] then
								v666["Skill 3"]({
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
									local v667 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v667 then
										v667 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v667 then
										local v668 = require(v667)
										if v668["Skill 4"] then
											local v669 = {
												["Caster"] = {
													["Character"] = v_u_304
												}
											}
											v668["Skill 4"](v669)
										end
									end
									return
								elseif v_u_301 == "StrongestInHistory" then
									local v670 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v670 then
										v670 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v670 then
										local v671 = require(v670)
										if v671["Skill 4"] then
											local v672 = v671["Skill 4"]
											local v673 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["CutsceneDuration"] = 6.5,
												["DamageDelay"] = 5,
												["CharAnimationId"] = "rbxassetid://125013796988038"
											}
											local v674 = v_u_305
											if v674 then
												v674 = v_u_305.CFrame
											end
											v673.CFrame = v674
											v672(v673)
										end
									end
									return
								elseif v_u_301 == "Gojo" then
									local v_u_675 = v_u_302.V
									if v_u_675 then
										local v_u_676 = Instance.new("Attachment")
										v_u_676.Name = "BlueAtt"
										v_u_676.Position = Vector3.new(7, 2, 5)
										v_u_676.Parent = v_u_305
										local v_u_677 = Instance.new("Attachment")
										v_u_677.Name = "RedAtt"
										v_u_677.Position = Vector3.new(-7, 2, 5)
										v_u_677.Parent = v_u_305
										local v_u_678 = nil
										local v_u_679 = nil
										local function v_u_688(p680, p681)
											-- upvalues: (copy) v_u_675, (ref) v_u_305
											local v682 = v_u_675:FindFirstChild(p680)
											if not v682 then
												return nil
											end
											local v683 = v682:Clone()
											v683.CFrame = v_u_305.CFrame * CFrame.new(p681.Position)
											v683.Anchored = true
											v683.CanCollide = false
											v683.Massless = true
											v683.Transparency = 1
											v683.Parent = workspace
											local v684 = Instance.new("Attachment")
											v684.Parent = v683
											local v685 = Instance.new("AlignPosition")
											v685.Attachment0 = v684
											v685.Attachment1 = p681
											v685.RigidityEnabled = false
											v685.Responsiveness = 100
											v685.MaxForce = (1 / 0)
											v685.Parent = v683
											local v686 = Instance.new("AlignOrientation")
											v686.Attachment0 = v684
											v686.Attachment1 = p681
											v686.RigidityEnabled = false
											v686.Responsiveness = 100
											v686.MaxTorque = (1 / 0)
											v686.Parent = v683
											v683.Anchored = false
											for _, v687 in v683:GetDescendants() do
												if v687:IsA("ParticleEmitter") then
													v687.Enabled = true
												elseif v687:IsA("Beam") or v687:IsA("Trail") then
													v687.Enabled = true
												end
											end
											return v683
										end
										local function v_u_692(p689, p690)
											if p689 and p689.Parent then
												for _, v_u_691 in p689:GetDescendants() do
													if v_u_691:IsA("ParticleEmitter") then
														v_u_691.Enabled = false
														if p690 then
															pcall(function()
																-- upvalues: (copy) v_u_691
																v_u_691:Clear()
															end)
														end
													elseif v_u_691:IsA("Beam") or v_u_691:IsA("Trail") then
														v_u_691.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_678, (copy) v_u_688, (copy) v_u_676, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												v_u_678 = v_u_688("Blue", v_u_676)
												if v_u_678 then
													v_u_297:AddItem(v_u_678, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_679, (copy) v_u_688, (copy) v_u_677, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												v_u_679 = v_u_688("Red", v_u_677)
												if v_u_679 then
													v_u_297:AddItem(v_u_679, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_305, (ref) v_u_298, (copy) v_u_676, (copy) v_u_677, (copy) v_u_675, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v693 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_298:Create(v_u_676, v693, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_298:Create(v_u_677, v693, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_305, (ref) v_u_675, (ref) v_u_297
													if v_u_305 and v_u_305.Parent then
														local v694 = v_u_675:FindFirstChild("StarEff")
														if v694 then
															local v695 = v694:Clone()
															v695.CFrame = v_u_305.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v695.Anchored = true
															v695.CanCollide = false
															v695.Transparency = 1
															v695.Parent = workspace
															for _, v696 in v695:GetDescendants() do
																if v696:IsA("ParticleEmitter") then
																	v696:Emit(v696:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_297:AddItem(v695, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_692, (ref) v_u_678, (ref) v_u_679, (copy) v_u_676, (copy) v_u_677, (copy) v_u_675, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												v_u_692(v_u_678, true)
												v_u_692(v_u_679, true)
												if v_u_676 and v_u_676.Parent then
													v_u_676:Destroy()
												end
												if v_u_677 and v_u_677.Parent then
													v_u_677:Destroy()
												end
												local v697 = v_u_675:FindFirstChild("MiniExplosionVFX")
												if v697 then
													local v698 = v697:Clone()
													v698.CFrame = v_u_305.CFrame * CFrame.new(0, 0, -2)
													v698.Anchored = true
													v698.CanCollide = false
													v698.Transparency = 1
													v698.Parent = workspace
													for _, v699 in v698:GetDescendants() do
														if v699:IsA("ParticleEmitter") then
															v699:Emit(v699:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_297:AddItem(v698, 3)
												end
												local v_u_700 = v_u_305.Position + v_u_305.CFrame.LookVector * 6
												local v_u_701 = v_u_305.CFrame.LookVector
												local v702 = v_u_675:FindFirstChild("Purple")
												if v702 then
													local v_u_703 = v702:Clone()
													v_u_703.Anchored = true
													v_u_703.CanCollide = false
													v_u_703.Parent = workspace
													v_u_297:AddItem(v_u_703, 3)
													for _, v704 in v_u_703:GetDescendants() do
														if v704:IsA("ParticleEmitter") then
															v704.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_700, (copy) v_u_703, (copy) v_u_701
														local v705 = v_u_700
														local v706 = 0
														while v706 < 200 and (v_u_703 and v_u_703.Parent) do
															v705 = v705 + v_u_701 * 3.9899999999999998
															v706 = v706 + 3.9899999999999998
															v_u_703.CFrame = CFrame.lookAt(v705, v705 + v_u_701)
															task.wait(0.03)
														end
														for _, v707 in v_u_703:GetDescendants() do
															if v707:IsA("ParticleEmitter") then
																v707.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_301 == "Sukuna" then
									local v_u_708 = v_u_302.V
									if v_u_708 then
										local v709 = (p_u_296.NPCModel or "NPC") .. "_SukunaV"
										local v710 = tick()
										if not v_u_295[v709] or v710 - v_u_295[v709] > 0.5 then
											v_u_295[v709] = v710
											v_u_37:PlayAt("SukunaV_Part1", p_u_296.Position)
										end
										local v711 = v_u_708:FindFirstChild("GroundVFX")
										if v711 then
											local v_u_712 = v711:Clone()
											v_u_712.CFrame = v_u_305.CFrame * CFrame.new(0, -2, 0)
											v_u_712.Anchored = false
											v_u_712.Parent = workspace
											v_u_297:AddItem(v_u_712, 3)
											local v713 = Instance.new("WeldConstraint")
											v713.Part0 = v_u_305
											v713.Part1 = v_u_712
											v713.Parent = v_u_712
											for _, v714 in v_u_712:GetDescendants() do
												if v714:IsA("ParticleEmitter") then
													v714.Enabled = true
													v714:Emit(v714:GetAttribute("EmitCount") or 40)
												elseif v714:IsA("Beam") then
													v714.Enabled = true
												end
											end
											task.delay(2.35, function()
												-- upvalues: (copy) v_u_712
												if v_u_712 and v_u_712.Parent then
													for _, v715 in v_u_712:GetDescendants() do
														if v715:IsA("ParticleEmitter") then
															v715.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_708, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v716 = v_u_708:FindFirstChild("MiniExplosionVFX")
												if v716 then
													local v717 = v716:Clone()
													v717.CFrame = v_u_305.CFrame * CFrame.new(1, 0, 0)
													v717.Anchored = false
													v717.Parent = workspace
													v_u_297:AddItem(v717, 2)
													local v718 = Instance.new("WeldConstraint")
													v718.Part0 = v_u_305
													v718.Part1 = v717
													v718.Parent = v717
													for _, v719 in v717:GetDescendants() do
														if v719:IsA("ParticleEmitter") then
															v719:Emit(v719:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v720 = v_u_708:FindFirstChild("ArrowVFX")
												if v720 then
													local v_u_721 = v720:Clone()
													v_u_721.CFrame = v_u_305.CFrame * CFrame.new(1, 0, 0)
													v_u_721.Anchored = false
													v_u_721.Parent = workspace
													v_u_297:AddItem(v_u_721, 2)
													local v722 = Instance.new("WeldConstraint")
													v722.Part0 = v_u_305
													v722.Part1 = v_u_721
													v722.Parent = v_u_721
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_721
														if v_u_721 and v_u_721.Parent then
															for _, v723 in v_u_721:GetDescendants() do
																if v723:IsA("ParticleEmitter") or v723:IsA("Beam") then
																	v723.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_305, (ref) p_u_296, (ref) v_u_295, (ref) v_u_37, (copy) v_u_708, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v724 = (p_u_296.NPCModel or "NPC") .. "_SukunaV2"
												local v725 = tick()
												if not v_u_295[v724] or v725 - v_u_295[v724] > 0.5 then
													v_u_295[v724] = v725
													v_u_37:PlayAt("SukunaV_Part2", v_u_305.Position)
												end
												local v726 = v_u_305.CFrame.LookVector
												local v727 = v_u_305.Position + v726 * 85
												local v728 = v_u_708:FindFirstChild("ExplosionVFX")
												if v728 then
													local v_u_729 = v728:Clone()
													if v_u_729:IsA("Model") then
														v_u_729:PivotTo(CFrame.new(v727) * CFrame.new(0, 73, 0))
													else
														v_u_729.CFrame = CFrame.new(v727) * CFrame.new(0, 73, 0)
													end
													v_u_729.Parent = workspace
													v_u_297:AddItem(v_u_729, 4)
													for _, v730 in v_u_729:GetDescendants() do
														if v730:IsA("ParticleEmitter") then
															v730.Enabled = true
															v730:Emit(v730:GetAttribute("EmitCount") or 30)
														elseif v730:IsA("Beam") or v730:IsA("Trail") then
															v730.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_729
														if v_u_729 and v_u_729.Parent then
															for _, v731 in v_u_729:GetDescendants() do
																if v731:IsA("ParticleEmitter") or (v731:IsA("Beam") or v731:IsA("Trail")) then
																	v731.Enabled = false
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
									local v_u_732 = v_u_302.V
									if v_u_732 then
										local v733 = v_u_732:FindFirstChild("FirstEffects")
										if v733 then
											local v_u_734 = v733:Clone()
											v_u_734.CFrame = v_u_305.CFrame * CFrame.new(0, -2.5, 0)
											v_u_734.Anchored = false
											v_u_734.CanCollide = false
											v_u_734.Transparency = 1
											v_u_734.CastShadow = false
											v_u_734.CanQuery = false
											v_u_734.Massless = true
											v_u_734.Parent = workspace
											v_u_297:AddItem(v_u_734, 6)
											local v735 = Instance.new("WeldConstraint")
											v735.Part0 = v_u_305
											v735.Part1 = v_u_734
											v735.Parent = v_u_734
											for _, v736 in v_u_734:GetDescendants() do
												if v736:IsA("ParticleEmitter") then
													v736.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_734
												if v_u_734 and v_u_734.Parent then
													for _, v737 in v_u_734:GetDescendants() do
														if v737:IsA("ParticleEmitter") then
															v737.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_305, (copy) v_u_732, (ref) v_u_297
											if v_u_305 and v_u_305.Parent then
												local v738 = v_u_732:FindFirstChild("UltVFX")
												if v738 then
													local v_u_739 = v738:Clone()
													v_u_739:PivotTo(v_u_305.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v740 in v_u_739:GetDescendants() do
														if v740:IsA("BasePart") then
															v740.Anchored = true
															v740.CanCollide = false
															v740.CastShadow = false
															v740.CanQuery = false
														end
													end
													v_u_739.Parent = workspace
													v_u_297:AddItem(v_u_739, 4.5)
													for _, v741 in v_u_739:GetDescendants() do
														if v741:IsA("ParticleEmitter") then
															v741.Enabled = true
														elseif v741:IsA("Beam") then
															v741.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_739
														if v_u_739 and v_u_739.Parent then
															for _, v742 in v_u_739:GetDescendants() do
																if v742:IsA("ParticleEmitter") then
																	v742.Enabled = false
																end
															end
															for _, v_u_743 in v_u_739:GetDescendants() do
																if v_u_743:IsA("Beam") then
																	local v_u_744 = v_u_743.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_744, (copy) v_u_743
																		local v745 = tick()
																		while tick() - v745 < 0.5 do
																			local v746 = (tick() - v745) / 0.5
																			local v747 = {}
																			for _, v748 in ipairs(v_u_744) do
																				local v749 = v748.Value + (1 - v748.Value) * v746
																				local v750 = NumberSequenceKeypoint.new
																				local v751 = v748.Time
																				table.insert(v747, v750(v751, v749))
																			end
																			v_u_743.Transparency = NumberSequence.new(v747)
																			task.wait()
																		end
																		v_u_743.Transparency = NumberSequence.new(1)
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
										local v752 = v_u_68.Ichigo
										if v752 and v752["Skill 4"] then
											local v753 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["CutsceneDuration"] = 8.33,
												["CharAnimationId"] = "rbxassetid://98446587158184",
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v752["Skill 4"](v753)
											return
										end
									elseif v_u_301 == "Alucard" then
										local v754 = v_u_68.Alucard
										if v754 and v754["Skill 4"] then
											local v755 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["AbilityConfig"] = {},
												["CutsceneDuration"] = 5.5,
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v754["Skill 4"](v755)
											return
										end
									elseif v_u_301 == "Rimuru" then
										local v756 = v_u_68.Rimuru
										if v756 and v756["Skill 4"] then
											local v757 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v756["Skill 4"](v757)
											return
										end
									elseif v_u_301 == "Madoka" then
										local v758 = v_u_68.Madoka
										if v758 and v758["Skill 4"] then
											local v759 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["DamageDelay"] = 3.13,
												["Duration"] = 8.63
											}
											v758["Skill 4"](v759)
											return
										end
									elseif v_u_301 == "Gilgamesh" then
										local v760 = v_u_68.Gilgamesh
										if v760 and v760["Skill 4"] then
											local v761 = {
												["Caster"] = {
													["Character"] = v_u_304
												},
												["AbilityConfig"] = {}
											}
											v760["Skill 4"](v761)
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
									local v762 = v_u_68.Rimuru
									if v762 and v762["Skill 5"] then
										local v763 = {
											["Caster"] = {
												["Character"] = v_u_304
											},
											["AbilityConfig"] = {},
											["DisableCutscene"] = true
										}
										v762["Skill 5"](v763)
									end
								end
								if v_u_301 == "Gilgamesh" then
									local v764 = v_u_68.Gilgamesh
									if v764 and v764["Skill 5"] then
										local v765 = {
											["Caster"] = {
												["Character"] = v_u_304
											},
											["AbilityConfig"] = {}
										}
										v764["Skill 5"](v765)
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
	local v_u_767 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p768, p_u_769)
		-- upvalues: (copy) v_u_767, (copy) v_u_766, (copy) v_u_44, (copy) v_u_37, (copy) v_u_288, (copy) v_u_7, (copy) v_u_294, (copy) v_u_4
		if p768 == "SpawnVFX" then
			if p_u_769.IsNPC and (p_u_769.VFXName == "Z" or (p_u_769.VFXName == "X" or (p_u_769.VFXName == "C" or (p_u_769.VFXName == "V" or p_u_769.VFXName == "F")))) then
				local v770 = (p_u_769.NPCModel or "NPC") .. "_" .. p_u_769.VFXName
				local v771 = tick()
				if v_u_767[v770] and v771 - v_u_767[v770] < 1 then
					return
				end
				v_u_767[v770] = v771
				task.spawn(function()
					-- upvalues: (ref) v_u_766, (copy) p_u_769
					v_u_766(p_u_769)
				end)
				local v772 = p_u_769.MovesetType or "Saber"
				if p_u_769.VFXName == "Z" then
					if v772 == "Gojo" then
						local v773 = (p_u_769.NPCModel or "unknown") .. "_Z"
						local v774 = tick()
						local v775
						if v_u_44[v773] and v774 - v_u_44[v773] < 1.5 then
							v775 = false
						else
							v_u_44[v773] = v774
							v775 = true
						end
						if v775 then
							v_u_37:PlayAt("GojoZ", p_u_769.Position)
						end
					elseif v772 == "Sukuna" then
						local v776 = (p_u_769.NPCModel or "unknown") .. "_Z"
						local v777 = tick()
						local v778
						if v_u_44[v776] and v777 - v_u_44[v776] < 1.5 then
							v778 = false
						else
							v_u_44[v776] = v777
							v778 = true
						end
						if v778 then
							v_u_37:PlayAt("SukunaZ", p_u_769.Position)
						end
					elseif v772 == "Jinwoo" then
						local v779 = (p_u_769.NPCModel or "unknown") .. "_Z"
						local v780 = tick()
						local v781
						if v_u_44[v779] and v780 - v_u_44[v779] < 1.5 then
							v781 = false
						else
							v_u_44[v779] = v780
							v781 = true
						end
						if v781 then
							v_u_37:PlayAt("JinwooZ", p_u_769.Position)
						end
					elseif v772 == "Ragna" then
						local v782 = (p_u_769.NPCModel or "unknown") .. "_Z"
						local v783 = tick()
						local v784
						if v_u_44[v782] and v783 - v_u_44[v782] < 1.5 then
							v784 = false
						else
							v_u_44[v782] = v783
							v784 = true
						end
						if v784 then
							v_u_37:PlayAt("RagnaZ", p_u_769.Position)
						end
					elseif v772 == "Aizen" then
						local v785 = (p_u_769.NPCModel or "unknown") .. "_Z"
						local v786 = tick()
						local v787
						if v_u_44[v785] and v786 - v_u_44[v785] < 1.5 then
							v787 = false
						else
							v_u_44[v785] = v786
							v787 = true
						end
						if v787 then
							v_u_37:PlayAt("AizenZ", p_u_769.Position)
						end
					elseif v772 == "QinShi" then
						local v788 = (p_u_769.NPCModel or "unknown") .. "_Z"
						local v789 = tick()
						local v790
						if v_u_44[v788] and v789 - v_u_44[v788] < 1.5 then
							v790 = false
						else
							v_u_44[v788] = v789
							v790 = true
						end
						if v790 then
							v_u_37:PlayAt("QinShiZ", p_u_769.Position)
						end
					elseif v772 == "Yuji" then
						local v791 = (p_u_769.NPCModel or "unknown") .. "_Z"
						local v792 = tick()
						local v793
						if v_u_44[v791] and v792 - v_u_44[v791] < 1.5 then
							v793 = false
						else
							v_u_44[v791] = v792
							v793 = true
						end
						if v793 then
							v_u_37:PlayAt("YujiZ", p_u_769.Position)
						end
					elseif v772 ~= "Alucard" then
						if v772 == "GojoV2" then
							local v794 = (p_u_769.NPCModel or "unknown") .. "_Z"
							local v795 = tick()
							local v796
							if v_u_44[v794] and v795 - v_u_44[v794] < 1.5 then
								v796 = false
							else
								v_u_44[v794] = v795
								v796 = true
							end
							if v796 then
								v_u_37:PlayAt("GojoV2Z", p_u_769.Position)
							end
						elseif v772 ~= "StrongestInHistory" and (v772 ~= "Rimuru" and v772 ~= "Madoka") then
							local v797 = (p_u_769.NPCModel or "unknown") .. "_Z"
							local v798 = tick()
							local v799
							if v_u_44[v797] and v798 - v_u_44[v797] < 1.5 then
								v799 = false
							else
								v_u_44[v797] = v798
								v799 = true
							end
							if v799 then
								v_u_37:PlayAt("SaberZ", p_u_769.Position)
							end
						end
					end
				elseif p_u_769.VFXName == "X" then
					if v772 == "Gojo" then
						local v800 = (p_u_769.NPCModel or "unknown") .. "_X"
						local v801 = tick()
						local v802
						if v_u_44[v800] and v801 - v_u_44[v800] < 1.5 then
							v802 = false
						else
							v_u_44[v800] = v801
							v802 = true
						end
						if v802 then
							v_u_37:PlayAt("GojoX", p_u_769.Position)
						end
					elseif v772 == "Sukuna" then
						local v803 = (p_u_769.NPCModel or "unknown") .. "_X"
						local v804 = tick()
						local v805
						if v_u_44[v803] and v804 - v_u_44[v803] < 1.5 then
							v805 = false
						else
							v_u_44[v803] = v804
							v805 = true
						end
						if v805 then
							v_u_37:PlayAt("SukunaX", p_u_769.Position)
						end
					elseif v772 == "Jinwoo" then
						local v806 = (p_u_769.NPCModel or "unknown") .. "_X"
						local v807 = tick()
						local v808
						if v_u_44[v806] and v807 - v_u_44[v806] < 1.5 then
							v808 = false
						else
							v_u_44[v806] = v807
							v808 = true
						end
						if v808 then
							v_u_37:PlayAt("JinwooX", p_u_769.Position)
						end
					elseif v772 == "Ragna" then
						local v809 = (p_u_769.NPCModel or "unknown") .. "_X"
						local v810 = tick()
						local v811
						if v_u_44[v809] and v810 - v_u_44[v809] < 1.5 then
							v811 = false
						else
							v_u_44[v809] = v810
							v811 = true
						end
						if v811 then
							v_u_37:PlayAt("RagnaX", p_u_769.Position)
						end
					elseif v772 == "Aizen" then
						local v812 = (p_u_769.NPCModel or "unknown") .. "_X"
						local v813 = tick()
						local v814
						if v_u_44[v812] and v813 - v_u_44[v812] < 1.5 then
							v814 = false
						else
							v_u_44[v812] = v813
							v814 = true
						end
						if v814 then
							v_u_37:PlayAt("AizenX", p_u_769.Position)
						end
					elseif v772 == "QinShi" then
						local v815 = (p_u_769.NPCModel or "unknown") .. "_X"
						local v816 = tick()
						local v817
						if v_u_44[v815] and v816 - v_u_44[v815] < 1.5 then
							v817 = false
						else
							v_u_44[v815] = v816
							v817 = true
						end
						if v817 then
							v_u_37:PlayAt("QinShiX", p_u_769.Position)
						end
					elseif v772 == "Yuji" then
						local v818 = (p_u_769.NPCModel or "unknown") .. "_X"
						local v819 = tick()
						local v820
						if v_u_44[v818] and v819 - v_u_44[v818] < 1.5 then
							v820 = false
						else
							v_u_44[v818] = v819
							v820 = true
						end
						if v820 then
							v_u_37:PlayAt("YujiX", p_u_769.Position)
						end
					elseif v772 ~= "Ichigo" and v772 ~= "Alucard" then
						if v772 == "GojoV2" then
							local v821 = (p_u_769.NPCModel or "unknown") .. "_X"
							local v822 = tick()
							local v823
							if v_u_44[v821] and v822 - v_u_44[v821] < 1.5 then
								v823 = false
							else
								v_u_44[v821] = v822
								v823 = true
							end
							if v823 then
								v_u_37:PlayAt("GojoV2X", p_u_769.Position)
							end
						elseif v772 ~= "StrongestInHistory" and (v772 ~= "Rimuru" and v772 ~= "Madoka") then
							local v824 = (p_u_769.NPCModel or "unknown") .. "_X"
							local v825 = tick()
							local v826
							if v_u_44[v824] and v825 - v_u_44[v824] < 1.5 then
								v826 = false
							else
								v_u_44[v824] = v825
								v826 = true
							end
							if v826 then
								v_u_37:PlayAt("SaberX", p_u_769.Position)
							end
						end
					end
				elseif p_u_769.VFXName == "C" then
					if v772 == "Gojo" then
						local v827 = (p_u_769.NPCModel or "unknown") .. "_C"
						local v828 = tick()
						local v829
						if v_u_44[v827] and v828 - v_u_44[v827] < 1.5 then
							v829 = false
						else
							v_u_44[v827] = v828
							v829 = true
						end
						if v829 then
							v_u_37:PlayAt("GojoC", p_u_769.Position)
							v_u_37:PlayAt("GojoC_Hold", p_u_769.Position)
						end
					elseif v772 == "Jinwoo" then
						local v830 = (p_u_769.NPCModel or "unknown") .. "_C"
						local v831 = tick()
						local v832
						if v_u_44[v830] and v831 - v_u_44[v830] < 1.5 then
							v832 = false
						else
							v_u_44[v830] = v831
							v832 = true
						end
						if v832 then
							v_u_37:PlayAt("JinwooC", p_u_769.Position)
						end
					elseif v772 == "Ragna" then
						local v833 = (p_u_769.NPCModel or "unknown") .. "_C"
						local v834 = tick()
						local v835
						if v_u_44[v833] and v834 - v_u_44[v833] < 1.5 then
							v835 = false
						else
							v_u_44[v833] = v834
							v835 = true
						end
						if v835 then
							v_u_37:PlayAt("RagnaC_Startup", p_u_769.Position)
						end
					elseif v772 == "Aizen" then
						local v836 = (p_u_769.NPCModel or "unknown") .. "_C"
						local v837 = tick()
						local v838
						if v_u_44[v836] and v837 - v_u_44[v836] < 1.5 then
							v838 = false
						else
							v_u_44[v836] = v837
							v838 = true
						end
						if v838 then
							v_u_37:PlayAt("AizenC", p_u_769.Position)
						end
					elseif v772 == "QinShi" then
						local v839 = (p_u_769.NPCModel or "unknown") .. "_C"
						local v840 = tick()
						local v841
						if v_u_44[v839] and v840 - v_u_44[v839] < 1.5 then
							v841 = false
						else
							v_u_44[v839] = v840
							v841 = true
						end
						if v841 then
							v_u_37:PlayAt("QinShiC", p_u_769.Position)
						end
					elseif v772 == "Yuji" then
						local v842 = (p_u_769.NPCModel or "unknown") .. "_C"
						local v843 = tick()
						local v844
						if v_u_44[v842] and v843 - v_u_44[v842] < 1.5 then
							v844 = false
						else
							v_u_44[v842] = v843
							v844 = true
						end
						if v844 then
							v_u_37:PlayAt("YujiC_Press", p_u_769.Position)
						end
					elseif v772 ~= "Ichigo" and (v772 ~= "Alucard" and (v772 ~= "GojoV2" and (v772 ~= "StrongestInHistory" and (v772 ~= "Rimuru" and v772 ~= "Madoka")))) then
						local v845 = (p_u_769.NPCModel or "unknown") .. "_C"
						local v846 = tick()
						local v847
						if v_u_44[v845] and v846 - v_u_44[v845] < 1.5 then
							v847 = false
						else
							v_u_44[v845] = v846
							v847 = true
						end
						if v847 then
							v_u_37:PlayAt("SaberC_Cast", p_u_769.Position)
							task.delay(3.85, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_769
								v_u_37:PlayAt("SaberC_Beam", p_u_769.Position)
							end)
							task.delay(4.4, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_769
								v_u_37:PlayAt("SaberC_Explosion", p_u_769.Position)
							end)
						end
					end
				elseif p_u_769.VFXName == "V" then
					if v772 == "Gojo" then
						v_u_37:PlayAt("GojoV", p_u_769.Position)
					elseif v772 ~= "Sukuna" and (v772 ~= "Ichigo" and (v772 ~= "Alucard" and (v772 ~= "GojoV2" and (v772 ~= "StrongestInHistory" and v772 ~= "Rimuru")))) then
						local _ = v772 == "Madoka"
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_288, (copy) p_u_769
					v_u_288.SpawnVFX(p_u_769.VFXName, p_u_769.Position, p_u_769.Scale, p_u_769.Duration, p_u_769.AbilityName)
				end)
			end
			if p_u_769.CameraShake then
				task.delay(p_u_769.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_769, (ref) v_u_7
					local v_u_848 = p_u_769.CameraShake.Intensity or 5
					local v_u_849 = p_u_769.CameraShake.Duration or 0.3
					if v_u_7:GetAttribute("DisableScreenShake") then
						return
					else
						local v_u_850 = workspace.CurrentCamera
						if v_u_850 then
							task.spawn(function()
								-- upvalues: (copy) v_u_850, (copy) v_u_849, (copy) v_u_848
								local v851 = tick()
								local _ = v_u_850.CFrame
								while tick() - v851 < v_u_849 do
									local v852 = v_u_848 * (1 - (tick() - v851) / v_u_849)
									local v853 = (math.random() - 0.5) * v852 * 0.1
									local v854 = (math.random() - 0.5) * v852 * 0.1
									v_u_850.CFrame = v_u_850.CFrame * CFrame.new(v853, v854, 0)
									task.wait()
								end
							end)
						end
					end
				end)
			end
			if p_u_769.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_294, (copy) p_u_769
					v_u_294(p_u_769.ScreenFlash)
				end)
				return
			end
		elseif p768 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_288, (copy) p_u_769, (ref) v_u_4
				local v855 = v_u_288.SpawnVFXWithRotation(p_u_769.VFXName, p_u_769.Position, p_u_769.Rotation, p_u_769.Scale, p_u_769.Duration, "KatanaAbilities")
				if v855 then
					v_u_4:AddItem(v855, (p_u_769.Duration or 0.4) + 1)
				end
			end)
			if p_u_769.IsNPC then
				v_u_37:PlayAt("KatanaZ", p_u_769.Position)
			end
			if p_u_769.CameraShake then
				local v_u_856 = p_u_769.CameraShake.Intensity or 3
				local v_u_857 = p_u_769.CameraShake.Duration or 0.2
				if v_u_7:GetAttribute("DisableScreenShake") then
					return
				else
					local v_u_858 = workspace.CurrentCamera
					if v_u_858 then
						task.spawn(function()
							-- upvalues: (copy) v_u_858, (copy) v_u_857, (copy) v_u_856
							local v859 = tick()
							local _ = v_u_858.CFrame
							while tick() - v859 < v_u_857 do
								local v860 = v_u_856 * (1 - (tick() - v859) / v_u_857)
								local v861 = (math.random() - 0.5) * v860 * 0.1
								local v862 = (math.random() - 0.5) * v860 * 0.1
								v_u_858.CFrame = v_u_858.CFrame * CFrame.new(v861, v862, 0)
								task.wait()
							end
						end)
					end
				end
			end
		elseif p768 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_288, (copy) p_u_769, (ref) v_u_4
				local v863 = v_u_288.SpawnTravelingVFX(p_u_769.VFXName, p_u_769.StartPosition, p_u_769.Direction, p_u_769.TravelDistance, p_u_769.TravelSpeed, p_u_769.Scale, p_u_769.Duration, "KatanaAbilities")
				if v863 then
					v_u_4:AddItem(v863, (p_u_769.TravelDistance or 50) / (p_u_769.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_769.CameraShake then
				local v_u_864 = p_u_769.CameraShake.Intensity or 6
				local v_u_865 = p_u_769.CameraShake.Duration or 0.3
				local v_u_866 = not v_u_7:GetAttribute("DisableScreenShake") and workspace.CurrentCamera
				if v_u_866 then
					task.spawn(function()
						-- upvalues: (copy) v_u_866, (copy) v_u_865, (copy) v_u_864
						local v867 = tick()
						local _ = v_u_866.CFrame
						while tick() - v867 < v_u_865 do
							local v868 = v_u_864 * (1 - (tick() - v867) / v_u_865)
							local v869 = (math.random() - 0.5) * v868 * 0.1
							local v870 = (math.random() - 0.5) * v868 * 0.1
							v_u_866.CFrame = v_u_866.CFrame * CFrame.new(v869, v870, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_769.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_294, (copy) p_u_769
					v_u_294(p_u_769.ScreenFlash)
				end)
			end
		end
	end)
	local v871 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_872 = 1
	v871.OnClientEvent:Connect(function(p873)
		-- upvalues: (ref) v_u_872, (copy) v_u_37
		if p873 and p873.Position then
			v_u_37:PlayAt("CombatHit" .. v_u_872, p873.Position)
			v_u_872 = v_u_872 % 7 + 1
		end
	end)
	local v_u_874 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v875 = v46:WaitForChild("HitboxVisualize", 5)
	if v875 then
		v875.OnClientEvent:Connect(function(p876)
			-- upvalues: (copy) v_u_874
			if p876.Type == "Box" then
				v_u_874.ShowBox(p876.CFrame, p876.Size, p876.Duration, p876.Color)
				return
			elseif p876.Type == "Sphere" then
				v_u_874.ShowSphere(p876.Position, p876.Radius, p876.Duration, p876.Color)
				return
			elseif p876.Type == "Traveling" then
				v_u_874.ShowTraveling(p876.StartPos, p876.Direction, p876.Size, p876.Speed, p876.Distance, p876.HitboxType, p876.Color)
			elseif p876.Type == "FollowingAOE" then
				local v877 = p876.Character
				if v877 then
					v_u_874.ShowFollowingAOE(v877, p876.Size, p876.Duration, p876.Offset, p876.Color, p876.Shape)
					return
				end
			else
				if p876.Type == "MultiWave" then
					v_u_874.ShowMultiWave(p876.OriginCFrame, p876.Waves)
					return
				end
				if p876.Type == "Explosion" then
					v_u_874.ShowExplosion(p876.Position, p876.Radius, p876.Duration, p876.Color)
					return
				end
				if p876.Type == "StaticBox" then
					v_u_874.ShowStaticBox(p876.StartPos, p876.EndPos, p876.Width, p876.Height, p876.Duration, p876.Color)
				end
			end
		end)
	end
end)
if not v878 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v879)
	warn("=====================================")
end