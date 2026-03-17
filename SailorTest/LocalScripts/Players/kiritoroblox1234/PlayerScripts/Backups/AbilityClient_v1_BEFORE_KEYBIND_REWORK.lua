local v891, v892 = pcall(function()
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
	local v66 = v_u_3:FindFirstChild("RemoteEvents")
	if v66 then
		v66 = v66:FindFirstChild("GilgameshFUnlockUpdate")
	end
	if v66 then
		v66.OnClientEvent:Connect(function(p67)
			-- upvalues: (copy) v_u_7
			v_u_7:SetAttribute("GilgameshFUnlocked", p67)
		end)
	end
	local function v69()
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
		local v68 = workspace.CurrentCamera
		if v68 then
			v68.FieldOfView = 70
		end
	end
	v_u_7.CharacterAdded:Connect(v69)
	if v_u_7.Character then
		task.spawn(v69)
	end
	local v_u_70 = v_u_54
	local v_u_71 = {}
	local v72 = 0
	for _, v73 in v47:GetChildren() do
		if v73:IsA("ModuleScript") and not (string.find(v73.Name, "DISABLED") or string.find(v73.Name, "BEFORE")) then
			local v74, v75 = pcall(require, v73)
			if v74 then
				v_u_71[v73.Name] = v75
				v72 = v72 + 1
			else
				warn("[AbilityClient] Failed to load VFX handler:", v73.Name, "Error:", v75)
			end
		end
	end
	local function v_u_80()
		-- upvalues: (copy) v_u_7, (copy) v_u_36
		local v76 = v_u_7.Character
		if not v76 then
			return nil
		end
		local v77 = v76:FindFirstChildOfClass("Tool")
		if not v77 then
			return nil
		end
		for v78, v79 in pairs(v_u_36.Movesets) do
			if v79.ToolName and v79.ToolName == v77.Name then
				return v78
			end
		end
		return nil
	end
	local v_u_81 = {}
	local v_u_82 = nil
	local v_u_83 = 0
	local v_u_84 = nil
	local v_u_85 = nil
	local v_u_86 = 0
	local v_u_87 = 0.5
	local v_u_88 = nil
	local v_u_89 = false
	local v_u_90 = false
	local v_u_91 = {}
	local v_u_92 = false
	local v_u_93 = nil
	local v_u_94 = 0
	local v_u_95 = nil
	local v_u_96 = nil
	local v_u_97 = nil
	local v_u_98 = nil
	local v_u_99 = nil
	local v_u_100 = false
	local v_u_101 = false
	local v_u_102 = nil
	local v_u_103 = nil
	local v_u_104 = nil
	local v_u_105 = nil
	local function v_u_107()
		-- upvalues: (ref) v_u_104, (ref) v_u_105, (ref) v_u_93, (ref) v_u_94, (ref) v_u_95, (ref) v_u_96, (ref) v_u_97, (ref) v_u_102, (ref) v_u_103, (ref) v_u_100, (ref) v_u_101, (ref) v_u_98
		if v_u_104 then
			v_u_104:Stop(0)
			v_u_104 = nil
		end
		if v_u_105 then
			v_u_105:Stop()
			v_u_105 = nil
		end
		v_u_93 = nil
		v_u_94 = 0
		v_u_95 = nil
		v_u_96 = nil
		v_u_97 = nil
		local v106 = workspace.CurrentCamera
		if v106 then
			v106.FieldOfView = 70
		end
		if v_u_102 then
			v_u_102:Destroy()
			v_u_102 = nil
		end
		if v_u_103 then
			v_u_103:Destroy()
			v_u_103 = nil
		end
		v_u_100 = false
		v_u_101 = false
		v_u_98 = nil
	end
	local function v110(p108)
		-- upvalues: (copy) v_u_107
		local v109 = p108:WaitForChild("Humanoid", 5)
		if v109 then
			v109.Died:Connect(function()
				-- upvalues: (ref) v_u_107
				v_u_107()
			end)
		end
	end
	local v111 = v_u_7.Character and v_u_7.Character:WaitForChild("Humanoid", 5)
	if v111 then
		v111.Died:Connect(function()
			-- upvalues: (copy) v_u_107
			v_u_107()
		end)
	end
	v_u_7.CharacterAdded:Connect(v110)
	local function v_u_165(p112)
		-- upvalues: (copy) v_u_1, (ref) v_u_98, (ref) v_u_100, (ref) v_u_101, (copy) v_u_3, (copy) v_u_4, (ref) v_u_103, (copy) v_u_7, (copy) v_u_6, (ref) v_u_102, (ref) v_u_93, (ref) v_u_99, (copy) v_u_5, (ref) v_u_105, (copy) v_u_37
		local v_u_113 = workspace.CurrentCamera
		if v_u_113 then
			local v_u_114 = v_u_1.LocalPlayer.Character
			if v_u_114 then
				local v_u_115 = v_u_114:FindFirstChild("Right Arm") or v_u_114:FindFirstChild("RightHand")
				if v_u_115 and v_u_114:FindFirstChild("HumanoidRootPart") then
					v_u_98 = v_u_113.FieldOfView
					v_u_100 = false
					v_u_101 = false
					local v_u_116 = p112.ChargeTier2Time or 2
					local v_u_117 = p112.ChargeTier3Time or 4
					local v118 = v_u_3.AbilitySystem.VFX.Yuji.C
					local v119 = v118:FindFirstChild("ArmVFX1")
					local v_u_120 = v118:FindFirstChild("ArmVFX2")
					local v_u_121 = v118:FindFirstChild("ArmVFX3")
					local v_u_122 = v118:FindFirstChild("AuraVFX1")
					local v_u_123 = v118:FindFirstChild("AuraVFX2")
					local v_u_124 = v118:FindFirstChild("AuraVFX3")
					local v_u_125 = nil
					local v_u_126 = nil
					local v_u_127 = false
					local function v_u_132(p128)
						-- upvalues: (copy) v_u_115
						if not p128 then
							return nil
						end
						local v129 = p128:Clone()
						v129.CFrame = v_u_115.CFrame * CFrame.new(Vector3.new(0, -1, 0))
						v129.Anchored = false
						v129.CanCollide = false
						v129.CanQuery = false
						v129.CanTouch = false
						v129.Transparency = 1
						v129.Parent = workspace
						local v130 = Instance.new("WeldConstraint")
						v130.Part0 = v129
						v130.Part1 = v_u_115
						v130.Parent = v129
						for _, v131 in v129:GetDescendants() do
							if v131:IsA("ParticleEmitter") then
								v131.Enabled = true
								v131:Emit(v131:GetAttribute("EmitCount") or v131.Rate)
							end
						end
						return v129
					end
					local function v_u_138(p133)
						-- upvalues: (copy) v_u_114
						if not p133 then
							return nil
						end
						local v134 = v_u_114:FindFirstChild("HumanoidRootPart")
						if not v134 then
							return nil
						end
						local v135 = p133:Clone()
						v135.CFrame = v134.CFrame * CFrame.new(Vector3.new(0, -2.95, 0))
						v135.Anchored = false
						v135.CanCollide = false
						v135.CanQuery = false
						v135.CanTouch = false
						v135.Transparency = 1
						v135.Parent = workspace
						local v136 = Instance.new("WeldConstraint")
						v136.Part0 = v135
						v136.Part1 = v134
						v136.Parent = v135
						for _, v137 in v135:GetDescendants() do
							if v137:IsA("ParticleEmitter") then
								v137.Enabled = true
								v137:Emit(v137:GetAttribute("EmitCount") or v137.Rate)
							end
						end
						return v135
					end
					local function v_u_141(p139)
						if p139 then
							for _, v140 in p139:GetDescendants() do
								if v140:IsA("ParticleEmitter") then
									v140.Enabled = false
								end
							end
						end
					end
					v_u_125 = v_u_132(v119)
					v_u_102 = v_u_125
					task.delay(0.15, function()
						-- upvalues: (ref) v_u_93, (ref) v_u_127, (ref) v_u_126, (copy) v_u_138, (copy) v_u_122, (ref) v_u_103
						if v_u_93 then
							if not v_u_127 then
								v_u_127 = true
								v_u_126 = v_u_138(v_u_122)
								v_u_103 = v_u_126
							end
						else
							return
						end
					end)
					local v142 = 4 * v_u_117
					v_u_99 = v_u_5:Create(v_u_113, TweenInfo.new(v_u_117, Enum.EasingStyle.Linear), {
						["FieldOfView"] = v_u_98 + v142
					})
					v_u_99:Play()
					task.spawn(function()
						-- upvalues: (ref) v_u_93, (ref) v_u_100, (copy) v_u_116, (ref) v_u_7, (copy) v_u_113, (ref) v_u_6, (copy) v_u_120, (ref) v_u_125, (copy) v_u_132, (copy) v_u_141, (ref) v_u_4, (ref) v_u_102, (copy) v_u_123, (ref) v_u_126, (copy) v_u_138, (ref) v_u_103, (ref) v_u_99, (ref) v_u_5, (copy) v_u_117, (ref) v_u_101, (copy) v_u_121, (copy) v_u_124, (ref) v_u_105, (ref) v_u_37
						local v143 = tick()
						while v_u_93 do
							local v144 = tick() - v143
							if not v_u_100 and v_u_116 <= v144 then
								v_u_100 = true
								if not v_u_7:GetAttribute("DisableScreenShake") then
									local v_u_145 = 0.3
									local v_u_146 = 6
									task.spawn(function()
										-- upvalues: (copy) v_u_145, (copy) v_u_146, (ref) v_u_113, (ref) v_u_6
										local v147 = tick()
										while tick() - v147 < v_u_145 do
											local v148 = v_u_146 * (1 - (tick() - v147) / v_u_145) * 0.01
											local v149 = (math.random() - 0.5) * 2 * v148
											local v150 = (math.random() - 0.5) * 2 * v148
											v_u_113.CFrame = v_u_113.CFrame * CFrame.new(v149, v150, 0)
											v_u_6.RenderStepped:Wait()
										end
									end)
								end
								local v151 = v_u_125
								v_u_125 = v_u_132(v_u_120)
								if v151 then
									v_u_141(v151)
									v_u_4:AddItem(v151, 0.5)
								end
								v_u_102 = v_u_125
								local v152 = v_u_126
								v_u_126 = v_u_138(v_u_123)
								v_u_103 = v_u_126
								if v152 then
									v_u_141(v152)
									v_u_4:AddItem(v152, 0.5)
								end
								if v_u_99 then
									v_u_99:Pause()
								end
								local v153 = v_u_5:Create(v_u_113, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_113.FieldOfView + 5
								})
								v153:Play()
								v153.Completed:Wait()
								if v_u_93 then
									local v154 = v_u_117 - v144
									local v155 = {
										["FieldOfView"] = v_u_113.FieldOfView + 4 * v154
									}
									v_u_99 = v_u_5:Create(v_u_113, TweenInfo.new(v154, Enum.EasingStyle.Linear), v155)
									v_u_99:Play()
								end
							end
							if not v_u_101 and v_u_117 <= v144 then
								v_u_101 = true
								if not v_u_7:GetAttribute("DisableScreenShake") then
									local v_u_156 = 0.3
									local v_u_157 = 10
									task.spawn(function()
										-- upvalues: (copy) v_u_156, (copy) v_u_157, (ref) v_u_113, (ref) v_u_6
										local v158 = tick()
										while tick() - v158 < v_u_156 do
											local v159 = v_u_157 * (1 - (tick() - v158) / v_u_156) * 0.01
											local v160 = (math.random() - 0.5) * 2 * v159
											local v161 = (math.random() - 0.5) * 2 * v159
											v_u_113.CFrame = v_u_113.CFrame * CFrame.new(v160, v161, 0)
											v_u_6.RenderStepped:Wait()
										end
									end)
								end
								local v162 = v_u_125
								v_u_125 = v_u_132(v_u_121)
								if v162 then
									v_u_141(v162)
									v_u_4:AddItem(v162, 0.5)
								end
								v_u_102 = v_u_125
								local v163 = v_u_126
								v_u_126 = v_u_138(v_u_124)
								v_u_103 = v_u_126
								if v163 then
									v_u_141(v163)
									v_u_4:AddItem(v163, 0.5)
								end
								local v164 = v_u_7.Character
								if v164 then
									v164 = v164:FindFirstChild("HumanoidRootPart")
								end
								v_u_105 = v164 and v_u_37:PlayAt("YujiC_HoldLoop", v164.Position)
								if v_u_105 then
									v_u_105.Looped = true
								end
								if v_u_99 then
									v_u_99:Cancel()
									v_u_99 = nil
								end
								v_u_5:Create(v_u_113, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_113.FieldOfView + 5
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
	local function v_u_170()
		-- upvalues: (ref) v_u_99, (ref) v_u_102, (copy) v_u_4, (ref) v_u_103, (ref) v_u_98, (copy) v_u_5, (ref) v_u_100, (ref) v_u_101
		if v_u_99 then
			v_u_99:Cancel()
			v_u_99 = nil
		end
		if v_u_102 and v_u_102.Parent then
			for _, v166 in v_u_102:GetDescendants() do
				if v166:IsA("ParticleEmitter") then
					v166.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_102, 0.15)
		end
		v_u_102 = nil
		if v_u_103 and v_u_103.Parent then
			for _, v167 in v_u_103:GetDescendants() do
				if v167:IsA("ParticleEmitter") then
					v167.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_103, 0.15)
		end
		v_u_103 = nil
		local v168 = workspace.CurrentCamera
		if v168 and v_u_98 then
			local v169 = {
				["FieldOfView"] = v_u_98
			}
			v_u_5:Create(v168, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v169):Play()
		end
		v_u_98 = nil
		v_u_100 = false
		v_u_101 = false
	end
	local function v_u_180(_, p171, p172, p173, p174)
		local v175 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p174 or "Gojo")
		if v175 then
			v175 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p174 or "Gojo"):FindFirstChild("C")
		end
		if not v175 then
			return nil
		end
		local v176 = v175:FindFirstChild(p171)
		if not v176 then
			return nil
		end
		local v177 = v176:Clone()
		v177.CFrame = p172.CFrame
		v177.Anchored = false
		v177.CanCollide = false
		v177.Transparency = 1
		v177.Parent = workspace
		local v178 = Instance.new("WeldConstraint")
		v178.Part0 = p172
		v178.Part1 = v177
		v178.Parent = v177
		for _, v179 in pairs(v177:GetDescendants()) do
			if v179:IsA("ParticleEmitter") then
				v179.Enabled = true
			end
		end
		game:GetService("Debris"):AddItem(v177, p173)
		return v177
	end
	local function v_u_183()
		-- upvalues: (ref) v_u_91
		for _, v181 in pairs(v_u_91) do
			if v181 and v181.Parent then
				for _, v182 in pairs(v181:GetDescendants()) do
					if v182:IsA("ParticleEmitter") then
						v182.Enabled = false
					end
				end
				game:GetService("Debris"):AddItem(v181, 0.5)
			end
		end
		v_u_91 = {}
	end
	local function v_u_192(p184, p185, p_u_186)
		-- upvalues: (copy) v_u_5
		local v187 = workspace.CurrentCamera
		if v187 then
			local v_u_188 = v187.FieldOfView
			local v189 = {
				["FieldOfView"] = v_u_188 + p184
			}
			v_u_5:Create(v187, TweenInfo.new(p185, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), v189):Play()
			task.delay(p185, function()
				-- upvalues: (ref) v_u_5, (copy) p_u_186, (copy) v_u_188
				local v190 = workspace.CurrentCamera
				if v190 then
					local v191 = {
						["FieldOfView"] = v_u_188
					}
					v_u_5:Create(v190, TweenInfo.new(p_u_186, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v191):Play()
				end
			end)
		end
	end
	local function v_u_203(p193)
		-- upvalues: (copy) v_u_183, (copy) v_u_192, (copy) v_u_180, (ref) v_u_85, (ref) v_u_91
		v_u_183()
		v_u_192(10, 0.12, 0.5)
		task.delay(9.5, function()
			-- upvalues: (ref) v_u_192
			v_u_192(10, 0.12, 0.5)
		end)
		local v194 = p193:FindFirstChild("Torso") or p193:FindFirstChild("UpperTorso")
		local v195 = p193:FindFirstChild("Right Arm") or p193:FindFirstChild("RightUpperArm")
		local v196 = p193:FindFirstChild("Left Arm") or p193:FindFirstChild("LeftUpperArm")
		local v197 = v194 and v_u_180(p193, "DamageVFX", v194, 10, v_u_85)
		if v197 then
			local v198 = v_u_91
			table.insert(v198, v197)
		end
		local v199 = v195 and v_u_180(p193, "ArmVFX", v195, 10, v_u_85)
		if v199 then
			local v200 = v_u_91
			table.insert(v200, v199)
		end
		local v201 = v196 and v_u_180(p193, "ArmVFX", v196, 10, v_u_85)
		if v201 then
			local v202 = v_u_91
			table.insert(v202, v201)
		end
	end
	local function v_u_208(p204)
		-- upvalues: (copy) v_u_183, (ref) v_u_92, (copy) v_u_192, (copy) v_u_180, (ref) v_u_85, (ref) v_u_91
		v_u_183()
		v_u_92 = true
		v_u_192(10, 0.12, 0.5)
		task.delay(5.5, function()
			-- upvalues: (ref) v_u_92, (ref) v_u_192
			if v_u_92 then
				v_u_192(10, 0.12, 0.5)
			end
			v_u_92 = false
		end)
		local v205 = p204:FindFirstChild("Torso") or p204:FindFirstChild("UpperTorso")
		local v206 = v205 and v_u_180(p204, "HealVFX", v205, 6, v_u_85)
		if v206 then
			local v207 = v_u_91
			table.insert(v207, v206)
		end
	end
	v_u_2.InputBegan:Connect(function(p209, p210)
		-- upvalues: (ref) v_u_51, (copy) v_u_43, (copy) v_u_7, (copy) v_u_36, (copy) v_u_56, (ref) v_u_58, (ref) v_u_59, (ref) v_u_57, (copy) v_u_80, (copy) v_u_81, (copy) v_u_34, (copy) v_u_48, (copy) v_u_37, (ref) v_u_82, (ref) v_u_83, (ref) v_u_84, (ref) v_u_85, (ref) v_u_86, (ref) v_u_87, (ref) v_u_90, (copy) v_u_203, (ref) v_u_88, (copy) v_u_208, (ref) v_u_89, (copy) v_u_45, (ref) v_u_93, (ref) v_u_94, (ref) v_u_95, (ref) v_u_96, (ref) v_u_97, (copy) v_u_165, (copy) v_u_3, (ref) v_u_104, (copy) v_u_170, (copy) v_u_2
		if p210 then
			return
		elseif v_u_51 then
			return
		elseif v_u_43.InArtifactUI then
			return
		else
			local v211 = v_u_7.Character
			if v211 and v211:GetAttribute("InArtifactUI") then
				return
			elseif v211 and v211:GetAttribute("InCutscene") then
				return
			else
				local v212 = v_u_36.Keybinds[p209.KeyCode] or v_u_56[p209.KeyCode]
				if p209.KeyCode == Enum.KeyCode.DPadUp then
					if v_u_58 then
						task.cancel(v_u_58)
						v_u_58 = nil
					end
					local v213 = tick()
					local v214 = v213 - v_u_59
					v_u_59 = v213
					if v214 <= 0.4 then
						v_u_57 = v_u_57 + 1
					else
						v_u_57 = 1
					end
					if v_u_57 < 2 then
						local v_u_215 = v_u_80()
						local v_u_216 = v_u_7.Character
						v_u_58 = task.delay(0.4, function()
							-- upvalues: (ref) v_u_58, (ref) v_u_57, (ref) v_u_51, (copy) v_u_216, (ref) v_u_36, (copy) v_u_215, (ref) v_u_81, (ref) v_u_34, (ref) v_u_48, (ref) v_u_37
							v_u_58 = nil
							if v_u_57 == 1 then
								v_u_57 = 0
								if v_u_51 then
									return
								elseif v_u_216 and v_u_216:GetAttribute("InCutscene") then
									return
								else
									local v217 = v_u_36.Movesets[v_u_215]
									if v217 and v217.Abilities[4] then
										local v218 = v217.Abilities[4]
										local v219 = v_u_81[v_u_215 .. "_" .. 4]
										local v220
										if v219 and tick() < v219 then
											local _ = v219 - tick()
											v220 = true
										else
											v220 = false
										end
										if v220 then
											return
										elseif v218.Type == "TargetedCutscene" then
											local v221, v222 = v_u_34(v218.TargetRange or 30)
											if v221 then
												v_u_48:FireServer(4, {
													["TargetName"] = v221.Name,
													["TargetPosition"] = v222.Position
												})
											end
										else
											if v_u_215 == "Shadow" then
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
					v212 = 5
				end
				if v212 then
					local v223 = v_u_80()
					local v224 = game:GetService("RunService"):IsStudio()
					if v212 == 5 and (v223 == "Shadow" and not v224) and v_u_7:GetAttribute("ShadowFUnlocked") ~= true then
						return
					elseif v212 == 5 and (v223 == "StrongestInHistory" and not v224) and v_u_7:GetAttribute("SukunaFUnlocked") ~= true then
						return
					elseif v212 == 5 and (v223 == "StrongestOfToday" and not v224) and v_u_7:GetAttribute("GojoFUnlocked") ~= true then
						return
					elseif v212 == 5 and (v223 == "Rimuru" and not v224) and v_u_7:GetAttribute("RimuruFUnlocked") ~= true then
						return
					elseif v212 == 5 and (v223 == "Gilgamesh" and not v224) and v_u_7:GetAttribute("GilgameshFUnlocked") ~= true then
						return
					elseif v223 then
						local v225 = v_u_36.Movesets[v223]
						if v225 and v225.Abilities[v212] then
							local v226 = v225.Abilities[v212]
							if v226.Type == "HoldVariant" then
								local v227 = v_u_81[v223 .. "_" .. v212]
								local v228
								if v227 and tick() < v227 then
									local _ = v227 - tick()
									v228 = true
								else
									v228 = false
								end
								if not v228 then
									v_u_82 = p209.KeyCode
									v_u_83 = tick()
									v_u_84 = v212
									v_u_85 = v223
									v_u_86 = 1
									v_u_87 = v226.HoldThreshold or 0.5
									v_u_90 = false
									local v229 = v_u_7.Character
									if v229 then
										v_u_203(v229)
									end
									if v_u_88 then
										v_u_88:Disconnect()
									end
									v_u_88 = game:GetService("RunService").Heartbeat:Connect(function()
										-- upvalues: (ref) v_u_82, (ref) v_u_88, (ref) v_u_83, (ref) v_u_87, (ref) v_u_86, (ref) v_u_90, (ref) v_u_7, (ref) v_u_208, (ref) v_u_36, (ref) v_u_85, (ref) v_u_84, (ref) v_u_81, (ref) v_u_89, (ref) v_u_45, (ref) v_u_37, (ref) v_u_48
										if v_u_82 then
											if v_u_87 <= tick() - v_u_83 and (v_u_86 == 1 and not v_u_90) then
												v_u_86 = 2
												v_u_90 = true
												local v230 = v_u_7.Character
												if v230 then
													v_u_208(v230)
												end
												local v231 = v_u_36.Movesets[v_u_85]
												if v231 then
													v231 = v231.Abilities[v_u_84]
												end
												if v231 and v231.Cooldown then
													local v232 = v_u_85
													local v233 = v_u_84
													local v234 = v231.Cooldown
													v_u_81[v232 .. "_" .. v233] = tick() + v234
												end
												v_u_89 = true
												local v235 = v_u_85
												local v236 = v_u_84
												local v237 = v_u_45[v235]
												local v238 = v237 and v237[v236]
												if v238 then
													if v236 == 3 then
														v238 = v235 == "Sukuna" and "SukunaC_Hold" or (v235 == "Gojo" and "GojoC_Hold" or v238)
													end
													v_u_37:Play(v238)
												end
												v_u_48:FireServer(v_u_84, {
													["Variant"] = 2
												})
											end
										else
											if v_u_88 then
												v_u_88:Disconnect()
											end
											v_u_88 = nil
										end
									end)
								end
							elseif v226.Type == "ChargedInstant" then
								local v239 = v_u_81[v223 .. "_" .. v212]
								local v240
								if v239 and tick() < v239 then
									local _ = v239 - tick()
									v240 = true
								else
									v240 = false
								end
								if not v240 then
									v_u_93 = p209.KeyCode
									v_u_94 = tick()
									v_u_95 = v212
									v_u_96 = v223
									v_u_97 = v226
									v_u_165(v226)
									if v223 == "Yuji" and v212 == 3 then
										local v241 = v_u_7.Character
										if v241 then
											v241 = v241:FindFirstChild("HumanoidRootPart")
										end
										if v241 then
											v_u_37:PlayAt("YujiC_HoldStart", v241.Position)
										end
										task.delay(0.15, function()
											-- upvalues: (ref) v_u_93, (ref) v_u_95, (ref) v_u_7, (ref) v_u_3, (ref) v_u_104
											if v_u_93 then
												if v_u_95 == 3 then
													local v242 = v_u_7.Character
													if v242 then
														v242 = v242:FindFirstChildOfClass("Humanoid")
													end
													if v242 then
														local v243 = v242:FindFirstChildOfClass("Animator") or Instance.new("Animator", v242)
														local v244 = v_u_3.AbilitySystem.Animations:FindFirstChild("Yuji")
														if v244 then
															v244 = v244:FindFirstChild("Yuji_C_Anim_Hold")
														end
														if v244 then
															if v_u_104 then
																v_u_104:Stop(0)
																v_u_104 = nil
															end
															v_u_104 = v243:LoadAnimation(v244)
															v_u_104.Priority = Enum.AnimationPriority.Action4
															v_u_104.Looped = true
															v_u_104:Play()
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
								local v245 = v_u_81[v223 .. "_" .. v212]
								local v246
								if v245 and tick() < v245 then
									local _ = v245 - tick()
									v246 = true
								else
									v246 = false
								end
								if v246 then
									return
								else
									if v_u_93 then
										v_u_170()
										if v_u_104 then
											v_u_104:Stop(0)
											v_u_104 = nil
										end
										v_u_93 = nil
										v_u_94 = 0
										v_u_95 = nil
										v_u_96 = nil
										v_u_97 = nil
									end
									if v226.Type == "TargetedCutscene" then
										local v247, v248 = v_u_34(v226.TargetRange or 30)
										if v247 then
											local v249 = v_u_81[v223 .. "_" .. v212]
											local v250
											if v249 and tick() < v249 then
												local _ = v249 - tick()
												v250 = true
											else
												v250 = false
											end
											if not v250 then
												v_u_48:FireServer(v212, {
													["TargetName"] = v247.Name,
													["TargetPosition"] = v248.Position
												})
											end
										else
											if v_u_2:GetLastInputType() == Enum.UserInputType.Gamepad1 then
												local v251 = v_u_3:FindFirstChild("Remotes")
												if v251 then
													v251 = v_u_3.Remotes:FindFirstChild("ShowNotification")
												end
												if v251 then
													v251:FireServer("Ability", {
														["message"] = "No target in range",
														["duration"] = 1.5
													})
												end
											end
											return
										end
									else
										if v223 == "Shadow" then
											local v252 = v_u_81[v223 .. "_" .. v212]
											local v253
											if v252 and tick() < v252 then
												local _ = v252 - tick()
												v253 = true
											else
												v253 = false
											end
											if not v253 then
												if v212 == 2 then
													v_u_37:Play("ShadowX_Dash")
												elseif v212 == 4 then
													v_u_37:Play("ShadowV_Ultimate")
												end
											end
										end
										v_u_48:FireServer(v212)
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
	v_u_2.InputEnded:Connect(function(p254, _)
		-- upvalues: (ref) v_u_93, (ref) v_u_94, (ref) v_u_96, (ref) v_u_95, (ref) v_u_97, (copy) v_u_170, (ref) v_u_104, (ref) v_u_105, (copy) v_u_81, (copy) v_u_48, (ref) v_u_82, (ref) v_u_86, (ref) v_u_85, (ref) v_u_84, (ref) v_u_90, (ref) v_u_83, (ref) v_u_87, (ref) v_u_88, (copy) v_u_36, (ref) v_u_89, (copy) v_u_45, (copy) v_u_37
		if v_u_93 and p254.KeyCode == v_u_93 then
			local v255 = tick() - v_u_94
			local v256 = v_u_96
			local v257 = v_u_95
			local v258 = v_u_97
			v_u_170()
			if v_u_104 then
				v_u_104:Stop(0.1)
				v_u_104 = nil
			end
			if v_u_105 then
				v_u_105:Stop()
				v_u_105 = nil
			end
			_G.YujiCharging = false
			v_u_93 = nil
			v_u_94 = 0
			v_u_95 = nil
			v_u_96 = nil
			v_u_97 = nil
			if v256 and (v257 and v258) then
				local v259 = (v258.ChargeTier3Time or 5) <= v255 and 3 or ((v258.ChargeTier2Time or 2.5) <= v255 and 2 or 1)
				if v258.Cooldown then
					local v260 = v258.Cooldown
					v_u_81[v256 .. "_" .. v257] = tick() + v260
				end
				v_u_48:FireServer(v257, {
					["ChargeTier"] = v259,
					["HoldDuration"] = v255
				})
			end
		elseif v_u_82 then
			if p254.KeyCode == v_u_82 then
				local v261 = v_u_85
				local v262 = v_u_84
				local v263 = v_u_90
				v_u_82 = nil
				v_u_83 = 0
				v_u_84 = nil
				v_u_85 = nil
				v_u_86 = 0
				v_u_87 = 0.5
				v_u_90 = false
				if v_u_88 then
					v_u_88:Disconnect()
					v_u_88 = nil
				end
				if v261 and v262 then
					if not v263 then
						local v264 = v_u_36.Movesets[v261]
						if v264 then
							v264 = v264.Abilities[v262]
						end
						if v264 and v264.Cooldown then
							local v265 = v264.Cooldown
							v_u_81[v261 .. "_" .. v262] = tick() + v265
						end
						v_u_89 = true
						local v266 = v_u_45[v261]
						local v267 = v266 and v266[v262]
						if v267 then
							local _ = v262 == 3
							v_u_37:Play(v267)
						end
						v_u_48:FireServer(v262, {
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
	local v_u_268 = workspace:GetServerTimeNow()
	v49.OnClientEvent:Connect(function(p_u_269)
		-- upvalues: (copy) v_u_268, (copy) v_u_7, (ref) v_u_92, (copy) v_u_183, (ref) v_u_70, (copy) v_u_53, (copy) v_u_55, (copy) v_u_36, (ref) v_u_51, (copy) v_u_81, (ref) v_u_89, (copy) v_u_45, (copy) v_u_37, (copy) v_u_71
		if workspace:GetServerTimeNow() - v_u_268 < 2 and p_u_269.Caster ~= v_u_7 then
			return
		elseif p_u_269.Timestamp and p_u_269.Timestamp < v_u_268 then
			return
		elseif p_u_269.Type == "HealingInterrupted" and p_u_269.Caster == v_u_7 then
			v_u_92 = false
			v_u_183()
			return
		elseif p_u_269.Type == "Hit" then
			return
		else
			local v270 = false
			if p_u_269.Caster == v_u_7 and p_u_269.Cooldown then
				if not v_u_70 and pcall(function()
					-- upvalues: (ref) v_u_53
					v_u_53:Init()
				end) then
					v_u_70 = true
				end
				local v271 = p_u_269.MovesetName or "Ability"
				local v272 = v_u_55[p_u_269.Keybind or 1] or "Z"
				v_u_53:StartCooldown(v271, p_u_269.AbilityName, v272, p_u_269.Cooldown)
			end
			if p_u_269.Caster == v_u_7 and (p_u_269.AbilitySlot and p_u_269.MovesetName) then
				local v273 = v_u_36.Movesets[p_u_269.MovesetName]
				if v273 then
					v273 = v273.Abilities[p_u_269.AbilitySlot]
				end
				if v273 then
					local v274
					if v273.Type == "HoldVariant" then
						v274 = false
					else
						v274 = v273.Type ~= "Toggle"
					end
					if v273.AbilityLockDuration == 0 then
						v274 = false
					end
					if v274 then
						v_u_51 = true
						local v275 = (v273.ChargeTime or v273.Duration or (v273.MovementLockDuration or 5)) + 2
						local v276 = math.max(v275, 5)
						task.delay(v276, function()
							-- upvalues: (ref) v_u_51
							if v_u_51 == true then
								v_u_51 = false
							end
						end)
					end
					if p_u_269.Cooldown then
						local v277 = p_u_269.MovesetName
						local v278 = p_u_269.AbilitySlot
						local v279 = p_u_269.Cooldown
						v_u_81[v277 .. "_" .. v278] = tick() + v279
					end
					if v273.Type == "HoldVariant" then
						v270 = v_u_89
					else
						v270 = false
					end
					if not v270 then
						local v280 = p_u_269.MovesetName
						local v281 = p_u_269.AbilitySlot
						local v282 = p_u_269.Variant
						local v283 = v_u_45[v280]
						local v284 = v283 and v283[v281]
						if v284 then
							if v281 == 3 and v282 == 2 then
								v284 = v280 == "Sukuna" and "SukunaC_Hold" or (v280 == "Gojo" and "GojoC_Hold" or v284)
							end
							v_u_37:Play(v284)
						end
					end
					if v273.Type == "HoldVariant" then
						v_u_89 = false
					end
				end
			end
			local v285 = p_u_269.Caster
			local v286 = p_u_269.MovesetName
			local v287 = p_u_269.AbilityName
			if v285 and v285.Character then
				local v288 = v_u_36.Movesets[v286]
				if v288 then
					v288 = v288.Abilities[p_u_269.AbilitySlot]
				end
				local v289
				if v288 then
					v289 = v288.Type == "HoldVariant"
				else
					v289 = v288
				end
				local v290 = p_u_269.Caster == v_u_7
				if v289 and (v290 and v270) then
					return
				else
					p_u_269.SkipLocalVFX = v270
					local v291 = v_u_71[v286]
					if not v_u_7:GetAttribute("DisableOtherVFX") or v285 == v_u_7 then
						if v291 then
							local v_u_292 = v291[v287]
							if v_u_292 then
								task.spawn(function()
									-- upvalues: (copy) v_u_292, (copy) p_u_269
									local v293, v294 = pcall(v_u_292, p_u_269)
									if not v293 then
										warn("[AbilityClient] VFX error:", v294)
									end
								end)
							else
								warn("[AbilityClient] No handler for " .. v287)
							end
						else
							warn("[AbilityClient] No VFX handler for moveset " .. v286)
						end
						if v288 and (v288.Type == "ContinuousDamage" and (v290 and not (v288.AnchorHitbox or p_u_269.AnchorHitbox))) then
							local v_u_295 = v285.Character
							local v_u_296 = p_u_269.HitboxSize or (v288.HitboxSize or Vector3.new(30, 15, 30))
							local v_u_297 = p_u_269.HitboxOffset or (v288.HitboxOffset or Vector3.new(0, 0, 0))
							local v_u_298 = p_u_269.DamageDuration or (v288.Duration or 3)
							local v299 = p_u_269.DamageDelay or (v288.DamageDelay or 0)
							if v_u_295 then
								local v_u_300 = require(game:GetService("ReplicatedStorage"):WaitForChild("HitboxVisualizer"))
								task.delay(v299, function()
									-- upvalues: (copy) v_u_295, (copy) v_u_300, (copy) v_u_296, (copy) v_u_298, (copy) v_u_297
									if v_u_295 and v_u_295.Parent then
										v_u_300.ShowFollowingAOE(v_u_295, v_u_296, v_u_298, v_u_297)
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
	local v_u_301 = require(v_u_3:WaitForChild("VFXService"))
	local v_u_302 = game:GetService("TweenService")
	local function v_u_307(p303)
		-- upvalues: (copy) v_u_7, (copy) v_u_302
		local v304 = v_u_7.PlayerGui:FindFirstChild("ScreenEffects")
		if not v304 then
			v304 = Instance.new("ScreenGui")
			v304.Name = "ScreenEffects"
			v304.IgnoreGuiInset = true
			v304.DisplayOrder = 10
			v304.Parent = v_u_7.PlayerGui
		end
		local v_u_305 = Instance.new("Frame")
		v_u_305.Size = UDim2.new(1, 0, 1, 0)
		v_u_305.BackgroundColor3 = p303.Color or Color3.new(1, 1, 1)
		v_u_305.BackgroundTransparency = 0.7
		v_u_305.BorderSizePixel = 0
		v_u_305.Parent = v304
		local v306 = v_u_302:Create(v_u_305, TweenInfo.new(p303.Duration or 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 1
		})
		v306:Play()
		v306.Completed:Connect(function()
			-- upvalues: (copy) v_u_305
			v_u_305:Destroy()
		end)
	end
	local v_u_308 = {}
	local function v_u_779(p_u_309)
		-- upvalues: (copy) v_u_3, (copy) v_u_71, (copy) v_u_308, (copy) v_u_37
		local v_u_310 = game:GetService("Debris")
		game:GetService("TweenService")
		local v_u_311 = game:GetService("TweenService")
		local v312 = v_u_3:FindFirstChild("AbilitySystem")
		if v312 then
			local v313 = v312:FindFirstChild("VFX")
			if v313 then
				local v_u_314 = p_u_309.MovesetType or "Saber"
				local v_u_315 = v313:FindFirstChild(v_u_314) or v313:FindFirstChild("Saber")
				if v_u_315 then
					local v316 = p_u_309.Position
					CFrame.new(v316)
					if p_u_309.LookVector then
						CFrame.lookAt(v316, v316 + p_u_309.LookVector)
					end
					local v_u_317 = p_u_309.NPCModel
					if v_u_317 then
						v_u_317 = workspace.NPCs:FindFirstChild(p_u_309.NPCModel) or workspace:FindFirstChild(p_u_309.NPCModel)
					end
					local v_u_318
					if v_u_317 then
						v_u_318 = v_u_317:FindFirstChild("HumanoidRootPart")
					else
						v_u_318 = v_u_317
					end
					local function v_u_324(p319, p320, p321)
						-- upvalues: (copy) v_u_310
						local v322 = p319:Clone()
						v322.CFrame = p320
						v322.Anchored = true
						v322.CanCollide = false
						v322.Transparency = 1
						v322.CastShadow = false
						v322.CanQuery = false
						v322.Parent = workspace
						v_u_310:AddItem(v322, p321)
						for _, v323 in v322:GetDescendants() do
							if v323:IsA("ParticleEmitter") then
								v323:Emit(v323:GetAttribute("EmitCount") or 20)
							end
						end
						return v322
					end
					local function v_u_330(p325, p326)
						-- upvalues: (copy) v_u_311
						local v327 = TweenInfo.new(p326, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						for _, v328 in p325:GetDescendants() do
							if v328:IsA("Beam") then
								local v329 = v328.Width0
								v328.Width0 = 0
								v328.Width1 = 0
								v328.Enabled = true
								v_u_311:Create(v328, v327, {
									["Width0"] = v329,
									["Width1"] = v329
								}):Play()
							end
						end
					end
					local function v_u_336(p331, p332)
						-- upvalues: (copy) v_u_311
						local v333 = TweenInfo.new(p332, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
						for _, v_u_334 in p331:GetDescendants() do
							if v_u_334:IsA("Beam") then
								local v335 = v_u_311:Create(v_u_334, v333, {
									["Width0"] = 0,
									["Width1"] = 0
								})
								v335:Play()
								v335.Completed:Once(function()
									-- upvalues: (copy) v_u_334
									v_u_334.Enabled = false
								end)
							end
						end
					end
					if p_u_309.VFXName == "Z" then
						task.spawn(function()
							-- upvalues: (copy) v_u_318, (copy) v_u_314, (copy) v_u_317, (ref) v_u_315, (copy) v_u_310, (copy) v_u_311, (ref) v_u_71, (ref) v_u_3, (copy) v_u_324
							if v_u_318 and v_u_318.Parent then
								if v_u_314 == "Gojo" then
									local v_u_337 = v_u_317:FindFirstChild("Right Arm")
									if v_u_337 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_315, (copy) v_u_337, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v338 = v_u_315.Z:FindFirstChild("RedVFXFirst")
												if v338 then
													local v339 = v338:Clone()
													v339.CFrame = v_u_337.CFrame * CFrame.new(0, -1.05, 0)
													v339.Anchored = true
													v339.CanCollide = false
													v339.Transparency = 1
													v339.CastShadow = false
													v339.CanQuery = false
													v339.Parent = workspace
													v_u_310:AddItem(v339, 4)
													for _, v_u_340 in v339:GetDescendants() do
														if v_u_340:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_340
																local v341 = v_u_340:GetAttribute("EmitDelay") or 0
																task.wait(v341)
																v_u_340:Emit(v_u_340:GetAttribute("EmitCount") or v_u_340.Rate)
															end)
														end
													end
													v339.Anchored = false
													local v342 = Instance.new("WeldConstraint")
													v342.Part0 = v_u_337
													v342.Part1 = v339
													v342.Parent = v339
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_315, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v343 = v_u_315.Z:FindFirstChild("RedVFX")
												if v343 then
													local v344 = v343:Clone()
													v344.CFrame = v_u_318.CFrame * CFrame.new(0, 1, -10)
													v344.Anchored = true
													v344.CanCollide = false
													v344.Transparency = 1
													v344.CastShadow = false
													v344.CanQuery = false
													v344.Parent = workspace
													v_u_310:AddItem(v344, 3)
													for _, v_u_345 in v344:GetDescendants() do
														if v_u_345:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_345
																local v346 = v_u_345:GetAttribute("EmitDelay") or 0
																task.wait(v346)
																v_u_345:Emit(v_u_345:GetAttribute("EmitCount") or v_u_345.Rate)
															end)
														end
													end
												end
											else
												return
											end
										end)
									end
								elseif v_u_314 == "Sukuna" then
									local v_u_347 = v_u_315.Z
									if v_u_347 then
										local v348 = v_u_318.Position + Vector3.new(0, 1, 0)
										local v_u_349 = v_u_318.CFrame.LookVector
										local v350 = v_u_347:FindFirstChild("StartExplosionVFX")
										if v350 then
											local v351 = v350:Clone()
											v351.CFrame = CFrame.new(v348) * CFrame.Angles(0, 1.5707963267948966, 0)
											v351.Anchored = true
											v351.CanCollide = false
											v351.Transparency = 1
											v351.Parent = workspace
											v_u_310:AddItem(v351, 3)
											for _, v_u_352 in v351:GetDescendants() do
												task.spawn(function()
													-- upvalues: (copy) v_u_352
													if v_u_352:IsA("ParticleEmitter") then
														local v353 = v_u_352:GetAttribute("EmitDelay") or 0
														if v353 > 0 then
															task.wait(v353)
														end
														v_u_352:Emit(v_u_352:GetAttribute("EmitCount") or v_u_352.Rate)
													end
												end)
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_349, (copy) v_u_347, (ref) v_u_310, (ref) v_u_311
											if v_u_318 and v_u_318.Parent then
												local v354 = v_u_318.Position + v_u_349 * 3 + Vector3.new(0, 1, 0)
												local v355 = v_u_318.Position + v_u_349 * 65 + Vector3.new(0, 1, 0)
												local v356 = v_u_347:FindFirstChild("DismantleVFX")
												if v356 then
													local v_u_357 = v356:Clone()
													v_u_357.CFrame = CFrame.new(v354, v355)
													v_u_357.Anchored = true
													v_u_357.CanCollide = false
													v_u_357.Transparency = 1
													v_u_357.Parent = workspace
													v_u_310:AddItem(v_u_357, 2)
													for _, v358 in v_u_357:GetDescendants() do
														if v358:IsA("ParticleEmitter") then
															v358.Enabled = true
														end
													end
													v_u_311:Create(v_u_357, TweenInfo.new(1, Enum.EasingStyle.Linear), {
														["CFrame"] = CFrame.new(v355, v355 + v_u_349)
													}):Play()
													task.delay(1, function()
														-- upvalues: (copy) v_u_357
														for _, v359 in v_u_357:GetDescendants() do
															if v359:IsA("ParticleEmitter") then
																v359.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								else
									if v_u_314 == "Ragna" then
										local v360 = v_u_315.Z
										if v360 then
											local v361 = v360:FindFirstChild("DashVFX")
											local v362 = v360:FindFirstChild("SlashesVFX")
											local v363 = v_u_318.CFrame.LookVector
											local v364 = CFrame.lookAt(v_u_318.Position, v_u_318.Position + v363)
											if v361 then
												local v_u_365 = v361:Clone()
												v_u_365.CFrame = v364
												v_u_365.Anchored = false
												v_u_365.CanCollide = false
												v_u_365.Transparency = 1
												v_u_365.CastShadow = false
												v_u_365.CanQuery = false
												v_u_365.Massless = true
												v_u_365.Parent = workspace
												v_u_310:AddItem(v_u_365, 1.5)
												local v366 = Instance.new("WeldConstraint")
												v366.Part0 = v_u_318
												v366.Part1 = v_u_365
												v366.Parent = v_u_365
												for _, v367 in v_u_365:GetDescendants() do
													if v367:IsA("ParticleEmitter") then
														v367.Enabled = true
														v367:Emit(v367:GetAttribute("EmitCount") or 30)
													end
												end
												task.delay(0.5, function()
													-- upvalues: (copy) v_u_365
													if v_u_365 and v_u_365.Parent then
														for _, v368 in v_u_365:GetDescendants() do
															if v368:IsA("ParticleEmitter") then
																v368.Enabled = false
															end
														end
													end
												end)
											end
											if v362 then
												local v369 = v362:Clone()
												v369.CFrame = v364 * CFrame.new(0, 0, -20)
												v369.Anchored = true
												v369.CanCollide = false
												v369.Transparency = 1
												v369.Parent = workspace
												v_u_310:AddItem(v369, 1.5)
												for _, v_u_370 in v369:GetDescendants() do
													if v_u_370:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_370
															local v371 = v_u_370:GetAttribute("EmitDelay") or 0
															if v371 > 0 then
																task.wait(v371)
															end
															v_u_370:Emit(v_u_370:GetAttribute("EmitCount") or v_u_370.Rate)
														end)
													end
												end
												return
											end
										end
									else
										if v_u_314 == "Aizen" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_318, (ref) v_u_315, (ref) v_u_310
												if v_u_318 and v_u_318.Parent then
													local v372 = v_u_315.Z:FindFirstChild("LightningVFX")
													if v372 then
														local v373 = v372:Clone()
														v373.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -5)
														v373.Anchored = true
														v373.CanCollide = false
														v373.Transparency = 1
														v373.CastShadow = false
														v373.CanQuery = false
														v373.Parent = workspace
														v_u_310:AddItem(v373, 3)
														for _, v_u_374 in v373:GetDescendants() do
															if v_u_374:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_374
																	local v375 = v_u_374:GetAttribute("EmitDelay") or 0.05
																	task.delay(v375, function()
																		-- upvalues: (ref) v_u_374
																		v_u_374:Emit(v_u_374:GetAttribute("EmitCount") or v_u_374.Rate)
																	end)
																end)
															end
														end
													end
													local v376 = v_u_315.Z:FindFirstChild("EnergyThrust")
													if v376 then
														local v377 = v376:Clone()
														v377.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -25)
														v377.Anchored = true
														v377.CanCollide = false
														v377.Transparency = 1
														v377.CastShadow = false
														v377.CanQuery = false
														v377.Parent = workspace
														v_u_310:AddItem(v377, 3)
														for _, v_u_378 in v377:GetDescendants() do
															if v_u_378:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_378
																	local v379 = v_u_378:GetAttribute("EmitDelay") or 0.05
																	task.delay(v379, function()
																		-- upvalues: (ref) v_u_378
																		v_u_378:Emit(v_u_378:GetAttribute("EmitCount") or v_u_378.Rate)
																	end)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_314 == "QinShi" then
											task.delay(0.4, function()
												-- upvalues: (ref) v_u_318, (ref) v_u_315, (ref) v_u_310
												if v_u_318 and v_u_318.Parent then
													local v380 = v_u_315.Z:FindFirstChild("PunchVFX")
													if v380 then
														local v381 = v380:Clone()
														v381.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
														v381.Anchored = true
														v381.CanCollide = false
														v381.Transparency = 1
														v381.CastShadow = false
														v381.CanQuery = false
														v381.Parent = workspace
														v_u_310:AddItem(v381, 3)
														for _, v_u_382 in v381:GetDescendants() do
															if v_u_382:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_382
																	local v383 = v_u_382:GetAttribute("EmitDelay") or 0
																	task.wait(v383)
																	v_u_382:Emit(v_u_382:GetAttribute("EmitCount") or v_u_382.Rate)
																end)
															end
														end
													end
													local v384 = v_u_315.Z:FindFirstChild("EnergyThrust")
													if v384 then
														local v385 = v384:Clone()
														v385.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -25)
														v385.Anchored = true
														v385.CanCollide = false
														v385.Transparency = 1
														v385.CastShadow = false
														v385.CanQuery = false
														v385.Parent = workspace
														v_u_310:AddItem(v385, 3)
														for _, v_u_386 in v385:GetDescendants() do
															if v_u_386:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_386
																	local v387 = v_u_386:GetAttribute("EmitDelay") or 0
																	task.wait(v387)
																	v_u_386:Emit(v_u_386:GetAttribute("EmitCount") or v_u_386.Rate)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_314 == "Yuji" then
											task.delay(0.3, function()
												-- upvalues: (ref) v_u_318, (ref) v_u_315, (ref) v_u_310
												if v_u_318 and v_u_318.Parent then
													local v388 = v_u_315.Z
													if v388 then
														local v389 = v388:FindFirstChild("SlamVFX")
														if v389 then
															local v390 = v389:Clone()
															v390:PivotTo(v_u_318.CFrame * CFrame.new(0, -1.5, -5))
															v390.Parent = workspace
															v_u_310:AddItem(v390, 3)
															for _, v391 in v390:GetDescendants() do
																if v391:IsA("BasePart") then
																	v391.Anchored = true
																	v391.CanCollide = false
																	v391.CanQuery = false
																end
															end
															for _, v_u_392 in v390:GetDescendants() do
																if v_u_392:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_392
																		local v393 = v_u_392:GetAttribute("EmitDelay") or 0
																		if v393 > 0 then
																			task.wait(v393)
																		end
																		v_u_392:Emit(v_u_392:GetAttribute("EmitCount") or v_u_392.Rate)
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
										if v_u_314 == "Alucard" then
											local v394 = v_u_71.Alucard
											if v394 and v394["Skill 1"] then
												local v395 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v394["Skill 1"](v395)
												return
											end
										elseif v_u_314 == "GojoV2" then
											local v396 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v396 then
												v396 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v396 then
												local v397 = require(v396)
												if v397["Skill 1"] then
													local v398 = {
														["Caster"] = {
															["Character"] = v_u_317
														}
													}
													v397["Skill 1"](v398)
													return
												end
											end
										elseif v_u_314 == "StrongestInHistory" then
											local v399 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v399 then
												v399 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v399 then
												local v400 = require(v399)
												if v400["Skill 1"] then
													local v401 = {
														["Caster"] = {
															["Character"] = v_u_317
														}
													}
													v400["Skill 1"](v401)
													return
												end
											end
										elseif v_u_314 == "Rimuru" then
											local v402 = v_u_71.Rimuru
											if v402 and v402["Skill 1"] then
												local v403 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v402["Skill 1"](v403)
												return
											end
										elseif v_u_314 == "Madoka" then
											local v404 = v_u_71.Madoka
											if v404 and v404["Skill 1"] then
												local v405 = {
													["Caster"] = {
														["Character"] = v_u_317
													}
												}
												v404["Skill 1"](v405)
												return
											end
										elseif v_u_314 == "Gilgamesh" then
											local v406 = v_u_71.Gilgamesh
											if v406 and v406["Skill 1"] then
												local v407 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v406["Skill 1"](v407)
												return
											end
										else
											task.wait(0.45)
											if not (v_u_318 and v_u_318.Parent) then
												return
											end
											local v408 = v_u_318.CFrame
											local v409 = v_u_315.Z:FindFirstChild("EnergyThrust")
											local v410 = v_u_315.Z:FindFirstChild("EnergyPart")
											if v409 then
												v_u_324(v409, v408 * CFrame.new(0, 2, -35), 3)
											end
											if v410 then
												v_u_324(v410, v408 * CFrame.new(0, 2, -2), 3)
											end
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_309.VFXName == "X" then
						task.spawn(function()
							-- upvalues: (copy) v_u_318, (copy) v_u_314, (copy) v_u_317, (ref) v_u_315, (copy) v_u_310, (copy) v_u_311, (ref) v_u_71, (ref) v_u_3, (copy) p_u_309
							if v_u_318 and v_u_318.Parent then
								if v_u_314 == "Gojo" then
									local v_u_411 = v_u_317:FindFirstChild("Right Arm")
									if v_u_411 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_315, (copy) v_u_411, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v412 = v_u_315.X:FindFirstChild("BlueVFXFirst")
												if v412 then
													local v413 = v412:Clone()
													v413.CFrame = v_u_411.CFrame * CFrame.new(0, -1.05, 0)
													v413.Anchored = true
													v413.CanCollide = false
													v413.Transparency = 1
													v413.CastShadow = false
													v413.CanQuery = false
													v413.Parent = workspace
													v_u_310:AddItem(v413, 4)
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
													v413.Anchored = false
													local v416 = Instance.new("WeldConstraint")
													v416.Part0 = v_u_411
													v416.Part1 = v413
													v416.Parent = v413
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_315, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v417 = v_u_318.CFrame
												local v418 = v_u_315.X:FindFirstChild("BlueMainVFX")
												if v418 then
													local v419 = v418:Clone()
													v419.CFrame = v417 * CFrame.new(0, 0, -25)
													v419.Anchored = true
													v419.CanCollide = false
													v419.Transparency = 1
													v419.CastShadow = false
													v419.CanQuery = false
													v419.Parent = workspace
													v_u_310:AddItem(v419, 3)
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
												local v422 = v_u_315.X:FindFirstChild("Blue_Additional_VFX")
												if v422 then
													local v423 = v422:Clone()
													v423.CFrame = v417 * CFrame.new(0, 0, -5)
													v423.Anchored = true
													v423.CanCollide = false
													v423.Transparency = 1
													v423.CastShadow = false
													v423.CanQuery = false
													v423.Parent = workspace
													v_u_310:AddItem(v423, 4)
													for _, v_u_424 in v423:GetDescendants() do
														if v_u_424:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_424
																local v425 = v_u_424:GetAttribute("EmitDelay") or 0
																task.wait(v425)
																v_u_424:Emit(v_u_424:GetAttribute("EmitCount") or v_u_424.Rate)
															end)
														end
													end
												end
											end
										end)
									end
								else
									if v_u_314 == "Sukuna" then
										local v426 = v_u_315.X
										if not v426 then
											return
										end
										local v427 = v426:FindFirstChild("GroundVFX")
										if v427 then
											local v_u_428 = v427:Clone()
											v_u_428:PivotTo(v_u_318.CFrame * CFrame.new(0, -2.5, 0))
											v_u_428.Parent = workspace
											v_u_310:AddItem(v_u_428, 3.5)
											local v429 = v_u_428.PrimaryPart or v_u_428:FindFirstChildWhichIsA("BasePart")
											for _, v430 in v_u_428:GetDescendants() do
												if v430:IsA("BasePart") then
													v430.Anchored = false
													v430.CanCollide = false
													v430.CanQuery = false
													v430.CanTouch = false
													v430.Massless = true
												end
											end
											if v429 then
												local v431 = Instance.new("WeldConstraint")
												v431.Part0 = v_u_318
												v431.Part1 = v429
												v431.Parent = v429
											end
											task.delay(2.6, function()
												-- upvalues: (copy) v_u_428
												if v_u_428 and v_u_428.Parent then
													for _, v432 in v_u_428:GetDescendants() do
														if v432:IsA("ParticleEmitter") then
															v432.Enabled = false
														end
													end
												end
											end)
											return
										end
									elseif v_u_314 == "Jinwoo" then
										local v433 = v_u_315.X
										if not v433 then
											return
										end
										local v434 = v433:FindFirstChild("DashVFX")
										local v435 = v433:FindFirstChild("SlashesVFX")
										local v436 = v_u_318.CFrame.LookVector
										local v437 = CFrame.lookAt(v_u_318.Position, v_u_318.Position + v436)
										if v434 then
											local v_u_438 = v434:Clone()
											v_u_438.CFrame = v437
											v_u_438.Anchored = false
											v_u_438.CanCollide = false
											v_u_438.Transparency = 1
											v_u_438.CastShadow = false
											v_u_438.CanQuery = false
											v_u_438.Massless = true
											v_u_438.Parent = workspace
											v_u_310:AddItem(v_u_438, 1.5)
											local v439 = Instance.new("WeldConstraint")
											v439.Part0 = v_u_318
											v439.Part1 = v_u_438
											v439.Parent = v_u_438
											for _, v440 in v_u_438:GetDescendants() do
												if v440:IsA("ParticleEmitter") then
													v440.Enabled = true
													v440:Emit(v440:GetAttribute("EmitCount") or 30)
												end
											end
											task.delay(0.5, function()
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
										if v435 then
											local v442 = v435:Clone()
											v442.CFrame = v437 * CFrame.new(0, 0, -20)
											v442.Anchored = true
											v442.CanCollide = false
											v442.Transparency = 1
											v442.CastShadow = false
											v442.CanQuery = false
											v442.Parent = workspace
											v_u_310:AddItem(v442, 1.5)
											for _, v_u_443 in v442:GetDescendants() do
												if v_u_443:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_443
														local v444 = v_u_443:GetAttribute("EmitDelay") or 0
														if v444 > 0 then
															task.wait(v444)
														end
														v_u_443:Emit(v_u_443:GetAttribute("EmitCount") or v_u_443.Rate)
													end)
												end
											end
											return
										end
									elseif v_u_314 == "Ragna" then
										local v_u_445 = v_u_315.X
										if v_u_445 then
											local v446 = v_u_445:FindFirstChild("GroundVFX")
											if v446 then
												local v447 = v446:Clone()
												v447.CFrame = v_u_318.CFrame * CFrame.new(0, -2.5, 0)
												v447.Anchored = true
												v447.CanCollide = false
												v447.Transparency = 1
												v447.Parent = workspace
												v_u_310:AddItem(v447, 5)
												for _, v_u_448 in v447:GetDescendants() do
													if v_u_448:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_448
															local v449 = v_u_448:GetAttribute("EmitDelay") or 0
															if v449 > 0 then
																task.wait(v449)
															end
															v_u_448:Emit(v_u_448:GetAttribute("EmitCount") or v_u_448.Rate)
														end)
													end
												end
											end
											local v450 = v_u_445:FindFirstChild("ChargeVFX")
											if v450 then
												local v_u_451 = v450:Clone()
												v_u_451.CFrame = v_u_318.CFrame
												v_u_451.Anchored = false
												v_u_451.CanCollide = false
												v_u_451.Transparency = 1
												v_u_451.Massless = true
												v_u_451.Parent = workspace
												v_u_310:AddItem(v_u_451, 1.3)
												local v452 = Instance.new("WeldConstraint")
												v452.Part0 = v_u_318
												v452.Part1 = v_u_451
												v452.Parent = v_u_451
												for _, v453 in v_u_451:GetDescendants() do
													if v453:IsA("ParticleEmitter") then
														v453.Enabled = true
													end
												end
												task.delay(0.4, function()
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
											task.delay(0.44999999999999996, function()
												-- upvalues: (ref) v_u_318, (copy) v_u_445, (ref) v_u_310
												if v_u_318 and v_u_318.Parent then
													local v455 = v_u_445:FindFirstChild("BarrageVFX")
													if v455 then
														local v_u_456 = v455:Clone()
														v_u_456.CFrame = v_u_318.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_456.Anchored = true
														v_u_456.CanCollide = false
														v_u_456.Transparency = 1
														v_u_456.Parent = workspace
														v_u_310:AddItem(v_u_456, 2.9)
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
													local v459 = v_u_445:FindFirstChild("BarrageGroundVFX")
													if v459 then
														local v_u_460 = v459:Clone()
														v_u_460.CFrame = v_u_318.CFrame * CFrame.new(0, -37.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_460.Anchored = true
														v_u_460.CanCollide = false
														v_u_460.Transparency = 1
														v_u_460.Parent = workspace
														v_u_310:AddItem(v_u_460, 2.7)
														for _, v461 in v_u_460:GetDescendants() do
															if v461:IsA("ParticleEmitter") then
																v461.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_460
															if v_u_460 and v_u_460.Parent then
																for _, v462 in v_u_460:GetDescendants() do
																	if v462:IsA("ParticleEmitter") then
																		v462.Enabled = false
																	end
																end
															end
														end)
													end
												end
											end)
											task.delay(2, function()
												-- upvalues: (ref) v_u_318, (copy) v_u_445, (ref) v_u_310
												if v_u_318 and v_u_318.Parent then
													local v463 = v_u_445:FindFirstChild("ChargeVFX")
													if v463 then
														local v_u_464 = v463:Clone()
														v_u_464.CFrame = v_u_318.CFrame
														v_u_464.Anchored = false
														v_u_464.CanCollide = false
														v_u_464.Transparency = 1
														v_u_464.Massless = true
														v_u_464.Parent = workspace
														v_u_310:AddItem(v_u_464, 1)
														local v465 = Instance.new("WeldConstraint")
														v465.Part0 = v_u_318
														v465.Part1 = v_u_464
														v465.Parent = v_u_464
														for _, v466 in v_u_464:GetDescendants() do
															if v466:IsA("ParticleEmitter") then
																v466.Enabled = true
															end
														end
														task.delay(0.6, function()
															-- upvalues: (copy) v_u_464
															if v_u_464 and v_u_464.Parent then
																for _, v467 in v_u_464:GetDescendants() do
																	if v467:IsA("ParticleEmitter") then
																		v467.Enabled = false
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
										if v_u_314 == "Aizen" then
											local v468 = v_u_315.X:FindFirstChild("BarrageVFX")
											if v468 then
												local v_u_469 = v468:Clone()
												v_u_469.CFrame = v_u_318.CFrame * CFrame.new(0, 4, -15)
												v_u_469.Anchored = false
												v_u_469.CanCollide = false
												v_u_469.Transparency = 1
												v_u_469.CastShadow = false
												v_u_469.CanQuery = false
												v_u_469.Massless = true
												v_u_469.Parent = workspace
												v_u_310:AddItem(v_u_469, 3.7)
												local v470 = Instance.new("WeldConstraint")
												v470.Part0 = v_u_318
												v470.Part1 = v_u_469
												v470.Parent = v_u_469
												for _, v471 in v_u_469:GetDescendants() do
													if v471:IsA("ParticleEmitter") or (v471:IsA("Beam") or v471:IsA("Trail")) then
														v471.Enabled = true
													end
												end
												task.delay(1.7, function()
													-- upvalues: (copy) v_u_469
													if v_u_469 and v_u_469.Parent then
														for _, v472 in v_u_469:GetDescendants() do
															if v472:IsA("ParticleEmitter") or (v472:IsA("Beam") or v472:IsA("Trail")) then
																v472.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(1.9, function()
												-- upvalues: (ref) v_u_318, (ref) v_u_315, (ref) v_u_310, (ref) v_u_311
												if not (v_u_318 and v_u_318.Parent) then
													return
												end
												local v473 = { 0, 0 }
												local v474 = {
													{ 180, 180, 135 },
													{ 180, 180, 45 }
												}
												for v475 = 1, 2 do
													if not (v_u_318 and v_u_318.Parent) then
														break
													end
													local v476 = v473[v475]
													local v477 = v474[v475][1]
													local v478 = v474[v475][2]
													local v479 = v474[v475][3]
													local v480 = v_u_318.CFrame * CFrame.Angles(0, math.rad(v476), 0)
													local v481 = v480.Position
													local v482 = v481 + v480.LookVector * 80
													local v483 = CFrame.Angles(math.rad(v477), math.rad(v478), (math.rad(v479)))
													local v484 = CFrame.lookAt(v481, v482) * v483
													local v485 = CFrame.lookAt(v482, v482 + v480.LookVector) * v483
													local v486 = v_u_315.X:FindFirstChild("StartVFX")
													if v486 then
														local v487 = v486:Clone()
														v487.CFrame = v484
														v487.Anchored = true
														v487.CanCollide = false
														v487.Transparency = 1
														v487.Parent = workspace
														v_u_310:AddItem(v487, 2)
														for _, v488 in v487:GetDescendants() do
															if v488:IsA("ParticleEmitter") then
																v488:Emit(v488:GetAttribute("EmitCount") or v488.Rate)
															end
														end
													end
													local v489 = v_u_315.X:FindFirstChild("SlashVFX")
													if v489 then
														local v_u_490 = v489:Clone()
														v_u_490.CFrame = v484
														v_u_490.Anchored = true
														v_u_490.CanCollide = false
														v_u_490.Transparency = 1
														v_u_490.Parent = workspace
														v_u_310:AddItem(v_u_490, 3)
														for _, v491 in v_u_490:GetDescendants() do
															if v491:IsA("ParticleEmitter") or (v491:IsA("Beam") or v491:IsA("Trail")) then
																v491.Enabled = true
															end
														end
														local v492 = v_u_311:Create(v_u_490, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															["CFrame"] = v485
														})
														v492:Play()
														v492.Completed:Connect(function()
															-- upvalues: (copy) v_u_490
															for _, v493 in v_u_490:GetDescendants() do
																if v493:IsA("ParticleEmitter") or (v493:IsA("Beam") or v493:IsA("Trail")) then
																	v493.Enabled = false
																end
															end
														end)
													end
													if v475 < 2 then
														task.wait(0.3)
													end
												end
											end)
											return
										end
										if v_u_314 == "QinShi" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_318, (ref) v_u_315, (ref) v_u_310
												if v_u_318 and v_u_318.Parent then
													local v494 = v_u_315:FindFirstChild("X")
													if v494 then
														local v495 = v494:FindFirstChild("StompVFX")
														if v495 then
															local v496 = v_u_318.Position - Vector3.new(0, 2.5, 0)
															local v497 = v495:Clone()
															local v498 = v497:FindFirstChild("Main")
															local v499 = v497:FindFirstChild("Lightning")
															if v498 then
																v498.CFrame = CFrame.new(v496)
																v498.Anchored = true
																v498.CanCollide = false
																v498.Transparency = 1
															end
															if v499 then
																v499.CFrame = CFrame.new(v496 + Vector3.new(0, 13, 0))
																v499.Anchored = true
																v499.CanCollide = false
																v499.Transparency = 1
															end
															v497.Parent = workspace
															v_u_310:AddItem(v497, 3)
															for _, v_u_500 in v497:GetDescendants() do
																if v_u_500:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_500
																		local v501 = v_u_500:GetAttribute("EmitDelay") or 0
																		task.wait(v501)
																		v_u_500:Emit(v_u_500:GetAttribute("EmitCount") or v_u_500.Rate)
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
										if v_u_314 == "Yuji" then
											local v502 = v_u_315.X
											local v503 = v502 and v502:FindFirstChild("BarrageVFX")
											if v503 then
												local v_u_504 = v503:Clone()
												v_u_504.CFrame = v_u_318.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, -1.5707963267948966, 0)
												v_u_504.Anchored = false
												v_u_504.CanCollide = false
												v_u_504.Transparency = 1
												v_u_504.CastShadow = false
												v_u_504.CanQuery = false
												v_u_504.Massless = true
												v_u_504.Parent = workspace
												v_u_310:AddItem(v_u_504, 4)
												local v505 = Instance.new("WeldConstraint")
												v505.Part0 = v_u_318
												v505.Part1 = v_u_504
												v505.Parent = v_u_504
												for _, v506 in v_u_504:GetDescendants() do
													if v506:IsA("ParticleEmitter") then
														v506.Enabled = true
													end
												end
												task.delay(3.2, function()
													-- upvalues: (copy) v_u_504
													if v_u_504 and v_u_504.Parent then
														for _, v507 in v_u_504:GetDescendants() do
															if v507:IsA("ParticleEmitter") then
																v507.Enabled = false
															end
														end
													end
												end)
												return
											end
										elseif v_u_314 == "Alucard" then
											local v508 = v_u_71.Alucard
											if v508 and v508["Skill 2"] then
												local v509 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v508["Skill 2"](v509)
												return
											end
										elseif v_u_314 == "GojoV2" then
											local v510 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v510 then
												v510 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v510 then
												local v511 = require(v510)
												if v511["Skill 2"] then
													v511["Skill 2"]({
														["Caster"] = {
															["Character"] = v_u_317
														},
														["Duration"] = p_u_309.Duration or 6
													})
													return
												end
											end
										elseif v_u_314 == "StrongestInHistory" then
											local v512 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v512 then
												v512 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v512 then
												local v513 = require(v512)
												if v513["Skill 2"] then
													local v514 = {
														["Caster"] = {
															["Character"] = v_u_317
														}
													}
													v513["Skill 2"](v514)
													return
												end
											end
										elseif v_u_314 == "Ichigo" then
											local v515 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v515 then
												v515 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("Ichigo")
											end
											if v515 then
												local v516 = require(v515)
												if v516 and v516["Skill 2"] then
													local v517 = {
														["Caster"] = {
															["Character"] = v_u_317
														},
														["Duration"] = 4
													}
													v516["Skill 2"](v517)
													return
												end
											end
										elseif v_u_314 == "Rimuru" then
											local v518 = v_u_71.Rimuru
											if v518 and v518["Skill 2"] then
												local v519 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v518["Skill 2"](v519)
												return
											end
										elseif v_u_314 == "Madoka" then
											local v520 = v_u_71.Madoka
											if v520 and v520["Skill 2"] then
												v520["Skill 2"]({
													["Caster"] = {
														["Character"] = v_u_317
													},
													["Position"] = v_u_318 and v_u_318.Position + v_u_318.CFrame.LookVector * 50 or nil
												})
												return
											end
										elseif v_u_314 == "Gilgamesh" then
											local v521 = v_u_71.Gilgamesh
											if v521 and v521["Skill 2"] then
												local v522 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v521["Skill 2"](v522)
												return
											end
										else
											task.wait(0.35)
											if not (v_u_318 and v_u_318.Parent) then
												return
											end
											local v523 = v_u_318.CFrame
											local v524 = v_u_315.X:FindFirstChild("EnergySlashes")
											if not v524 then
												return
											end
											local v_u_525 = v524:Clone()
											v_u_525.CFrame = v523 * CFrame.new(0, 1.5, -20)
											v_u_525.Anchored = false
											v_u_525.CanCollide = false
											v_u_525.Transparency = 1
											v_u_525.CastShadow = false
											v_u_525.CanQuery = false
											v_u_525.Massless = true
											v_u_525.Parent = workspace
											v_u_310:AddItem(v_u_525, 4)
											local v526 = Instance.new("WeldConstraint")
											v526.Part0 = v_u_525
											v526.Part1 = v_u_318
											v526.Parent = v_u_525
											v_u_310:AddItem(v526, 2.06)
											task.delay(2.05, function()
												-- upvalues: (copy) v_u_525
												for _, v527 in v_u_525:GetDescendants() do
													if v527:IsA("ParticleEmitter") then
														v527.Enabled = false
													end
												end
												v_u_525.Anchored = true
											end)
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_309.VFXName == "C" then
						task.spawn(function()
							-- upvalues: (copy) v_u_318, (copy) v_u_314, (ref) v_u_3, (copy) v_u_317, (copy) p_u_309, (ref) v_u_315, (copy) v_u_310, (copy) v_u_330, (copy) v_u_336
							if v_u_318 and v_u_318.Parent then
								if v_u_314 == "GojoV2" then
									local v528 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v528 then
										v528 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v528 then
										local v529 = require(v528)
										if v529["Skill 3"] then
											local v530 = v529["Skill 3"]
											local v531 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["Duration"] = p_u_309.Duration or 6
											}
											v530(v531)
										end
									end
									return
								elseif v_u_314 == "StrongestInHistory" then
									local v532 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v532 then
										v532 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v532 then
										local v_u_533 = require(v532)
										if v_u_533["Skill 3"] then
											local v534 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["ChargeTime"] = 2.5
											}
											v_u_533["Skill 3"](v534)
										end
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_533, (ref) v_u_317
											if v_u_318 and v_u_318.Parent then
												local v535 = v_u_318.Position + v_u_318.CFrame.LookVector * 85
												if v_u_533["Skill 3"] then
													local v536 = v_u_533["Skill 3"]
													local v537 = {
														["Caster"] = {
															["Character"] = v_u_317
														},
														["Phase"] = "Explosion",
														["Position"] = v535,
														["CFrame"] = CFrame.new(v535),
														["DOTDuration"] = 3.5
													}
													v536(v537)
												end
											end
										end)
									end
									return
								elseif v_u_314 == "Gojo" then
									local v538 = v_u_315.C:FindFirstChild("DamageVFX")
									if v538 then
										local v539 = v538:Clone()
										v539.CFrame = v_u_318.CFrame
										v539.Anchored = false
										v539.CanCollide = false
										v539.Transparency = 1
										v539.Massless = true
										v539.Parent = workspace
										local v540 = Instance.new("WeldConstraint")
										v540.Part0 = v539
										v540.Part1 = v_u_318
										v540.Parent = v539
										for _, v541 in v539:GetDescendants() do
											if v541:IsA("ParticleEmitter") then
												v541:Emit(v541:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_310:AddItem(v539, 3)
									end
									return
								elseif v_u_314 == "Jinwoo" then
									local v542 = v_u_315.C
									if v542 then
										local v543 = v542:FindFirstChild("EnergySlashes")
										local v544 = v542:FindFirstChild("ShadowVFX")
										if v543 then
											local v_u_545 = v543:Clone()
											v_u_545.CFrame = v_u_318.CFrame * CFrame.new(0, 3.9, 0)
											v_u_545.Anchored = false
											v_u_545.CanCollide = false
											v_u_545.Transparency = 1
											v_u_545.CastShadow = false
											v_u_545.CanQuery = false
											v_u_545.Massless = true
											v_u_545.Parent = workspace
											v_u_310:AddItem(v_u_545, 3.65)
											local v546 = Instance.new("WeldConstraint")
											v546.Part0 = v_u_318
											v546.Part1 = v_u_545
											v546.Parent = v_u_545
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_545
												if v_u_545 and v_u_545.Parent then
													for _, v547 in v_u_545:GetDescendants() do
														if v547:IsA("ParticleEmitter") then
															v547:Emit(v547:GetAttribute("EmitCount") or v547.Rate)
															v547.Enabled = false
														end
													end
												end
											end)
										end
										if v544 then
											local v_u_548 = v544:Clone()
											v_u_548.CFrame = v_u_318.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_548.Anchored = false
											v_u_548.CanCollide = false
											v_u_548.Transparency = 1
											v_u_548.CastShadow = false
											v_u_548.CanQuery = false
											v_u_548.Massless = true
											v_u_548.Parent = workspace
											v_u_310:AddItem(v_u_548, 2.65)
											local v549 = Instance.new("WeldConstraint")
											v549.Part0 = v_u_318
											v549.Part1 = v_u_548
											v549.Parent = v_u_548
											for _, v_u_550 in v_u_548:GetDescendants() do
												if v_u_550:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_550
														local v551 = v_u_550:GetAttribute("EmitDelay") or 0
														if v551 > 0 then
															task.wait(v551)
														end
														v_u_550:Emit(v_u_550:GetAttribute("EmitCount") or v_u_550.Rate)
													end)
												end
											end
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_548
												if v_u_548 and v_u_548.Parent then
													for _, v552 in v_u_548:GetDescendants() do
														if v552:IsA("ParticleEmitter") then
															v552.Enabled = false
														end
													end
												end
											end)
										end
									end
								elseif v_u_314 == "Ragna" then
									local v553 = v_u_315.C
									if v553 then
										local v_u_554 = v553:FindFirstChild("Sword")
										local v_u_555 = v553:FindFirstChild("StartVFX")
										local v_u_556 = v553:FindFirstChild("ExpVFX")
										if v_u_554 then
											local v_u_557 = {}
											local v_u_558 = {}
											for _ = 1, 6 do
												local v559 = 4 + math.random() * 4
												local v560 = (math.random() - 0.5) * 2 * 6
												local v561 = -(3 + math.random() * 3)
												local v562 = {
													["offset"] = Vector3.new(v560, v559, v561)
												}
												table.insert(v_u_557, v562)
											end
											local v_u_563 = 0
											task.spawn(function()
												-- upvalues: (ref) v_u_563, (ref) v_u_318, (copy) v_u_557, (copy) v_u_554, (ref) v_u_310, (copy) v_u_555, (copy) v_u_558
												while v_u_563 < 6 and (v_u_318 and v_u_318.Parent) do
													local v564 = 6 - v_u_563
													local v565 = math.min(2, v564)
													for v566 = 1, v565 do
														local v567 = v_u_557[v_u_563 + v566]
														local v568 = v_u_318.CFrame
														local v569 = v568:VectorToWorldSpace(v567.offset)
														local v570 = v568.Position + v569
														local v571 = v_u_554:Clone()
														v571.CFrame = CFrame.new(v570) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v571.Anchored = true
														v571.CanCollide = false
														v571.CanQuery = false
														v571.Transparency = 0
														v571.Parent = workspace
														v_u_310:AddItem(v571, 3)
														if v_u_555 then
															local v572 = v_u_555:Clone()
															v572.CFrame = v571.CFrame
															v572.Anchored = true
															v572.CanCollide = false
															v572.Transparency = 1
															v572.Parent = workspace
															v_u_310:AddItem(v572, 1)
															for _, v573 in v572:GetDescendants() do
																if v573:IsA("ParticleEmitter") then
																	v573:Emit(v573:GetAttribute("EmitCount") or 20)
																end
															end
														end
														local v574 = v_u_558
														table.insert(v574, {
															["sword"] = v571,
															["spawnData"] = v567
														})
													end
													v_u_563 = v_u_563 + v565
													task.wait(0.25)
												end
											end)
											local v575 = game:GetService("RunService")
											local v_u_576 = nil
											v_u_576 = v575.Heartbeat:Connect(function()
												-- upvalues: (ref) v_u_318, (ref) v_u_576, (copy) v_u_558
												if v_u_318 and v_u_318.Parent then
													local v577 = (1 / 0)
													local v578 = nil
													for _, v579 in ipairs(game.Players:GetPlayers()) do
														if v579.Character and v579.Character:FindFirstChild("HumanoidRootPart") then
															local v580 = v579.Character.HumanoidRootPart
															local v581 = (v580.Position - v_u_318.Position).Magnitude
															if v581 < v577 and v581 < 150 then
																v578 = v580.Position
																v577 = v581
															end
														end
													end
													for _, v582 in ipairs(v_u_558) do
														local v583 = v582.sword
														if v583 and (v583.Parent and not v582.launched) then
															local v584 = v583.Position
															local v585
															if v578 then
																local v586 = v578 - v584
																if v586.Magnitude > 0.1 then
																	local v587 = v586.Unit
																	v585 = CFrame.lookAt(v584, v584 + v587) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793)
																else
																	v585 = CFrame.new(v584) * CFrame.Angles(1.5707963267948966, 0, 0)
																end
															else
																v585 = CFrame.new(v584) * v_u_318.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v583.CFrame = v583.CFrame:Lerp(v585, 0.12)
														end
													end
												elseif v_u_576 then
													v_u_576:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_576, (ref) v_u_318, (copy) v_u_558, (copy) v_u_556, (ref) v_u_310
												if v_u_576 then
													v_u_576:Disconnect()
												end
												if v_u_318 and v_u_318.Parent then
													local v588 = v_u_318.Position + v_u_318.CFrame.LookVector * 30
													local v589 = (1 / 0)
													for _, v590 in ipairs(game.Players:GetPlayers()) do
														if v590.Character and v590.Character:FindFirstChild("HumanoidRootPart") then
															local v591 = v590.Character.HumanoidRootPart
															local v592 = (v591.Position - v_u_318.Position).Magnitude
															if v592 < v589 and v592 < 150 then
																v588 = v591.Position
																v589 = v592
															end
														end
													end
													local v_u_593 = CFrame.new(v588)
													for v594, v_u_595 in ipairs(v_u_558) do
														task.delay((v594 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_595, (copy) v_u_593, (ref) v_u_556, (ref) v_u_310
															local v_u_596 = v_u_595.sword
															if v_u_596 and v_u_596.Parent then
																v_u_595.launched = true
																local v_u_597 = v_u_596.Position
																local v598 = v_u_593.Position
																local v599 = math.random(-8, 8)
																local v600 = math.random
																local v_u_601 = v598 + Vector3.new(v599, 0, v600(-8, 8))
																local v602 = (v_u_597 + v_u_601) / 2
																local v603 = math.random(-60, 60)
																local v604 = math.rad(v603)
																local v605 = 12 + math.random() * 5
																local v606 = math.sin(v604) * 5
																local v607 = math.cos(v604) * 5
																local v_u_608 = v602 + Vector3.new(v606, v605, v607)
																local v_u_609 = tick()
																task.spawn(function()
																	-- upvalues: (copy) v_u_609, (copy) v_u_597, (copy) v_u_608, (copy) v_u_601, (copy) v_u_596, (ref) v_u_556, (ref) v_u_310
																	while tick() - v_u_609 < 0.4 do
																		local v610 = (tick() - v_u_609) / 0.4
																		local v611 = v_u_597
																		local v612 = v_u_608
																		local v613 = v_u_601
																		local v614 = 1 - v610
																		local v615 = v614 * v614 * v611 + 2 * v614 * v610 * v612 + v610 * v610 * v613
																		local v616 = v610 + 0.05
																		local v617 = math.min(v616, 1)
																		local v618 = v_u_597
																		local v619 = v_u_608
																		local v620 = v_u_601
																		local v621 = 1 - v617
																		local v622 = v621 * v621 * v618 + 2 * v621 * v617 * v619 + v617 * v617 * v620 - v615
																		if v_u_596 and (v_u_596.Parent and v622.Magnitude > 0.01) then
																			v_u_596.CFrame = CFrame.lookAt(v615, v615 + v622.Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
																		end
																		task.wait()
																	end
																	if v_u_556 and (v_u_596 and v_u_596.Parent) then
																		local v623 = v_u_556:Clone()
																		v623.CFrame = CFrame.new(v_u_601)
																		v623.Anchored = true
																		v623.CanCollide = false
																		v623.Transparency = 1
																		v623.Parent = workspace
																		v_u_310:AddItem(v623, 1.5)
																		for _, v624 in v623:GetDescendants() do
																			if v624:IsA("ParticleEmitter") then
																				v624:Emit(v624:GetAttribute("EmitCount") or 30)
																			end
																		end
																	end
																	if v_u_596 and v_u_596.Parent then
																		v_u_596:Destroy()
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
								elseif v_u_314 == "Aizen" then
									local v_u_625 = v_u_315.C
									if v_u_625 then
										local v_u_626 = {}
										local function v_u_632(p627, p628)
											-- upvalues: (ref) v_u_318, (ref) v_u_310
											if not p627 then
												return nil
											end
											local v629 = p627:Clone()
											v629.CFrame = v_u_318.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v629.Anchored = false
											v629.CanCollide = false
											v629.Transparency = 1
											v629.CastShadow = false
											v629.CanQuery = false
											v629.Massless = true
											v629.Parent = workspace
											v_u_310:AddItem(v629, p628)
											local v630 = Instance.new("WeldConstraint")
											v630.Part0 = v_u_318
											v630.Part1 = v629
											v630.Parent = v629
											for _, v631 in v629:GetDescendants() do
												if v631:IsA("ParticleEmitter") or (v631:IsA("Beam") or v631:IsA("Trail")) then
													v631.Enabled = true
												end
											end
											return v629
										end
										local v633 = v_u_632(v_u_625:FindFirstChild("ChargeVFX"), 4)
										if v633 then
											table.insert(v_u_626, v633)
										end
										local v634 = v_u_632(v_u_625:FindFirstChild("AuraVFX1"), 4)
										if v634 then
											table.insert(v_u_626, v634)
										end
										task.delay(0.25, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_632, (copy) v_u_625, (copy) v_u_626
											if v_u_318 and v_u_318.Parent then
												local v635 = v_u_632(v_u_625:FindFirstChild("AuraVFX2"), 3.75)
												if v635 then
													local v636 = v_u_626
													table.insert(v636, v635)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_632, (copy) v_u_625, (copy) v_u_626
											if v_u_318 and v_u_318.Parent then
												local v637 = v_u_632(v_u_625:FindFirstChild("AuraVFX3"), 3.5)
												if v637 then
													local v638 = v_u_626
													table.insert(v638, v637)
												end
											end
										end)
										task.delay(3, function()
											-- upvalues: (copy) v_u_626
											for _, v639 in pairs(v_u_626) do
												if v639 and v639.Parent then
													for _, v640 in v639:GetDescendants() do
														if v640:IsA("ParticleEmitter") or (v640:IsA("Beam") or v640:IsA("Trail")) then
															v640.Enabled = false
														end
													end
												end
											end
										end)
									end
								elseif v_u_314 == "Rimuru" then
									return
								else
									local v641 = v_u_315.C:FindFirstChild("FirstEffects")
									if v641 then
										local v_u_642 = v641:Clone()
										for _, v643 in v_u_642:GetDescendants() do
											if v643:IsA("BasePart") then
												v643.Anchored = true
												v643.CanCollide = false
												v643.CanQuery = false
												v643.CanTouch = false
												v643.CastShadow = false
												v643.Transparency = 1
											end
										end
										v_u_642:PivotTo(v_u_318.CFrame * CFrame.new(0, -2, 0))
										v_u_642.Parent = workspace
										v_u_310:AddItem(v_u_642, 6)
										task.delay(4.85, function()
											-- upvalues: (copy) v_u_642
											for _, v644 in v_u_642:GetDescendants() do
												if v644:IsA("ParticleEmitter") then
													v644.Enabled = false
												end
											end
										end)
									end
									task.wait(3.85)
									if v_u_318 and v_u_318.Parent then
										local v_u_645 = v_u_318.CFrame
										local v646 = v_u_315.C:FindFirstChild("HorizontalBeam")
										if v646 then
											local v647 = v646:Clone()
											for _, v648 in v647:GetDescendants() do
												if v648:IsA("BasePart") then
													v648.Anchored = true
													v648.CanCollide = false
													v648.CanQuery = false
													v648.CanTouch = false
													v648.CastShadow = false
													v648.Massless = true
													v648.Transparency = 1
												end
												if v648:IsA("Beam") then
													v648.Enabled = false
												end
											end
											v647:PivotTo(v_u_645 * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0))
											v647.Parent = workspace
											v_u_310:AddItem(v647, 6)
											local v649 = {
												["BigBeam1"] = 0,
												["BigBeam2"] = 0.25,
												["BigBeams3"] = 0.5
											}
											local v650 = {
												["BigBeam1"] = 0.36,
												["BigBeam2"] = 0.61,
												["BigBeams3"] = 0.76
											}
											for _, v_u_651 in v647:GetChildren() do
												if v_u_651:IsA("Model") then
													local v_u_652 = v_u_651:FindFirstChild("Beam")
													local v653 = v649[v_u_651.Name] or 0
													local v654 = v650[v_u_651.Name] or 2
													task.delay(v653, function()
														-- upvalues: (copy) v_u_652, (ref) v_u_330, (copy) v_u_651
														if v_u_652 then
															v_u_330(v_u_652, 0.3)
														end
														for _, v655 in v_u_651:GetDescendants() do
															if v655:IsA("ParticleEmitter") and not (v_u_652 and v655:IsDescendantOf(v_u_652)) then
																v655:Emit(v655:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v654, function()
														-- upvalues: (copy) v_u_652, (ref) v_u_336
														if v_u_652 then
															v_u_336(v_u_652, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_315, (copy) v_u_645, (ref) v_u_310, (ref) v_u_336
											if v_u_318 and v_u_318.Parent then
												local v656 = v_u_315.C:FindFirstChild("Explosion")
												if v656 then
													local v_u_657 = v656:Clone()
													for _, v658 in v_u_657:GetDescendants() do
														if v658:IsA("BasePart") then
															v658.Anchored = true
															v658.CanCollide = false
															v658.CanQuery = false
															v658.CanTouch = false
															v658.CastShadow = false
															v658.Transparency = 1
														end
													end
													v_u_657:PivotTo(v_u_645 * CFrame.new(0, 8, -75) * CFrame.Angles(0, 0, 1.5707963267948966))
													v_u_657.Parent = workspace
													v_u_310:AddItem(v_u_657, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_336, (copy) v_u_657
														v_u_336(v_u_657, 0.5)
														for _, v659 in v_u_657:GetDescendants() do
															if v659:IsA("ParticleEmitter") then
																v659.Enabled = false
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
						if v_u_314 == "QinShi" then
							task.spawn(function()
								-- upvalues: (copy) v_u_318, (ref) v_u_315, (copy) v_u_310
								if v_u_318 and v_u_318.Parent then
									local v660 = v_u_315:FindFirstChild("C")
									if v660 then
										local v661 = v660:FindFirstChild("BarrageVFX")
										if v661 then
											local v_u_662 = v661:Clone()
											v_u_662.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_662.Anchored = false
											v_u_662.CanCollide = false
											v_u_662.CanQuery = false
											v_u_662.CanTouch = false
											v_u_662.Transparency = 1
											v_u_662.CastShadow = false
											v_u_662.Parent = workspace
											local v663 = Instance.new("WeldConstraint")
											v663.Part0 = v_u_662
											v663.Part1 = v_u_318
											v663.Parent = v_u_662
											for _, v664 in v_u_662:GetDescendants() do
												if v664:IsA("ParticleEmitter") then
													v664.Enabled = true
												end
											end
											task.delay(3, function()
												-- upvalues: (copy) v_u_662
												if v_u_662 and v_u_662.Parent then
													for _, v665 in v_u_662:GetDescendants() do
														if v665:IsA("ParticleEmitter") then
															v665.Enabled = false
														end
													end
												end
											end)
											v_u_310:AddItem(v_u_662, 4)
										end
									end
								else
									return
								end
							end)
						end
						if v_u_314 == "Yuji" then
							task.spawn(function()
								-- upvalues: (copy) v_u_318, (ref) v_u_315, (copy) v_u_310
								if v_u_318 and v_u_318.Parent then
									local v_u_666 = v_u_315:FindFirstChild("C")
									if v_u_666 then
										local v667 = v_u_666:FindFirstChild("AuraVFX3")
										if v667 then
											local v_u_668 = v667:Clone()
											v_u_668.CFrame = v_u_318.CFrame
											v_u_668.Anchored = false
											v_u_668.CanCollide = false
											v_u_668.Transparency = 1
											v_u_668.Massless = true
											v_u_668.Parent = workspace
											local v669 = Instance.new("WeldConstraint")
											v669.Part0 = v_u_318
											v669.Part1 = v_u_668
											v669.Parent = v_u_668
											for _, v670 in v_u_668:GetDescendants() do
												if v670:IsA("ParticleEmitter") then
													v670.Enabled = true
												end
											end
											task.delay(0.8, function()
												-- upvalues: (copy) v_u_668
												if v_u_668 and v_u_668.Parent then
													for _, v671 in v_u_668:GetDescendants() do
														if v671:IsA("ParticleEmitter") then
															v671.Enabled = false
														end
													end
												end
											end)
											v_u_310:AddItem(v_u_668, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_666, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v672 = v_u_666:FindFirstChild("BlackFlashVFX3")
												if v672 then
													local v673 = v672:Clone()
													v673.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -10)
													v673.Anchored = true
													v673.CanCollide = false
													v673.Transparency = 1
													v673.Parent = workspace
													for _, v674 in v673:GetDescendants() do
														if v674:IsA("ParticleEmitter") then
															v674:Emit(v674:GetAttribute("EmitCount") or v674.Rate)
														end
													end
													v_u_310:AddItem(v673, 3)
												end
											end
										end)
									end
								else
									return
								end
							end)
						end
						if v_u_314 == "Alucard" then
							local v675 = v_u_71.Alucard
							if v675 and v675["Skill 3"] then
								v675["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_317
									},
									["DamageDelay"] = 2.5,
									["Duration"] = 5,
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_314 == "Ichigo" then
							local v676 = v_u_71.Ichigo
							if v676 and v676["Skill 3"] then
								v676["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_317
									},
									["ChargeTime"] = 3.5,
									["SlashCount"] = 1,
									["SlashInterval"] = 0.15,
									["SlashDistance"] = 80,
									["SlashSpeed"] = 180
								})
							end
						end
						if v_u_314 == "Rimuru" then
							local v677 = v_u_71.Rimuru
							if v677 and v677["Skill 3"] then
								v677["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_317
									},
									["DamageDelay"] = 2.5,
									["Duration"] = 5,
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_314 == "Madoka" then
							local v678 = v_u_71.Madoka
							if v678 and v678["Skill 3"] then
								v678["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_317
									},
									["DamageDelay"] = 1.03,
									["Duration"] = 3.97
								})
							end
						end
						if v_u_314 == "Gilgamesh" then
							local v679 = v_u_71.Gilgamesh
							if v679 and v679["Skill 3"] then
								v679["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_317
									},
									["AbilityConfig"] = {}
								})
							end
						end
					elseif p_u_309.VFXName == "V" then
						task.spawn(function()
							-- upvalues: (copy) v_u_318, (copy) v_u_314, (ref) v_u_3, (copy) v_u_317, (ref) v_u_315, (copy) v_u_310, (copy) v_u_311, (copy) p_u_309, (ref) v_u_308, (ref) v_u_37, (ref) v_u_71
							if v_u_318 and v_u_318.Parent then
								if v_u_314 == "GojoV2" then
									local v680 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v680 then
										v680 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v680 then
										local v681 = require(v680)
										if v681["Skill 4"] then
											local v682 = {
												["Caster"] = {
													["Character"] = v_u_317
												}
											}
											v681["Skill 4"](v682)
										end
									end
									return
								elseif v_u_314 == "StrongestInHistory" then
									local v683 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v683 then
										v683 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v683 then
										local v684 = require(v683)
										if v684["Skill 4"] then
											local v685 = v684["Skill 4"]
											local v686 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["CutsceneDuration"] = 6.5,
												["DamageDelay"] = 5,
												["CharAnimationId"] = "rbxassetid://125013796988038"
											}
											local v687 = v_u_318
											if v687 then
												v687 = v_u_318.CFrame
											end
											v686.CFrame = v687
											v685(v686)
										end
									end
									return
								elseif v_u_314 == "Gojo" then
									local v_u_688 = v_u_315.V
									if v_u_688 then
										local v_u_689 = Instance.new("Attachment")
										v_u_689.Name = "BlueAtt"
										v_u_689.Position = Vector3.new(7, 2, 5)
										v_u_689.Parent = v_u_318
										local v_u_690 = Instance.new("Attachment")
										v_u_690.Name = "RedAtt"
										v_u_690.Position = Vector3.new(-7, 2, 5)
										v_u_690.Parent = v_u_318
										local v_u_691 = nil
										local v_u_692 = nil
										local function v_u_701(p693, p694)
											-- upvalues: (copy) v_u_688, (ref) v_u_318
											local v695 = v_u_688:FindFirstChild(p693)
											if not v695 then
												return nil
											end
											local v696 = v695:Clone()
											v696.CFrame = v_u_318.CFrame * CFrame.new(p694.Position)
											v696.Anchored = true
											v696.CanCollide = false
											v696.Massless = true
											v696.Transparency = 1
											v696.Parent = workspace
											local v697 = Instance.new("Attachment")
											v697.Parent = v696
											local v698 = Instance.new("AlignPosition")
											v698.Attachment0 = v697
											v698.Attachment1 = p694
											v698.RigidityEnabled = false
											v698.Responsiveness = 100
											v698.MaxForce = (1 / 0)
											v698.Parent = v696
											local v699 = Instance.new("AlignOrientation")
											v699.Attachment0 = v697
											v699.Attachment1 = p694
											v699.RigidityEnabled = false
											v699.Responsiveness = 100
											v699.MaxTorque = (1 / 0)
											v699.Parent = v696
											v696.Anchored = false
											for _, v700 in v696:GetDescendants() do
												if v700:IsA("ParticleEmitter") then
													v700.Enabled = true
												elseif v700:IsA("Beam") or v700:IsA("Trail") then
													v700.Enabled = true
												end
											end
											return v696
										end
										local function v_u_705(p702, p703)
											if p702 and p702.Parent then
												for _, v_u_704 in p702:GetDescendants() do
													if v_u_704:IsA("ParticleEmitter") then
														v_u_704.Enabled = false
														if p703 then
															pcall(function()
																-- upvalues: (copy) v_u_704
																v_u_704:Clear()
															end)
														end
													elseif v_u_704:IsA("Beam") or v_u_704:IsA("Trail") then
														v_u_704.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_691, (copy) v_u_701, (copy) v_u_689, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												v_u_691 = v_u_701("Blue", v_u_689)
												if v_u_691 then
													v_u_310:AddItem(v_u_691, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_692, (copy) v_u_701, (copy) v_u_690, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												v_u_692 = v_u_701("Red", v_u_690)
												if v_u_692 then
													v_u_310:AddItem(v_u_692, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_311, (copy) v_u_689, (copy) v_u_690, (copy) v_u_688, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v706 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_311:Create(v_u_689, v706, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_311:Create(v_u_690, v706, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_318, (ref) v_u_688, (ref) v_u_310
													if v_u_318 and v_u_318.Parent then
														local v707 = v_u_688:FindFirstChild("StarEff")
														if v707 then
															local v708 = v707:Clone()
															v708.CFrame = v_u_318.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v708.Anchored = true
															v708.CanCollide = false
															v708.Transparency = 1
															v708.Parent = workspace
															for _, v709 in v708:GetDescendants() do
																if v709:IsA("ParticleEmitter") then
																	v709:Emit(v709:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_310:AddItem(v708, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_705, (ref) v_u_691, (ref) v_u_692, (copy) v_u_689, (copy) v_u_690, (copy) v_u_688, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												v_u_705(v_u_691, true)
												v_u_705(v_u_692, true)
												if v_u_689 and v_u_689.Parent then
													v_u_689:Destroy()
												end
												if v_u_690 and v_u_690.Parent then
													v_u_690:Destroy()
												end
												local v710 = v_u_688:FindFirstChild("MiniExplosionVFX")
												if v710 then
													local v711 = v710:Clone()
													v711.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -2)
													v711.Anchored = true
													v711.CanCollide = false
													v711.Transparency = 1
													v711.Parent = workspace
													for _, v712 in v711:GetDescendants() do
														if v712:IsA("ParticleEmitter") then
															v712:Emit(v712:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_310:AddItem(v711, 3)
												end
												local v_u_713 = v_u_318.Position + v_u_318.CFrame.LookVector * 6
												local v_u_714 = v_u_318.CFrame.LookVector
												local v715 = v_u_688:FindFirstChild("Purple")
												if v715 then
													local v_u_716 = v715:Clone()
													v_u_716.Anchored = true
													v_u_716.CanCollide = false
													v_u_716.Parent = workspace
													v_u_310:AddItem(v_u_716, 3)
													for _, v717 in v_u_716:GetDescendants() do
														if v717:IsA("ParticleEmitter") then
															v717.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_713, (copy) v_u_716, (copy) v_u_714
														local v718 = v_u_713
														local v719 = 0
														while v719 < 200 and (v_u_716 and v_u_716.Parent) do
															v718 = v718 + v_u_714 * 3.9899999999999998
															v719 = v719 + 3.9899999999999998
															v_u_716.CFrame = CFrame.lookAt(v718, v718 + v_u_714)
															task.wait(0.03)
														end
														for _, v720 in v_u_716:GetDescendants() do
															if v720:IsA("ParticleEmitter") then
																v720.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_314 == "Sukuna" then
									local v_u_721 = v_u_315.V
									if v_u_721 then
										local v722 = (p_u_309.NPCModel or "NPC") .. "_SukunaV"
										local v723 = tick()
										if not v_u_308[v722] or v723 - v_u_308[v722] > 0.5 then
											v_u_308[v722] = v723
											v_u_37:PlayAt("SukunaV_Part1", p_u_309.Position)
										end
										local v724 = v_u_721:FindFirstChild("GroundVFX")
										if v724 then
											local v_u_725 = v724:Clone()
											v_u_725.CFrame = v_u_318.CFrame * CFrame.new(0, -2, 0)
											v_u_725.Anchored = false
											v_u_725.Parent = workspace
											v_u_310:AddItem(v_u_725, 3)
											local v726 = Instance.new("WeldConstraint")
											v726.Part0 = v_u_318
											v726.Part1 = v_u_725
											v726.Parent = v_u_725
											for _, v727 in v_u_725:GetDescendants() do
												if v727:IsA("ParticleEmitter") then
													v727.Enabled = true
													v727:Emit(v727:GetAttribute("EmitCount") or 40)
												elseif v727:IsA("Beam") then
													v727.Enabled = true
												end
											end
											task.delay(2.35, function()
												-- upvalues: (copy) v_u_725
												if v_u_725 and v_u_725.Parent then
													for _, v728 in v_u_725:GetDescendants() do
														if v728:IsA("ParticleEmitter") then
															v728.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_721, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v729 = v_u_721:FindFirstChild("MiniExplosionVFX")
												if v729 then
													local v730 = v729:Clone()
													v730.CFrame = v_u_318.CFrame * CFrame.new(1, 0, 0)
													v730.Anchored = false
													v730.Parent = workspace
													v_u_310:AddItem(v730, 2)
													local v731 = Instance.new("WeldConstraint")
													v731.Part0 = v_u_318
													v731.Part1 = v730
													v731.Parent = v730
													for _, v732 in v730:GetDescendants() do
														if v732:IsA("ParticleEmitter") then
															v732:Emit(v732:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v733 = v_u_721:FindFirstChild("ArrowVFX")
												if v733 then
													local v_u_734 = v733:Clone()
													v_u_734.CFrame = v_u_318.CFrame * CFrame.new(1, 0, 0)
													v_u_734.Anchored = false
													v_u_734.Parent = workspace
													v_u_310:AddItem(v_u_734, 2)
													local v735 = Instance.new("WeldConstraint")
													v735.Part0 = v_u_318
													v735.Part1 = v_u_734
													v735.Parent = v_u_734
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_734
														if v_u_734 and v_u_734.Parent then
															for _, v736 in v_u_734:GetDescendants() do
																if v736:IsA("ParticleEmitter") or v736:IsA("Beam") then
																	v736.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_318, (ref) p_u_309, (ref) v_u_308, (ref) v_u_37, (copy) v_u_721, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v737 = (p_u_309.NPCModel or "NPC") .. "_SukunaV2"
												local v738 = tick()
												if not v_u_308[v737] or v738 - v_u_308[v737] > 0.5 then
													v_u_308[v737] = v738
													v_u_37:PlayAt("SukunaV_Part2", v_u_318.Position)
												end
												local v739 = v_u_318.CFrame.LookVector
												local v740 = v_u_318.Position + v739 * 85
												local v741 = v_u_721:FindFirstChild("ExplosionVFX")
												if v741 then
													local v_u_742 = v741:Clone()
													if v_u_742:IsA("Model") then
														v_u_742:PivotTo(CFrame.new(v740) * CFrame.new(0, 73, 0))
													else
														v_u_742.CFrame = CFrame.new(v740) * CFrame.new(0, 73, 0)
													end
													v_u_742.Parent = workspace
													v_u_310:AddItem(v_u_742, 4)
													for _, v743 in v_u_742:GetDescendants() do
														if v743:IsA("ParticleEmitter") then
															v743.Enabled = true
															v743:Emit(v743:GetAttribute("EmitCount") or 30)
														elseif v743:IsA("Beam") or v743:IsA("Trail") then
															v743.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_742
														if v_u_742 and v_u_742.Parent then
															for _, v744 in v_u_742:GetDescendants() do
																if v744:IsA("ParticleEmitter") or (v744:IsA("Beam") or v744:IsA("Trail")) then
																	v744.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_314 == "Ragna" then
									v_u_37:PlayAt("RagnaV", p_u_309.Position)
									local v_u_745 = v_u_315.V
									if v_u_745 then
										local v746 = v_u_745:FindFirstChild("FirstEffects")
										if v746 then
											local v_u_747 = v746:Clone()
											v_u_747.CFrame = v_u_318.CFrame * CFrame.new(0, -2.5, 0)
											v_u_747.Anchored = false
											v_u_747.CanCollide = false
											v_u_747.Transparency = 1
											v_u_747.CastShadow = false
											v_u_747.CanQuery = false
											v_u_747.Massless = true
											v_u_747.Parent = workspace
											v_u_310:AddItem(v_u_747, 6)
											local v748 = Instance.new("WeldConstraint")
											v748.Part0 = v_u_318
											v748.Part1 = v_u_747
											v748.Parent = v_u_747
											for _, v749 in v_u_747:GetDescendants() do
												if v749:IsA("ParticleEmitter") then
													v749.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_747
												if v_u_747 and v_u_747.Parent then
													for _, v750 in v_u_747:GetDescendants() do
														if v750:IsA("ParticleEmitter") then
															v750.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_745, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v751 = v_u_745:FindFirstChild("UltVFX")
												if v751 then
													local v_u_752 = v751:Clone()
													v_u_752:PivotTo(v_u_318.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v753 in v_u_752:GetDescendants() do
														if v753:IsA("BasePart") then
															v753.Anchored = true
															v753.CanCollide = false
															v753.CastShadow = false
															v753.CanQuery = false
														end
													end
													v_u_752.Parent = workspace
													v_u_310:AddItem(v_u_752, 4.5)
													for _, v754 in v_u_752:GetDescendants() do
														if v754:IsA("ParticleEmitter") then
															v754.Enabled = true
														elseif v754:IsA("Beam") then
															v754.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_752
														if v_u_752 and v_u_752.Parent then
															for _, v755 in v_u_752:GetDescendants() do
																if v755:IsA("ParticleEmitter") then
																	v755.Enabled = false
																end
															end
															for _, v_u_756 in v_u_752:GetDescendants() do
																if v_u_756:IsA("Beam") then
																	local v_u_757 = v_u_756.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_757, (copy) v_u_756
																		local v758 = tick()
																		while tick() - v758 < 0.5 do
																			local v759 = (tick() - v758) / 0.5
																			local v760 = {}
																			for _, v761 in ipairs(v_u_757) do
																				local v762 = v761.Value + (1 - v761.Value) * v759
																				local v763 = NumberSequenceKeypoint.new
																				local v764 = v761.Time
																				table.insert(v760, v763(v764, v762))
																			end
																			v_u_756.Transparency = NumberSequence.new(v760)
																			task.wait()
																		end
																		v_u_756.Transparency = NumberSequence.new(1)
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
									if v_u_314 == "Ichigo" then
										local v765 = v_u_71.Ichigo
										if v765 and v765["Skill 4"] then
											local v766 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["CutsceneDuration"] = 8.33,
												["CharAnimationId"] = "rbxassetid://98446587158184",
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v765["Skill 4"](v766)
											return
										end
									elseif v_u_314 == "Alucard" then
										local v767 = v_u_71.Alucard
										if v767 and v767["Skill 4"] then
											local v768 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["AbilityConfig"] = {},
												["CutsceneDuration"] = 5.5,
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v767["Skill 4"](v768)
											return
										end
									elseif v_u_314 == "Rimuru" then
										local v769 = v_u_71.Rimuru
										if v769 and v769["Skill 4"] then
											local v770 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v769["Skill 4"](v770)
											return
										end
									elseif v_u_314 == "Madoka" then
										local v771 = v_u_71.Madoka
										if v771 and v771["Skill 4"] then
											local v772 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["DamageDelay"] = 3.13,
												["Duration"] = 8.63
											}
											v771["Skill 4"](v772)
											return
										end
									elseif v_u_314 == "Gilgamesh" then
										local v773 = v_u_71.Gilgamesh
										if v773 and v773["Skill 4"] then
											local v774 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["AbilityConfig"] = {}
											}
											v773["Skill 4"](v774)
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_309.VFXName == "F" then
						task.spawn(function()
							-- upvalues: (copy) v_u_318, (copy) v_u_314, (ref) v_u_71, (copy) v_u_317
							if v_u_318 and v_u_318.Parent then
								if v_u_314 == "Rimuru" then
									local v775 = v_u_71.Rimuru
									if v775 and v775["Skill 5"] then
										local v776 = {
											["Caster"] = {
												["Character"] = v_u_317
											},
											["AbilityConfig"] = {},
											["DisableCutscene"] = true
										}
										v775["Skill 5"](v776)
									end
								end
								if v_u_314 == "Gilgamesh" then
									local v777 = v_u_71.Gilgamesh
									if v777 and v777["Skill 5"] then
										local v778 = {
											["Caster"] = {
												["Character"] = v_u_317
											},
											["AbilityConfig"] = {}
										}
										v777["Skill 5"](v778)
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
	local v_u_780 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p781, p_u_782)
		-- upvalues: (copy) v_u_780, (copy) v_u_779, (copy) v_u_44, (copy) v_u_37, (copy) v_u_301, (copy) v_u_7, (copy) v_u_307, (copy) v_u_4
		if p781 == "SpawnVFX" then
			if p_u_782.IsNPC and (p_u_782.VFXName == "Z" or (p_u_782.VFXName == "X" or (p_u_782.VFXName == "C" or (p_u_782.VFXName == "V" or p_u_782.VFXName == "F")))) then
				local v783 = (p_u_782.NPCModel or "NPC") .. "_" .. p_u_782.VFXName
				local v784 = tick()
				if v_u_780[v783] and v784 - v_u_780[v783] < 1 then
					return
				end
				v_u_780[v783] = v784
				task.spawn(function()
					-- upvalues: (ref) v_u_779, (copy) p_u_782
					v_u_779(p_u_782)
				end)
				local v785 = p_u_782.MovesetType or "Saber"
				if p_u_782.VFXName == "Z" then
					if v785 == "Gojo" then
						local v786 = (p_u_782.NPCModel or "unknown") .. "_Z"
						local v787 = tick()
						local v788
						if v_u_44[v786] and v787 - v_u_44[v786] < 1.5 then
							v788 = false
						else
							v_u_44[v786] = v787
							v788 = true
						end
						if v788 then
							v_u_37:PlayAt("GojoZ", p_u_782.Position)
						end
					elseif v785 == "Sukuna" then
						local v789 = (p_u_782.NPCModel or "unknown") .. "_Z"
						local v790 = tick()
						local v791
						if v_u_44[v789] and v790 - v_u_44[v789] < 1.5 then
							v791 = false
						else
							v_u_44[v789] = v790
							v791 = true
						end
						if v791 then
							v_u_37:PlayAt("SukunaZ", p_u_782.Position)
						end
					elseif v785 == "Jinwoo" then
						local v792 = (p_u_782.NPCModel or "unknown") .. "_Z"
						local v793 = tick()
						local v794
						if v_u_44[v792] and v793 - v_u_44[v792] < 1.5 then
							v794 = false
						else
							v_u_44[v792] = v793
							v794 = true
						end
						if v794 then
							v_u_37:PlayAt("JinwooZ", p_u_782.Position)
						end
					elseif v785 == "Ragna" then
						local v795 = (p_u_782.NPCModel or "unknown") .. "_Z"
						local v796 = tick()
						local v797
						if v_u_44[v795] and v796 - v_u_44[v795] < 1.5 then
							v797 = false
						else
							v_u_44[v795] = v796
							v797 = true
						end
						if v797 then
							v_u_37:PlayAt("RagnaZ", p_u_782.Position)
						end
					elseif v785 == "Aizen" then
						local v798 = (p_u_782.NPCModel or "unknown") .. "_Z"
						local v799 = tick()
						local v800
						if v_u_44[v798] and v799 - v_u_44[v798] < 1.5 then
							v800 = false
						else
							v_u_44[v798] = v799
							v800 = true
						end
						if v800 then
							v_u_37:PlayAt("AizenZ", p_u_782.Position)
						end
					elseif v785 == "QinShi" then
						local v801 = (p_u_782.NPCModel or "unknown") .. "_Z"
						local v802 = tick()
						local v803
						if v_u_44[v801] and v802 - v_u_44[v801] < 1.5 then
							v803 = false
						else
							v_u_44[v801] = v802
							v803 = true
						end
						if v803 then
							v_u_37:PlayAt("QinShiZ", p_u_782.Position)
						end
					elseif v785 == "Yuji" then
						local v804 = (p_u_782.NPCModel or "unknown") .. "_Z"
						local v805 = tick()
						local v806
						if v_u_44[v804] and v805 - v_u_44[v804] < 1.5 then
							v806 = false
						else
							v_u_44[v804] = v805
							v806 = true
						end
						if v806 then
							v_u_37:PlayAt("YujiZ", p_u_782.Position)
						end
					elseif v785 ~= "Alucard" then
						if v785 == "GojoV2" then
							local v807 = (p_u_782.NPCModel or "unknown") .. "_Z"
							local v808 = tick()
							local v809
							if v_u_44[v807] and v808 - v_u_44[v807] < 1.5 then
								v809 = false
							else
								v_u_44[v807] = v808
								v809 = true
							end
							if v809 then
								v_u_37:PlayAt("GojoV2Z", p_u_782.Position)
							end
						elseif v785 ~= "StrongestInHistory" and (v785 ~= "Rimuru" and v785 ~= "Madoka") then
							local v810 = (p_u_782.NPCModel or "unknown") .. "_Z"
							local v811 = tick()
							local v812
							if v_u_44[v810] and v811 - v_u_44[v810] < 1.5 then
								v812 = false
							else
								v_u_44[v810] = v811
								v812 = true
							end
							if v812 then
								v_u_37:PlayAt("SaberZ", p_u_782.Position)
							end
						end
					end
				elseif p_u_782.VFXName == "X" then
					if v785 == "Gojo" then
						local v813 = (p_u_782.NPCModel or "unknown") .. "_X"
						local v814 = tick()
						local v815
						if v_u_44[v813] and v814 - v_u_44[v813] < 1.5 then
							v815 = false
						else
							v_u_44[v813] = v814
							v815 = true
						end
						if v815 then
							v_u_37:PlayAt("GojoX", p_u_782.Position)
						end
					elseif v785 == "Sukuna" then
						local v816 = (p_u_782.NPCModel or "unknown") .. "_X"
						local v817 = tick()
						local v818
						if v_u_44[v816] and v817 - v_u_44[v816] < 1.5 then
							v818 = false
						else
							v_u_44[v816] = v817
							v818 = true
						end
						if v818 then
							v_u_37:PlayAt("SukunaX", p_u_782.Position)
						end
					elseif v785 == "Jinwoo" then
						local v819 = (p_u_782.NPCModel or "unknown") .. "_X"
						local v820 = tick()
						local v821
						if v_u_44[v819] and v820 - v_u_44[v819] < 1.5 then
							v821 = false
						else
							v_u_44[v819] = v820
							v821 = true
						end
						if v821 then
							v_u_37:PlayAt("JinwooX", p_u_782.Position)
						end
					elseif v785 == "Ragna" then
						local v822 = (p_u_782.NPCModel or "unknown") .. "_X"
						local v823 = tick()
						local v824
						if v_u_44[v822] and v823 - v_u_44[v822] < 1.5 then
							v824 = false
						else
							v_u_44[v822] = v823
							v824 = true
						end
						if v824 then
							v_u_37:PlayAt("RagnaX", p_u_782.Position)
						end
					elseif v785 == "Aizen" then
						local v825 = (p_u_782.NPCModel or "unknown") .. "_X"
						local v826 = tick()
						local v827
						if v_u_44[v825] and v826 - v_u_44[v825] < 1.5 then
							v827 = false
						else
							v_u_44[v825] = v826
							v827 = true
						end
						if v827 then
							v_u_37:PlayAt("AizenX", p_u_782.Position)
						end
					elseif v785 == "QinShi" then
						local v828 = (p_u_782.NPCModel or "unknown") .. "_X"
						local v829 = tick()
						local v830
						if v_u_44[v828] and v829 - v_u_44[v828] < 1.5 then
							v830 = false
						else
							v_u_44[v828] = v829
							v830 = true
						end
						if v830 then
							v_u_37:PlayAt("QinShiX", p_u_782.Position)
						end
					elseif v785 == "Yuji" then
						local v831 = (p_u_782.NPCModel or "unknown") .. "_X"
						local v832 = tick()
						local v833
						if v_u_44[v831] and v832 - v_u_44[v831] < 1.5 then
							v833 = false
						else
							v_u_44[v831] = v832
							v833 = true
						end
						if v833 then
							v_u_37:PlayAt("YujiX", p_u_782.Position)
						end
					elseif v785 ~= "Ichigo" and v785 ~= "Alucard" then
						if v785 == "GojoV2" then
							local v834 = (p_u_782.NPCModel or "unknown") .. "_X"
							local v835 = tick()
							local v836
							if v_u_44[v834] and v835 - v_u_44[v834] < 1.5 then
								v836 = false
							else
								v_u_44[v834] = v835
								v836 = true
							end
							if v836 then
								v_u_37:PlayAt("GojoV2X", p_u_782.Position)
							end
						elseif v785 ~= "StrongestInHistory" and (v785 ~= "Rimuru" and v785 ~= "Madoka") then
							local v837 = (p_u_782.NPCModel or "unknown") .. "_X"
							local v838 = tick()
							local v839
							if v_u_44[v837] and v838 - v_u_44[v837] < 1.5 then
								v839 = false
							else
								v_u_44[v837] = v838
								v839 = true
							end
							if v839 then
								v_u_37:PlayAt("SaberX", p_u_782.Position)
							end
						end
					end
				elseif p_u_782.VFXName == "C" then
					if v785 == "Gojo" then
						local v840 = (p_u_782.NPCModel or "unknown") .. "_C"
						local v841 = tick()
						local v842
						if v_u_44[v840] and v841 - v_u_44[v840] < 1.5 then
							v842 = false
						else
							v_u_44[v840] = v841
							v842 = true
						end
						if v842 then
							v_u_37:PlayAt("GojoC", p_u_782.Position)
							v_u_37:PlayAt("GojoC_Hold", p_u_782.Position)
						end
					elseif v785 == "Jinwoo" then
						local v843 = (p_u_782.NPCModel or "unknown") .. "_C"
						local v844 = tick()
						local v845
						if v_u_44[v843] and v844 - v_u_44[v843] < 1.5 then
							v845 = false
						else
							v_u_44[v843] = v844
							v845 = true
						end
						if v845 then
							v_u_37:PlayAt("JinwooC", p_u_782.Position)
						end
					elseif v785 == "Ragna" then
						local v846 = (p_u_782.NPCModel or "unknown") .. "_C"
						local v847 = tick()
						local v848
						if v_u_44[v846] and v847 - v_u_44[v846] < 1.5 then
							v848 = false
						else
							v_u_44[v846] = v847
							v848 = true
						end
						if v848 then
							v_u_37:PlayAt("RagnaC_Startup", p_u_782.Position)
						end
					elseif v785 == "Aizen" then
						local v849 = (p_u_782.NPCModel or "unknown") .. "_C"
						local v850 = tick()
						local v851
						if v_u_44[v849] and v850 - v_u_44[v849] < 1.5 then
							v851 = false
						else
							v_u_44[v849] = v850
							v851 = true
						end
						if v851 then
							v_u_37:PlayAt("AizenC", p_u_782.Position)
						end
					elseif v785 == "QinShi" then
						local v852 = (p_u_782.NPCModel or "unknown") .. "_C"
						local v853 = tick()
						local v854
						if v_u_44[v852] and v853 - v_u_44[v852] < 1.5 then
							v854 = false
						else
							v_u_44[v852] = v853
							v854 = true
						end
						if v854 then
							v_u_37:PlayAt("QinShiC", p_u_782.Position)
						end
					elseif v785 == "Yuji" then
						local v855 = (p_u_782.NPCModel or "unknown") .. "_C"
						local v856 = tick()
						local v857
						if v_u_44[v855] and v856 - v_u_44[v855] < 1.5 then
							v857 = false
						else
							v_u_44[v855] = v856
							v857 = true
						end
						if v857 then
							v_u_37:PlayAt("YujiC_Press", p_u_782.Position)
						end
					elseif v785 ~= "Ichigo" and (v785 ~= "Alucard" and (v785 ~= "GojoV2" and (v785 ~= "StrongestInHistory" and (v785 ~= "Rimuru" and v785 ~= "Madoka")))) then
						local v858 = (p_u_782.NPCModel or "unknown") .. "_C"
						local v859 = tick()
						local v860
						if v_u_44[v858] and v859 - v_u_44[v858] < 1.5 then
							v860 = false
						else
							v_u_44[v858] = v859
							v860 = true
						end
						if v860 then
							v_u_37:PlayAt("SaberC_Cast", p_u_782.Position)
							task.delay(3.85, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_782
								v_u_37:PlayAt("SaberC_Beam", p_u_782.Position)
							end)
							task.delay(4.4, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_782
								v_u_37:PlayAt("SaberC_Explosion", p_u_782.Position)
							end)
						end
					end
				elseif p_u_782.VFXName == "V" then
					if v785 == "Gojo" then
						v_u_37:PlayAt("GojoV", p_u_782.Position)
					elseif v785 ~= "Sukuna" and (v785 ~= "Ichigo" and (v785 ~= "Alucard" and (v785 ~= "GojoV2" and (v785 ~= "StrongestInHistory" and v785 ~= "Rimuru")))) then
						local _ = v785 == "Madoka"
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_301, (copy) p_u_782
					v_u_301.SpawnVFX(p_u_782.VFXName, p_u_782.Position, p_u_782.Scale, p_u_782.Duration, p_u_782.AbilityName)
				end)
			end
			if p_u_782.CameraShake then
				task.delay(p_u_782.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_782, (ref) v_u_7
					local v_u_861 = p_u_782.CameraShake.Intensity or 5
					local v_u_862 = p_u_782.CameraShake.Duration or 0.3
					if v_u_7:GetAttribute("DisableScreenShake") then
						return
					else
						local v_u_863 = workspace.CurrentCamera
						if v_u_863 then
							task.spawn(function()
								-- upvalues: (copy) v_u_863, (copy) v_u_862, (copy) v_u_861
								local v864 = tick()
								local _ = v_u_863.CFrame
								while tick() - v864 < v_u_862 do
									local v865 = v_u_861 * (1 - (tick() - v864) / v_u_862)
									local v866 = (math.random() - 0.5) * v865 * 0.1
									local v867 = (math.random() - 0.5) * v865 * 0.1
									v_u_863.CFrame = v_u_863.CFrame * CFrame.new(v866, v867, 0)
									task.wait()
								end
							end)
						end
					end
				end)
			end
			if p_u_782.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_307, (copy) p_u_782
					v_u_307(p_u_782.ScreenFlash)
				end)
				return
			end
		elseif p781 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_301, (copy) p_u_782, (ref) v_u_4
				local v868 = v_u_301.SpawnVFXWithRotation(p_u_782.VFXName, p_u_782.Position, p_u_782.Rotation, p_u_782.Scale, p_u_782.Duration, "KatanaAbilities")
				if v868 then
					v_u_4:AddItem(v868, (p_u_782.Duration or 0.4) + 1)
				end
			end)
			if p_u_782.IsNPC then
				v_u_37:PlayAt("KatanaZ", p_u_782.Position)
			end
			if p_u_782.CameraShake then
				local v_u_869 = p_u_782.CameraShake.Intensity or 3
				local v_u_870 = p_u_782.CameraShake.Duration or 0.2
				if v_u_7:GetAttribute("DisableScreenShake") then
					return
				else
					local v_u_871 = workspace.CurrentCamera
					if v_u_871 then
						task.spawn(function()
							-- upvalues: (copy) v_u_871, (copy) v_u_870, (copy) v_u_869
							local v872 = tick()
							local _ = v_u_871.CFrame
							while tick() - v872 < v_u_870 do
								local v873 = v_u_869 * (1 - (tick() - v872) / v_u_870)
								local v874 = (math.random() - 0.5) * v873 * 0.1
								local v875 = (math.random() - 0.5) * v873 * 0.1
								v_u_871.CFrame = v_u_871.CFrame * CFrame.new(v874, v875, 0)
								task.wait()
							end
						end)
					end
				end
			end
		elseif p781 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_301, (copy) p_u_782, (ref) v_u_4
				local v876 = v_u_301.SpawnTravelingVFX(p_u_782.VFXName, p_u_782.StartPosition, p_u_782.Direction, p_u_782.TravelDistance, p_u_782.TravelSpeed, p_u_782.Scale, p_u_782.Duration, "KatanaAbilities")
				if v876 then
					v_u_4:AddItem(v876, (p_u_782.TravelDistance or 50) / (p_u_782.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_782.CameraShake then
				local v_u_877 = p_u_782.CameraShake.Intensity or 6
				local v_u_878 = p_u_782.CameraShake.Duration or 0.3
				local v_u_879 = not v_u_7:GetAttribute("DisableScreenShake") and workspace.CurrentCamera
				if v_u_879 then
					task.spawn(function()
						-- upvalues: (copy) v_u_879, (copy) v_u_878, (copy) v_u_877
						local v880 = tick()
						local _ = v_u_879.CFrame
						while tick() - v880 < v_u_878 do
							local v881 = v_u_877 * (1 - (tick() - v880) / v_u_878)
							local v882 = (math.random() - 0.5) * v881 * 0.1
							local v883 = (math.random() - 0.5) * v881 * 0.1
							v_u_879.CFrame = v_u_879.CFrame * CFrame.new(v882, v883, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_782.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_307, (copy) p_u_782
					v_u_307(p_u_782.ScreenFlash)
				end)
			end
		end
	end)
	local v884 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_885 = 1
	v884.OnClientEvent:Connect(function(p886)
		-- upvalues: (ref) v_u_885, (copy) v_u_37
		if p886 and p886.Position then
			v_u_37:PlayAt("CombatHit" .. v_u_885, p886.Position)
			v_u_885 = v_u_885 % 7 + 1
		end
	end)
	local v_u_887 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v888 = v46:WaitForChild("HitboxVisualize", 5)
	if v888 then
		v888.OnClientEvent:Connect(function(p889)
			-- upvalues: (copy) v_u_887
			if p889.Type == "Box" then
				v_u_887.ShowBox(p889.CFrame, p889.Size, p889.Duration, p889.Color)
				return
			elseif p889.Type == "Sphere" then
				v_u_887.ShowSphere(p889.Position, p889.Radius, p889.Duration, p889.Color)
				return
			elseif p889.Type == "Traveling" then
				v_u_887.ShowTraveling(p889.StartPos, p889.Direction, p889.Size, p889.Speed, p889.Distance, p889.HitboxType, p889.Color)
			elseif p889.Type == "FollowingAOE" then
				local v890 = p889.Character
				if v890 then
					v_u_887.ShowFollowingAOE(v890, p889.Size, p889.Duration, p889.Offset, p889.Color, p889.Shape)
					return
				end
			else
				if p889.Type == "MultiWave" then
					v_u_887.ShowMultiWave(p889.OriginCFrame, p889.Waves)
					return
				end
				if p889.Type == "Explosion" then
					v_u_887.ShowExplosion(p889.Position, p889.Radius, p889.Duration, p889.Color)
					return
				end
				if p889.Type == "StaticBox" then
					v_u_887.ShowStaticBox(p889.StartPos, p889.EndPos, p889.Width, p889.Height, p889.Duration, p889.Color)
				end
			end
		end)
	end
end)
if not v891 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v892)
	warn("=====================================")
end