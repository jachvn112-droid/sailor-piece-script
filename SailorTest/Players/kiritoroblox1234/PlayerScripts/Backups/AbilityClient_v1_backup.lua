local v874, v875 = pcall(function()
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
	local function v_u_762(p_u_307)
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
										else
											task.wait(0.45)
											if not (v_u_316 and v_u_316.Parent) then
												return
											end
											local v402 = v_u_316.CFrame
											local v403 = v_u_313.Z:FindFirstChild("EnergyThrust")
											local v404 = v_u_313.Z:FindFirstChild("EnergyPart")
											if v403 then
												v_u_322(v403, v402 * CFrame.new(0, 2, -35), 3)
											end
											if v404 then
												v_u_322(v404, v402 * CFrame.new(0, 2, -2), 3)
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
									local v_u_405 = v_u_315:FindFirstChild("Right Arm")
									if v_u_405 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (copy) v_u_405, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v406 = v_u_313.X:FindFirstChild("BlueVFXFirst")
												if v406 then
													local v407 = v406:Clone()
													v407.CFrame = v_u_405.CFrame * CFrame.new(0, -1.05, 0)
													v407.Anchored = true
													v407.CanCollide = false
													v407.Transparency = 1
													v407.CastShadow = false
													v407.CanQuery = false
													v407.Parent = workspace
													v_u_308:AddItem(v407, 4)
													for _, v_u_408 in v407:GetDescendants() do
														if v_u_408:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_408
																local v409 = v_u_408:GetAttribute("EmitDelay") or 0
																task.wait(v409)
																v_u_408:Emit(v_u_408:GetAttribute("EmitCount") or v_u_408.Rate)
															end)
														end
													end
													v407.Anchored = false
													local v410 = Instance.new("WeldConstraint")
													v410.Part0 = v_u_405
													v410.Part1 = v407
													v410.Parent = v407
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v411 = v_u_316.CFrame
												local v412 = v_u_313.X:FindFirstChild("BlueMainVFX")
												if v412 then
													local v413 = v412:Clone()
													v413.CFrame = v411 * CFrame.new(0, 0, -25)
													v413.Anchored = true
													v413.CanCollide = false
													v413.Transparency = 1
													v413.CastShadow = false
													v413.CanQuery = false
													v413.Parent = workspace
													v_u_308:AddItem(v413, 3)
													for _, v_u_414 in v413:GetDescendants() do
														if v_u_414:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_414
																local v415 = v_u_414:GetAttribute("EmitDelay") or 0
																task.wait(v415)
																v_u_414:Emit(v_u_414:GetAttribute("EmitCount") or v_u_414.Rate)
															end)
														end
													end
												end
												local v416 = v_u_313.X:FindFirstChild("Blue_Additional_VFX")
												if v416 then
													local v417 = v416:Clone()
													v417.CFrame = v411 * CFrame.new(0, 0, -5)
													v417.Anchored = true
													v417.CanCollide = false
													v417.Transparency = 1
													v417.CastShadow = false
													v417.CanQuery = false
													v417.Parent = workspace
													v_u_308:AddItem(v417, 4)
													for _, v_u_418 in v417:GetDescendants() do
														if v_u_418:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_418
																local v419 = v_u_418:GetAttribute("EmitDelay") or 0
																task.wait(v419)
																v_u_418:Emit(v_u_418:GetAttribute("EmitCount") or v_u_418.Rate)
															end)
														end
													end
												end
											end
										end)
									end
								else
									if v_u_312 == "Sukuna" then
										local v420 = v_u_313.X
										if not v420 then
											return
										end
										local v421 = v420:FindFirstChild("GroundVFX")
										if v421 then
											local v_u_422 = v421:Clone()
											v_u_422:PivotTo(v_u_316.CFrame * CFrame.new(0, -2.5, 0))
											v_u_422.Parent = workspace
											v_u_308:AddItem(v_u_422, 3.5)
											local v423 = v_u_422.PrimaryPart or v_u_422:FindFirstChildWhichIsA("BasePart")
											for _, v424 in v_u_422:GetDescendants() do
												if v424:IsA("BasePart") then
													v424.Anchored = false
													v424.CanCollide = false
													v424.CanQuery = false
													v424.CanTouch = false
													v424.Massless = true
												end
											end
											if v423 then
												local v425 = Instance.new("WeldConstraint")
												v425.Part0 = v_u_316
												v425.Part1 = v423
												v425.Parent = v423
											end
											task.delay(2.6, function()
												-- upvalues: (copy) v_u_422
												if v_u_422 and v_u_422.Parent then
													for _, v426 in v_u_422:GetDescendants() do
														if v426:IsA("ParticleEmitter") then
															v426.Enabled = false
														end
													end
												end
											end)
											return
										end
									elseif v_u_312 == "Jinwoo" then
										local v427 = v_u_313.X
										if not v427 then
											return
										end
										local v428 = v427:FindFirstChild("DashVFX")
										local v429 = v427:FindFirstChild("SlashesVFX")
										local v430 = v_u_316.CFrame.LookVector
										local v431 = CFrame.lookAt(v_u_316.Position, v_u_316.Position + v430)
										if v428 then
											local v_u_432 = v428:Clone()
											v_u_432.CFrame = v431
											v_u_432.Anchored = false
											v_u_432.CanCollide = false
											v_u_432.Transparency = 1
											v_u_432.CastShadow = false
											v_u_432.CanQuery = false
											v_u_432.Massless = true
											v_u_432.Parent = workspace
											v_u_308:AddItem(v_u_432, 1.5)
											local v433 = Instance.new("WeldConstraint")
											v433.Part0 = v_u_316
											v433.Part1 = v_u_432
											v433.Parent = v_u_432
											for _, v434 in v_u_432:GetDescendants() do
												if v434:IsA("ParticleEmitter") then
													v434.Enabled = true
													v434:Emit(v434:GetAttribute("EmitCount") or 30)
												end
											end
											task.delay(0.5, function()
												-- upvalues: (copy) v_u_432
												if v_u_432 and v_u_432.Parent then
													for _, v435 in v_u_432:GetDescendants() do
														if v435:IsA("ParticleEmitter") then
															v435.Enabled = false
														end
													end
												end
											end)
										end
										if v429 then
											local v436 = v429:Clone()
											v436.CFrame = v431 * CFrame.new(0, 0, -20)
											v436.Anchored = true
											v436.CanCollide = false
											v436.Transparency = 1
											v436.CastShadow = false
											v436.CanQuery = false
											v436.Parent = workspace
											v_u_308:AddItem(v436, 1.5)
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
											return
										end
									elseif v_u_312 == "Ragna" then
										local v_u_439 = v_u_313.X
										if v_u_439 then
											local v440 = v_u_439:FindFirstChild("GroundVFX")
											if v440 then
												local v441 = v440:Clone()
												v441.CFrame = v_u_316.CFrame * CFrame.new(0, -2.5, 0)
												v441.Anchored = true
												v441.CanCollide = false
												v441.Transparency = 1
												v441.Parent = workspace
												v_u_308:AddItem(v441, 5)
												for _, v_u_442 in v441:GetDescendants() do
													if v_u_442:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_442
															local v443 = v_u_442:GetAttribute("EmitDelay") or 0
															if v443 > 0 then
																task.wait(v443)
															end
															v_u_442:Emit(v_u_442:GetAttribute("EmitCount") or v_u_442.Rate)
														end)
													end
												end
											end
											local v444 = v_u_439:FindFirstChild("ChargeVFX")
											if v444 then
												local v_u_445 = v444:Clone()
												v_u_445.CFrame = v_u_316.CFrame
												v_u_445.Anchored = false
												v_u_445.CanCollide = false
												v_u_445.Transparency = 1
												v_u_445.Massless = true
												v_u_445.Parent = workspace
												v_u_308:AddItem(v_u_445, 1.3)
												local v446 = Instance.new("WeldConstraint")
												v446.Part0 = v_u_316
												v446.Part1 = v_u_445
												v446.Parent = v_u_445
												for _, v447 in v_u_445:GetDescendants() do
													if v447:IsA("ParticleEmitter") then
														v447.Enabled = true
													end
												end
												task.delay(0.4, function()
													-- upvalues: (copy) v_u_445
													if v_u_445 and v_u_445.Parent then
														for _, v448 in v_u_445:GetDescendants() do
															if v448:IsA("ParticleEmitter") then
																v448.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(0.44999999999999996, function()
												-- upvalues: (ref) v_u_316, (copy) v_u_439, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v449 = v_u_439:FindFirstChild("BarrageVFX")
													if v449 then
														local v_u_450 = v449:Clone()
														v_u_450.CFrame = v_u_316.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_450.Anchored = true
														v_u_450.CanCollide = false
														v_u_450.Transparency = 1
														v_u_450.Parent = workspace
														v_u_308:AddItem(v_u_450, 2.9)
														for _, v451 in v_u_450:GetDescendants() do
															if v451:IsA("ParticleEmitter") then
																v451.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_450
															if v_u_450 and v_u_450.Parent then
																for _, v452 in v_u_450:GetDescendants() do
																	if v452:IsA("ParticleEmitter") then
																		v452.Enabled = false
																	end
																end
															end
														end)
													end
													local v453 = v_u_439:FindFirstChild("BarrageGroundVFX")
													if v453 then
														local v_u_454 = v453:Clone()
														v_u_454.CFrame = v_u_316.CFrame * CFrame.new(0, -37.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_454.Anchored = true
														v_u_454.CanCollide = false
														v_u_454.Transparency = 1
														v_u_454.Parent = workspace
														v_u_308:AddItem(v_u_454, 2.7)
														for _, v455 in v_u_454:GetDescendants() do
															if v455:IsA("ParticleEmitter") then
																v455.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_454
															if v_u_454 and v_u_454.Parent then
																for _, v456 in v_u_454:GetDescendants() do
																	if v456:IsA("ParticleEmitter") then
																		v456.Enabled = false
																	end
																end
															end
														end)
													end
												end
											end)
											task.delay(2, function()
												-- upvalues: (ref) v_u_316, (copy) v_u_439, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v457 = v_u_439:FindFirstChild("ChargeVFX")
													if v457 then
														local v_u_458 = v457:Clone()
														v_u_458.CFrame = v_u_316.CFrame
														v_u_458.Anchored = false
														v_u_458.CanCollide = false
														v_u_458.Transparency = 1
														v_u_458.Massless = true
														v_u_458.Parent = workspace
														v_u_308:AddItem(v_u_458, 1)
														local v459 = Instance.new("WeldConstraint")
														v459.Part0 = v_u_316
														v459.Part1 = v_u_458
														v459.Parent = v_u_458
														for _, v460 in v_u_458:GetDescendants() do
															if v460:IsA("ParticleEmitter") then
																v460.Enabled = true
															end
														end
														task.delay(0.6, function()
															-- upvalues: (copy) v_u_458
															if v_u_458 and v_u_458.Parent then
																for _, v461 in v_u_458:GetDescendants() do
																	if v461:IsA("ParticleEmitter") then
																		v461.Enabled = false
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
											local v462 = v_u_313.X:FindFirstChild("BarrageVFX")
											if v462 then
												local v_u_463 = v462:Clone()
												v_u_463.CFrame = v_u_316.CFrame * CFrame.new(0, 4, -15)
												v_u_463.Anchored = false
												v_u_463.CanCollide = false
												v_u_463.Transparency = 1
												v_u_463.CastShadow = false
												v_u_463.CanQuery = false
												v_u_463.Massless = true
												v_u_463.Parent = workspace
												v_u_308:AddItem(v_u_463, 3.7)
												local v464 = Instance.new("WeldConstraint")
												v464.Part0 = v_u_316
												v464.Part1 = v_u_463
												v464.Parent = v_u_463
												for _, v465 in v_u_463:GetDescendants() do
													if v465:IsA("ParticleEmitter") or (v465:IsA("Beam") or v465:IsA("Trail")) then
														v465.Enabled = true
													end
												end
												task.delay(1.7, function()
													-- upvalues: (copy) v_u_463
													if v_u_463 and v_u_463.Parent then
														for _, v466 in v_u_463:GetDescendants() do
															if v466:IsA("ParticleEmitter") or (v466:IsA("Beam") or v466:IsA("Trail")) then
																v466.Enabled = false
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
												local v467 = { 0, 0 }
												local v468 = {
													{ 180, 180, 135 },
													{ 180, 180, 45 }
												}
												for v469 = 1, 2 do
													if not (v_u_316 and v_u_316.Parent) then
														break
													end
													local v470 = v467[v469]
													local v471 = v468[v469][1]
													local v472 = v468[v469][2]
													local v473 = v468[v469][3]
													local v474 = v_u_316.CFrame * CFrame.Angles(0, math.rad(v470), 0)
													local v475 = v474.Position
													local v476 = v475 + v474.LookVector * 80
													local v477 = CFrame.Angles(math.rad(v471), math.rad(v472), (math.rad(v473)))
													local v478 = CFrame.lookAt(v475, v476) * v477
													local v479 = CFrame.lookAt(v476, v476 + v474.LookVector) * v477
													local v480 = v_u_313.X:FindFirstChild("StartVFX")
													if v480 then
														local v481 = v480:Clone()
														v481.CFrame = v478
														v481.Anchored = true
														v481.CanCollide = false
														v481.Transparency = 1
														v481.Parent = workspace
														v_u_308:AddItem(v481, 2)
														for _, v482 in v481:GetDescendants() do
															if v482:IsA("ParticleEmitter") then
																v482:Emit(v482:GetAttribute("EmitCount") or v482.Rate)
															end
														end
													end
													local v483 = v_u_313.X:FindFirstChild("SlashVFX")
													if v483 then
														local v_u_484 = v483:Clone()
														v_u_484.CFrame = v478
														v_u_484.Anchored = true
														v_u_484.CanCollide = false
														v_u_484.Transparency = 1
														v_u_484.Parent = workspace
														v_u_308:AddItem(v_u_484, 3)
														for _, v485 in v_u_484:GetDescendants() do
															if v485:IsA("ParticleEmitter") or (v485:IsA("Beam") or v485:IsA("Trail")) then
																v485.Enabled = true
															end
														end
														local v486 = v_u_309:Create(v_u_484, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															["CFrame"] = v479
														})
														v486:Play()
														v486.Completed:Connect(function()
															-- upvalues: (copy) v_u_484
															for _, v487 in v_u_484:GetDescendants() do
																if v487:IsA("ParticleEmitter") or (v487:IsA("Beam") or v487:IsA("Trail")) then
																	v487.Enabled = false
																end
															end
														end)
													end
													if v469 < 2 then
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
													local v488 = v_u_313:FindFirstChild("X")
													if v488 then
														local v489 = v488:FindFirstChild("StompVFX")
														if v489 then
															local v490 = v_u_316.Position - Vector3.new(0, 2.5, 0)
															local v491 = v489:Clone()
															local v492 = v491:FindFirstChild("Main")
															local v493 = v491:FindFirstChild("Lightning")
															if v492 then
																v492.CFrame = CFrame.new(v490)
																v492.Anchored = true
																v492.CanCollide = false
																v492.Transparency = 1
															end
															if v493 then
																v493.CFrame = CFrame.new(v490 + Vector3.new(0, 13, 0))
																v493.Anchored = true
																v493.CanCollide = false
																v493.Transparency = 1
															end
															v491.Parent = workspace
															v_u_308:AddItem(v491, 3)
															for _, v_u_494 in v491:GetDescendants() do
																if v_u_494:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_494
																		local v495 = v_u_494:GetAttribute("EmitDelay") or 0
																		task.wait(v495)
																		v_u_494:Emit(v_u_494:GetAttribute("EmitCount") or v_u_494.Rate)
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
											local v496 = v_u_313.X
											local v497 = v496 and v496:FindFirstChild("BarrageVFX")
											if v497 then
												local v_u_498 = v497:Clone()
												v_u_498.CFrame = v_u_316.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, -1.5707963267948966, 0)
												v_u_498.Anchored = false
												v_u_498.CanCollide = false
												v_u_498.Transparency = 1
												v_u_498.CastShadow = false
												v_u_498.CanQuery = false
												v_u_498.Massless = true
												v_u_498.Parent = workspace
												v_u_308:AddItem(v_u_498, 4)
												local v499 = Instance.new("WeldConstraint")
												v499.Part0 = v_u_316
												v499.Part1 = v_u_498
												v499.Parent = v_u_498
												for _, v500 in v_u_498:GetDescendants() do
													if v500:IsA("ParticleEmitter") then
														v500.Enabled = true
													end
												end
												task.delay(3.2, function()
													-- upvalues: (copy) v_u_498
													if v_u_498 and v_u_498.Parent then
														for _, v501 in v_u_498:GetDescendants() do
															if v501:IsA("ParticleEmitter") then
																v501.Enabled = false
															end
														end
													end
												end)
												return
											end
										elseif v_u_312 == "Alucard" then
											local v502 = v_u_69.Alucard
											if v502 and v502["Skill 2"] then
												local v503 = {
													["Caster"] = {
														["Character"] = v_u_315
													},
													["AbilityConfig"] = {}
												}
												v502["Skill 2"](v503)
												return
											end
										elseif v_u_312 == "GojoV2" then
											local v504 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v504 then
												v504 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v504 then
												local v505 = require(v504)
												if v505["Skill 2"] then
													v505["Skill 2"]({
														["Caster"] = {
															["Character"] = v_u_315
														},
														["Duration"] = p_u_307.Duration or 6
													})
													return
												end
											end
										elseif v_u_312 == "StrongestInHistory" then
											local v506 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v506 then
												v506 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v506 then
												local v507 = require(v506)
												if v507["Skill 2"] then
													local v508 = {
														["Caster"] = {
															["Character"] = v_u_315
														}
													}
													v507["Skill 2"](v508)
													return
												end
											end
										elseif v_u_312 == "Ichigo" then
											local v509 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v509 then
												v509 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("Ichigo")
											end
											if v509 then
												local v510 = require(v509)
												if v510 and v510["Skill 2"] then
													local v511 = {
														["Caster"] = {
															["Character"] = v_u_315
														},
														["Duration"] = 4
													}
													v510["Skill 2"](v511)
													return
												end
											end
										elseif v_u_312 == "Rimuru" then
											local v512 = v_u_69.Rimuru
											if v512 and v512["Skill 2"] then
												local v513 = {
													["Caster"] = {
														["Character"] = v_u_315
													},
													["AbilityConfig"] = {}
												}
												v512["Skill 2"](v513)
												return
											end
										else
											task.wait(0.35)
											if not (v_u_316 and v_u_316.Parent) then
												return
											end
											local v514 = v_u_316.CFrame
											local v515 = v_u_313.X:FindFirstChild("EnergySlashes")
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
											v_u_308:AddItem(v_u_516, 4)
											local v517 = Instance.new("WeldConstraint")
											v517.Part0 = v_u_516
											v517.Part1 = v_u_316
											v517.Parent = v_u_516
											v_u_308:AddItem(v517, 2.06)
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
					elseif p_u_307.VFXName == "C" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (ref) v_u_3, (copy) v_u_315, (copy) p_u_307, (ref) v_u_313, (copy) v_u_308, (copy) v_u_328, (copy) v_u_334
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "GojoV2" then
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
													["Character"] = v_u_315
												},
												["Duration"] = p_u_307.Duration or 6
											}
											v521(v522)
										end
									end
									return
								elseif v_u_312 == "StrongestInHistory" then
									local v523 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v523 then
										v523 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v523 then
										local v_u_524 = require(v523)
										if v_u_524["Skill 3"] then
											local v525 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["ChargeTime"] = 2.5
											}
											v_u_524["Skill 3"](v525)
										end
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_524, (ref) v_u_315
											if v_u_316 and v_u_316.Parent then
												local v526 = v_u_316.Position + v_u_316.CFrame.LookVector * 85
												if v_u_524["Skill 3"] then
													local v527 = v_u_524["Skill 3"]
													local v528 = {
														["Caster"] = {
															["Character"] = v_u_315
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
								elseif v_u_312 == "Gojo" then
									local v529 = v_u_313.C:FindFirstChild("DamageVFX")
									if v529 then
										local v530 = v529:Clone()
										v530.CFrame = v_u_316.CFrame
										v530.Anchored = false
										v530.CanCollide = false
										v530.Transparency = 1
										v530.Massless = true
										v530.Parent = workspace
										local v531 = Instance.new("WeldConstraint")
										v531.Part0 = v530
										v531.Part1 = v_u_316
										v531.Parent = v530
										for _, v532 in v530:GetDescendants() do
											if v532:IsA("ParticleEmitter") then
												v532:Emit(v532:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_308:AddItem(v530, 3)
									end
									return
								elseif v_u_312 == "Jinwoo" then
									local v533 = v_u_313.C
									if v533 then
										local v534 = v533:FindFirstChild("EnergySlashes")
										local v535 = v533:FindFirstChild("ShadowVFX")
										if v534 then
											local v_u_536 = v534:Clone()
											v_u_536.CFrame = v_u_316.CFrame * CFrame.new(0, 3.9, 0)
											v_u_536.Anchored = false
											v_u_536.CanCollide = false
											v_u_536.Transparency = 1
											v_u_536.CastShadow = false
											v_u_536.CanQuery = false
											v_u_536.Massless = true
											v_u_536.Parent = workspace
											v_u_308:AddItem(v_u_536, 3.65)
											local v537 = Instance.new("WeldConstraint")
											v537.Part0 = v_u_316
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
											v_u_539.CFrame = v_u_316.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_539.Anchored = false
											v_u_539.CanCollide = false
											v_u_539.Transparency = 1
											v_u_539.CastShadow = false
											v_u_539.CanQuery = false
											v_u_539.Massless = true
											v_u_539.Parent = workspace
											v_u_308:AddItem(v_u_539, 2.65)
											local v540 = Instance.new("WeldConstraint")
											v540.Part0 = v_u_316
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
								elseif v_u_312 == "Ragna" then
									local v544 = v_u_313.C
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
												-- upvalues: (ref) v_u_554, (ref) v_u_316, (copy) v_u_548, (copy) v_u_545, (ref) v_u_308, (copy) v_u_546, (copy) v_u_549
												while v_u_554 < 6 and (v_u_316 and v_u_316.Parent) do
													local v555 = 6 - v_u_554
													local v556 = math.min(2, v555)
													for v557 = 1, v556 do
														local v558 = v_u_548[v_u_554 + v557]
														local v559 = v_u_316.CFrame
														local v560 = v559:VectorToWorldSpace(v558.offset)
														local v561 = v559.Position + v560
														local v562 = v_u_545:Clone()
														v562.CFrame = CFrame.new(v561) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v562.Anchored = true
														v562.CanCollide = false
														v562.CanQuery = false
														v562.Transparency = 0
														v562.Parent = workspace
														v_u_308:AddItem(v562, 3)
														if v_u_546 then
															local v563 = v_u_546:Clone()
															v563.CFrame = v562.CFrame
															v563.Anchored = true
															v563.CanCollide = false
															v563.Transparency = 1
															v563.Parent = workspace
															v_u_308:AddItem(v563, 1)
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
												-- upvalues: (ref) v_u_316, (ref) v_u_567, (copy) v_u_549
												if v_u_316 and v_u_316.Parent then
													local v568 = (1 / 0)
													local v569 = nil
													for _, v570 in ipairs(game.Players:GetPlayers()) do
														if v570.Character and v570.Character:FindFirstChild("HumanoidRootPart") then
															local v571 = v570.Character.HumanoidRootPart
															local v572 = (v571.Position - v_u_316.Position).Magnitude
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
																v576 = CFrame.new(v575) * v_u_316.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v574.CFrame = v574.CFrame:Lerp(v576, 0.12)
														end
													end
												elseif v_u_567 then
													v_u_567:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_567, (ref) v_u_316, (copy) v_u_549, (copy) v_u_547, (ref) v_u_308
												if v_u_567 then
													v_u_567:Disconnect()
												end
												if v_u_316 and v_u_316.Parent then
													local v579 = v_u_316.Position + v_u_316.CFrame.LookVector * 30
													local v580 = (1 / 0)
													for _, v581 in ipairs(game.Players:GetPlayers()) do
														if v581.Character and v581.Character:FindFirstChild("HumanoidRootPart") then
															local v582 = v581.Character.HumanoidRootPart
															local v583 = (v582.Position - v_u_316.Position).Magnitude
															if v583 < v580 and v583 < 150 then
																v579 = v582.Position
																v580 = v583
															end
														end
													end
													local v_u_584 = CFrame.new(v579)
													for v585, v_u_586 in ipairs(v_u_549) do
														task.delay((v585 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_586, (copy) v_u_584, (ref) v_u_547, (ref) v_u_308
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
																	-- upvalues: (copy) v_u_600, (copy) v_u_588, (copy) v_u_599, (copy) v_u_592, (copy) v_u_587, (ref) v_u_547, (ref) v_u_308
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
																		v_u_308:AddItem(v614, 1.5)
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
								elseif v_u_312 == "Aizen" then
									local v_u_616 = v_u_313.C
									if v_u_616 then
										local v_u_617 = {}
										local function v_u_623(p618, p619)
											-- upvalues: (ref) v_u_316, (ref) v_u_308
											if not p618 then
												return nil
											end
											local v620 = p618:Clone()
											v620.CFrame = v_u_316.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v620.Anchored = false
											v620.CanCollide = false
											v620.Transparency = 1
											v620.CastShadow = false
											v620.CanQuery = false
											v620.Massless = true
											v620.Parent = workspace
											v_u_308:AddItem(v620, p619)
											local v621 = Instance.new("WeldConstraint")
											v621.Part0 = v_u_316
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
											-- upvalues: (ref) v_u_316, (copy) v_u_623, (copy) v_u_616, (copy) v_u_617
											if v_u_316 and v_u_316.Parent then
												local v626 = v_u_623(v_u_616:FindFirstChild("AuraVFX2"), 3.75)
												if v626 then
													local v627 = v_u_617
													table.insert(v627, v626)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_623, (copy) v_u_616, (copy) v_u_617
											if v_u_316 and v_u_316.Parent then
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
								elseif v_u_312 == "Rimuru" then
									return
								else
									local v632 = v_u_313.C:FindFirstChild("FirstEffects")
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
										v_u_633:PivotTo(v_u_316.CFrame * CFrame.new(0, -2, 0))
										v_u_633.Parent = workspace
										v_u_308:AddItem(v_u_633, 6)
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
									if v_u_316 and v_u_316.Parent then
										local v_u_636 = v_u_316.CFrame
										local v637 = v_u_313.C:FindFirstChild("HorizontalBeam")
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
											v_u_308:AddItem(v638, 6)
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
														-- upvalues: (copy) v_u_643, (ref) v_u_328, (copy) v_u_642
														if v_u_643 then
															v_u_328(v_u_643, 0.3)
														end
														for _, v646 in v_u_642:GetDescendants() do
															if v646:IsA("ParticleEmitter") and not (v_u_643 and v646:IsDescendantOf(v_u_643)) then
																v646:Emit(v646:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v645, function()
														-- upvalues: (copy) v_u_643, (ref) v_u_334
														if v_u_643 then
															v_u_334(v_u_643, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (copy) v_u_636, (ref) v_u_308, (ref) v_u_334
											if v_u_316 and v_u_316.Parent then
												local v647 = v_u_313.C:FindFirstChild("Explosion")
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
													v_u_308:AddItem(v_u_648, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_334, (copy) v_u_648
														v_u_334(v_u_648, 0.5)
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
						if v_u_312 == "QinShi" then
							task.spawn(function()
								-- upvalues: (copy) v_u_316, (ref) v_u_313, (copy) v_u_308
								if v_u_316 and v_u_316.Parent then
									local v651 = v_u_313:FindFirstChild("C")
									if v651 then
										local v652 = v651:FindFirstChild("BarrageVFX")
										if v652 then
											local v_u_653 = v652:Clone()
											v_u_653.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_653.Anchored = false
											v_u_653.CanCollide = false
											v_u_653.CanQuery = false
											v_u_653.CanTouch = false
											v_u_653.Transparency = 1
											v_u_653.CastShadow = false
											v_u_653.Parent = workspace
											local v654 = Instance.new("WeldConstraint")
											v654.Part0 = v_u_653
											v654.Part1 = v_u_316
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
											v_u_308:AddItem(v_u_653, 4)
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
									local v_u_657 = v_u_313:FindFirstChild("C")
									if v_u_657 then
										local v658 = v_u_657:FindFirstChild("AuraVFX3")
										if v658 then
											local v_u_659 = v658:Clone()
											v_u_659.CFrame = v_u_316.CFrame
											v_u_659.Anchored = false
											v_u_659.CanCollide = false
											v_u_659.Transparency = 1
											v_u_659.Massless = true
											v_u_659.Parent = workspace
											local v660 = Instance.new("WeldConstraint")
											v660.Part0 = v_u_316
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
											v_u_308:AddItem(v_u_659, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_657, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v663 = v_u_657:FindFirstChild("BlackFlashVFX3")
												if v663 then
													local v664 = v663:Clone()
													v664.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -10)
													v664.Anchored = true
													v664.CanCollide = false
													v664.Transparency = 1
													v664.Parent = workspace
													for _, v665 in v664:GetDescendants() do
														if v665:IsA("ParticleEmitter") then
															v665:Emit(v665:GetAttribute("EmitCount") or v665.Rate)
														end
													end
													v_u_308:AddItem(v664, 3)
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
							local v666 = v_u_69.Alucard
							if v666 and v666["Skill 3"] then
								v666["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_315
									},
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_312 == "Ichigo" then
							local v667 = v_u_69.Ichigo
							if v667 and v667["Skill 3"] then
								v667["Skill 3"]({
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
							local v668 = v_u_69.Rimuru
							if v668 and v668["Skill 3"] then
								v668["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_315
									},
									["AbilityConfig"] = {}
								})
							end
						end
					elseif p_u_307.VFXName == "V" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (ref) v_u_3, (copy) v_u_315, (ref) v_u_313, (copy) v_u_308, (copy) v_u_309, (copy) p_u_307, (ref) v_u_306, (ref) v_u_37, (ref) v_u_69
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "GojoV2" then
									local v669 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v669 then
										v669 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v669 then
										local v670 = require(v669)
										if v670["Skill 4"] then
											local v671 = {
												["Caster"] = {
													["Character"] = v_u_315
												}
											}
											v670["Skill 4"](v671)
										end
									end
									return
								elseif v_u_312 == "StrongestInHistory" then
									local v672 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v672 then
										v672 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v672 then
										local v673 = require(v672)
										if v673["Skill 4"] then
											local v674 = v673["Skill 4"]
											local v675 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["CutsceneDuration"] = 6.5,
												["DamageDelay"] = 5,
												["CharAnimationId"] = "rbxassetid://125013796988038"
											}
											local v676 = v_u_316
											if v676 then
												v676 = v_u_316.CFrame
											end
											v675.CFrame = v676
											v674(v675)
										end
									end
									return
								elseif v_u_312 == "Gojo" then
									local v_u_677 = v_u_313.V
									if v_u_677 then
										local v_u_678 = Instance.new("Attachment")
										v_u_678.Name = "BlueAtt"
										v_u_678.Position = Vector3.new(7, 2, 5)
										v_u_678.Parent = v_u_316
										local v_u_679 = Instance.new("Attachment")
										v_u_679.Name = "RedAtt"
										v_u_679.Position = Vector3.new(-7, 2, 5)
										v_u_679.Parent = v_u_316
										local v_u_680 = nil
										local v_u_681 = nil
										local function v_u_690(p682, p683)
											-- upvalues: (copy) v_u_677, (ref) v_u_316
											local v684 = v_u_677:FindFirstChild(p682)
											if not v684 then
												return nil
											end
											local v685 = v684:Clone()
											v685.CFrame = v_u_316.CFrame * CFrame.new(p683.Position)
											v685.Anchored = true
											v685.CanCollide = false
											v685.Massless = true
											v685.Transparency = 1
											v685.Parent = workspace
											local v686 = Instance.new("Attachment")
											v686.Parent = v685
											local v687 = Instance.new("AlignPosition")
											v687.Attachment0 = v686
											v687.Attachment1 = p683
											v687.RigidityEnabled = false
											v687.Responsiveness = 100
											v687.MaxForce = (1 / 0)
											v687.Parent = v685
											local v688 = Instance.new("AlignOrientation")
											v688.Attachment0 = v686
											v688.Attachment1 = p683
											v688.RigidityEnabled = false
											v688.Responsiveness = 100
											v688.MaxTorque = (1 / 0)
											v688.Parent = v685
											v685.Anchored = false
											for _, v689 in v685:GetDescendants() do
												if v689:IsA("ParticleEmitter") then
													v689.Enabled = true
												elseif v689:IsA("Beam") or v689:IsA("Trail") then
													v689.Enabled = true
												end
											end
											return v685
										end
										local function v_u_694(p691, p692)
											if p691 and p691.Parent then
												for _, v_u_693 in p691:GetDescendants() do
													if v_u_693:IsA("ParticleEmitter") then
														v_u_693.Enabled = false
														if p692 then
															pcall(function()
																-- upvalues: (copy) v_u_693
																v_u_693:Clear()
															end)
														end
													elseif v_u_693:IsA("Beam") or v_u_693:IsA("Trail") then
														v_u_693.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_680, (copy) v_u_690, (copy) v_u_678, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_680 = v_u_690("Blue", v_u_678)
												if v_u_680 then
													v_u_308:AddItem(v_u_680, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_681, (copy) v_u_690, (copy) v_u_679, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_681 = v_u_690("Red", v_u_679)
												if v_u_681 then
													v_u_308:AddItem(v_u_681, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_309, (copy) v_u_678, (copy) v_u_679, (copy) v_u_677, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v695 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_309:Create(v_u_678, v695, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_309:Create(v_u_679, v695, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_316, (ref) v_u_677, (ref) v_u_308
													if v_u_316 and v_u_316.Parent then
														local v696 = v_u_677:FindFirstChild("StarEff")
														if v696 then
															local v697 = v696:Clone()
															v697.CFrame = v_u_316.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v697.Anchored = true
															v697.CanCollide = false
															v697.Transparency = 1
															v697.Parent = workspace
															for _, v698 in v697:GetDescendants() do
																if v698:IsA("ParticleEmitter") then
																	v698:Emit(v698:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_308:AddItem(v697, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_694, (ref) v_u_680, (ref) v_u_681, (copy) v_u_678, (copy) v_u_679, (copy) v_u_677, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_694(v_u_680, true)
												v_u_694(v_u_681, true)
												if v_u_678 and v_u_678.Parent then
													v_u_678:Destroy()
												end
												if v_u_679 and v_u_679.Parent then
													v_u_679:Destroy()
												end
												local v699 = v_u_677:FindFirstChild("MiniExplosionVFX")
												if v699 then
													local v700 = v699:Clone()
													v700.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -2)
													v700.Anchored = true
													v700.CanCollide = false
													v700.Transparency = 1
													v700.Parent = workspace
													for _, v701 in v700:GetDescendants() do
														if v701:IsA("ParticleEmitter") then
															v701:Emit(v701:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_308:AddItem(v700, 3)
												end
												local v_u_702 = v_u_316.Position + v_u_316.CFrame.LookVector * 6
												local v_u_703 = v_u_316.CFrame.LookVector
												local v704 = v_u_677:FindFirstChild("Purple")
												if v704 then
													local v_u_705 = v704:Clone()
													v_u_705.Anchored = true
													v_u_705.CanCollide = false
													v_u_705.Parent = workspace
													v_u_308:AddItem(v_u_705, 3)
													for _, v706 in v_u_705:GetDescendants() do
														if v706:IsA("ParticleEmitter") then
															v706.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_702, (copy) v_u_705, (copy) v_u_703
														local v707 = v_u_702
														local v708 = 0
														while v708 < 200 and (v_u_705 and v_u_705.Parent) do
															v707 = v707 + v_u_703 * 3.9899999999999998
															v708 = v708 + 3.9899999999999998
															v_u_705.CFrame = CFrame.lookAt(v707, v707 + v_u_703)
															task.wait(0.03)
														end
														for _, v709 in v_u_705:GetDescendants() do
															if v709:IsA("ParticleEmitter") then
																v709.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_312 == "Sukuna" then
									local v_u_710 = v_u_313.V
									if v_u_710 then
										local v711 = (p_u_307.NPCModel or "NPC") .. "_SukunaV"
										local v712 = tick()
										if not v_u_306[v711] or v712 - v_u_306[v711] > 0.5 then
											v_u_306[v711] = v712
											v_u_37:PlayAt("SukunaV_Part1", p_u_307.Position)
										end
										local v713 = v_u_710:FindFirstChild("GroundVFX")
										if v713 then
											local v_u_714 = v713:Clone()
											v_u_714.CFrame = v_u_316.CFrame * CFrame.new(0, -2, 0)
											v_u_714.Anchored = false
											v_u_714.Parent = workspace
											v_u_308:AddItem(v_u_714, 3)
											local v715 = Instance.new("WeldConstraint")
											v715.Part0 = v_u_316
											v715.Part1 = v_u_714
											v715.Parent = v_u_714
											for _, v716 in v_u_714:GetDescendants() do
												if v716:IsA("ParticleEmitter") then
													v716.Enabled = true
													v716:Emit(v716:GetAttribute("EmitCount") or 40)
												elseif v716:IsA("Beam") then
													v716.Enabled = true
												end
											end
											task.delay(2.35, function()
												-- upvalues: (copy) v_u_714
												if v_u_714 and v_u_714.Parent then
													for _, v717 in v_u_714:GetDescendants() do
														if v717:IsA("ParticleEmitter") then
															v717.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_710, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v718 = v_u_710:FindFirstChild("MiniExplosionVFX")
												if v718 then
													local v719 = v718:Clone()
													v719.CFrame = v_u_316.CFrame * CFrame.new(1, 0, 0)
													v719.Anchored = false
													v719.Parent = workspace
													v_u_308:AddItem(v719, 2)
													local v720 = Instance.new("WeldConstraint")
													v720.Part0 = v_u_316
													v720.Part1 = v719
													v720.Parent = v719
													for _, v721 in v719:GetDescendants() do
														if v721:IsA("ParticleEmitter") then
															v721:Emit(v721:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v722 = v_u_710:FindFirstChild("ArrowVFX")
												if v722 then
													local v_u_723 = v722:Clone()
													v_u_723.CFrame = v_u_316.CFrame * CFrame.new(1, 0, 0)
													v_u_723.Anchored = false
													v_u_723.Parent = workspace
													v_u_308:AddItem(v_u_723, 2)
													local v724 = Instance.new("WeldConstraint")
													v724.Part0 = v_u_316
													v724.Part1 = v_u_723
													v724.Parent = v_u_723
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_723
														if v_u_723 and v_u_723.Parent then
															for _, v725 in v_u_723:GetDescendants() do
																if v725:IsA("ParticleEmitter") or v725:IsA("Beam") then
																	v725.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_316, (ref) p_u_307, (ref) v_u_306, (ref) v_u_37, (copy) v_u_710, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v726 = (p_u_307.NPCModel or "NPC") .. "_SukunaV2"
												local v727 = tick()
												if not v_u_306[v726] or v727 - v_u_306[v726] > 0.5 then
													v_u_306[v726] = v727
													v_u_37:PlayAt("SukunaV_Part2", v_u_316.Position)
												end
												local v728 = v_u_316.CFrame.LookVector
												local v729 = v_u_316.Position + v728 * 85
												local v730 = v_u_710:FindFirstChild("ExplosionVFX")
												if v730 then
													local v_u_731 = v730:Clone()
													if v_u_731:IsA("Model") then
														v_u_731:PivotTo(CFrame.new(v729) * CFrame.new(0, 73, 0))
													else
														v_u_731.CFrame = CFrame.new(v729) * CFrame.new(0, 73, 0)
													end
													v_u_731.Parent = workspace
													v_u_308:AddItem(v_u_731, 4)
													for _, v732 in v_u_731:GetDescendants() do
														if v732:IsA("ParticleEmitter") then
															v732.Enabled = true
															v732:Emit(v732:GetAttribute("EmitCount") or 30)
														elseif v732:IsA("Beam") or v732:IsA("Trail") then
															v732.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_731
														if v_u_731 and v_u_731.Parent then
															for _, v733 in v_u_731:GetDescendants() do
																if v733:IsA("ParticleEmitter") or (v733:IsA("Beam") or v733:IsA("Trail")) then
																	v733.Enabled = false
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
									local v_u_734 = v_u_313.V
									if v_u_734 then
										local v735 = v_u_734:FindFirstChild("FirstEffects")
										if v735 then
											local v_u_736 = v735:Clone()
											v_u_736.CFrame = v_u_316.CFrame * CFrame.new(0, -2.5, 0)
											v_u_736.Anchored = false
											v_u_736.CanCollide = false
											v_u_736.Transparency = 1
											v_u_736.CastShadow = false
											v_u_736.CanQuery = false
											v_u_736.Massless = true
											v_u_736.Parent = workspace
											v_u_308:AddItem(v_u_736, 6)
											local v737 = Instance.new("WeldConstraint")
											v737.Part0 = v_u_316
											v737.Part1 = v_u_736
											v737.Parent = v_u_736
											for _, v738 in v_u_736:GetDescendants() do
												if v738:IsA("ParticleEmitter") then
													v738.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_736
												if v_u_736 and v_u_736.Parent then
													for _, v739 in v_u_736:GetDescendants() do
														if v739:IsA("ParticleEmitter") then
															v739.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_734, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v740 = v_u_734:FindFirstChild("UltVFX")
												if v740 then
													local v_u_741 = v740:Clone()
													v_u_741:PivotTo(v_u_316.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v742 in v_u_741:GetDescendants() do
														if v742:IsA("BasePart") then
															v742.Anchored = true
															v742.CanCollide = false
															v742.CastShadow = false
															v742.CanQuery = false
														end
													end
													v_u_741.Parent = workspace
													v_u_308:AddItem(v_u_741, 4.5)
													for _, v743 in v_u_741:GetDescendants() do
														if v743:IsA("ParticleEmitter") then
															v743.Enabled = true
														elseif v743:IsA("Beam") then
															v743.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_741
														if v_u_741 and v_u_741.Parent then
															for _, v744 in v_u_741:GetDescendants() do
																if v744:IsA("ParticleEmitter") then
																	v744.Enabled = false
																end
															end
															for _, v_u_745 in v_u_741:GetDescendants() do
																if v_u_745:IsA("Beam") then
																	local v_u_746 = v_u_745.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_746, (copy) v_u_745
																		local v747 = tick()
																		while tick() - v747 < 0.5 do
																			local v748 = (tick() - v747) / 0.5
																			local v749 = {}
																			for _, v750 in ipairs(v_u_746) do
																				local v751 = v750.Value + (1 - v750.Value) * v748
																				local v752 = NumberSequenceKeypoint.new
																				local v753 = v750.Time
																				table.insert(v749, v752(v753, v751))
																			end
																			v_u_745.Transparency = NumberSequence.new(v749)
																			task.wait()
																		end
																		v_u_745.Transparency = NumberSequence.new(1)
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
										local v754 = v_u_69.Ichigo
										if v754 and v754["Skill 4"] then
											local v755 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["CutsceneDuration"] = 8.33,
												["CharAnimationId"] = "rbxassetid://98446587158184",
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v754["Skill 4"](v755)
											return
										end
									elseif v_u_312 == "Alucard" then
										local v756 = v_u_69.Alucard
										if v756 and v756["Skill 4"] then
											local v757 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["AbilityConfig"] = {},
												["CutsceneDuration"] = 5.5,
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v756["Skill 4"](v757)
											return
										end
									elseif v_u_312 == "Rimuru" then
										local v758 = v_u_69.Rimuru
										if v758 and v758["Skill 4"] then
											local v759 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v758["Skill 4"](v759)
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
									local v760 = v_u_69.Rimuru
									if v760 and v760["Skill 5"] then
										local v761 = {
											["Caster"] = {
												["Character"] = v_u_315
											},
											["AbilityConfig"] = {},
											["DisableCutscene"] = true
										}
										v760["Skill 5"](v761)
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
	local v_u_763 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p764, p_u_765)
		-- upvalues: (copy) v_u_763, (copy) v_u_762, (copy) v_u_44, (copy) v_u_37, (copy) v_u_299, (copy) v_u_7, (copy) v_u_305, (copy) v_u_4
		if p764 == "SpawnVFX" then
			if p_u_765.IsNPC and (p_u_765.VFXName == "Z" or (p_u_765.VFXName == "X" or (p_u_765.VFXName == "C" or (p_u_765.VFXName == "V" or p_u_765.VFXName == "F")))) then
				local v766 = (p_u_765.NPCModel or "NPC") .. "_" .. p_u_765.VFXName
				local v767 = tick()
				if v_u_763[v766] and v767 - v_u_763[v766] < 1 then
					return
				end
				v_u_763[v766] = v767
				task.spawn(function()
					-- upvalues: (ref) v_u_762, (copy) p_u_765
					v_u_762(p_u_765)
				end)
				local v768 = p_u_765.MovesetType or "Saber"
				if p_u_765.VFXName == "Z" then
					if v768 == "Gojo" then
						local v769 = (p_u_765.NPCModel or "unknown") .. "_Z"
						local v770 = tick()
						local v771
						if v_u_44[v769] and v770 - v_u_44[v769] < 1.5 then
							v771 = false
						else
							v_u_44[v769] = v770
							v771 = true
						end
						if v771 then
							v_u_37:PlayAt("GojoZ", p_u_765.Position)
						end
					elseif v768 == "Sukuna" then
						local v772 = (p_u_765.NPCModel or "unknown") .. "_Z"
						local v773 = tick()
						local v774
						if v_u_44[v772] and v773 - v_u_44[v772] < 1.5 then
							v774 = false
						else
							v_u_44[v772] = v773
							v774 = true
						end
						if v774 then
							v_u_37:PlayAt("SukunaZ", p_u_765.Position)
						end
					elseif v768 == "Jinwoo" then
						local v775 = (p_u_765.NPCModel or "unknown") .. "_Z"
						local v776 = tick()
						local v777
						if v_u_44[v775] and v776 - v_u_44[v775] < 1.5 then
							v777 = false
						else
							v_u_44[v775] = v776
							v777 = true
						end
						if v777 then
							v_u_37:PlayAt("JinwooZ", p_u_765.Position)
						end
					elseif v768 == "Ragna" then
						local v778 = (p_u_765.NPCModel or "unknown") .. "_Z"
						local v779 = tick()
						local v780
						if v_u_44[v778] and v779 - v_u_44[v778] < 1.5 then
							v780 = false
						else
							v_u_44[v778] = v779
							v780 = true
						end
						if v780 then
							v_u_37:PlayAt("RagnaZ", p_u_765.Position)
						end
					elseif v768 == "Aizen" then
						local v781 = (p_u_765.NPCModel or "unknown") .. "_Z"
						local v782 = tick()
						local v783
						if v_u_44[v781] and v782 - v_u_44[v781] < 1.5 then
							v783 = false
						else
							v_u_44[v781] = v782
							v783 = true
						end
						if v783 then
							v_u_37:PlayAt("AizenZ", p_u_765.Position)
						end
					elseif v768 == "QinShi" then
						local v784 = (p_u_765.NPCModel or "unknown") .. "_Z"
						local v785 = tick()
						local v786
						if v_u_44[v784] and v785 - v_u_44[v784] < 1.5 then
							v786 = false
						else
							v_u_44[v784] = v785
							v786 = true
						end
						if v786 then
							v_u_37:PlayAt("QinShiZ", p_u_765.Position)
						end
					elseif v768 == "Yuji" then
						local v787 = (p_u_765.NPCModel or "unknown") .. "_Z"
						local v788 = tick()
						local v789
						if v_u_44[v787] and v788 - v_u_44[v787] < 1.5 then
							v789 = false
						else
							v_u_44[v787] = v788
							v789 = true
						end
						if v789 then
							v_u_37:PlayAt("YujiZ", p_u_765.Position)
						end
					elseif v768 ~= "Alucard" then
						if v768 == "GojoV2" then
							local v790 = (p_u_765.NPCModel or "unknown") .. "_Z"
							local v791 = tick()
							local v792
							if v_u_44[v790] and v791 - v_u_44[v790] < 1.5 then
								v792 = false
							else
								v_u_44[v790] = v791
								v792 = true
							end
							if v792 then
								v_u_37:PlayAt("GojoV2Z", p_u_765.Position)
							end
						elseif v768 ~= "StrongestInHistory" then
							local v793 = (p_u_765.NPCModel or "unknown") .. "_Z"
							local v794 = tick()
							local v795
							if v_u_44[v793] and v794 - v_u_44[v793] < 1.5 then
								v795 = false
							else
								v_u_44[v793] = v794
								v795 = true
							end
							if v795 then
								v_u_37:PlayAt("SaberZ", p_u_765.Position)
							end
						end
					end
				elseif p_u_765.VFXName == "X" then
					if v768 == "Gojo" then
						local v796 = (p_u_765.NPCModel or "unknown") .. "_X"
						local v797 = tick()
						local v798
						if v_u_44[v796] and v797 - v_u_44[v796] < 1.5 then
							v798 = false
						else
							v_u_44[v796] = v797
							v798 = true
						end
						if v798 then
							v_u_37:PlayAt("GojoX", p_u_765.Position)
						end
					elseif v768 == "Sukuna" then
						local v799 = (p_u_765.NPCModel or "unknown") .. "_X"
						local v800 = tick()
						local v801
						if v_u_44[v799] and v800 - v_u_44[v799] < 1.5 then
							v801 = false
						else
							v_u_44[v799] = v800
							v801 = true
						end
						if v801 then
							v_u_37:PlayAt("SukunaX", p_u_765.Position)
						end
					elseif v768 == "Jinwoo" then
						local v802 = (p_u_765.NPCModel or "unknown") .. "_X"
						local v803 = tick()
						local v804
						if v_u_44[v802] and v803 - v_u_44[v802] < 1.5 then
							v804 = false
						else
							v_u_44[v802] = v803
							v804 = true
						end
						if v804 then
							v_u_37:PlayAt("JinwooX", p_u_765.Position)
						end
					elseif v768 == "Ragna" then
						local v805 = (p_u_765.NPCModel or "unknown") .. "_X"
						local v806 = tick()
						local v807
						if v_u_44[v805] and v806 - v_u_44[v805] < 1.5 then
							v807 = false
						else
							v_u_44[v805] = v806
							v807 = true
						end
						if v807 then
							v_u_37:PlayAt("RagnaX", p_u_765.Position)
						end
					elseif v768 == "Aizen" then
						local v808 = (p_u_765.NPCModel or "unknown") .. "_X"
						local v809 = tick()
						local v810
						if v_u_44[v808] and v809 - v_u_44[v808] < 1.5 then
							v810 = false
						else
							v_u_44[v808] = v809
							v810 = true
						end
						if v810 then
							v_u_37:PlayAt("AizenX", p_u_765.Position)
						end
					elseif v768 == "QinShi" then
						local v811 = (p_u_765.NPCModel or "unknown") .. "_X"
						local v812 = tick()
						local v813
						if v_u_44[v811] and v812 - v_u_44[v811] < 1.5 then
							v813 = false
						else
							v_u_44[v811] = v812
							v813 = true
						end
						if v813 then
							v_u_37:PlayAt("QinShiX", p_u_765.Position)
						end
					elseif v768 == "Yuji" then
						local v814 = (p_u_765.NPCModel or "unknown") .. "_X"
						local v815 = tick()
						local v816
						if v_u_44[v814] and v815 - v_u_44[v814] < 1.5 then
							v816 = false
						else
							v_u_44[v814] = v815
							v816 = true
						end
						if v816 then
							v_u_37:PlayAt("YujiX", p_u_765.Position)
						end
					elseif v768 ~= "Ichigo" and v768 ~= "Alucard" then
						if v768 == "GojoV2" then
							local v817 = (p_u_765.NPCModel or "unknown") .. "_X"
							local v818 = tick()
							local v819
							if v_u_44[v817] and v818 - v_u_44[v817] < 1.5 then
								v819 = false
							else
								v_u_44[v817] = v818
								v819 = true
							end
							if v819 then
								v_u_37:PlayAt("GojoV2X", p_u_765.Position)
							end
						elseif v768 ~= "StrongestInHistory" then
							local v820 = (p_u_765.NPCModel or "unknown") .. "_X"
							local v821 = tick()
							local v822
							if v_u_44[v820] and v821 - v_u_44[v820] < 1.5 then
								v822 = false
							else
								v_u_44[v820] = v821
								v822 = true
							end
							if v822 then
								v_u_37:PlayAt("SaberX", p_u_765.Position)
							end
						end
					end
				elseif p_u_765.VFXName == "C" then
					if v768 == "Gojo" then
						local v823 = (p_u_765.NPCModel or "unknown") .. "_C"
						local v824 = tick()
						local v825
						if v_u_44[v823] and v824 - v_u_44[v823] < 1.5 then
							v825 = false
						else
							v_u_44[v823] = v824
							v825 = true
						end
						if v825 then
							v_u_37:PlayAt("GojoC", p_u_765.Position)
							v_u_37:PlayAt("GojoC_Hold", p_u_765.Position)
						end
					elseif v768 == "Jinwoo" then
						local v826 = (p_u_765.NPCModel or "unknown") .. "_C"
						local v827 = tick()
						local v828
						if v_u_44[v826] and v827 - v_u_44[v826] < 1.5 then
							v828 = false
						else
							v_u_44[v826] = v827
							v828 = true
						end
						if v828 then
							v_u_37:PlayAt("JinwooC", p_u_765.Position)
						end
					elseif v768 == "Ragna" then
						local v829 = (p_u_765.NPCModel or "unknown") .. "_C"
						local v830 = tick()
						local v831
						if v_u_44[v829] and v830 - v_u_44[v829] < 1.5 then
							v831 = false
						else
							v_u_44[v829] = v830
							v831 = true
						end
						if v831 then
							v_u_37:PlayAt("RagnaC_Startup", p_u_765.Position)
						end
					elseif v768 == "Aizen" then
						local v832 = (p_u_765.NPCModel or "unknown") .. "_C"
						local v833 = tick()
						local v834
						if v_u_44[v832] and v833 - v_u_44[v832] < 1.5 then
							v834 = false
						else
							v_u_44[v832] = v833
							v834 = true
						end
						if v834 then
							v_u_37:PlayAt("AizenC", p_u_765.Position)
						end
					elseif v768 == "QinShi" then
						local v835 = (p_u_765.NPCModel or "unknown") .. "_C"
						local v836 = tick()
						local v837
						if v_u_44[v835] and v836 - v_u_44[v835] < 1.5 then
							v837 = false
						else
							v_u_44[v835] = v836
							v837 = true
						end
						if v837 then
							v_u_37:PlayAt("QinShiC", p_u_765.Position)
						end
					elseif v768 == "Yuji" then
						local v838 = (p_u_765.NPCModel or "unknown") .. "_C"
						local v839 = tick()
						local v840
						if v_u_44[v838] and v839 - v_u_44[v838] < 1.5 then
							v840 = false
						else
							v_u_44[v838] = v839
							v840 = true
						end
						if v840 then
							v_u_37:PlayAt("YujiC_Press", p_u_765.Position)
						end
					elseif v768 ~= "Ichigo" and (v768 ~= "Alucard" and (v768 ~= "GojoV2" and (v768 ~= "StrongestInHistory" and v768 ~= "Rimuru"))) then
						local v841 = (p_u_765.NPCModel or "unknown") .. "_C"
						local v842 = tick()
						local v843
						if v_u_44[v841] and v842 - v_u_44[v841] < 1.5 then
							v843 = false
						else
							v_u_44[v841] = v842
							v843 = true
						end
						if v843 then
							v_u_37:PlayAt("SaberC_Cast", p_u_765.Position)
							task.delay(3.85, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_765
								v_u_37:PlayAt("SaberC_Beam", p_u_765.Position)
							end)
							task.delay(4.4, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_765
								v_u_37:PlayAt("SaberC_Explosion", p_u_765.Position)
							end)
						end
					end
				elseif p_u_765.VFXName == "V" then
					if v768 == "Gojo" then
						v_u_37:PlayAt("GojoV", p_u_765.Position)
					elseif v768 ~= "Sukuna" and (v768 ~= "Ichigo" and (v768 ~= "Alucard" and (v768 ~= "GojoV2" and v768 ~= "StrongestInHistory"))) then
						local _ = v768 == "Rimuru"
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_299, (copy) p_u_765
					v_u_299.SpawnVFX(p_u_765.VFXName, p_u_765.Position, p_u_765.Scale, p_u_765.Duration, p_u_765.AbilityName)
				end)
			end
			if p_u_765.CameraShake then
				task.delay(p_u_765.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_765, (ref) v_u_7
					local v_u_844 = p_u_765.CameraShake.Intensity or 5
					local v_u_845 = p_u_765.CameraShake.Duration or 0.3
					if v_u_7:GetAttribute("DisableScreenShake") then
						return
					else
						local v_u_846 = workspace.CurrentCamera
						if v_u_846 then
							task.spawn(function()
								-- upvalues: (copy) v_u_846, (copy) v_u_845, (copy) v_u_844
								local v847 = tick()
								local _ = v_u_846.CFrame
								while tick() - v847 < v_u_845 do
									local v848 = v_u_844 * (1 - (tick() - v847) / v_u_845)
									local v849 = (math.random() - 0.5) * v848 * 0.1
									local v850 = (math.random() - 0.5) * v848 * 0.1
									v_u_846.CFrame = v_u_846.CFrame * CFrame.new(v849, v850, 0)
									task.wait()
								end
							end)
						end
					end
				end)
			end
			if p_u_765.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_305, (copy) p_u_765
					v_u_305(p_u_765.ScreenFlash)
				end)
				return
			end
		elseif p764 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_299, (copy) p_u_765, (ref) v_u_4
				local v851 = v_u_299.SpawnVFXWithRotation(p_u_765.VFXName, p_u_765.Position, p_u_765.Rotation, p_u_765.Scale, p_u_765.Duration, "KatanaAbilities")
				if v851 then
					v_u_4:AddItem(v851, (p_u_765.Duration or 0.4) + 1)
				end
			end)
			if p_u_765.IsNPC then
				v_u_37:PlayAt("KatanaZ", p_u_765.Position)
			end
			if p_u_765.CameraShake then
				local v_u_852 = p_u_765.CameraShake.Intensity or 3
				local v_u_853 = p_u_765.CameraShake.Duration or 0.2
				if v_u_7:GetAttribute("DisableScreenShake") then
					return
				else
					local v_u_854 = workspace.CurrentCamera
					if v_u_854 then
						task.spawn(function()
							-- upvalues: (copy) v_u_854, (copy) v_u_853, (copy) v_u_852
							local v855 = tick()
							local _ = v_u_854.CFrame
							while tick() - v855 < v_u_853 do
								local v856 = v_u_852 * (1 - (tick() - v855) / v_u_853)
								local v857 = (math.random() - 0.5) * v856 * 0.1
								local v858 = (math.random() - 0.5) * v856 * 0.1
								v_u_854.CFrame = v_u_854.CFrame * CFrame.new(v857, v858, 0)
								task.wait()
							end
						end)
					end
				end
			end
		elseif p764 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_299, (copy) p_u_765, (ref) v_u_4
				local v859 = v_u_299.SpawnTravelingVFX(p_u_765.VFXName, p_u_765.StartPosition, p_u_765.Direction, p_u_765.TravelDistance, p_u_765.TravelSpeed, p_u_765.Scale, p_u_765.Duration, "KatanaAbilities")
				if v859 then
					v_u_4:AddItem(v859, (p_u_765.TravelDistance or 50) / (p_u_765.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_765.CameraShake then
				local v_u_860 = p_u_765.CameraShake.Intensity or 6
				local v_u_861 = p_u_765.CameraShake.Duration or 0.3
				local v_u_862 = not v_u_7:GetAttribute("DisableScreenShake") and workspace.CurrentCamera
				if v_u_862 then
					task.spawn(function()
						-- upvalues: (copy) v_u_862, (copy) v_u_861, (copy) v_u_860
						local v863 = tick()
						local _ = v_u_862.CFrame
						while tick() - v863 < v_u_861 do
							local v864 = v_u_860 * (1 - (tick() - v863) / v_u_861)
							local v865 = (math.random() - 0.5) * v864 * 0.1
							local v866 = (math.random() - 0.5) * v864 * 0.1
							v_u_862.CFrame = v_u_862.CFrame * CFrame.new(v865, v866, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_765.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_305, (copy) p_u_765
					v_u_305(p_u_765.ScreenFlash)
				end)
			end
		end
	end)
	local v867 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_868 = 1
	v867.OnClientEvent:Connect(function(p869)
		-- upvalues: (ref) v_u_868, (copy) v_u_37
		if p869 and p869.Position then
			v_u_37:PlayAt("CombatHit" .. v_u_868, p869.Position)
			v_u_868 = v_u_868 % 7 + 1
		end
	end)
	local v_u_870 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v871 = v46:WaitForChild("HitboxVisualize", 5)
	if v871 then
		v871.OnClientEvent:Connect(function(p872)
			-- upvalues: (copy) v_u_870
			if p872.Type == "Box" then
				v_u_870.ShowBox(p872.CFrame, p872.Size, p872.Duration, p872.Color)
				return
			elseif p872.Type == "Sphere" then
				v_u_870.ShowSphere(p872.Position, p872.Radius, p872.Duration, p872.Color)
				return
			elseif p872.Type == "Traveling" then
				v_u_870.ShowTraveling(p872.StartPos, p872.Direction, p872.Size, p872.Speed, p872.Distance, p872.HitboxType, p872.Color)
			elseif p872.Type == "FollowingAOE" then
				local v873 = p872.Character
				if v873 then
					v_u_870.ShowFollowingAOE(v873, p872.Size, p872.Duration, p872.Offset, p872.Color, p872.Shape)
					return
				end
			else
				if p872.Type == "MultiWave" then
					v_u_870.ShowMultiWave(p872.OriginCFrame, p872.Waves)
					return
				end
				if p872.Type == "Explosion" then
					v_u_870.ShowExplosion(p872.Position, p872.Radius, p872.Duration, p872.Color)
					return
				end
				if p872.Type == "StaticBox" then
					v_u_870.ShowStaticBox(p872.StartPos, p872.EndPos, p872.Width, p872.Height, p872.Duration, p872.Color)
				end
			end
		end)
	end
end)
if not v874 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v875)
	warn("=====================================")
end