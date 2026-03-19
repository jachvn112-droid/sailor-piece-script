local v865, v866 = pcall(function()
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
	local function v_u_753(p_u_307)
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
										else
											task.wait(0.45)
											if not (v_u_316 and v_u_316.Parent) then
												return
											end
											local v400 = v_u_316.CFrame
											local v401 = v_u_313.Z:FindFirstChild("EnergyThrust")
											local v402 = v_u_313.Z:FindFirstChild("EnergyPart")
											if v401 then
												v_u_322(v401, v400 * CFrame.new(0, 2, -35), 3)
											end
											if v402 then
												v_u_322(v402, v400 * CFrame.new(0, 2, -2), 3)
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
									local v_u_403 = v_u_315:FindFirstChild("Right Arm")
									if v_u_403 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (copy) v_u_403, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v404 = v_u_313.X:FindFirstChild("BlueVFXFirst")
												if v404 then
													local v405 = v404:Clone()
													v405.CFrame = v_u_403.CFrame * CFrame.new(0, -1.05, 0)
													v405.Anchored = true
													v405.CanCollide = false
													v405.Transparency = 1
													v405.CastShadow = false
													v405.CanQuery = false
													v405.Parent = workspace
													v_u_308:AddItem(v405, 4)
													for _, v_u_406 in v405:GetDescendants() do
														if v_u_406:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_406
																local v407 = v_u_406:GetAttribute("EmitDelay") or 0
																task.wait(v407)
																v_u_406:Emit(v_u_406:GetAttribute("EmitCount") or v_u_406.Rate)
															end)
														end
													end
													v405.Anchored = false
													local v408 = Instance.new("WeldConstraint")
													v408.Part0 = v_u_403
													v408.Part1 = v405
													v408.Parent = v405
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v409 = v_u_316.CFrame
												local v410 = v_u_313.X:FindFirstChild("BlueMainVFX")
												if v410 then
													local v411 = v410:Clone()
													v411.CFrame = v409 * CFrame.new(0, 0, -25)
													v411.Anchored = true
													v411.CanCollide = false
													v411.Transparency = 1
													v411.CastShadow = false
													v411.CanQuery = false
													v411.Parent = workspace
													v_u_308:AddItem(v411, 3)
													for _, v_u_412 in v411:GetDescendants() do
														if v_u_412:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_412
																local v413 = v_u_412:GetAttribute("EmitDelay") or 0
																task.wait(v413)
																v_u_412:Emit(v_u_412:GetAttribute("EmitCount") or v_u_412.Rate)
															end)
														end
													end
												end
												local v414 = v_u_313.X:FindFirstChild("Blue_Additional_VFX")
												if v414 then
													local v415 = v414:Clone()
													v415.CFrame = v409 * CFrame.new(0, 0, -5)
													v415.Anchored = true
													v415.CanCollide = false
													v415.Transparency = 1
													v415.CastShadow = false
													v415.CanQuery = false
													v415.Parent = workspace
													v_u_308:AddItem(v415, 4)
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
											end
										end)
									end
								else
									if v_u_312 == "Sukuna" then
										local v418 = v_u_313.X
										if not v418 then
											return
										end
										local v419 = v418:FindFirstChild("GroundVFX")
										if v419 then
											local v_u_420 = v419:Clone()
											v_u_420:PivotTo(v_u_316.CFrame * CFrame.new(0, -2.5, 0))
											v_u_420.Parent = workspace
											v_u_308:AddItem(v_u_420, 3.5)
											local v421 = v_u_420.PrimaryPart or v_u_420:FindFirstChildWhichIsA("BasePart")
											for _, v422 in v_u_420:GetDescendants() do
												if v422:IsA("BasePart") then
													v422.Anchored = false
													v422.CanCollide = false
													v422.CanQuery = false
													v422.CanTouch = false
													v422.Massless = true
												end
											end
											if v421 then
												local v423 = Instance.new("WeldConstraint")
												v423.Part0 = v_u_316
												v423.Part1 = v421
												v423.Parent = v421
											end
											task.delay(2.6, function()
												-- upvalues: (copy) v_u_420
												if v_u_420 and v_u_420.Parent then
													for _, v424 in v_u_420:GetDescendants() do
														if v424:IsA("ParticleEmitter") then
															v424.Enabled = false
														end
													end
												end
											end)
											return
										end
									elseif v_u_312 == "Jinwoo" then
										local v425 = v_u_313.X
										if not v425 then
											return
										end
										local v426 = v425:FindFirstChild("DashVFX")
										local v427 = v425:FindFirstChild("SlashesVFX")
										local v428 = v_u_316.CFrame.LookVector
										local v429 = CFrame.lookAt(v_u_316.Position, v_u_316.Position + v428)
										if v426 then
											local v_u_430 = v426:Clone()
											v_u_430.CFrame = v429
											v_u_430.Anchored = false
											v_u_430.CanCollide = false
											v_u_430.Transparency = 1
											v_u_430.CastShadow = false
											v_u_430.CanQuery = false
											v_u_430.Massless = true
											v_u_430.Parent = workspace
											v_u_308:AddItem(v_u_430, 1.5)
											local v431 = Instance.new("WeldConstraint")
											v431.Part0 = v_u_316
											v431.Part1 = v_u_430
											v431.Parent = v_u_430
											for _, v432 in v_u_430:GetDescendants() do
												if v432:IsA("ParticleEmitter") then
													v432.Enabled = true
													v432:Emit(v432:GetAttribute("EmitCount") or 30)
												end
											end
											task.delay(0.5, function()
												-- upvalues: (copy) v_u_430
												if v_u_430 and v_u_430.Parent then
													for _, v433 in v_u_430:GetDescendants() do
														if v433:IsA("ParticleEmitter") then
															v433.Enabled = false
														end
													end
												end
											end)
										end
										if v427 then
											local v434 = v427:Clone()
											v434.CFrame = v429 * CFrame.new(0, 0, -20)
											v434.Anchored = true
											v434.CanCollide = false
											v434.Transparency = 1
											v434.CastShadow = false
											v434.CanQuery = false
											v434.Parent = workspace
											v_u_308:AddItem(v434, 1.5)
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
											return
										end
									elseif v_u_312 == "Ragna" then
										local v_u_437 = v_u_313.X
										if v_u_437 then
											local v438 = v_u_437:FindFirstChild("GroundVFX")
											if v438 then
												local v439 = v438:Clone()
												v439.CFrame = v_u_316.CFrame * CFrame.new(0, -2.5, 0)
												v439.Anchored = true
												v439.CanCollide = false
												v439.Transparency = 1
												v439.Parent = workspace
												v_u_308:AddItem(v439, 5)
												for _, v_u_440 in v439:GetDescendants() do
													if v_u_440:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_440
															local v441 = v_u_440:GetAttribute("EmitDelay") or 0
															if v441 > 0 then
																task.wait(v441)
															end
															v_u_440:Emit(v_u_440:GetAttribute("EmitCount") or v_u_440.Rate)
														end)
													end
												end
											end
											local v442 = v_u_437:FindFirstChild("ChargeVFX")
											if v442 then
												local v_u_443 = v442:Clone()
												v_u_443.CFrame = v_u_316.CFrame
												v_u_443.Anchored = false
												v_u_443.CanCollide = false
												v_u_443.Transparency = 1
												v_u_443.Massless = true
												v_u_443.Parent = workspace
												v_u_308:AddItem(v_u_443, 1.3)
												local v444 = Instance.new("WeldConstraint")
												v444.Part0 = v_u_316
												v444.Part1 = v_u_443
												v444.Parent = v_u_443
												for _, v445 in v_u_443:GetDescendants() do
													if v445:IsA("ParticleEmitter") then
														v445.Enabled = true
													end
												end
												task.delay(0.4, function()
													-- upvalues: (copy) v_u_443
													if v_u_443 and v_u_443.Parent then
														for _, v446 in v_u_443:GetDescendants() do
															if v446:IsA("ParticleEmitter") then
																v446.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(0.44999999999999996, function()
												-- upvalues: (ref) v_u_316, (copy) v_u_437, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v447 = v_u_437:FindFirstChild("BarrageVFX")
													if v447 then
														local v_u_448 = v447:Clone()
														v_u_448.CFrame = v_u_316.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_448.Anchored = true
														v_u_448.CanCollide = false
														v_u_448.Transparency = 1
														v_u_448.Parent = workspace
														v_u_308:AddItem(v_u_448, 2.9)
														for _, v449 in v_u_448:GetDescendants() do
															if v449:IsA("ParticleEmitter") then
																v449.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_448
															if v_u_448 and v_u_448.Parent then
																for _, v450 in v_u_448:GetDescendants() do
																	if v450:IsA("ParticleEmitter") then
																		v450.Enabled = false
																	end
																end
															end
														end)
													end
													local v451 = v_u_437:FindFirstChild("BarrageGroundVFX")
													if v451 then
														local v_u_452 = v451:Clone()
														v_u_452.CFrame = v_u_316.CFrame * CFrame.new(0, -37.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_452.Anchored = true
														v_u_452.CanCollide = false
														v_u_452.Transparency = 1
														v_u_452.Parent = workspace
														v_u_308:AddItem(v_u_452, 2.7)
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
												end
											end)
											task.delay(2, function()
												-- upvalues: (ref) v_u_316, (copy) v_u_437, (ref) v_u_308
												if v_u_316 and v_u_316.Parent then
													local v455 = v_u_437:FindFirstChild("ChargeVFX")
													if v455 then
														local v_u_456 = v455:Clone()
														v_u_456.CFrame = v_u_316.CFrame
														v_u_456.Anchored = false
														v_u_456.CanCollide = false
														v_u_456.Transparency = 1
														v_u_456.Massless = true
														v_u_456.Parent = workspace
														v_u_308:AddItem(v_u_456, 1)
														local v457 = Instance.new("WeldConstraint")
														v457.Part0 = v_u_316
														v457.Part1 = v_u_456
														v457.Parent = v_u_456
														for _, v458 in v_u_456:GetDescendants() do
															if v458:IsA("ParticleEmitter") then
																v458.Enabled = true
															end
														end
														task.delay(0.6, function()
															-- upvalues: (copy) v_u_456
															if v_u_456 and v_u_456.Parent then
																for _, v459 in v_u_456:GetDescendants() do
																	if v459:IsA("ParticleEmitter") then
																		v459.Enabled = false
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
											local v460 = v_u_313.X:FindFirstChild("BarrageVFX")
											if v460 then
												local v_u_461 = v460:Clone()
												v_u_461.CFrame = v_u_316.CFrame * CFrame.new(0, 4, -15)
												v_u_461.Anchored = false
												v_u_461.CanCollide = false
												v_u_461.Transparency = 1
												v_u_461.CastShadow = false
												v_u_461.CanQuery = false
												v_u_461.Massless = true
												v_u_461.Parent = workspace
												v_u_308:AddItem(v_u_461, 3.7)
												local v462 = Instance.new("WeldConstraint")
												v462.Part0 = v_u_316
												v462.Part1 = v_u_461
												v462.Parent = v_u_461
												for _, v463 in v_u_461:GetDescendants() do
													if v463:IsA("ParticleEmitter") or (v463:IsA("Beam") or v463:IsA("Trail")) then
														v463.Enabled = true
													end
												end
												task.delay(1.7, function()
													-- upvalues: (copy) v_u_461
													if v_u_461 and v_u_461.Parent then
														for _, v464 in v_u_461:GetDescendants() do
															if v464:IsA("ParticleEmitter") or (v464:IsA("Beam") or v464:IsA("Trail")) then
																v464.Enabled = false
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
												local v465 = { 0, 0 }
												local v466 = {
													{ 180, 180, 135 },
													{ 180, 180, 45 }
												}
												for v467 = 1, 2 do
													if not (v_u_316 and v_u_316.Parent) then
														break
													end
													local v468 = v465[v467]
													local v469 = v466[v467][1]
													local v470 = v466[v467][2]
													local v471 = v466[v467][3]
													local v472 = v_u_316.CFrame * CFrame.Angles(0, math.rad(v468), 0)
													local v473 = v472.Position
													local v474 = v473 + v472.LookVector * 80
													local v475 = CFrame.Angles(math.rad(v469), math.rad(v470), (math.rad(v471)))
													local v476 = CFrame.lookAt(v473, v474) * v475
													local v477 = CFrame.lookAt(v474, v474 + v472.LookVector) * v475
													local v478 = v_u_313.X:FindFirstChild("StartVFX")
													if v478 then
														local v479 = v478:Clone()
														v479.CFrame = v476
														v479.Anchored = true
														v479.CanCollide = false
														v479.Transparency = 1
														v479.Parent = workspace
														v_u_308:AddItem(v479, 2)
														for _, v480 in v479:GetDescendants() do
															if v480:IsA("ParticleEmitter") then
																v480:Emit(v480:GetAttribute("EmitCount") or v480.Rate)
															end
														end
													end
													local v481 = v_u_313.X:FindFirstChild("SlashVFX")
													if v481 then
														local v_u_482 = v481:Clone()
														v_u_482.CFrame = v476
														v_u_482.Anchored = true
														v_u_482.CanCollide = false
														v_u_482.Transparency = 1
														v_u_482.Parent = workspace
														v_u_308:AddItem(v_u_482, 3)
														for _, v483 in v_u_482:GetDescendants() do
															if v483:IsA("ParticleEmitter") or (v483:IsA("Beam") or v483:IsA("Trail")) then
																v483.Enabled = true
															end
														end
														local v484 = v_u_309:Create(v_u_482, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															["CFrame"] = v477
														})
														v484:Play()
														v484.Completed:Connect(function()
															-- upvalues: (copy) v_u_482
															for _, v485 in v_u_482:GetDescendants() do
																if v485:IsA("ParticleEmitter") or (v485:IsA("Beam") or v485:IsA("Trail")) then
																	v485.Enabled = false
																end
															end
														end)
													end
													if v467 < 2 then
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
													local v486 = v_u_313:FindFirstChild("X")
													if v486 then
														local v487 = v486:FindFirstChild("StompVFX")
														if v487 then
															local v488 = v_u_316.Position - Vector3.new(0, 2.5, 0)
															local v489 = v487:Clone()
															local v490 = v489:FindFirstChild("Main")
															local v491 = v489:FindFirstChild("Lightning")
															if v490 then
																v490.CFrame = CFrame.new(v488)
																v490.Anchored = true
																v490.CanCollide = false
																v490.Transparency = 1
															end
															if v491 then
																v491.CFrame = CFrame.new(v488 + Vector3.new(0, 13, 0))
																v491.Anchored = true
																v491.CanCollide = false
																v491.Transparency = 1
															end
															v489.Parent = workspace
															v_u_308:AddItem(v489, 3)
															for _, v_u_492 in v489:GetDescendants() do
																if v_u_492:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_492
																		local v493 = v_u_492:GetAttribute("EmitDelay") or 0
																		task.wait(v493)
																		v_u_492:Emit(v_u_492:GetAttribute("EmitCount") or v_u_492.Rate)
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
											local v494 = v_u_313.X
											local v495 = v494 and v494:FindFirstChild("BarrageVFX")
											if v495 then
												local v_u_496 = v495:Clone()
												v_u_496.CFrame = v_u_316.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, -1.5707963267948966, 0)
												v_u_496.Anchored = false
												v_u_496.CanCollide = false
												v_u_496.Transparency = 1
												v_u_496.CastShadow = false
												v_u_496.CanQuery = false
												v_u_496.Massless = true
												v_u_496.Parent = workspace
												v_u_308:AddItem(v_u_496, 4)
												local v497 = Instance.new("WeldConstraint")
												v497.Part0 = v_u_316
												v497.Part1 = v_u_496
												v497.Parent = v_u_496
												for _, v498 in v_u_496:GetDescendants() do
													if v498:IsA("ParticleEmitter") then
														v498.Enabled = true
													end
												end
												task.delay(3.2, function()
													-- upvalues: (copy) v_u_496
													if v_u_496 and v_u_496.Parent then
														for _, v499 in v_u_496:GetDescendants() do
															if v499:IsA("ParticleEmitter") then
																v499.Enabled = false
															end
														end
													end
												end)
												return
											end
										elseif v_u_312 == "Alucard" then
											local v500 = v_u_69.Alucard
											if v500 and v500["Skill 2"] then
												local v501 = {
													["Caster"] = {
														["Character"] = v_u_315
													},
													["AbilityConfig"] = {}
												}
												v500["Skill 2"](v501)
												return
											end
										elseif v_u_312 == "GojoV2" then
											local v502 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v502 then
												v502 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v502 then
												local v503 = require(v502)
												if v503["Skill 2"] then
													v503["Skill 2"]({
														["Caster"] = {
															["Character"] = v_u_315
														},
														["Duration"] = p_u_307.Duration or 6
													})
													return
												end
											end
										elseif v_u_312 == "StrongestInHistory" then
											local v504 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v504 then
												v504 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v504 then
												local v505 = require(v504)
												if v505["Skill 2"] then
													local v506 = {
														["Caster"] = {
															["Character"] = v_u_315
														}
													}
													v505["Skill 2"](v506)
													return
												end
											end
										elseif v_u_312 == "Ichigo" then
											local v507 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v507 then
												v507 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("Ichigo")
											end
											if v507 then
												local v508 = require(v507)
												if v508 and v508["Skill 2"] then
													local v509 = {
														["Caster"] = {
															["Character"] = v_u_315
														},
														["Duration"] = 4
													}
													v508["Skill 2"](v509)
													return
												end
											end
										else
											task.wait(0.35)
											if not (v_u_316 and v_u_316.Parent) then
												return
											end
											local v510 = v_u_316.CFrame
											local v511 = v_u_313.X:FindFirstChild("EnergySlashes")
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
											v_u_308:AddItem(v_u_512, 4)
											local v513 = Instance.new("WeldConstraint")
											v513.Part0 = v_u_512
											v513.Part1 = v_u_316
											v513.Parent = v_u_512
											v_u_308:AddItem(v513, 2.06)
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
					elseif p_u_307.VFXName == "C" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (ref) v_u_3, (copy) v_u_315, (copy) p_u_307, (ref) v_u_313, (copy) v_u_308, (copy) v_u_328, (copy) v_u_334
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "GojoV2" then
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
													["Character"] = v_u_315
												},
												["Duration"] = p_u_307.Duration or 6
											}
											v517(v518)
										end
									end
									return
								elseif v_u_312 == "StrongestInHistory" then
									local v519 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v519 then
										v519 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v519 then
										local v_u_520 = require(v519)
										if v_u_520["Skill 3"] then
											local v521 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["ChargeTime"] = 2.5
											}
											v_u_520["Skill 3"](v521)
										end
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_520, (ref) v_u_315
											if v_u_316 and v_u_316.Parent then
												local v522 = v_u_316.Position + v_u_316.CFrame.LookVector * 85
												if v_u_520["Skill 3"] then
													local v523 = v_u_520["Skill 3"]
													local v524 = {
														["Caster"] = {
															["Character"] = v_u_315
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
								elseif v_u_312 == "Gojo" then
									local v525 = v_u_313.C:FindFirstChild("DamageVFX")
									if v525 then
										local v526 = v525:Clone()
										v526.CFrame = v_u_316.CFrame
										v526.Anchored = false
										v526.CanCollide = false
										v526.Transparency = 1
										v526.Massless = true
										v526.Parent = workspace
										local v527 = Instance.new("WeldConstraint")
										v527.Part0 = v526
										v527.Part1 = v_u_316
										v527.Parent = v526
										for _, v528 in v526:GetDescendants() do
											if v528:IsA("ParticleEmitter") then
												v528:Emit(v528:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_308:AddItem(v526, 3)
									end
									return
								elseif v_u_312 == "Jinwoo" then
									local v529 = v_u_313.C
									if v529 then
										local v530 = v529:FindFirstChild("EnergySlashes")
										local v531 = v529:FindFirstChild("ShadowVFX")
										if v530 then
											local v_u_532 = v530:Clone()
											v_u_532.CFrame = v_u_316.CFrame * CFrame.new(0, 3.9, 0)
											v_u_532.Anchored = false
											v_u_532.CanCollide = false
											v_u_532.Transparency = 1
											v_u_532.CastShadow = false
											v_u_532.CanQuery = false
											v_u_532.Massless = true
											v_u_532.Parent = workspace
											v_u_308:AddItem(v_u_532, 3.65)
											local v533 = Instance.new("WeldConstraint")
											v533.Part0 = v_u_316
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
											v_u_535.CFrame = v_u_316.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_535.Anchored = false
											v_u_535.CanCollide = false
											v_u_535.Transparency = 1
											v_u_535.CastShadow = false
											v_u_535.CanQuery = false
											v_u_535.Massless = true
											v_u_535.Parent = workspace
											v_u_308:AddItem(v_u_535, 2.65)
											local v536 = Instance.new("WeldConstraint")
											v536.Part0 = v_u_316
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
								elseif v_u_312 == "Ragna" then
									local v540 = v_u_313.C
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
												-- upvalues: (ref) v_u_550, (ref) v_u_316, (copy) v_u_544, (copy) v_u_541, (ref) v_u_308, (copy) v_u_542, (copy) v_u_545
												while v_u_550 < 6 and (v_u_316 and v_u_316.Parent) do
													local v551 = 6 - v_u_550
													local v552 = math.min(2, v551)
													for v553 = 1, v552 do
														local v554 = v_u_544[v_u_550 + v553]
														local v555 = v_u_316.CFrame
														local v556 = v555:VectorToWorldSpace(v554.offset)
														local v557 = v555.Position + v556
														local v558 = v_u_541:Clone()
														v558.CFrame = CFrame.new(v557) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v558.Anchored = true
														v558.CanCollide = false
														v558.CanQuery = false
														v558.Transparency = 0
														v558.Parent = workspace
														v_u_308:AddItem(v558, 3)
														if v_u_542 then
															local v559 = v_u_542:Clone()
															v559.CFrame = v558.CFrame
															v559.Anchored = true
															v559.CanCollide = false
															v559.Transparency = 1
															v559.Parent = workspace
															v_u_308:AddItem(v559, 1)
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
												-- upvalues: (ref) v_u_316, (ref) v_u_563, (copy) v_u_545
												if v_u_316 and v_u_316.Parent then
													local v564 = (1 / 0)
													local v565 = nil
													for _, v566 in ipairs(game.Players:GetPlayers()) do
														if v566.Character and v566.Character:FindFirstChild("HumanoidRootPart") then
															local v567 = v566.Character.HumanoidRootPart
															local v568 = (v567.Position - v_u_316.Position).Magnitude
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
																v572 = CFrame.new(v571) * v_u_316.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v570.CFrame = v570.CFrame:Lerp(v572, 0.12)
														end
													end
												elseif v_u_563 then
													v_u_563:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_563, (ref) v_u_316, (copy) v_u_545, (copy) v_u_543, (ref) v_u_308
												if v_u_563 then
													v_u_563:Disconnect()
												end
												if v_u_316 and v_u_316.Parent then
													local v575 = v_u_316.Position + v_u_316.CFrame.LookVector * 30
													local v576 = (1 / 0)
													for _, v577 in ipairs(game.Players:GetPlayers()) do
														if v577.Character and v577.Character:FindFirstChild("HumanoidRootPart") then
															local v578 = v577.Character.HumanoidRootPart
															local v579 = (v578.Position - v_u_316.Position).Magnitude
															if v579 < v576 and v579 < 150 then
																v575 = v578.Position
																v576 = v579
															end
														end
													end
													local v_u_580 = CFrame.new(v575)
													for v581, v_u_582 in ipairs(v_u_545) do
														task.delay((v581 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_582, (copy) v_u_580, (ref) v_u_543, (ref) v_u_308
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
																	-- upvalues: (copy) v_u_596, (copy) v_u_584, (copy) v_u_595, (copy) v_u_588, (copy) v_u_583, (ref) v_u_543, (ref) v_u_308
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
																		v_u_308:AddItem(v610, 1.5)
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
								elseif v_u_312 == "Aizen" then
									local v_u_612 = v_u_313.C
									if v_u_612 then
										local v_u_613 = {}
										local function v_u_619(p614, p615)
											-- upvalues: (ref) v_u_316, (ref) v_u_308
											if not p614 then
												return nil
											end
											local v616 = p614:Clone()
											v616.CFrame = v_u_316.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v616.Anchored = false
											v616.CanCollide = false
											v616.Transparency = 1
											v616.CastShadow = false
											v616.CanQuery = false
											v616.Massless = true
											v616.Parent = workspace
											v_u_308:AddItem(v616, p615)
											local v617 = Instance.new("WeldConstraint")
											v617.Part0 = v_u_316
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
											-- upvalues: (ref) v_u_316, (copy) v_u_619, (copy) v_u_612, (copy) v_u_613
											if v_u_316 and v_u_316.Parent then
												local v622 = v_u_619(v_u_612:FindFirstChild("AuraVFX2"), 3.75)
												if v622 then
													local v623 = v_u_613
													table.insert(v623, v622)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_619, (copy) v_u_612, (copy) v_u_613
											if v_u_316 and v_u_316.Parent then
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
								else
									local v628 = v_u_313.C:FindFirstChild("FirstEffects")
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
										v_u_629:PivotTo(v_u_316.CFrame * CFrame.new(0, -2, 0))
										v_u_629.Parent = workspace
										v_u_308:AddItem(v_u_629, 6)
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
									if v_u_316 and v_u_316.Parent then
										local v_u_632 = v_u_316.CFrame
										local v633 = v_u_313.C:FindFirstChild("HorizontalBeam")
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
											v_u_308:AddItem(v634, 6)
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
														-- upvalues: (copy) v_u_639, (ref) v_u_328, (copy) v_u_638
														if v_u_639 then
															v_u_328(v_u_639, 0.3)
														end
														for _, v642 in v_u_638:GetDescendants() do
															if v642:IsA("ParticleEmitter") and not (v_u_639 and v642:IsDescendantOf(v_u_639)) then
																v642:Emit(v642:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v641, function()
														-- upvalues: (copy) v_u_639, (ref) v_u_334
														if v_u_639 then
															v_u_334(v_u_639, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (copy) v_u_632, (ref) v_u_308, (ref) v_u_334
											if v_u_316 and v_u_316.Parent then
												local v643 = v_u_313.C:FindFirstChild("Explosion")
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
													v_u_308:AddItem(v_u_644, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_334, (copy) v_u_644
														v_u_334(v_u_644, 0.5)
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
						if v_u_312 == "QinShi" then
							task.spawn(function()
								-- upvalues: (copy) v_u_316, (ref) v_u_313, (copy) v_u_308
								if v_u_316 and v_u_316.Parent then
									local v647 = v_u_313:FindFirstChild("C")
									if v647 then
										local v648 = v647:FindFirstChild("BarrageVFX")
										if v648 then
											local v_u_649 = v648:Clone()
											v_u_649.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_649.Anchored = false
											v_u_649.CanCollide = false
											v_u_649.CanQuery = false
											v_u_649.CanTouch = false
											v_u_649.Transparency = 1
											v_u_649.CastShadow = false
											v_u_649.Parent = workspace
											local v650 = Instance.new("WeldConstraint")
											v650.Part0 = v_u_649
											v650.Part1 = v_u_316
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
											v_u_308:AddItem(v_u_649, 4)
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
									local v_u_653 = v_u_313:FindFirstChild("C")
									if v_u_653 then
										local v654 = v_u_653:FindFirstChild("AuraVFX3")
										if v654 then
											local v_u_655 = v654:Clone()
											v_u_655.CFrame = v_u_316.CFrame
											v_u_655.Anchored = false
											v_u_655.CanCollide = false
											v_u_655.Transparency = 1
											v_u_655.Massless = true
											v_u_655.Parent = workspace
											local v656 = Instance.new("WeldConstraint")
											v656.Part0 = v_u_316
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
											v_u_308:AddItem(v_u_655, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_653, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v659 = v_u_653:FindFirstChild("BlackFlashVFX3")
												if v659 then
													local v660 = v659:Clone()
													v660.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -10)
													v660.Anchored = true
													v660.CanCollide = false
													v660.Transparency = 1
													v660.Parent = workspace
													for _, v661 in v660:GetDescendants() do
														if v661:IsA("ParticleEmitter") then
															v661:Emit(v661:GetAttribute("EmitCount") or v661.Rate)
														end
													end
													v_u_308:AddItem(v660, 3)
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
							local v662 = v_u_69.Alucard
							if v662 and v662["Skill 3"] then
								v662["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_315
									},
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_312 == "Ichigo" then
							local v663 = v_u_69.Ichigo
							if v663 and v663["Skill 3"] then
								v663["Skill 3"]({
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
					elseif p_u_307.VFXName == "V" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (ref) v_u_3, (copy) v_u_315, (ref) v_u_313, (copy) v_u_308, (copy) v_u_309, (copy) p_u_307, (ref) v_u_306, (ref) v_u_37, (ref) v_u_69
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "GojoV2" then
									local v664 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v664 then
										v664 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v664 then
										local v665 = require(v664)
										if v665["Skill 4"] then
											local v666 = {
												["Caster"] = {
													["Character"] = v_u_315
												}
											}
											v665["Skill 4"](v666)
										end
									end
									return
								elseif v_u_312 == "StrongestInHistory" then
									local v667 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v667 then
										v667 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v667 then
										local v668 = require(v667)
										if v668["Skill 4"] then
											local v669 = v668["Skill 4"]
											local v670 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["CutsceneDuration"] = 6.5,
												["DamageDelay"] = 5,
												["CharAnimationId"] = "rbxassetid://125013796988038"
											}
											local v671 = v_u_316
											if v671 then
												v671 = v_u_316.CFrame
											end
											v670.CFrame = v671
											v669(v670)
										end
									end
									return
								elseif v_u_312 == "Gojo" then
									local v_u_672 = v_u_313.V
									if v_u_672 then
										local v_u_673 = Instance.new("Attachment")
										v_u_673.Name = "BlueAtt"
										v_u_673.Position = Vector3.new(7, 2, 5)
										v_u_673.Parent = v_u_316
										local v_u_674 = Instance.new("Attachment")
										v_u_674.Name = "RedAtt"
										v_u_674.Position = Vector3.new(-7, 2, 5)
										v_u_674.Parent = v_u_316
										local v_u_675 = nil
										local v_u_676 = nil
										local function v_u_685(p677, p678)
											-- upvalues: (copy) v_u_672, (ref) v_u_316
											local v679 = v_u_672:FindFirstChild(p677)
											if not v679 then
												return nil
											end
											local v680 = v679:Clone()
											v680.CFrame = v_u_316.CFrame * CFrame.new(p678.Position)
											v680.Anchored = true
											v680.CanCollide = false
											v680.Massless = true
											v680.Transparency = 1
											v680.Parent = workspace
											local v681 = Instance.new("Attachment")
											v681.Parent = v680
											local v682 = Instance.new("AlignPosition")
											v682.Attachment0 = v681
											v682.Attachment1 = p678
											v682.RigidityEnabled = false
											v682.Responsiveness = 100
											v682.MaxForce = (1 / 0)
											v682.Parent = v680
											local v683 = Instance.new("AlignOrientation")
											v683.Attachment0 = v681
											v683.Attachment1 = p678
											v683.RigidityEnabled = false
											v683.Responsiveness = 100
											v683.MaxTorque = (1 / 0)
											v683.Parent = v680
											v680.Anchored = false
											for _, v684 in v680:GetDescendants() do
												if v684:IsA("ParticleEmitter") then
													v684.Enabled = true
												elseif v684:IsA("Beam") or v684:IsA("Trail") then
													v684.Enabled = true
												end
											end
											return v680
										end
										local function v_u_689(p686, p687)
											if p686 and p686.Parent then
												for _, v_u_688 in p686:GetDescendants() do
													if v_u_688:IsA("ParticleEmitter") then
														v_u_688.Enabled = false
														if p687 then
															pcall(function()
																-- upvalues: (copy) v_u_688
																v_u_688:Clear()
															end)
														end
													elseif v_u_688:IsA("Beam") or v_u_688:IsA("Trail") then
														v_u_688.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_675, (copy) v_u_685, (copy) v_u_673, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_675 = v_u_685("Blue", v_u_673)
												if v_u_675 then
													v_u_308:AddItem(v_u_675, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_676, (copy) v_u_685, (copy) v_u_674, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_676 = v_u_685("Red", v_u_674)
												if v_u_676 then
													v_u_308:AddItem(v_u_676, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_309, (copy) v_u_673, (copy) v_u_674, (copy) v_u_672, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v690 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_309:Create(v_u_673, v690, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_309:Create(v_u_674, v690, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_316, (ref) v_u_672, (ref) v_u_308
													if v_u_316 and v_u_316.Parent then
														local v691 = v_u_672:FindFirstChild("StarEff")
														if v691 then
															local v692 = v691:Clone()
															v692.CFrame = v_u_316.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v692.Anchored = true
															v692.CanCollide = false
															v692.Transparency = 1
															v692.Parent = workspace
															for _, v693 in v692:GetDescendants() do
																if v693:IsA("ParticleEmitter") then
																	v693:Emit(v693:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_308:AddItem(v692, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_689, (ref) v_u_675, (ref) v_u_676, (copy) v_u_673, (copy) v_u_674, (copy) v_u_672, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_689(v_u_675, true)
												v_u_689(v_u_676, true)
												if v_u_673 and v_u_673.Parent then
													v_u_673:Destroy()
												end
												if v_u_674 and v_u_674.Parent then
													v_u_674:Destroy()
												end
												local v694 = v_u_672:FindFirstChild("MiniExplosionVFX")
												if v694 then
													local v695 = v694:Clone()
													v695.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -2)
													v695.Anchored = true
													v695.CanCollide = false
													v695.Transparency = 1
													v695.Parent = workspace
													for _, v696 in v695:GetDescendants() do
														if v696:IsA("ParticleEmitter") then
															v696:Emit(v696:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_308:AddItem(v695, 3)
												end
												local v_u_697 = v_u_316.Position + v_u_316.CFrame.LookVector * 6
												local v_u_698 = v_u_316.CFrame.LookVector
												local v699 = v_u_672:FindFirstChild("Purple")
												if v699 then
													local v_u_700 = v699:Clone()
													v_u_700.Anchored = true
													v_u_700.CanCollide = false
													v_u_700.Parent = workspace
													v_u_308:AddItem(v_u_700, 3)
													for _, v701 in v_u_700:GetDescendants() do
														if v701:IsA("ParticleEmitter") then
															v701.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_697, (copy) v_u_700, (copy) v_u_698
														local v702 = v_u_697
														local v703 = 0
														while v703 < 200 and (v_u_700 and v_u_700.Parent) do
															v702 = v702 + v_u_698 * 3.9899999999999998
															v703 = v703 + 3.9899999999999998
															v_u_700.CFrame = CFrame.lookAt(v702, v702 + v_u_698)
															task.wait(0.03)
														end
														for _, v704 in v_u_700:GetDescendants() do
															if v704:IsA("ParticleEmitter") then
																v704.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_312 == "Sukuna" then
									local v_u_705 = v_u_313.V
									if v_u_705 then
										local v706 = (p_u_307.NPCModel or "NPC") .. "_SukunaV"
										local v707 = tick()
										if not v_u_306[v706] or v707 - v_u_306[v706] > 0.5 then
											v_u_306[v706] = v707
											v_u_37:PlayAt("SukunaV_Part1", p_u_307.Position)
										end
										local v708 = v_u_705:FindFirstChild("GroundVFX")
										if v708 then
											local v_u_709 = v708:Clone()
											v_u_709.CFrame = v_u_316.CFrame * CFrame.new(0, -2, 0)
											v_u_709.Anchored = false
											v_u_709.Parent = workspace
											v_u_308:AddItem(v_u_709, 3)
											local v710 = Instance.new("WeldConstraint")
											v710.Part0 = v_u_316
											v710.Part1 = v_u_709
											v710.Parent = v_u_709
											for _, v711 in v_u_709:GetDescendants() do
												if v711:IsA("ParticleEmitter") then
													v711.Enabled = true
													v711:Emit(v711:GetAttribute("EmitCount") or 40)
												elseif v711:IsA("Beam") then
													v711.Enabled = true
												end
											end
											task.delay(2.35, function()
												-- upvalues: (copy) v_u_709
												if v_u_709 and v_u_709.Parent then
													for _, v712 in v_u_709:GetDescendants() do
														if v712:IsA("ParticleEmitter") then
															v712.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_705, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v713 = v_u_705:FindFirstChild("MiniExplosionVFX")
												if v713 then
													local v714 = v713:Clone()
													v714.CFrame = v_u_316.CFrame * CFrame.new(1, 0, 0)
													v714.Anchored = false
													v714.Parent = workspace
													v_u_308:AddItem(v714, 2)
													local v715 = Instance.new("WeldConstraint")
													v715.Part0 = v_u_316
													v715.Part1 = v714
													v715.Parent = v714
													for _, v716 in v714:GetDescendants() do
														if v716:IsA("ParticleEmitter") then
															v716:Emit(v716:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v717 = v_u_705:FindFirstChild("ArrowVFX")
												if v717 then
													local v_u_718 = v717:Clone()
													v_u_718.CFrame = v_u_316.CFrame * CFrame.new(1, 0, 0)
													v_u_718.Anchored = false
													v_u_718.Parent = workspace
													v_u_308:AddItem(v_u_718, 2)
													local v719 = Instance.new("WeldConstraint")
													v719.Part0 = v_u_316
													v719.Part1 = v_u_718
													v719.Parent = v_u_718
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_718
														if v_u_718 and v_u_718.Parent then
															for _, v720 in v_u_718:GetDescendants() do
																if v720:IsA("ParticleEmitter") or v720:IsA("Beam") then
																	v720.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_316, (ref) p_u_307, (ref) v_u_306, (ref) v_u_37, (copy) v_u_705, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v721 = (p_u_307.NPCModel or "NPC") .. "_SukunaV2"
												local v722 = tick()
												if not v_u_306[v721] or v722 - v_u_306[v721] > 0.5 then
													v_u_306[v721] = v722
													v_u_37:PlayAt("SukunaV_Part2", v_u_316.Position)
												end
												local v723 = v_u_316.CFrame.LookVector
												local v724 = v_u_316.Position + v723 * 85
												local v725 = v_u_705:FindFirstChild("ExplosionVFX")
												if v725 then
													local v_u_726 = v725:Clone()
													if v_u_726:IsA("Model") then
														v_u_726:PivotTo(CFrame.new(v724) * CFrame.new(0, 73, 0))
													else
														v_u_726.CFrame = CFrame.new(v724) * CFrame.new(0, 73, 0)
													end
													v_u_726.Parent = workspace
													v_u_308:AddItem(v_u_726, 4)
													for _, v727 in v_u_726:GetDescendants() do
														if v727:IsA("ParticleEmitter") then
															v727.Enabled = true
															v727:Emit(v727:GetAttribute("EmitCount") or 30)
														elseif v727:IsA("Beam") or v727:IsA("Trail") then
															v727.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_726
														if v_u_726 and v_u_726.Parent then
															for _, v728 in v_u_726:GetDescendants() do
																if v728:IsA("ParticleEmitter") or (v728:IsA("Beam") or v728:IsA("Trail")) then
																	v728.Enabled = false
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
									local v_u_729 = v_u_313.V
									if v_u_729 then
										local v730 = v_u_729:FindFirstChild("FirstEffects")
										if v730 then
											local v_u_731 = v730:Clone()
											v_u_731.CFrame = v_u_316.CFrame * CFrame.new(0, -2.5, 0)
											v_u_731.Anchored = false
											v_u_731.CanCollide = false
											v_u_731.Transparency = 1
											v_u_731.CastShadow = false
											v_u_731.CanQuery = false
											v_u_731.Massless = true
											v_u_731.Parent = workspace
											v_u_308:AddItem(v_u_731, 6)
											local v732 = Instance.new("WeldConstraint")
											v732.Part0 = v_u_316
											v732.Part1 = v_u_731
											v732.Parent = v_u_731
											for _, v733 in v_u_731:GetDescendants() do
												if v733:IsA("ParticleEmitter") then
													v733.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_731
												if v_u_731 and v_u_731.Parent then
													for _, v734 in v_u_731:GetDescendants() do
														if v734:IsA("ParticleEmitter") then
															v734.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_729, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v735 = v_u_729:FindFirstChild("UltVFX")
												if v735 then
													local v_u_736 = v735:Clone()
													v_u_736:PivotTo(v_u_316.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v737 in v_u_736:GetDescendants() do
														if v737:IsA("BasePart") then
															v737.Anchored = true
															v737.CanCollide = false
															v737.CastShadow = false
															v737.CanQuery = false
														end
													end
													v_u_736.Parent = workspace
													v_u_308:AddItem(v_u_736, 4.5)
													for _, v738 in v_u_736:GetDescendants() do
														if v738:IsA("ParticleEmitter") then
															v738.Enabled = true
														elseif v738:IsA("Beam") then
															v738.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_736
														if v_u_736 and v_u_736.Parent then
															for _, v739 in v_u_736:GetDescendants() do
																if v739:IsA("ParticleEmitter") then
																	v739.Enabled = false
																end
															end
															for _, v_u_740 in v_u_736:GetDescendants() do
																if v_u_740:IsA("Beam") then
																	local v_u_741 = v_u_740.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_741, (copy) v_u_740
																		local v742 = tick()
																		while tick() - v742 < 0.5 do
																			local v743 = (tick() - v742) / 0.5
																			local v744 = {}
																			for _, v745 in ipairs(v_u_741) do
																				local v746 = v745.Value + (1 - v745.Value) * v743
																				local v747 = NumberSequenceKeypoint.new
																				local v748 = v745.Time
																				table.insert(v744, v747(v748, v746))
																			end
																			v_u_740.Transparency = NumberSequence.new(v744)
																			task.wait()
																		end
																		v_u_740.Transparency = NumberSequence.new(1)
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
										local v749 = v_u_69.Ichigo
										if v749 and v749["Skill 4"] then
											local v750 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["CutsceneDuration"] = 8.33,
												["CharAnimationId"] = "rbxassetid://98446587158184",
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v749["Skill 4"](v750)
											return
										end
									elseif v_u_312 == "Alucard" then
										local v751 = v_u_69.Alucard
										if v751 and v751["Skill 4"] then
											local v752 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["AbilityConfig"] = {},
												["CutsceneDuration"] = 5.5,
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v751["Skill 4"](v752)
										end
									end
									return
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
		else
			return
		end
	end
	local v_u_754 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p755, p_u_756)
		-- upvalues: (copy) v_u_754, (copy) v_u_753, (copy) v_u_44, (copy) v_u_37, (copy) v_u_299, (copy) v_u_7, (copy) v_u_305, (copy) v_u_4
		if p755 == "SpawnVFX" then
			if p_u_756.IsNPC and (p_u_756.VFXName == "Z" or (p_u_756.VFXName == "X" or (p_u_756.VFXName == "C" or p_u_756.VFXName == "V"))) then
				local v757 = (p_u_756.NPCModel or "NPC") .. "_" .. p_u_756.VFXName
				local v758 = tick()
				if v_u_754[v757] and v758 - v_u_754[v757] < 1 then
					return
				end
				v_u_754[v757] = v758
				task.spawn(function()
					-- upvalues: (ref) v_u_753, (copy) p_u_756
					v_u_753(p_u_756)
				end)
				local v759 = p_u_756.MovesetType or "Saber"
				if p_u_756.VFXName == "Z" then
					if v759 == "Gojo" then
						local v760 = (p_u_756.NPCModel or "unknown") .. "_Z"
						local v761 = tick()
						local v762
						if v_u_44[v760] and v761 - v_u_44[v760] < 1.5 then
							v762 = false
						else
							v_u_44[v760] = v761
							v762 = true
						end
						if v762 then
							v_u_37:PlayAt("GojoZ", p_u_756.Position)
						end
					elseif v759 == "Sukuna" then
						local v763 = (p_u_756.NPCModel or "unknown") .. "_Z"
						local v764 = tick()
						local v765
						if v_u_44[v763] and v764 - v_u_44[v763] < 1.5 then
							v765 = false
						else
							v_u_44[v763] = v764
							v765 = true
						end
						if v765 then
							v_u_37:PlayAt("SukunaZ", p_u_756.Position)
						end
					elseif v759 == "Jinwoo" then
						local v766 = (p_u_756.NPCModel or "unknown") .. "_Z"
						local v767 = tick()
						local v768
						if v_u_44[v766] and v767 - v_u_44[v766] < 1.5 then
							v768 = false
						else
							v_u_44[v766] = v767
							v768 = true
						end
						if v768 then
							v_u_37:PlayAt("JinwooZ", p_u_756.Position)
						end
					elseif v759 == "Ragna" then
						local v769 = (p_u_756.NPCModel or "unknown") .. "_Z"
						local v770 = tick()
						local v771
						if v_u_44[v769] and v770 - v_u_44[v769] < 1.5 then
							v771 = false
						else
							v_u_44[v769] = v770
							v771 = true
						end
						if v771 then
							v_u_37:PlayAt("RagnaZ", p_u_756.Position)
						end
					elseif v759 == "Aizen" then
						local v772 = (p_u_756.NPCModel or "unknown") .. "_Z"
						local v773 = tick()
						local v774
						if v_u_44[v772] and v773 - v_u_44[v772] < 1.5 then
							v774 = false
						else
							v_u_44[v772] = v773
							v774 = true
						end
						if v774 then
							v_u_37:PlayAt("AizenZ", p_u_756.Position)
						end
					elseif v759 == "QinShi" then
						local v775 = (p_u_756.NPCModel or "unknown") .. "_Z"
						local v776 = tick()
						local v777
						if v_u_44[v775] and v776 - v_u_44[v775] < 1.5 then
							v777 = false
						else
							v_u_44[v775] = v776
							v777 = true
						end
						if v777 then
							v_u_37:PlayAt("QinShiZ", p_u_756.Position)
						end
					elseif v759 == "Yuji" then
						local v778 = (p_u_756.NPCModel or "unknown") .. "_Z"
						local v779 = tick()
						local v780
						if v_u_44[v778] and v779 - v_u_44[v778] < 1.5 then
							v780 = false
						else
							v_u_44[v778] = v779
							v780 = true
						end
						if v780 then
							v_u_37:PlayAt("YujiZ", p_u_756.Position)
						end
					elseif v759 ~= "Alucard" then
						if v759 == "GojoV2" then
							local v781 = (p_u_756.NPCModel or "unknown") .. "_Z"
							local v782 = tick()
							local v783
							if v_u_44[v781] and v782 - v_u_44[v781] < 1.5 then
								v783 = false
							else
								v_u_44[v781] = v782
								v783 = true
							end
							if v783 then
								v_u_37:PlayAt("GojoV2Z", p_u_756.Position)
							end
						elseif v759 ~= "StrongestInHistory" then
							local v784 = (p_u_756.NPCModel or "unknown") .. "_Z"
							local v785 = tick()
							local v786
							if v_u_44[v784] and v785 - v_u_44[v784] < 1.5 then
								v786 = false
							else
								v_u_44[v784] = v785
								v786 = true
							end
							if v786 then
								v_u_37:PlayAt("SaberZ", p_u_756.Position)
							end
						end
					end
				elseif p_u_756.VFXName == "X" then
					if v759 == "Gojo" then
						local v787 = (p_u_756.NPCModel or "unknown") .. "_X"
						local v788 = tick()
						local v789
						if v_u_44[v787] and v788 - v_u_44[v787] < 1.5 then
							v789 = false
						else
							v_u_44[v787] = v788
							v789 = true
						end
						if v789 then
							v_u_37:PlayAt("GojoX", p_u_756.Position)
						end
					elseif v759 == "Sukuna" then
						local v790 = (p_u_756.NPCModel or "unknown") .. "_X"
						local v791 = tick()
						local v792
						if v_u_44[v790] and v791 - v_u_44[v790] < 1.5 then
							v792 = false
						else
							v_u_44[v790] = v791
							v792 = true
						end
						if v792 then
							v_u_37:PlayAt("SukunaX", p_u_756.Position)
						end
					elseif v759 == "Jinwoo" then
						local v793 = (p_u_756.NPCModel or "unknown") .. "_X"
						local v794 = tick()
						local v795
						if v_u_44[v793] and v794 - v_u_44[v793] < 1.5 then
							v795 = false
						else
							v_u_44[v793] = v794
							v795 = true
						end
						if v795 then
							v_u_37:PlayAt("JinwooX", p_u_756.Position)
						end
					elseif v759 == "Ragna" then
						local v796 = (p_u_756.NPCModel or "unknown") .. "_X"
						local v797 = tick()
						local v798
						if v_u_44[v796] and v797 - v_u_44[v796] < 1.5 then
							v798 = false
						else
							v_u_44[v796] = v797
							v798 = true
						end
						if v798 then
							v_u_37:PlayAt("RagnaX", p_u_756.Position)
						end
					elseif v759 == "Aizen" then
						local v799 = (p_u_756.NPCModel or "unknown") .. "_X"
						local v800 = tick()
						local v801
						if v_u_44[v799] and v800 - v_u_44[v799] < 1.5 then
							v801 = false
						else
							v_u_44[v799] = v800
							v801 = true
						end
						if v801 then
							v_u_37:PlayAt("AizenX", p_u_756.Position)
						end
					elseif v759 == "QinShi" then
						local v802 = (p_u_756.NPCModel or "unknown") .. "_X"
						local v803 = tick()
						local v804
						if v_u_44[v802] and v803 - v_u_44[v802] < 1.5 then
							v804 = false
						else
							v_u_44[v802] = v803
							v804 = true
						end
						if v804 then
							v_u_37:PlayAt("QinShiX", p_u_756.Position)
						end
					elseif v759 == "Yuji" then
						local v805 = (p_u_756.NPCModel or "unknown") .. "_X"
						local v806 = tick()
						local v807
						if v_u_44[v805] and v806 - v_u_44[v805] < 1.5 then
							v807 = false
						else
							v_u_44[v805] = v806
							v807 = true
						end
						if v807 then
							v_u_37:PlayAt("YujiX", p_u_756.Position)
						end
					elseif v759 ~= "Ichigo" and v759 ~= "Alucard" then
						if v759 == "GojoV2" then
							local v808 = (p_u_756.NPCModel or "unknown") .. "_X"
							local v809 = tick()
							local v810
							if v_u_44[v808] and v809 - v_u_44[v808] < 1.5 then
								v810 = false
							else
								v_u_44[v808] = v809
								v810 = true
							end
							if v810 then
								v_u_37:PlayAt("GojoV2X", p_u_756.Position)
							end
						elseif v759 ~= "StrongestInHistory" then
							local v811 = (p_u_756.NPCModel or "unknown") .. "_X"
							local v812 = tick()
							local v813
							if v_u_44[v811] and v812 - v_u_44[v811] < 1.5 then
								v813 = false
							else
								v_u_44[v811] = v812
								v813 = true
							end
							if v813 then
								v_u_37:PlayAt("SaberX", p_u_756.Position)
							end
						end
					end
				elseif p_u_756.VFXName == "C" then
					if v759 == "Gojo" then
						local v814 = (p_u_756.NPCModel or "unknown") .. "_C"
						local v815 = tick()
						local v816
						if v_u_44[v814] and v815 - v_u_44[v814] < 1.5 then
							v816 = false
						else
							v_u_44[v814] = v815
							v816 = true
						end
						if v816 then
							v_u_37:PlayAt("GojoC", p_u_756.Position)
							v_u_37:PlayAt("GojoC_Hold", p_u_756.Position)
						end
					elseif v759 == "Jinwoo" then
						local v817 = (p_u_756.NPCModel or "unknown") .. "_C"
						local v818 = tick()
						local v819
						if v_u_44[v817] and v818 - v_u_44[v817] < 1.5 then
							v819 = false
						else
							v_u_44[v817] = v818
							v819 = true
						end
						if v819 then
							v_u_37:PlayAt("JinwooC", p_u_756.Position)
						end
					elseif v759 == "Ragna" then
						local v820 = (p_u_756.NPCModel or "unknown") .. "_C"
						local v821 = tick()
						local v822
						if v_u_44[v820] and v821 - v_u_44[v820] < 1.5 then
							v822 = false
						else
							v_u_44[v820] = v821
							v822 = true
						end
						if v822 then
							v_u_37:PlayAt("RagnaC_Startup", p_u_756.Position)
						end
					elseif v759 == "Aizen" then
						local v823 = (p_u_756.NPCModel or "unknown") .. "_C"
						local v824 = tick()
						local v825
						if v_u_44[v823] and v824 - v_u_44[v823] < 1.5 then
							v825 = false
						else
							v_u_44[v823] = v824
							v825 = true
						end
						if v825 then
							v_u_37:PlayAt("AizenC", p_u_756.Position)
						end
					elseif v759 == "QinShi" then
						local v826 = (p_u_756.NPCModel or "unknown") .. "_C"
						local v827 = tick()
						local v828
						if v_u_44[v826] and v827 - v_u_44[v826] < 1.5 then
							v828 = false
						else
							v_u_44[v826] = v827
							v828 = true
						end
						if v828 then
							v_u_37:PlayAt("QinShiC", p_u_756.Position)
						end
					elseif v759 == "Yuji" then
						local v829 = (p_u_756.NPCModel or "unknown") .. "_C"
						local v830 = tick()
						local v831
						if v_u_44[v829] and v830 - v_u_44[v829] < 1.5 then
							v831 = false
						else
							v_u_44[v829] = v830
							v831 = true
						end
						if v831 then
							v_u_37:PlayAt("YujiC_Press", p_u_756.Position)
						end
					elseif v759 ~= "Ichigo" and (v759 ~= "Alucard" and (v759 ~= "GojoV2" and v759 ~= "StrongestInHistory")) then
						local v832 = (p_u_756.NPCModel or "unknown") .. "_C"
						local v833 = tick()
						local v834
						if v_u_44[v832] and v833 - v_u_44[v832] < 1.5 then
							v834 = false
						else
							v_u_44[v832] = v833
							v834 = true
						end
						if v834 then
							v_u_37:PlayAt("SaberC_Cast", p_u_756.Position)
							task.delay(3.85, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_756
								v_u_37:PlayAt("SaberC_Beam", p_u_756.Position)
							end)
							task.delay(4.4, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_756
								v_u_37:PlayAt("SaberC_Explosion", p_u_756.Position)
							end)
						end
					end
				elseif p_u_756.VFXName == "V" then
					if v759 == "Gojo" then
						v_u_37:PlayAt("GojoV", p_u_756.Position)
					elseif v759 ~= "Sukuna" and (v759 ~= "Ichigo" and (v759 ~= "Alucard" and v759 ~= "GojoV2")) then
						local _ = v759 == "StrongestInHistory"
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_299, (copy) p_u_756
					v_u_299.SpawnVFX(p_u_756.VFXName, p_u_756.Position, p_u_756.Scale, p_u_756.Duration, p_u_756.AbilityName)
				end)
			end
			if p_u_756.CameraShake then
				task.delay(p_u_756.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_756, (ref) v_u_7
					local v_u_835 = p_u_756.CameraShake.Intensity or 5
					local v_u_836 = p_u_756.CameraShake.Duration or 0.3
					if v_u_7:GetAttribute("DisableScreenShake") then
						return
					else
						local v_u_837 = workspace.CurrentCamera
						if v_u_837 then
							task.spawn(function()
								-- upvalues: (copy) v_u_837, (copy) v_u_836, (copy) v_u_835
								local v838 = tick()
								local _ = v_u_837.CFrame
								while tick() - v838 < v_u_836 do
									local v839 = v_u_835 * (1 - (tick() - v838) / v_u_836)
									local v840 = (math.random() - 0.5) * v839 * 0.1
									local v841 = (math.random() - 0.5) * v839 * 0.1
									v_u_837.CFrame = v_u_837.CFrame * CFrame.new(v840, v841, 0)
									task.wait()
								end
							end)
						end
					end
				end)
			end
			if p_u_756.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_305, (copy) p_u_756
					v_u_305(p_u_756.ScreenFlash)
				end)
				return
			end
		elseif p755 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_299, (copy) p_u_756, (ref) v_u_4
				local v842 = v_u_299.SpawnVFXWithRotation(p_u_756.VFXName, p_u_756.Position, p_u_756.Rotation, p_u_756.Scale, p_u_756.Duration, "KatanaAbilities")
				if v842 then
					v_u_4:AddItem(v842, (p_u_756.Duration or 0.4) + 1)
				end
			end)
			if p_u_756.IsNPC then
				v_u_37:PlayAt("KatanaZ", p_u_756.Position)
			end
			if p_u_756.CameraShake then
				local v_u_843 = p_u_756.CameraShake.Intensity or 3
				local v_u_844 = p_u_756.CameraShake.Duration or 0.2
				if v_u_7:GetAttribute("DisableScreenShake") then
					return
				else
					local v_u_845 = workspace.CurrentCamera
					if v_u_845 then
						task.spawn(function()
							-- upvalues: (copy) v_u_845, (copy) v_u_844, (copy) v_u_843
							local v846 = tick()
							local _ = v_u_845.CFrame
							while tick() - v846 < v_u_844 do
								local v847 = v_u_843 * (1 - (tick() - v846) / v_u_844)
								local v848 = (math.random() - 0.5) * v847 * 0.1
								local v849 = (math.random() - 0.5) * v847 * 0.1
								v_u_845.CFrame = v_u_845.CFrame * CFrame.new(v848, v849, 0)
								task.wait()
							end
						end)
					end
				end
			end
		elseif p755 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_299, (copy) p_u_756, (ref) v_u_4
				local v850 = v_u_299.SpawnTravelingVFX(p_u_756.VFXName, p_u_756.StartPosition, p_u_756.Direction, p_u_756.TravelDistance, p_u_756.TravelSpeed, p_u_756.Scale, p_u_756.Duration, "KatanaAbilities")
				if v850 then
					v_u_4:AddItem(v850, (p_u_756.TravelDistance or 50) / (p_u_756.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_756.CameraShake then
				local v_u_851 = p_u_756.CameraShake.Intensity or 6
				local v_u_852 = p_u_756.CameraShake.Duration or 0.3
				local v_u_853 = not v_u_7:GetAttribute("DisableScreenShake") and workspace.CurrentCamera
				if v_u_853 then
					task.spawn(function()
						-- upvalues: (copy) v_u_853, (copy) v_u_852, (copy) v_u_851
						local v854 = tick()
						local _ = v_u_853.CFrame
						while tick() - v854 < v_u_852 do
							local v855 = v_u_851 * (1 - (tick() - v854) / v_u_852)
							local v856 = (math.random() - 0.5) * v855 * 0.1
							local v857 = (math.random() - 0.5) * v855 * 0.1
							v_u_853.CFrame = v_u_853.CFrame * CFrame.new(v856, v857, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_756.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_305, (copy) p_u_756
					v_u_305(p_u_756.ScreenFlash)
				end)
			end
		end
	end)
	local v858 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_859 = 1
	v858.OnClientEvent:Connect(function(p860)
		-- upvalues: (ref) v_u_859, (copy) v_u_37
		if p860 and p860.Position then
			v_u_37:PlayAt("CombatHit" .. v_u_859, p860.Position)
			v_u_859 = v_u_859 % 7 + 1
		end
	end)
	local v_u_861 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v862 = v46:WaitForChild("HitboxVisualize", 5)
	if v862 then
		v862.OnClientEvent:Connect(function(p863)
			-- upvalues: (copy) v_u_861
			if p863.Type == "Box" then
				v_u_861.ShowBox(p863.CFrame, p863.Size, p863.Duration, p863.Color)
				return
			elseif p863.Type == "Sphere" then
				v_u_861.ShowSphere(p863.Position, p863.Radius, p863.Duration, p863.Color)
				return
			elseif p863.Type == "Traveling" then
				v_u_861.ShowTraveling(p863.StartPos, p863.Direction, p863.Size, p863.Speed, p863.Distance, p863.HitboxType, p863.Color)
			elseif p863.Type == "FollowingAOE" then
				local v864 = p863.Character
				if v864 then
					v_u_861.ShowFollowingAOE(v864, p863.Size, p863.Duration, p863.Offset, p863.Color, p863.Shape)
					return
				end
			else
				if p863.Type == "MultiWave" then
					v_u_861.ShowMultiWave(p863.OriginCFrame, p863.Waves)
					return
				end
				if p863.Type == "Explosion" then
					v_u_861.ShowExplosion(p863.Position, p863.Radius, p863.Duration, p863.Color)
					return
				end
				if p863.Type == "StaticBox" then
					v_u_861.ShowStaticBox(p863.StartPos, p863.EndPos, p863.Width, p863.Height, p863.Duration, p863.Color)
				end
			end
		end)
	end
end)
if not v865 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v866)
	warn("=====================================")
end