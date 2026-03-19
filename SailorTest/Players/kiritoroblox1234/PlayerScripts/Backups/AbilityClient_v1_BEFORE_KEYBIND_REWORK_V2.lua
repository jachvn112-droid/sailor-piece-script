local v898, v899 = pcall(function()
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
						if v288 and (v288.Type == "ContinuousDamage" and (v290 and not (v288.AnchorHitbox or (p_u_269.AnchorHitbox or (v288.DirectDamage or v288.WorldAnchorHitbox))))) then
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
	local function v_u_786(p_u_309)
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
										elseif v_u_314 == "Anos" then
											local v408 = v_u_71.Anos
											if v408 and v408["Skill 1"] then
												local v409 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v408["Skill 1"](v409)
												return
											end
										else
											task.wait(0.45)
											if not (v_u_318 and v_u_318.Parent) then
												return
											end
											local v410 = v_u_318.CFrame
											local v411 = v_u_315.Z:FindFirstChild("EnergyThrust")
											local v412 = v_u_315.Z:FindFirstChild("EnergyPart")
											if v411 then
												v_u_324(v411, v410 * CFrame.new(0, 2, -35), 3)
											end
											if v412 then
												v_u_324(v412, v410 * CFrame.new(0, 2, -2), 3)
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
									local v_u_413 = v_u_317:FindFirstChild("Right Arm")
									if v_u_413 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_315, (copy) v_u_413, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v414 = v_u_315.X:FindFirstChild("BlueVFXFirst")
												if v414 then
													local v415 = v414:Clone()
													v415.CFrame = v_u_413.CFrame * CFrame.new(0, -1.05, 0)
													v415.Anchored = true
													v415.CanCollide = false
													v415.Transparency = 1
													v415.CastShadow = false
													v415.CanQuery = false
													v415.Parent = workspace
													v_u_310:AddItem(v415, 4)
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
													v415.Anchored = false
													local v418 = Instance.new("WeldConstraint")
													v418.Part0 = v_u_413
													v418.Part1 = v415
													v418.Parent = v415
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_315, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v419 = v_u_318.CFrame
												local v420 = v_u_315.X:FindFirstChild("BlueMainVFX")
												if v420 then
													local v421 = v420:Clone()
													v421.CFrame = v419 * CFrame.new(0, 0, -25)
													v421.Anchored = true
													v421.CanCollide = false
													v421.Transparency = 1
													v421.CastShadow = false
													v421.CanQuery = false
													v421.Parent = workspace
													v_u_310:AddItem(v421, 3)
													for _, v_u_422 in v421:GetDescendants() do
														if v_u_422:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_422
																local v423 = v_u_422:GetAttribute("EmitDelay") or 0
																task.wait(v423)
																v_u_422:Emit(v_u_422:GetAttribute("EmitCount") or v_u_422.Rate)
															end)
														end
													end
												end
												local v424 = v_u_315.X:FindFirstChild("Blue_Additional_VFX")
												if v424 then
													local v425 = v424:Clone()
													v425.CFrame = v419 * CFrame.new(0, 0, -5)
													v425.Anchored = true
													v425.CanCollide = false
													v425.Transparency = 1
													v425.CastShadow = false
													v425.CanQuery = false
													v425.Parent = workspace
													v_u_310:AddItem(v425, 4)
													for _, v_u_426 in v425:GetDescendants() do
														if v_u_426:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_426
																local v427 = v_u_426:GetAttribute("EmitDelay") or 0
																task.wait(v427)
																v_u_426:Emit(v_u_426:GetAttribute("EmitCount") or v_u_426.Rate)
															end)
														end
													end
												end
											end
										end)
									end
								else
									if v_u_314 == "Sukuna" then
										local v428 = v_u_315.X
										if not v428 then
											return
										end
										local v429 = v428:FindFirstChild("GroundVFX")
										if v429 then
											local v_u_430 = v429:Clone()
											v_u_430:PivotTo(v_u_318.CFrame * CFrame.new(0, -2.5, 0))
											v_u_430.Parent = workspace
											v_u_310:AddItem(v_u_430, 3.5)
											local v431 = v_u_430.PrimaryPart or v_u_430:FindFirstChildWhichIsA("BasePart")
											for _, v432 in v_u_430:GetDescendants() do
												if v432:IsA("BasePart") then
													v432.Anchored = false
													v432.CanCollide = false
													v432.CanQuery = false
													v432.CanTouch = false
													v432.Massless = true
												end
											end
											if v431 then
												local v433 = Instance.new("WeldConstraint")
												v433.Part0 = v_u_318
												v433.Part1 = v431
												v433.Parent = v431
											end
											task.delay(2.6, function()
												-- upvalues: (copy) v_u_430
												if v_u_430 and v_u_430.Parent then
													for _, v434 in v_u_430:GetDescendants() do
														if v434:IsA("ParticleEmitter") then
															v434.Enabled = false
														end
													end
												end
											end)
											return
										end
									elseif v_u_314 == "Jinwoo" then
										local v435 = v_u_315.X
										if not v435 then
											return
										end
										local v436 = v435:FindFirstChild("DashVFX")
										local v437 = v435:FindFirstChild("SlashesVFX")
										local v438 = v_u_318.CFrame.LookVector
										local v439 = CFrame.lookAt(v_u_318.Position, v_u_318.Position + v438)
										if v436 then
											local v_u_440 = v436:Clone()
											v_u_440.CFrame = v439
											v_u_440.Anchored = false
											v_u_440.CanCollide = false
											v_u_440.Transparency = 1
											v_u_440.CastShadow = false
											v_u_440.CanQuery = false
											v_u_440.Massless = true
											v_u_440.Parent = workspace
											v_u_310:AddItem(v_u_440, 1.5)
											local v441 = Instance.new("WeldConstraint")
											v441.Part0 = v_u_318
											v441.Part1 = v_u_440
											v441.Parent = v_u_440
											for _, v442 in v_u_440:GetDescendants() do
												if v442:IsA("ParticleEmitter") then
													v442.Enabled = true
													v442:Emit(v442:GetAttribute("EmitCount") or 30)
												end
											end
											task.delay(0.5, function()
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
										if v437 then
											local v444 = v437:Clone()
											v444.CFrame = v439 * CFrame.new(0, 0, -20)
											v444.Anchored = true
											v444.CanCollide = false
											v444.Transparency = 1
											v444.CastShadow = false
											v444.CanQuery = false
											v444.Parent = workspace
											v_u_310:AddItem(v444, 1.5)
											for _, v_u_445 in v444:GetDescendants() do
												if v_u_445:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_445
														local v446 = v_u_445:GetAttribute("EmitDelay") or 0
														if v446 > 0 then
															task.wait(v446)
														end
														v_u_445:Emit(v_u_445:GetAttribute("EmitCount") or v_u_445.Rate)
													end)
												end
											end
											return
										end
									elseif v_u_314 == "Ragna" then
										local v_u_447 = v_u_315.X
										if v_u_447 then
											local v448 = v_u_447:FindFirstChild("GroundVFX")
											if v448 then
												local v449 = v448:Clone()
												v449.CFrame = v_u_318.CFrame * CFrame.new(0, -2.5, 0)
												v449.Anchored = true
												v449.CanCollide = false
												v449.Transparency = 1
												v449.Parent = workspace
												v_u_310:AddItem(v449, 5)
												for _, v_u_450 in v449:GetDescendants() do
													if v_u_450:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_450
															local v451 = v_u_450:GetAttribute("EmitDelay") or 0
															if v451 > 0 then
																task.wait(v451)
															end
															v_u_450:Emit(v_u_450:GetAttribute("EmitCount") or v_u_450.Rate)
														end)
													end
												end
											end
											local v452 = v_u_447:FindFirstChild("ChargeVFX")
											if v452 then
												local v_u_453 = v452:Clone()
												v_u_453.CFrame = v_u_318.CFrame
												v_u_453.Anchored = false
												v_u_453.CanCollide = false
												v_u_453.Transparency = 1
												v_u_453.Massless = true
												v_u_453.Parent = workspace
												v_u_310:AddItem(v_u_453, 1.3)
												local v454 = Instance.new("WeldConstraint")
												v454.Part0 = v_u_318
												v454.Part1 = v_u_453
												v454.Parent = v_u_453
												for _, v455 in v_u_453:GetDescendants() do
													if v455:IsA("ParticleEmitter") then
														v455.Enabled = true
													end
												end
												task.delay(0.4, function()
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
											task.delay(0.44999999999999996, function()
												-- upvalues: (ref) v_u_318, (copy) v_u_447, (ref) v_u_310
												if v_u_318 and v_u_318.Parent then
													local v457 = v_u_447:FindFirstChild("BarrageVFX")
													if v457 then
														local v_u_458 = v457:Clone()
														v_u_458.CFrame = v_u_318.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_458.Anchored = true
														v_u_458.CanCollide = false
														v_u_458.Transparency = 1
														v_u_458.Parent = workspace
														v_u_310:AddItem(v_u_458, 2.9)
														for _, v459 in v_u_458:GetDescendants() do
															if v459:IsA("ParticleEmitter") then
																v459.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_458
															if v_u_458 and v_u_458.Parent then
																for _, v460 in v_u_458:GetDescendants() do
																	if v460:IsA("ParticleEmitter") then
																		v460.Enabled = false
																	end
																end
															end
														end)
													end
													local v461 = v_u_447:FindFirstChild("BarrageGroundVFX")
													if v461 then
														local v_u_462 = v461:Clone()
														v_u_462.CFrame = v_u_318.CFrame * CFrame.new(0, -37.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_462.Anchored = true
														v_u_462.CanCollide = false
														v_u_462.Transparency = 1
														v_u_462.Parent = workspace
														v_u_310:AddItem(v_u_462, 2.7)
														for _, v463 in v_u_462:GetDescendants() do
															if v463:IsA("ParticleEmitter") then
																v463.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_462
															if v_u_462 and v_u_462.Parent then
																for _, v464 in v_u_462:GetDescendants() do
																	if v464:IsA("ParticleEmitter") then
																		v464.Enabled = false
																	end
																end
															end
														end)
													end
												end
											end)
											task.delay(2, function()
												-- upvalues: (ref) v_u_318, (copy) v_u_447, (ref) v_u_310
												if v_u_318 and v_u_318.Parent then
													local v465 = v_u_447:FindFirstChild("ChargeVFX")
													if v465 then
														local v_u_466 = v465:Clone()
														v_u_466.CFrame = v_u_318.CFrame
														v_u_466.Anchored = false
														v_u_466.CanCollide = false
														v_u_466.Transparency = 1
														v_u_466.Massless = true
														v_u_466.Parent = workspace
														v_u_310:AddItem(v_u_466, 1)
														local v467 = Instance.new("WeldConstraint")
														v467.Part0 = v_u_318
														v467.Part1 = v_u_466
														v467.Parent = v_u_466
														for _, v468 in v_u_466:GetDescendants() do
															if v468:IsA("ParticleEmitter") then
																v468.Enabled = true
															end
														end
														task.delay(0.6, function()
															-- upvalues: (copy) v_u_466
															if v_u_466 and v_u_466.Parent then
																for _, v469 in v_u_466:GetDescendants() do
																	if v469:IsA("ParticleEmitter") then
																		v469.Enabled = false
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
											local v470 = v_u_315.X:FindFirstChild("BarrageVFX")
											if v470 then
												local v_u_471 = v470:Clone()
												v_u_471.CFrame = v_u_318.CFrame * CFrame.new(0, 4, -15)
												v_u_471.Anchored = false
												v_u_471.CanCollide = false
												v_u_471.Transparency = 1
												v_u_471.CastShadow = false
												v_u_471.CanQuery = false
												v_u_471.Massless = true
												v_u_471.Parent = workspace
												v_u_310:AddItem(v_u_471, 3.7)
												local v472 = Instance.new("WeldConstraint")
												v472.Part0 = v_u_318
												v472.Part1 = v_u_471
												v472.Parent = v_u_471
												for _, v473 in v_u_471:GetDescendants() do
													if v473:IsA("ParticleEmitter") or (v473:IsA("Beam") or v473:IsA("Trail")) then
														v473.Enabled = true
													end
												end
												task.delay(1.7, function()
													-- upvalues: (copy) v_u_471
													if v_u_471 and v_u_471.Parent then
														for _, v474 in v_u_471:GetDescendants() do
															if v474:IsA("ParticleEmitter") or (v474:IsA("Beam") or v474:IsA("Trail")) then
																v474.Enabled = false
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
												local v475 = { 0, 0 }
												local v476 = {
													{ 180, 180, 135 },
													{ 180, 180, 45 }
												}
												for v477 = 1, 2 do
													if not (v_u_318 and v_u_318.Parent) then
														break
													end
													local v478 = v475[v477]
													local v479 = v476[v477][1]
													local v480 = v476[v477][2]
													local v481 = v476[v477][3]
													local v482 = v_u_318.CFrame * CFrame.Angles(0, math.rad(v478), 0)
													local v483 = v482.Position
													local v484 = v483 + v482.LookVector * 80
													local v485 = CFrame.Angles(math.rad(v479), math.rad(v480), (math.rad(v481)))
													local v486 = CFrame.lookAt(v483, v484) * v485
													local v487 = CFrame.lookAt(v484, v484 + v482.LookVector) * v485
													local v488 = v_u_315.X:FindFirstChild("StartVFX")
													if v488 then
														local v489 = v488:Clone()
														v489.CFrame = v486
														v489.Anchored = true
														v489.CanCollide = false
														v489.Transparency = 1
														v489.Parent = workspace
														v_u_310:AddItem(v489, 2)
														for _, v490 in v489:GetDescendants() do
															if v490:IsA("ParticleEmitter") then
																v490:Emit(v490:GetAttribute("EmitCount") or v490.Rate)
															end
														end
													end
													local v491 = v_u_315.X:FindFirstChild("SlashVFX")
													if v491 then
														local v_u_492 = v491:Clone()
														v_u_492.CFrame = v486
														v_u_492.Anchored = true
														v_u_492.CanCollide = false
														v_u_492.Transparency = 1
														v_u_492.Parent = workspace
														v_u_310:AddItem(v_u_492, 3)
														for _, v493 in v_u_492:GetDescendants() do
															if v493:IsA("ParticleEmitter") or (v493:IsA("Beam") or v493:IsA("Trail")) then
																v493.Enabled = true
															end
														end
														local v494 = v_u_311:Create(v_u_492, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															["CFrame"] = v487
														})
														v494:Play()
														v494.Completed:Connect(function()
															-- upvalues: (copy) v_u_492
															for _, v495 in v_u_492:GetDescendants() do
																if v495:IsA("ParticleEmitter") or (v495:IsA("Beam") or v495:IsA("Trail")) then
																	v495.Enabled = false
																end
															end
														end)
													end
													if v477 < 2 then
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
													local v496 = v_u_315:FindFirstChild("X")
													if v496 then
														local v497 = v496:FindFirstChild("StompVFX")
														if v497 then
															local v498 = v_u_318.Position - Vector3.new(0, 2.5, 0)
															local v499 = v497:Clone()
															local v500 = v499:FindFirstChild("Main")
															local v501 = v499:FindFirstChild("Lightning")
															if v500 then
																v500.CFrame = CFrame.new(v498)
																v500.Anchored = true
																v500.CanCollide = false
																v500.Transparency = 1
															end
															if v501 then
																v501.CFrame = CFrame.new(v498 + Vector3.new(0, 13, 0))
																v501.Anchored = true
																v501.CanCollide = false
																v501.Transparency = 1
															end
															v499.Parent = workspace
															v_u_310:AddItem(v499, 3)
															for _, v_u_502 in v499:GetDescendants() do
																if v_u_502:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_502
																		local v503 = v_u_502:GetAttribute("EmitDelay") or 0
																		task.wait(v503)
																		v_u_502:Emit(v_u_502:GetAttribute("EmitCount") or v_u_502.Rate)
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
											local v504 = v_u_315.X
											local v505 = v504 and v504:FindFirstChild("BarrageVFX")
											if v505 then
												local v_u_506 = v505:Clone()
												v_u_506.CFrame = v_u_318.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, -1.5707963267948966, 0)
												v_u_506.Anchored = false
												v_u_506.CanCollide = false
												v_u_506.Transparency = 1
												v_u_506.CastShadow = false
												v_u_506.CanQuery = false
												v_u_506.Massless = true
												v_u_506.Parent = workspace
												v_u_310:AddItem(v_u_506, 4)
												local v507 = Instance.new("WeldConstraint")
												v507.Part0 = v_u_318
												v507.Part1 = v_u_506
												v507.Parent = v_u_506
												for _, v508 in v_u_506:GetDescendants() do
													if v508:IsA("ParticleEmitter") then
														v508.Enabled = true
													end
												end
												task.delay(3.2, function()
													-- upvalues: (copy) v_u_506
													if v_u_506 and v_u_506.Parent then
														for _, v509 in v_u_506:GetDescendants() do
															if v509:IsA("ParticleEmitter") then
																v509.Enabled = false
															end
														end
													end
												end)
												return
											end
										elseif v_u_314 == "Alucard" then
											local v510 = v_u_71.Alucard
											if v510 and v510["Skill 2"] then
												local v511 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v510["Skill 2"](v511)
												return
											end
										elseif v_u_314 == "GojoV2" then
											local v512 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v512 then
												v512 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v512 then
												local v513 = require(v512)
												if v513["Skill 2"] then
													v513["Skill 2"]({
														["Caster"] = {
															["Character"] = v_u_317
														},
														["Duration"] = p_u_309.Duration or 6
													})
													return
												end
											end
										elseif v_u_314 == "StrongestInHistory" then
											local v514 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v514 then
												v514 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v514 then
												local v515 = require(v514)
												if v515["Skill 2"] then
													local v516 = {
														["Caster"] = {
															["Character"] = v_u_317
														}
													}
													v515["Skill 2"](v516)
													return
												end
											end
										elseif v_u_314 == "Ichigo" then
											local v517 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v517 then
												v517 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("Ichigo")
											end
											if v517 then
												local v518 = require(v517)
												if v518 and v518["Skill 2"] then
													local v519 = {
														["Caster"] = {
															["Character"] = v_u_317
														},
														["Duration"] = 4
													}
													v518["Skill 2"](v519)
													return
												end
											end
										elseif v_u_314 == "Rimuru" then
											local v520 = v_u_71.Rimuru
											if v520 and v520["Skill 2"] then
												local v521 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v520["Skill 2"](v521)
												return
											end
										elseif v_u_314 == "Madoka" then
											local v522 = v_u_71.Madoka
											if v522 and v522["Skill 2"] then
												v522["Skill 2"]({
													["Caster"] = {
														["Character"] = v_u_317
													},
													["Position"] = v_u_318 and v_u_318.Position + v_u_318.CFrame.LookVector * 50 or nil
												})
												return
											end
										elseif v_u_314 == "Gilgamesh" then
											local v523 = v_u_71.Gilgamesh
											if v523 and v523["Skill 2"] then
												local v524 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v523["Skill 2"](v524)
												return
											end
										elseif v_u_314 == "Anos" then
											local v525 = v_u_71.Anos
											if v525 and v525["Skill 2"] then
												local v526 = {
													["Caster"] = {
														["Character"] = v_u_317
													},
													["AbilityConfig"] = {}
												}
												v525["Skill 2"](v526)
												return
											end
										else
											task.wait(0.35)
											if not (v_u_318 and v_u_318.Parent) then
												return
											end
											local v527 = v_u_318.CFrame
											local v528 = v_u_315.X:FindFirstChild("EnergySlashes")
											if not v528 then
												return
											end
											local v_u_529 = v528:Clone()
											v_u_529.CFrame = v527 * CFrame.new(0, 1.5, -20)
											v_u_529.Anchored = false
											v_u_529.CanCollide = false
											v_u_529.Transparency = 1
											v_u_529.CastShadow = false
											v_u_529.CanQuery = false
											v_u_529.Massless = true
											v_u_529.Parent = workspace
											v_u_310:AddItem(v_u_529, 4)
											local v530 = Instance.new("WeldConstraint")
											v530.Part0 = v_u_529
											v530.Part1 = v_u_318
											v530.Parent = v_u_529
											v_u_310:AddItem(v530, 2.06)
											task.delay(2.05, function()
												-- upvalues: (copy) v_u_529
												for _, v531 in v_u_529:GetDescendants() do
													if v531:IsA("ParticleEmitter") then
														v531.Enabled = false
													end
												end
												v_u_529.Anchored = true
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
									local v532 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v532 then
										v532 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v532 then
										local v533 = require(v532)
										if v533["Skill 3"] then
											local v534 = v533["Skill 3"]
											local v535 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["Duration"] = p_u_309.Duration or 6
											}
											v534(v535)
										end
									end
									return
								elseif v_u_314 == "StrongestInHistory" then
									local v536 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v536 then
										v536 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v536 then
										local v_u_537 = require(v536)
										if v_u_537["Skill 3"] then
											local v538 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["ChargeTime"] = 2.5
											}
											v_u_537["Skill 3"](v538)
										end
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_537, (ref) v_u_317
											if v_u_318 and v_u_318.Parent then
												local v539 = v_u_318.Position + v_u_318.CFrame.LookVector * 85
												if v_u_537["Skill 3"] then
													local v540 = v_u_537["Skill 3"]
													local v541 = {
														["Caster"] = {
															["Character"] = v_u_317
														},
														["Phase"] = "Explosion",
														["Position"] = v539,
														["CFrame"] = CFrame.new(v539),
														["DOTDuration"] = 3.5
													}
													v540(v541)
												end
											end
										end)
									end
									return
								elseif v_u_314 == "Gojo" then
									local v542 = v_u_315.C:FindFirstChild("DamageVFX")
									if v542 then
										local v543 = v542:Clone()
										v543.CFrame = v_u_318.CFrame
										v543.Anchored = false
										v543.CanCollide = false
										v543.Transparency = 1
										v543.Massless = true
										v543.Parent = workspace
										local v544 = Instance.new("WeldConstraint")
										v544.Part0 = v543
										v544.Part1 = v_u_318
										v544.Parent = v543
										for _, v545 in v543:GetDescendants() do
											if v545:IsA("ParticleEmitter") then
												v545:Emit(v545:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_310:AddItem(v543, 3)
									end
									return
								elseif v_u_314 == "Jinwoo" then
									local v546 = v_u_315.C
									if v546 then
										local v547 = v546:FindFirstChild("EnergySlashes")
										local v548 = v546:FindFirstChild("ShadowVFX")
										if v547 then
											local v_u_549 = v547:Clone()
											v_u_549.CFrame = v_u_318.CFrame * CFrame.new(0, 3.9, 0)
											v_u_549.Anchored = false
											v_u_549.CanCollide = false
											v_u_549.Transparency = 1
											v_u_549.CastShadow = false
											v_u_549.CanQuery = false
											v_u_549.Massless = true
											v_u_549.Parent = workspace
											v_u_310:AddItem(v_u_549, 3.65)
											local v550 = Instance.new("WeldConstraint")
											v550.Part0 = v_u_318
											v550.Part1 = v_u_549
											v550.Parent = v_u_549
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_549
												if v_u_549 and v_u_549.Parent then
													for _, v551 in v_u_549:GetDescendants() do
														if v551:IsA("ParticleEmitter") then
															v551:Emit(v551:GetAttribute("EmitCount") or v551.Rate)
															v551.Enabled = false
														end
													end
												end
											end)
										end
										if v548 then
											local v_u_552 = v548:Clone()
											v_u_552.CFrame = v_u_318.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_552.Anchored = false
											v_u_552.CanCollide = false
											v_u_552.Transparency = 1
											v_u_552.CastShadow = false
											v_u_552.CanQuery = false
											v_u_552.Massless = true
											v_u_552.Parent = workspace
											v_u_310:AddItem(v_u_552, 2.65)
											local v553 = Instance.new("WeldConstraint")
											v553.Part0 = v_u_318
											v553.Part1 = v_u_552
											v553.Parent = v_u_552
											for _, v_u_554 in v_u_552:GetDescendants() do
												if v_u_554:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_554
														local v555 = v_u_554:GetAttribute("EmitDelay") or 0
														if v555 > 0 then
															task.wait(v555)
														end
														v_u_554:Emit(v_u_554:GetAttribute("EmitCount") or v_u_554.Rate)
													end)
												end
											end
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_552
												if v_u_552 and v_u_552.Parent then
													for _, v556 in v_u_552:GetDescendants() do
														if v556:IsA("ParticleEmitter") then
															v556.Enabled = false
														end
													end
												end
											end)
										end
									end
								elseif v_u_314 == "Ragna" then
									local v557 = v_u_315.C
									if v557 then
										local v_u_558 = v557:FindFirstChild("Sword")
										local v_u_559 = v557:FindFirstChild("StartVFX")
										local v_u_560 = v557:FindFirstChild("ExpVFX")
										if v_u_558 then
											local v_u_561 = {}
											local v_u_562 = {}
											for _ = 1, 6 do
												local v563 = 4 + math.random() * 4
												local v564 = (math.random() - 0.5) * 2 * 6
												local v565 = -(3 + math.random() * 3)
												local v566 = {
													["offset"] = Vector3.new(v564, v563, v565)
												}
												table.insert(v_u_561, v566)
											end
											local v_u_567 = 0
											task.spawn(function()
												-- upvalues: (ref) v_u_567, (ref) v_u_318, (copy) v_u_561, (copy) v_u_558, (ref) v_u_310, (copy) v_u_559, (copy) v_u_562
												while v_u_567 < 6 and (v_u_318 and v_u_318.Parent) do
													local v568 = 6 - v_u_567
													local v569 = math.min(2, v568)
													for v570 = 1, v569 do
														local v571 = v_u_561[v_u_567 + v570]
														local v572 = v_u_318.CFrame
														local v573 = v572:VectorToWorldSpace(v571.offset)
														local v574 = v572.Position + v573
														local v575 = v_u_558:Clone()
														v575.CFrame = CFrame.new(v574) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v575.Anchored = true
														v575.CanCollide = false
														v575.CanQuery = false
														v575.Transparency = 0
														v575.Parent = workspace
														v_u_310:AddItem(v575, 3)
														if v_u_559 then
															local v576 = v_u_559:Clone()
															v576.CFrame = v575.CFrame
															v576.Anchored = true
															v576.CanCollide = false
															v576.Transparency = 1
															v576.Parent = workspace
															v_u_310:AddItem(v576, 1)
															for _, v577 in v576:GetDescendants() do
																if v577:IsA("ParticleEmitter") then
																	v577:Emit(v577:GetAttribute("EmitCount") or 20)
																end
															end
														end
														local v578 = v_u_562
														table.insert(v578, {
															["sword"] = v575,
															["spawnData"] = v571
														})
													end
													v_u_567 = v_u_567 + v569
													task.wait(0.25)
												end
											end)
											local v579 = game:GetService("RunService")
											local v_u_580 = nil
											v_u_580 = v579.Heartbeat:Connect(function()
												-- upvalues: (ref) v_u_318, (ref) v_u_580, (copy) v_u_562
												if v_u_318 and v_u_318.Parent then
													local v581 = (1 / 0)
													local v582 = nil
													for _, v583 in ipairs(game.Players:GetPlayers()) do
														if v583.Character and v583.Character:FindFirstChild("HumanoidRootPart") then
															local v584 = v583.Character.HumanoidRootPart
															local v585 = (v584.Position - v_u_318.Position).Magnitude
															if v585 < v581 and v585 < 150 then
																v582 = v584.Position
																v581 = v585
															end
														end
													end
													for _, v586 in ipairs(v_u_562) do
														local v587 = v586.sword
														if v587 and (v587.Parent and not v586.launched) then
															local v588 = v587.Position
															local v589
															if v582 then
																local v590 = v582 - v588
																if v590.Magnitude > 0.1 then
																	local v591 = v590.Unit
																	v589 = CFrame.lookAt(v588, v588 + v591) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793)
																else
																	v589 = CFrame.new(v588) * CFrame.Angles(1.5707963267948966, 0, 0)
																end
															else
																v589 = CFrame.new(v588) * v_u_318.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v587.CFrame = v587.CFrame:Lerp(v589, 0.12)
														end
													end
												elseif v_u_580 then
													v_u_580:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_580, (ref) v_u_318, (copy) v_u_562, (copy) v_u_560, (ref) v_u_310
												if v_u_580 then
													v_u_580:Disconnect()
												end
												if v_u_318 and v_u_318.Parent then
													local v592 = v_u_318.Position + v_u_318.CFrame.LookVector * 30
													local v593 = (1 / 0)
													for _, v594 in ipairs(game.Players:GetPlayers()) do
														if v594.Character and v594.Character:FindFirstChild("HumanoidRootPart") then
															local v595 = v594.Character.HumanoidRootPart
															local v596 = (v595.Position - v_u_318.Position).Magnitude
															if v596 < v593 and v596 < 150 then
																v592 = v595.Position
																v593 = v596
															end
														end
													end
													local v_u_597 = CFrame.new(v592)
													for v598, v_u_599 in ipairs(v_u_562) do
														task.delay((v598 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_599, (copy) v_u_597, (ref) v_u_560, (ref) v_u_310
															local v_u_600 = v_u_599.sword
															if v_u_600 and v_u_600.Parent then
																v_u_599.launched = true
																local v_u_601 = v_u_600.Position
																local v602 = v_u_597.Position
																local v603 = math.random(-8, 8)
																local v604 = math.random
																local v_u_605 = v602 + Vector3.new(v603, 0, v604(-8, 8))
																local v606 = (v_u_601 + v_u_605) / 2
																local v607 = math.random(-60, 60)
																local v608 = math.rad(v607)
																local v609 = 12 + math.random() * 5
																local v610 = math.sin(v608) * 5
																local v611 = math.cos(v608) * 5
																local v_u_612 = v606 + Vector3.new(v610, v609, v611)
																local v_u_613 = tick()
																task.spawn(function()
																	-- upvalues: (copy) v_u_613, (copy) v_u_601, (copy) v_u_612, (copy) v_u_605, (copy) v_u_600, (ref) v_u_560, (ref) v_u_310
																	while tick() - v_u_613 < 0.4 do
																		local v614 = (tick() - v_u_613) / 0.4
																		local v615 = v_u_601
																		local v616 = v_u_612
																		local v617 = v_u_605
																		local v618 = 1 - v614
																		local v619 = v618 * v618 * v615 + 2 * v618 * v614 * v616 + v614 * v614 * v617
																		local v620 = v614 + 0.05
																		local v621 = math.min(v620, 1)
																		local v622 = v_u_601
																		local v623 = v_u_612
																		local v624 = v_u_605
																		local v625 = 1 - v621
																		local v626 = v625 * v625 * v622 + 2 * v625 * v621 * v623 + v621 * v621 * v624 - v619
																		if v_u_600 and (v_u_600.Parent and v626.Magnitude > 0.01) then
																			v_u_600.CFrame = CFrame.lookAt(v619, v619 + v626.Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
																		end
																		task.wait()
																	end
																	if v_u_560 and (v_u_600 and v_u_600.Parent) then
																		local v627 = v_u_560:Clone()
																		v627.CFrame = CFrame.new(v_u_605)
																		v627.Anchored = true
																		v627.CanCollide = false
																		v627.Transparency = 1
																		v627.Parent = workspace
																		v_u_310:AddItem(v627, 1.5)
																		for _, v628 in v627:GetDescendants() do
																			if v628:IsA("ParticleEmitter") then
																				v628:Emit(v628:GetAttribute("EmitCount") or 30)
																			end
																		end
																	end
																	if v_u_600 and v_u_600.Parent then
																		v_u_600:Destroy()
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
									local v_u_629 = v_u_315.C
									if v_u_629 then
										local v_u_630 = {}
										local function v_u_636(p631, p632)
											-- upvalues: (ref) v_u_318, (ref) v_u_310
											if not p631 then
												return nil
											end
											local v633 = p631:Clone()
											v633.CFrame = v_u_318.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v633.Anchored = false
											v633.CanCollide = false
											v633.Transparency = 1
											v633.CastShadow = false
											v633.CanQuery = false
											v633.Massless = true
											v633.Parent = workspace
											v_u_310:AddItem(v633, p632)
											local v634 = Instance.new("WeldConstraint")
											v634.Part0 = v_u_318
											v634.Part1 = v633
											v634.Parent = v633
											for _, v635 in v633:GetDescendants() do
												if v635:IsA("ParticleEmitter") or (v635:IsA("Beam") or v635:IsA("Trail")) then
													v635.Enabled = true
												end
											end
											return v633
										end
										local v637 = v_u_636(v_u_629:FindFirstChild("ChargeVFX"), 4)
										if v637 then
											table.insert(v_u_630, v637)
										end
										local v638 = v_u_636(v_u_629:FindFirstChild("AuraVFX1"), 4)
										if v638 then
											table.insert(v_u_630, v638)
										end
										task.delay(0.25, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_636, (copy) v_u_629, (copy) v_u_630
											if v_u_318 and v_u_318.Parent then
												local v639 = v_u_636(v_u_629:FindFirstChild("AuraVFX2"), 3.75)
												if v639 then
													local v640 = v_u_630
													table.insert(v640, v639)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_636, (copy) v_u_629, (copy) v_u_630
											if v_u_318 and v_u_318.Parent then
												local v641 = v_u_636(v_u_629:FindFirstChild("AuraVFX3"), 3.5)
												if v641 then
													local v642 = v_u_630
													table.insert(v642, v641)
												end
											end
										end)
										task.delay(3, function()
											-- upvalues: (copy) v_u_630
											for _, v643 in pairs(v_u_630) do
												if v643 and v643.Parent then
													for _, v644 in v643:GetDescendants() do
														if v644:IsA("ParticleEmitter") or (v644:IsA("Beam") or v644:IsA("Trail")) then
															v644.Enabled = false
														end
													end
												end
											end
										end)
									end
								elseif v_u_314 == "Rimuru" then
									return
								else
									local v645 = v_u_315.C:FindFirstChild("FirstEffects")
									if v645 then
										local v_u_646 = v645:Clone()
										for _, v647 in v_u_646:GetDescendants() do
											if v647:IsA("BasePart") then
												v647.Anchored = true
												v647.CanCollide = false
												v647.CanQuery = false
												v647.CanTouch = false
												v647.CastShadow = false
												v647.Transparency = 1
											end
										end
										v_u_646:PivotTo(v_u_318.CFrame * CFrame.new(0, -2, 0))
										v_u_646.Parent = workspace
										v_u_310:AddItem(v_u_646, 6)
										task.delay(4.85, function()
											-- upvalues: (copy) v_u_646
											for _, v648 in v_u_646:GetDescendants() do
												if v648:IsA("ParticleEmitter") then
													v648.Enabled = false
												end
											end
										end)
									end
									task.wait(3.85)
									if v_u_318 and v_u_318.Parent then
										local v_u_649 = v_u_318.CFrame
										local v650 = v_u_315.C:FindFirstChild("HorizontalBeam")
										if v650 then
											local v651 = v650:Clone()
											for _, v652 in v651:GetDescendants() do
												if v652:IsA("BasePart") then
													v652.Anchored = true
													v652.CanCollide = false
													v652.CanQuery = false
													v652.CanTouch = false
													v652.CastShadow = false
													v652.Massless = true
													v652.Transparency = 1
												end
												if v652:IsA("Beam") then
													v652.Enabled = false
												end
											end
											v651:PivotTo(v_u_649 * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0))
											v651.Parent = workspace
											v_u_310:AddItem(v651, 6)
											local v653 = {
												["BigBeam1"] = 0,
												["BigBeam2"] = 0.25,
												["BigBeams3"] = 0.5
											}
											local v654 = {
												["BigBeam1"] = 0.36,
												["BigBeam2"] = 0.61,
												["BigBeams3"] = 0.76
											}
											for _, v_u_655 in v651:GetChildren() do
												if v_u_655:IsA("Model") then
													local v_u_656 = v_u_655:FindFirstChild("Beam")
													local v657 = v653[v_u_655.Name] or 0
													local v658 = v654[v_u_655.Name] or 2
													task.delay(v657, function()
														-- upvalues: (copy) v_u_656, (ref) v_u_330, (copy) v_u_655
														if v_u_656 then
															v_u_330(v_u_656, 0.3)
														end
														for _, v659 in v_u_655:GetDescendants() do
															if v659:IsA("ParticleEmitter") and not (v_u_656 and v659:IsDescendantOf(v_u_656)) then
																v659:Emit(v659:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v658, function()
														-- upvalues: (copy) v_u_656, (ref) v_u_336
														if v_u_656 then
															v_u_336(v_u_656, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_315, (copy) v_u_649, (ref) v_u_310, (ref) v_u_336
											if v_u_318 and v_u_318.Parent then
												local v660 = v_u_315.C:FindFirstChild("Explosion")
												if v660 then
													local v_u_661 = v660:Clone()
													for _, v662 in v_u_661:GetDescendants() do
														if v662:IsA("BasePart") then
															v662.Anchored = true
															v662.CanCollide = false
															v662.CanQuery = false
															v662.CanTouch = false
															v662.CastShadow = false
															v662.Transparency = 1
														end
													end
													v_u_661:PivotTo(v_u_649 * CFrame.new(0, 8, -75) * CFrame.Angles(0, 0, 1.5707963267948966))
													v_u_661.Parent = workspace
													v_u_310:AddItem(v_u_661, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_336, (copy) v_u_661
														v_u_336(v_u_661, 0.5)
														for _, v663 in v_u_661:GetDescendants() do
															if v663:IsA("ParticleEmitter") then
																v663.Enabled = false
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
									local v664 = v_u_315:FindFirstChild("C")
									if v664 then
										local v665 = v664:FindFirstChild("BarrageVFX")
										if v665 then
											local v_u_666 = v665:Clone()
											v_u_666.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_666.Anchored = false
											v_u_666.CanCollide = false
											v_u_666.CanQuery = false
											v_u_666.CanTouch = false
											v_u_666.Transparency = 1
											v_u_666.CastShadow = false
											v_u_666.Parent = workspace
											local v667 = Instance.new("WeldConstraint")
											v667.Part0 = v_u_666
											v667.Part1 = v_u_318
											v667.Parent = v_u_666
											for _, v668 in v_u_666:GetDescendants() do
												if v668:IsA("ParticleEmitter") then
													v668.Enabled = true
												end
											end
											task.delay(3, function()
												-- upvalues: (copy) v_u_666
												if v_u_666 and v_u_666.Parent then
													for _, v669 in v_u_666:GetDescendants() do
														if v669:IsA("ParticleEmitter") then
															v669.Enabled = false
														end
													end
												end
											end)
											v_u_310:AddItem(v_u_666, 4)
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
									local v_u_670 = v_u_315:FindFirstChild("C")
									if v_u_670 then
										local v671 = v_u_670:FindFirstChild("AuraVFX3")
										if v671 then
											local v_u_672 = v671:Clone()
											v_u_672.CFrame = v_u_318.CFrame
											v_u_672.Anchored = false
											v_u_672.CanCollide = false
											v_u_672.Transparency = 1
											v_u_672.Massless = true
											v_u_672.Parent = workspace
											local v673 = Instance.new("WeldConstraint")
											v673.Part0 = v_u_318
											v673.Part1 = v_u_672
											v673.Parent = v_u_672
											for _, v674 in v_u_672:GetDescendants() do
												if v674:IsA("ParticleEmitter") then
													v674.Enabled = true
												end
											end
											task.delay(0.8, function()
												-- upvalues: (copy) v_u_672
												if v_u_672 and v_u_672.Parent then
													for _, v675 in v_u_672:GetDescendants() do
														if v675:IsA("ParticleEmitter") then
															v675.Enabled = false
														end
													end
												end
											end)
											v_u_310:AddItem(v_u_672, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_670, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v676 = v_u_670:FindFirstChild("BlackFlashVFX3")
												if v676 then
													local v677 = v676:Clone()
													v677.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -10)
													v677.Anchored = true
													v677.CanCollide = false
													v677.Transparency = 1
													v677.Parent = workspace
													for _, v678 in v677:GetDescendants() do
														if v678:IsA("ParticleEmitter") then
															v678:Emit(v678:GetAttribute("EmitCount") or v678.Rate)
														end
													end
													v_u_310:AddItem(v677, 3)
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
							local v679 = v_u_71.Alucard
							if v679 and v679["Skill 3"] then
								v679["Skill 3"]({
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
							local v680 = v_u_71.Ichigo
							if v680 and v680["Skill 3"] then
								v680["Skill 3"]({
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
							local v681 = v_u_71.Rimuru
							if v681 and v681["Skill 3"] then
								v681["Skill 3"]({
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
							local v682 = v_u_71.Madoka
							if v682 and v682["Skill 3"] then
								v682["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_317
									},
									["DamageDelay"] = 1.03,
									["Duration"] = 3.97
								})
							end
						end
						if v_u_314 == "Gilgamesh" then
							local v683 = v_u_71.Gilgamesh
							if v683 and v683["Skill 3"] then
								v683["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_317
									},
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_314 == "Anos" then
							local v684 = v_u_71.Anos
							if v684 and v684["Skill 3"] then
								v684["Skill 3"]({
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
									local v685 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v685 then
										v685 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v685 then
										local v686 = require(v685)
										if v686["Skill 4"] then
											local v687 = {
												["Caster"] = {
													["Character"] = v_u_317
												}
											}
											v686["Skill 4"](v687)
										end
									end
									return
								elseif v_u_314 == "StrongestInHistory" then
									local v688 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v688 then
										v688 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v688 then
										local v689 = require(v688)
										if v689["Skill 4"] then
											local v690 = v689["Skill 4"]
											local v691 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["CutsceneDuration"] = 6.5,
												["DamageDelay"] = 5,
												["CharAnimationId"] = "rbxassetid://125013796988038"
											}
											local v692 = v_u_318
											if v692 then
												v692 = v_u_318.CFrame
											end
											v691.CFrame = v692
											v690(v691)
										end
									end
									return
								elseif v_u_314 == "Gojo" then
									local v_u_693 = v_u_315.V
									if v_u_693 then
										local v_u_694 = Instance.new("Attachment")
										v_u_694.Name = "BlueAtt"
										v_u_694.Position = Vector3.new(7, 2, 5)
										v_u_694.Parent = v_u_318
										local v_u_695 = Instance.new("Attachment")
										v_u_695.Name = "RedAtt"
										v_u_695.Position = Vector3.new(-7, 2, 5)
										v_u_695.Parent = v_u_318
										local v_u_696 = nil
										local v_u_697 = nil
										local function v_u_706(p698, p699)
											-- upvalues: (copy) v_u_693, (ref) v_u_318
											local v700 = v_u_693:FindFirstChild(p698)
											if not v700 then
												return nil
											end
											local v701 = v700:Clone()
											v701.CFrame = v_u_318.CFrame * CFrame.new(p699.Position)
											v701.Anchored = true
											v701.CanCollide = false
											v701.Massless = true
											v701.Transparency = 1
											v701.Parent = workspace
											local v702 = Instance.new("Attachment")
											v702.Parent = v701
											local v703 = Instance.new("AlignPosition")
											v703.Attachment0 = v702
											v703.Attachment1 = p699
											v703.RigidityEnabled = false
											v703.Responsiveness = 100
											v703.MaxForce = (1 / 0)
											v703.Parent = v701
											local v704 = Instance.new("AlignOrientation")
											v704.Attachment0 = v702
											v704.Attachment1 = p699
											v704.RigidityEnabled = false
											v704.Responsiveness = 100
											v704.MaxTorque = (1 / 0)
											v704.Parent = v701
											v701.Anchored = false
											for _, v705 in v701:GetDescendants() do
												if v705:IsA("ParticleEmitter") then
													v705.Enabled = true
												elseif v705:IsA("Beam") or v705:IsA("Trail") then
													v705.Enabled = true
												end
											end
											return v701
										end
										local function v_u_710(p707, p708)
											if p707 and p707.Parent then
												for _, v_u_709 in p707:GetDescendants() do
													if v_u_709:IsA("ParticleEmitter") then
														v_u_709.Enabled = false
														if p708 then
															pcall(function()
																-- upvalues: (copy) v_u_709
																v_u_709:Clear()
															end)
														end
													elseif v_u_709:IsA("Beam") or v_u_709:IsA("Trail") then
														v_u_709.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_696, (copy) v_u_706, (copy) v_u_694, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												v_u_696 = v_u_706("Blue", v_u_694)
												if v_u_696 then
													v_u_310:AddItem(v_u_696, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_697, (copy) v_u_706, (copy) v_u_695, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												v_u_697 = v_u_706("Red", v_u_695)
												if v_u_697 then
													v_u_310:AddItem(v_u_697, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_318, (ref) v_u_311, (copy) v_u_694, (copy) v_u_695, (copy) v_u_693, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v711 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_311:Create(v_u_694, v711, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_311:Create(v_u_695, v711, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_318, (ref) v_u_693, (ref) v_u_310
													if v_u_318 and v_u_318.Parent then
														local v712 = v_u_693:FindFirstChild("StarEff")
														if v712 then
															local v713 = v712:Clone()
															v713.CFrame = v_u_318.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v713.Anchored = true
															v713.CanCollide = false
															v713.Transparency = 1
															v713.Parent = workspace
															for _, v714 in v713:GetDescendants() do
																if v714:IsA("ParticleEmitter") then
																	v714:Emit(v714:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_310:AddItem(v713, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_710, (ref) v_u_696, (ref) v_u_697, (copy) v_u_694, (copy) v_u_695, (copy) v_u_693, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												v_u_710(v_u_696, true)
												v_u_710(v_u_697, true)
												if v_u_694 and v_u_694.Parent then
													v_u_694:Destroy()
												end
												if v_u_695 and v_u_695.Parent then
													v_u_695:Destroy()
												end
												local v715 = v_u_693:FindFirstChild("MiniExplosionVFX")
												if v715 then
													local v716 = v715:Clone()
													v716.CFrame = v_u_318.CFrame * CFrame.new(0, 0, -2)
													v716.Anchored = true
													v716.CanCollide = false
													v716.Transparency = 1
													v716.Parent = workspace
													for _, v717 in v716:GetDescendants() do
														if v717:IsA("ParticleEmitter") then
															v717:Emit(v717:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_310:AddItem(v716, 3)
												end
												local v_u_718 = v_u_318.Position + v_u_318.CFrame.LookVector * 6
												local v_u_719 = v_u_318.CFrame.LookVector
												local v720 = v_u_693:FindFirstChild("Purple")
												if v720 then
													local v_u_721 = v720:Clone()
													v_u_721.Anchored = true
													v_u_721.CanCollide = false
													v_u_721.Parent = workspace
													v_u_310:AddItem(v_u_721, 3)
													for _, v722 in v_u_721:GetDescendants() do
														if v722:IsA("ParticleEmitter") then
															v722.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_718, (copy) v_u_721, (copy) v_u_719
														local v723 = v_u_718
														local v724 = 0
														while v724 < 200 and (v_u_721 and v_u_721.Parent) do
															v723 = v723 + v_u_719 * 3.9899999999999998
															v724 = v724 + 3.9899999999999998
															v_u_721.CFrame = CFrame.lookAt(v723, v723 + v_u_719)
															task.wait(0.03)
														end
														for _, v725 in v_u_721:GetDescendants() do
															if v725:IsA("ParticleEmitter") then
																v725.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_314 == "Sukuna" then
									local v_u_726 = v_u_315.V
									if v_u_726 then
										local v727 = (p_u_309.NPCModel or "NPC") .. "_SukunaV"
										local v728 = tick()
										if not v_u_308[v727] or v728 - v_u_308[v727] > 0.5 then
											v_u_308[v727] = v728
											v_u_37:PlayAt("SukunaV_Part1", p_u_309.Position)
										end
										local v729 = v_u_726:FindFirstChild("GroundVFX")
										if v729 then
											local v_u_730 = v729:Clone()
											v_u_730.CFrame = v_u_318.CFrame * CFrame.new(0, -2, 0)
											v_u_730.Anchored = false
											v_u_730.Parent = workspace
											v_u_310:AddItem(v_u_730, 3)
											local v731 = Instance.new("WeldConstraint")
											v731.Part0 = v_u_318
											v731.Part1 = v_u_730
											v731.Parent = v_u_730
											for _, v732 in v_u_730:GetDescendants() do
												if v732:IsA("ParticleEmitter") then
													v732.Enabled = true
													v732:Emit(v732:GetAttribute("EmitCount") or 40)
												elseif v732:IsA("Beam") then
													v732.Enabled = true
												end
											end
											task.delay(2.35, function()
												-- upvalues: (copy) v_u_730
												if v_u_730 and v_u_730.Parent then
													for _, v733 in v_u_730:GetDescendants() do
														if v733:IsA("ParticleEmitter") then
															v733.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_726, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v734 = v_u_726:FindFirstChild("MiniExplosionVFX")
												if v734 then
													local v735 = v734:Clone()
													v735.CFrame = v_u_318.CFrame * CFrame.new(1, 0, 0)
													v735.Anchored = false
													v735.Parent = workspace
													v_u_310:AddItem(v735, 2)
													local v736 = Instance.new("WeldConstraint")
													v736.Part0 = v_u_318
													v736.Part1 = v735
													v736.Parent = v735
													for _, v737 in v735:GetDescendants() do
														if v737:IsA("ParticleEmitter") then
															v737:Emit(v737:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v738 = v_u_726:FindFirstChild("ArrowVFX")
												if v738 then
													local v_u_739 = v738:Clone()
													v_u_739.CFrame = v_u_318.CFrame * CFrame.new(1, 0, 0)
													v_u_739.Anchored = false
													v_u_739.Parent = workspace
													v_u_310:AddItem(v_u_739, 2)
													local v740 = Instance.new("WeldConstraint")
													v740.Part0 = v_u_318
													v740.Part1 = v_u_739
													v740.Parent = v_u_739
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_739
														if v_u_739 and v_u_739.Parent then
															for _, v741 in v_u_739:GetDescendants() do
																if v741:IsA("ParticleEmitter") or v741:IsA("Beam") then
																	v741.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_318, (ref) p_u_309, (ref) v_u_308, (ref) v_u_37, (copy) v_u_726, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v742 = (p_u_309.NPCModel or "NPC") .. "_SukunaV2"
												local v743 = tick()
												if not v_u_308[v742] or v743 - v_u_308[v742] > 0.5 then
													v_u_308[v742] = v743
													v_u_37:PlayAt("SukunaV_Part2", v_u_318.Position)
												end
												local v744 = v_u_318.CFrame.LookVector
												local v745 = v_u_318.Position + v744 * 85
												local v746 = v_u_726:FindFirstChild("ExplosionVFX")
												if v746 then
													local v_u_747 = v746:Clone()
													if v_u_747:IsA("Model") then
														v_u_747:PivotTo(CFrame.new(v745) * CFrame.new(0, 73, 0))
													else
														v_u_747.CFrame = CFrame.new(v745) * CFrame.new(0, 73, 0)
													end
													v_u_747.Parent = workspace
													v_u_310:AddItem(v_u_747, 4)
													for _, v748 in v_u_747:GetDescendants() do
														if v748:IsA("ParticleEmitter") then
															v748.Enabled = true
															v748:Emit(v748:GetAttribute("EmitCount") or 30)
														elseif v748:IsA("Beam") or v748:IsA("Trail") then
															v748.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_747
														if v_u_747 and v_u_747.Parent then
															for _, v749 in v_u_747:GetDescendants() do
																if v749:IsA("ParticleEmitter") or (v749:IsA("Beam") or v749:IsA("Trail")) then
																	v749.Enabled = false
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
									local v_u_750 = v_u_315.V
									if v_u_750 then
										local v751 = v_u_750:FindFirstChild("FirstEffects")
										if v751 then
											local v_u_752 = v751:Clone()
											v_u_752.CFrame = v_u_318.CFrame * CFrame.new(0, -2.5, 0)
											v_u_752.Anchored = false
											v_u_752.CanCollide = false
											v_u_752.Transparency = 1
											v_u_752.CastShadow = false
											v_u_752.CanQuery = false
											v_u_752.Massless = true
											v_u_752.Parent = workspace
											v_u_310:AddItem(v_u_752, 6)
											local v753 = Instance.new("WeldConstraint")
											v753.Part0 = v_u_318
											v753.Part1 = v_u_752
											v753.Parent = v_u_752
											for _, v754 in v_u_752:GetDescendants() do
												if v754:IsA("ParticleEmitter") then
													v754.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_752
												if v_u_752 and v_u_752.Parent then
													for _, v755 in v_u_752:GetDescendants() do
														if v755:IsA("ParticleEmitter") then
															v755.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_318, (copy) v_u_750, (ref) v_u_310
											if v_u_318 and v_u_318.Parent then
												local v756 = v_u_750:FindFirstChild("UltVFX")
												if v756 then
													local v_u_757 = v756:Clone()
													v_u_757:PivotTo(v_u_318.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v758 in v_u_757:GetDescendants() do
														if v758:IsA("BasePart") then
															v758.Anchored = true
															v758.CanCollide = false
															v758.CastShadow = false
															v758.CanQuery = false
														end
													end
													v_u_757.Parent = workspace
													v_u_310:AddItem(v_u_757, 4.5)
													for _, v759 in v_u_757:GetDescendants() do
														if v759:IsA("ParticleEmitter") then
															v759.Enabled = true
														elseif v759:IsA("Beam") then
															v759.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_757
														if v_u_757 and v_u_757.Parent then
															for _, v760 in v_u_757:GetDescendants() do
																if v760:IsA("ParticleEmitter") then
																	v760.Enabled = false
																end
															end
															for _, v_u_761 in v_u_757:GetDescendants() do
																if v_u_761:IsA("Beam") then
																	local v_u_762 = v_u_761.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_762, (copy) v_u_761
																		local v763 = tick()
																		while tick() - v763 < 0.5 do
																			local v764 = (tick() - v763) / 0.5
																			local v765 = {}
																			for _, v766 in ipairs(v_u_762) do
																				local v767 = v766.Value + (1 - v766.Value) * v764
																				local v768 = NumberSequenceKeypoint.new
																				local v769 = v766.Time
																				table.insert(v765, v768(v769, v767))
																			end
																			v_u_761.Transparency = NumberSequence.new(v765)
																			task.wait()
																		end
																		v_u_761.Transparency = NumberSequence.new(1)
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
										local v770 = v_u_71.Ichigo
										if v770 and v770["Skill 4"] then
											local v771 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["CutsceneDuration"] = 8.33,
												["CharAnimationId"] = "rbxassetid://98446587158184",
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v770["Skill 4"](v771)
											return
										end
									elseif v_u_314 == "Alucard" then
										local v772 = v_u_71.Alucard
										if v772 and v772["Skill 4"] then
											local v773 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["AbilityConfig"] = {},
												["CutsceneDuration"] = 5.5,
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v772["Skill 4"](v773)
											return
										end
									elseif v_u_314 == "Rimuru" then
										local v774 = v_u_71.Rimuru
										if v774 and v774["Skill 4"] then
											local v775 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v774["Skill 4"](v775)
											return
										end
									elseif v_u_314 == "Madoka" then
										local v776 = v_u_71.Madoka
										if v776 and v776["Skill 4"] then
											local v777 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["DamageDelay"] = 3.13,
												["Duration"] = 8.63
											}
											v776["Skill 4"](v777)
											return
										end
									elseif v_u_314 == "Gilgamesh" then
										local v778 = v_u_71.Gilgamesh
										if v778 and v778["Skill 4"] then
											local v779 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["AbilityConfig"] = {}
											}
											v778["Skill 4"](v779)
											return
										end
									elseif v_u_314 == "Anos" then
										local v780 = v_u_71.Anos
										if v780 and v780["Skill 4"] then
											local v781 = {
												["Caster"] = {
													["Character"] = v_u_317
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v780["Skill 4"](v781)
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
									local v782 = v_u_71.Rimuru
									if v782 and v782["Skill 5"] then
										local v783 = {
											["Caster"] = {
												["Character"] = v_u_317
											},
											["AbilityConfig"] = {},
											["DisableCutscene"] = true
										}
										v782["Skill 5"](v783)
									end
								end
								if v_u_314 == "Gilgamesh" then
									local v784 = v_u_71.Gilgamesh
									if v784 and v784["Skill 5"] then
										local v785 = {
											["Caster"] = {
												["Character"] = v_u_317
											},
											["AbilityConfig"] = {}
										}
										v784["Skill 5"](v785)
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
	local v_u_787 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p788, p_u_789)
		-- upvalues: (copy) v_u_787, (copy) v_u_786, (copy) v_u_44, (copy) v_u_37, (copy) v_u_301, (copy) v_u_7, (copy) v_u_307, (copy) v_u_4
		if p788 == "SpawnVFX" then
			if p_u_789.IsNPC and (p_u_789.VFXName == "Z" or (p_u_789.VFXName == "X" or (p_u_789.VFXName == "C" or (p_u_789.VFXName == "V" or p_u_789.VFXName == "F")))) then
				local v790 = (p_u_789.NPCModel or "NPC") .. "_" .. p_u_789.VFXName
				local v791 = tick()
				if v_u_787[v790] and v791 - v_u_787[v790] < 1 then
					return
				end
				v_u_787[v790] = v791
				task.spawn(function()
					-- upvalues: (ref) v_u_786, (copy) p_u_789
					v_u_786(p_u_789)
				end)
				local v792 = p_u_789.MovesetType or "Saber"
				if p_u_789.VFXName == "Z" then
					if v792 == "Gojo" then
						local v793 = (p_u_789.NPCModel or "unknown") .. "_Z"
						local v794 = tick()
						local v795
						if v_u_44[v793] and v794 - v_u_44[v793] < 1.5 then
							v795 = false
						else
							v_u_44[v793] = v794
							v795 = true
						end
						if v795 then
							v_u_37:PlayAt("GojoZ", p_u_789.Position)
						end
					elseif v792 == "Sukuna" then
						local v796 = (p_u_789.NPCModel or "unknown") .. "_Z"
						local v797 = tick()
						local v798
						if v_u_44[v796] and v797 - v_u_44[v796] < 1.5 then
							v798 = false
						else
							v_u_44[v796] = v797
							v798 = true
						end
						if v798 then
							v_u_37:PlayAt("SukunaZ", p_u_789.Position)
						end
					elseif v792 == "Jinwoo" then
						local v799 = (p_u_789.NPCModel or "unknown") .. "_Z"
						local v800 = tick()
						local v801
						if v_u_44[v799] and v800 - v_u_44[v799] < 1.5 then
							v801 = false
						else
							v_u_44[v799] = v800
							v801 = true
						end
						if v801 then
							v_u_37:PlayAt("JinwooZ", p_u_789.Position)
						end
					elseif v792 == "Ragna" then
						local v802 = (p_u_789.NPCModel or "unknown") .. "_Z"
						local v803 = tick()
						local v804
						if v_u_44[v802] and v803 - v_u_44[v802] < 1.5 then
							v804 = false
						else
							v_u_44[v802] = v803
							v804 = true
						end
						if v804 then
							v_u_37:PlayAt("RagnaZ", p_u_789.Position)
						end
					elseif v792 == "Aizen" then
						local v805 = (p_u_789.NPCModel or "unknown") .. "_Z"
						local v806 = tick()
						local v807
						if v_u_44[v805] and v806 - v_u_44[v805] < 1.5 then
							v807 = false
						else
							v_u_44[v805] = v806
							v807 = true
						end
						if v807 then
							v_u_37:PlayAt("AizenZ", p_u_789.Position)
						end
					elseif v792 == "QinShi" then
						local v808 = (p_u_789.NPCModel or "unknown") .. "_Z"
						local v809 = tick()
						local v810
						if v_u_44[v808] and v809 - v_u_44[v808] < 1.5 then
							v810 = false
						else
							v_u_44[v808] = v809
							v810 = true
						end
						if v810 then
							v_u_37:PlayAt("QinShiZ", p_u_789.Position)
						end
					elseif v792 == "Yuji" then
						local v811 = (p_u_789.NPCModel or "unknown") .. "_Z"
						local v812 = tick()
						local v813
						if v_u_44[v811] and v812 - v_u_44[v811] < 1.5 then
							v813 = false
						else
							v_u_44[v811] = v812
							v813 = true
						end
						if v813 then
							v_u_37:PlayAt("YujiZ", p_u_789.Position)
						end
					elseif v792 ~= "Alucard" then
						if v792 == "GojoV2" then
							local v814 = (p_u_789.NPCModel or "unknown") .. "_Z"
							local v815 = tick()
							local v816
							if v_u_44[v814] and v815 - v_u_44[v814] < 1.5 then
								v816 = false
							else
								v_u_44[v814] = v815
								v816 = true
							end
							if v816 then
								v_u_37:PlayAt("GojoV2Z", p_u_789.Position)
							end
						elseif v792 ~= "StrongestInHistory" and (v792 ~= "Rimuru" and (v792 ~= "Madoka" and v792 ~= "Anos")) then
							local v817 = (p_u_789.NPCModel or "unknown") .. "_Z"
							local v818 = tick()
							local v819
							if v_u_44[v817] and v818 - v_u_44[v817] < 1.5 then
								v819 = false
							else
								v_u_44[v817] = v818
								v819 = true
							end
							if v819 then
								v_u_37:PlayAt("SaberZ", p_u_789.Position)
							end
						end
					end
				elseif p_u_789.VFXName == "X" then
					if v792 == "Gojo" then
						local v820 = (p_u_789.NPCModel or "unknown") .. "_X"
						local v821 = tick()
						local v822
						if v_u_44[v820] and v821 - v_u_44[v820] < 1.5 then
							v822 = false
						else
							v_u_44[v820] = v821
							v822 = true
						end
						if v822 then
							v_u_37:PlayAt("GojoX", p_u_789.Position)
						end
					elseif v792 == "Sukuna" then
						local v823 = (p_u_789.NPCModel or "unknown") .. "_X"
						local v824 = tick()
						local v825
						if v_u_44[v823] and v824 - v_u_44[v823] < 1.5 then
							v825 = false
						else
							v_u_44[v823] = v824
							v825 = true
						end
						if v825 then
							v_u_37:PlayAt("SukunaX", p_u_789.Position)
						end
					elseif v792 == "Jinwoo" then
						local v826 = (p_u_789.NPCModel or "unknown") .. "_X"
						local v827 = tick()
						local v828
						if v_u_44[v826] and v827 - v_u_44[v826] < 1.5 then
							v828 = false
						else
							v_u_44[v826] = v827
							v828 = true
						end
						if v828 then
							v_u_37:PlayAt("JinwooX", p_u_789.Position)
						end
					elseif v792 == "Ragna" then
						local v829 = (p_u_789.NPCModel or "unknown") .. "_X"
						local v830 = tick()
						local v831
						if v_u_44[v829] and v830 - v_u_44[v829] < 1.5 then
							v831 = false
						else
							v_u_44[v829] = v830
							v831 = true
						end
						if v831 then
							v_u_37:PlayAt("RagnaX", p_u_789.Position)
						end
					elseif v792 == "Aizen" then
						local v832 = (p_u_789.NPCModel or "unknown") .. "_X"
						local v833 = tick()
						local v834
						if v_u_44[v832] and v833 - v_u_44[v832] < 1.5 then
							v834 = false
						else
							v_u_44[v832] = v833
							v834 = true
						end
						if v834 then
							v_u_37:PlayAt("AizenX", p_u_789.Position)
						end
					elseif v792 == "QinShi" then
						local v835 = (p_u_789.NPCModel or "unknown") .. "_X"
						local v836 = tick()
						local v837
						if v_u_44[v835] and v836 - v_u_44[v835] < 1.5 then
							v837 = false
						else
							v_u_44[v835] = v836
							v837 = true
						end
						if v837 then
							v_u_37:PlayAt("QinShiX", p_u_789.Position)
						end
					elseif v792 == "Yuji" then
						local v838 = (p_u_789.NPCModel or "unknown") .. "_X"
						local v839 = tick()
						local v840
						if v_u_44[v838] and v839 - v_u_44[v838] < 1.5 then
							v840 = false
						else
							v_u_44[v838] = v839
							v840 = true
						end
						if v840 then
							v_u_37:PlayAt("YujiX", p_u_789.Position)
						end
					elseif v792 ~= "Ichigo" and v792 ~= "Alucard" then
						if v792 == "GojoV2" then
							local v841 = (p_u_789.NPCModel or "unknown") .. "_X"
							local v842 = tick()
							local v843
							if v_u_44[v841] and v842 - v_u_44[v841] < 1.5 then
								v843 = false
							else
								v_u_44[v841] = v842
								v843 = true
							end
							if v843 then
								v_u_37:PlayAt("GojoV2X", p_u_789.Position)
							end
						elseif v792 ~= "StrongestInHistory" and (v792 ~= "Rimuru" and (v792 ~= "Madoka" and v792 ~= "Anos")) then
							local v844 = (p_u_789.NPCModel or "unknown") .. "_X"
							local v845 = tick()
							local v846
							if v_u_44[v844] and v845 - v_u_44[v844] < 1.5 then
								v846 = false
							else
								v_u_44[v844] = v845
								v846 = true
							end
							if v846 then
								v_u_37:PlayAt("SaberX", p_u_789.Position)
							end
						end
					end
				elseif p_u_789.VFXName == "C" then
					if v792 == "Gojo" then
						local v847 = (p_u_789.NPCModel or "unknown") .. "_C"
						local v848 = tick()
						local v849
						if v_u_44[v847] and v848 - v_u_44[v847] < 1.5 then
							v849 = false
						else
							v_u_44[v847] = v848
							v849 = true
						end
						if v849 then
							v_u_37:PlayAt("GojoC", p_u_789.Position)
							v_u_37:PlayAt("GojoC_Hold", p_u_789.Position)
						end
					elseif v792 == "Jinwoo" then
						local v850 = (p_u_789.NPCModel or "unknown") .. "_C"
						local v851 = tick()
						local v852
						if v_u_44[v850] and v851 - v_u_44[v850] < 1.5 then
							v852 = false
						else
							v_u_44[v850] = v851
							v852 = true
						end
						if v852 then
							v_u_37:PlayAt("JinwooC", p_u_789.Position)
						end
					elseif v792 == "Ragna" then
						local v853 = (p_u_789.NPCModel or "unknown") .. "_C"
						local v854 = tick()
						local v855
						if v_u_44[v853] and v854 - v_u_44[v853] < 1.5 then
							v855 = false
						else
							v_u_44[v853] = v854
							v855 = true
						end
						if v855 then
							v_u_37:PlayAt("RagnaC_Startup", p_u_789.Position)
						end
					elseif v792 == "Aizen" then
						local v856 = (p_u_789.NPCModel or "unknown") .. "_C"
						local v857 = tick()
						local v858
						if v_u_44[v856] and v857 - v_u_44[v856] < 1.5 then
							v858 = false
						else
							v_u_44[v856] = v857
							v858 = true
						end
						if v858 then
							v_u_37:PlayAt("AizenC", p_u_789.Position)
						end
					elseif v792 == "QinShi" then
						local v859 = (p_u_789.NPCModel or "unknown") .. "_C"
						local v860 = tick()
						local v861
						if v_u_44[v859] and v860 - v_u_44[v859] < 1.5 then
							v861 = false
						else
							v_u_44[v859] = v860
							v861 = true
						end
						if v861 then
							v_u_37:PlayAt("QinShiC", p_u_789.Position)
						end
					elseif v792 == "Yuji" then
						local v862 = (p_u_789.NPCModel or "unknown") .. "_C"
						local v863 = tick()
						local v864
						if v_u_44[v862] and v863 - v_u_44[v862] < 1.5 then
							v864 = false
						else
							v_u_44[v862] = v863
							v864 = true
						end
						if v864 then
							v_u_37:PlayAt("YujiC_Press", p_u_789.Position)
						end
					elseif v792 ~= "Ichigo" and (v792 ~= "Alucard" and (v792 ~= "GojoV2" and (v792 ~= "StrongestInHistory" and (v792 ~= "Rimuru" and (v792 ~= "Madoka" and v792 ~= "Anos"))))) then
						local v865 = (p_u_789.NPCModel or "unknown") .. "_C"
						local v866 = tick()
						local v867
						if v_u_44[v865] and v866 - v_u_44[v865] < 1.5 then
							v867 = false
						else
							v_u_44[v865] = v866
							v867 = true
						end
						if v867 then
							v_u_37:PlayAt("SaberC_Cast", p_u_789.Position)
							task.delay(3.85, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_789
								v_u_37:PlayAt("SaberC_Beam", p_u_789.Position)
							end)
							task.delay(4.4, function()
								-- upvalues: (ref) v_u_37, (copy) p_u_789
								v_u_37:PlayAt("SaberC_Explosion", p_u_789.Position)
							end)
						end
					end
				elseif p_u_789.VFXName == "V" then
					if v792 == "Gojo" then
						v_u_37:PlayAt("GojoV", p_u_789.Position)
					elseif v792 ~= "Sukuna" and (v792 ~= "Ichigo" and (v792 ~= "Alucard" and (v792 ~= "GojoV2" and (v792 ~= "StrongestInHistory" and (v792 ~= "Rimuru" and v792 ~= "Madoka"))))) then
						local _ = v792 == "Anos"
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_301, (copy) p_u_789
					v_u_301.SpawnVFX(p_u_789.VFXName, p_u_789.Position, p_u_789.Scale, p_u_789.Duration, p_u_789.AbilityName)
				end)
			end
			if p_u_789.CameraShake then
				task.delay(p_u_789.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_789, (ref) v_u_7
					local v_u_868 = p_u_789.CameraShake.Intensity or 5
					local v_u_869 = p_u_789.CameraShake.Duration or 0.3
					if v_u_7:GetAttribute("DisableScreenShake") then
						return
					else
						local v_u_870 = workspace.CurrentCamera
						if v_u_870 then
							task.spawn(function()
								-- upvalues: (copy) v_u_870, (copy) v_u_869, (copy) v_u_868
								local v871 = tick()
								local _ = v_u_870.CFrame
								while tick() - v871 < v_u_869 do
									local v872 = v_u_868 * (1 - (tick() - v871) / v_u_869)
									local v873 = (math.random() - 0.5) * v872 * 0.1
									local v874 = (math.random() - 0.5) * v872 * 0.1
									v_u_870.CFrame = v_u_870.CFrame * CFrame.new(v873, v874, 0)
									task.wait()
								end
							end)
						end
					end
				end)
			end
			if p_u_789.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_307, (copy) p_u_789
					v_u_307(p_u_789.ScreenFlash)
				end)
				return
			end
		elseif p788 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_301, (copy) p_u_789, (ref) v_u_4
				local v875 = v_u_301.SpawnVFXWithRotation(p_u_789.VFXName, p_u_789.Position, p_u_789.Rotation, p_u_789.Scale, p_u_789.Duration, "KatanaAbilities")
				if v875 then
					v_u_4:AddItem(v875, (p_u_789.Duration or 0.4) + 1)
				end
			end)
			if p_u_789.IsNPC then
				v_u_37:PlayAt("KatanaZ", p_u_789.Position)
			end
			if p_u_789.CameraShake then
				local v_u_876 = p_u_789.CameraShake.Intensity or 3
				local v_u_877 = p_u_789.CameraShake.Duration or 0.2
				if v_u_7:GetAttribute("DisableScreenShake") then
					return
				else
					local v_u_878 = workspace.CurrentCamera
					if v_u_878 then
						task.spawn(function()
							-- upvalues: (copy) v_u_878, (copy) v_u_877, (copy) v_u_876
							local v879 = tick()
							local _ = v_u_878.CFrame
							while tick() - v879 < v_u_877 do
								local v880 = v_u_876 * (1 - (tick() - v879) / v_u_877)
								local v881 = (math.random() - 0.5) * v880 * 0.1
								local v882 = (math.random() - 0.5) * v880 * 0.1
								v_u_878.CFrame = v_u_878.CFrame * CFrame.new(v881, v882, 0)
								task.wait()
							end
						end)
					end
				end
			end
		elseif p788 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_301, (copy) p_u_789, (ref) v_u_4
				local v883 = v_u_301.SpawnTravelingVFX(p_u_789.VFXName, p_u_789.StartPosition, p_u_789.Direction, p_u_789.TravelDistance, p_u_789.TravelSpeed, p_u_789.Scale, p_u_789.Duration, "KatanaAbilities")
				if v883 then
					v_u_4:AddItem(v883, (p_u_789.TravelDistance or 50) / (p_u_789.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_789.CameraShake then
				local v_u_884 = p_u_789.CameraShake.Intensity or 6
				local v_u_885 = p_u_789.CameraShake.Duration or 0.3
				local v_u_886 = not v_u_7:GetAttribute("DisableScreenShake") and workspace.CurrentCamera
				if v_u_886 then
					task.spawn(function()
						-- upvalues: (copy) v_u_886, (copy) v_u_885, (copy) v_u_884
						local v887 = tick()
						local _ = v_u_886.CFrame
						while tick() - v887 < v_u_885 do
							local v888 = v_u_884 * (1 - (tick() - v887) / v_u_885)
							local v889 = (math.random() - 0.5) * v888 * 0.1
							local v890 = (math.random() - 0.5) * v888 * 0.1
							v_u_886.CFrame = v_u_886.CFrame * CFrame.new(v889, v890, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_789.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_307, (copy) p_u_789
					v_u_307(p_u_789.ScreenFlash)
				end)
			end
		end
	end)
	local v891 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_892 = 1
	v891.OnClientEvent:Connect(function(p893)
		-- upvalues: (ref) v_u_892, (copy) v_u_37
		if p893 and p893.Position then
			v_u_37:PlayAt("CombatHit" .. v_u_892, p893.Position)
			v_u_892 = v_u_892 % 7 + 1
		end
	end)
	local v_u_894 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v895 = v46:WaitForChild("HitboxVisualize", 5)
	if v895 then
		v895.OnClientEvent:Connect(function(p896)
			-- upvalues: (copy) v_u_894
			if p896.Type == "Box" then
				v_u_894.ShowBox(p896.CFrame, p896.Size, p896.Duration, p896.Color)
				return
			elseif p896.Type == "Sphere" then
				v_u_894.ShowSphere(p896.Position, p896.Radius, p896.Duration, p896.Color)
				return
			elseif p896.Type == "Traveling" then
				v_u_894.ShowTraveling(p896.StartPos, p896.Direction, p896.Size, p896.Speed, p896.Distance, p896.HitboxType, p896.Color)
			elseif p896.Type == "FollowingAOE" then
				local v897 = p896.Character
				if v897 then
					v_u_894.ShowFollowingAOE(v897, p896.Size, p896.Duration, p896.Offset, p896.Color, p896.Shape)
					return
				end
			else
				if p896.Type == "MultiWave" then
					v_u_894.ShowMultiWave(p896.OriginCFrame, p896.Waves)
					return
				end
				if p896.Type == "Explosion" then
					v_u_894.ShowExplosion(p896.Position, p896.Radius, p896.Duration, p896.Color)
					return
				end
				if p896.Type == "StaticBox" then
					v_u_894.ShowStaticBox(p896.StartPos, p896.EndPos, p896.Width, p896.Height, p896.Duration, p896.Color)
				end
			end
		end)
	end
end)
if not v898 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v899)
	warn("=====================================")
end