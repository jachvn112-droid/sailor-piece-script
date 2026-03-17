local v796, v797 = pcall(function()
	local v_u_1 = game:GetService("Players")
	local v_u_2 = game:GetService("UserInputService")
	local v_u_3 = game:GetService("ReplicatedStorage")
	local v_u_4 = game:GetService("Debris")
	local v_u_5 = game:GetService("TweenService")
	local v_u_6 = game:GetService("RunService")
	local v_u_7 = v_u_1.LocalPlayer
	local v_u_8 = workspace.CurrentCamera
	local function v_u_36(p9)
		-- upvalues: (copy) v_u_7, (copy) v_u_2, (copy) v_u_8
		local v10 = p9 or 30
		local v11 = v_u_7.Character
		local v12
		if v11 then
			v12 = v11:FindFirstChild("HumanoidRootPart")
		else
			v12 = v11
		end
		if not v12 then
			return nil
		end
		local v13 = RaycastParams.new()
		v13.FilterDescendantsInstances = { v11 }
		v13.FilterType = Enum.RaycastFilterType.Exclude
		local v14 = v_u_7:GetMouse()
		local v15 = v_u_2:GetLastInputType()
		local v16
		if v15 == Enum.UserInputType.Touch or v15 == Enum.UserInputType.Gamepad1 then
			local v17 = Vector2.new(v_u_8.ViewportSize.X / 2, v_u_8.ViewportSize.Y / 2)
			v16 = v_u_8:ViewportPointToRay(v17.X, v17.Y)
		else
			v16 = v_u_8:ScreenPointToRay(v14.X, v14.Y)
		end
		local v18 = workspace:Raycast(v16.Origin, v16.Direction * 500, v13)
		local v19 = v18 and v18.Instance:FindFirstAncestorOfClass("Model")
		if v19 then
			local v20 = v19:FindFirstChildOfClass("Humanoid")
			local v21 = v19:FindFirstChild("HumanoidRootPart")
			if v20 and (v21 and (v20.Health > 0 and (v21.Position - v12.Position).Magnitude <= v10)) then
				return v19, v21
			end
		end
		local v22 = v18 and v18.Position or v16.Origin + v16.Direction * v10
		local v23 = v10
		local v24 = nil
		local v25 = nil
		for _, v26 in pairs(game:GetService("Players"):GetPlayers()) do
			if v26 ~= v_u_7 and v26.Character then
				local v27 = v26.Character:FindFirstChild("HumanoidRootPart")
				local v28 = v26.Character:FindFirstChildOfClass("Humanoid")
				if v27 and (v28 and v28.Health > 0) then
					local v29 = (v27.Position - v12.Position).Magnitude
					local v30 = (v27.Position - v22).Magnitude
					if v29 <= v10 and v30 < v23 then
						v24 = v26.Character
						v25 = v27
						v23 = v30
					end
				end
			end
		end
		for _, v31 in pairs(workspace:GetDescendants()) do
			if v31:IsA("Model") and v31:FindFirstChild("HumanoidRootPart") then
				local v32 = v31:FindFirstChildOfClass("Humanoid")
				local v33 = v31:FindFirstChild("HumanoidRootPart")
				if v32 and (v33 and (v32.Health > 0 and v31 ~= v11)) then
					local v34 = (v33.Position - v12.Position).Magnitude
					local v35 = (v33.Position - v22).Magnitude
					if v34 <= v10 and v35 < v23 then
						v25 = v33
						v24 = v31
						v23 = v35
					end
				end
			end
		end
		return v24, v25
	end
	local v_u_37 = v_u_3:WaitForChild("AbilitySystem")
	local v_u_38 = require(v_u_37:WaitForChild("AbilityConfig"))
	local v_u_39 = require(v_u_3:WaitForChild("Modules"):WaitForChild("SoundManager"))
	local v_u_40 = game:GetService("ContentProvider")
	task.spawn(function()
		-- upvalues: (copy) v_u_37, (copy) v_u_40
		local v41 = v_u_37:FindFirstChild("Animations")
		if v41 then
			local v42 = {}
			for _, v43 in pairs(v41:GetChildren()) do
				for _, v44 in pairs(v43:GetDescendants()) do
					if v44:IsA("Animation") then
						table.insert(v42, v44)
					end
				end
			end
			if #v42 > 0 then
				v_u_40:PreloadAsync(v42)
			end
		end
	end)
	local v_u_45 = require(v_u_3:WaitForChild("Modules"):WaitForChild("UIStateManager"))
	local v_u_46 = {}
	local v_u_47 = {
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
		["QinShi"] = { "QinShiZ", "QinShiX", "QinShiC" }
	}
	local v48 = v_u_37:WaitForChild("Remotes")
	local v49 = v_u_37:WaitForChild("VFXHandlers")
	local v_u_50 = v48.RequestAbility
	local v51 = v48.AbilityFeedback
	local v52 = v48:WaitForChild("AbilityStateChanged", 5)
	local v_u_53 = false
	if v52 then
		v52.OnClientEvent:Connect(function(p54)
			-- upvalues: (ref) v_u_53
			v_u_53 = p54
			if p54 == true then
				task.delay(15, function()
					-- upvalues: (ref) v_u_53
					if v_u_53 == true then
						v_u_53 = false
					end
				end)
			end
		end)
	end
	local v_u_55 = require(v_u_3:WaitForChild("CooldownUIManager"))
	local v_u_56 = false
	local v_u_57 = {
		"Z",
		"X",
		"C",
		"V",
		"F",
		"N"
	}
	local v_u_58 = {
		[Enum.KeyCode.ButtonX] = 1,
		[Enum.KeyCode.ButtonY] = 2,
		[Enum.KeyCode.ButtonB] = 3,
		[Enum.KeyCode.DPadUp] = 4
	}
	local v_u_59 = 0
	local function v61()
		-- upvalues: (ref) v_u_56, (copy) v_u_55, (copy) v_u_7
		task.wait(0.1)
		if not v_u_56 and pcall(function()
			-- upvalues: (ref) v_u_55
			v_u_55:Init()
		end) then
			v_u_56 = true
		end
		v_u_7:SetAttribute("FOVEffectActive", false)
		v_u_7:SetAttribute("FOVZoomActive", false)
		local v60 = workspace.CurrentCamera
		if v60 then
			v60.FieldOfView = 70
		end
	end
	v_u_7.CharacterAdded:Connect(v61)
	if v_u_7.Character then
		task.spawn(v61)
	end
	local v_u_62 = v_u_56
	local v_u_63 = {}
	local v64 = 0
	for _, v65 in v49:GetChildren() do
		if v65:IsA("ModuleScript") then
			local v66, v67 = pcall(require, v65)
			if v66 then
				v_u_63[v65.Name] = v67
				v64 = v64 + 1
			else
				warn("[AbilityClient] Failed to load VFX handler:", v65.Name, "Error:", v67)
			end
		end
	end
	local function v_u_72()
		-- upvalues: (copy) v_u_7, (copy) v_u_38
		local v68 = v_u_7.Character
		if not v68 then
			return nil
		end
		local v69 = v68:FindFirstChildOfClass("Tool")
		if not v69 then
			return nil
		end
		for v70, v71 in pairs(v_u_38.Movesets) do
			if v71.ToolName and v71.ToolName == v69.Name then
				return v70
			end
		end
		return nil
	end
	local v_u_73 = {}
	local v_u_74 = nil
	local v_u_75 = 0
	local v_u_76 = nil
	local v_u_77 = nil
	local v_u_78 = 0
	local v_u_79 = 0.5
	local v_u_80 = nil
	local v_u_81 = false
	local v_u_82 = false
	local v_u_83 = {}
	local v_u_84 = false
	local v_u_85 = nil
	local v_u_86 = 0
	local v_u_87 = nil
	local v_u_88 = nil
	local v_u_89 = nil
	local v_u_90 = nil
	local v_u_91 = nil
	local v_u_92 = false
	local v_u_93 = false
	local v_u_94 = nil
	local v_u_95 = nil
	local v_u_96 = nil
	local v_u_97 = nil
	local function v_u_99()
		-- upvalues: (ref) v_u_96, (ref) v_u_97, (ref) v_u_85, (ref) v_u_86, (ref) v_u_87, (ref) v_u_88, (ref) v_u_89, (ref) v_u_94, (ref) v_u_95, (ref) v_u_92, (ref) v_u_93, (ref) v_u_90
		if v_u_96 then
			v_u_96:Stop(0)
			v_u_96 = nil
		end
		if v_u_97 then
			v_u_97:Stop()
			v_u_97 = nil
		end
		v_u_85 = nil
		v_u_86 = 0
		v_u_87 = nil
		v_u_88 = nil
		v_u_89 = nil
		local v98 = workspace.CurrentCamera
		if v98 then
			v98.FieldOfView = 70
		end
		if v_u_94 then
			v_u_94:Destroy()
			v_u_94 = nil
		end
		if v_u_95 then
			v_u_95:Destroy()
			v_u_95 = nil
		end
		v_u_92 = false
		v_u_93 = false
		v_u_90 = nil
	end
	local function v102(p100)
		-- upvalues: (copy) v_u_99
		local v101 = p100:WaitForChild("Humanoid", 5)
		if v101 then
			v101.Died:Connect(function()
				-- upvalues: (ref) v_u_99
				v_u_99()
			end)
		end
	end
	local v103 = v_u_7.Character and v_u_7.Character:WaitForChild("Humanoid", 5)
	if v103 then
		v103.Died:Connect(function()
			-- upvalues: (copy) v_u_99
			v_u_99()
		end)
	end
	v_u_7.CharacterAdded:Connect(v102)
	local function v_u_157(p104)
		-- upvalues: (copy) v_u_1, (ref) v_u_90, (ref) v_u_92, (ref) v_u_93, (copy) v_u_3, (copy) v_u_4, (ref) v_u_95, (copy) v_u_6, (ref) v_u_94, (ref) v_u_85, (ref) v_u_91, (copy) v_u_5, (copy) v_u_7, (ref) v_u_97, (copy) v_u_39
		local v_u_105 = workspace.CurrentCamera
		if v_u_105 then
			local v_u_106 = v_u_1.LocalPlayer.Character
			if v_u_106 then
				local v_u_107 = v_u_106:FindFirstChild("Right Arm") or v_u_106:FindFirstChild("RightHand")
				if v_u_107 and v_u_106:FindFirstChild("HumanoidRootPart") then
					v_u_90 = v_u_105.FieldOfView
					v_u_92 = false
					v_u_93 = false
					local v_u_108 = p104.ChargeTier2Time or 2
					local v_u_109 = p104.ChargeTier3Time or 4
					local v110 = v_u_3.AbilitySystem.VFX.Yuji.C
					local v111 = v110:FindFirstChild("ArmVFX1")
					local v_u_112 = v110:FindFirstChild("ArmVFX2")
					local v_u_113 = v110:FindFirstChild("ArmVFX3")
					local v_u_114 = v110:FindFirstChild("AuraVFX1")
					local v_u_115 = v110:FindFirstChild("AuraVFX2")
					local v_u_116 = v110:FindFirstChild("AuraVFX3")
					local v_u_117 = nil
					local v_u_118 = nil
					local v_u_119 = false
					local function v_u_124(p120)
						-- upvalues: (copy) v_u_107
						if not p120 then
							return nil
						end
						local v121 = p120:Clone()
						v121.CFrame = v_u_107.CFrame * CFrame.new(Vector3.new(0, -1, 0))
						v121.Anchored = false
						v121.CanCollide = false
						v121.CanQuery = false
						v121.CanTouch = false
						v121.Transparency = 1
						v121.Parent = workspace
						local v122 = Instance.new("WeldConstraint")
						v122.Part0 = v121
						v122.Part1 = v_u_107
						v122.Parent = v121
						for _, v123 in v121:GetDescendants() do
							if v123:IsA("ParticleEmitter") then
								v123.Enabled = true
								v123:Emit(v123:GetAttribute("EmitCount") or v123.Rate)
							end
						end
						return v121
					end
					local function v_u_130(p125)
						-- upvalues: (copy) v_u_106
						if not p125 then
							return nil
						end
						local v126 = v_u_106:FindFirstChild("HumanoidRootPart")
						if not v126 then
							return nil
						end
						local v127 = p125:Clone()
						v127.CFrame = v126.CFrame * CFrame.new(Vector3.new(0, -2.95, 0))
						v127.Anchored = false
						v127.CanCollide = false
						v127.CanQuery = false
						v127.CanTouch = false
						v127.Transparency = 1
						v127.Parent = workspace
						local v128 = Instance.new("WeldConstraint")
						v128.Part0 = v127
						v128.Part1 = v126
						v128.Parent = v127
						for _, v129 in v127:GetDescendants() do
							if v129:IsA("ParticleEmitter") then
								v129.Enabled = true
								v129:Emit(v129:GetAttribute("EmitCount") or v129.Rate)
							end
						end
						return v127
					end
					local function v_u_133(p131)
						if p131 then
							for _, v132 in p131:GetDescendants() do
								if v132:IsA("ParticleEmitter") then
									v132.Enabled = false
								end
							end
						end
					end
					v_u_117 = v_u_124(v111)
					v_u_94 = v_u_117
					task.delay(0.15, function()
						-- upvalues: (ref) v_u_85, (ref) v_u_119, (ref) v_u_118, (copy) v_u_130, (copy) v_u_114, (ref) v_u_95
						if v_u_85 then
							if not v_u_119 then
								v_u_119 = true
								v_u_118 = v_u_130(v_u_114)
								v_u_95 = v_u_118
							end
						else
							return
						end
					end)
					local v134 = 4 * v_u_109
					v_u_91 = v_u_5:Create(v_u_105, TweenInfo.new(v_u_109, Enum.EasingStyle.Linear), {
						["FieldOfView"] = v_u_90 + v134
					})
					v_u_91:Play()
					task.spawn(function()
						-- upvalues: (ref) v_u_85, (ref) v_u_92, (copy) v_u_108, (copy) v_u_105, (ref) v_u_6, (copy) v_u_112, (ref) v_u_117, (copy) v_u_124, (copy) v_u_133, (ref) v_u_4, (ref) v_u_94, (copy) v_u_115, (ref) v_u_118, (copy) v_u_130, (ref) v_u_95, (ref) v_u_91, (ref) v_u_5, (copy) v_u_109, (ref) v_u_93, (copy) v_u_113, (copy) v_u_116, (ref) v_u_7, (ref) v_u_97, (ref) v_u_39
						local v135 = tick()
						while v_u_85 do
							local v136 = tick() - v135
							if not v_u_92 and v_u_108 <= v136 then
								v_u_92 = true
								local v_u_137 = 0.3
								local v_u_138 = 6
								task.spawn(function()
									-- upvalues: (copy) v_u_137, (copy) v_u_138, (ref) v_u_105, (ref) v_u_6
									local v139 = tick()
									while tick() - v139 < v_u_137 do
										local v140 = v_u_138 * (1 - (tick() - v139) / v_u_137) * 0.01
										local v141 = (math.random() - 0.5) * 2 * v140
										local v142 = (math.random() - 0.5) * 2 * v140
										v_u_105.CFrame = v_u_105.CFrame * CFrame.new(v141, v142, 0)
										v_u_6.RenderStepped:Wait()
									end
								end)
								local v143 = v_u_117
								v_u_117 = v_u_124(v_u_112)
								if v143 then
									v_u_133(v143)
									v_u_4:AddItem(v143, 0.5)
								end
								v_u_94 = v_u_117
								local v144 = v_u_118
								v_u_118 = v_u_130(v_u_115)
								v_u_95 = v_u_118
								if v144 then
									v_u_133(v144)
									v_u_4:AddItem(v144, 0.5)
								end
								if v_u_91 then
									v_u_91:Pause()
								end
								local v145 = v_u_5:Create(v_u_105, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_105.FieldOfView + 5
								})
								v145:Play()
								v145.Completed:Wait()
								if v_u_85 then
									local v146 = v_u_109 - v136
									local v147 = {
										["FieldOfView"] = v_u_105.FieldOfView + 4 * v146
									}
									v_u_91 = v_u_5:Create(v_u_105, TweenInfo.new(v146, Enum.EasingStyle.Linear), v147)
									v_u_91:Play()
								end
							end
							if not v_u_93 and v_u_109 <= v136 then
								v_u_93 = true
								local v_u_148 = 0.3
								local v_u_149 = 10
								task.spawn(function()
									-- upvalues: (copy) v_u_148, (copy) v_u_149, (ref) v_u_105, (ref) v_u_6
									local v150 = tick()
									while tick() - v150 < v_u_148 do
										local v151 = v_u_149 * (1 - (tick() - v150) / v_u_148) * 0.01
										local v152 = (math.random() - 0.5) * 2 * v151
										local v153 = (math.random() - 0.5) * 2 * v151
										v_u_105.CFrame = v_u_105.CFrame * CFrame.new(v152, v153, 0)
										v_u_6.RenderStepped:Wait()
									end
								end)
								local v154 = v_u_117
								v_u_117 = v_u_124(v_u_113)
								if v154 then
									v_u_133(v154)
									v_u_4:AddItem(v154, 0.5)
								end
								v_u_94 = v_u_117
								local v155 = v_u_118
								v_u_118 = v_u_130(v_u_116)
								v_u_95 = v_u_118
								if v155 then
									v_u_133(v155)
									v_u_4:AddItem(v155, 0.5)
								end
								local v156 = v_u_7.Character
								if v156 then
									v156 = v156:FindFirstChild("HumanoidRootPart")
								end
								v_u_97 = v156 and v_u_39:PlayAt("YujiC_HoldLoop", v156.Position)
								if v_u_97 then
									v_u_97.Looped = true
								end
								if v_u_91 then
									v_u_91:Cancel()
									v_u_91 = nil
								end
								v_u_5:Create(v_u_105, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_105.FieldOfView + 5
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
	local function v_u_162()
		-- upvalues: (ref) v_u_91, (ref) v_u_94, (copy) v_u_4, (ref) v_u_95, (ref) v_u_90, (copy) v_u_5, (ref) v_u_92, (ref) v_u_93
		if v_u_91 then
			v_u_91:Cancel()
			v_u_91 = nil
		end
		if v_u_94 and v_u_94.Parent then
			for _, v158 in v_u_94:GetDescendants() do
				if v158:IsA("ParticleEmitter") then
					v158.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_94, 0.15)
		end
		v_u_94 = nil
		if v_u_95 and v_u_95.Parent then
			for _, v159 in v_u_95:GetDescendants() do
				if v159:IsA("ParticleEmitter") then
					v159.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_95, 0.15)
		end
		v_u_95 = nil
		local v160 = workspace.CurrentCamera
		if v160 and v_u_90 then
			local v161 = {
				["FieldOfView"] = v_u_90
			}
			v_u_5:Create(v160, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v161):Play()
		end
		v_u_90 = nil
		v_u_92 = false
		v_u_93 = false
	end
	local function v_u_172(_, p163, p164, p165, p166)
		local v167 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p166 or "Gojo")
		if v167 then
			v167 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p166 or "Gojo"):FindFirstChild("C")
		end
		if not v167 then
			return nil
		end
		local v168 = v167:FindFirstChild(p163)
		if not v168 then
			return nil
		end
		local v169 = v168:Clone()
		v169.CFrame = p164.CFrame
		v169.Anchored = false
		v169.CanCollide = false
		v169.Transparency = 1
		v169.Parent = workspace
		local v170 = Instance.new("WeldConstraint")
		v170.Part0 = p164
		v170.Part1 = v169
		v170.Parent = v169
		for _, v171 in pairs(v169:GetDescendants()) do
			if v171:IsA("ParticleEmitter") then
				v171.Enabled = true
			end
		end
		game:GetService("Debris"):AddItem(v169, p165)
		return v169
	end
	local function v_u_175()
		-- upvalues: (ref) v_u_83
		for _, v173 in pairs(v_u_83) do
			if v173 and v173.Parent then
				for _, v174 in pairs(v173:GetDescendants()) do
					if v174:IsA("ParticleEmitter") then
						v174.Enabled = false
					end
				end
				game:GetService("Debris"):AddItem(v173, 0.5)
			end
		end
		v_u_83 = {}
	end
	local function v_u_184(p176, p177, p_u_178)
		-- upvalues: (copy) v_u_5
		local v179 = workspace.CurrentCamera
		if v179 then
			local v_u_180 = v179.FieldOfView
			local v181 = {
				["FieldOfView"] = v_u_180 + p176
			}
			v_u_5:Create(v179, TweenInfo.new(p177, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), v181):Play()
			task.delay(p177, function()
				-- upvalues: (ref) v_u_5, (copy) p_u_178, (copy) v_u_180
				local v182 = workspace.CurrentCamera
				if v182 then
					local v183 = {
						["FieldOfView"] = v_u_180
					}
					v_u_5:Create(v182, TweenInfo.new(p_u_178, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v183):Play()
				end
			end)
		end
	end
	local function v_u_195(p185)
		-- upvalues: (copy) v_u_175, (copy) v_u_184, (copy) v_u_172, (ref) v_u_77, (ref) v_u_83
		v_u_175()
		v_u_184(10, 0.12, 0.5)
		task.delay(9.5, function()
			-- upvalues: (ref) v_u_184
			v_u_184(10, 0.12, 0.5)
		end)
		local v186 = p185:FindFirstChild("Torso") or p185:FindFirstChild("UpperTorso")
		local v187 = p185:FindFirstChild("Right Arm") or p185:FindFirstChild("RightUpperArm")
		local v188 = p185:FindFirstChild("Left Arm") or p185:FindFirstChild("LeftUpperArm")
		local v189 = v186 and v_u_172(p185, "DamageVFX", v186, 10, v_u_77)
		if v189 then
			local v190 = v_u_83
			table.insert(v190, v189)
		end
		local v191 = v187 and v_u_172(p185, "ArmVFX", v187, 10, v_u_77)
		if v191 then
			local v192 = v_u_83
			table.insert(v192, v191)
		end
		local v193 = v188 and v_u_172(p185, "ArmVFX", v188, 10, v_u_77)
		if v193 then
			local v194 = v_u_83
			table.insert(v194, v193)
		end
	end
	local function v_u_200(p196)
		-- upvalues: (copy) v_u_175, (ref) v_u_84, (copy) v_u_184, (copy) v_u_172, (ref) v_u_77, (ref) v_u_83
		v_u_175()
		v_u_84 = true
		v_u_184(10, 0.12, 0.5)
		task.delay(5.5, function()
			-- upvalues: (ref) v_u_84, (ref) v_u_184
			if v_u_84 then
				v_u_184(10, 0.12, 0.5)
			end
			v_u_84 = false
		end)
		local v197 = p196:FindFirstChild("Torso") or p196:FindFirstChild("UpperTorso")
		local v198 = v197 and v_u_172(p196, "HealVFX", v197, 6, v_u_77)
		if v198 then
			local v199 = v_u_83
			table.insert(v199, v198)
		end
	end
	v_u_2.InputBegan:Connect(function(p201, p202)
		-- upvalues: (ref) v_u_53, (copy) v_u_45, (copy) v_u_7, (copy) v_u_38, (copy) v_u_58, (ref) v_u_59, (copy) v_u_72, (copy) v_u_3, (copy) v_u_73, (ref) v_u_74, (ref) v_u_75, (ref) v_u_76, (ref) v_u_77, (ref) v_u_78, (ref) v_u_79, (ref) v_u_82, (copy) v_u_195, (ref) v_u_80, (copy) v_u_200, (ref) v_u_81, (copy) v_u_47, (copy) v_u_39, (copy) v_u_50, (ref) v_u_85, (ref) v_u_86, (ref) v_u_87, (ref) v_u_88, (ref) v_u_89, (copy) v_u_157, (ref) v_u_96, (copy) v_u_162, (copy) v_u_36, (copy) v_u_5
		if p202 then
			return
		elseif v_u_53 then
			return
		elseif v_u_45.InArtifactUI then
			return
		else
			local v203 = v_u_7.Character
			if v203 and v203:GetAttribute("InArtifactUI") then
				return
			elseif v203 and v203:GetAttribute("InCutscene") then
				return
			else
				local v204 = v_u_38.Keybinds[p201.KeyCode] or v_u_58[p201.KeyCode]
				if p201.KeyCode == Enum.KeyCode.DPadUp then
					local v205 = tick()
					if v205 - v_u_59 <= 0.3 then
						v204 = 5
						v_u_59 = 0
					else
						v_u_59 = v205
						v204 = 4
					end
				end
				if v204 then
					local v206 = v_u_72()
					if v204 == 5 and v206 == "Shadow" then
						local v_u_207 = false
						pcall(function()
							-- upvalues: (ref) v_u_3, (ref) v_u_207
							local v208 = v_u_3:FindFirstChild("RemoteEvents")
							if v208 then
								v208 = v_u_3.RemoteEvents:FindFirstChild("CheckShadowFUnlocked")
							end
							if v208 then
								v_u_207 = v208:InvokeServer()
							end
						end)
						if not v_u_207 then
							return
						end
					end
					if v206 then
						local v209 = v_u_38.Movesets[v206]
						if v209 and v209.Abilities[v204] then
							local v210 = v209.Abilities[v204]
							if v210.Type == "HoldVariant" then
								local v211 = v_u_73[v206 .. "_" .. v204]
								local v212
								if v211 and tick() < v211 then
									local _ = v211 - tick()
									v212 = true
								else
									v212 = false
								end
								if not v212 then
									v_u_74 = p201.KeyCode
									v_u_75 = tick()
									v_u_76 = v204
									v_u_77 = v206
									v_u_78 = 1
									v_u_79 = v210.HoldThreshold or 0.5
									v_u_82 = false
									local v213 = v_u_7.Character
									if v213 then
										v_u_195(v213)
									end
									if v_u_80 then
										v_u_80:Disconnect()
									end
									v_u_80 = game:GetService("RunService").Heartbeat:Connect(function()
										-- upvalues: (ref) v_u_74, (ref) v_u_80, (ref) v_u_75, (ref) v_u_79, (ref) v_u_78, (ref) v_u_82, (ref) v_u_7, (ref) v_u_200, (ref) v_u_38, (ref) v_u_77, (ref) v_u_76, (ref) v_u_73, (ref) v_u_81, (ref) v_u_47, (ref) v_u_39, (ref) v_u_50
										if v_u_74 then
											if v_u_79 <= tick() - v_u_75 and (v_u_78 == 1 and not v_u_82) then
												v_u_78 = 2
												v_u_82 = true
												local v214 = v_u_7.Character
												if v214 then
													v_u_200(v214)
												end
												local v215 = v_u_38.Movesets[v_u_77]
												if v215 then
													v215 = v215.Abilities[v_u_76]
												end
												if v215 and v215.Cooldown then
													local v216 = v_u_77
													local v217 = v_u_76
													local v218 = v215.Cooldown
													v_u_73[v216 .. "_" .. v217] = tick() + v218
												end
												v_u_81 = true
												local v219 = v_u_77
												local v220 = v_u_76
												local v221 = v_u_47[v219]
												local v222 = v221 and v221[v220]
												if v222 then
													if v220 == 3 then
														v222 = v219 == "Sukuna" and "SukunaC_Hold" or (v219 == "Gojo" and "GojoC_Hold" or v222)
													end
													v_u_39:Play(v222)
												end
												v_u_50:FireServer(v_u_76, {
													["Variant"] = 2
												})
											end
										else
											if v_u_80 then
												v_u_80:Disconnect()
											end
											v_u_80 = nil
										end
									end)
								end
							elseif v210.Type == "ChargedInstant" then
								local v223 = v_u_73[v206 .. "_" .. v204]
								local v224
								if v223 and tick() < v223 then
									local _ = v223 - tick()
									v224 = true
								else
									v224 = false
								end
								if not v224 then
									v_u_85 = p201.KeyCode
									v_u_86 = tick()
									v_u_87 = v204
									v_u_88 = v206
									v_u_89 = v210
									v_u_157(v210)
									if v206 == "Yuji" and v204 == 3 then
										local v225 = v_u_7.Character
										if v225 then
											v225 = v225:FindFirstChild("HumanoidRootPart")
										end
										if v225 then
											v_u_39:PlayAt("YujiC_HoldStart", v225.Position)
										end
										task.delay(0.15, function()
											-- upvalues: (ref) v_u_85, (ref) v_u_87, (ref) v_u_7, (ref) v_u_3, (ref) v_u_96
											if v_u_85 then
												if v_u_87 == 3 then
													local v226 = v_u_7.Character
													if v226 then
														v226 = v226:FindFirstChildOfClass("Humanoid")
													end
													if v226 then
														local v227 = v226:FindFirstChildOfClass("Animator") or Instance.new("Animator", v226)
														local v228 = v_u_3.AbilitySystem.Animations:FindFirstChild("Yuji")
														if v228 then
															v228 = v228:FindFirstChild("Yuji_C_Anim_Hold")
														end
														if v228 then
															if v_u_96 then
																v_u_96:Stop(0)
																v_u_96 = nil
															end
															v_u_96 = v227:LoadAnimation(v228)
															v_u_96.Priority = Enum.AnimationPriority.Action4
															v_u_96.Looped = true
															v_u_96:Play()
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
								local v229 = v_u_73[v206 .. "_" .. v204]
								local v230
								if v229 and tick() < v229 then
									local _ = v229 - tick()
									v230 = true
								else
									v230 = false
								end
								if v230 then
									return
								else
									if v_u_85 then
										v_u_162()
										if v_u_96 then
											v_u_96:Stop(0)
											v_u_96 = nil
										end
										v_u_85 = nil
										v_u_86 = 0
										v_u_87 = nil
										v_u_88 = nil
										v_u_89 = nil
									end
									if v210.Type == "TargetedCutscene" then
										local v231, v232 = v_u_36(v210.TargetRange or 30)
										if v231 then
											local v233 = v_u_73[v206 .. "_" .. v204]
											local v234
											if v233 and tick() < v233 then
												local _ = v233 - tick()
												v234 = true
											else
												v234 = false
											end
											if not v234 then
												v_u_50:FireServer(v204, {
													["TargetName"] = v231.Name,
													["TargetPosition"] = v232.Position
												})
											end
										else
											local v235 = v_u_7:FindFirstChild("PlayerGui")
											if v235 then
												local v_u_236 = Instance.new("ScreenGui")
												v_u_236.Name = "AbilityNotif"
												v_u_236.ResetOnSpawn = false
												v_u_236.Parent = v235
												local v_u_237 = Instance.new("TextLabel")
												v_u_237.Size = UDim2.new(0, 300, 0, 50)
												v_u_237.Position = UDim2.new(0.5, -150, 0.3, 0)
												v_u_237.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
												v_u_237.BackgroundTransparency = 0.3
												v_u_237.BorderSizePixel = 0
												v_u_237.Text = "No target in range!"
												v_u_237.TextColor3 = Color3.fromRGB(255, 100, 100)
												v_u_237.TextSize = 20
												v_u_237.Font = Enum.Font.GothamBold
												v_u_237.Parent = v_u_236
												local v238 = Instance.new("UICorner")
												v238.CornerRadius = UDim.new(0, 8)
												v238.Parent = v_u_237
												task.delay(1.5, function()
													-- upvalues: (copy) v_u_236, (ref) v_u_5, (copy) v_u_237
													if v_u_236 and v_u_236.Parent then
														local v239 = v_u_5:Create(v_u_237, TweenInfo.new(0.5), {
															["BackgroundTransparency"] = 1,
															["TextTransparency"] = 1
														})
														v239:Play()
														v239.Completed:Connect(function()
															-- upvalues: (ref) v_u_236
															v_u_236:Destroy()
														end)
													end
												end)
											end
											return
										end
									else
										if v206 == "Shadow" and v204 == 2 then
											v_u_39:Play("ShadowX_Dash")
										end
										v_u_50:FireServer(v204)
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
	v_u_2.InputEnded:Connect(function(p240, _)
		-- upvalues: (ref) v_u_85, (ref) v_u_86, (ref) v_u_88, (ref) v_u_87, (ref) v_u_89, (copy) v_u_162, (ref) v_u_96, (ref) v_u_97, (copy) v_u_73, (copy) v_u_50, (ref) v_u_74, (ref) v_u_78, (ref) v_u_77, (ref) v_u_76, (ref) v_u_82, (ref) v_u_75, (ref) v_u_79, (ref) v_u_80, (copy) v_u_38, (ref) v_u_81, (copy) v_u_47, (copy) v_u_39
		if v_u_85 and p240.KeyCode == v_u_85 then
			local v241 = tick() - v_u_86
			local v242 = v_u_88
			local v243 = v_u_87
			local v244 = v_u_89
			v_u_162()
			if v_u_96 then
				v_u_96:Stop(0.1)
				v_u_96 = nil
			end
			if v_u_97 then
				v_u_97:Stop()
				v_u_97 = nil
			end
			_G.YujiCharging = false
			v_u_85 = nil
			v_u_86 = 0
			v_u_87 = nil
			v_u_88 = nil
			v_u_89 = nil
			if v242 and (v243 and v244) then
				local v245 = (v244.ChargeTier3Time or 5) <= v241 and 3 or ((v244.ChargeTier2Time or 2.5) <= v241 and 2 or 1)
				if v244.Cooldown then
					local v246 = v244.Cooldown
					v_u_73[v242 .. "_" .. v243] = tick() + v246
				end
				v_u_50:FireServer(v243, {
					["ChargeTier"] = v245,
					["HoldDuration"] = v241
				})
			end
		elseif v_u_74 then
			if p240.KeyCode == v_u_74 then
				local v247 = v_u_77
				local v248 = v_u_76
				local v249 = v_u_82
				v_u_74 = nil
				v_u_75 = 0
				v_u_76 = nil
				v_u_77 = nil
				v_u_78 = 0
				v_u_79 = 0.5
				v_u_82 = false
				if v_u_80 then
					v_u_80:Disconnect()
					v_u_80 = nil
				end
				if v247 and v248 then
					if not v249 then
						local v250 = v_u_38.Movesets[v247]
						if v250 then
							v250 = v250.Abilities[v248]
						end
						if v250 and v250.Cooldown then
							local v251 = v250.Cooldown
							v_u_73[v247 .. "_" .. v248] = tick() + v251
						end
						v_u_81 = true
						local v252 = v_u_47[v247]
						local v253 = v252 and v252[v248]
						if v253 then
							local _ = v248 == 3
							v_u_39:Play(v253)
						end
						v_u_50:FireServer(v248, {
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
	v51.OnClientEvent:Connect(function(p_u_254)
		-- upvalues: (copy) v_u_7, (ref) v_u_84, (copy) v_u_175, (ref) v_u_62, (copy) v_u_55, (copy) v_u_57, (copy) v_u_38, (ref) v_u_53, (copy) v_u_73, (ref) v_u_81, (copy) v_u_47, (copy) v_u_39, (copy) v_u_63
		if p_u_254.Type == "HealingInterrupted" and p_u_254.Caster == v_u_7 then
			v_u_84 = false
			v_u_175()
			return
		elseif p_u_254.Type == "Hit" then
			return
		else
			local v255 = false
			if p_u_254.Caster == v_u_7 and p_u_254.Cooldown then
				if not v_u_62 and pcall(function()
					-- upvalues: (ref) v_u_55
					v_u_55:Init()
				end) then
					v_u_62 = true
				end
				local v256 = p_u_254.MovesetName or "Ability"
				local v257 = v_u_57[p_u_254.Keybind or 1] or "Z"
				v_u_55:StartCooldown(v256, p_u_254.AbilityName, v257, p_u_254.Cooldown)
			end
			if p_u_254.Caster == v_u_7 and (p_u_254.AbilitySlot and p_u_254.MovesetName) then
				local v258 = v_u_38.Movesets[p_u_254.MovesetName]
				if v258 then
					v258 = v258.Abilities[p_u_254.AbilitySlot]
				end
				if v258 then
					local v259
					if v258.Type == "HoldVariant" then
						v259 = false
					else
						v259 = v258.Type ~= "Toggle"
					end
					if v258.AbilityLockDuration == 0 then
						v259 = false
					end
					if v259 then
						v_u_53 = true
						local v260 = (v258.ChargeTime or v258.Duration or (v258.MovementLockDuration or 5)) + 2
						local v261 = math.max(v260, 5)
						task.delay(v261, function()
							-- upvalues: (ref) v_u_53
							if v_u_53 == true then
								v_u_53 = false
							end
						end)
					end
					if p_u_254.Cooldown then
						local v262 = p_u_254.MovesetName
						local v263 = p_u_254.AbilitySlot
						local v264 = p_u_254.Cooldown
						v_u_73[v262 .. "_" .. v263] = tick() + v264
					end
					if v258.Type == "HoldVariant" then
						v255 = v_u_81
					else
						v255 = false
					end
					if not v255 then
						local v265 = p_u_254.MovesetName
						local v266 = p_u_254.AbilitySlot
						local v267 = p_u_254.Variant
						local v268 = v_u_47[v265]
						local v269 = v268 and v268[v266]
						if v269 then
							if v266 == 3 and v267 == 2 then
								v269 = v265 == "Sukuna" and "SukunaC_Hold" or (v265 == "Gojo" and "GojoC_Hold" or v269)
							end
							v_u_39:Play(v269)
						end
					end
					if v258.Type == "HoldVariant" then
						v_u_81 = false
					end
				end
			end
			local v270 = p_u_254.Caster
			local v271 = p_u_254.MovesetName
			local v272 = p_u_254.AbilityName
			if v270 and v270.Character then
				local v273 = v_u_38.Movesets[v271]
				if v273 then
					v273 = v273.Abilities[p_u_254.AbilitySlot]
				end
				if v273 then
					v273 = v273.Type == "HoldVariant"
				end
				if v273 and (p_u_254.Caster == v_u_7 and v255) then
					return
				else
					p_u_254.SkipLocalVFX = v255
					local v274 = v_u_63[v271]
					if v274 then
						local v_u_275 = v274[v272]
						if v_u_275 then
							task.spawn(function()
								-- upvalues: (copy) v_u_275, (copy) p_u_254
								local v276, v277 = pcall(v_u_275, p_u_254)
								if not v276 then
									warn("[AbilityClient] VFX error:", v277)
								end
							end)
						else
							warn("[AbilityClient] No handler for " .. v272)
						end
					else
						warn("[AbilityClient] No VFX handler for moveset " .. v271)
						return
					end
				end
			else
				return
			end
		end
	end)
	local v_u_278 = require(v_u_3:WaitForChild("VFXService"))
	local v_u_279 = game:GetService("TweenService")
	local function v_u_284(p280)
		-- upvalues: (copy) v_u_7, (copy) v_u_279
		local v281 = v_u_7.PlayerGui:FindFirstChild("ScreenEffects")
		if not v281 then
			v281 = Instance.new("ScreenGui")
			v281.Name = "ScreenEffects"
			v281.IgnoreGuiInset = true
			v281.DisplayOrder = 10
			v281.Parent = v_u_7.PlayerGui
		end
		local v_u_282 = Instance.new("Frame")
		v_u_282.Size = UDim2.new(1, 0, 1, 0)
		v_u_282.BackgroundColor3 = p280.Color or Color3.new(1, 1, 1)
		v_u_282.BackgroundTransparency = 0.7
		v_u_282.BorderSizePixel = 0
		v_u_282.Parent = v281
		local v283 = v_u_279:Create(v_u_282, TweenInfo.new(p280.Duration or 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 1
		})
		v283:Play()
		v283.Completed:Connect(function()
			-- upvalues: (copy) v_u_282
			v_u_282:Destroy()
		end)
	end
	local v_u_285 = {}
	local function v_u_690(p_u_286)
		-- upvalues: (copy) v_u_3, (copy) v_u_285, (copy) v_u_39
		local v_u_287 = game:GetService("Debris")
		game:GetService("TweenService")
		local v_u_288 = game:GetService("TweenService")
		local v289 = v_u_3:FindFirstChild("AbilitySystem")
		if v289 then
			local v290 = v289:FindFirstChild("VFX")
			if v290 then
				local v_u_291 = p_u_286.MovesetType or "Saber"
				local v_u_292 = v290:FindFirstChild(v_u_291) or v290:FindFirstChild("Saber")
				if v_u_292 then
					local v293 = p_u_286.Position
					CFrame.new(v293)
					if p_u_286.LookVector then
						CFrame.lookAt(v293, v293 + p_u_286.LookVector)
					end
					local v_u_294 = p_u_286.NPCModel
					if v_u_294 then
						v_u_294 = workspace.NPCs:FindFirstChild(p_u_286.NPCModel) or workspace:FindFirstChild(p_u_286.NPCModel)
					end
					local v_u_295
					if v_u_294 then
						v_u_295 = v_u_294:FindFirstChild("HumanoidRootPart")
					else
						v_u_295 = v_u_294
					end
					local function v_u_301(p296, p297, p298)
						-- upvalues: (copy) v_u_287
						local v299 = p296:Clone()
						v299.CFrame = p297
						v299.Anchored = true
						v299.CanCollide = false
						v299.Transparency = 1
						v299.CastShadow = false
						v299.CanQuery = false
						v299.Parent = workspace
						v_u_287:AddItem(v299, p298)
						for _, v300 in v299:GetDescendants() do
							if v300:IsA("ParticleEmitter") then
								v300:Emit(v300:GetAttribute("EmitCount") or 20)
							end
						end
						return v299
					end
					local function v_u_307(p302, p303)
						-- upvalues: (copy) v_u_288
						local v304 = TweenInfo.new(p303, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						for _, v305 in p302:GetDescendants() do
							if v305:IsA("Beam") then
								local v306 = v305.Width0
								v305.Width0 = 0
								v305.Width1 = 0
								v305.Enabled = true
								v_u_288:Create(v305, v304, {
									["Width0"] = v306,
									["Width1"] = v306
								}):Play()
							end
						end
					end
					local function v_u_313(p308, p309)
						-- upvalues: (copy) v_u_288
						local v310 = TweenInfo.new(p309, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
						for _, v_u_311 in p308:GetDescendants() do
							if v_u_311:IsA("Beam") then
								local v312 = v_u_288:Create(v_u_311, v310, {
									["Width0"] = 0,
									["Width1"] = 0
								})
								v312:Play()
								v312.Completed:Once(function()
									-- upvalues: (copy) v_u_311
									v_u_311.Enabled = false
								end)
							end
						end
					end
					if p_u_286.VFXName == "Z" then
						task.spawn(function()
							-- upvalues: (copy) v_u_295, (copy) v_u_291, (copy) v_u_294, (ref) v_u_292, (copy) v_u_287, (copy) v_u_288, (copy) v_u_301
							if v_u_295 and v_u_295.Parent then
								if v_u_291 == "Gojo" then
									local v_u_314 = v_u_294:FindFirstChild("Right Arm")
									if v_u_314 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_295, (ref) v_u_292, (copy) v_u_314, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												local v315 = v_u_292.Z:FindFirstChild("RedVFXFirst")
												if v315 then
													local v316 = v315:Clone()
													v316.CFrame = v_u_314.CFrame * CFrame.new(0, -1.05, 0)
													v316.Anchored = true
													v316.CanCollide = false
													v316.Transparency = 1
													v316.CastShadow = false
													v316.CanQuery = false
													v316.Parent = workspace
													v_u_287:AddItem(v316, 4)
													for _, v_u_317 in v316:GetDescendants() do
														if v_u_317:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_317
																local v318 = v_u_317:GetAttribute("EmitDelay") or 0
																task.wait(v318)
																v_u_317:Emit(v_u_317:GetAttribute("EmitCount") or v_u_317.Rate)
															end)
														end
													end
													v316.Anchored = false
													local v319 = Instance.new("WeldConstraint")
													v319.Part0 = v_u_314
													v319.Part1 = v316
													v319.Parent = v316
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_295, (ref) v_u_292, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												local v320 = v_u_292.Z:FindFirstChild("RedVFX")
												if v320 then
													local v321 = v320:Clone()
													v321.CFrame = v_u_295.CFrame * CFrame.new(0, 1, -10)
													v321.Anchored = true
													v321.CanCollide = false
													v321.Transparency = 1
													v321.CastShadow = false
													v321.CanQuery = false
													v321.Parent = workspace
													v_u_287:AddItem(v321, 3)
													for _, v_u_322 in v321:GetDescendants() do
														if v_u_322:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_322
																local v323 = v_u_322:GetAttribute("EmitDelay") or 0
																task.wait(v323)
																v_u_322:Emit(v_u_322:GetAttribute("EmitCount") or v_u_322.Rate)
															end)
														end
													end
												end
											else
												return
											end
										end)
									end
								elseif v_u_291 == "Sukuna" then
									local v_u_324 = v_u_292.Z
									if v_u_324 then
										local v325 = v_u_295.Position + Vector3.new(0, 1, 0)
										local v_u_326 = v_u_295.CFrame.LookVector
										local v327 = v_u_324:FindFirstChild("StartExplosionVFX")
										if v327 then
											local v328 = v327:Clone()
											v328.CFrame = CFrame.new(v325) * CFrame.Angles(0, 1.5707963267948966, 0)
											v328.Anchored = true
											v328.CanCollide = false
											v328.Transparency = 1
											v328.Parent = workspace
											v_u_287:AddItem(v328, 3)
											for _, v_u_329 in v328:GetDescendants() do
												task.spawn(function()
													-- upvalues: (copy) v_u_329
													if v_u_329:IsA("ParticleEmitter") then
														local v330 = v_u_329:GetAttribute("EmitDelay") or 0
														if v330 > 0 then
															task.wait(v330)
														end
														v_u_329:Emit(v_u_329:GetAttribute("EmitCount") or v_u_329.Rate)
													end
												end)
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_295, (copy) v_u_326, (copy) v_u_324, (ref) v_u_287, (ref) v_u_288
											if v_u_295 and v_u_295.Parent then
												local v331 = v_u_295.Position + v_u_326 * 3 + Vector3.new(0, 1, 0)
												local v332 = v_u_295.Position + v_u_326 * 65 + Vector3.new(0, 1, 0)
												local v333 = v_u_324:FindFirstChild("DismantleVFX")
												if v333 then
													local v_u_334 = v333:Clone()
													v_u_334.CFrame = CFrame.new(v331, v332)
													v_u_334.Anchored = true
													v_u_334.CanCollide = false
													v_u_334.Transparency = 1
													v_u_334.Parent = workspace
													v_u_287:AddItem(v_u_334, 2)
													for _, v335 in v_u_334:GetDescendants() do
														if v335:IsA("ParticleEmitter") then
															v335.Enabled = true
														end
													end
													v_u_288:Create(v_u_334, TweenInfo.new(1, Enum.EasingStyle.Linear), {
														["CFrame"] = CFrame.new(v332, v332 + v_u_326)
													}):Play()
													task.delay(1, function()
														-- upvalues: (copy) v_u_334
														for _, v336 in v_u_334:GetDescendants() do
															if v336:IsA("ParticleEmitter") then
																v336.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								else
									if v_u_291 == "Ragna" then
										local v337 = v_u_292.Z
										if v337 then
											local v338 = v337:FindFirstChild("DashVFX")
											local v339 = v337:FindFirstChild("SlashesVFX")
											local v340 = v_u_295.CFrame.LookVector
											local v341 = CFrame.lookAt(v_u_295.Position, v_u_295.Position + v340)
											if v338 then
												local v_u_342 = v338:Clone()
												v_u_342.CFrame = v341
												v_u_342.Anchored = false
												v_u_342.CanCollide = false
												v_u_342.Transparency = 1
												v_u_342.CastShadow = false
												v_u_342.CanQuery = false
												v_u_342.Massless = true
												v_u_342.Parent = workspace
												v_u_287:AddItem(v_u_342, 1.5)
												local v343 = Instance.new("WeldConstraint")
												v343.Part0 = v_u_295
												v343.Part1 = v_u_342
												v343.Parent = v_u_342
												for _, v344 in v_u_342:GetDescendants() do
													if v344:IsA("ParticleEmitter") then
														v344.Enabled = true
														v344:Emit(v344:GetAttribute("EmitCount") or 30)
													end
												end
												task.delay(0.5, function()
													-- upvalues: (copy) v_u_342
													if v_u_342 and v_u_342.Parent then
														for _, v345 in v_u_342:GetDescendants() do
															if v345:IsA("ParticleEmitter") then
																v345.Enabled = false
															end
														end
													end
												end)
											end
											if v339 then
												local v346 = v339:Clone()
												v346.CFrame = v341 * CFrame.new(0, 0, -20)
												v346.Anchored = true
												v346.CanCollide = false
												v346.Transparency = 1
												v346.Parent = workspace
												v_u_287:AddItem(v346, 1.5)
												for _, v_u_347 in v346:GetDescendants() do
													if v_u_347:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_347
															local v348 = v_u_347:GetAttribute("EmitDelay") or 0
															if v348 > 0 then
																task.wait(v348)
															end
															v_u_347:Emit(v_u_347:GetAttribute("EmitCount") or v_u_347.Rate)
														end)
													end
												end
												return
											end
										end
									else
										if v_u_291 == "Aizen" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_295, (ref) v_u_292, (ref) v_u_287
												if v_u_295 and v_u_295.Parent then
													local v349 = v_u_292.Z:FindFirstChild("LightningVFX")
													if v349 then
														local v350 = v349:Clone()
														v350.CFrame = v_u_295.CFrame * CFrame.new(0, 0, -5)
														v350.Anchored = true
														v350.CanCollide = false
														v350.Transparency = 1
														v350.CastShadow = false
														v350.CanQuery = false
														v350.Parent = workspace
														v_u_287:AddItem(v350, 3)
														for _, v_u_351 in v350:GetDescendants() do
															if v_u_351:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_351
																	local v352 = v_u_351:GetAttribute("EmitDelay") or 0.05
																	task.delay(v352, function()
																		-- upvalues: (ref) v_u_351
																		v_u_351:Emit(v_u_351:GetAttribute("EmitCount") or v_u_351.Rate)
																	end)
																end)
															end
														end
													end
													local v353 = v_u_292.Z:FindFirstChild("EnergyThrust")
													if v353 then
														local v354 = v353:Clone()
														v354.CFrame = v_u_295.CFrame * CFrame.new(0, 0, -25)
														v354.Anchored = true
														v354.CanCollide = false
														v354.Transparency = 1
														v354.CastShadow = false
														v354.CanQuery = false
														v354.Parent = workspace
														v_u_287:AddItem(v354, 3)
														for _, v_u_355 in v354:GetDescendants() do
															if v_u_355:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_355
																	local v356 = v_u_355:GetAttribute("EmitDelay") or 0.05
																	task.delay(v356, function()
																		-- upvalues: (ref) v_u_355
																		v_u_355:Emit(v_u_355:GetAttribute("EmitCount") or v_u_355.Rate)
																	end)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_291 == "QinShi" then
											task.delay(0.4, function()
												-- upvalues: (ref) v_u_295, (ref) v_u_292, (ref) v_u_287
												if v_u_295 and v_u_295.Parent then
													local v357 = v_u_292.Z:FindFirstChild("PunchVFX")
													if v357 then
														local v358 = v357:Clone()
														v358.CFrame = v_u_295.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
														v358.Anchored = true
														v358.CanCollide = false
														v358.Transparency = 1
														v358.CastShadow = false
														v358.CanQuery = false
														v358.Parent = workspace
														v_u_287:AddItem(v358, 3)
														for _, v_u_359 in v358:GetDescendants() do
															if v_u_359:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_359
																	local v360 = v_u_359:GetAttribute("EmitDelay") or 0
																	task.wait(v360)
																	v_u_359:Emit(v_u_359:GetAttribute("EmitCount") or v_u_359.Rate)
																end)
															end
														end
													end
													local v361 = v_u_292.Z:FindFirstChild("EnergyThrust")
													if v361 then
														local v362 = v361:Clone()
														v362.CFrame = v_u_295.CFrame * CFrame.new(0, 0, -25)
														v362.Anchored = true
														v362.CanCollide = false
														v362.Transparency = 1
														v362.CastShadow = false
														v362.CanQuery = false
														v362.Parent = workspace
														v_u_287:AddItem(v362, 3)
														for _, v_u_363 in v362:GetDescendants() do
															if v_u_363:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_363
																	local v364 = v_u_363:GetAttribute("EmitDelay") or 0
																	task.wait(v364)
																	v_u_363:Emit(v_u_363:GetAttribute("EmitCount") or v_u_363.Rate)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_291 == "Yuji" then
											task.delay(0.3, function()
												-- upvalues: (ref) v_u_295, (ref) v_u_292, (ref) v_u_287
												if v_u_295 and v_u_295.Parent then
													local v365 = v_u_292.Z
													if v365 then
														local v366 = v365:FindFirstChild("SlamVFX")
														if v366 then
															local v367 = v366:Clone()
															v367:PivotTo(v_u_295.CFrame * CFrame.new(0, -1.5, -5))
															v367.Parent = workspace
															v_u_287:AddItem(v367, 3)
															for _, v368 in v367:GetDescendants() do
																if v368:IsA("BasePart") then
																	v368.Anchored = true
																	v368.CanCollide = false
																	v368.CanQuery = false
																end
															end
															for _, v_u_369 in v367:GetDescendants() do
																if v_u_369:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_369
																		local v370 = v_u_369:GetAttribute("EmitDelay") or 0
																		if v370 > 0 then
																			task.wait(v370)
																		end
																		v_u_369:Emit(v_u_369:GetAttribute("EmitCount") or v_u_369.Rate)
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
										task.wait(0.45)
										if not (v_u_295 and v_u_295.Parent) then
											return
										end
										local v371 = v_u_295.CFrame
										local v372 = v_u_292.Z:FindFirstChild("EnergyThrust")
										local v373 = v_u_292.Z:FindFirstChild("EnergyPart")
										if v372 then
											v_u_301(v372, v371 * CFrame.new(0, 2, -35), 3)
										end
										if v373 then
											v_u_301(v373, v371 * CFrame.new(0, 2, -2), 3)
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_286.VFXName == "X" then
						task.spawn(function()
							-- upvalues: (copy) v_u_295, (copy) v_u_291, (copy) v_u_294, (ref) v_u_292, (copy) v_u_287, (copy) v_u_288
							if v_u_295 and v_u_295.Parent then
								if v_u_291 == "Gojo" then
									local v_u_374 = v_u_294:FindFirstChild("Right Arm")
									if v_u_374 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_295, (ref) v_u_292, (copy) v_u_374, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												local v375 = v_u_292.X:FindFirstChild("BlueVFXFirst")
												if v375 then
													local v376 = v375:Clone()
													v376.CFrame = v_u_374.CFrame * CFrame.new(0, -1.05, 0)
													v376.Anchored = true
													v376.CanCollide = false
													v376.Transparency = 1
													v376.CastShadow = false
													v376.CanQuery = false
													v376.Parent = workspace
													v_u_287:AddItem(v376, 4)
													for _, v_u_377 in v376:GetDescendants() do
														if v_u_377:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_377
																local v378 = v_u_377:GetAttribute("EmitDelay") or 0
																task.wait(v378)
																v_u_377:Emit(v_u_377:GetAttribute("EmitCount") or v_u_377.Rate)
															end)
														end
													end
													v376.Anchored = false
													local v379 = Instance.new("WeldConstraint")
													v379.Part0 = v_u_374
													v379.Part1 = v376
													v379.Parent = v376
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_295, (ref) v_u_292, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												local v380 = v_u_295.CFrame
												local v381 = v_u_292.X:FindFirstChild("BlueMainVFX")
												if v381 then
													local v382 = v381:Clone()
													v382.CFrame = v380 * CFrame.new(0, 0, -25)
													v382.Anchored = true
													v382.CanCollide = false
													v382.Transparency = 1
													v382.CastShadow = false
													v382.CanQuery = false
													v382.Parent = workspace
													v_u_287:AddItem(v382, 3)
													for _, v_u_383 in v382:GetDescendants() do
														if v_u_383:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_383
																local v384 = v_u_383:GetAttribute("EmitDelay") or 0
																task.wait(v384)
																v_u_383:Emit(v_u_383:GetAttribute("EmitCount") or v_u_383.Rate)
															end)
														end
													end
												end
												local v385 = v_u_292.X:FindFirstChild("Blue_Additional_VFX")
												if v385 then
													local v386 = v385:Clone()
													v386.CFrame = v380 * CFrame.new(0, 0, -5)
													v386.Anchored = true
													v386.CanCollide = false
													v386.Transparency = 1
													v386.CastShadow = false
													v386.CanQuery = false
													v386.Parent = workspace
													v_u_287:AddItem(v386, 4)
													for _, v_u_387 in v386:GetDescendants() do
														if v_u_387:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_387
																local v388 = v_u_387:GetAttribute("EmitDelay") or 0
																task.wait(v388)
																v_u_387:Emit(v_u_387:GetAttribute("EmitCount") or v_u_387.Rate)
															end)
														end
													end
												end
											end
										end)
									end
								else
									if v_u_291 == "Sukuna" then
										local v389 = v_u_292.X
										if not v389 then
											return
										end
										local v390 = v389:FindFirstChild("GroundVFX")
										if v390 then
											local v_u_391 = v390:Clone()
											v_u_391:PivotTo(v_u_295.CFrame * CFrame.new(0, -2.5, 0))
											v_u_391.Parent = workspace
											v_u_287:AddItem(v_u_391, 3.5)
											local v392 = v_u_391.PrimaryPart or v_u_391:FindFirstChildWhichIsA("BasePart")
											for _, v393 in v_u_391:GetDescendants() do
												if v393:IsA("BasePart") then
													v393.Anchored = false
													v393.CanCollide = false
													v393.CanQuery = false
													v393.CanTouch = false
													v393.Massless = true
												end
											end
											if v392 then
												local v394 = Instance.new("WeldConstraint")
												v394.Part0 = v_u_295
												v394.Part1 = v392
												v394.Parent = v392
											end
											task.delay(2.6, function()
												-- upvalues: (copy) v_u_391
												if v_u_391 and v_u_391.Parent then
													for _, v395 in v_u_391:GetDescendants() do
														if v395:IsA("ParticleEmitter") then
															v395.Enabled = false
														end
													end
												end
											end)
											return
										end
									elseif v_u_291 == "Jinwoo" then
										local v396 = v_u_292.X
										if not v396 then
											return
										end
										local v397 = v396:FindFirstChild("DashVFX")
										local v398 = v396:FindFirstChild("SlashesVFX")
										local v399 = v_u_295.CFrame.LookVector
										local v400 = CFrame.lookAt(v_u_295.Position, v_u_295.Position + v399)
										if v397 then
											local v_u_401 = v397:Clone()
											v_u_401.CFrame = v400
											v_u_401.Anchored = false
											v_u_401.CanCollide = false
											v_u_401.Transparency = 1
											v_u_401.CastShadow = false
											v_u_401.CanQuery = false
											v_u_401.Massless = true
											v_u_401.Parent = workspace
											v_u_287:AddItem(v_u_401, 1.5)
											local v402 = Instance.new("WeldConstraint")
											v402.Part0 = v_u_295
											v402.Part1 = v_u_401
											v402.Parent = v_u_401
											for _, v403 in v_u_401:GetDescendants() do
												if v403:IsA("ParticleEmitter") then
													v403.Enabled = true
													v403:Emit(v403:GetAttribute("EmitCount") or 30)
												end
											end
											task.delay(0.5, function()
												-- upvalues: (copy) v_u_401
												if v_u_401 and v_u_401.Parent then
													for _, v404 in v_u_401:GetDescendants() do
														if v404:IsA("ParticleEmitter") then
															v404.Enabled = false
														end
													end
												end
											end)
										end
										if v398 then
											local v405 = v398:Clone()
											v405.CFrame = v400 * CFrame.new(0, 0, -20)
											v405.Anchored = true
											v405.CanCollide = false
											v405.Transparency = 1
											v405.CastShadow = false
											v405.CanQuery = false
											v405.Parent = workspace
											v_u_287:AddItem(v405, 1.5)
											for _, v_u_406 in v405:GetDescendants() do
												if v_u_406:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_406
														local v407 = v_u_406:GetAttribute("EmitDelay") or 0
														if v407 > 0 then
															task.wait(v407)
														end
														v_u_406:Emit(v_u_406:GetAttribute("EmitCount") or v_u_406.Rate)
													end)
												end
											end
											return
										end
									elseif v_u_291 == "Ragna" then
										local v_u_408 = v_u_292.X
										if v_u_408 then
											local v409 = v_u_408:FindFirstChild("GroundVFX")
											if v409 then
												local v410 = v409:Clone()
												v410.CFrame = v_u_295.CFrame * CFrame.new(0, -2.5, 0)
												v410.Anchored = true
												v410.CanCollide = false
												v410.Transparency = 1
												v410.Parent = workspace
												v_u_287:AddItem(v410, 5)
												for _, v_u_411 in v410:GetDescendants() do
													if v_u_411:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_411
															local v412 = v_u_411:GetAttribute("EmitDelay") or 0
															if v412 > 0 then
																task.wait(v412)
															end
															v_u_411:Emit(v_u_411:GetAttribute("EmitCount") or v_u_411.Rate)
														end)
													end
												end
											end
											local v413 = v_u_408:FindFirstChild("ChargeVFX")
											if v413 then
												local v_u_414 = v413:Clone()
												v_u_414.CFrame = v_u_295.CFrame
												v_u_414.Anchored = false
												v_u_414.CanCollide = false
												v_u_414.Transparency = 1
												v_u_414.Massless = true
												v_u_414.Parent = workspace
												v_u_287:AddItem(v_u_414, 1.3)
												local v415 = Instance.new("WeldConstraint")
												v415.Part0 = v_u_295
												v415.Part1 = v_u_414
												v415.Parent = v_u_414
												for _, v416 in v_u_414:GetDescendants() do
													if v416:IsA("ParticleEmitter") then
														v416.Enabled = true
													end
												end
												task.delay(0.4, function()
													-- upvalues: (copy) v_u_414
													if v_u_414 and v_u_414.Parent then
														for _, v417 in v_u_414:GetDescendants() do
															if v417:IsA("ParticleEmitter") then
																v417.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(0.44999999999999996, function()
												-- upvalues: (ref) v_u_295, (copy) v_u_408, (ref) v_u_287
												if v_u_295 and v_u_295.Parent then
													local v418 = v_u_408:FindFirstChild("BarrageVFX")
													if v418 then
														local v_u_419 = v418:Clone()
														v_u_419.CFrame = v_u_295.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_419.Anchored = true
														v_u_419.CanCollide = false
														v_u_419.Transparency = 1
														v_u_419.Parent = workspace
														v_u_287:AddItem(v_u_419, 2.9)
														for _, v420 in v_u_419:GetDescendants() do
															if v420:IsA("ParticleEmitter") then
																v420.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_419
															if v_u_419 and v_u_419.Parent then
																for _, v421 in v_u_419:GetDescendants() do
																	if v421:IsA("ParticleEmitter") then
																		v421.Enabled = false
																	end
																end
															end
														end)
													end
													local v422 = v_u_408:FindFirstChild("BarrageGroundVFX")
													if v422 then
														local v_u_423 = v422:Clone()
														v_u_423.CFrame = v_u_295.CFrame * CFrame.new(0, -37.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_423.Anchored = true
														v_u_423.CanCollide = false
														v_u_423.Transparency = 1
														v_u_423.Parent = workspace
														v_u_287:AddItem(v_u_423, 2.7)
														for _, v424 in v_u_423:GetDescendants() do
															if v424:IsA("ParticleEmitter") then
																v424.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_423
															if v_u_423 and v_u_423.Parent then
																for _, v425 in v_u_423:GetDescendants() do
																	if v425:IsA("ParticleEmitter") then
																		v425.Enabled = false
																	end
																end
															end
														end)
													end
												end
											end)
											task.delay(2, function()
												-- upvalues: (ref) v_u_295, (copy) v_u_408, (ref) v_u_287
												if v_u_295 and v_u_295.Parent then
													local v426 = v_u_408:FindFirstChild("ChargeVFX")
													if v426 then
														local v_u_427 = v426:Clone()
														v_u_427.CFrame = v_u_295.CFrame
														v_u_427.Anchored = false
														v_u_427.CanCollide = false
														v_u_427.Transparency = 1
														v_u_427.Massless = true
														v_u_427.Parent = workspace
														v_u_287:AddItem(v_u_427, 1)
														local v428 = Instance.new("WeldConstraint")
														v428.Part0 = v_u_295
														v428.Part1 = v_u_427
														v428.Parent = v_u_427
														for _, v429 in v_u_427:GetDescendants() do
															if v429:IsA("ParticleEmitter") then
																v429.Enabled = true
															end
														end
														task.delay(0.6, function()
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
												end
											end)
											return
										end
									else
										if v_u_291 == "Aizen" then
											local v431 = v_u_292.X:FindFirstChild("BarrageVFX")
											if v431 then
												local v_u_432 = v431:Clone()
												v_u_432.CFrame = v_u_295.CFrame * CFrame.new(0, 4, -15)
												v_u_432.Anchored = false
												v_u_432.CanCollide = false
												v_u_432.Transparency = 1
												v_u_432.CastShadow = false
												v_u_432.CanQuery = false
												v_u_432.Massless = true
												v_u_432.Parent = workspace
												v_u_287:AddItem(v_u_432, 3.7)
												local v433 = Instance.new("WeldConstraint")
												v433.Part0 = v_u_295
												v433.Part1 = v_u_432
												v433.Parent = v_u_432
												for _, v434 in v_u_432:GetDescendants() do
													if v434:IsA("ParticleEmitter") or (v434:IsA("Beam") or v434:IsA("Trail")) then
														v434.Enabled = true
													end
												end
												task.delay(1.7, function()
													-- upvalues: (copy) v_u_432
													if v_u_432 and v_u_432.Parent then
														for _, v435 in v_u_432:GetDescendants() do
															if v435:IsA("ParticleEmitter") or (v435:IsA("Beam") or v435:IsA("Trail")) then
																v435.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(1.9, function()
												-- upvalues: (ref) v_u_295, (ref) v_u_292, (ref) v_u_287, (ref) v_u_288
												if not (v_u_295 and v_u_295.Parent) then
													return
												end
												local v436 = { 0, 0 }
												local v437 = {
													{ 180, 180, 135 },
													{ 180, 180, 45 }
												}
												for v438 = 1, 2 do
													if not (v_u_295 and v_u_295.Parent) then
														break
													end
													local v439 = v436[v438]
													local v440 = v437[v438][1]
													local v441 = v437[v438][2]
													local v442 = v437[v438][3]
													local v443 = v_u_295.CFrame * CFrame.Angles(0, math.rad(v439), 0)
													local v444 = v443.Position
													local v445 = v444 + v443.LookVector * 80
													local v446 = CFrame.Angles(math.rad(v440), math.rad(v441), (math.rad(v442)))
													local v447 = CFrame.lookAt(v444, v445) * v446
													local v448 = CFrame.lookAt(v445, v445 + v443.LookVector) * v446
													local v449 = v_u_292.X:FindFirstChild("StartVFX")
													if v449 then
														local v450 = v449:Clone()
														v450.CFrame = v447
														v450.Anchored = true
														v450.CanCollide = false
														v450.Transparency = 1
														v450.Parent = workspace
														v_u_287:AddItem(v450, 2)
														for _, v451 in v450:GetDescendants() do
															if v451:IsA("ParticleEmitter") then
																v451:Emit(v451:GetAttribute("EmitCount") or v451.Rate)
															end
														end
													end
													local v452 = v_u_292.X:FindFirstChild("SlashVFX")
													if v452 then
														local v_u_453 = v452:Clone()
														v_u_453.CFrame = v447
														v_u_453.Anchored = true
														v_u_453.CanCollide = false
														v_u_453.Transparency = 1
														v_u_453.Parent = workspace
														v_u_287:AddItem(v_u_453, 3)
														for _, v454 in v_u_453:GetDescendants() do
															if v454:IsA("ParticleEmitter") or (v454:IsA("Beam") or v454:IsA("Trail")) then
																v454.Enabled = true
															end
														end
														local v455 = v_u_288:Create(v_u_453, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															["CFrame"] = v448
														})
														v455:Play()
														v455.Completed:Connect(function()
															-- upvalues: (copy) v_u_453
															for _, v456 in v_u_453:GetDescendants() do
																if v456:IsA("ParticleEmitter") or (v456:IsA("Beam") or v456:IsA("Trail")) then
																	v456.Enabled = false
																end
															end
														end)
													end
													if v438 < 2 then
														task.wait(0.3)
													end
												end
											end)
											return
										end
										if v_u_291 == "QinShi" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_295, (ref) v_u_292, (ref) v_u_287
												if v_u_295 and v_u_295.Parent then
													local v457 = v_u_292:FindFirstChild("X")
													if v457 then
														local v458 = v457:FindFirstChild("StompVFX")
														if v458 then
															local v459 = v_u_295.Position - Vector3.new(0, 2.5, 0)
															local v460 = v458:Clone()
															local v461 = v460:FindFirstChild("Main")
															local v462 = v460:FindFirstChild("Lightning")
															if v461 then
																v461.CFrame = CFrame.new(v459)
																v461.Anchored = true
																v461.CanCollide = false
																v461.Transparency = 1
															end
															if v462 then
																v462.CFrame = CFrame.new(v459 + Vector3.new(0, 13, 0))
																v462.Anchored = true
																v462.CanCollide = false
																v462.Transparency = 1
															end
															v460.Parent = workspace
															v_u_287:AddItem(v460, 3)
															for _, v_u_463 in v460:GetDescendants() do
																if v_u_463:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_463
																		local v464 = v_u_463:GetAttribute("EmitDelay") or 0
																		task.wait(v464)
																		v_u_463:Emit(v_u_463:GetAttribute("EmitCount") or v_u_463.Rate)
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
										if v_u_291 == "Yuji" then
											local v465 = v_u_292.X
											local v466 = v465 and v465:FindFirstChild("BarrageVFX")
											if v466 then
												local v_u_467 = v466:Clone()
												v_u_467.CFrame = v_u_295.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, -1.5707963267948966, 0)
												v_u_467.Anchored = false
												v_u_467.CanCollide = false
												v_u_467.Transparency = 1
												v_u_467.CastShadow = false
												v_u_467.CanQuery = false
												v_u_467.Massless = true
												v_u_467.Parent = workspace
												v_u_287:AddItem(v_u_467, 4)
												local v468 = Instance.new("WeldConstraint")
												v468.Part0 = v_u_295
												v468.Part1 = v_u_467
												v468.Parent = v_u_467
												for _, v469 in v_u_467:GetDescendants() do
													if v469:IsA("ParticleEmitter") then
														v469.Enabled = true
													end
												end
												task.delay(3.2, function()
													-- upvalues: (copy) v_u_467
													if v_u_467 and v_u_467.Parent then
														for _, v470 in v_u_467:GetDescendants() do
															if v470:IsA("ParticleEmitter") then
																v470.Enabled = false
															end
														end
													end
												end)
												return
											end
										else
											task.wait(0.35)
											if not (v_u_295 and v_u_295.Parent) then
												return
											end
											local v471 = v_u_295.CFrame
											local v472 = v_u_292.X:FindFirstChild("EnergySlashes")
											if not v472 then
												return
											end
											local v_u_473 = v472:Clone()
											v_u_473.CFrame = v471 * CFrame.new(0, 1.5, -20)
											v_u_473.Anchored = false
											v_u_473.CanCollide = false
											v_u_473.Transparency = 1
											v_u_473.CastShadow = false
											v_u_473.CanQuery = false
											v_u_473.Massless = true
											v_u_473.Parent = workspace
											v_u_287:AddItem(v_u_473, 4)
											local v474 = Instance.new("WeldConstraint")
											v474.Part0 = v_u_473
											v474.Part1 = v_u_295
											v474.Parent = v_u_473
											v_u_287:AddItem(v474, 2.06)
											task.delay(2.05, function()
												-- upvalues: (copy) v_u_473
												for _, v475 in v_u_473:GetDescendants() do
													if v475:IsA("ParticleEmitter") then
														v475.Enabled = false
													end
												end
												v_u_473.Anchored = true
											end)
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_286.VFXName == "C" then
						task.spawn(function()
							-- upvalues: (copy) v_u_295, (copy) v_u_291, (ref) v_u_292, (copy) v_u_287, (copy) v_u_307, (copy) v_u_313
							if v_u_295 and v_u_295.Parent then
								if v_u_291 == "Gojo" then
									local v476 = v_u_292.C:FindFirstChild("DamageVFX")
									if v476 then
										local v477 = v476:Clone()
										v477.CFrame = v_u_295.CFrame
										v477.Anchored = false
										v477.CanCollide = false
										v477.Transparency = 1
										v477.Massless = true
										v477.Parent = workspace
										local v478 = Instance.new("WeldConstraint")
										v478.Part0 = v477
										v478.Part1 = v_u_295
										v478.Parent = v477
										for _, v479 in v477:GetDescendants() do
											if v479:IsA("ParticleEmitter") then
												v479:Emit(v479:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_287:AddItem(v477, 3)
									end
									return
								elseif v_u_291 == "Jinwoo" then
									local v480 = v_u_292.C
									if v480 then
										local v481 = v480:FindFirstChild("EnergySlashes")
										local v482 = v480:FindFirstChild("ShadowVFX")
										if v481 then
											local v_u_483 = v481:Clone()
											v_u_483.CFrame = v_u_295.CFrame * CFrame.new(0, 3.9, 0)
											v_u_483.Anchored = false
											v_u_483.CanCollide = false
											v_u_483.Transparency = 1
											v_u_483.CastShadow = false
											v_u_483.CanQuery = false
											v_u_483.Massless = true
											v_u_483.Parent = workspace
											v_u_287:AddItem(v_u_483, 3.65)
											local v484 = Instance.new("WeldConstraint")
											v484.Part0 = v_u_295
											v484.Part1 = v_u_483
											v484.Parent = v_u_483
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_483
												if v_u_483 and v_u_483.Parent then
													for _, v485 in v_u_483:GetDescendants() do
														if v485:IsA("ParticleEmitter") then
															v485:Emit(v485:GetAttribute("EmitCount") or v485.Rate)
															v485.Enabled = false
														end
													end
												end
											end)
										end
										if v482 then
											local v_u_486 = v482:Clone()
											v_u_486.CFrame = v_u_295.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_486.Anchored = false
											v_u_486.CanCollide = false
											v_u_486.Transparency = 1
											v_u_486.CastShadow = false
											v_u_486.CanQuery = false
											v_u_486.Massless = true
											v_u_486.Parent = workspace
											v_u_287:AddItem(v_u_486, 2.65)
											local v487 = Instance.new("WeldConstraint")
											v487.Part0 = v_u_295
											v487.Part1 = v_u_486
											v487.Parent = v_u_486
											for _, v_u_488 in v_u_486:GetDescendants() do
												if v_u_488:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_488
														local v489 = v_u_488:GetAttribute("EmitDelay") or 0
														if v489 > 0 then
															task.wait(v489)
														end
														v_u_488:Emit(v_u_488:GetAttribute("EmitCount") or v_u_488.Rate)
													end)
												end
											end
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_486
												if v_u_486 and v_u_486.Parent then
													for _, v490 in v_u_486:GetDescendants() do
														if v490:IsA("ParticleEmitter") then
															v490.Enabled = false
														end
													end
												end
											end)
										end
									end
								elseif v_u_291 == "Ragna" then
									local v491 = v_u_292.C
									if v491 then
										local v_u_492 = v491:FindFirstChild("Sword")
										local v_u_493 = v491:FindFirstChild("StartVFX")
										local v_u_494 = v491:FindFirstChild("ExpVFX")
										if v_u_492 then
											local v_u_495 = {}
											local v_u_496 = {}
											for _ = 1, 6 do
												local v497 = 4 + math.random() * 4
												local v498 = (math.random() - 0.5) * 2 * 6
												local v499 = -(3 + math.random() * 3)
												local v500 = {
													["offset"] = Vector3.new(v498, v497, v499)
												}
												table.insert(v_u_495, v500)
											end
											local v_u_501 = 0
											task.spawn(function()
												-- upvalues: (ref) v_u_501, (ref) v_u_295, (copy) v_u_495, (copy) v_u_492, (ref) v_u_287, (copy) v_u_493, (copy) v_u_496
												while v_u_501 < 6 and (v_u_295 and v_u_295.Parent) do
													local v502 = 6 - v_u_501
													local v503 = math.min(2, v502)
													for v504 = 1, v503 do
														local v505 = v_u_495[v_u_501 + v504]
														local v506 = v_u_295.CFrame
														local v507 = v506:VectorToWorldSpace(v505.offset)
														local v508 = v506.Position + v507
														local v509 = v_u_492:Clone()
														v509.CFrame = CFrame.new(v508) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v509.Anchored = true
														v509.CanCollide = false
														v509.CanQuery = false
														v509.Transparency = 0
														v509.Parent = workspace
														v_u_287:AddItem(v509, 3)
														if v_u_493 then
															local v510 = v_u_493:Clone()
															v510.CFrame = v509.CFrame
															v510.Anchored = true
															v510.CanCollide = false
															v510.Transparency = 1
															v510.Parent = workspace
															v_u_287:AddItem(v510, 1)
															for _, v511 in v510:GetDescendants() do
																if v511:IsA("ParticleEmitter") then
																	v511:Emit(v511:GetAttribute("EmitCount") or 20)
																end
															end
														end
														local v512 = v_u_496
														table.insert(v512, {
															["sword"] = v509,
															["spawnData"] = v505
														})
													end
													v_u_501 = v_u_501 + v503
													task.wait(0.25)
												end
											end)
											local v513 = game:GetService("RunService")
											local v_u_514 = nil
											v_u_514 = v513.Heartbeat:Connect(function()
												-- upvalues: (ref) v_u_295, (ref) v_u_514, (copy) v_u_496
												if v_u_295 and v_u_295.Parent then
													local v515 = (1 / 0)
													local v516 = nil
													for _, v517 in ipairs(game.Players:GetPlayers()) do
														if v517.Character and v517.Character:FindFirstChild("HumanoidRootPart") then
															local v518 = v517.Character.HumanoidRootPart
															local v519 = (v518.Position - v_u_295.Position).Magnitude
															if v519 < v515 and v519 < 150 then
																v516 = v518.Position
																v515 = v519
															end
														end
													end
													for _, v520 in ipairs(v_u_496) do
														local v521 = v520.sword
														if v521 and (v521.Parent and not v520.launched) then
															local v522 = v521.Position
															local v523
															if v516 then
																local v524 = v516 - v522
																if v524.Magnitude > 0.1 then
																	local v525 = v524.Unit
																	v523 = CFrame.lookAt(v522, v522 + v525) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793)
																else
																	v523 = CFrame.new(v522) * CFrame.Angles(1.5707963267948966, 0, 0)
																end
															else
																v523 = CFrame.new(v522) * v_u_295.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v521.CFrame = v521.CFrame:Lerp(v523, 0.12)
														end
													end
												elseif v_u_514 then
													v_u_514:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_514, (ref) v_u_295, (copy) v_u_496, (copy) v_u_494, (ref) v_u_287
												if v_u_514 then
													v_u_514:Disconnect()
												end
												if v_u_295 and v_u_295.Parent then
													local v526 = v_u_295.Position + v_u_295.CFrame.LookVector * 30
													local v527 = (1 / 0)
													for _, v528 in ipairs(game.Players:GetPlayers()) do
														if v528.Character and v528.Character:FindFirstChild("HumanoidRootPart") then
															local v529 = v528.Character.HumanoidRootPart
															local v530 = (v529.Position - v_u_295.Position).Magnitude
															if v530 < v527 and v530 < 150 then
																v526 = v529.Position
																v527 = v530
															end
														end
													end
													local v_u_531 = CFrame.new(v526)
													for v532, v_u_533 in ipairs(v_u_496) do
														task.delay((v532 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_533, (copy) v_u_531, (ref) v_u_494, (ref) v_u_287
															local v_u_534 = v_u_533.sword
															if v_u_534 and v_u_534.Parent then
																v_u_533.launched = true
																local v_u_535 = v_u_534.Position
																local v536 = v_u_531.Position
																local v537 = math.random(-8, 8)
																local v538 = math.random
																local v_u_539 = v536 + Vector3.new(v537, 0, v538(-8, 8))
																local v540 = (v_u_535 + v_u_539) / 2
																local v541 = math.random(-60, 60)
																local v542 = math.rad(v541)
																local v543 = 12 + math.random() * 5
																local v544 = math.sin(v542) * 5
																local v545 = math.cos(v542) * 5
																local v_u_546 = v540 + Vector3.new(v544, v543, v545)
																local v_u_547 = tick()
																task.spawn(function()
																	-- upvalues: (copy) v_u_547, (copy) v_u_535, (copy) v_u_546, (copy) v_u_539, (copy) v_u_534, (ref) v_u_494, (ref) v_u_287
																	while tick() - v_u_547 < 0.4 do
																		local v548 = (tick() - v_u_547) / 0.4
																		local v549 = v_u_535
																		local v550 = v_u_546
																		local v551 = v_u_539
																		local v552 = 1 - v548
																		local v553 = v552 * v552 * v549 + 2 * v552 * v548 * v550 + v548 * v548 * v551
																		local v554 = v548 + 0.05
																		local v555 = math.min(v554, 1)
																		local v556 = v_u_535
																		local v557 = v_u_546
																		local v558 = v_u_539
																		local v559 = 1 - v555
																		local v560 = v559 * v559 * v556 + 2 * v559 * v555 * v557 + v555 * v555 * v558 - v553
																		if v_u_534 and (v_u_534.Parent and v560.Magnitude > 0.01) then
																			v_u_534.CFrame = CFrame.lookAt(v553, v553 + v560.Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
																		end
																		task.wait()
																	end
																	if v_u_494 and (v_u_534 and v_u_534.Parent) then
																		local v561 = v_u_494:Clone()
																		v561.CFrame = CFrame.new(v_u_539)
																		v561.Anchored = true
																		v561.CanCollide = false
																		v561.Transparency = 1
																		v561.Parent = workspace
																		v_u_287:AddItem(v561, 1.5)
																		for _, v562 in v561:GetDescendants() do
																			if v562:IsA("ParticleEmitter") then
																				v562:Emit(v562:GetAttribute("EmitCount") or 30)
																			end
																		end
																	end
																	if v_u_534 and v_u_534.Parent then
																		v_u_534:Destroy()
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
								elseif v_u_291 == "Aizen" then
									local v_u_563 = v_u_292.C
									if v_u_563 then
										local v_u_564 = {}
										local function v_u_570(p565, p566)
											-- upvalues: (ref) v_u_295, (ref) v_u_287
											if not p565 then
												return nil
											end
											local v567 = p565:Clone()
											v567.CFrame = v_u_295.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v567.Anchored = false
											v567.CanCollide = false
											v567.Transparency = 1
											v567.CastShadow = false
											v567.CanQuery = false
											v567.Massless = true
											v567.Parent = workspace
											v_u_287:AddItem(v567, p566)
											local v568 = Instance.new("WeldConstraint")
											v568.Part0 = v_u_295
											v568.Part1 = v567
											v568.Parent = v567
											for _, v569 in v567:GetDescendants() do
												if v569:IsA("ParticleEmitter") or (v569:IsA("Beam") or v569:IsA("Trail")) then
													v569.Enabled = true
												end
											end
											return v567
										end
										local v571 = v_u_570(v_u_563:FindFirstChild("ChargeVFX"), 4)
										if v571 then
											table.insert(v_u_564, v571)
										end
										local v572 = v_u_570(v_u_563:FindFirstChild("AuraVFX1"), 4)
										if v572 then
											table.insert(v_u_564, v572)
										end
										task.delay(0.25, function()
											-- upvalues: (ref) v_u_295, (copy) v_u_570, (copy) v_u_563, (copy) v_u_564
											if v_u_295 and v_u_295.Parent then
												local v573 = v_u_570(v_u_563:FindFirstChild("AuraVFX2"), 3.75)
												if v573 then
													local v574 = v_u_564
													table.insert(v574, v573)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_295, (copy) v_u_570, (copy) v_u_563, (copy) v_u_564
											if v_u_295 and v_u_295.Parent then
												local v575 = v_u_570(v_u_563:FindFirstChild("AuraVFX3"), 3.5)
												if v575 then
													local v576 = v_u_564
													table.insert(v576, v575)
												end
											end
										end)
										task.delay(3, function()
											-- upvalues: (copy) v_u_564
											for _, v577 in pairs(v_u_564) do
												if v577 and v577.Parent then
													for _, v578 in v577:GetDescendants() do
														if v578:IsA("ParticleEmitter") or (v578:IsA("Beam") or v578:IsA("Trail")) then
															v578.Enabled = false
														end
													end
												end
											end
										end)
									end
								else
									local v579 = v_u_292.C:FindFirstChild("FirstEffects")
									if v579 then
										local v_u_580 = v579:Clone()
										for _, v581 in v_u_580:GetDescendants() do
											if v581:IsA("BasePart") then
												v581.Anchored = true
												v581.CanCollide = false
												v581.CanQuery = false
												v581.CanTouch = false
												v581.CastShadow = false
												v581.Transparency = 1
											end
										end
										v_u_580:PivotTo(v_u_295.CFrame * CFrame.new(0, -2, 0))
										v_u_580.Parent = workspace
										v_u_287:AddItem(v_u_580, 6)
										task.delay(4.85, function()
											-- upvalues: (copy) v_u_580
											for _, v582 in v_u_580:GetDescendants() do
												if v582:IsA("ParticleEmitter") then
													v582.Enabled = false
												end
											end
										end)
									end
									task.wait(3.85)
									if v_u_295 and v_u_295.Parent then
										local v_u_583 = v_u_295.CFrame
										local v584 = v_u_292.C:FindFirstChild("HorizontalBeam")
										if v584 then
											local v585 = v584:Clone()
											for _, v586 in v585:GetDescendants() do
												if v586:IsA("BasePart") then
													v586.Anchored = true
													v586.CanCollide = false
													v586.CanQuery = false
													v586.CanTouch = false
													v586.CastShadow = false
													v586.Massless = true
													v586.Transparency = 1
												end
												if v586:IsA("Beam") then
													v586.Enabled = false
												end
											end
											v585:PivotTo(v_u_583 * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0))
											v585.Parent = workspace
											v_u_287:AddItem(v585, 6)
											local v587 = {
												["BigBeam1"] = 0,
												["BigBeam2"] = 0.25,
												["BigBeams3"] = 0.5
											}
											local v588 = {
												["BigBeam1"] = 0.36,
												["BigBeam2"] = 0.61,
												["BigBeams3"] = 0.76
											}
											for _, v_u_589 in v585:GetChildren() do
												if v_u_589:IsA("Model") then
													local v_u_590 = v_u_589:FindFirstChild("Beam")
													local v591 = v587[v_u_589.Name] or 0
													local v592 = v588[v_u_589.Name] or 2
													task.delay(v591, function()
														-- upvalues: (copy) v_u_590, (ref) v_u_307, (copy) v_u_589
														if v_u_590 then
															v_u_307(v_u_590, 0.3)
														end
														for _, v593 in v_u_589:GetDescendants() do
															if v593:IsA("ParticleEmitter") and not (v_u_590 and v593:IsDescendantOf(v_u_590)) then
																v593:Emit(v593:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v592, function()
														-- upvalues: (copy) v_u_590, (ref) v_u_313
														if v_u_590 then
															v_u_313(v_u_590, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_295, (ref) v_u_292, (copy) v_u_583, (ref) v_u_287, (ref) v_u_313
											if v_u_295 and v_u_295.Parent then
												local v594 = v_u_292.C:FindFirstChild("Explosion")
												if v594 then
													local v_u_595 = v594:Clone()
													for _, v596 in v_u_595:GetDescendants() do
														if v596:IsA("BasePart") then
															v596.Anchored = true
															v596.CanCollide = false
															v596.CanQuery = false
															v596.CanTouch = false
															v596.CastShadow = false
															v596.Transparency = 1
														end
													end
													v_u_595:PivotTo(v_u_583 * CFrame.new(0, 8, -75) * CFrame.Angles(0, 0, 1.5707963267948966))
													v_u_595.Parent = workspace
													v_u_287:AddItem(v_u_595, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_313, (copy) v_u_595
														v_u_313(v_u_595, 0.5)
														for _, v597 in v_u_595:GetDescendants() do
															if v597:IsA("ParticleEmitter") then
																v597.Enabled = false
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
						if v_u_291 == "QinShi" then
							task.spawn(function()
								-- upvalues: (copy) v_u_295, (ref) v_u_292, (copy) v_u_287
								if v_u_295 and v_u_295.Parent then
									local v598 = v_u_292:FindFirstChild("C")
									if v598 then
										local v599 = v598:FindFirstChild("BarrageVFX")
										if v599 then
											local v_u_600 = v599:Clone()
											v_u_600.CFrame = v_u_295.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_600.Anchored = false
											v_u_600.CanCollide = false
											v_u_600.CanQuery = false
											v_u_600.CanTouch = false
											v_u_600.Transparency = 1
											v_u_600.CastShadow = false
											v_u_600.Parent = workspace
											local v601 = Instance.new("WeldConstraint")
											v601.Part0 = v_u_600
											v601.Part1 = v_u_295
											v601.Parent = v_u_600
											for _, v602 in v_u_600:GetDescendants() do
												if v602:IsA("ParticleEmitter") then
													v602.Enabled = true
												end
											end
											task.delay(3, function()
												-- upvalues: (copy) v_u_600
												if v_u_600 and v_u_600.Parent then
													for _, v603 in v_u_600:GetDescendants() do
														if v603:IsA("ParticleEmitter") then
															v603.Enabled = false
														end
													end
												end
											end)
											v_u_287:AddItem(v_u_600, 4)
										end
									end
								else
									return
								end
							end)
						end
						if v_u_291 == "Yuji" then
							task.spawn(function()
								-- upvalues: (copy) v_u_295, (ref) v_u_292, (copy) v_u_287
								if v_u_295 and v_u_295.Parent then
									local v_u_604 = v_u_292:FindFirstChild("C")
									if v_u_604 then
										local v605 = v_u_604:FindFirstChild("AuraVFX3")
										if v605 then
											local v_u_606 = v605:Clone()
											v_u_606.CFrame = v_u_295.CFrame
											v_u_606.Anchored = false
											v_u_606.CanCollide = false
											v_u_606.Transparency = 1
											v_u_606.Massless = true
											v_u_606.Parent = workspace
											local v607 = Instance.new("WeldConstraint")
											v607.Part0 = v_u_295
											v607.Part1 = v_u_606
											v607.Parent = v_u_606
											for _, v608 in v_u_606:GetDescendants() do
												if v608:IsA("ParticleEmitter") then
													v608.Enabled = true
												end
											end
											task.delay(0.8, function()
												-- upvalues: (copy) v_u_606
												if v_u_606 and v_u_606.Parent then
													for _, v609 in v_u_606:GetDescendants() do
														if v609:IsA("ParticleEmitter") then
															v609.Enabled = false
														end
													end
												end
											end)
											v_u_287:AddItem(v_u_606, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_295, (copy) v_u_604, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												local v610 = v_u_604:FindFirstChild("BlackFlashVFX3")
												if v610 then
													local v611 = v610:Clone()
													v611.CFrame = v_u_295.CFrame * CFrame.new(0, 0, -10)
													v611.Anchored = true
													v611.CanCollide = false
													v611.Transparency = 1
													v611.Parent = workspace
													for _, v612 in v611:GetDescendants() do
														if v612:IsA("ParticleEmitter") then
															v612:Emit(v612:GetAttribute("EmitCount") or v612.Rate)
														end
													end
													v_u_287:AddItem(v611, 3)
												end
											end
										end)
									end
								else
									return
								end
							end)
						end
					elseif p_u_286.VFXName == "V" then
						task.spawn(function()
							-- upvalues: (copy) v_u_295, (copy) v_u_291, (ref) v_u_292, (copy) v_u_287, (copy) v_u_288, (copy) p_u_286, (ref) v_u_285, (ref) v_u_39
							if v_u_295 and v_u_295.Parent then
								if v_u_291 == "Gojo" then
									local v_u_613 = v_u_292.V
									if v_u_613 then
										local v_u_614 = Instance.new("Attachment")
										v_u_614.Name = "BlueAtt"
										v_u_614.Position = Vector3.new(7, 2, 5)
										v_u_614.Parent = v_u_295
										local v_u_615 = Instance.new("Attachment")
										v_u_615.Name = "RedAtt"
										v_u_615.Position = Vector3.new(-7, 2, 5)
										v_u_615.Parent = v_u_295
										local v_u_616 = nil
										local v_u_617 = nil
										local function v_u_626(p618, p619)
											-- upvalues: (copy) v_u_613, (ref) v_u_295
											local v620 = v_u_613:FindFirstChild(p618)
											if not v620 then
												return nil
											end
											local v621 = v620:Clone()
											v621.CFrame = v_u_295.CFrame * CFrame.new(p619.Position)
											v621.Anchored = true
											v621.CanCollide = false
											v621.Massless = true
											v621.Transparency = 1
											v621.Parent = workspace
											local v622 = Instance.new("Attachment")
											v622.Parent = v621
											local v623 = Instance.new("AlignPosition")
											v623.Attachment0 = v622
											v623.Attachment1 = p619
											v623.RigidityEnabled = false
											v623.Responsiveness = 100
											v623.MaxForce = (1 / 0)
											v623.Parent = v621
											local v624 = Instance.new("AlignOrientation")
											v624.Attachment0 = v622
											v624.Attachment1 = p619
											v624.RigidityEnabled = false
											v624.Responsiveness = 100
											v624.MaxTorque = (1 / 0)
											v624.Parent = v621
											v621.Anchored = false
											for _, v625 in v621:GetDescendants() do
												if v625:IsA("ParticleEmitter") then
													v625.Enabled = true
												elseif v625:IsA("Beam") or v625:IsA("Trail") then
													v625.Enabled = true
												end
											end
											return v621
										end
										local function v_u_630(p627, p628)
											if p627 and p627.Parent then
												for _, v_u_629 in p627:GetDescendants() do
													if v_u_629:IsA("ParticleEmitter") then
														v_u_629.Enabled = false
														if p628 then
															pcall(function()
																-- upvalues: (copy) v_u_629
																v_u_629:Clear()
															end)
														end
													elseif v_u_629:IsA("Beam") or v_u_629:IsA("Trail") then
														v_u_629.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_295, (ref) v_u_616, (copy) v_u_626, (copy) v_u_614, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												v_u_616 = v_u_626("Blue", v_u_614)
												if v_u_616 then
													v_u_287:AddItem(v_u_616, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_295, (ref) v_u_617, (copy) v_u_626, (copy) v_u_615, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												v_u_617 = v_u_626("Red", v_u_615)
												if v_u_617 then
													v_u_287:AddItem(v_u_617, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_295, (ref) v_u_288, (copy) v_u_614, (copy) v_u_615, (copy) v_u_613, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												local v631 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_288:Create(v_u_614, v631, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_288:Create(v_u_615, v631, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_295, (ref) v_u_613, (ref) v_u_287
													if v_u_295 and v_u_295.Parent then
														local v632 = v_u_613:FindFirstChild("StarEff")
														if v632 then
															local v633 = v632:Clone()
															v633.CFrame = v_u_295.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v633.Anchored = true
															v633.CanCollide = false
															v633.Transparency = 1
															v633.Parent = workspace
															for _, v634 in v633:GetDescendants() do
																if v634:IsA("ParticleEmitter") then
																	v634:Emit(v634:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_287:AddItem(v633, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_295, (copy) v_u_630, (ref) v_u_616, (ref) v_u_617, (copy) v_u_614, (copy) v_u_615, (copy) v_u_613, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												v_u_630(v_u_616, true)
												v_u_630(v_u_617, true)
												if v_u_614 and v_u_614.Parent then
													v_u_614:Destroy()
												end
												if v_u_615 and v_u_615.Parent then
													v_u_615:Destroy()
												end
												local v635 = v_u_613:FindFirstChild("MiniExplosionVFX")
												if v635 then
													local v636 = v635:Clone()
													v636.CFrame = v_u_295.CFrame * CFrame.new(0, 0, -2)
													v636.Anchored = true
													v636.CanCollide = false
													v636.Transparency = 1
													v636.Parent = workspace
													for _, v637 in v636:GetDescendants() do
														if v637:IsA("ParticleEmitter") then
															v637:Emit(v637:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_287:AddItem(v636, 3)
												end
												local v_u_638 = v_u_295.Position + v_u_295.CFrame.LookVector * 6
												local v_u_639 = v_u_295.CFrame.LookVector
												local v640 = v_u_613:FindFirstChild("Purple")
												if v640 then
													local v_u_641 = v640:Clone()
													v_u_641.Anchored = true
													v_u_641.CanCollide = false
													v_u_641.Parent = workspace
													v_u_287:AddItem(v_u_641, 3)
													for _, v642 in v_u_641:GetDescendants() do
														if v642:IsA("ParticleEmitter") then
															v642.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_638, (copy) v_u_641, (copy) v_u_639
														local v643 = v_u_638
														local v644 = 0
														while v644 < 200 and (v_u_641 and v_u_641.Parent) do
															v643 = v643 + v_u_639 * 3.9899999999999998
															v644 = v644 + 3.9899999999999998
															v_u_641.CFrame = CFrame.lookAt(v643, v643 + v_u_639)
															task.wait(0.03)
														end
														for _, v645 in v_u_641:GetDescendants() do
															if v645:IsA("ParticleEmitter") then
																v645.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								elseif v_u_291 == "Sukuna" then
									local v_u_646 = v_u_292.V
									if v_u_646 then
										local v647 = (p_u_286.NPCModel or "NPC") .. "_SukunaV"
										local v648 = tick()
										if not v_u_285[v647] or v648 - v_u_285[v647] > 0.5 then
											v_u_285[v647] = v648
											v_u_39:PlayAt("SukunaV_Part1", p_u_286.Position)
										end
										local v649 = v_u_646:FindFirstChild("GroundVFX")
										if v649 then
											local v_u_650 = v649:Clone()
											v_u_650.CFrame = v_u_295.CFrame * CFrame.new(0, -2, 0)
											v_u_650.Anchored = false
											v_u_650.Parent = workspace
											v_u_287:AddItem(v_u_650, 3)
											local v651 = Instance.new("WeldConstraint")
											v651.Part0 = v_u_295
											v651.Part1 = v_u_650
											v651.Parent = v_u_650
											for _, v652 in v_u_650:GetDescendants() do
												if v652:IsA("ParticleEmitter") then
													v652.Enabled = true
													v652:Emit(v652:GetAttribute("EmitCount") or 40)
												elseif v652:IsA("Beam") then
													v652.Enabled = true
												end
											end
											task.delay(2.35, function()
												-- upvalues: (copy) v_u_650
												if v_u_650 and v_u_650.Parent then
													for _, v653 in v_u_650:GetDescendants() do
														if v653:IsA("ParticleEmitter") then
															v653.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_295, (copy) v_u_646, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												local v654 = v_u_646:FindFirstChild("MiniExplosionVFX")
												if v654 then
													local v655 = v654:Clone()
													v655.CFrame = v_u_295.CFrame * CFrame.new(1, 0, 0)
													v655.Anchored = false
													v655.Parent = workspace
													v_u_287:AddItem(v655, 2)
													local v656 = Instance.new("WeldConstraint")
													v656.Part0 = v_u_295
													v656.Part1 = v655
													v656.Parent = v655
													for _, v657 in v655:GetDescendants() do
														if v657:IsA("ParticleEmitter") then
															v657:Emit(v657:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v658 = v_u_646:FindFirstChild("ArrowVFX")
												if v658 then
													local v_u_659 = v658:Clone()
													v_u_659.CFrame = v_u_295.CFrame * CFrame.new(1, 0, 0)
													v_u_659.Anchored = false
													v_u_659.Parent = workspace
													v_u_287:AddItem(v_u_659, 2)
													local v660 = Instance.new("WeldConstraint")
													v660.Part0 = v_u_295
													v660.Part1 = v_u_659
													v660.Parent = v_u_659
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_659
														if v_u_659 and v_u_659.Parent then
															for _, v661 in v_u_659:GetDescendants() do
																if v661:IsA("ParticleEmitter") or v661:IsA("Beam") then
																	v661.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_295, (ref) p_u_286, (ref) v_u_285, (ref) v_u_39, (copy) v_u_646, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												local v662 = (p_u_286.NPCModel or "NPC") .. "_SukunaV2"
												local v663 = tick()
												if not v_u_285[v662] or v663 - v_u_285[v662] > 0.5 then
													v_u_285[v662] = v663
													v_u_39:PlayAt("SukunaV_Part2", v_u_295.Position)
												end
												local v664 = v_u_295.CFrame.LookVector
												local v665 = v_u_295.Position + v664 * 85
												local v666 = v_u_646:FindFirstChild("ExplosionVFX")
												if v666 then
													local v_u_667 = v666:Clone()
													if v_u_667:IsA("Model") then
														v_u_667:PivotTo(CFrame.new(v665) * CFrame.new(0, 73, 0))
													else
														v_u_667.CFrame = CFrame.new(v665) * CFrame.new(0, 73, 0)
													end
													v_u_667.Parent = workspace
													v_u_287:AddItem(v_u_667, 4)
													for _, v668 in v_u_667:GetDescendants() do
														if v668:IsA("ParticleEmitter") then
															v668.Enabled = true
															v668:Emit(v668:GetAttribute("EmitCount") or 30)
														elseif v668:IsA("Beam") or v668:IsA("Trail") then
															v668.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_667
														if v_u_667 and v_u_667.Parent then
															for _, v669 in v_u_667:GetDescendants() do
																if v669:IsA("ParticleEmitter") or (v669:IsA("Beam") or v669:IsA("Trail")) then
																	v669.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
									end
								else
									if v_u_291 == "Ragna" then
										v_u_39:PlayAt("RagnaV", p_u_286.Position)
										local v_u_670 = v_u_292.V
										if not v_u_670 then
											return
										end
										local v671 = v_u_670:FindFirstChild("FirstEffects")
										if v671 then
											local v_u_672 = v671:Clone()
											v_u_672.CFrame = v_u_295.CFrame * CFrame.new(0, -2.5, 0)
											v_u_672.Anchored = false
											v_u_672.CanCollide = false
											v_u_672.Transparency = 1
											v_u_672.CastShadow = false
											v_u_672.CanQuery = false
											v_u_672.Massless = true
											v_u_672.Parent = workspace
											v_u_287:AddItem(v_u_672, 6)
											local v673 = Instance.new("WeldConstraint")
											v673.Part0 = v_u_295
											v673.Part1 = v_u_672
											v673.Parent = v_u_672
											for _, v674 in v_u_672:GetDescendants() do
												if v674:IsA("ParticleEmitter") then
													v674.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_672
												if v_u_672 and v_u_672.Parent then
													for _, v675 in v_u_672:GetDescendants() do
														if v675:IsA("ParticleEmitter") then
															v675.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_295, (copy) v_u_670, (ref) v_u_287
											if v_u_295 and v_u_295.Parent then
												local v676 = v_u_670:FindFirstChild("UltVFX")
												if v676 then
													local v_u_677 = v676:Clone()
													v_u_677:PivotTo(v_u_295.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v678 in v_u_677:GetDescendants() do
														if v678:IsA("BasePart") then
															v678.Anchored = true
															v678.CanCollide = false
															v678.CastShadow = false
															v678.CanQuery = false
														end
													end
													v_u_677.Parent = workspace
													v_u_287:AddItem(v_u_677, 4.5)
													for _, v679 in v_u_677:GetDescendants() do
														if v679:IsA("ParticleEmitter") then
															v679.Enabled = true
														elseif v679:IsA("Beam") then
															v679.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_677
														if v_u_677 and v_u_677.Parent then
															for _, v680 in v_u_677:GetDescendants() do
																if v680:IsA("ParticleEmitter") then
																	v680.Enabled = false
																end
															end
															for _, v_u_681 in v_u_677:GetDescendants() do
																if v_u_681:IsA("Beam") then
																	local v_u_682 = v_u_681.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_682, (copy) v_u_681
																		local v683 = tick()
																		while tick() - v683 < 0.5 do
																			local v684 = (tick() - v683) / 0.5
																			local v685 = {}
																			for _, v686 in ipairs(v_u_682) do
																				local v687 = v686.Value + (1 - v686.Value) * v684
																				local v688 = NumberSequenceKeypoint.new
																				local v689 = v686.Time
																				table.insert(v685, v688(v689, v687))
																			end
																			v_u_681.Transparency = NumberSequence.new(v685)
																			task.wait()
																		end
																		v_u_681.Transparency = NumberSequence.new(1)
																	end)
																end
															end
														end
													end)
												end
											end
										end)
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
	local v_u_691 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p692, p_u_693)
		-- upvalues: (copy) v_u_691, (copy) v_u_690, (copy) v_u_46, (copy) v_u_39, (copy) v_u_278, (copy) v_u_284, (copy) v_u_4
		if p692 == "SpawnVFX" then
			if p_u_693.IsNPC and (p_u_693.VFXName == "Z" or (p_u_693.VFXName == "X" or (p_u_693.VFXName == "C" or p_u_693.VFXName == "V"))) then
				local v694 = (p_u_693.NPCModel or "NPC") .. "_" .. p_u_693.VFXName
				local v695 = tick()
				if v_u_691[v694] and v695 - v_u_691[v694] < 1 then
					return
				end
				v_u_691[v694] = v695
				task.spawn(function()
					-- upvalues: (ref) v_u_690, (copy) p_u_693
					v_u_690(p_u_693)
				end)
				local v696 = p_u_693.MovesetType or "Saber"
				if p_u_693.VFXName == "Z" then
					if v696 == "Gojo" then
						local v697 = (p_u_693.NPCModel or "unknown") .. "_Z"
						local v698 = tick()
						local v699
						if v_u_46[v697] and v698 - v_u_46[v697] < 1.5 then
							v699 = false
						else
							v_u_46[v697] = v698
							v699 = true
						end
						if v699 then
							v_u_39:PlayAt("GojoZ", p_u_693.Position)
						end
					elseif v696 == "Sukuna" then
						local v700 = (p_u_693.NPCModel or "unknown") .. "_Z"
						local v701 = tick()
						local v702
						if v_u_46[v700] and v701 - v_u_46[v700] < 1.5 then
							v702 = false
						else
							v_u_46[v700] = v701
							v702 = true
						end
						if v702 then
							v_u_39:PlayAt("SukunaZ", p_u_693.Position)
						end
					elseif v696 == "Jinwoo" then
						local v703 = (p_u_693.NPCModel or "unknown") .. "_Z"
						local v704 = tick()
						local v705
						if v_u_46[v703] and v704 - v_u_46[v703] < 1.5 then
							v705 = false
						else
							v_u_46[v703] = v704
							v705 = true
						end
						if v705 then
							v_u_39:PlayAt("JinwooZ", p_u_693.Position)
						end
					elseif v696 == "Ragna" then
						local v706 = (p_u_693.NPCModel or "unknown") .. "_Z"
						local v707 = tick()
						local v708
						if v_u_46[v706] and v707 - v_u_46[v706] < 1.5 then
							v708 = false
						else
							v_u_46[v706] = v707
							v708 = true
						end
						if v708 then
							v_u_39:PlayAt("RagnaZ", p_u_693.Position)
						end
					elseif v696 == "Aizen" then
						local v709 = (p_u_693.NPCModel or "unknown") .. "_Z"
						local v710 = tick()
						local v711
						if v_u_46[v709] and v710 - v_u_46[v709] < 1.5 then
							v711 = false
						else
							v_u_46[v709] = v710
							v711 = true
						end
						if v711 then
							v_u_39:PlayAt("AizenZ", p_u_693.Position)
						end
					elseif v696 == "QinShi" then
						local v712 = (p_u_693.NPCModel or "unknown") .. "_Z"
						local v713 = tick()
						local v714
						if v_u_46[v712] and v713 - v_u_46[v712] < 1.5 then
							v714 = false
						else
							v_u_46[v712] = v713
							v714 = true
						end
						if v714 then
							v_u_39:PlayAt("QinShiZ", p_u_693.Position)
						end
					elseif v696 == "Yuji" then
						local v715 = (p_u_693.NPCModel or "unknown") .. "_Z"
						local v716 = tick()
						local v717
						if v_u_46[v715] and v716 - v_u_46[v715] < 1.5 then
							v717 = false
						else
							v_u_46[v715] = v716
							v717 = true
						end
						if v717 then
							v_u_39:PlayAt("YujiZ", p_u_693.Position)
						end
					else
						local v718 = (p_u_693.NPCModel or "unknown") .. "_Z"
						local v719 = tick()
						local v720
						if v_u_46[v718] and v719 - v_u_46[v718] < 1.5 then
							v720 = false
						else
							v_u_46[v718] = v719
							v720 = true
						end
						if v720 then
							v_u_39:PlayAt("SaberZ", p_u_693.Position)
						end
					end
				elseif p_u_693.VFXName == "X" then
					if v696 == "Gojo" then
						local v721 = (p_u_693.NPCModel or "unknown") .. "_X"
						local v722 = tick()
						local v723
						if v_u_46[v721] and v722 - v_u_46[v721] < 1.5 then
							v723 = false
						else
							v_u_46[v721] = v722
							v723 = true
						end
						if v723 then
							v_u_39:PlayAt("GojoX", p_u_693.Position)
						end
					elseif v696 == "Sukuna" then
						local v724 = (p_u_693.NPCModel or "unknown") .. "_X"
						local v725 = tick()
						local v726
						if v_u_46[v724] and v725 - v_u_46[v724] < 1.5 then
							v726 = false
						else
							v_u_46[v724] = v725
							v726 = true
						end
						if v726 then
							v_u_39:PlayAt("SukunaX", p_u_693.Position)
						end
					elseif v696 == "Jinwoo" then
						local v727 = (p_u_693.NPCModel or "unknown") .. "_X"
						local v728 = tick()
						local v729
						if v_u_46[v727] and v728 - v_u_46[v727] < 1.5 then
							v729 = false
						else
							v_u_46[v727] = v728
							v729 = true
						end
						if v729 then
							v_u_39:PlayAt("JinwooX", p_u_693.Position)
						end
					elseif v696 == "Ragna" then
						local v730 = (p_u_693.NPCModel or "unknown") .. "_X"
						local v731 = tick()
						local v732
						if v_u_46[v730] and v731 - v_u_46[v730] < 1.5 then
							v732 = false
						else
							v_u_46[v730] = v731
							v732 = true
						end
						if v732 then
							v_u_39:PlayAt("RagnaX", p_u_693.Position)
						end
					elseif v696 == "Aizen" then
						local v733 = (p_u_693.NPCModel or "unknown") .. "_X"
						local v734 = tick()
						local v735
						if v_u_46[v733] and v734 - v_u_46[v733] < 1.5 then
							v735 = false
						else
							v_u_46[v733] = v734
							v735 = true
						end
						if v735 then
							v_u_39:PlayAt("AizenX", p_u_693.Position)
						end
					elseif v696 == "QinShi" then
						local v736 = (p_u_693.NPCModel or "unknown") .. "_X"
						local v737 = tick()
						local v738
						if v_u_46[v736] and v737 - v_u_46[v736] < 1.5 then
							v738 = false
						else
							v_u_46[v736] = v737
							v738 = true
						end
						if v738 then
							v_u_39:PlayAt("QinShiX", p_u_693.Position)
						end
					elseif v696 == "Yuji" then
						local v739 = (p_u_693.NPCModel or "unknown") .. "_X"
						local v740 = tick()
						local v741
						if v_u_46[v739] and v740 - v_u_46[v739] < 1.5 then
							v741 = false
						else
							v_u_46[v739] = v740
							v741 = true
						end
						if v741 then
							v_u_39:PlayAt("YujiX", p_u_693.Position)
						end
					else
						local v742 = (p_u_693.NPCModel or "unknown") .. "_X"
						local v743 = tick()
						local v744
						if v_u_46[v742] and v743 - v_u_46[v742] < 1.5 then
							v744 = false
						else
							v_u_46[v742] = v743
							v744 = true
						end
						if v744 then
							v_u_39:PlayAt("SaberX", p_u_693.Position)
						end
					end
				elseif p_u_693.VFXName == "C" then
					if v696 == "Gojo" then
						local v745 = (p_u_693.NPCModel or "unknown") .. "_C"
						local v746 = tick()
						local v747
						if v_u_46[v745] and v746 - v_u_46[v745] < 1.5 then
							v747 = false
						else
							v_u_46[v745] = v746
							v747 = true
						end
						if v747 then
							v_u_39:PlayAt("GojoC", p_u_693.Position)
							v_u_39:PlayAt("GojoC_Hold", p_u_693.Position)
						end
					elseif v696 == "Jinwoo" then
						local v748 = (p_u_693.NPCModel or "unknown") .. "_C"
						local v749 = tick()
						local v750
						if v_u_46[v748] and v749 - v_u_46[v748] < 1.5 then
							v750 = false
						else
							v_u_46[v748] = v749
							v750 = true
						end
						if v750 then
							v_u_39:PlayAt("JinwooC", p_u_693.Position)
						end
					elseif v696 == "Ragna" then
						local v751 = (p_u_693.NPCModel or "unknown") .. "_C"
						local v752 = tick()
						local v753
						if v_u_46[v751] and v752 - v_u_46[v751] < 1.5 then
							v753 = false
						else
							v_u_46[v751] = v752
							v753 = true
						end
						if v753 then
							v_u_39:PlayAt("RagnaC_Startup", p_u_693.Position)
						end
					elseif v696 == "Aizen" then
						local v754 = (p_u_693.NPCModel or "unknown") .. "_C"
						local v755 = tick()
						local v756
						if v_u_46[v754] and v755 - v_u_46[v754] < 1.5 then
							v756 = false
						else
							v_u_46[v754] = v755
							v756 = true
						end
						if v756 then
							v_u_39:PlayAt("AizenC", p_u_693.Position)
						end
					elseif v696 == "QinShi" then
						local v757 = (p_u_693.NPCModel or "unknown") .. "_C"
						local v758 = tick()
						local v759
						if v_u_46[v757] and v758 - v_u_46[v757] < 1.5 then
							v759 = false
						else
							v_u_46[v757] = v758
							v759 = true
						end
						if v759 then
							v_u_39:PlayAt("QinShiC", p_u_693.Position)
						end
					elseif v696 == "Yuji" then
						local v760 = (p_u_693.NPCModel or "unknown") .. "_C"
						local v761 = tick()
						local v762
						if v_u_46[v760] and v761 - v_u_46[v760] < 1.5 then
							v762 = false
						else
							v_u_46[v760] = v761
							v762 = true
						end
						if v762 then
							v_u_39:PlayAt("YujiC_Press", p_u_693.Position)
						end
					else
						local v763 = (p_u_693.NPCModel or "unknown") .. "_C"
						local v764 = tick()
						local v765
						if v_u_46[v763] and v764 - v_u_46[v763] < 1.5 then
							v765 = false
						else
							v_u_46[v763] = v764
							v765 = true
						end
						if v765 then
							v_u_39:PlayAt("SaberC_Cast", p_u_693.Position)
							task.delay(3.85, function()
								-- upvalues: (ref) v_u_39, (copy) p_u_693
								v_u_39:PlayAt("SaberC_Beam", p_u_693.Position)
							end)
							task.delay(4.4, function()
								-- upvalues: (ref) v_u_39, (copy) p_u_693
								v_u_39:PlayAt("SaberC_Explosion", p_u_693.Position)
							end)
						end
					end
				elseif p_u_693.VFXName == "V" then
					if v696 == "Gojo" then
						v_u_39:PlayAt("GojoV", p_u_693.Position)
					else
						local _ = v696 == "Sukuna"
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_278, (copy) p_u_693
					v_u_278.SpawnVFX(p_u_693.VFXName, p_u_693.Position, p_u_693.Scale, p_u_693.Duration, p_u_693.AbilityName)
				end)
			end
			if p_u_693.CameraShake then
				task.delay(p_u_693.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_693
					local v_u_766 = p_u_693.CameraShake.Intensity or 5
					local v_u_767 = p_u_693.CameraShake.Duration or 0.3
					local v_u_768 = workspace.CurrentCamera
					if v_u_768 then
						task.spawn(function()
							-- upvalues: (copy) v_u_768, (copy) v_u_767, (copy) v_u_766
							local v769 = tick()
							local _ = v_u_768.CFrame
							while tick() - v769 < v_u_767 do
								local v770 = v_u_766 * (1 - (tick() - v769) / v_u_767)
								local v771 = (math.random() - 0.5) * v770 * 0.1
								local v772 = (math.random() - 0.5) * v770 * 0.1
								v_u_768.CFrame = v_u_768.CFrame * CFrame.new(v771, v772, 0)
								task.wait()
							end
						end)
					end
				end)
			end
			if p_u_693.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_284, (copy) p_u_693
					v_u_284(p_u_693.ScreenFlash)
				end)
				return
			end
		elseif p692 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_278, (copy) p_u_693, (ref) v_u_4
				local v773 = v_u_278.SpawnVFXWithRotation(p_u_693.VFXName, p_u_693.Position, p_u_693.Rotation, p_u_693.Scale, p_u_693.Duration, "KatanaAbilities")
				if v773 then
					v_u_4:AddItem(v773, (p_u_693.Duration or 0.4) + 1)
				end
			end)
			if p_u_693.IsNPC then
				v_u_39:PlayAt("KatanaZ", p_u_693.Position)
			end
			if p_u_693.CameraShake then
				local v_u_774 = p_u_693.CameraShake.Intensity or 3
				local v_u_775 = p_u_693.CameraShake.Duration or 0.2
				local v_u_776 = workspace.CurrentCamera
				if v_u_776 then
					task.spawn(function()
						-- upvalues: (copy) v_u_776, (copy) v_u_775, (copy) v_u_774
						local v777 = tick()
						local _ = v_u_776.CFrame
						while tick() - v777 < v_u_775 do
							local v778 = v_u_774 * (1 - (tick() - v777) / v_u_775)
							local v779 = (math.random() - 0.5) * v778 * 0.1
							local v780 = (math.random() - 0.5) * v778 * 0.1
							v_u_776.CFrame = v_u_776.CFrame * CFrame.new(v779, v780, 0)
							task.wait()
						end
					end)
				end
			end
		elseif p692 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_278, (copy) p_u_693, (ref) v_u_4
				local v781 = v_u_278.SpawnTravelingVFX(p_u_693.VFXName, p_u_693.StartPosition, p_u_693.Direction, p_u_693.TravelDistance, p_u_693.TravelSpeed, p_u_693.Scale, p_u_693.Duration, "KatanaAbilities")
				if v781 then
					v_u_4:AddItem(v781, (p_u_693.TravelDistance or 50) / (p_u_693.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_693.CameraShake then
				local v_u_782 = p_u_693.CameraShake.Intensity or 6
				local v_u_783 = p_u_693.CameraShake.Duration or 0.3
				local v_u_784 = workspace.CurrentCamera
				if v_u_784 then
					task.spawn(function()
						-- upvalues: (copy) v_u_784, (copy) v_u_783, (copy) v_u_782
						local v785 = tick()
						local _ = v_u_784.CFrame
						while tick() - v785 < v_u_783 do
							local v786 = v_u_782 * (1 - (tick() - v785) / v_u_783)
							local v787 = (math.random() - 0.5) * v786 * 0.1
							local v788 = (math.random() - 0.5) * v786 * 0.1
							v_u_784.CFrame = v_u_784.CFrame * CFrame.new(v787, v788, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_693.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_284, (copy) p_u_693
					v_u_284(p_u_693.ScreenFlash)
				end)
			end
		end
	end)
	local v789 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_790 = 1
	v789.OnClientEvent:Connect(function(p791)
		-- upvalues: (ref) v_u_790, (copy) v_u_39
		if p791 and p791.Position then
			v_u_39:PlayAt("CombatHit" .. v_u_790, p791.Position)
			v_u_790 = v_u_790 % 7 + 1
		end
	end)
	local v_u_792 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v793 = v48:WaitForChild("HitboxVisualize", 5)
	if v793 then
		v793.OnClientEvent:Connect(function(p794)
			-- upvalues: (copy) v_u_792
			if p794.Type == "Box" then
				v_u_792.ShowBox(p794.CFrame, p794.Size, p794.Duration, p794.Color)
				return
			elseif p794.Type == "Sphere" then
				v_u_792.ShowSphere(p794.Position, p794.Radius, p794.Duration, p794.Color)
				return
			elseif p794.Type == "Traveling" then
				v_u_792.ShowTraveling(p794.StartPos, p794.Direction, p794.Size, p794.Speed, p794.Distance, p794.HitboxType, p794.Color)
			elseif p794.Type == "FollowingAOE" then
				local v795 = p794.Character
				if v795 then
					v_u_792.ShowFollowingAOE(v795, p794.Size, p794.Duration, p794.Offset, p794.Color, p794.Shape)
					return
				end
			else
				if p794.Type == "MultiWave" then
					v_u_792.ShowMultiWave(p794.OriginCFrame, p794.Waves)
					return
				end
				if p794.Type == "Explosion" then
					v_u_792.ShowExplosion(p794.Position, p794.Radius, p794.Duration, p794.Color)
					return
				end
				if p794.Type == "StaticBox" then
					v_u_792.ShowStaticBox(p794.StartPos, p794.EndPos, p794.Width, p794.Height, p794.Duration, p794.Color)
				end
			end
		end)
	end
end)
if not v796 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v797)
	warn("=====================================")
end