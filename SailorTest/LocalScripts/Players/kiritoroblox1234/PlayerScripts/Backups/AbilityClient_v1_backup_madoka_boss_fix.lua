local v881, v882 = pcall(function()
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
	local function v_u_769(p_u_307)
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
										elseif v_u_312 == "Madoka" then
											local v516 = v_u_69.Madoka
											if v516 and v516["Skill 2"] then
												local v517 = {
													["Caster"] = {
														["Character"] = v_u_315
													}
												}
												v516["Skill 2"](v517)
												return
											end
										else
											task.wait(0.35)
											if not (v_u_316 and v_u_316.Parent) then
												return
											end
											local v518 = v_u_316.CFrame
											local v519 = v_u_313.X:FindFirstChild("EnergySlashes")
											if not v519 then
												return
											end
											local v_u_520 = v519:Clone()
											v_u_520.CFrame = v518 * CFrame.new(0, 1.5, -20)
											v_u_520.Anchored = false
											v_u_520.CanCollide = false
											v_u_520.Transparency = 1
											v_u_520.CastShadow = false
											v_u_520.CanQuery = false
											v_u_520.Massless = true
											v_u_520.Parent = workspace
											v_u_308:AddItem(v_u_520, 4)
											local v521 = Instance.new("WeldConstraint")
											v521.Part0 = v_u_520
											v521.Part1 = v_u_316
											v521.Parent = v_u_520
											v_u_308:AddItem(v521, 2.06)
											task.delay(2.05, function()
												-- upvalues: (copy) v_u_520
												for _, v522 in v_u_520:GetDescendants() do
													if v522:IsA("ParticleEmitter") then
														v522.Enabled = false
													end
												end
												v_u_520.Anchored = true
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
									local v523 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v523 then
										v523 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v523 then
										local v524 = require(v523)
										if v524["Skill 3"] then
											local v525 = v524["Skill 3"]
											local v526 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["Duration"] = p_u_307.Duration or 6
											}
											v525(v526)
										end
									end
									return
								elseif v_u_312 == "StrongestInHistory" then
									local v527 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v527 then
										v527 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v527 then
										local v_u_528 = require(v527)
										if v_u_528["Skill 3"] then
											local v529 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["ChargeTime"] = 2.5
											}
											v_u_528["Skill 3"](v529)
										end
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_528, (ref) v_u_315
											if v_u_316 and v_u_316.Parent then
												local v530 = v_u_316.Position + v_u_316.CFrame.LookVector * 85
												if v_u_528["Skill 3"] then
													local v531 = v_u_528["Skill 3"]
													local v532 = {
														["Caster"] = {
															["Character"] = v_u_315
														},
														["Phase"] = "Explosion",
														["Position"] = v530,
														["CFrame"] = CFrame.new(v530),
														["DOTDuration"] = 3.5
													}
													v531(v532)
												end
											end
										end)
									end
									return
								elseif v_u_312 == "Gojo" then
									local v533 = v_u_313.C:FindFirstChild("DamageVFX")
									if v533 then
										local v534 = v533:Clone()
										v534.CFrame = v_u_316.CFrame
										v534.Anchored = false
										v534.CanCollide = false
										v534.Transparency = 1
										v534.Massless = true
										v534.Parent = workspace
										local v535 = Instance.new("WeldConstraint")
										v535.Part0 = v534
										v535.Part1 = v_u_316
										v535.Parent = v534
										for _, v536 in v534:GetDescendants() do
											if v536:IsA("ParticleEmitter") then
												v536:Emit(v536:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_308:AddItem(v534, 3)
									end
									return
								elseif v_u_312 == "Jinwoo" then
									local v537 = v_u_313.C
									if v537 then
										local v538 = v537:FindFirstChild("EnergySlashes")
										local v539 = v537:FindFirstChild("ShadowVFX")
										if v538 then
											local v_u_540 = v538:Clone()
											v_u_540.CFrame = v_u_316.CFrame * CFrame.new(0, 3.9, 0)
											v_u_540.Anchored = false
											v_u_540.CanCollide = false
											v_u_540.Transparency = 1
											v_u_540.CastShadow = false
											v_u_540.CanQuery = false
											v_u_540.Massless = true
											v_u_540.Parent = workspace
											v_u_308:AddItem(v_u_540, 3.65)
											local v541 = Instance.new("WeldConstraint")
											v541.Part0 = v_u_316
											v541.Part1 = v_u_540
											v541.Parent = v_u_540
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_540
												if v_u_540 and v_u_540.Parent then
													for _, v542 in v_u_540:GetDescendants() do
														if v542:IsA("ParticleEmitter") then
															v542:Emit(v542:GetAttribute("EmitCount") or v542.Rate)
															v542.Enabled = false
														end
													end
												end
											end)
										end
										if v539 then
											local v_u_543 = v539:Clone()
											v_u_543.CFrame = v_u_316.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_543.Anchored = false
											v_u_543.CanCollide = false
											v_u_543.Transparency = 1
											v_u_543.CastShadow = false
											v_u_543.CanQuery = false
											v_u_543.Massless = true
											v_u_543.Parent = workspace
											v_u_308:AddItem(v_u_543, 2.65)
											local v544 = Instance.new("WeldConstraint")
											v544.Part0 = v_u_316
											v544.Part1 = v_u_543
											v544.Parent = v_u_543
											for _, v_u_545 in v_u_543:GetDescendants() do
												if v_u_545:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_545
														local v546 = v_u_545:GetAttribute("EmitDelay") or 0
														if v546 > 0 then
															task.wait(v546)
														end
														v_u_545:Emit(v_u_545:GetAttribute("EmitCount") or v_u_545.Rate)
													end)
												end
											end
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_543
												if v_u_543 and v_u_543.Parent then
													for _, v547 in v_u_543:GetDescendants() do
														if v547:IsA("ParticleEmitter") then
															v547.Enabled = false
														end
													end
												end
											end)
										end
									end
								elseif v_u_312 == "Ragna" then
									local v548 = v_u_313.C
									if v548 then
										local v_u_549 = v548:FindFirstChild("Sword")
										local v_u_550 = v548:FindFirstChild("StartVFX")
										local v_u_551 = v548:FindFirstChild("ExpVFX")
										if v_u_549 then
											local v_u_552 = {}
											local v_u_553 = {}
											for _ = 1, 6 do
												local v554 = 4 + math.random() * 4
												local v555 = (math.random() - 0.5) * 2 * 6
												local v556 = -(3 + math.random() * 3)
												local v557 = {
													["offset"] = Vector3.new(v555, v554, v556)
												}
												table.insert(v_u_552, v557)
											end
											local v_u_558 = 0
											task.spawn(function()
												-- upvalues: (ref) v_u_558, (ref) v_u_316, (copy) v_u_552, (copy) v_u_549, (ref) v_u_308, (copy) v_u_550, (copy) v_u_553
												while v_u_558 < 6 and (v_u_316 and v_u_316.Parent) do
													local v559 = 6 - v_u_558
													local v560 = math.min(2, v559)
													for v561 = 1, v560 do
														local v562 = v_u_552[v_u_558 + v561]
														local v563 = v_u_316.CFrame
														local v564 = v563:VectorToWorldSpace(v562.offset)
														local v565 = v563.Position + v564
														local v566 = v_u_549:Clone()
														v566.CFrame = CFrame.new(v565) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v566.Anchored = true
														v566.CanCollide = false
														v566.CanQuery = false
														v566.Transparency = 0
														v566.Parent = workspace
														v_u_308:AddItem(v566, 3)
														if v_u_550 then
															local v567 = v_u_550:Clone()
															v567.CFrame = v566.CFrame
															v567.Anchored = true
															v567.CanCollide = false
															v567.Transparency = 1
															v567.Parent = workspace
															v_u_308:AddItem(v567, 1)
															for _, v568 in v567:GetDescendants() do
																if v568:IsA("ParticleEmitter") then
																	v568:Emit(v568:GetAttribute("EmitCount") or 20)
																end
															end
														end
														local v569 = v_u_553
														table.insert(v569, {
															["sword"] = v566,
															["spawnData"] = v562
														})
													end
													v_u_558 = v_u_558 + v560
													task.wait(0.25)
												end
											end)
											local v570 = game:GetService("RunService")
											local v_u_571 = nil
											v_u_571 = v570.Heartbeat:Connect(function()
												-- upvalues: (ref) v_u_316, (ref) v_u_571, (copy) v_u_553
												if v_u_316 and v_u_316.Parent then
													local v572 = (1 / 0)
													local v573 = nil
													for _, v574 in ipairs(game.Players:GetPlayers()) do
														if v574.Character and v574.Character:FindFirstChild("HumanoidRootPart") then
															local v575 = v574.Character.HumanoidRootPart
															local v576 = (v575.Position - v_u_316.Position).Magnitude
															if v576 < v572 and v576 < 150 then
																v573 = v575.Position
																v572 = v576
															end
														end
													end
													for _, v577 in ipairs(v_u_553) do
														local v578 = v577.sword
														if v578 and (v578.Parent and not v577.launched) then
															local v579 = v578.Position
															local v580
															if v573 then
																local v581 = v573 - v579
																if v581.Magnitude > 0.1 then
																	local v582 = v581.Unit
																	v580 = CFrame.lookAt(v579, v579 + v582) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793)
																else
																	v580 = CFrame.new(v579) * CFrame.Angles(1.5707963267948966, 0, 0)
																end
															else
																v580 = CFrame.new(v579) * v_u_316.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v578.CFrame = v578.CFrame:Lerp(v580, 0.12)
														end
													end
												elseif v_u_571 then
													v_u_571:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_571, (ref) v_u_316, (copy) v_u_553, (copy) v_u_551, (ref) v_u_308
												if v_u_571 then
													v_u_571:Disconnect()
												end
												if v_u_316 and v_u_316.Parent then
													local v583 = v_u_316.Position + v_u_316.CFrame.LookVector * 30
													local v584 = (1 / 0)
													for _, v585 in ipairs(game.Players:GetPlayers()) do
														if v585.Character and v585.Character:FindFirstChild("HumanoidRootPart") then
															local v586 = v585.Character.HumanoidRootPart
															local v587 = (v586.Position - v_u_316.Position).Magnitude
															if v587 < v584 and v587 < 150 then
																v583 = v586.Position
																v584 = v587
															end
														end
													end
													local v_u_588 = CFrame.new(v583)
													for v589, v_u_590 in ipairs(v_u_553) do
														task.delay((v589 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_590, (copy) v_u_588, (ref) v_u_551, (ref) v_u_308
															local v_u_591 = v_u_590.sword
															if v_u_591 and v_u_591.Parent then
																v_u_590.launched = true
																local v_u_592 = v_u_591.Position
																local v593 = v_u_588.Position
																local v594 = math.random(-8, 8)
																local v595 = math.random
																local v_u_596 = v593 + Vector3.new(v594, 0, v595(-8, 8))
																local v597 = (v_u_592 + v_u_596) / 2
																local v598 = math.random(-60, 60)
																local v599 = math.rad(v598)
																local v600 = 12 + math.random() * 5
																local v601 = math.sin(v599) * 5
																local v602 = math.cos(v599) * 5
																local v_u_603 = v597 + Vector3.new(v601, v600, v602)
																local v_u_604 = tick()
																task.spawn(function()
																	-- upvalues: (copy) v_u_604, (copy) v_u_592, (copy) v_u_603, (copy) v_u_596, (copy) v_u_591, (ref) v_u_551, (ref) v_u_308
																	while tick() - v_u_604 < 0.4 do
																		local v605 = (tick() - v_u_604) / 0.4
																		local v606 = v_u_592
																		local v607 = v_u_603
																		local v608 = v_u_596
																		local v609 = 1 - v605
																		local v610 = v609 * v609 * v606 + 2 * v609 * v605 * v607 + v605 * v605 * v608
																		local v611 = v605 + 0.05
																		local v612 = math.min(v611, 1)
																		local v613 = v_u_592
																		local v614 = v_u_603
																		local v615 = v_u_596
																		local v616 = 1 - v612
																		local v617 = v616 * v616 * v613 + 2 * v616 * v612 * v614 + v612 * v612 * v615 - v610
																		if v_u_591 and (v_u_591.Parent and v617.Magnitude > 0.01) then
																			v_u_591.CFrame = CFrame.lookAt(v610, v610 + v617.Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
																		end
																		task.wait()
																	end
																	if v_u_551 and (v_u_591 and v_u_591.Parent) then
																		local v618 = v_u_551:Clone()
																		v618.CFrame = CFrame.new(v_u_596)
																		v618.Anchored = true
																		v618.CanCollide = false
																		v618.Transparency = 1
																		v618.Parent = workspace
																		v_u_308:AddItem(v618, 1.5)
																		for _, v619 in v618:GetDescendants() do
																			if v619:IsA("ParticleEmitter") then
																				v619:Emit(v619:GetAttribute("EmitCount") or 30)
																			end
																		end
																	end
																	if v_u_591 and v_u_591.Parent then
																		v_u_591:Destroy()
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
									local v_u_620 = v_u_313.C
									if v_u_620 then
										local v_u_621 = {}
										local function v_u_627(p622, p623)
											-- upvalues: (ref) v_u_316, (ref) v_u_308
											if not p622 then
												return nil
											end
											local v624 = p622:Clone()
											v624.CFrame = v_u_316.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v624.Anchored = false
											v624.CanCollide = false
											v624.Transparency = 1
											v624.CastShadow = false
											v624.CanQuery = false
											v624.Massless = true
											v624.Parent = workspace
											v_u_308:AddItem(v624, p623)
											local v625 = Instance.new("WeldConstraint")
											v625.Part0 = v_u_316
											v625.Part1 = v624
											v625.Parent = v624
											for _, v626 in v624:GetDescendants() do
												if v626:IsA("ParticleEmitter") or (v626:IsA("Beam") or v626:IsA("Trail")) then
													v626.Enabled = true
												end
											end
											return v624
										end
										local v628 = v_u_627(v_u_620:FindFirstChild("ChargeVFX"), 4)
										if v628 then
											table.insert(v_u_621, v628)
										end
										local v629 = v_u_627(v_u_620:FindFirstChild("AuraVFX1"), 4)
										if v629 then
											table.insert(v_u_621, v629)
										end
										task.delay(0.25, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_627, (copy) v_u_620, (copy) v_u_621
											if v_u_316 and v_u_316.Parent then
												local v630 = v_u_627(v_u_620:FindFirstChild("AuraVFX2"), 3.75)
												if v630 then
													local v631 = v_u_621
													table.insert(v631, v630)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_627, (copy) v_u_620, (copy) v_u_621
											if v_u_316 and v_u_316.Parent then
												local v632 = v_u_627(v_u_620:FindFirstChild("AuraVFX3"), 3.5)
												if v632 then
													local v633 = v_u_621
													table.insert(v633, v632)
												end
											end
										end)
										task.delay(3, function()
											-- upvalues: (copy) v_u_621
											for _, v634 in pairs(v_u_621) do
												if v634 and v634.Parent then
													for _, v635 in v634:GetDescendants() do
														if v635:IsA("ParticleEmitter") or (v635:IsA("Beam") or v635:IsA("Trail")) then
															v635.Enabled = false
														end
													end
												end
											end
										end)
									end
								elseif v_u_312 == "Rimuru" then
									return
								else
									local v636 = v_u_313.C:FindFirstChild("FirstEffects")
									if v636 then
										local v_u_637 = v636:Clone()
										for _, v638 in v_u_637:GetDescendants() do
											if v638:IsA("BasePart") then
												v638.Anchored = true
												v638.CanCollide = false
												v638.CanQuery = false
												v638.CanTouch = false
												v638.CastShadow = false
												v638.Transparency = 1
											end
										end
										v_u_637:PivotTo(v_u_316.CFrame * CFrame.new(0, -2, 0))
										v_u_637.Parent = workspace
										v_u_308:AddItem(v_u_637, 6)
										task.delay(4.85, function()
											-- upvalues: (copy) v_u_637
											for _, v639 in v_u_637:GetDescendants() do
												if v639:IsA("ParticleEmitter") then
													v639.Enabled = false
												end
											end
										end)
									end
									task.wait(3.85)
									if v_u_316 and v_u_316.Parent then
										local v_u_640 = v_u_316.CFrame
										local v641 = v_u_313.C:FindFirstChild("HorizontalBeam")
										if v641 then
											local v642 = v641:Clone()
											for _, v643 in v642:GetDescendants() do
												if v643:IsA("BasePart") then
													v643.Anchored = true
													v643.CanCollide = false
													v643.CanQuery = false
													v643.CanTouch = false
													v643.CastShadow = false
													v643.Massless = true
													v643.Transparency = 1
												end
												if v643:IsA("Beam") then
													v643.Enabled = false
												end
											end
											v642:PivotTo(v_u_640 * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0))
											v642.Parent = workspace
											v_u_308:AddItem(v642, 6)
											local v644 = {
												["BigBeam1"] = 0,
												["BigBeam2"] = 0.25,
												["BigBeams3"] = 0.5
											}
											local v645 = {
												["BigBeam1"] = 0.36,
												["BigBeam2"] = 0.61,
												["BigBeams3"] = 0.76
											}
											for _, v_u_646 in v642:GetChildren() do
												if v_u_646:IsA("Model") then
													local v_u_647 = v_u_646:FindFirstChild("Beam")
													local v648 = v644[v_u_646.Name] or 0
													local v649 = v645[v_u_646.Name] or 2
													task.delay(v648, function()
														-- upvalues: (copy) v_u_647, (ref) v_u_328, (copy) v_u_646
														if v_u_647 then
															v_u_328(v_u_647, 0.3)
														end
														for _, v650 in v_u_646:GetDescendants() do
															if v650:IsA("ParticleEmitter") and not (v_u_647 and v650:IsDescendantOf(v_u_647)) then
																v650:Emit(v650:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v649, function()
														-- upvalues: (copy) v_u_647, (ref) v_u_334
														if v_u_647 then
															v_u_334(v_u_647, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_313, (copy) v_u_640, (ref) v_u_308, (ref) v_u_334
											if v_u_316 and v_u_316.Parent then
												local v651 = v_u_313.C:FindFirstChild("Explosion")
												if v651 then
													local v_u_652 = v651:Clone()
													for _, v653 in v_u_652:GetDescendants() do
														if v653:IsA("BasePart") then
															v653.Anchored = true
															v653.CanCollide = false
															v653.CanQuery = false
															v653.CanTouch = false
															v653.CastShadow = false
															v653.Transparency = 1
														end
													end
													v_u_652:PivotTo(v_u_640 * CFrame.new(0, 8, -75) * CFrame.Angles(0, 0, 1.5707963267948966))
													v_u_652.Parent = workspace
													v_u_308:AddItem(v_u_652, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_334, (copy) v_u_652
														v_u_334(v_u_652, 0.5)
														for _, v654 in v_u_652:GetDescendants() do
															if v654:IsA("ParticleEmitter") then
																v654.Enabled = false
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
									local v655 = v_u_313:FindFirstChild("C")
									if v655 then
										local v656 = v655:FindFirstChild("BarrageVFX")
										if v656 then
											local v_u_657 = v656:Clone()
											v_u_657.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_657.Anchored = false
											v_u_657.CanCollide = false
											v_u_657.CanQuery = false
											v_u_657.CanTouch = false
											v_u_657.Transparency = 1
											v_u_657.CastShadow = false
											v_u_657.Parent = workspace
											local v658 = Instance.new("WeldConstraint")
											v658.Part0 = v_u_657
											v658.Part1 = v_u_316
											v658.Parent = v_u_657
											for _, v659 in v_u_657:GetDescendants() do
												if v659:IsA("ParticleEmitter") then
													v659.Enabled = true
												end
											end
											task.delay(3, function()
												-- upvalues: (copy) v_u_657
												if v_u_657 and v_u_657.Parent then
													for _, v660 in v_u_657:GetDescendants() do
														if v660:IsA("ParticleEmitter") then
															v660.Enabled = false
														end
													end
												end
											end)
											v_u_308:AddItem(v_u_657, 4)
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
									local v_u_661 = v_u_313:FindFirstChild("C")
									if v_u_661 then
										local v662 = v_u_661:FindFirstChild("AuraVFX3")
										if v662 then
											local v_u_663 = v662:Clone()
											v_u_663.CFrame = v_u_316.CFrame
											v_u_663.Anchored = false
											v_u_663.CanCollide = false
											v_u_663.Transparency = 1
											v_u_663.Massless = true
											v_u_663.Parent = workspace
											local v664 = Instance.new("WeldConstraint")
											v664.Part0 = v_u_316
											v664.Part1 = v_u_663
											v664.Parent = v_u_663
											for _, v665 in v_u_663:GetDescendants() do
												if v665:IsA("ParticleEmitter") then
													v665.Enabled = true
												end
											end
											task.delay(0.8, function()
												-- upvalues: (copy) v_u_663
												if v_u_663 and v_u_663.Parent then
													for _, v666 in v_u_663:GetDescendants() do
														if v666:IsA("ParticleEmitter") then
															v666.Enabled = false
														end
													end
												end
											end)
											v_u_308:AddItem(v_u_663, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_661, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v667 = v_u_661:FindFirstChild("BlackFlashVFX3")
												if v667 then
													local v668 = v667:Clone()
													v668.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -10)
													v668.Anchored = true
													v668.CanCollide = false
													v668.Transparency = 1
													v668.Parent = workspace
													for _, v669 in v668:GetDescendants() do
														if v669:IsA("ParticleEmitter") then
															v669:Emit(v669:GetAttribute("EmitCount") or v669.Rate)
														end
													end
													v_u_308:AddItem(v668, 3)
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
							local v670 = v_u_69.Alucard
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
						if v_u_312 == "Ichigo" then
							local v671 = v_u_69.Ichigo
							if v671 and v671["Skill 3"] then
								v671["Skill 3"]({
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
							local v672 = v_u_69.Rimuru
							if v672 and v672["Skill 3"] then
								v672["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_315
									},
									["DamageDelay"] = 2.5,
									["Duration"] = 5,
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_312 == "Madoka" then
							local v673 = v_u_69.Madoka
							if v673 and v673["Skill 3"] then
								v673["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_315
									},
									["DamageDelay"] = 1.03,
									["Duration"] = 3.97
								})
							end
						end
					elseif p_u_307.VFXName == "V" then
						task.spawn(function()
							-- upvalues: (copy) v_u_316, (copy) v_u_312, (ref) v_u_3, (copy) v_u_315, (ref) v_u_313, (copy) v_u_308, (copy) v_u_309, (copy) p_u_307, (ref) v_u_306, (ref) v_u_37, (ref) v_u_69
							if v_u_316 and v_u_316.Parent then
								if v_u_312 == "GojoV2" then
									local v674 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v674 then
										v674 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v674 then
										local v675 = require(v674)
										if v675["Skill 4"] then
											local v676 = {
												["Caster"] = {
													["Character"] = v_u_315
												}
											}
											v675["Skill 4"](v676)
										end
									end
									return
								elseif v_u_312 == "StrongestInHistory" then
									local v677 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v677 then
										v677 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v677 then
										local v678 = require(v677)
										if v678["Skill 4"] then
											local v679 = v678["Skill 4"]
											local v680 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["CutsceneDuration"] = 6.5,
												["DamageDelay"] = 5,
												["CharAnimationId"] = "rbxassetid://125013796988038"
											}
											local v681 = v_u_316
											if v681 then
												v681 = v_u_316.CFrame
											end
											v680.CFrame = v681
											v679(v680)
										end
									end
									return
								elseif v_u_312 == "Gojo" then
									local v_u_682 = v_u_313.V
									if v_u_682 then
										local v_u_683 = Instance.new("Attachment")
										v_u_683.Name = "BlueAtt"
										v_u_683.Position = Vector3.new(7, 2, 5)
										v_u_683.Parent = v_u_316
										local v_u_684 = Instance.new("Attachment")
										v_u_684.Name = "RedAtt"
										v_u_684.Position = Vector3.new(-7, 2, 5)
										v_u_684.Parent = v_u_316
										local v_u_685 = nil
										local v_u_686 = nil
										local function v_u_695(p687, p688)
											-- upvalues: (copy) v_u_682, (ref) v_u_316
											local v689 = v_u_682:FindFirstChild(p687)
											if not v689 then
												return nil
											end
											local v690 = v689:Clone()
											v690.CFrame = v_u_316.CFrame * CFrame.new(p688.Position)
											v690.Anchored = true
											v690.CanCollide = false
											v690.Massless = true
											v690.Transparency = 1
											v690.Parent = workspace
											local v691 = Instance.new("Attachment")
											v691.Parent = v690
											local v692 = Instance.new("AlignPosition")
											v692.Attachment0 = v691
											v692.Attachment1 = p688
											v692.RigidityEnabled = false
											v692.Responsiveness = 100
											v692.MaxForce = (1 / 0)
											v692.Parent = v690
											local v693 = Instance.new("AlignOrientation")
											v693.Attachment0 = v691
											v693.Attachment1 = p688
											v693.RigidityEnabled = false
											v693.Responsiveness = 100
											v693.MaxTorque = (1 / 0)
											v693.Parent = v690
											v690.Anchored = false
											for _, v694 in v690:GetDescendants() do
												if v694:IsA("ParticleEmitter") then
													v694.Enabled = true
												elseif v694:IsA("Beam") or v694:IsA("Trail") then
													v694.Enabled = true
												end
											end
											return v690
										end
										local function v_u_699(p696, p697)
											if p696 and p696.Parent then
												for _, v_u_698 in p696:GetDescendants() do
													if v_u_698:IsA("ParticleEmitter") then
														v_u_698.Enabled = false
														if p697 then
															pcall(function()
																-- upvalues: (copy) v_u_698
																v_u_698:Clear()
															end)
														end
													elseif v_u_698:IsA("Beam") or v_u_698:IsA("Trail") then
														v_u_698.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_685, (copy) v_u_695, (copy) v_u_683, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_685 = v_u_695("Blue", v_u_683)
												if v_u_685 then
													v_u_308:AddItem(v_u_685, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_686, (copy) v_u_695, (copy) v_u_684, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_686 = v_u_695("Red", v_u_684)
												if v_u_686 then
													v_u_308:AddItem(v_u_686, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_316, (ref) v_u_309, (copy) v_u_683, (copy) v_u_684, (copy) v_u_682, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v700 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_309:Create(v_u_683, v700, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_309:Create(v_u_684, v700, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_316, (ref) v_u_682, (ref) v_u_308
													if v_u_316 and v_u_316.Parent then
														local v701 = v_u_682:FindFirstChild("StarEff")
														if v701 then
															local v702 = v701:Clone()
															v702.CFrame = v_u_316.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v702.Anchored = true
															v702.CanCollide = false
															v702.Transparency = 1
															v702.Parent = workspace
															for _, v703 in v702:GetDescendants() do
																if v703:IsA("ParticleEmitter") then
																	v703:Emit(v703:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_308:AddItem(v702, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_699, (ref) v_u_685, (ref) v_u_686, (copy) v_u_683, (copy) v_u_684, (copy) v_u_682, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												v_u_699(v_u_685, true)
												v_u_699(v_u_686, true)
												if v_u_683 and v_u_683.Parent then
													v_u_683:Destroy()
												end
												if v_u_684 and v_u_684.Parent then
													v_u_684:Destroy()
												end
												local v704 = v_u_682:FindFirstChild("MiniExplosionVFX")
												if v704 then
													local v705 = v704:Clone()
													v705.CFrame = v_u_316.CFrame * CFrame.new(0, 0, -2)
													v705.Anchored = true
													v705.CanCollide = false
													v705.Transparency = 1
													v705.Parent = workspace
													for _, v706 in v705:GetDescendants() do
														if v706:IsA("ParticleEmitter") then
															v706:Emit(v706:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_308:AddItem(v705, 3)
												end
												local v_u_707 = v_u_316.Position + v_u_316.CFrame.LookVector * 6
												local v_u_708 = v_u_316.CFrame.LookVector
												local v709 = v_u_682:FindFirstChild("Purple")
												if v709 then
													local v_u_710 = v709:Clone()
													v_u_710.Anchored = true
													v_u_710.CanCollide = false
													v_u_710.Parent = workspace
													v_u_308:AddItem(v_u_710, 3)
													for _, v711 in v_u_710:GetDescendants() do
														if v711:IsA("ParticleEmitter") then
															v711.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_707, (copy) v_u_710, (copy) v_u_708
														local v712 = v_u_707
														local v713 = 0
														while v713 < 200 and (v_u_710 and v_u_710.Parent) do
															v712 = v712 + v_u_708 * 3.9899999999999998
															v713 = v713 + 3.9899999999999998
															v_u_710.CFrame = CFrame.lookAt(v712, v712 + v_u_708)
															task.wait(0.03)
														end
														for _, v714 in v_u_710:GetDescendants() do
															if v714:IsA("ParticleEmitter") then
																v714.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_312 == "Sukuna" then
									local v_u_715 = v_u_313.V
									if v_u_715 then
										local v716 = (p_u_307.NPCModel or "NPC") .. "_SukunaV"
										local v717 = tick()
										if not v_u_306[v716] or v717 - v_u_306[v716] > 0.5 then
											v_u_306[v716] = v717
											v_u_37:PlayAt("SukunaV_Part1", p_u_307.Position)
										end
										local v718 = v_u_715:FindFirstChild("GroundVFX")
										if v718 then
											local v_u_719 = v718:Clone()
											v_u_719.CFrame = v_u_316.CFrame * CFrame.new(0, -2, 0)
											v_u_719.Anchored = false
											v_u_719.Parent = workspace
											v_u_308:AddItem(v_u_719, 3)
											local v720 = Instance.new("WeldConstraint")
											v720.Part0 = v_u_316
											v720.Part1 = v_u_719
											v720.Parent = v_u_719
											for _, v721 in v_u_719:GetDescendants() do
												if v721:IsA("ParticleEmitter") then
													v721.Enabled = true
													v721:Emit(v721:GetAttribute("EmitCount") or 40)
												elseif v721:IsA("Beam") then
													v721.Enabled = true
												end
											end
											task.delay(2.35, function()
												-- upvalues: (copy) v_u_719
												if v_u_719 and v_u_719.Parent then
													for _, v722 in v_u_719:GetDescendants() do
														if v722:IsA("ParticleEmitter") then
															v722.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_715, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v723 = v_u_715:FindFirstChild("MiniExplosionVFX")
												if v723 then
													local v724 = v723:Clone()
													v724.CFrame = v_u_316.CFrame * CFrame.new(1, 0, 0)
													v724.Anchored = false
													v724.Parent = workspace
													v_u_308:AddItem(v724, 2)
													local v725 = Instance.new("WeldConstraint")
													v725.Part0 = v_u_316
													v725.Part1 = v724
													v725.Parent = v724
													for _, v726 in v724:GetDescendants() do
														if v726:IsA("ParticleEmitter") then
															v726:Emit(v726:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v727 = v_u_715:FindFirstChild("ArrowVFX")
												if v727 then
													local v_u_728 = v727:Clone()
													v_u_728.CFrame = v_u_316.CFrame * CFrame.new(1, 0, 0)
													v_u_728.Anchored = false
													v_u_728.Parent = workspace
													v_u_308:AddItem(v_u_728, 2)
													local v729 = Instance.new("WeldConstraint")
													v729.Part0 = v_u_316
													v729.Part1 = v_u_728
													v729.Parent = v_u_728
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_728
														if v_u_728 and v_u_728.Parent then
															for _, v730 in v_u_728:GetDescendants() do
																if v730:IsA("ParticleEmitter") or v730:IsA("Beam") then
																	v730.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_316, (ref) p_u_307, (ref) v_u_306, (ref) v_u_37, (copy) v_u_715, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v731 = (p_u_307.NPCModel or "NPC") .. "_SukunaV2"
												local v732 = tick()
												if not v_u_306[v731] or v732 - v_u_306[v731] > 0.5 then
													v_u_306[v731] = v732
													v_u_37:PlayAt("SukunaV_Part2", v_u_316.Position)
												end
												local v733 = v_u_316.CFrame.LookVector
												local v734 = v_u_316.Position + v733 * 85
												local v735 = v_u_715:FindFirstChild("ExplosionVFX")
												if v735 then
													local v_u_736 = v735:Clone()
													if v_u_736:IsA("Model") then
														v_u_736:PivotTo(CFrame.new(v734) * CFrame.new(0, 73, 0))
													else
														v_u_736.CFrame = CFrame.new(v734) * CFrame.new(0, 73, 0)
													end
													v_u_736.Parent = workspace
													v_u_308:AddItem(v_u_736, 4)
													for _, v737 in v_u_736:GetDescendants() do
														if v737:IsA("ParticleEmitter") then
															v737.Enabled = true
															v737:Emit(v737:GetAttribute("EmitCount") or 30)
														elseif v737:IsA("Beam") or v737:IsA("Trail") then
															v737.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_736
														if v_u_736 and v_u_736.Parent then
															for _, v738 in v_u_736:GetDescendants() do
																if v738:IsA("ParticleEmitter") or (v738:IsA("Beam") or v738:IsA("Trail")) then
																	v738.Enabled = false
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
									local v_u_739 = v_u_313.V
									if v_u_739 then
										local v740 = v_u_739:FindFirstChild("FirstEffects")
										if v740 then
											local v_u_741 = v740:Clone()
											v_u_741.CFrame = v_u_316.CFrame * CFrame.new(0, -2.5, 0)
											v_u_741.Anchored = false
											v_u_741.CanCollide = false
											v_u_741.Transparency = 1
											v_u_741.CastShadow = false
											v_u_741.CanQuery = false
											v_u_741.Massless = true
											v_u_741.Parent = workspace
											v_u_308:AddItem(v_u_741, 6)
											local v742 = Instance.new("WeldConstraint")
											v742.Part0 = v_u_316
											v742.Part1 = v_u_741
											v742.Parent = v_u_741
											for _, v743 in v_u_741:GetDescendants() do
												if v743:IsA("ParticleEmitter") then
													v743.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_741
												if v_u_741 and v_u_741.Parent then
													for _, v744 in v_u_741:GetDescendants() do
														if v744:IsA("ParticleEmitter") then
															v744.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_316, (copy) v_u_739, (ref) v_u_308
											if v_u_316 and v_u_316.Parent then
												local v745 = v_u_739:FindFirstChild("UltVFX")
												if v745 then
													local v_u_746 = v745:Clone()
													v_u_746:PivotTo(v_u_316.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v747 in v_u_746:GetDescendants() do
														if v747:IsA("BasePart") then
															v747.Anchored = true
															v747.CanCollide = false
															v747.CastShadow = false
															v747.CanQuery = false
														end
													end
													v_u_746.Parent = workspace
													v_u_308:AddItem(v_u_746, 4.5)
													for _, v748 in v_u_746:GetDescendants() do
														if v748:IsA("ParticleEmitter") then
															v748.Enabled = true
														elseif v748:IsA("Beam") then
															v748.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_746
														if v_u_746 and v_u_746.Parent then
															for _, v749 in v_u_746:GetDescendants() do
																if v749:IsA("ParticleEmitter") then
																	v749.Enabled = false
																end
															end
															for _, v_u_750 in v_u_746:GetDescendants() do
																if v_u_750:IsA("Beam") then
																	local v_u_751 = v_u_750.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_751, (copy) v_u_750
																		local v752 = tick()
																		while tick() - v752 < 0.5 do
																			local v753 = (tick() - v752) / 0.5
																			local v754 = {}
																			for _, v755 in ipairs(v_u_751) do
																				local v756 = v755.Value + (1 - v755.Value) * v753
																				local v757 = NumberSequenceKeypoint.new
																				local v758 = v755.Time
																				table.insert(v754, v757(v758, v756))
																			end
																			v_u_750.Transparency = NumberSequence.new(v754)
																			task.wait()
																		end
																		v_u_750.Transparency = NumberSequence.new(1)
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
										local v759 = v_u_69.Ichigo
										if v759 and v759["Skill 4"] then
											local v760 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["CutsceneDuration"] = 8.33,
												["CharAnimationId"] = "rbxassetid://98446587158184",
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v759["Skill 4"](v760)
											return
										end
									elseif v_u_312 == "Alucard" then
										local v761 = v_u_69.Alucard
										if v761 and v761["Skill 4"] then
											local v762 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["AbilityConfig"] = {},
												["CutsceneDuration"] = 5.5,
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v761["Skill 4"](v762)
											return
										end
									elseif v_u_312 == "Rimuru" then
										local v763 = v_u_69.Rimuru
										if v763 and v763["Skill 4"] then
											local v764 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v763["Skill 4"](v764)
											return
										end
									elseif v_u_312 == "Madoka" then
										local v765 = v_u_69.Madoka
										if v765 and v765["Skill 4"] then
											local v766 = {
												["Caster"] = {
													["Character"] = v_u_315
												},
												["DamageDelay"] = 3.13,
												["Duration"] = 8.63
											}
											v765["Skill 4"](v766)
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
									local v767 = v_u_69.Rimuru
									if v767 and v767["Skill 5"] then
										local v768 = {
											["Caster"] = {
												["Character"] = v_u_315
											},
											["AbilityConfig"] = {},
											["DisableCutscene"] = true
										}
										v767["Skill 5"](v768)
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
	local v_u_770 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p771, p_u_772)
		-- upvalues: (copy) v_u_770, (copy) v_u_769, (copy) v_u_44, (copy) v_u_37, (copy) v_u_299, (copy) v_u_7, (copy) v_u_305, (copy) v_u_4
		if p771 == "SpawnVFX" then
			if p_u_772.IsNPC and (p_u_772.VFXName == "Z" or (p_u_772.VFXName == "X" or (p_u_772.VFXName == "C" or (p_u_772.VFXName == "V" or p_u_772.VFXName == "F")))) then
				local v773 = (p_u_772.NPCModel or "NPC") .. "_" .. p_u_772.VFXName
				local v774 = tick()
				if v_u_770[v773] and v774 - v_u_770[v773] < 1 then
					return
				end
				v_u_770[v773] = v774
				task.spawn(function()
					-- upvalues: (ref) v_u_769, (copy) p_u_772
					v_u_769(p_u_772)
				end)
				local v775 = p_u_772.MovesetType or "Saber"
				if p_u_772.VFXName == "Z" then
					if v775 == "Gojo" then
						local v776 = (p_u_772.NPCModel or "unknown") .. "_Z"
						local v777 = tick()
						local v778
						if v_u_44[v776] and v777 - v_u_44[v776] < 1.5 then
							v778 = false
						else
							v_u_44[v776] = v777
							v778 = true
						end
						if v778 then
							v_u_37:PlayAt("GojoZ", p_u_772.Position)
						end
					elseif v775 == "Sukuna" then
						local v779 = (p_u_772.NPCModel or "unknown") .. "_Z"
						local v780 = tick()
						local v781
						if v_u_44[v779] and v780 - v_u_44[v779] < 1.5 then
							v781 = false
						else
							v_u_44[v779] = v780
							v781 = true
						end
						if v781 then
							v_u_37:PlayAt("SukunaZ", p_u_772.Position)
						end
					elseif v775 == "Jinwoo" then
						local v782 = (p_u_772.NPCModel or "unknown") .. "_Z"
						local v783 = tick()
						local v784
						if v_u_44[v782] and v783 - v_u_44[v782] < 1.5 then
							v784 = false
						else
							v_u_44[v782] = v783
							v784 = true
						end
						if v784 then
							v_u_37:PlayAt("JinwooZ", p_u_772.Position)
						end
					elseif v775 == "Ragna" then
						local v785 = (p_u_772.NPCModel or "unknown") .. "_Z"
						local v786 = tick()
						local v787
						if v_u_44[v785] and v786 - v_u_44[v785] < 1.5 then
							v787 = false
						else
							v_u_44[v785] = v786
							v787 = true
						end
						if v787 then
							v_u_37:PlayAt("RagnaZ", p_u_772.Position)
						end
					elseif v775 == "Aizen" then
						local v788 = (p_u_772.NPCModel or "unknown") .. "_Z"
						local v789 = tick()
						local v790
						if v_u_44[v788] and v789 - v_u_44[v788] < 1.5 then
							v790 = false
						else
							v_u_44[v788] = v789
							v790 = true
						end
						if v790 then
							v_u_37:PlayAt("AizenZ", p_u_772.Position)
						end
					elseif v775 == "QinShi" then
						local v791 = (p_u_772.NPCModel or "unknown") .. "_Z"
						local v792 = tick()
						local v793
						if v_u_44[v791] and v792 - v_u_44[v791] < 1.5 then
							v793 = false
						else
							v_u_44[v791] = v792
							v793 = true
						end
						if v793 then
							v_u_37:PlayAt("QinShiZ", p_u_772.Position)
						end
					elseif v775 == "Yuji" then
						local v794 = (p_u_772.NPCModel or "unknown") .. "_Z"
						local v795 = tick()
						local v796
						if v_u_44[v794] and v795 - v_u_44[v794] < 1.5 then
							v796 = false
						else
							v_u_44[v794] = v795
							v796 = true
						end
						if v796 then
							v_u_37:PlayAt("YujiZ", p_u_772.Position)
						end
					elseif v775 ~= "Alucard" then
						if v775 == "GojoV2" then
							local v797 = (p_u_772.NPCModel or "unknown") .. "_Z"
							local v798 = tick()
							local v799
							if v_u_44[v797] and v798 - v_u_44[v797] < 1.5 then
								v799 = false
							else
								v_u_44[v797] = v798
								v799 = true
							end
							if v799 then
								v_u_37:PlayAt("GojoV2Z", p_u_772.Position)
							end
						elseif v775 ~= "StrongestInHistory" and (v775 ~= "Rimuru" and v775 ~= "Madoka") then
							local v800 = (p_u_772.NPCModel or "unknown") .. "_Z"
							local v801 = tick()
							local v802
							if v_u_44[v800] and v801 - v_u_44[v800] < 1.5 then
								v802 = false
							else
								v_u_44[v800] = v801
								v802 = true
							end
							if v802 then
								v_u_37:PlayAt("SaberZ", p_u_772.Position)
							end
						end
					end
				elseif p_u_772.VFXName == "X" then
					if v775 == "Gojo" then
						local v803 = (p_u_772.NPCModel or "unknown") .. "_X"
						local v804 = tick()
						local v805
						if v_u_44[v803] and v804 - v_u_44[v803] < 1.5 then
							v805 = false
						else
							v_u_44[v803] = v804
							v805 = true
						end
						if v805 then
							v_u_37:PlayAt("GojoX", p_u_772.Position)
						end
					elseif v775 == "Sukuna" then
						local v806 = (p_u_772.NPCModel or "unknown") .. "_X"
						local v807 = tick()
						local v808
						if v_u_44[v806] and v807 - v_u_44[v806] < 1.5 then
							v808 = false
						else
							v_u_44[v806] = v807
							v808 = true
						end
						if v808 then
							v_u_37:PlayAt("SukunaX", p_u_772.Position)
						end
					elseif v775 == "Jinwoo" then
						local v809 = (p_u_772.NPCModel or "unknown") .. "_X"
						local v810 = tick()
						local v811
						if v_u_44[v809] and v810 - v_u_44[v809] < 1.5 then
							v811 = false
						else
							v_u_44[v809] = v810
							v811 = true
						end
						if v811 then
							v_u_37:PlayAt("JinwooX", p_u_772.Position)
						end
					elseif v775 == "Ragna" then
						local v812 = (p_u_772.NPCModel or "unknown") .. "_X"
						local v813 = tick()
						local v814
						if v_u_44[v812] and v813 - v_u_44[v812] < 1.5 then
							v814 = false
						else
							v_u_44[v812] = v813
							v814 = true
						end
						if v814 then
							v_u_37:PlayAt("RagnaX", p_u_772.Position)
						end
					elseif v775 == "Aizen" then
						local v815 = (p_u_772.NPCModel or "unknown") .. "_X"
						local v816 = tick()
						local v817
						if v_u_44[v815] and v816 - v_u_44[v815] < 1.5 then
							v817 = false
						else
							v_u_44[v815] = v816
							v817 = true
						end
						if v817 then
							v_u_37:PlayAt("AizenX", p_u_772.Position)
						end
					elseif v775 == "QinShi" then
						local v818 = (p_u_772.NPCModel or "unknown") .. "_X"
						local v819 = tick()
						local v820
						if v_u_44[v818] and v819 - v_u_44[v818] < 1.5 then
							v820 = false
						else
							v_u_44[v818] = v819
							v820 = true
						end
						if v820 then
							v_u_37:PlayAt("QinShiX", p_u_772.Position)
						end
					elseif v775 == "Yuji" then
						local v821 = (p_u_772.NPCModel or "unknown") .. "_X"
						local v822 = tick()
						local v823
						if v_u_44[v821] and v822 - v_u_44[v821] < 1.5 then
							v823 = false
						else
							v_u_44[v821] = v822
							v823 = true
						end
						if v823 then
							v_u_37:PlayAt("YujiX", p_u_772.Position)
						end
					elseif v775 ~= "Ichigo" and v775 ~= "Alucard" then
						if v775 == "GojoV2" then
							local v824 = (p_u_772.NPCModel or "unknown") .. "_X"
							local v825 = tick()
							local v826
							if v_u_44[v824] and v825 - v_u_44[v824] < 1.5 then
								v826 = false
							else
								v_u_44[v824] = v825
								v826 = true
							end
							if v826 then
								v_u_37:PlayAt("GojoV2X", p_u_772.Position)
							end
						elseif v775 ~= "StrongestInHistory" and (v775 ~= "Rimuru" and v775 ~= "Madoka") then
							local v827 = (p_u_772.NPCModel or "unknown") .. "_X"
							local v828 = tick()
							local v829
							if v_u_44[v827] and v828 - v_u_44[v827] < 1.5 then
								v829 = false
							else
								v_u_44[v827] = v828
								v829 = true
							end
							if v829 then
								v_u_37:PlayAt("SaberX", p_u_772.Position)
							end
						end
					end
				elseif p_u_772.VFXName == "C" then
					if v775 == "Gojo" then
						local v830 = (p_u_772.NPCModel or "unknown") .. "_C"
						local v831 = tick()
						local v832
						if v_u_44[v830] and v831 - v_u_44[v830] < 1.5 then
							v832 = false
						else
							v_u_44[v830] = v831
							v832 = true
						end
						if v832 then
							v_u_37:PlayAt("GojoC", p_u_772.Position)
							v_u_37:PlayAt("GojoC_Hold", p_u_772.Position)
						end
					elseif v775 == "Jinwoo" then
						local v833 = (p_u_772.NPCModel or "unknown") .. "_C"
						local v834 = tick()
						local v835
						if v_u_44[v833] and v834 - v_u_44[v833] < 1.5 then
							v835 = false
						else
							v_u_44[v833] = v834
							v835 = true
						end
						if v835 then
							v_u_37:PlayAt("JinwooC", p_u_772.Position)
						end
					elseif v775 == "Ragna" then
						local v836 = (p_u_772.NPCModel or "unknown") .. "_C"
						local v837 = tick()
						local v838
						if v_u_44[v836] and v837 - v_u_44[v836] < 1.5 then
							v838 = false
						else
							v_u_44[v836] = v837
							v838 = true
						end
						if v838 then
							v_u_37:PlayAt("RagnaC_Startup", p_u_772.Position)
						end
					elseif v775 == "Aizen" then
						local v839 = (p_u_772.NPCModel or "unknown") .. "_C"
						local v840 = tick()
						local v841
						if v_u_44[v839] and v840 - v_u_44[v839] < 1.5 then
							v841 = false
						else
							v_u_44[v839] = v840
							v841 = true
						end
						if v841 then
							v_u_37:PlayAt("AizenC", p_u_772.Position)
						end
					elseif v775 == "QinShi" then
						local v842 = (p_u_772.NPCModel or "unknown") .. "_C"
						local v843 = tick()
						local v844
						if v_u_44[v842] and v843 - v_u_44[v842] < 1.5 then
							v844 = false
						else
							v_u_44[v842] = v843
							v844 = true
						end
						if v844 then
							v_u_37:PlayAt("QinShiC", p_u_772.Position)
						end
					elseif v775 == "Yuji" then
						local v845 = (p_u_772.NPCModel or "unknown") .. "_C"
						local v846 = tick()
						local v847
						if v_u_44[v845] and v846 - v_u_44[v845] < 1.5 then
							v847 = false
						else
							v_u_44[v845] = v846
							v847 = true
						end
						if v847 then
							v_u_37:PlayAt("YujiC_Press", p_u_772.Position)
						end
					elseif v775 ~= "Ichigo" and (v775 ~= "Alucard" and (v775 ~= "GojoV2" and (v775 ~= "StrongestInHistory" and (v775 ~= "Rimuru" and v775 ~= "Madoka")))) then
						local v848 = (p_u_772.NPCModel or "unknown") .. "_C"
						local v849 = tick()
						local v850
						if v_u_44[v848] and v849 - v_u_44[v848] < 1.5 then
							v850 = false
						else
							v_u_44[v848] = v849
							v850 = true
						end
						if v850 then
							v_u_37:PlayAt("SaberC_Cast", p_u_772.Position)
							task.delay(3.85, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_772
								v_u_37:PlayAt("SaberC_Beam", p_u_772.Position)
							end)
							task.delay(4.4, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_772
								v_u_37:PlayAt("SaberC_Explosion", p_u_772.Position)
							end)
						end
					end
				elseif p_u_772.VFXName == "V" then
					if v775 == "Gojo" then
						v_u_37:PlayAt("GojoV", p_u_772.Position)
					elseif v775 ~= "Sukuna" and (v775 ~= "Ichigo" and (v775 ~= "Alucard" and (v775 ~= "GojoV2" and (v775 ~= "StrongestInHistory" and v775 ~= "Rimuru")))) then
						local _ = v775 == "Madoka"
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_299, (copy) p_u_772
					v_u_299.SpawnVFX(p_u_772.VFXName, p_u_772.Position, p_u_772.Scale, p_u_772.Duration, p_u_772.AbilityName)
				end)
			end
			if p_u_772.CameraShake then
				task.delay(p_u_772.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_772, (ref) v_u_7
					local v_u_851 = p_u_772.CameraShake.Intensity or 5
					local v_u_852 = p_u_772.CameraShake.Duration or 0.3
					if v_u_7:GetAttribute("DisableScreenShake") then
						return
					else
						local v_u_853 = workspace.CurrentCamera
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
				end)
			end
			if p_u_772.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_305, (copy) p_u_772
					v_u_305(p_u_772.ScreenFlash)
				end)
				return
			end
		elseif p771 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_299, (copy) p_u_772, (ref) v_u_4
				local v858 = v_u_299.SpawnVFXWithRotation(p_u_772.VFXName, p_u_772.Position, p_u_772.Rotation, p_u_772.Scale, p_u_772.Duration, "KatanaAbilities")
				if v858 then
					v_u_4:AddItem(v858, (p_u_772.Duration or 0.4) + 1)
				end
			end)
			if p_u_772.IsNPC then
				v_u_37:PlayAt("KatanaZ", p_u_772.Position)
			end
			if p_u_772.CameraShake then
				local v_u_859 = p_u_772.CameraShake.Intensity or 3
				local v_u_860 = p_u_772.CameraShake.Duration or 0.2
				if v_u_7:GetAttribute("DisableScreenShake") then
					return
				else
					local v_u_861 = workspace.CurrentCamera
					if v_u_861 then
						task.spawn(function()
							-- upvalues: (copy) v_u_861, (copy) v_u_860, (copy) v_u_859
							local v862 = tick()
							local _ = v_u_861.CFrame
							while tick() - v862 < v_u_860 do
								local v863 = v_u_859 * (1 - (tick() - v862) / v_u_860)
								local v864 = (math.random() - 0.5) * v863 * 0.1
								local v865 = (math.random() - 0.5) * v863 * 0.1
								v_u_861.CFrame = v_u_861.CFrame * CFrame.new(v864, v865, 0)
								task.wait()
							end
						end)
					end
				end
			end
		elseif p771 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_299, (copy) p_u_772, (ref) v_u_4
				local v866 = v_u_299.SpawnTravelingVFX(p_u_772.VFXName, p_u_772.StartPosition, p_u_772.Direction, p_u_772.TravelDistance, p_u_772.TravelSpeed, p_u_772.Scale, p_u_772.Duration, "KatanaAbilities")
				if v866 then
					v_u_4:AddItem(v866, (p_u_772.TravelDistance or 50) / (p_u_772.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_772.CameraShake then
				local v_u_867 = p_u_772.CameraShake.Intensity or 6
				local v_u_868 = p_u_772.CameraShake.Duration or 0.3
				local v_u_869 = not v_u_7:GetAttribute("DisableScreenShake") and workspace.CurrentCamera
				if v_u_869 then
					task.spawn(function()
						-- upvalues: (copy) v_u_869, (copy) v_u_868, (copy) v_u_867
						local v870 = tick()
						local _ = v_u_869.CFrame
						while tick() - v870 < v_u_868 do
							local v871 = v_u_867 * (1 - (tick() - v870) / v_u_868)
							local v872 = (math.random() - 0.5) * v871 * 0.1
							local v873 = (math.random() - 0.5) * v871 * 0.1
							v_u_869.CFrame = v_u_869.CFrame * CFrame.new(v872, v873, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_772.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_305, (copy) p_u_772
					v_u_305(p_u_772.ScreenFlash)
				end)
			end
		end
	end)
	local v874 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_875 = 1
	v874.OnClientEvent:Connect(function(p876)
		-- upvalues: (ref) v_u_875, (copy) v_u_37
		if p876 and p876.Position then
			v_u_37:PlayAt("CombatHit" .. v_u_875, p876.Position)
			v_u_875 = v_u_875 % 7 + 1
		end
	end)
	local v_u_877 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v878 = v46:WaitForChild("HitboxVisualize", 5)
	if v878 then
		v878.OnClientEvent:Connect(function(p879)
			-- upvalues: (copy) v_u_877
			if p879.Type == "Box" then
				v_u_877.ShowBox(p879.CFrame, p879.Size, p879.Duration, p879.Color)
				return
			elseif p879.Type == "Sphere" then
				v_u_877.ShowSphere(p879.Position, p879.Radius, p879.Duration, p879.Color)
				return
			elseif p879.Type == "Traveling" then
				v_u_877.ShowTraveling(p879.StartPos, p879.Direction, p879.Size, p879.Speed, p879.Distance, p879.HitboxType, p879.Color)
			elseif p879.Type == "FollowingAOE" then
				local v880 = p879.Character
				if v880 then
					v_u_877.ShowFollowingAOE(v880, p879.Size, p879.Duration, p879.Offset, p879.Color, p879.Shape)
					return
				end
			else
				if p879.Type == "MultiWave" then
					v_u_877.ShowMultiWave(p879.OriginCFrame, p879.Waves)
					return
				end
				if p879.Type == "Explosion" then
					v_u_877.ShowExplosion(p879.Position, p879.Radius, p879.Duration, p879.Color)
					return
				end
				if p879.Type == "StaticBox" then
					v_u_877.ShowStaticBox(p879.StartPos, p879.EndPos, p879.Width, p879.Height, p879.Duration, p879.Color)
				end
			end
		end)
	end
end)
if not v881 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v882)
	warn("=====================================")
end