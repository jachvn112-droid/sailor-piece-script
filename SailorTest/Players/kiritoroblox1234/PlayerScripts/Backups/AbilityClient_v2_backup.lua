local v876, v877 = pcall(function()
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
		[Enum.KeyCode.DPadUp] = 4
	}
	local v_u_57 = 0
	local v_u_58 = nil
	local v_u_59 = 0
	local v60 = v_u_3:FindFirstChild("RemoteEvents")
	if v60 then
		v60 = v60:FindFirstChild("ShadowFUnlockUpdate")
	end
	if v60 then
		v60.OnClientEvent:Connect(function(p61)
			-- upvalues: (copy) v_u_7
			v_u_7:SetAttribute("ShadowFUnlocked", p61)
		end)
	end
	local v62 = v_u_3:FindFirstChild("RemoteEvents")
	if v62 then
		v62 = v62:FindFirstChild("SukunaFUnlockUpdate")
	end
	if v62 then
		v62.OnClientEvent:Connect(function(p63)
			-- upvalues: (copy) v_u_7
			v_u_7:SetAttribute("SukunaFUnlocked", p63)
		end)
	end
	local v64 = v_u_3:FindFirstChild("RemoteEvents")
	if v64 then
		v64 = v64:FindFirstChild("GojoFUnlockUpdate")
	end
	if v64 then
		v64.OnClientEvent:Connect(function(p65)
			-- upvalues: (copy) v_u_7
			v_u_7:SetAttribute("GojoFUnlocked", p65)
		end)
	end
	local function v67()
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
		local v66 = workspace.CurrentCamera
		if v66 then
			v66.FieldOfView = 70
		end
	end
	v_u_7.CharacterAdded:Connect(v67)
	if v_u_7.Character then
		task.spawn(v67)
	end
	local v_u_68 = v_u_54
	local v_u_69 = {}
	local v70 = 0
	for _, v71 in v47:GetChildren() do
		if v71:IsA("ModuleScript") and not (string.find(v71.Name, "DISABLED") or string.find(v71.Name, "BEFORE")) then
			local v72, v73 = pcall(require, v71)
			if v72 then
				v_u_69[v71.Name] = v73
				v70 = v70 + 1
			else
				warn("[AbilityClient] Failed to load VFX handler:", v71.Name, "Error:", v73)
			end
		end
	end
	local function v_u_78()
		-- upvalues: (copy) v_u_7, (copy) v_u_36
		local v74 = v_u_7.Character
		if not v74 then
			return nil
		end
		local v75 = v74:FindFirstChildOfClass("Tool")
		if not v75 then
			return nil
		end
		for v76, v77 in pairs(v_u_36.Movesets) do
			if v77.ToolName and v77.ToolName == v75.Name then
				return v76
			end
		end
		return nil
	end
	local v_u_79 = {}
	local v_u_80 = nil
	local v_u_81 = 0
	local v_u_82 = nil
	local v_u_83 = nil
	local v_u_84 = 0
	local v_u_85 = 0.5
	local v_u_86 = nil
	local v_u_87 = false
	local v_u_88 = false
	local v_u_89 = {}
	local v_u_90 = false
	local v_u_91 = nil
	local v_u_92 = 0
	local v_u_93 = nil
	local v_u_94 = nil
	local v_u_95 = nil
	local v_u_96 = nil
	local v_u_97 = nil
	local v_u_98 = false
	local v_u_99 = false
	local v_u_100 = nil
	local v_u_101 = nil
	local v_u_102 = nil
	local v_u_103 = nil
	local function v_u_105()
		-- upvalues: (ref) v_u_102, (ref) v_u_103, (ref) v_u_91, (ref) v_u_92, (ref) v_u_93, (ref) v_u_94, (ref) v_u_95, (ref) v_u_100, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_96
		if v_u_102 then
			v_u_102:Stop(0)
			v_u_102 = nil
		end
		if v_u_103 then
			v_u_103:Stop()
			v_u_103 = nil
		end
		v_u_91 = nil
		v_u_92 = 0
		v_u_93 = nil
		v_u_94 = nil
		v_u_95 = nil
		local v104 = workspace.CurrentCamera
		if v104 then
			v104.FieldOfView = 70
		end
		if v_u_100 then
			v_u_100:Destroy()
			v_u_100 = nil
		end
		if v_u_101 then
			v_u_101:Destroy()
			v_u_101 = nil
		end
		v_u_98 = false
		v_u_99 = false
		v_u_96 = nil
	end
	local function v108(p106)
		-- upvalues: (copy) v_u_105
		local v107 = p106:WaitForChild("Humanoid", 5)
		if v107 then
			v107.Died:Connect(function()
				-- upvalues: (ref) v_u_105
				v_u_105()
			end)
		end
	end
	local v109 = v_u_7.Character and v_u_7.Character:WaitForChild("Humanoid", 5)
	if v109 then
		v109.Died:Connect(function()
			-- upvalues: (copy) v_u_105
			v_u_105()
		end)
	end
	v_u_7.CharacterAdded:Connect(v108)
	local function v_u_163(p110)
		-- upvalues: (copy) v_u_1, (ref) v_u_96, (ref) v_u_98, (ref) v_u_99, (copy) v_u_3, (copy) v_u_4, (ref) v_u_101, (copy) v_u_7, (copy) v_u_6, (ref) v_u_100, (ref) v_u_91, (ref) v_u_97, (copy) v_u_5, (ref) v_u_103, (copy) v_u_37
		local v_u_111 = workspace.CurrentCamera
		if v_u_111 then
			local v_u_112 = v_u_1.LocalPlayer.Character
			if v_u_112 then
				local v_u_113 = v_u_112:FindFirstChild("Right Arm") or v_u_112:FindFirstChild("RightHand")
				if v_u_113 and v_u_112:FindFirstChild("HumanoidRootPart") then
					v_u_96 = v_u_111.FieldOfView
					v_u_98 = false
					v_u_99 = false
					local v_u_114 = p110.ChargeTier2Time or 2
					local v_u_115 = p110.ChargeTier3Time or 4
					local v116 = v_u_3.AbilitySystem.VFX.Yuji.C
					local v117 = v116:FindFirstChild("ArmVFX1")
					local v_u_118 = v116:FindFirstChild("ArmVFX2")
					local v_u_119 = v116:FindFirstChild("ArmVFX3")
					local v_u_120 = v116:FindFirstChild("AuraVFX1")
					local v_u_121 = v116:FindFirstChild("AuraVFX2")
					local v_u_122 = v116:FindFirstChild("AuraVFX3")
					local v_u_123 = nil
					local v_u_124 = nil
					local v_u_125 = false
					local function v_u_130(p126)
						-- upvalues: (copy) v_u_113
						if not p126 then
							return nil
						end
						local v127 = p126:Clone()
						v127.CFrame = v_u_113.CFrame * CFrame.new(Vector3.new(0, -1, 0))
						v127.Anchored = false
						v127.CanCollide = false
						v127.CanQuery = false
						v127.CanTouch = false
						v127.Transparency = 1
						v127.Parent = workspace
						local v128 = Instance.new("WeldConstraint")
						v128.Part0 = v127
						v128.Part1 = v_u_113
						v128.Parent = v127
						for _, v129 in v127:GetDescendants() do
							if v129:IsA("ParticleEmitter") then
								v129.Enabled = true
								v129:Emit(v129:GetAttribute("EmitCount") or v129.Rate)
							end
						end
						return v127
					end
					local function v_u_136(p131)
						-- upvalues: (copy) v_u_112
						if not p131 then
							return nil
						end
						local v132 = v_u_112:FindFirstChild("HumanoidRootPart")
						if not v132 then
							return nil
						end
						local v133 = p131:Clone()
						v133.CFrame = v132.CFrame * CFrame.new(Vector3.new(0, -2.95, 0))
						v133.Anchored = false
						v133.CanCollide = false
						v133.CanQuery = false
						v133.CanTouch = false
						v133.Transparency = 1
						v133.Parent = workspace
						local v134 = Instance.new("WeldConstraint")
						v134.Part0 = v133
						v134.Part1 = v132
						v134.Parent = v133
						for _, v135 in v133:GetDescendants() do
							if v135:IsA("ParticleEmitter") then
								v135.Enabled = true
								v135:Emit(v135:GetAttribute("EmitCount") or v135.Rate)
							end
						end
						return v133
					end
					local function v_u_139(p137)
						if p137 then
							for _, v138 in p137:GetDescendants() do
								if v138:IsA("ParticleEmitter") then
									v138.Enabled = false
								end
							end
						end
					end
					v_u_123 = v_u_130(v117)
					v_u_100 = v_u_123
					task.delay(0.15, function()
						-- upvalues: (ref) v_u_91, (ref) v_u_125, (ref) v_u_124, (copy) v_u_136, (copy) v_u_120, (ref) v_u_101
						if v_u_91 then
							if not v_u_125 then
								v_u_125 = true
								v_u_124 = v_u_136(v_u_120)
								v_u_101 = v_u_124
							end
						else
							return
						end
					end)
					local v140 = 4 * v_u_115
					v_u_97 = v_u_5:Create(v_u_111, TweenInfo.new(v_u_115, Enum.EasingStyle.Linear), {
						["FieldOfView"] = v_u_96 + v140
					})
					v_u_97:Play()
					task.spawn(function()
						-- upvalues: (ref) v_u_91, (ref) v_u_98, (copy) v_u_114, (ref) v_u_7, (copy) v_u_111, (ref) v_u_6, (copy) v_u_118, (ref) v_u_123, (copy) v_u_130, (copy) v_u_139, (ref) v_u_4, (ref) v_u_100, (copy) v_u_121, (ref) v_u_124, (copy) v_u_136, (ref) v_u_101, (ref) v_u_97, (ref) v_u_5, (copy) v_u_115, (ref) v_u_99, (copy) v_u_119, (copy) v_u_122, (ref) v_u_103, (ref) v_u_37
						local v141 = tick()
						while v_u_91 do
							local v142 = tick() - v141
							if not v_u_98 and v_u_114 <= v142 then
								v_u_98 = true
								if not v_u_7:GetAttribute("DisableScreenShake") then
									local v_u_143 = 0.3
									local v_u_144 = 6
									task.spawn(function()
										-- upvalues: (copy) v_u_143, (copy) v_u_144, (ref) v_u_111, (ref) v_u_6
										local v145 = tick()
										while tick() - v145 < v_u_143 do
											local v146 = v_u_144 * (1 - (tick() - v145) / v_u_143) * 0.01
											local v147 = (math.random() - 0.5) * 2 * v146
											local v148 = (math.random() - 0.5) * 2 * v146
											v_u_111.CFrame = v_u_111.CFrame * CFrame.new(v147, v148, 0)
											v_u_6.RenderStepped:Wait()
										end
									end)
								end
								local v149 = v_u_123
								v_u_123 = v_u_130(v_u_118)
								if v149 then
									v_u_139(v149)
									v_u_4:AddItem(v149, 0.5)
								end
								v_u_100 = v_u_123
								local v150 = v_u_124
								v_u_124 = v_u_136(v_u_121)
								v_u_101 = v_u_124
								if v150 then
									v_u_139(v150)
									v_u_4:AddItem(v150, 0.5)
								end
								if v_u_97 then
									v_u_97:Pause()
								end
								local v151 = v_u_5:Create(v_u_111, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_111.FieldOfView + 5
								})
								v151:Play()
								v151.Completed:Wait()
								if v_u_91 then
									local v152 = v_u_115 - v142
									local v153 = {
										["FieldOfView"] = v_u_111.FieldOfView + 4 * v152
									}
									v_u_97 = v_u_5:Create(v_u_111, TweenInfo.new(v152, Enum.EasingStyle.Linear), v153)
									v_u_97:Play()
								end
							end
							if not v_u_99 and v_u_115 <= v142 then
								v_u_99 = true
								if not v_u_7:GetAttribute("DisableScreenShake") then
									local v_u_154 = 0.3
									local v_u_155 = 10
									task.spawn(function()
										-- upvalues: (copy) v_u_154, (copy) v_u_155, (ref) v_u_111, (ref) v_u_6
										local v156 = tick()
										while tick() - v156 < v_u_154 do
											local v157 = v_u_155 * (1 - (tick() - v156) / v_u_154) * 0.01
											local v158 = (math.random() - 0.5) * 2 * v157
											local v159 = (math.random() - 0.5) * 2 * v157
											v_u_111.CFrame = v_u_111.CFrame * CFrame.new(v158, v159, 0)
											v_u_6.RenderStepped:Wait()
										end
									end)
								end
								local v160 = v_u_123
								v_u_123 = v_u_130(v_u_119)
								if v160 then
									v_u_139(v160)
									v_u_4:AddItem(v160, 0.5)
								end
								v_u_100 = v_u_123
								local v161 = v_u_124
								v_u_124 = v_u_136(v_u_122)
								v_u_101 = v_u_124
								if v161 then
									v_u_139(v161)
									v_u_4:AddItem(v161, 0.5)
								end
								local v162 = v_u_7.Character
								if v162 then
									v162 = v162:FindFirstChild("HumanoidRootPart")
								end
								v_u_103 = v162 and v_u_37:PlayAt("YujiC_HoldLoop", v162.Position)
								if v_u_103 then
									v_u_103.Looped = true
								end
								if v_u_97 then
									v_u_97:Cancel()
									v_u_97 = nil
								end
								v_u_5:Create(v_u_111, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_111.FieldOfView + 5
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
	local function v_u_168()
		-- upvalues: (ref) v_u_97, (ref) v_u_100, (copy) v_u_4, (ref) v_u_101, (ref) v_u_96, (copy) v_u_5, (ref) v_u_98, (ref) v_u_99
		if v_u_97 then
			v_u_97:Cancel()
			v_u_97 = nil
		end
		if v_u_100 and v_u_100.Parent then
			for _, v164 in v_u_100:GetDescendants() do
				if v164:IsA("ParticleEmitter") then
					v164.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_100, 0.15)
		end
		v_u_100 = nil
		if v_u_101 and v_u_101.Parent then
			for _, v165 in v_u_101:GetDescendants() do
				if v165:IsA("ParticleEmitter") then
					v165.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_101, 0.15)
		end
		v_u_101 = nil
		local v166 = workspace.CurrentCamera
		if v166 and v_u_96 then
			local v167 = {
				["FieldOfView"] = v_u_96
			}
			v_u_5:Create(v166, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v167):Play()
		end
		v_u_96 = nil
		v_u_98 = false
		v_u_99 = false
	end
	local function v_u_178(_, p169, p170, p171, p172)
		local v173 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p172 or "Gojo")
		if v173 then
			v173 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p172 or "Gojo"):FindFirstChild("C")
		end
		if not v173 then
			return nil
		end
		local v174 = v173:FindFirstChild(p169)
		if not v174 then
			return nil
		end
		local v175 = v174:Clone()
		v175.CFrame = p170.CFrame
		v175.Anchored = false
		v175.CanCollide = false
		v175.Transparency = 1
		v175.Parent = workspace
		local v176 = Instance.new("WeldConstraint")
		v176.Part0 = p170
		v176.Part1 = v175
		v176.Parent = v175
		for _, v177 in pairs(v175:GetDescendants()) do
			if v177:IsA("ParticleEmitter") then
				v177.Enabled = true
			end
		end
		game:GetService("Debris"):AddItem(v175, p171)
		return v175
	end
	local function v_u_181()
		-- upvalues: (ref) v_u_89
		for _, v179 in pairs(v_u_89) do
			if v179 and v179.Parent then
				for _, v180 in pairs(v179:GetDescendants()) do
					if v180:IsA("ParticleEmitter") then
						v180.Enabled = false
					end
				end
				game:GetService("Debris"):AddItem(v179, 0.5)
			end
		end
		v_u_89 = {}
	end
	local function v_u_190(p182, p183, p_u_184)
		-- upvalues: (copy) v_u_5
		local v185 = workspace.CurrentCamera
		if v185 then
			local v_u_186 = v185.FieldOfView
			local v187 = {
				["FieldOfView"] = v_u_186 + p182
			}
			v_u_5:Create(v185, TweenInfo.new(p183, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), v187):Play()
			task.delay(p183, function()
				-- upvalues: (ref) v_u_5, (copy) p_u_184, (copy) v_u_186
				local v188 = workspace.CurrentCamera
				if v188 then
					local v189 = {
						["FieldOfView"] = v_u_186
					}
					v_u_5:Create(v188, TweenInfo.new(p_u_184, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v189):Play()
				end
			end)
		end
	end
	local function v_u_201(p191)
		-- upvalues: (copy) v_u_181, (copy) v_u_190, (copy) v_u_178, (ref) v_u_83, (ref) v_u_89
		v_u_181()
		v_u_190(10, 0.12, 0.5)
		task.delay(9.5, function()
			-- upvalues: (ref) v_u_190
			v_u_190(10, 0.12, 0.5)
		end)
		local v192 = p191:FindFirstChild("Torso") or p191:FindFirstChild("UpperTorso")
		local v193 = p191:FindFirstChild("Right Arm") or p191:FindFirstChild("RightUpperArm")
		local v194 = p191:FindFirstChild("Left Arm") or p191:FindFirstChild("LeftUpperArm")
		local v195 = v192 and v_u_178(p191, "DamageVFX", v192, 10, v_u_83)
		if v195 then
			local v196 = v_u_89
			table.insert(v196, v195)
		end
		local v197 = v193 and v_u_178(p191, "ArmVFX", v193, 10, v_u_83)
		if v197 then
			local v198 = v_u_89
			table.insert(v198, v197)
		end
		local v199 = v194 and v_u_178(p191, "ArmVFX", v194, 10, v_u_83)
		if v199 then
			local v200 = v_u_89
			table.insert(v200, v199)
		end
	end
	local function v_u_206(p202)
		-- upvalues: (copy) v_u_181, (ref) v_u_90, (copy) v_u_190, (copy) v_u_178, (ref) v_u_83, (ref) v_u_89
		v_u_181()
		v_u_90 = true
		v_u_190(10, 0.12, 0.5)
		task.delay(5.5, function()
			-- upvalues: (ref) v_u_90, (ref) v_u_190
			if v_u_90 then
				v_u_190(10, 0.12, 0.5)
			end
			v_u_90 = false
		end)
		local v203 = p202:FindFirstChild("Torso") or p202:FindFirstChild("UpperTorso")
		local v204 = v203 and v_u_178(p202, "HealVFX", v203, 6, v_u_83)
		if v204 then
			local v205 = v_u_89
			table.insert(v205, v204)
		end
	end
	v_u_2.InputBegan:Connect(function(p207, p208)
		-- upvalues: (ref) v_u_51, (copy) v_u_43, (copy) v_u_7, (copy) v_u_36, (copy) v_u_56, (ref) v_u_58, (ref) v_u_59, (ref) v_u_57, (copy) v_u_78, (copy) v_u_79, (copy) v_u_34, (copy) v_u_48, (copy) v_u_37, (ref) v_u_80, (ref) v_u_81, (ref) v_u_82, (ref) v_u_83, (ref) v_u_84, (ref) v_u_85, (ref) v_u_88, (copy) v_u_201, (ref) v_u_86, (copy) v_u_206, (ref) v_u_87, (copy) v_u_45, (ref) v_u_91, (ref) v_u_92, (ref) v_u_93, (ref) v_u_94, (ref) v_u_95, (copy) v_u_163, (copy) v_u_3, (ref) v_u_102, (copy) v_u_168, (copy) v_u_2
		if p208 then
			return
		elseif v_u_51 then
			return
		elseif v_u_43.InArtifactUI then
			return
		else
			local v209 = v_u_7.Character
			if v209 and v209:GetAttribute("InArtifactUI") then
				return
			elseif v209 and v209:GetAttribute("InCutscene") then
				return
			else
				local v210 = v_u_36.Keybinds[p207.KeyCode] or v_u_56[p207.KeyCode]
				if p207.KeyCode == Enum.KeyCode.DPadUp then
					if v_u_58 then
						task.cancel(v_u_58)
						v_u_58 = nil
					end
					local v211 = tick()
					local v212 = v211 - v_u_59
					v_u_59 = v211
					if v212 <= 0.4 then
						v_u_57 = v_u_57 + 1
					else
						v_u_57 = 1
					end
					if v_u_57 < 2 then
						local v_u_213 = v_u_78()
						local v_u_214 = v_u_7.Character
						v_u_58 = task.delay(0.4, function()
							-- upvalues: (ref) v_u_58, (ref) v_u_57, (ref) v_u_51, (copy) v_u_214, (ref) v_u_36, (copy) v_u_213, (ref) v_u_79, (ref) v_u_34, (ref) v_u_48, (ref) v_u_37
							v_u_58 = nil
							if v_u_57 == 1 then
								v_u_57 = 0
								if v_u_51 then
									return
								elseif v_u_214 and v_u_214:GetAttribute("InCutscene") then
									return
								else
									local v215 = v_u_36.Movesets[v_u_213]
									if v215 and v215.Abilities[4] then
										local v216 = v215.Abilities[4]
										local v217 = v_u_79[v_u_213 .. "_" .. 4]
										local v218
										if v217 and tick() < v217 then
											local _ = v217 - tick()
											v218 = true
										else
											v218 = false
										end
										if v218 then
											return
										elseif v216.Type == "TargetedCutscene" then
											local v219, v220 = v_u_34(v216.TargetRange or 30)
											if v219 then
												v_u_48:FireServer(4, {
													["TargetName"] = v219.Name,
													["TargetPosition"] = v220.Position
												})
											end
										else
											if v_u_213 == "Shadow" then
												v_u_37:Play("ShadowV_Ultimate")
											end
											v_u_48:FireServer(4)
											return
										end
									else
										return
									end
								end
							else
								return
							end
						end)
						return
					end
					v_u_57 = 0
					v210 = 5
				end
				if v210 then
					local v221 = v_u_78()
					local v222 = game:GetService("RunService"):IsStudio()
					if v210 == 5 and (v221 == "Shadow" and not v222) and v_u_7:GetAttribute("ShadowFUnlocked") ~= true then
						return
					elseif v210 == 5 and (v221 == "StrongestInHistory" and not v222) and v_u_7:GetAttribute("SukunaFUnlocked") ~= true then
						return
					elseif v210 == 5 and (v221 == "StrongestOfToday" and not v222) and v_u_7:GetAttribute("GojoFUnlocked") ~= true then
						return
					elseif v221 then
						local v223 = v_u_36.Movesets[v221]
						if v223 and v223.Abilities[v210] then
							local v224 = v223.Abilities[v210]
							if v224.Type == "HoldVariant" then
								local v225 = v_u_79[v221 .. "_" .. v210]
								local v226
								if v225 and tick() < v225 then
									local _ = v225 - tick()
									v226 = true
								else
									v226 = false
								end
								if not v226 then
									v_u_80 = p207.KeyCode
									v_u_81 = tick()
									v_u_82 = v210
									v_u_83 = v221
									v_u_84 = 1
									v_u_85 = v224.HoldThreshold or 0.5
									v_u_88 = false
									local v227 = v_u_7.Character
									if v227 then
										v_u_201(v227)
									end
									if v_u_86 then
										v_u_86:Disconnect()
									end
									v_u_86 = game:GetService("RunService").Heartbeat:Connect(function()
										-- upvalues: (ref) v_u_80, (ref) v_u_86, (ref) v_u_81, (ref) v_u_85, (ref) v_u_84, (ref) v_u_88, (ref) v_u_7, (ref) v_u_206, (ref) v_u_36, (ref) v_u_83, (ref) v_u_82, (ref) v_u_79, (ref) v_u_87, (ref) v_u_45, (ref) v_u_37, (ref) v_u_48
										if v_u_80 then
											if v_u_85 <= tick() - v_u_81 and (v_u_84 == 1 and not v_u_88) then
												v_u_84 = 2
												v_u_88 = true
												local v228 = v_u_7.Character
												if v228 then
													v_u_206(v228)
												end
												local v229 = v_u_36.Movesets[v_u_83]
												if v229 then
													v229 = v229.Abilities[v_u_82]
												end
												if v229 and v229.Cooldown then
													local v230 = v_u_83
													local v231 = v_u_82
													local v232 = v229.Cooldown
													v_u_79[v230 .. "_" .. v231] = tick() + v232
												end
												v_u_87 = true
												local v233 = v_u_83
												local v234 = v_u_82
												local v235 = v_u_45[v233]
												local v236 = v235 and v235[v234]
												if v236 then
													if v234 == 3 then
														v236 = v233 == "Sukuna" and "SukunaC_Hold" or (v233 == "Gojo" and "GojoC_Hold" or v236)
													end
													v_u_37:Play(v236)
												end
												v_u_48:FireServer(v_u_82, {
													["Variant"] = 2
												})
											end
										else
											if v_u_86 then
												v_u_86:Disconnect()
											end
											v_u_86 = nil
										end
									end)
								end
							elseif v224.Type == "ChargedInstant" then
								local v237 = v_u_79[v221 .. "_" .. v210]
								local v238
								if v237 and tick() < v237 then
									local _ = v237 - tick()
									v238 = true
								else
									v238 = false
								end
								if not v238 then
									v_u_91 = p207.KeyCode
									v_u_92 = tick()
									v_u_93 = v210
									v_u_94 = v221
									v_u_95 = v224
									v_u_163(v224)
									if v221 == "Yuji" and v210 == 3 then
										local v239 = v_u_7.Character
										if v239 then
											v239 = v239:FindFirstChild("HumanoidRootPart")
										end
										if v239 then
											v_u_37:PlayAt("YujiC_HoldStart", v239.Position)
										end
										task.delay(0.15, function()
											-- upvalues: (ref) v_u_91, (ref) v_u_93, (ref) v_u_7, (ref) v_u_3, (ref) v_u_102
											if v_u_91 then
												if v_u_93 == 3 then
													local v240 = v_u_7.Character
													if v240 then
														v240 = v240:FindFirstChildOfClass("Humanoid")
													end
													if v240 then
														local v241 = v240:FindFirstChildOfClass("Animator") or Instance.new("Animator", v240)
														local v242 = v_u_3.AbilitySystem.Animations:FindFirstChild("Yuji")
														if v242 then
															v242 = v242:FindFirstChild("Yuji_C_Anim_Hold")
														end
														if v242 then
															if v_u_102 then
																v_u_102:Stop(0)
																v_u_102 = nil
															end
															v_u_102 = v241:LoadAnimation(v242)
															v_u_102.Priority = Enum.AnimationPriority.Action4
															v_u_102.Looped = true
															v_u_102:Play()
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
								local v243 = v_u_79[v221 .. "_" .. v210]
								local v244
								if v243 and tick() < v243 then
									local _ = v243 - tick()
									v244 = true
								else
									v244 = false
								end
								if v244 then
									return
								else
									if v_u_91 then
										v_u_168()
										if v_u_102 then
											v_u_102:Stop(0)
											v_u_102 = nil
										end
										v_u_91 = nil
										v_u_92 = 0
										v_u_93 = nil
										v_u_94 = nil
										v_u_95 = nil
									end
									if v224.Type == "TargetedCutscene" then
										local v245, v246 = v_u_34(v224.TargetRange or 30)
										if v245 then
											local v247 = v_u_79[v221 .. "_" .. v210]
											local v248
											if v247 and tick() < v247 then
												local _ = v247 - tick()
												v248 = true
											else
												v248 = false
											end
											if not v248 then
												v_u_48:FireServer(v210, {
													["TargetName"] = v245.Name,
													["TargetPosition"] = v246.Position
												})
											end
										else
											if v_u_2:GetLastInputType() == Enum.UserInputType.Gamepad1 then
												local v249 = v_u_3:FindFirstChild("Remotes")
												if v249 then
													v249 = v_u_3.Remotes:FindFirstChild("ShowNotification")
												end
												if v249 then
													v249:FireServer("Ability", {
														["message"] = "No target in range",
														["duration"] = 1.5
													})
												end
											end
											return
										end
									else
										if v221 == "Shadow" then
											local v250 = v_u_79[v221 .. "_" .. v210]
											local v251
											if v250 and tick() < v250 then
												local _ = v250 - tick()
												v251 = true
											else
												v251 = false
											end
											if not v251 then
												if v210 == 2 then
													v_u_37:Play("ShadowX_Dash")
												elseif v210 == 4 then
													v_u_37:Play("ShadowV_Ultimate")
												end
											end
										end
										v_u_48:FireServer(v210)
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
	v_u_2.InputEnded:Connect(function(p252, _)
		-- upvalues: (ref) v_u_91, (ref) v_u_92, (ref) v_u_94, (ref) v_u_93, (ref) v_u_95, (copy) v_u_168, (ref) v_u_102, (ref) v_u_103, (copy) v_u_79, (copy) v_u_48, (ref) v_u_80, (ref) v_u_84, (ref) v_u_83, (ref) v_u_82, (ref) v_u_88, (ref) v_u_81, (ref) v_u_85, (ref) v_u_86, (copy) v_u_36, (ref) v_u_87, (copy) v_u_45, (copy) v_u_37
		if v_u_91 and p252.KeyCode == v_u_91 then
			local v253 = tick() - v_u_92
			local v254 = v_u_94
			local v255 = v_u_93
			local v256 = v_u_95
			v_u_168()
			if v_u_102 then
				v_u_102:Stop(0.1)
				v_u_102 = nil
			end
			if v_u_103 then
				v_u_103:Stop()
				v_u_103 = nil
			end
			_G.YujiCharging = false
			v_u_91 = nil
			v_u_92 = 0
			v_u_93 = nil
			v_u_94 = nil
			v_u_95 = nil
			if v254 and (v255 and v256) then
				local v257 = (v256.ChargeTier3Time or 5) <= v253 and 3 or ((v256.ChargeTier2Time or 2.5) <= v253 and 2 or 1)
				if v256.Cooldown then
					local v258 = v256.Cooldown
					v_u_79[v254 .. "_" .. v255] = tick() + v258
				end
				v_u_48:FireServer(v255, {
					["ChargeTier"] = v257,
					["HoldDuration"] = v253
				})
			end
		elseif v_u_80 then
			if p252.KeyCode == v_u_80 then
				local v259 = v_u_83
				local v260 = v_u_82
				local v261 = v_u_88
				v_u_80 = nil
				v_u_81 = 0
				v_u_82 = nil
				v_u_83 = nil
				v_u_84 = 0
				v_u_85 = 0.5
				v_u_88 = false
				if v_u_86 then
					v_u_86:Disconnect()
					v_u_86 = nil
				end
				if v259 and v260 then
					if not v261 then
						local v262 = v_u_36.Movesets[v259]
						if v262 then
							v262 = v262.Abilities[v260]
						end
						if v262 and v262.Cooldown then
							local v263 = v262.Cooldown
							v_u_79[v259 .. "_" .. v260] = tick() + v263
						end
						v_u_87 = true
						local v264 = v_u_45[v259]
						local v265 = v264 and v264[v260]
						if v265 then
							local _ = v260 == 3
							v_u_37:Play(v265)
						end
						v_u_48:FireServer(v260, {
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
	local v_u_266 = workspace:GetServerTimeNow()
	v49.OnClientEvent:Connect(function(p_u_267)
		-- upvalues: (copy) v_u_266, (copy) v_u_7, (ref) v_u_90, (copy) v_u_181, (ref) v_u_68, (copy) v_u_53, (copy) v_u_55, (copy) v_u_36, (ref) v_u_51, (copy) v_u_79, (ref) v_u_87, (copy) v_u_45, (copy) v_u_37, (copy) v_u_69
		if workspace:GetServerTimeNow() - v_u_266 < 2 and p_u_267.Caster ~= v_u_7 then
			return
		elseif p_u_267.Timestamp and p_u_267.Timestamp < v_u_266 then
			return
		elseif p_u_267.Type == "HealingInterrupted" and p_u_267.Caster == v_u_7 then
			v_u_90 = false
			v_u_181()
			return
		elseif p_u_267.Type == "Hit" then
			return
		else
			local v268 = false
			if p_u_267.Caster == v_u_7 and p_u_267.Cooldown then
				if not v_u_68 and pcall(function()
					-- upvalues: (ref) v_u_53
					v_u_53:Init()
				end) then
					v_u_68 = true
				end
				local v269 = p_u_267.MovesetName or "Ability"
				local v270 = v_u_55[p_u_267.Keybind or 1] or "Z"
				v_u_53:StartCooldown(v269, p_u_267.AbilityName, v270, p_u_267.Cooldown)
			end
			if p_u_267.Caster == v_u_7 and (p_u_267.AbilitySlot and p_u_267.MovesetName) then
				local v271 = v_u_36.Movesets[p_u_267.MovesetName]
				if v271 then
					v271 = v271.Abilities[p_u_267.AbilitySlot]
				end
				if v271 then
					local v272
					if v271.Type == "HoldVariant" then
						v272 = false
					else
						v272 = v271.Type ~= "Toggle"
					end
					if v271.AbilityLockDuration == 0 then
						v272 = false
					end
					if v272 then
						v_u_51 = true
						local v273 = (v271.ChargeTime or v271.Duration or (v271.MovementLockDuration or 5)) + 2
						local v274 = math.max(v273, 5)
						task.delay(v274, function()
							-- upvalues: (ref) v_u_51
							if v_u_51 == true then
								v_u_51 = false
							end
						end)
					end
					if p_u_267.Cooldown then
						local v275 = p_u_267.MovesetName
						local v276 = p_u_267.AbilitySlot
						local v277 = p_u_267.Cooldown
						v_u_79[v275 .. "_" .. v276] = tick() + v277
					end
					if v271.Type == "HoldVariant" then
						v268 = v_u_87
					else
						v268 = false
					end
					if not v268 then
						local v278 = p_u_267.MovesetName
						local v279 = p_u_267.AbilitySlot
						local v280 = p_u_267.Variant
						local v281 = v_u_45[v278]
						local v282 = v281 and v281[v279]
						if v282 then
							if v279 == 3 and v280 == 2 then
								v282 = v278 == "Sukuna" and "SukunaC_Hold" or (v278 == "Gojo" and "GojoC_Hold" or v282)
							end
							v_u_37:Play(v282)
						end
					end
					if v271.Type == "HoldVariant" then
						v_u_87 = false
					end
				end
			end
			local v283 = p_u_267.Caster
			local v284 = p_u_267.MovesetName
			local v285 = p_u_267.AbilityName
			if v283 and v283.Character then
				local v286 = v_u_36.Movesets[v284]
				if v286 then
					v286 = v286.Abilities[p_u_267.AbilitySlot]
				end
				local v287
				if v286 then
					v287 = v286.Type == "HoldVariant"
				else
					v287 = v286
				end
				local v288 = p_u_267.Caster == v_u_7
				if not (v287 and (v288 and v268)) then
					p_u_267.SkipLocalVFX = v268
					local v289 = v_u_69[v284]
					if v289 then
						local v_u_290 = v289[v285]
						if v_u_290 then
							task.spawn(function()
								-- upvalues: (copy) v_u_290, (copy) p_u_267
								local v291, v292 = pcall(v_u_290, p_u_267)
								if not v291 then
									warn("[AbilityClient] VFX error:", v292)
								end
							end)
						else
							warn("[AbilityClient] No handler for " .. v285)
						end
					else
						warn("[AbilityClient] No VFX handler for moveset " .. v284)
					end
					if v286 and (v286.Type == "ContinuousDamage" and (v288 and not (v286.AnchorHitbox or p_u_267.AnchorHitbox))) then
						local v_u_293 = v283.Character
						local v_u_294 = p_u_267.HitboxSize or (v286.HitboxSize or Vector3.new(30, 15, 30))
						local v_u_295 = p_u_267.HitboxOffset or (v286.HitboxOffset or Vector3.new(0, 0, 0))
						local v_u_296 = p_u_267.DamageDuration or (v286.Duration or 3)
						local v297 = p_u_267.DamageDelay or (v286.DamageDelay or 0)
						if v_u_293 then
							local v_u_298 = require(game:GetService("ReplicatedStorage"):WaitForChild("HitboxVisualizer"))
							task.delay(v297, function()
								-- upvalues: (copy) v_u_293, (copy) v_u_298, (copy) v_u_294, (copy) v_u_296, (copy) v_u_295
								if v_u_293 and v_u_293.Parent then
									v_u_298.ShowFollowingAOE(v_u_293, v_u_294, v_u_296, v_u_295)
								end
							end)
						end
					end
				end
			else
				return
			end
		end
	end)
	local v_u_299 = require(v_u_3:WaitForChild("VFXService"))
	local v_u_300 = game:GetService("TweenService")
	local function v_u_305(p301)
		-- upvalues: (copy) v_u_7, (copy) v_u_300
		local v302 = v_u_7.PlayerGui:FindFirstChild("ScreenEffects")
		if not v302 then
			v302 = Instance.new("ScreenGui")
			v302.Name = "ScreenEffects"
			v302.IgnoreGuiInset = true
			v302.DisplayOrder = 10
			v302.Parent = v_u_7.PlayerGui
		end
		local v_u_303 = Instance.new("Frame")
		v_u_303.Size = UDim2.new(1, 0, 1, 0)
		v_u_303.BackgroundColor3 = p301.Color or Color3.new(1, 1, 1)
		v_u_303.BackgroundTransparency = 0.7
		v_u_303.BorderSizePixel = 0
		v_u_303.Parent = v302
		local v304 = v_u_300:Create(v_u_303, TweenInfo.new(p301.Duration or 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 1
		})
		v304:Play()
		v304.Completed:Connect(function()
			-- upvalues: (copy) v_u_303
			v_u_303:Destroy()
		end)
	end
	local v_u_306 = {}
	local function v_u_764(p_u_307)
		-- upvalues: (copy) v_u_3, (copy) v_u_69, (copy) v_u_306, (copy) v_u_37
		local v_u_308 = game:GetService("Debris")
		game:GetService("TweenService")
		local v_u_309 = game:GetService("TweenService")
		local v310 = v_u_3:FindFirstChild("AbilitySystem")
		if v310 then
			local v311 = v310:FindFirstChild("VFX")
			if v311 then
				local v_u_312 = p_u_307.MovesetType or "Saber"
				local v_u_313 = v311:FindFirstChild(v_u_312) or v311:FindFirstChild("Saber")
				if v_u_313 then
					local v314 = p_u_307.Position
					CFrame.new(v314)
					if p_u_307.LookVector then
						CFrame.lookAt(v314, v314 + p_u_307.LookVector)
					end
					local v_u_315 = p_u_307.NPCModel
					if v_u_315 then
						v_u_315 = workspace.NPCs:FindFirstChild(p_u_307.NPCModel) or workspace:FindFirstChild(p_u_307.NPCModel)
					end
					local v_u_316
					if v_u_315 then
						v_u_316 = v_u_315:FindFirstChild("HumanoidRootPart")
					else
						v_u_316 = v_u_315
					end
					local function v_u_322(p317, p318, p319)
						-- upvalues: (copy) v_u_308
						local v320 = p317:Clone()
						v320.CFrame = p318
						v320.Anchored = true
						v320.CanCollide = false
						v320.Transparency = 1
						v320.CastShadow = false
						v320.CanQuery = false
						v320.Parent = workspace
						v_u_308:AddItem(v320, p319)
						for _, v321 in v320:GetDescendants() do
							if v321:IsA("ParticleEmitter") then
								v321:Emit(v321:GetAttribute("EmitCount") or 20)
							end
						end
						return v320
					end
					local function v_u_328(p323, p324)
						-- upvalues: (copy) v_u_309
						local v325 = TweenInfo.new(p324, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						for _, v326 in p323:GetDescendants() do
							if v326:IsA("Beam") then
								local v327 = v326.Width0
								v326.Width0 = 0
								v326.Width1 = 0
								v326.Enabled = true
								v_u_309:Create(v326, v325, {
									["Width0"] = v327,
									["Width1"] = v327
								}):Play()
							end
						end
					end
					local function v_u_334(p329, p330)
						-- upvalues: (copy) v_u_309
						local v331 = TweenInfo.new(p330, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
						for _, v_u_332 in p329:GetDescendants() do
							if v_u_332:IsA("Beam") then
								local v333 = v_u_309:Create(v_u_332, v331, {
									["Width0"] = 0,
									["Width1"] = 0
								})
								v333:Play()
								v333.Completed:Once(function()
									-- upvalues: (copy) v_u_332
									v_u_332.Enabled = false
								end)
							end
						end
					end
					if p_u_307.VFXName == "Z" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (copy) v_u_315, (ref) v_u_313, (copy) v_u_308, (copy) v_u_309, (ref) v_u_69, (ref) v_u_3, (copy) v_u_322
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "Gojo" then
									local v_u_335 = v_u_315:FindFirstChild("Right Arm")
									if v_u_335 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (copy) v_u_335, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v336 = v_u_313.Z:FindFirstChild("RedVFXFirst")
												if v336 then
													local v337 = v336:Clone()
													v337.CFrame = v_u_335.CFrame * CFrame.new(0, -1.05, 0)
													v337.Anchored = true
													v337.CanCollide = false
													v337.Transparency = 1
													v337.CastShadow = false
													v337.CanQuery = false
													v337.Parent = workspace
													v_u_308:AddItem(v337, 4)
													for _, v_u_338 in v337:GetDescendants() do
														if v_u_338:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_338
																local v339 = v_u_338:GetAttribute("EmitDelay") or 0
																task.wait(v339)
																v_u_338:Emit(v_u_338:GetAttribute("EmitCount") or v_u_338.Rate)
															end)
														end
													end
													v337.Anchored = false
													local v340 = Instance.new("WeldConstraint")
													v340.Part0 = v_u_335
													v340.Part1 = v337
													v340.Parent = v337
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v341 = v_u_313.Z:FindFirstChild("RedVFX")
												if v341 then
													local v342 = v341:Clone()
													v342.CFrame = v_u_316.CFrame * CFrame.new(0, 1, -10)
													v342.Anchored = true
													v342.CanCollide = false
													v342.Transparency = 1
													v342.CastShadow = false
													v342.CanQuery = false
													v342.Parent = workspace
													v_u_308:AddItem(v342, 3)
													for _, v_u_343 in v342:GetDescendants() do
														if v_u_343:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_343
																local v344 = v_u_343:GetAttribute("EmitDelay") or 0
																task.wait(v344)
																v_u_343:Emit(v_u_343:GetAttribute("EmitCount") or v_u_343.Rate)
															end)
														end
													end
												end
											else
												return
											end
										end)
									end
								elseif v_u_312 == "Sukuna" then
									local v_u_345 = v_u_313.Z
									if v_u_345 then
										local v346 = v_u_316.Position + Vector3.new(0, 1, 0)
										local v_u_347 = v_u_316.CFrame.LookVector
										local v348 = v_u_345:FindFirstChild("StartExplosionVFX")
										if v348 then
											local v349 = v348:Clone()
											v349.CFrame = CFrame.new(v346) * CFrame.Angles(0, 1.5707963267948966, 0)
											v349.Anchored = true
											v349.CanCollide = false
											v349.Transparency = 1
											v349.Parent = workspace
											v_u_308:AddItem(v349, 3)
											for _, v_u_350 in v349:GetDescendants() do
												task.spawn(function()
													-- upvalues: (copy) v_u_350
													if v_u_350:IsA("ParticleEmitter") then
														local v351 = v_u_350:GetAttribute("EmitDelay") or 0
														if v351 > 0 then
															task.wait(v351)
														end
														v_u_350:Emit(v_u_350:GetAttribute("EmitCount") or v_u_350.Rate)
													end
												end)
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_347, (copy) v_u_345, (ref) v_u_308, (ref) v_u_309
											if v_u_316 and v_u_316.Parent then
												local v352 = v_u_316.Position + v_u_347 * 3 + Vector3.new(0, 1, 0)
												local v353 = v_u_316.Position + v_u_347 * 65 + Vector3.new(0, 1, 0)
												local v354 = v_u_345:FindFirstChild("DismantleVFX")
												if v354 then
													local v_u_355 = v354:Clone()
													v_u_355.CFrame = CFrame.new(v352, v353)
													v_u_355.Anchored = true
													v_u_355.CanCollide = false
													v_u_355.Transparency = 1
													v_u_355.Parent = workspace
													v_u_308:AddItem(v_u_355, 2)
													for _, v356 in v_u_355:GetDescendants() do
														if v356:IsA("ParticleEmitter") then
															v356.Enabled = true
														end
													end
													v_u_309:Create(v_u_355, TweenInfo.new(1, Enum.EasingStyle.Linear), {
														["CFrame"] = CFrame.new(v353, v353 + v_u_347)
													}):Play()
													task.delay(1, function()
														-- upvalues: (copy) v_u_355
														for _, v357 in v_u_355:GetDescendants() do
															if v357:IsA("ParticleEmitter") then
																v357.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								else
									if v_u_312 == "Ragna" then
										local v358 = v_u_313.Z
										if v358 then
											local v359 = v358:FindFirstChild("DashVFX")
											local v360 = v358:FindFirstChild("SlashesVFX")
											local v361 = v_u_316.CFrame.LookVector
											local v362 = CFrame.lookAt(v_u_316.Position, v_u_316.Position + v361)
											if v359 then
												local v_u_363 = v359:Clone()
												v_u_363.CFrame = v362
												v_u_363.Anchored = false
												v_u_363.CanCollide = false
												v_u_363.Transparency = 1
												v_u_363.CastShadow = false
												v_u_363.CanQuery = false
												v_u_363.Massless = true
												v_u_363.Parent = workspace
												v_u_308:AddItem(v_u_363, 1.5)
												local v364 = Instance.new("WeldConstraint")
												v364.Part0 = v_u_316
												v364.Part1 = v_u_363
												v364.Parent = v_u_363
												for _, v365 in v_u_363:GetDescendants() do
													if v365:IsA("ParticleEmitter") then
														v365.Enabled = true
														v365:Emit(v365:GetAttribute("EmitCount") or 30)
													end
												end
												task.delay(0.5, function()
													-- upvalues: (copy) v_u_363
													if v_u_363 and v_u_363.Parent then
														for _, v366 in v_u_363:GetDescendants() do
															if v366:IsA("ParticleEmitter") then
																v366.Enabled = false
															end
														end
													end
												end)
											end
											if v360 then
												local v367 = v360:Clone()
												v367.CFrame = v362 * CFrame.new(0, 0, -20)
												v367.Anchored = true
												v367.CanCollide = false
												v367.Transparency = 1
												v367.Parent = workspace
												v_u_308:AddItem(v367, 1.5)
												for _, v_u_368 in v367:GetDescendants() do
													if v_u_368:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_368
															local v369 = v_u_368:GetAttribute("EmitDelay") or 0
															if v369 > 0 then
																task.wait(v369)
															end
															v_u_368:Emit(v_u_368:GetAttribute("EmitCount") or v_u_368.Rate)
														end)
													end
												end
												return
											end
										end
									else
										if v_u_312 == "Aizen" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_316, (ref) v_u_313, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v370 = v_u_313.Z:FindFirstChild("LightningVFX")
													if v370 then
														local v371 = v370:Clone()
														v371.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -5)
														v371.Anchored = true
														v371.CanCollide = false
														v371.Transparency = 1
														v371.CastShadow = false
														v371.CanQuery = false
														v371.Parent = workspace
														v_u_308:AddItem(v371, 3)
														for _, v_u_372 in v371:GetDescendants() do
															if v_u_372:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_372
																	local v373 = v_u_372:GetAttribute("EmitDelay") or 0.05
																	task.delay(v373, function()
																		-- upvalues: (ref) v_u_372
																		v_u_372:Emit(v_u_372:GetAttribute("EmitCount") or v_u_372.Rate)
																	end)
																end)
															end
														end
													end
													local v374 = v_u_313.Z:FindFirstChild("EnergyThrust")
													if v374 then
														local v375 = v374:Clone()
														v375.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -25)
														v375.Anchored = true
														v375.CanCollide = false
														v375.Transparency = 1
														v375.CastShadow = false
														v375.CanQuery = false
														v375.Parent = workspace
														v_u_308:AddItem(v375, 3)
														for _, v_u_376 in v375:GetDescendants() do
															if v_u_376:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_376
																	local v377 = v_u_376:GetAttribute("EmitDelay") or 0.05
																	task.delay(v377, function()
																		-- upvalues: (ref) v_u_376
																		v_u_376:Emit(v_u_376:GetAttribute("EmitCount") or v_u_376.Rate)
																	end)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_312 == "QinShi" then
											task.delay(0.4, function()
												-- upvalues: (ref) v_u_316, (ref) v_u_313, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v378 = v_u_313.Z:FindFirstChild("PunchVFX")
													if v378 then
														local v379 = v378:Clone()
														v379.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
														v379.Anchored = true
														v379.CanCollide = false
														v379.Transparency = 1
														v379.CastShadow = false
														v379.CanQuery = false
														v379.Parent = workspace
														v_u_308:AddItem(v379, 3)
														for _, v_u_380 in v379:GetDescendants() do
															if v_u_380:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_380
																	local v381 = v_u_380:GetAttribute("EmitDelay") or 0
																	task.wait(v381)
																	v_u_380:Emit(v_u_380:GetAttribute("EmitCount") or v_u_380.Rate)
																end)
															end
														end
													end
													local v382 = v_u_313.Z:FindFirstChild("EnergyThrust")
													if v382 then
														local v383 = v382:Clone()
														v383.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -25)
														v383.Anchored = true
														v383.CanCollide = false
														v383.Transparency = 1
														v383.CastShadow = false
														v383.CanQuery = false
														v383.Parent = workspace
														v_u_308:AddItem(v383, 3)
														for _, v_u_384 in v383:GetDescendants() do
															if v_u_384:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_384
																	local v385 = v_u_384:GetAttribute("EmitDelay") or 0
																	task.wait(v385)
																	v_u_384:Emit(v_u_384:GetAttribute("EmitCount") or v_u_384.Rate)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_312 == "Yuji" then
											task.delay(0.3, function()
												-- upvalues: (ref) v_u_316, (ref) v_u_313, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v386 = v_u_313.Z
													if v386 then
														local v387 = v386:FindFirstChild("SlamVFX")
														if v387 then
															local v388 = v387:Clone()
															v388:PivotTo(v_u_316.CFrame * CFrame.new(0, -1.5, -5))
															v388.Parent = workspace
															v_u_308:AddItem(v388, 3)
															for _, v389 in v388:GetDescendants() do
																if v389:IsA("BasePart") then
																	v389.Anchored = true
																	v389.CanCollide = false
																	v389.CanQuery = false
																end
															end
															for _, v_u_390 in v388:GetDescendants() do
																if v_u_390:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_390
																		local v391 = v_u_390:GetAttribute("EmitDelay") or 0
																		if v391 > 0 then
																			task.wait(v391)
																		end
																		v_u_390:Emit(v_u_390:GetAttribute("EmitCount") or v_u_390.Rate)
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
										if v_u_312 == "Alucard" then
											local v392 = v_u_69.Alucard
											if v392 and v392["Skill 1"] then
												local v393 = {
													["Caster"] = {
														["Character"] = v_u_315
													},
													["AbilityConfig"] = {}
												}
												v392["Skill 1"](v393)
												return
											end
										elseif v_u_312 == "GojoV2" then
											local v394 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v394 then
												v394 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v394 then
												local v395 = require(v394)
												if v395["Skill 1"] then
													local v396 = {
														["Caster"] = {
															["Character"] = v_u_315
														}
													}
													v395["Skill 1"](v396)
													return
												end
											end
										elseif v_u_312 == "StrongestInHistory" then
											local v397 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v397 then
												v397 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v397 then
												local v398 = require(v397)
												if v398["Skill 1"] then
													local v399 = {
														["Caster"] = {
															["Character"] = v_u_315
														}
													}
													v398["Skill 1"](v399)
													return
												end
											end
										elseif v_u_312 == "Rimuru" then
											local v400 = v_u_69.Rimuru
											if v400 and v400["Skill 1"] then
												local v401 = {
													["Caster"] = {
														["Character"] = v_u_315
													},
													["AbilityConfig"] = {}
												}
												v400["Skill 1"](v401)
												return
											end
										elseif v_u_312 == "Madoka" then
											local v402 = v_u_69.Madoka
											if v402 and v402["Skill 1"] then
												local v403 = {
													["Caster"] = {
														["Character"] = v_u_315
													}
												}
												v402["Skill 1"](v403)
												return
											end
										else
											task.wait(0.45)
											if not (v_u_316 and v_u_316.Parent) then
												return
											end
											local v404 = v_u_316.CFrame
											local v405 = v_u_313.Z:FindFirstChild("EnergyThrust")
											local v406 = v_u_313.Z:FindFirstChild("EnergyPart")
											if v405 then
												v_u_322(v405, v404 * CFrame.new(0, 2, -35), 3)
											end
											if v406 then
												v_u_322(v406, v404 * CFrame.new(0, 2, -2), 3)
											end
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_307.VFXName == "X" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (copy) v_u_315, (ref) v_u_313, (copy) v_u_308, (copy) v_u_309, (ref) v_u_69, (ref) v_u_3, (copy) p_u_307
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "Gojo" then
									local v_u_407 = v_u_315:FindFirstChild("Right Arm")
									if v_u_407 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (copy) v_u_407, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v408 = v_u_313.X:FindFirstChild("BlueVFXFirst")
												if v408 then
													local v409 = v408:Clone()
													v409.CFrame = v_u_407.CFrame * CFrame.new(0, -1.05, 0)
													v409.Anchored = true
													v409.CanCollide = false
													v409.Transparency = 1
													v409.CastShadow = false
													v409.CanQuery = false
													v409.Parent = workspace
													v_u_308:AddItem(v409, 4)
													for _, v_u_410 in v409:GetDescendants() do
														if v_u_410:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_410
																local v411 = v_u_410:GetAttribute("EmitDelay") or 0
																task.wait(v411)
																v_u_410:Emit(v_u_410:GetAttribute("EmitCount") or v_u_410.Rate)
															end)
														end
													end
													v409.Anchored = false
													local v412 = Instance.new("WeldConstraint")
													v412.Part0 = v_u_407
													v412.Part1 = v409
													v412.Parent = v409
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v413 = v_u_316.CFrame
												local v414 = v_u_313.X:FindFirstChild("BlueMainVFX")
												if v414 then
													local v415 = v414:Clone()
													v415.CFrame = v413 * CFrame.new(0, 0, -25)
													v415.Anchored = true
													v415.CanCollide = false
													v415.Transparency = 1
													v415.CastShadow = false
													v415.CanQuery = false
													v415.Parent = workspace
													v_u_308:AddItem(v415, 3)
													for _, v_u_416 in v415:GetDescendants() do
														if v_u_416:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_416
																local v417 = v_u_416:GetAttribute("EmitDelay") or 0
																task.wait(v417)
																v_u_416:Emit(v_u_416:GetAttribute("EmitCount") or v_u_416.Rate)
															end)
														end
													end
												end
												local v418 = v_u_313.X:FindFirstChild("Blue_Additional_VFX")
												if v418 then
													local v419 = v418:Clone()
													v419.CFrame = v413 * CFrame.new(0, 0, -5)
													v419.Anchored = true
													v419.CanCollide = false
													v419.Transparency = 1
													v419.CastShadow = false
													v419.CanQuery = false
													v419.Parent = workspace
													v_u_308:AddItem(v419, 4)
													for _, v_u_420 in v419:GetDescendants() do
														if v_u_420:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_420
																local v421 = v_u_420:GetAttribute("EmitDelay") or 0
																task.wait(v421)
																v_u_420:Emit(v_u_420:GetAttribute("EmitCount") or v_u_420.Rate)
															end)
														end
													end
												end
											end
										end)
									end
								else
									if v_u_312 == "Sukuna" then
										local v422 = v_u_313.X
										if not v422 then
											return
										end
										local v423 = v422:FindFirstChild("GroundVFX")
										if v423 then
											local v_u_424 = v423:Clone()
											v_u_424:PivotTo(v_u_316.CFrame * CFrame.new(0, -2.5, 0))
											v_u_424.Parent = workspace
											v_u_308:AddItem(v_u_424, 3.5)
											local v425 = v_u_424.PrimaryPart or v_u_424:FindFirstChildWhichIsA("BasePart")
											for _, v426 in v_u_424:GetDescendants() do
												if v426:IsA("BasePart") then
													v426.Anchored = false
													v426.CanCollide = false
													v426.CanQuery = false
													v426.CanTouch = false
													v426.Massless = true
												end
											end
											if v425 then
												local v427 = Instance.new("WeldConstraint")
												v427.Part0 = v_u_316
												v427.Part1 = v425
												v427.Parent = v425
											end
											task.delay(2.6, function()
												-- upvalues: (copy) v_u_424
												if v_u_424 and v_u_424.Parent then
													for _, v428 in v_u_424:GetDescendants() do
														if v428:IsA("ParticleEmitter") then
															v428.Enabled = false
														end
													end
												end
											end)
											return
										end
									elseif v_u_312 == "Jinwoo" then
										local v429 = v_u_313.X
										if not v429 then
											return
										end
										local v430 = v429:FindFirstChild("DashVFX")
										local v431 = v429:FindFirstChild("SlashesVFX")
										local v432 = v_u_316.CFrame.LookVector
										local v433 = CFrame.lookAt(v_u_316.Position, v_u_316.Position + v432)
										if v430 then
											local v_u_434 = v430:Clone()
											v_u_434.CFrame = v433
											v_u_434.Anchored = false
											v_u_434.CanCollide = false
											v_u_434.Transparency = 1
											v_u_434.CastShadow = false
											v_u_434.CanQuery = false
											v_u_434.Massless = true
											v_u_434.Parent = workspace
											v_u_308:AddItem(v_u_434, 1.5)
											local v435 = Instance.new("WeldConstraint")
											v435.Part0 = v_u_316
											v435.Part1 = v_u_434
											v435.Parent = v_u_434
											for _, v436 in v_u_434:GetDescendants() do
												if v436:IsA("ParticleEmitter") then
													v436.Enabled = true
													v436:Emit(v436:GetAttribute("EmitCount") or 30)
												end
											end
											task.delay(0.5, function()
												-- upvalues: (copy) v_u_434
												if v_u_434 and v_u_434.Parent then
													for _, v437 in v_u_434:GetDescendants() do
														if v437:IsA("ParticleEmitter") then
															v437.Enabled = false
														end
													end
												end
											end)
										end
										if v431 then
											local v438 = v431:Clone()
											v438.CFrame = v433 * CFrame.new(0, 0, -20)
											v438.Anchored = true
											v438.CanCollide = false
											v438.Transparency = 1
											v438.CastShadow = false
											v438.CanQuery = false
											v438.Parent = workspace
											v_u_308:AddItem(v438, 1.5)
											for _, v_u_439 in v438:GetDescendants() do
												if v_u_439:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_439
														local v440 = v_u_439:GetAttribute("EmitDelay") or 0
														if v440 > 0 then
															task.wait(v440)
														end
														v_u_439:Emit(v_u_439:GetAttribute("EmitCount") or v_u_439.Rate)
													end)
												end
											end
											return
										end
									elseif v_u_312 == "Ragna" then
										local v_u_441 = v_u_313.X
										if v_u_441 then
											local v442 = v_u_441:FindFirstChild("GroundVFX")
											if v442 then
												local v443 = v442:Clone()
												v443.CFrame = v_u_316.CFrame * CFrame.new(0, -2.5, 0)
												v443.Anchored = true
												v443.CanCollide = false
												v443.Transparency = 1
												v443.Parent = workspace
												v_u_308:AddItem(v443, 5)
												for _, v_u_444 in v443:GetDescendants() do
													if v_u_444:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_444
															local v445 = v_u_444:GetAttribute("EmitDelay") or 0
															if v445 > 0 then
																task.wait(v445)
															end
															v_u_444:Emit(v_u_444:GetAttribute("EmitCount") or v_u_444.Rate)
														end)
													end
												end
											end
											local v446 = v_u_441:FindFirstChild("ChargeVFX")
											if v446 then
												local v_u_447 = v446:Clone()
												v_u_447.CFrame = v_u_316.CFrame
												v_u_447.Anchored = false
												v_u_447.CanCollide = false
												v_u_447.Transparency = 1
												v_u_447.Massless = true
												v_u_447.Parent = workspace
												v_u_308:AddItem(v_u_447, 1.3)
												local v448 = Instance.new("WeldConstraint")
												v448.Part0 = v_u_316
												v448.Part1 = v_u_447
												v448.Parent = v_u_447
												for _, v449 in v_u_447:GetDescendants() do
													if v449:IsA("ParticleEmitter") then
														v449.Enabled = true
													end
												end
												task.delay(0.4, function()
													-- upvalues: (copy) v_u_447
													if v_u_447 and v_u_447.Parent then
														for _, v450 in v_u_447:GetDescendants() do
															if v450:IsA("ParticleEmitter") then
																v450.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(0.44999999999999996, function()
												-- upvalues: (ref) v_u_316, (copy) v_u_441, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v451 = v_u_441:FindFirstChild("BarrageVFX")
													if v451 then
														local v_u_452 = v451:Clone()
														v_u_452.CFrame = v_u_316.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_452.Anchored = true
														v_u_452.CanCollide = false
														v_u_452.Transparency = 1
														v_u_452.Parent = workspace
														v_u_308:AddItem(v_u_452, 2.9)
														for _, v453 in v_u_452:GetDescendants() do
															if v453:IsA("ParticleEmitter") then
																v453.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_452
															if v_u_452 and v_u_452.Parent then
																for _, v454 in v_u_452:GetDescendants() do
																	if v454:IsA("ParticleEmitter") then
																		v454.Enabled = false
																	end
																end
															end
														end)
													end
													local v455 = v_u_441:FindFirstChild("BarrageGroundVFX")
													if v455 then
														local v_u_456 = v455:Clone()
														v_u_456.CFrame = v_u_316.CFrame * CFrame.new(0, -37.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_456.Anchored = true
														v_u_456.CanCollide = false
														v_u_456.Transparency = 1
														v_u_456.Parent = workspace
														v_u_308:AddItem(v_u_456, 2.7)
														for _, v457 in v_u_456:GetDescendants() do
															if v457:IsA("ParticleEmitter") then
																v457.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_456
															if v_u_456 and v_u_456.Parent then
																for _, v458 in v_u_456:GetDescendants() do
																	if v458:IsA("ParticleEmitter") then
																		v458.Enabled = false
																	end
																end
															end
														end)
													end
												end
											end)
											task.delay(2, function()
												-- upvalues: (ref) v_u_316, (copy) v_u_441, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v459 = v_u_441:FindFirstChild("ChargeVFX")
													if v459 then
														local v_u_460 = v459:Clone()
														v_u_460.CFrame = v_u_316.CFrame
														v_u_460.Anchored = false
														v_u_460.CanCollide = false
														v_u_460.Transparency = 1
														v_u_460.Massless = true
														v_u_460.Parent = workspace
														v_u_308:AddItem(v_u_460, 1)
														local v461 = Instance.new("WeldConstraint")
														v461.Part0 = v_u_316
														v461.Part1 = v_u_460
														v461.Parent = v_u_460
														for _, v462 in v_u_460:GetDescendants() do
															if v462:IsA("ParticleEmitter") then
																v462.Enabled = true
															end
														end
														task.delay(0.6, function()
															-- upvalues: (copy) v_u_460
															if v_u_460 and v_u_460.Parent then
																for _, v463 in v_u_460:GetDescendants() do
																	if v463:IsA("ParticleEmitter") then
																		v463.Enabled = false
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
										if v_u_312 == "Aizen" then
											local v464 = v_u_313.X:FindFirstChild("BarrageVFX")
											if v464 then
												local v_u_465 = v464:Clone()
												v_u_465.CFrame = v_u_316.CFrame * CFrame.new(0, 4, -15)
												v_u_465.Anchored = false
												v_u_465.CanCollide = false
												v_u_465.Transparency = 1
												v_u_465.CastShadow = false
												v_u_465.CanQuery = false
												v_u_465.Massless = true
												v_u_465.Parent = workspace
												v_u_308:AddItem(v_u_465, 3.7)
												local v466 = Instance.new("WeldConstraint")
												v466.Part0 = v_u_316
												v466.Part1 = v_u_465
												v466.Parent = v_u_465
												for _, v467 in v_u_465:GetDescendants() do
													if v467:IsA("ParticleEmitter") or (v467:IsA("Beam") or v467:IsA("Trail")) then
														v467.Enabled = true
													end
												end
												task.delay(1.7, function()
													-- upvalues: (copy) v_u_465
													if v_u_465 and v_u_465.Parent then
														for _, v468 in v_u_465:GetDescendants() do
															if v468:IsA("ParticleEmitter") or (v468:IsA("Beam") or v468:IsA("Trail")) then
																v468.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(1.9, function()
												-- upvalues: (ref) v_u_316, (ref) v_u_313, (ref) v_u_308, (ref) v_u_309
												if not (v_u_316 and v_u_316.Parent) then
													return
												end
												local v469 = { 0, 0 }
												local v470 = {
													{ 180, 180, 135 },
													{ 180, 180, 45 }
												}
												for v471 = 1, 2 do
													if not (v_u_316 and v_u_316.Parent) then
														break
													end
													local v472 = v469[v471]
													local v473 = v470[v471][1]
													local v474 = v470[v471][2]
													local v475 = v470[v471][3]
													local v476 = v_u_316.CFrame * CFrame.Angles(0, math.rad(v472), 0)
													local v477 = v476.Position
													local v478 = v477 + v476.LookVector * 80
													local v479 = CFrame.Angles(math.rad(v473), math.rad(v474), (math.rad(v475)))
													local v480 = CFrame.lookAt(v477, v478) * v479
													local v481 = CFrame.lookAt(v478, v478 + v476.LookVector) * v479
													local v482 = v_u_313.X:FindFirstChild("StartVFX")
													if v482 then
														local v483 = v482:Clone()
														v483.CFrame = v480
														v483.Anchored = true
														v483.CanCollide = false
														v483.Transparency = 1
														v483.Parent = workspace
														v_u_308:AddItem(v483, 2)
														for _, v484 in v483:GetDescendants() do
															if v484:IsA("ParticleEmitter") then
																v484:Emit(v484:GetAttribute("EmitCount") or v484.Rate)
															end
														end
													end
													local v485 = v_u_313.X:FindFirstChild("SlashVFX")
													if v485 then
														local v_u_486 = v485:Clone()
														v_u_486.CFrame = v480
														v_u_486.Anchored = true
														v_u_486.CanCollide = false
														v_u_486.Transparency = 1
														v_u_486.Parent = workspace
														v_u_308:AddItem(v_u_486, 3)
														for _, v487 in v_u_486:GetDescendants() do
															if v487:IsA("ParticleEmitter") or (v487:IsA("Beam") or v487:IsA("Trail")) then
																v487.Enabled = true
															end
														end
														local v488 = v_u_309:Create(v_u_486, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															["CFrame"] = v481
														})
														v488:Play()
														v488.Completed:Connect(function()
															-- upvalues: (copy) v_u_486
															for _, v489 in v_u_486:GetDescendants() do
																if v489:IsA("ParticleEmitter") or (v489:IsA("Beam") or v489:IsA("Trail")) then
																	v489.Enabled = false
																end
															end
														end)
													end
													if v471 < 2 then
														task.wait(0.3)
													end
												end
											end)
											return
										end
										if v_u_312 == "QinShi" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_316, (ref) v_u_313, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v490 = v_u_313:FindFirstChild("X")
													if v490 then
														local v491 = v490:FindFirstChild("StompVFX")
														if v491 then
															local v492 = v_u_316.Position - Vector3.new(0, 2.5, 0)
															local v493 = v491:Clone()
															local v494 = v493:FindFirstChild("Main")
															local v495 = v493:FindFirstChild("Lightning")
															if v494 then
																v494.CFrame = CFrame.new(v492)
																v494.Anchored = true
																v494.CanCollide = false
																v494.Transparency = 1
															end
															if v495 then
																v495.CFrame = CFrame.new(v492 + Vector3.new(0, 13, 0))
																v495.Anchored = true
																v495.CanCollide = false
																v495.Transparency = 1
															end
															v493.Parent = workspace
															v_u_308:AddItem(v493, 3)
															for _, v_u_496 in v493:GetDescendants() do
																if v_u_496:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_496
																		local v497 = v_u_496:GetAttribute("EmitDelay") or 0
																		task.wait(v497)
																		v_u_496:Emit(v_u_496:GetAttribute("EmitCount") or v_u_496.Rate)
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
										if v_u_312 == "Yuji" then
											local v498 = v_u_313.X
											local v499 = v498 and v498:FindFirstChild("BarrageVFX")
											if v499 then
												local v_u_500 = v499:Clone()
												v_u_500.CFrame = v_u_316.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, -1.5707963267948966, 0)
												v_u_500.Anchored = false
												v_u_500.CanCollide = false
												v_u_500.Transparency = 1
												v_u_500.CastShadow = false
												v_u_500.CanQuery = false
												v_u_500.Massless = true
												v_u_500.Parent = workspace
												v_u_308:AddItem(v_u_500, 4)
												local v501 = Instance.new("WeldConstraint")
												v501.Part0 = v_u_316
												v501.Part1 = v_u_500
												v501.Parent = v_u_500
												for _, v502 in v_u_500:GetDescendants() do
													if v502:IsA("ParticleEmitter") then
														v502.Enabled = true
													end
												end
												task.delay(3.2, function()
													-- upvalues: (copy) v_u_500
													if v_u_500 and v_u_500.Parent then
														for _, v503 in v_u_500:GetDescendants() do
															if v503:IsA("ParticleEmitter") then
																v503.Enabled = false
															end
														end
													end
												end)
												return
											end
										elseif v_u_312 == "Alucard" then
											local v504 = v_u_69.Alucard
											if v504 and v504["Skill 2"] then
												local v505 = {
													["Caster"] = {
														["Character"] = v_u_315
													},
													["AbilityConfig"] = {}
												}
												v504["Skill 2"](v505)
												return
											end
										elseif v_u_312 == "GojoV2" then
											local v506 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v506 then
												v506 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v506 then
												local v507 = require(v506)
												if v507["Skill 2"] then
													v507["Skill 2"]({
														["Caster"] = {
															["Character"] = v_u_315
														},
														["Duration"] = p_u_307.Duration or 6
													})
													return
												end
											end
										elseif v_u_312 == "StrongestInHistory" then
											local v508 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v508 then
												v508 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v508 then
												local v509 = require(v508)
												if v509["Skill 2"] then
													local v510 = {
														["Caster"] = {
															["Character"] = v_u_315
														}
													}
													v509["Skill 2"](v510)
													return
												end
											end
										elseif v_u_312 == "Ichigo" then
											local v511 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v511 then
												v511 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("Ichigo")
											end
											if v511 then
												local v512 = require(v511)
												if v512 and v512["Skill 2"] then
													local v513 = {
														["Caster"] = {
															["Character"] = v_u_315
														},
														["Duration"] = 4
													}
													v512["Skill 2"](v513)
													return
												end
											end
										elseif v_u_312 == "Rimuru" then
											local v514 = v_u_69.Rimuru
											if v514 and v514["Skill 2"] then
												local v515 = {
													["Caster"] = {
														["Character"] = v_u_315
													},
													["AbilityConfig"] = {}
												}
												v514["Skill 2"](v515)
												return
											end
										else
											task.wait(0.35)
											if not (v_u_316 and v_u_316.Parent) then
												return
											end
											local v516 = v_u_316.CFrame
											local v517 = v_u_313.X:FindFirstChild("EnergySlashes")
											if not v517 then
												return
											end
											local v_u_518 = v517:Clone()
											v_u_518.CFrame = v516 * CFrame.new(0, 1.5, -20)
											v_u_518.Anchored = false
											v_u_518.CanCollide = false
											v_u_518.Transparency = 1
											v_u_518.CastShadow = false
											v_u_518.CanQuery = false
											v_u_518.Massless = true
											v_u_518.Parent = workspace
											v_u_308:AddItem(v_u_518, 4)
											local v519 = Instance.new("WeldConstraint")
											v519.Part0 = v_u_518
											v519.Part1 = v_u_316
											v519.Parent = v_u_518
											v_u_308:AddItem(v519, 2.06)
											task.delay(2.05, function()
												-- upvalues: (copy) v_u_518
												for _, v520 in v_u_518:GetDescendants() do
													if v520:IsA("ParticleEmitter") then
														v520.Enabled = false
													end
												end
												v_u_518.Anchored = true
											end)
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_307.VFXName == "C" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (ref) v_u_3, (copy) v_u_315, (copy) p_u_307, (ref) v_u_313, (copy) v_u_308, (copy) v_u_328, (copy) v_u_334
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "GojoV2" then
									local v521 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v521 then
										v521 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v521 then
										local v522 = require(v521)
										if v522["Skill 3"] then
											local v523 = v522["Skill 3"]
											local v524 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["Duration"] = p_u_307.Duration or 6
											}
											v523(v524)
										end
									end
									return
								elseif v_u_312 == "StrongestInHistory" then
									local v525 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v525 then
										v525 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v525 then
										local v_u_526 = require(v525)
										if v_u_526["Skill 3"] then
											local v527 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["ChargeTime"] = 2.5
											}
											v_u_526["Skill 3"](v527)
										end
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_526, (ref) v_u_315
											if v_u_316 and v_u_316.Parent then
												local v528 = v_u_316.Position + v_u_316.CFrame.LookVector * 85
												if v_u_526["Skill 3"] then
													local v529 = v_u_526["Skill 3"]
													local v530 = {
														["Caster"] = {
															["Character"] = v_u_315
														},
														["Phase"] = "Explosion",
														["Position"] = v528,
														["CFrame"] = CFrame.new(v528),
														["DOTDuration"] = 3.5
													}
													v529(v530)
												end
											end
										end)
									end
									return
								elseif v_u_312 == "Gojo" then
									local v531 = v_u_313.C:FindFirstChild("DamageVFX")
									if v531 then
										local v532 = v531:Clone()
										v532.CFrame = v_u_316.CFrame
										v532.Anchored = false
										v532.CanCollide = false
										v532.Transparency = 1
										v532.Massless = true
										v532.Parent = workspace
										local v533 = Instance.new("WeldConstraint")
										v533.Part0 = v532
										v533.Part1 = v_u_316
										v533.Parent = v532
										for _, v534 in v532:GetDescendants() do
											if v534:IsA("ParticleEmitter") then
												v534:Emit(v534:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_308:AddItem(v532, 3)
									end
									return
								elseif v_u_312 == "Jinwoo" then
									local v535 = v_u_313.C
									if v535 then
										local v536 = v535:FindFirstChild("EnergySlashes")
										local v537 = v535:FindFirstChild("ShadowVFX")
										if v536 then
											local v_u_538 = v536:Clone()
											v_u_538.CFrame = v_u_316.CFrame * CFrame.new(0, 3.9, 0)
											v_u_538.Anchored = false
											v_u_538.CanCollide = false
											v_u_538.Transparency = 1
											v_u_538.CastShadow = false
											v_u_538.CanQuery = false
											v_u_538.Massless = true
											v_u_538.Parent = workspace
											v_u_308:AddItem(v_u_538, 3.65)
											local v539 = Instance.new("WeldConstraint")
											v539.Part0 = v_u_316
											v539.Part1 = v_u_538
											v539.Parent = v_u_538
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_538
												if v_u_538 and v_u_538.Parent then
													for _, v540 in v_u_538:GetDescendants() do
														if v540:IsA("ParticleEmitter") then
															v540:Emit(v540:GetAttribute("EmitCount") or v540.Rate)
															v540.Enabled = false
														end
													end
												end
											end)
										end
										if v537 then
											local v_u_541 = v537:Clone()
											v_u_541.CFrame = v_u_316.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_541.Anchored = false
											v_u_541.CanCollide = false
											v_u_541.Transparency = 1
											v_u_541.CastShadow = false
											v_u_541.CanQuery = false
											v_u_541.Massless = true
											v_u_541.Parent = workspace
											v_u_308:AddItem(v_u_541, 2.65)
											local v542 = Instance.new("WeldConstraint")
											v542.Part0 = v_u_316
											v542.Part1 = v_u_541
											v542.Parent = v_u_541
											for _, v_u_543 in v_u_541:GetDescendants() do
												if v_u_543:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_543
														local v544 = v_u_543:GetAttribute("EmitDelay") or 0
														if v544 > 0 then
															task.wait(v544)
														end
														v_u_543:Emit(v_u_543:GetAttribute("EmitCount") or v_u_543.Rate)
													end)
												end
											end
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_541
												if v_u_541 and v_u_541.Parent then
													for _, v545 in v_u_541:GetDescendants() do
														if v545:IsA("ParticleEmitter") then
															v545.Enabled = false
														end
													end
												end
											end)
										end
									end
								elseif v_u_312 == "Ragna" then
									local v546 = v_u_313.C
									if v546 then
										local v_u_547 = v546:FindFirstChild("Sword")
										local v_u_548 = v546:FindFirstChild("StartVFX")
										local v_u_549 = v546:FindFirstChild("ExpVFX")
										if v_u_547 then
											local v_u_550 = {}
											local v_u_551 = {}
											for _ = 1, 6 do
												local v552 = 4 + math.random() * 4
												local v553 = (math.random() - 0.5) * 2 * 6
												local v554 = -(3 + math.random() * 3)
												local v555 = {
													["offset"] = Vector3.new(v553, v552, v554)
												}
												table.insert(v_u_550, v555)
											end
											local v_u_556 = 0
											task.spawn(function()
												-- upvalues: (ref) v_u_556, (ref) v_u_316, (copy) v_u_550, (copy) v_u_547, (ref) v_u_308, (copy) v_u_548, (copy) v_u_551
												while v_u_556 < 6 and (v_u_316 and v_u_316.Parent) do
													local v557 = 6 - v_u_556
													local v558 = math.min(2, v557)
													for v559 = 1, v558 do
														local v560 = v_u_550[v_u_556 + v559]
														local v561 = v_u_316.CFrame
														local v562 = v561:VectorToWorldSpace(v560.offset)
														local v563 = v561.Position + v562
														local v564 = v_u_547:Clone()
														v564.CFrame = CFrame.new(v563) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v564.Anchored = true
														v564.CanCollide = false
														v564.CanQuery = false
														v564.Transparency = 0
														v564.Parent = workspace
														v_u_308:AddItem(v564, 3)
														if v_u_548 then
															local v565 = v_u_548:Clone()
															v565.CFrame = v564.CFrame
															v565.Anchored = true
															v565.CanCollide = false
															v565.Transparency = 1
															v565.Parent = workspace
															v_u_308:AddItem(v565, 1)
															for _, v566 in v565:GetDescendants() do
																if v566:IsA("ParticleEmitter") then
																	v566:Emit(v566:GetAttribute("EmitCount") or 20)
																end
															end
														end
														local v567 = v_u_551
														table.insert(v567, {
															["sword"] = v564,
															["spawnData"] = v560
														})
													end
													v_u_556 = v_u_556 + v558
													task.wait(0.25)
												end
											end)
											local v568 = game:GetService("RunService")
											local v_u_569 = nil
											v_u_569 = v568.Heartbeat:Connect(function()
												-- upvalues: (ref) v_u_316, (ref) v_u_569, (copy) v_u_551
												if v_u_316 and v_u_316.Parent then
													local v570 = (1 / 0)
													local v571 = nil
													for _, v572 in ipairs(game.Players:GetPlayers()) do
														if v572.Character and v572.Character:FindFirstChild("HumanoidRootPart") then
															local v573 = v572.Character.HumanoidRootPart
															local v574 = (v573.Position - v_u_316.Position).Magnitude
															if v574 < v570 and v574 < 150 then
																v571 = v573.Position
																v570 = v574
															end
														end
													end
													for _, v575 in ipairs(v_u_551) do
														local v576 = v575.sword
														if v576 and (v576.Parent and not v575.launched) then
															local v577 = v576.Position
															local v578
															if v571 then
																local v579 = v571 - v577
																if v579.Magnitude > 0.1 then
																	local v580 = v579.Unit
																	v578 = CFrame.lookAt(v577, v577 + v580) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793)
																else
																	v578 = CFrame.new(v577) * CFrame.Angles(1.5707963267948966, 0, 0)
																end
															else
																v578 = CFrame.new(v577) * v_u_316.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v576.CFrame = v576.CFrame:Lerp(v578, 0.12)
														end
													end
												elseif v_u_569 then
													v_u_569:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_569, (ref) v_u_316, (copy) v_u_551, (copy) v_u_549, (ref) v_u_308
												if v_u_569 then
													v_u_569:Disconnect()
												end
												if v_u_316 and v_u_316.Parent then
													local v581 = v_u_316.Position + v_u_316.CFrame.LookVector * 30
													local v582 = (1 / 0)
													for _, v583 in ipairs(game.Players:GetPlayers()) do
														if v583.Character and v583.Character:FindFirstChild("HumanoidRootPart") then
															local v584 = v583.Character.HumanoidRootPart
															local v585 = (v584.Position - v_u_316.Position).Magnitude
															if v585 < v582 and v585 < 150 then
																v581 = v584.Position
																v582 = v585
															end
														end
													end
													local v_u_586 = CFrame.new(v581)
													for v587, v_u_588 in ipairs(v_u_551) do
														task.delay((v587 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_588, (copy) v_u_586, (ref) v_u_549, (ref) v_u_308
															local v_u_589 = v_u_588.sword
															if v_u_589 and v_u_589.Parent then
																v_u_588.launched = true
																local v_u_590 = v_u_589.Position
																local v591 = v_u_586.Position
																local v592 = math.random(-8, 8)
																local v593 = math.random
																local v_u_594 = v591 + Vector3.new(v592, 0, v593(-8, 8))
																local v595 = (v_u_590 + v_u_594) / 2
																local v596 = math.random(-60, 60)
																local v597 = math.rad(v596)
																local v598 = 12 + math.random() * 5
																local v599 = math.sin(v597) * 5
																local v600 = math.cos(v597) * 5
																local v_u_601 = v595 + Vector3.new(v599, v598, v600)
																local v_u_602 = tick()
																task.spawn(function()
																	-- upvalues: (copy) v_u_602, (copy) v_u_590, (copy) v_u_601, (copy) v_u_594, (copy) v_u_589, (ref) v_u_549, (ref) v_u_308
																	while tick() - v_u_602 < 0.4 do
																		local v603 = (tick() - v_u_602) / 0.4
																		local v604 = v_u_590
																		local v605 = v_u_601
																		local v606 = v_u_594
																		local v607 = 1 - v603
																		local v608 = v607 * v607 * v604 + 2 * v607 * v603 * v605 + v603 * v603 * v606
																		local v609 = v603 + 0.05
																		local v610 = math.min(v609, 1)
																		local v611 = v_u_590
																		local v612 = v_u_601
																		local v613 = v_u_594
																		local v614 = 1 - v610
																		local v615 = v614 * v614 * v611 + 2 * v614 * v610 * v612 + v610 * v610 * v613 - v608
																		if v_u_589 and (v_u_589.Parent and v615.Magnitude > 0.01) then
																			v_u_589.CFrame = CFrame.lookAt(v608, v608 + v615.Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
																		end
																		task.wait()
																	end
																	if v_u_549 and (v_u_589 and v_u_589.Parent) then
																		local v616 = v_u_549:Clone()
																		v616.CFrame = CFrame.new(v_u_594)
																		v616.Anchored = true
																		v616.CanCollide = false
																		v616.Transparency = 1
																		v616.Parent = workspace
																		v_u_308:AddItem(v616, 1.5)
																		for _, v617 in v616:GetDescendants() do
																			if v617:IsA("ParticleEmitter") then
																				v617:Emit(v617:GetAttribute("EmitCount") or 30)
																			end
																		end
																	end
																	if v_u_589 and v_u_589.Parent then
																		v_u_589:Destroy()
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
								elseif v_u_312 == "Aizen" then
									local v_u_618 = v_u_313.C
									if v_u_618 then
										local v_u_619 = {}
										local function v_u_625(p620, p621)
											-- upvalues: (ref) v_u_316, (ref) v_u_308
											if not p620 then
												return nil
											end
											local v622 = p620:Clone()
											v622.CFrame = v_u_316.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v622.Anchored = false
											v622.CanCollide = false
											v622.Transparency = 1
											v622.CastShadow = false
											v622.CanQuery = false
											v622.Massless = true
											v622.Parent = workspace
											v_u_308:AddItem(v622, p621)
											local v623 = Instance.new("WeldConstraint")
											v623.Part0 = v_u_316
											v623.Part1 = v622
											v623.Parent = v622
											for _, v624 in v622:GetDescendants() do
												if v624:IsA("ParticleEmitter") or (v624:IsA("Beam") or v624:IsA("Trail")) then
													v624.Enabled = true
												end
											end
											return v622
										end
										local v626 = v_u_625(v_u_618:FindFirstChild("ChargeVFX"), 4)
										if v626 then
											table.insert(v_u_619, v626)
										end
										local v627 = v_u_625(v_u_618:FindFirstChild("AuraVFX1"), 4)
										if v627 then
											table.insert(v_u_619, v627)
										end
										task.delay(0.25, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_625, (copy) v_u_618, (copy) v_u_619
											if v_u_316 and v_u_316.Parent then
												local v628 = v_u_625(v_u_618:FindFirstChild("AuraVFX2"), 3.75)
												if v628 then
													local v629 = v_u_619
													table.insert(v629, v628)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_625, (copy) v_u_618, (copy) v_u_619
											if v_u_316 and v_u_316.Parent then
												local v630 = v_u_625(v_u_618:FindFirstChild("AuraVFX3"), 3.5)
												if v630 then
													local v631 = v_u_619
													table.insert(v631, v630)
												end
											end
										end)
										task.delay(3, function()
											-- upvalues: (copy) v_u_619
											for _, v632 in pairs(v_u_619) do
												if v632 and v632.Parent then
													for _, v633 in v632:GetDescendants() do
														if v633:IsA("ParticleEmitter") or (v633:IsA("Beam") or v633:IsA("Trail")) then
															v633.Enabled = false
														end
													end
												end
											end
										end)
									end
								elseif v_u_312 == "Rimuru" then
									return
								else
									local v634 = v_u_313.C:FindFirstChild("FirstEffects")
									if v634 then
										local v_u_635 = v634:Clone()
										for _, v636 in v_u_635:GetDescendants() do
											if v636:IsA("BasePart") then
												v636.Anchored = true
												v636.CanCollide = false
												v636.CanQuery = false
												v636.CanTouch = false
												v636.CastShadow = false
												v636.Transparency = 1
											end
										end
										v_u_635:PivotTo(v_u_316.CFrame * CFrame.new(0, -2, 0))
										v_u_635.Parent = workspace
										v_u_308:AddItem(v_u_635, 6)
										task.delay(4.85, function()
											-- upvalues: (copy) v_u_635
											for _, v637 in v_u_635:GetDescendants() do
												if v637:IsA("ParticleEmitter") then
													v637.Enabled = false
												end
											end
										end)
									end
									task.wait(3.85)
									if v_u_316 and v_u_316.Parent then
										local v_u_638 = v_u_316.CFrame
										local v639 = v_u_313.C:FindFirstChild("HorizontalBeam")
										if v639 then
											local v640 = v639:Clone()
											for _, v641 in v640:GetDescendants() do
												if v641:IsA("BasePart") then
													v641.Anchored = true
													v641.CanCollide = false
													v641.CanQuery = false
													v641.CanTouch = false
													v641.CastShadow = false
													v641.Massless = true
													v641.Transparency = 1
												end
												if v641:IsA("Beam") then
													v641.Enabled = false
												end
											end
											v640:PivotTo(v_u_638 * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0))
											v640.Parent = workspace
											v_u_308:AddItem(v640, 6)
											local v642 = {
												["BigBeam1"] = 0,
												["BigBeam2"] = 0.25,
												["BigBeams3"] = 0.5
											}
											local v643 = {
												["BigBeam1"] = 0.36,
												["BigBeam2"] = 0.61,
												["BigBeams3"] = 0.76
											}
											for _, v_u_644 in v640:GetChildren() do
												if v_u_644:IsA("Model") then
													local v_u_645 = v_u_644:FindFirstChild("Beam")
													local v646 = v642[v_u_644.Name] or 0
													local v647 = v643[v_u_644.Name] or 2
													task.delay(v646, function()
														-- upvalues: (copy) v_u_645, (ref) v_u_328, (copy) v_u_644
														if v_u_645 then
															v_u_328(v_u_645, 0.3)
														end
														for _, v648 in v_u_644:GetDescendants() do
															if v648:IsA("ParticleEmitter") and not (v_u_645 and v648:IsDescendantOf(v_u_645)) then
																v648:Emit(v648:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v647, function()
														-- upvalues: (copy) v_u_645, (ref) v_u_334
														if v_u_645 then
															v_u_334(v_u_645, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (copy) v_u_638, (ref) v_u_308, (ref) v_u_334
											if v_u_316 and v_u_316.Parent then
												local v649 = v_u_313.C:FindFirstChild("Explosion")
												if v649 then
													local v_u_650 = v649:Clone()
													for _, v651 in v_u_650:GetDescendants() do
														if v651:IsA("BasePart") then
															v651.Anchored = true
															v651.CanCollide = false
															v651.CanQuery = false
															v651.CanTouch = false
															v651.CastShadow = false
															v651.Transparency = 1
														end
													end
													v_u_650:PivotTo(v_u_638 * CFrame.new(0, 8, -75) * CFrame.Angles(0, 0, 1.5707963267948966))
													v_u_650.Parent = workspace
													v_u_308:AddItem(v_u_650, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_334, (copy) v_u_650
														v_u_334(v_u_650, 0.5)
														for _, v652 in v_u_650:GetDescendants() do
															if v652:IsA("ParticleEmitter") then
																v652.Enabled = false
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
						if v_u_312 == "QinShi" then
							task.spawn(function()
								-- upvalues: (copy) v_u_316, (ref) v_u_313, (copy) v_u_308
								if v_u_316 and v_u_316.Parent then
									local v653 = v_u_313:FindFirstChild("C")
									if v653 then
										local v654 = v653:FindFirstChild("BarrageVFX")
										if v654 then
											local v_u_655 = v654:Clone()
											v_u_655.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_655.Anchored = false
											v_u_655.CanCollide = false
											v_u_655.CanQuery = false
											v_u_655.CanTouch = false
											v_u_655.Transparency = 1
											v_u_655.CastShadow = false
											v_u_655.Parent = workspace
											local v656 = Instance.new("WeldConstraint")
											v656.Part0 = v_u_655
											v656.Part1 = v_u_316
											v656.Parent = v_u_655
											for _, v657 in v_u_655:GetDescendants() do
												if v657:IsA("ParticleEmitter") then
													v657.Enabled = true
												end
											end
											task.delay(3, function()
												-- upvalues: (copy) v_u_655
												if v_u_655 and v_u_655.Parent then
													for _, v658 in v_u_655:GetDescendants() do
														if v658:IsA("ParticleEmitter") then
															v658.Enabled = false
														end
													end
												end
											end)
											v_u_308:AddItem(v_u_655, 4)
										end
									end
								else
									return
								end
							end)
						end
						if v_u_312 == "Yuji" then
							task.spawn(function()
								-- upvalues: (copy) v_u_316, (ref) v_u_313, (copy) v_u_308
								if v_u_316 and v_u_316.Parent then
									local v_u_659 = v_u_313:FindFirstChild("C")
									if v_u_659 then
										local v660 = v_u_659:FindFirstChild("AuraVFX3")
										if v660 then
											local v_u_661 = v660:Clone()
											v_u_661.CFrame = v_u_316.CFrame
											v_u_661.Anchored = false
											v_u_661.CanCollide = false
											v_u_661.Transparency = 1
											v_u_661.Massless = true
											v_u_661.Parent = workspace
											local v662 = Instance.new("WeldConstraint")
											v662.Part0 = v_u_316
											v662.Part1 = v_u_661
											v662.Parent = v_u_661
											for _, v663 in v_u_661:GetDescendants() do
												if v663:IsA("ParticleEmitter") then
													v663.Enabled = true
												end
											end
											task.delay(0.8, function()
												-- upvalues: (copy) v_u_661
												if v_u_661 and v_u_661.Parent then
													for _, v664 in v_u_661:GetDescendants() do
														if v664:IsA("ParticleEmitter") then
															v664.Enabled = false
														end
													end
												end
											end)
											v_u_308:AddItem(v_u_661, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_659, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v665 = v_u_659:FindFirstChild("BlackFlashVFX3")
												if v665 then
													local v666 = v665:Clone()
													v666.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -10)
													v666.Anchored = true
													v666.CanCollide = false
													v666.Transparency = 1
													v666.Parent = workspace
													for _, v667 in v666:GetDescendants() do
														if v667:IsA("ParticleEmitter") then
															v667:Emit(v667:GetAttribute("EmitCount") or v667.Rate)
														end
													end
													v_u_308:AddItem(v666, 3)
												end
											end
										end)
									end
								else
									return
								end
							end)
						end
						if v_u_312 == "Alucard" then
							local v668 = v_u_69.Alucard
							if v668 and v668["Skill 3"] then
								v668["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_315
									},
									["DamageDelay"] = 2.5,
									["Duration"] = 5,
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_312 == "Ichigo" then
							local v669 = v_u_69.Ichigo
							if v669 and v669["Skill 3"] then
								v669["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_315
									},
									["ChargeTime"] = 3.5,
									["SlashCount"] = 1,
									["SlashInterval"] = 0.15,
									["SlashDistance"] = 80,
									["SlashSpeed"] = 180
								})
							end
						end
						if v_u_312 == "Rimuru" then
							local v670 = v_u_69.Rimuru
							if v670 and v670["Skill 3"] then
								v670["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_315
									},
									["DamageDelay"] = 2.5,
									["Duration"] = 5,
									["AbilityConfig"] = {}
								})
							end
						end
					elseif p_u_307.VFXName == "V" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (ref) v_u_3, (copy) v_u_315, (ref) v_u_313, (copy) v_u_308, (copy) v_u_309, (copy) p_u_307, (ref) v_u_306, (ref) v_u_37, (ref) v_u_69
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "GojoV2" then
									local v671 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v671 then
										v671 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v671 then
										local v672 = require(v671)
										if v672["Skill 4"] then
											local v673 = {
												["Caster"] = {
													["Character"] = v_u_315
												}
											}
											v672["Skill 4"](v673)
										end
									end
									return
								elseif v_u_312 == "StrongestInHistory" then
									local v674 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v674 then
										v674 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v674 then
										local v675 = require(v674)
										if v675["Skill 4"] then
											local v676 = v675["Skill 4"]
											local v677 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["CutsceneDuration"] = 6.5,
												["DamageDelay"] = 5,
												["CharAnimationId"] = "rbxassetid://125013796988038"
											}
											local v678 = v_u_316
											if v678 then
												v678 = v_u_316.CFrame
											end
											v677.CFrame = v678
											v676(v677)
										end
									end
									return
								elseif v_u_312 == "Gojo" then
									local v_u_679 = v_u_313.V
									if v_u_679 then
										local v_u_680 = Instance.new("Attachment")
										v_u_680.Name = "BlueAtt"
										v_u_680.Position = Vector3.new(7, 2, 5)
										v_u_680.Parent = v_u_316
										local v_u_681 = Instance.new("Attachment")
										v_u_681.Name = "RedAtt"
										v_u_681.Position = Vector3.new(-7, 2, 5)
										v_u_681.Parent = v_u_316
										local v_u_682 = nil
										local v_u_683 = nil
										local function v_u_692(p684, p685)
											-- upvalues: (copy) v_u_679, (ref) v_u_316
											local v686 = v_u_679:FindFirstChild(p684)
											if not v686 then
												return nil
											end
											local v687 = v686:Clone()
											v687.CFrame = v_u_316.CFrame * CFrame.new(p685.Position)
											v687.Anchored = true
											v687.CanCollide = false
											v687.Massless = true
											v687.Transparency = 1
											v687.Parent = workspace
											local v688 = Instance.new("Attachment")
											v688.Parent = v687
											local v689 = Instance.new("AlignPosition")
											v689.Attachment0 = v688
											v689.Attachment1 = p685
											v689.RigidityEnabled = false
											v689.Responsiveness = 100
											v689.MaxForce = (1 / 0)
											v689.Parent = v687
											local v690 = Instance.new("AlignOrientation")
											v690.Attachment0 = v688
											v690.Attachment1 = p685
											v690.RigidityEnabled = false
											v690.Responsiveness = 100
											v690.MaxTorque = (1 / 0)
											v690.Parent = v687
											v687.Anchored = false
											for _, v691 in v687:GetDescendants() do
												if v691:IsA("ParticleEmitter") then
													v691.Enabled = true
												elseif v691:IsA("Beam") or v691:IsA("Trail") then
													v691.Enabled = true
												end
											end
											return v687
										end
										local function v_u_696(p693, p694)
											if p693 and p693.Parent then
												for _, v_u_695 in p693:GetDescendants() do
													if v_u_695:IsA("ParticleEmitter") then
														v_u_695.Enabled = false
														if p694 then
															pcall(function()
																-- upvalues: (copy) v_u_695
																v_u_695:Clear()
															end)
														end
													elseif v_u_695:IsA("Beam") or v_u_695:IsA("Trail") then
														v_u_695.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_682, (copy) v_u_692, (copy) v_u_680, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_682 = v_u_692("Blue", v_u_680)
												if v_u_682 then
													v_u_308:AddItem(v_u_682, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_683, (copy) v_u_692, (copy) v_u_681, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_683 = v_u_692("Red", v_u_681)
												if v_u_683 then
													v_u_308:AddItem(v_u_683, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_309, (copy) v_u_680, (copy) v_u_681, (copy) v_u_679, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v697 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_309:Create(v_u_680, v697, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_309:Create(v_u_681, v697, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_316, (ref) v_u_679, (ref) v_u_308
													if v_u_316 and v_u_316.Parent then
														local v698 = v_u_679:FindFirstChild("StarEff")
														if v698 then
															local v699 = v698:Clone()
															v699.CFrame = v_u_316.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v699.Anchored = true
															v699.CanCollide = false
															v699.Transparency = 1
															v699.Parent = workspace
															for _, v700 in v699:GetDescendants() do
																if v700:IsA("ParticleEmitter") then
																	v700:Emit(v700:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_308:AddItem(v699, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_696, (ref) v_u_682, (ref) v_u_683, (copy) v_u_680, (copy) v_u_681, (copy) v_u_679, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_696(v_u_682, true)
												v_u_696(v_u_683, true)
												if v_u_680 and v_u_680.Parent then
													v_u_680:Destroy()
												end
												if v_u_681 and v_u_681.Parent then
													v_u_681:Destroy()
												end
												local v701 = v_u_679:FindFirstChild("MiniExplosionVFX")
												if v701 then
													local v702 = v701:Clone()
													v702.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -2)
													v702.Anchored = true
													v702.CanCollide = false
													v702.Transparency = 1
													v702.Parent = workspace
													for _, v703 in v702:GetDescendants() do
														if v703:IsA("ParticleEmitter") then
															v703:Emit(v703:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_308:AddItem(v702, 3)
												end
												local v_u_704 = v_u_316.Position + v_u_316.CFrame.LookVector * 6
												local v_u_705 = v_u_316.CFrame.LookVector
												local v706 = v_u_679:FindFirstChild("Purple")
												if v706 then
													local v_u_707 = v706:Clone()
													v_u_707.Anchored = true
													v_u_707.CanCollide = false
													v_u_707.Parent = workspace
													v_u_308:AddItem(v_u_707, 3)
													for _, v708 in v_u_707:GetDescendants() do
														if v708:IsA("ParticleEmitter") then
															v708.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_704, (copy) v_u_707, (copy) v_u_705
														local v709 = v_u_704
														local v710 = 0
														while v710 < 200 and (v_u_707 and v_u_707.Parent) do
															v709 = v709 + v_u_705 * 3.9899999999999998
															v710 = v710 + 3.9899999999999998
															v_u_707.CFrame = CFrame.lookAt(v709, v709 + v_u_705)
															task.wait(0.03)
														end
														for _, v711 in v_u_707:GetDescendants() do
															if v711:IsA("ParticleEmitter") then
																v711.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_312 == "Sukuna" then
									local v_u_712 = v_u_313.V
									if v_u_712 then
										local v713 = (p_u_307.NPCModel or "NPC") .. "_SukunaV"
										local v714 = tick()
										if not v_u_306[v713] or v714 - v_u_306[v713] > 0.5 then
											v_u_306[v713] = v714
											v_u_37:PlayAt("SukunaV_Part1", p_u_307.Position)
										end
										local v715 = v_u_712:FindFirstChild("GroundVFX")
										if v715 then
											local v_u_716 = v715:Clone()
											v_u_716.CFrame = v_u_316.CFrame * CFrame.new(0, -2, 0)
											v_u_716.Anchored = false
											v_u_716.Parent = workspace
											v_u_308:AddItem(v_u_716, 3)
											local v717 = Instance.new("WeldConstraint")
											v717.Part0 = v_u_316
											v717.Part1 = v_u_716
											v717.Parent = v_u_716
											for _, v718 in v_u_716:GetDescendants() do
												if v718:IsA("ParticleEmitter") then
													v718.Enabled = true
													v718:Emit(v718:GetAttribute("EmitCount") or 40)
												elseif v718:IsA("Beam") then
													v718.Enabled = true
												end
											end
											task.delay(2.35, function()
												-- upvalues: (copy) v_u_716
												if v_u_716 and v_u_716.Parent then
													for _, v719 in v_u_716:GetDescendants() do
														if v719:IsA("ParticleEmitter") then
															v719.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_712, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v720 = v_u_712:FindFirstChild("MiniExplosionVFX")
												if v720 then
													local v721 = v720:Clone()
													v721.CFrame = v_u_316.CFrame * CFrame.new(1, 0, 0)
													v721.Anchored = false
													v721.Parent = workspace
													v_u_308:AddItem(v721, 2)
													local v722 = Instance.new("WeldConstraint")
													v722.Part0 = v_u_316
													v722.Part1 = v721
													v722.Parent = v721
													for _, v723 in v721:GetDescendants() do
														if v723:IsA("ParticleEmitter") then
															v723:Emit(v723:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v724 = v_u_712:FindFirstChild("ArrowVFX")
												if v724 then
													local v_u_725 = v724:Clone()
													v_u_725.CFrame = v_u_316.CFrame * CFrame.new(1, 0, 0)
													v_u_725.Anchored = false
													v_u_725.Parent = workspace
													v_u_308:AddItem(v_u_725, 2)
													local v726 = Instance.new("WeldConstraint")
													v726.Part0 = v_u_316
													v726.Part1 = v_u_725
													v726.Parent = v_u_725
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_725
														if v_u_725 and v_u_725.Parent then
															for _, v727 in v_u_725:GetDescendants() do
																if v727:IsA("ParticleEmitter") or v727:IsA("Beam") then
																	v727.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_316, (ref) p_u_307, (ref) v_u_306, (ref) v_u_37, (copy) v_u_712, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v728 = (p_u_307.NPCModel or "NPC") .. "_SukunaV2"
												local v729 = tick()
												if not v_u_306[v728] or v729 - v_u_306[v728] > 0.5 then
													v_u_306[v728] = v729
													v_u_37:PlayAt("SukunaV_Part2", v_u_316.Position)
												end
												local v730 = v_u_316.CFrame.LookVector
												local v731 = v_u_316.Position + v730 * 85
												local v732 = v_u_712:FindFirstChild("ExplosionVFX")
												if v732 then
													local v_u_733 = v732:Clone()
													if v_u_733:IsA("Model") then
														v_u_733:PivotTo(CFrame.new(v731) * CFrame.new(0, 73, 0))
													else
														v_u_733.CFrame = CFrame.new(v731) * CFrame.new(0, 73, 0)
													end
													v_u_733.Parent = workspace
													v_u_308:AddItem(v_u_733, 4)
													for _, v734 in v_u_733:GetDescendants() do
														if v734:IsA("ParticleEmitter") then
															v734.Enabled = true
															v734:Emit(v734:GetAttribute("EmitCount") or 30)
														elseif v734:IsA("Beam") or v734:IsA("Trail") then
															v734.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_733
														if v_u_733 and v_u_733.Parent then
															for _, v735 in v_u_733:GetDescendants() do
																if v735:IsA("ParticleEmitter") or (v735:IsA("Beam") or v735:IsA("Trail")) then
																	v735.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_312 == "Ragna" then
									v_u_37:PlayAt("RagnaV", p_u_307.Position)
									local v_u_736 = v_u_313.V
									if v_u_736 then
										local v737 = v_u_736:FindFirstChild("FirstEffects")
										if v737 then
											local v_u_738 = v737:Clone()
											v_u_738.CFrame = v_u_316.CFrame * CFrame.new(0, -2.5, 0)
											v_u_738.Anchored = false
											v_u_738.CanCollide = false
											v_u_738.Transparency = 1
											v_u_738.CastShadow = false
											v_u_738.CanQuery = false
											v_u_738.Massless = true
											v_u_738.Parent = workspace
											v_u_308:AddItem(v_u_738, 6)
											local v739 = Instance.new("WeldConstraint")
											v739.Part0 = v_u_316
											v739.Part1 = v_u_738
											v739.Parent = v_u_738
											for _, v740 in v_u_738:GetDescendants() do
												if v740:IsA("ParticleEmitter") then
													v740.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_738
												if v_u_738 and v_u_738.Parent then
													for _, v741 in v_u_738:GetDescendants() do
														if v741:IsA("ParticleEmitter") then
															v741.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_736, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v742 = v_u_736:FindFirstChild("UltVFX")
												if v742 then
													local v_u_743 = v742:Clone()
													v_u_743:PivotTo(v_u_316.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v744 in v_u_743:GetDescendants() do
														if v744:IsA("BasePart") then
															v744.Anchored = true
															v744.CanCollide = false
															v744.CastShadow = false
															v744.CanQuery = false
														end
													end
													v_u_743.Parent = workspace
													v_u_308:AddItem(v_u_743, 4.5)
													for _, v745 in v_u_743:GetDescendants() do
														if v745:IsA("ParticleEmitter") then
															v745.Enabled = true
														elseif v745:IsA("Beam") then
															v745.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_743
														if v_u_743 and v_u_743.Parent then
															for _, v746 in v_u_743:GetDescendants() do
																if v746:IsA("ParticleEmitter") then
																	v746.Enabled = false
																end
															end
															for _, v_u_747 in v_u_743:GetDescendants() do
																if v_u_747:IsA("Beam") then
																	local v_u_748 = v_u_747.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_748, (copy) v_u_747
																		local v749 = tick()
																		while tick() - v749 < 0.5 do
																			local v750 = (tick() - v749) / 0.5
																			local v751 = {}
																			for _, v752 in ipairs(v_u_748) do
																				local v753 = v752.Value + (1 - v752.Value) * v750
																				local v754 = NumberSequenceKeypoint.new
																				local v755 = v752.Time
																				table.insert(v751, v754(v755, v753))
																			end
																			v_u_747.Transparency = NumberSequence.new(v751)
																			task.wait()
																		end
																		v_u_747.Transparency = NumberSequence.new(1)
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
									if v_u_312 == "Ichigo" then
										local v756 = v_u_69.Ichigo
										if v756 and v756["Skill 4"] then
											local v757 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["CutsceneDuration"] = 8.33,
												["CharAnimationId"] = "rbxassetid://98446587158184",
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v756["Skill 4"](v757)
											return
										end
									elseif v_u_312 == "Alucard" then
										local v758 = v_u_69.Alucard
										if v758 and v758["Skill 4"] then
											local v759 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["AbilityConfig"] = {},
												["CutsceneDuration"] = 5.5,
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v758["Skill 4"](v759)
											return
										end
									elseif v_u_312 == "Rimuru" then
										local v760 = v_u_69.Rimuru
										if v760 and v760["Skill 4"] then
											local v761 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
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
					elseif p_u_307.VFXName == "F" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (ref) v_u_69, (copy) v_u_315
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "Rimuru" then
									local v762 = v_u_69.Rimuru
									if v762 and v762["Skill 5"] then
										local v763 = {
											["Caster"] = {
												["Character"] = v_u_315
											},
											["AbilityConfig"] = {},
											["DisableCutscene"] = true
										}
										v762["Skill 5"](v763)
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
	local v_u_765 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p766, p_u_767)
		-- upvalues: (copy) v_u_765, (copy) v_u_764, (copy) v_u_44, (copy) v_u_37, (copy) v_u_299, (copy) v_u_7, (copy) v_u_305, (copy) v_u_4
		if p766 == "SpawnVFX" then
			if p_u_767.IsNPC and (p_u_767.VFXName == "Z" or (p_u_767.VFXName == "X" or (p_u_767.VFXName == "C" or (p_u_767.VFXName == "V" or p_u_767.VFXName == "F")))) then
				local v768 = (p_u_767.NPCModel or "NPC") .. "_" .. p_u_767.VFXName
				local v769 = tick()
				if v_u_765[v768] and v769 - v_u_765[v768] < 1 then
					return
				end
				v_u_765[v768] = v769
				task.spawn(function()
					-- upvalues: (ref) v_u_764, (copy) p_u_767
					v_u_764(p_u_767)
				end)
				local v770 = p_u_767.MovesetType or "Saber"
				if p_u_767.VFXName == "Z" then
					if v770 == "Gojo" then
						local v771 = (p_u_767.NPCModel or "unknown") .. "_Z"
						local v772 = tick()
						local v773
						if v_u_44[v771] and v772 - v_u_44[v771] < 1.5 then
							v773 = false
						else
							v_u_44[v771] = v772
							v773 = true
						end
						if v773 then
							v_u_37:PlayAt("GojoZ", p_u_767.Position)
						end
					elseif v770 == "Sukuna" then
						local v774 = (p_u_767.NPCModel or "unknown") .. "_Z"
						local v775 = tick()
						local v776
						if v_u_44[v774] and v775 - v_u_44[v774] < 1.5 then
							v776 = false
						else
							v_u_44[v774] = v775
							v776 = true
						end
						if v776 then
							v_u_37:PlayAt("SukunaZ", p_u_767.Position)
						end
					elseif v770 == "Jinwoo" then
						local v777 = (p_u_767.NPCModel or "unknown") .. "_Z"
						local v778 = tick()
						local v779
						if v_u_44[v777] and v778 - v_u_44[v777] < 1.5 then
							v779 = false
						else
							v_u_44[v777] = v778
							v779 = true
						end
						if v779 then
							v_u_37:PlayAt("JinwooZ", p_u_767.Position)
						end
					elseif v770 == "Ragna" then
						local v780 = (p_u_767.NPCModel or "unknown") .. "_Z"
						local v781 = tick()
						local v782
						if v_u_44[v780] and v781 - v_u_44[v780] < 1.5 then
							v782 = false
						else
							v_u_44[v780] = v781
							v782 = true
						end
						if v782 then
							v_u_37:PlayAt("RagnaZ", p_u_767.Position)
						end
					elseif v770 == "Aizen" then
						local v783 = (p_u_767.NPCModel or "unknown") .. "_Z"
						local v784 = tick()
						local v785
						if v_u_44[v783] and v784 - v_u_44[v783] < 1.5 then
							v785 = false
						else
							v_u_44[v783] = v784
							v785 = true
						end
						if v785 then
							v_u_37:PlayAt("AizenZ", p_u_767.Position)
						end
					elseif v770 == "QinShi" then
						local v786 = (p_u_767.NPCModel or "unknown") .. "_Z"
						local v787 = tick()
						local v788
						if v_u_44[v786] and v787 - v_u_44[v786] < 1.5 then
							v788 = false
						else
							v_u_44[v786] = v787
							v788 = true
						end
						if v788 then
							v_u_37:PlayAt("QinShiZ", p_u_767.Position)
						end
					elseif v770 == "Yuji" then
						local v789 = (p_u_767.NPCModel or "unknown") .. "_Z"
						local v790 = tick()
						local v791
						if v_u_44[v789] and v790 - v_u_44[v789] < 1.5 then
							v791 = false
						else
							v_u_44[v789] = v790
							v791 = true
						end
						if v791 then
							v_u_37:PlayAt("YujiZ", p_u_767.Position)
						end
					elseif v770 ~= "Alucard" then
						if v770 == "GojoV2" then
							local v792 = (p_u_767.NPCModel or "unknown") .. "_Z"
							local v793 = tick()
							local v794
							if v_u_44[v792] and v793 - v_u_44[v792] < 1.5 then
								v794 = false
							else
								v_u_44[v792] = v793
								v794 = true
							end
							if v794 then
								v_u_37:PlayAt("GojoV2Z", p_u_767.Position)
							end
						elseif v770 ~= "StrongestInHistory" and v770 ~= "Rimuru" then
							local v795 = (p_u_767.NPCModel or "unknown") .. "_Z"
							local v796 = tick()
							local v797
							if v_u_44[v795] and v796 - v_u_44[v795] < 1.5 then
								v797 = false
							else
								v_u_44[v795] = v796
								v797 = true
							end
							if v797 then
								v_u_37:PlayAt("SaberZ", p_u_767.Position)
							end
						end
					end
				elseif p_u_767.VFXName == "X" then
					if v770 == "Gojo" then
						local v798 = (p_u_767.NPCModel or "unknown") .. "_X"
						local v799 = tick()
						local v800
						if v_u_44[v798] and v799 - v_u_44[v798] < 1.5 then
							v800 = false
						else
							v_u_44[v798] = v799
							v800 = true
						end
						if v800 then
							v_u_37:PlayAt("GojoX", p_u_767.Position)
						end
					elseif v770 == "Sukuna" then
						local v801 = (p_u_767.NPCModel or "unknown") .. "_X"
						local v802 = tick()
						local v803
						if v_u_44[v801] and v802 - v_u_44[v801] < 1.5 then
							v803 = false
						else
							v_u_44[v801] = v802
							v803 = true
						end
						if v803 then
							v_u_37:PlayAt("SukunaX", p_u_767.Position)
						end
					elseif v770 == "Jinwoo" then
						local v804 = (p_u_767.NPCModel or "unknown") .. "_X"
						local v805 = tick()
						local v806
						if v_u_44[v804] and v805 - v_u_44[v804] < 1.5 then
							v806 = false
						else
							v_u_44[v804] = v805
							v806 = true
						end
						if v806 then
							v_u_37:PlayAt("JinwooX", p_u_767.Position)
						end
					elseif v770 == "Ragna" then
						local v807 = (p_u_767.NPCModel or "unknown") .. "_X"
						local v808 = tick()
						local v809
						if v_u_44[v807] and v808 - v_u_44[v807] < 1.5 then
							v809 = false
						else
							v_u_44[v807] = v808
							v809 = true
						end
						if v809 then
							v_u_37:PlayAt("RagnaX", p_u_767.Position)
						end
					elseif v770 == "Aizen" then
						local v810 = (p_u_767.NPCModel or "unknown") .. "_X"
						local v811 = tick()
						local v812
						if v_u_44[v810] and v811 - v_u_44[v810] < 1.5 then
							v812 = false
						else
							v_u_44[v810] = v811
							v812 = true
						end
						if v812 then
							v_u_37:PlayAt("AizenX", p_u_767.Position)
						end
					elseif v770 == "QinShi" then
						local v813 = (p_u_767.NPCModel or "unknown") .. "_X"
						local v814 = tick()
						local v815
						if v_u_44[v813] and v814 - v_u_44[v813] < 1.5 then
							v815 = false
						else
							v_u_44[v813] = v814
							v815 = true
						end
						if v815 then
							v_u_37:PlayAt("QinShiX", p_u_767.Position)
						end
					elseif v770 == "Yuji" then
						local v816 = (p_u_767.NPCModel or "unknown") .. "_X"
						local v817 = tick()
						local v818
						if v_u_44[v816] and v817 - v_u_44[v816] < 1.5 then
							v818 = false
						else
							v_u_44[v816] = v817
							v818 = true
						end
						if v818 then
							v_u_37:PlayAt("YujiX", p_u_767.Position)
						end
					elseif v770 ~= "Ichigo" and v770 ~= "Alucard" then
						if v770 == "GojoV2" then
							local v819 = (p_u_767.NPCModel or "unknown") .. "_X"
							local v820 = tick()
							local v821
							if v_u_44[v819] and v820 - v_u_44[v819] < 1.5 then
								v821 = false
							else
								v_u_44[v819] = v820
								v821 = true
							end
							if v821 then
								v_u_37:PlayAt("GojoV2X", p_u_767.Position)
							end
						elseif v770 ~= "StrongestInHistory" and v770 ~= "Rimuru" then
							local v822 = (p_u_767.NPCModel or "unknown") .. "_X"
							local v823 = tick()
							local v824
							if v_u_44[v822] and v823 - v_u_44[v822] < 1.5 then
								v824 = false
							else
								v_u_44[v822] = v823
								v824 = true
							end
							if v824 then
								v_u_37:PlayAt("SaberX", p_u_767.Position)
							end
						end
					end
				elseif p_u_767.VFXName == "C" then
					if v770 == "Gojo" then
						local v825 = (p_u_767.NPCModel or "unknown") .. "_C"
						local v826 = tick()
						local v827
						if v_u_44[v825] and v826 - v_u_44[v825] < 1.5 then
							v827 = false
						else
							v_u_44[v825] = v826
							v827 = true
						end
						if v827 then
							v_u_37:PlayAt("GojoC", p_u_767.Position)
							v_u_37:PlayAt("GojoC_Hold", p_u_767.Position)
						end
					elseif v770 == "Jinwoo" then
						local v828 = (p_u_767.NPCModel or "unknown") .. "_C"
						local v829 = tick()
						local v830
						if v_u_44[v828] and v829 - v_u_44[v828] < 1.5 then
							v830 = false
						else
							v_u_44[v828] = v829
							v830 = true
						end
						if v830 then
							v_u_37:PlayAt("JinwooC", p_u_767.Position)
						end
					elseif v770 == "Ragna" then
						local v831 = (p_u_767.NPCModel or "unknown") .. "_C"
						local v832 = tick()
						local v833
						if v_u_44[v831] and v832 - v_u_44[v831] < 1.5 then
							v833 = false
						else
							v_u_44[v831] = v832
							v833 = true
						end
						if v833 then
							v_u_37:PlayAt("RagnaC_Startup", p_u_767.Position)
						end
					elseif v770 == "Aizen" then
						local v834 = (p_u_767.NPCModel or "unknown") .. "_C"
						local v835 = tick()
						local v836
						if v_u_44[v834] and v835 - v_u_44[v834] < 1.5 then
							v836 = false
						else
							v_u_44[v834] = v835
							v836 = true
						end
						if v836 then
							v_u_37:PlayAt("AizenC", p_u_767.Position)
						end
					elseif v770 == "QinShi" then
						local v837 = (p_u_767.NPCModel or "unknown") .. "_C"
						local v838 = tick()
						local v839
						if v_u_44[v837] and v838 - v_u_44[v837] < 1.5 then
							v839 = false
						else
							v_u_44[v837] = v838
							v839 = true
						end
						if v839 then
							v_u_37:PlayAt("QinShiC", p_u_767.Position)
						end
					elseif v770 == "Yuji" then
						local v840 = (p_u_767.NPCModel or "unknown") .. "_C"
						local v841 = tick()
						local v842
						if v_u_44[v840] and v841 - v_u_44[v840] < 1.5 then
							v842 = false
						else
							v_u_44[v840] = v841
							v842 = true
						end
						if v842 then
							v_u_37:PlayAt("YujiC_Press", p_u_767.Position)
						end
					elseif v770 ~= "Ichigo" and (v770 ~= "Alucard" and (v770 ~= "GojoV2" and (v770 ~= "StrongestInHistory" and v770 ~= "Rimuru"))) then
						local v843 = (p_u_767.NPCModel or "unknown") .. "_C"
						local v844 = tick()
						local v845
						if v_u_44[v843] and v844 - v_u_44[v843] < 1.5 then
							v845 = false
						else
							v_u_44[v843] = v844
							v845 = true
						end
						if v845 then
							v_u_37:PlayAt("SaberC_Cast", p_u_767.Position)
							task.delay(3.85, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_767
								v_u_37:PlayAt("SaberC_Beam", p_u_767.Position)
							end)
							task.delay(4.4, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_767
								v_u_37:PlayAt("SaberC_Explosion", p_u_767.Position)
							end)
						end
					end
				elseif p_u_767.VFXName == "V" then
					if v770 == "Gojo" then
						v_u_37:PlayAt("GojoV", p_u_767.Position)
					elseif v770 ~= "Sukuna" and (v770 ~= "Ichigo" and (v770 ~= "Alucard" and (v770 ~= "GojoV2" and v770 ~= "StrongestInHistory"))) then
						local _ = v770 == "Rimuru"
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_299, (copy) p_u_767
					v_u_299.SpawnVFX(p_u_767.VFXName, p_u_767.Position, p_u_767.Scale, p_u_767.Duration, p_u_767.AbilityName)
				end)
			end
			if p_u_767.CameraShake then
				task.delay(p_u_767.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_767, (ref) v_u_7
					local v_u_846 = p_u_767.CameraShake.Intensity or 5
					local v_u_847 = p_u_767.CameraShake.Duration or 0.3
					if v_u_7:GetAttribute("DisableScreenShake") then
						return
					else
						local v_u_848 = workspace.CurrentCamera
						if v_u_848 then
							task.spawn(function()
								-- upvalues: (copy) v_u_848, (copy) v_u_847, (copy) v_u_846
								local v849 = tick()
								local _ = v_u_848.CFrame
								while tick() - v849 < v_u_847 do
									local v850 = v_u_846 * (1 - (tick() - v849) / v_u_847)
									local v851 = (math.random() - 0.5) * v850 * 0.1
									local v852 = (math.random() - 0.5) * v850 * 0.1
									v_u_848.CFrame = v_u_848.CFrame * CFrame.new(v851, v852, 0)
									task.wait()
								end
							end)
						end
					end
				end)
			end
			if p_u_767.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_305, (copy) p_u_767
					v_u_305(p_u_767.ScreenFlash)
				end)
				return
			end
		elseif p766 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_299, (copy) p_u_767, (ref) v_u_4
				local v853 = v_u_299.SpawnVFXWithRotation(p_u_767.VFXName, p_u_767.Position, p_u_767.Rotation, p_u_767.Scale, p_u_767.Duration, "KatanaAbilities")
				if v853 then
					v_u_4:AddItem(v853, (p_u_767.Duration or 0.4) + 1)
				end
			end)
			if p_u_767.IsNPC then
				v_u_37:PlayAt("KatanaZ", p_u_767.Position)
			end
			if p_u_767.CameraShake then
				local v_u_854 = p_u_767.CameraShake.Intensity or 3
				local v_u_855 = p_u_767.CameraShake.Duration or 0.2
				if v_u_7:GetAttribute("DisableScreenShake") then
					return
				else
					local v_u_856 = workspace.CurrentCamera
					if v_u_856 then
						task.spawn(function()
							-- upvalues: (copy) v_u_856, (copy) v_u_855, (copy) v_u_854
							local v857 = tick()
							local _ = v_u_856.CFrame
							while tick() - v857 < v_u_855 do
								local v858 = v_u_854 * (1 - (tick() - v857) / v_u_855)
								local v859 = (math.random() - 0.5) * v858 * 0.1
								local v860 = (math.random() - 0.5) * v858 * 0.1
								v_u_856.CFrame = v_u_856.CFrame * CFrame.new(v859, v860, 0)
								task.wait()
							end
						end)
					end
				end
			end
		elseif p766 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_299, (copy) p_u_767, (ref) v_u_4
				local v861 = v_u_299.SpawnTravelingVFX(p_u_767.VFXName, p_u_767.StartPosition, p_u_767.Direction, p_u_767.TravelDistance, p_u_767.TravelSpeed, p_u_767.Scale, p_u_767.Duration, "KatanaAbilities")
				if v861 then
					v_u_4:AddItem(v861, (p_u_767.TravelDistance or 50) / (p_u_767.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_767.CameraShake then
				local v_u_862 = p_u_767.CameraShake.Intensity or 6
				local v_u_863 = p_u_767.CameraShake.Duration or 0.3
				local v_u_864 = not v_u_7:GetAttribute("DisableScreenShake") and workspace.CurrentCamera
				if v_u_864 then
					task.spawn(function()
						-- upvalues: (copy) v_u_864, (copy) v_u_863, (copy) v_u_862
						local v865 = tick()
						local _ = v_u_864.CFrame
						while tick() - v865 < v_u_863 do
							local v866 = v_u_862 * (1 - (tick() - v865) / v_u_863)
							local v867 = (math.random() - 0.5) * v866 * 0.1
							local v868 = (math.random() - 0.5) * v866 * 0.1
							v_u_864.CFrame = v_u_864.CFrame * CFrame.new(v867, v868, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_767.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_305, (copy) p_u_767
					v_u_305(p_u_767.ScreenFlash)
				end)
			end
		end
	end)
	local v869 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_870 = 1
	v869.OnClientEvent:Connect(function(p871)
		-- upvalues: (ref) v_u_870, (copy) v_u_37
		if p871 and p871.Position then
			v_u_37:PlayAt("CombatHit" .. v_u_870, p871.Position)
			v_u_870 = v_u_870 % 7 + 1
		end
	end)
	local v_u_872 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v873 = v46:WaitForChild("HitboxVisualize", 5)
	if v873 then
		v873.OnClientEvent:Connect(function(p874)
			-- upvalues: (copy) v_u_872
			if p874.Type == "Box" then
				v_u_872.ShowBox(p874.CFrame, p874.Size, p874.Duration, p874.Color)
				return
			elseif p874.Type == "Sphere" then
				v_u_872.ShowSphere(p874.Position, p874.Radius, p874.Duration, p874.Color)
				return
			elseif p874.Type == "Traveling" then
				v_u_872.ShowTraveling(p874.StartPos, p874.Direction, p874.Size, p874.Speed, p874.Distance, p874.HitboxType, p874.Color)
			elseif p874.Type == "FollowingAOE" then
				local v875 = p874.Character
				if v875 then
					v_u_872.ShowFollowingAOE(v875, p874.Size, p874.Duration, p874.Offset, p874.Color, p874.Shape)
					return
				end
			else
				if p874.Type == "MultiWave" then
					v_u_872.ShowMultiWave(p874.OriginCFrame, p874.Waves)
					return
				end
				if p874.Type == "Explosion" then
					v_u_872.ShowExplosion(p874.Position, p874.Radius, p874.Duration, p874.Color)
					return
				end
				if p874.Type == "StaticBox" then
					v_u_872.ShowStaticBox(p874.StartPos, p874.EndPos, p874.Width, p874.Height, p874.Duration, p874.Color)
				end
			end
		end)
	end
end)
if not v876 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v877)
	warn("=====================================")
end