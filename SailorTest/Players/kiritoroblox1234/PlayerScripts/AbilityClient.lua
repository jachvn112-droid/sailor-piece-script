local v943, v944 = pcall(function()
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
	local v65 = v_u_3:FindFirstChild("RemoteEvents")
	if v65 then
		v65 = v65:FindFirstChild("AizenFUnlockUpdate")
	end
	if v65 then
		v65.OnClientEvent:Connect(function(p66)
			-- upvalues: (copy) v_u_7
			v_u_7:SetAttribute("AizenFUnlocked", p66)
		end)
	end
	local function v72()
		-- upvalues: (ref) v_u_54, (copy) v_u_53, (copy) v_u_7, (copy) v_u_3
		task.wait(0.1)
		if not v_u_54 and pcall(function()
			-- upvalues: (ref) v_u_53
			v_u_53:Init()
		end) then
			v_u_54 = true
		end
		v_u_7:SetAttribute("FOVEffectActive", false)
		v_u_7:SetAttribute("FOVZoomActive", false)
		local v67 = workspace.CurrentCamera
		if v67 then
			v67.FieldOfView = 70
		end
		local v68 = v_u_3:FindFirstChild("RemoteEvents")
		if v68 then
			v68 = v68:FindFirstChild("ShadowMonarchFUnlockUpdate")
		end
		if v68 then
			v68.OnClientEvent:Connect(function(p69)
				-- upvalues: (ref) v_u_7
				v_u_7:SetAttribute("ShadowMonarchFUnlocked", p69)
			end)
		end
		local v70 = v_u_3:FindFirstChild("RemoteEvents")
		if v70 then
			v70 = v70:FindFirstChild("BlessedMaidenFUnlockUpdate")
		end
		if v70 then
			v70.OnClientEvent:Connect(function(p71)
				-- upvalues: (ref) v_u_7
				v_u_7:SetAttribute("BlessedMaidenFUnlocked", p71)
			end)
		end
	end
	v_u_7.CharacterAdded:Connect(v72)
	if v_u_7.Character then
		task.spawn(v72)
	end
	local v_u_73 = v_u_54
	local v_u_74 = {}
	local v75 = 0
	for _, v76 in v47:GetChildren() do
		if v76:IsA("ModuleScript") and not (string.find(v76.Name, "DISABLED") or string.find(v76.Name, "BEFORE")) then
			local v77, v78 = pcall(require, v76)
			if v77 then
				v_u_74[v76.Name] = v78
				v75 = v75 + 1
			else
				warn("[AbilityClient] Failed to load VFX handler:", v76.Name, "Error:", v78)
			end
		end
	end
	local function v_u_83()
		-- upvalues: (copy) v_u_7, (copy) v_u_36
		local v79 = v_u_7.Character
		if not v79 then
			return nil
		end
		local v80 = v79:FindFirstChildOfClass("Tool")
		if not v80 then
			return nil
		end
		for v81, v82 in pairs(v_u_36.Movesets) do
			if v82.ToolName and v82.ToolName == v80.Name then
				return v81
			end
		end
		return nil
	end
	local v_u_84 = {}
	local v_u_85 = nil
	local v_u_86 = 0
	local v_u_87 = nil
	local v_u_88 = nil
	local v_u_89 = 0
	local v_u_90 = 0.5
	local v_u_91 = nil
	local v_u_92 = false
	local v_u_93 = false
	local v_u_94 = {}
	local v_u_95 = false
	local v_u_96 = nil
	local v_u_97 = 0
	local v_u_98 = nil
	local v_u_99 = nil
	local v_u_100 = nil
	local v_u_101 = nil
	local v_u_102 = nil
	local v_u_103 = false
	local v_u_104 = false
	local v_u_105 = nil
	local v_u_106 = nil
	local v_u_107 = nil
	local v_u_108 = nil
	local function v_u_110()
		-- upvalues: (ref) v_u_107, (ref) v_u_108, (ref) v_u_96, (ref) v_u_97, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_105, (ref) v_u_106, (ref) v_u_103, (ref) v_u_104, (ref) v_u_101
		if v_u_107 then
			v_u_107:Stop(0)
			v_u_107 = nil
		end
		if v_u_108 then
			v_u_108:Stop()
			v_u_108 = nil
		end
		v_u_96 = nil
		v_u_97 = 0
		v_u_98 = nil
		v_u_99 = nil
		v_u_100 = nil
		local v109 = workspace.CurrentCamera
		if v109 then
			v109.FieldOfView = 70
		end
		if v_u_105 then
			v_u_105:Destroy()
			v_u_105 = nil
		end
		if v_u_106 then
			v_u_106:Destroy()
			v_u_106 = nil
		end
		v_u_103 = false
		v_u_104 = false
		v_u_101 = nil
	end
	local function v113(p111)
		-- upvalues: (copy) v_u_110
		local v112 = p111:WaitForChild("Humanoid", 5)
		if v112 then
			v112.Died:Connect(function()
				-- upvalues: (ref) v_u_110
				v_u_110()
			end)
		end
	end
	local v114 = v_u_7.Character and v_u_7.Character:WaitForChild("Humanoid", 5)
	if v114 then
		v114.Died:Connect(function()
			-- upvalues: (copy) v_u_110
			v_u_110()
		end)
	end
	v_u_7.CharacterAdded:Connect(v113)
	local function v_u_168(p115)
		-- upvalues: (copy) v_u_1, (ref) v_u_101, (ref) v_u_103, (ref) v_u_104, (copy) v_u_3, (copy) v_u_4, (ref) v_u_106, (copy) v_u_7, (copy) v_u_6, (ref) v_u_105, (ref) v_u_96, (ref) v_u_102, (copy) v_u_5, (ref) v_u_108, (copy) v_u_37
		local v_u_116 = workspace.CurrentCamera
		if v_u_116 then
			local v_u_117 = v_u_1.LocalPlayer.Character
			if v_u_117 then
				local v_u_118 = v_u_117:FindFirstChild("Right Arm") or v_u_117:FindFirstChild("RightHand")
				if v_u_118 and v_u_117:FindFirstChild("HumanoidRootPart") then
					v_u_101 = v_u_116.FieldOfView
					v_u_103 = false
					v_u_104 = false
					local v_u_119 = p115.ChargeTier2Time or 2
					local v_u_120 = p115.ChargeTier3Time or 4
					local v121 = v_u_3.AbilitySystem.VFX.Yuji.C
					local v122 = v121:FindFirstChild("ArmVFX1")
					local v_u_123 = v121:FindFirstChild("ArmVFX2")
					local v_u_124 = v121:FindFirstChild("ArmVFX3")
					local v_u_125 = v121:FindFirstChild("AuraVFX1")
					local v_u_126 = v121:FindFirstChild("AuraVFX2")
					local v_u_127 = v121:FindFirstChild("AuraVFX3")
					local v_u_128 = nil
					local v_u_129 = nil
					local v_u_130 = false
					local function v_u_135(p131)
						-- upvalues: (copy) v_u_118
						if not p131 then
							return nil
						end
						local v132 = p131:Clone()
						v132.CFrame = v_u_118.CFrame * CFrame.new(Vector3.new(0, -1, 0))
						v132.Anchored = false
						v132.CanCollide = false
						v132.CanQuery = false
						v132.CanTouch = false
						v132.Transparency = 1
						v132.Parent = workspace
						local v133 = Instance.new("WeldConstraint")
						v133.Part0 = v132
						v133.Part1 = v_u_118
						v133.Parent = v132
						for _, v134 in v132:GetDescendants() do
							if v134:IsA("ParticleEmitter") then
								v134.Enabled = true
								v134:Emit(v134:GetAttribute("EmitCount") or v134.Rate)
							end
						end
						return v132
					end
					local function v_u_141(p136)
						-- upvalues: (copy) v_u_117
						if not p136 then
							return nil
						end
						local v137 = v_u_117:FindFirstChild("HumanoidRootPart")
						if not v137 then
							return nil
						end
						local v138 = p136:Clone()
						v138.CFrame = v137.CFrame * CFrame.new(Vector3.new(0, -2.95, 0))
						v138.Anchored = false
						v138.CanCollide = false
						v138.CanQuery = false
						v138.CanTouch = false
						v138.Transparency = 1
						v138.Parent = workspace
						local v139 = Instance.new("WeldConstraint")
						v139.Part0 = v138
						v139.Part1 = v137
						v139.Parent = v138
						for _, v140 in v138:GetDescendants() do
							if v140:IsA("ParticleEmitter") then
								v140.Enabled = true
								v140:Emit(v140:GetAttribute("EmitCount") or v140.Rate)
							end
						end
						return v138
					end
					local function v_u_144(p142)
						if p142 then
							for _, v143 in p142:GetDescendants() do
								if v143:IsA("ParticleEmitter") then
									v143.Enabled = false
								end
							end
						end
					end
					v_u_128 = v_u_135(v122)
					v_u_105 = v_u_128
					task.delay(0.15, function()
						-- upvalues: (ref) v_u_96, (ref) v_u_130, (ref) v_u_129, (copy) v_u_141, (copy) v_u_125, (ref) v_u_106
						if v_u_96 then
							if not v_u_130 then
								v_u_130 = true
								v_u_129 = v_u_141(v_u_125)
								v_u_106 = v_u_129
							end
						else
							return
						end
					end)
					local v145 = 4 * v_u_120
					v_u_102 = v_u_5:Create(v_u_116, TweenInfo.new(v_u_120, Enum.EasingStyle.Linear), {
						["FieldOfView"] = v_u_101 + v145
					})
					v_u_102:Play()
					task.spawn(function()
						-- upvalues: (ref) v_u_96, (ref) v_u_103, (copy) v_u_119, (ref) v_u_7, (copy) v_u_116, (ref) v_u_6, (copy) v_u_123, (ref) v_u_128, (copy) v_u_135, (copy) v_u_144, (ref) v_u_4, (ref) v_u_105, (copy) v_u_126, (ref) v_u_129, (copy) v_u_141, (ref) v_u_106, (ref) v_u_102, (ref) v_u_5, (copy) v_u_120, (ref) v_u_104, (copy) v_u_124, (copy) v_u_127, (ref) v_u_108, (ref) v_u_37
						local v146 = tick()
						while v_u_96 do
							local v147 = tick() - v146
							if not v_u_103 and v_u_119 <= v147 then
								v_u_103 = true
								if not v_u_7:GetAttribute("DisableScreenShake") then
									local v_u_148 = 0.3
									local v_u_149 = 6
									task.spawn(function()
										-- upvalues: (copy) v_u_148, (copy) v_u_149, (ref) v_u_116, (ref) v_u_6
										local v150 = tick()
										while tick() - v150 < v_u_148 do
											local v151 = v_u_149 * (1 - (tick() - v150) / v_u_148) * 0.01
											local v152 = (math.random() - 0.5) * 2 * v151
											local v153 = (math.random() - 0.5) * 2 * v151
											v_u_116.CFrame = v_u_116.CFrame * CFrame.new(v152, v153, 0)
											v_u_6.RenderStepped:Wait()
										end
									end)
								end
								local v154 = v_u_128
								v_u_128 = v_u_135(v_u_123)
								if v154 then
									v_u_144(v154)
									v_u_4:AddItem(v154, 0.5)
								end
								v_u_105 = v_u_128
								local v155 = v_u_129
								v_u_129 = v_u_141(v_u_126)
								v_u_106 = v_u_129
								if v155 then
									v_u_144(v155)
									v_u_4:AddItem(v155, 0.5)
								end
								if v_u_102 then
									v_u_102:Pause()
								end
								local v156 = v_u_5:Create(v_u_116, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_116.FieldOfView + 5
								})
								v156:Play()
								v156.Completed:Wait()
								if v_u_96 then
									local v157 = v_u_120 - v147
									local v158 = {
										["FieldOfView"] = v_u_116.FieldOfView + 4 * v157
									}
									v_u_102 = v_u_5:Create(v_u_116, TweenInfo.new(v157, Enum.EasingStyle.Linear), v158)
									v_u_102:Play()
								end
							end
							if not v_u_104 and v_u_120 <= v147 then
								v_u_104 = true
								if not v_u_7:GetAttribute("DisableScreenShake") then
									local v_u_159 = 0.3
									local v_u_160 = 10
									task.spawn(function()
										-- upvalues: (copy) v_u_159, (copy) v_u_160, (ref) v_u_116, (ref) v_u_6
										local v161 = tick()
										while tick() - v161 < v_u_159 do
											local v162 = v_u_160 * (1 - (tick() - v161) / v_u_159) * 0.01
											local v163 = (math.random() - 0.5) * 2 * v162
											local v164 = (math.random() - 0.5) * 2 * v162
											v_u_116.CFrame = v_u_116.CFrame * CFrame.new(v163, v164, 0)
											v_u_6.RenderStepped:Wait()
										end
									end)
								end
								local v165 = v_u_128
								v_u_128 = v_u_135(v_u_124)
								if v165 then
									v_u_144(v165)
									v_u_4:AddItem(v165, 0.5)
								end
								v_u_105 = v_u_128
								local v166 = v_u_129
								v_u_129 = v_u_141(v_u_127)
								v_u_106 = v_u_129
								if v166 then
									v_u_144(v166)
									v_u_4:AddItem(v166, 0.5)
								end
								local v167 = v_u_7.Character
								if v167 then
									v167 = v167:FindFirstChild("HumanoidRootPart")
								end
								v_u_108 = v167 and v_u_37:PlayAt("YujiC_HoldLoop", v167.Position)
								if v_u_108 then
									v_u_108.Looped = true
								end
								if v_u_102 then
									v_u_102:Cancel()
									v_u_102 = nil
								end
								v_u_5:Create(v_u_116, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FieldOfView"] = v_u_116.FieldOfView + 5
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
	local function v_u_173()
		-- upvalues: (ref) v_u_102, (ref) v_u_105, (copy) v_u_4, (ref) v_u_106, (ref) v_u_101, (copy) v_u_5, (ref) v_u_103, (ref) v_u_104
		if v_u_102 then
			v_u_102:Cancel()
			v_u_102 = nil
		end
		if v_u_105 and v_u_105.Parent then
			for _, v169 in v_u_105:GetDescendants() do
				if v169:IsA("ParticleEmitter") then
					v169.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_105, 0.15)
		end
		v_u_105 = nil
		if v_u_106 and v_u_106.Parent then
			for _, v170 in v_u_106:GetDescendants() do
				if v170:IsA("ParticleEmitter") then
					v170.Enabled = false
				end
			end
			v_u_4:AddItem(v_u_106, 0.15)
		end
		v_u_106 = nil
		local v171 = workspace.CurrentCamera
		if v171 and v_u_101 then
			local v172 = {
				["FieldOfView"] = v_u_101
			}
			v_u_5:Create(v171, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v172):Play()
		end
		v_u_101 = nil
		v_u_103 = false
		v_u_104 = false
	end
	local function v_u_183(_, p174, p175, p176, p177)
		local v178 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p177 or "Gojo")
		if v178 then
			v178 = game.ReplicatedStorage.AbilitySystem.VFX:FindFirstChild(p177 or "Gojo"):FindFirstChild("C")
		end
		if not v178 then
			return nil
		end
		local v179 = v178:FindFirstChild(p174)
		if not v179 then
			return nil
		end
		local v180 = v179:Clone()
		v180.CFrame = p175.CFrame
		v180.Anchored = false
		v180.CanCollide = false
		v180.Transparency = 1
		v180.Parent = workspace
		local v181 = Instance.new("WeldConstraint")
		v181.Part0 = p175
		v181.Part1 = v180
		v181.Parent = v180
		for _, v182 in pairs(v180:GetDescendants()) do
			if v182:IsA("ParticleEmitter") then
				v182.Enabled = true
			end
		end
		game:GetService("Debris"):AddItem(v180, p176)
		return v180
	end
	local function v_u_186()
		-- upvalues: (ref) v_u_94
		for _, v184 in pairs(v_u_94) do
			if v184 and v184.Parent then
				for _, v185 in pairs(v184:GetDescendants()) do
					if v185:IsA("ParticleEmitter") then
						v185.Enabled = false
					end
				end
				game:GetService("Debris"):AddItem(v184, 0.5)
			end
		end
		v_u_94 = {}
	end
	local function v_u_195(p187, p188, p_u_189)
		-- upvalues: (copy) v_u_5
		local v190 = workspace.CurrentCamera
		if v190 then
			local v_u_191 = v190.FieldOfView
			local v192 = {
				["FieldOfView"] = v_u_191 + p187
			}
			v_u_5:Create(v190, TweenInfo.new(p188, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), v192):Play()
			task.delay(p188, function()
				-- upvalues: (ref) v_u_5, (copy) p_u_189, (copy) v_u_191
				local v193 = workspace.CurrentCamera
				if v193 then
					local v194 = {
						["FieldOfView"] = v_u_191
					}
					v_u_5:Create(v193, TweenInfo.new(p_u_189, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v194):Play()
				end
			end)
		end
	end
	local function v_u_206(p196)
		-- upvalues: (copy) v_u_186, (copy) v_u_195, (copy) v_u_183, (ref) v_u_88, (ref) v_u_94
		v_u_186()
		v_u_195(10, 0.12, 0.5)
		task.delay(9.5, function()
			-- upvalues: (ref) v_u_195
			v_u_195(10, 0.12, 0.5)
		end)
		local v197 = p196:FindFirstChild("Torso") or p196:FindFirstChild("UpperTorso")
		local v198 = p196:FindFirstChild("Right Arm") or p196:FindFirstChild("RightUpperArm")
		local v199 = p196:FindFirstChild("Left Arm") or p196:FindFirstChild("LeftUpperArm")
		local v200 = v197 and v_u_183(p196, "DamageVFX", v197, 10, v_u_88)
		if v200 then
			local v201 = v_u_94
			table.insert(v201, v200)
		end
		local v202 = v198 and v_u_183(p196, "ArmVFX", v198, 10, v_u_88)
		if v202 then
			local v203 = v_u_94
			table.insert(v203, v202)
		end
		local v204 = v199 and v_u_183(p196, "ArmVFX", v199, 10, v_u_88)
		if v204 then
			local v205 = v_u_94
			table.insert(v205, v204)
		end
	end
	local function v_u_211(p207)
		-- upvalues: (copy) v_u_186, (ref) v_u_95, (copy) v_u_195, (copy) v_u_183, (ref) v_u_88, (ref) v_u_94
		v_u_186()
		v_u_95 = true
		v_u_195(10, 0.12, 0.5)
		task.delay(5.5, function()
			-- upvalues: (ref) v_u_95, (ref) v_u_195
			if v_u_95 then
				v_u_195(10, 0.12, 0.5)
			end
			v_u_95 = false
		end)
		local v208 = p207:FindFirstChild("Torso") or p207:FindFirstChild("UpperTorso")
		local v209 = v208 and v_u_183(p207, "HealVFX", v208, 6, v_u_88)
		if v209 then
			local v210 = v_u_94
			table.insert(v210, v209)
		end
	end
	v_u_2.InputBegan:Connect(function(p212, p213)
		-- upvalues: (ref) v_u_51, (copy) v_u_43, (copy) v_u_7, (copy) v_u_36, (copy) v_u_56, (copy) v_u_83, (copy) v_u_84, (ref) v_u_85, (ref) v_u_86, (ref) v_u_87, (ref) v_u_88, (ref) v_u_89, (ref) v_u_90, (ref) v_u_93, (copy) v_u_206, (ref) v_u_91, (copy) v_u_211, (ref) v_u_92, (copy) v_u_45, (copy) v_u_37, (copy) v_u_48, (ref) v_u_96, (ref) v_u_97, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (copy) v_u_168, (copy) v_u_3, (ref) v_u_107, (copy) v_u_173, (copy) v_u_34, (copy) v_u_2
		if p213 then
			return
		elseif v_u_51 then
			return
		elseif v_u_43.InArtifactUI then
			return
		else
			local v214 = v_u_7.Character
			if v214 and v214:GetAttribute("InArtifactUI") then
				return
			elseif v214 and v214:GetAttribute("InCutscene") then
				return
			else
				local v215 = v_u_36.Keybinds[p212.KeyCode] or v_u_56[p212.KeyCode]
				if v215 then
					local v216 = v_u_83()
					local v217 = game:GetService("RunService"):IsStudio()
					if v215 == 5 and (v216 == "Shadow" and not v217) and v_u_7:GetAttribute("ShadowFUnlocked") ~= true then
						return
					elseif v215 == 5 and (v216 == "StrongestInHistory" and not v217) and v_u_7:GetAttribute("SukunaFUnlocked") ~= true then
						return
					elseif v215 == 5 and (v216 == "StrongestOfToday" and not v217) and v_u_7:GetAttribute("GojoFUnlocked") ~= true then
						return
					elseif v215 == 5 and (v216 == "Rimuru" and not v217) and v_u_7:GetAttribute("RimuruFUnlocked") ~= true then
						return
					else
						if v215 == 5 and (v216 == "Gilgamesh" and not v217) then
							if v_u_7:GetAttribute("GilgameshFUnlocked") ~= true then
								return
							end
							if v215 == 5 and (v216 == "ShadowMonarch" and not v217) and v_u_7:GetAttribute("ShadowMonarchFUnlocked") ~= true then
								return
							end
						end
						if v215 == 5 and (v216 == "TrueAizen" and not v217) and v_u_7:GetAttribute("AizenFUnlocked") ~= true then
							return
						elseif v215 == 5 and (v216 == "BlessedMaiden" and not v217) and v_u_7:GetAttribute("BlessedMaidenFUnlocked") ~= true then
							return
						elseif v216 then
							local v218 = v_u_36.Movesets[v216]
							if v218 and v218.Abilities[v215] then
								local v219 = v218.Abilities[v215]
								if v219.Type == "HoldVariant" then
									local v220 = v_u_84[v216 .. "_" .. v215]
									local v221
									if v220 and tick() < v220 then
										local _ = v220 - tick()
										v221 = true
									else
										v221 = false
									end
									if not v221 then
										v_u_85 = p212.KeyCode
										v_u_86 = tick()
										v_u_87 = v215
										v_u_88 = v216
										v_u_89 = 1
										v_u_90 = v219.HoldThreshold or 0.5
										v_u_93 = false
										local v222 = v_u_7.Character
										if v222 then
											v_u_206(v222)
										end
										if v_u_91 then
											v_u_91:Disconnect()
										end
										v_u_91 = game:GetService("RunService").Heartbeat:Connect(function()
											-- upvalues: (ref) v_u_85, (ref) v_u_91, (ref) v_u_86, (ref) v_u_90, (ref) v_u_89, (ref) v_u_93, (ref) v_u_7, (ref) v_u_211, (ref) v_u_36, (ref) v_u_88, (ref) v_u_87, (ref) v_u_84, (ref) v_u_92, (ref) v_u_45, (ref) v_u_37, (ref) v_u_48
											if v_u_85 then
												if v_u_90 <= tick() - v_u_86 and (v_u_89 == 1 and not v_u_93) then
													v_u_89 = 2
													v_u_93 = true
													local v223 = v_u_7.Character
													if v223 then
														v_u_211(v223)
													end
													local v224 = v_u_36.Movesets[v_u_88]
													if v224 then
														v224 = v224.Abilities[v_u_87]
													end
													if v224 and v224.Cooldown then
														local v225 = v_u_88
														local v226 = v_u_87
														local v227 = v224.Cooldown
														v_u_84[v225 .. "_" .. v226] = tick() + v227
													end
													v_u_92 = true
													local v228 = v_u_88
													local v229 = v_u_87
													local v230 = v_u_45[v228]
													local v231 = v230 and v230[v229]
													if v231 then
														if v229 == 3 then
															v231 = v228 == "Sukuna" and "SukunaC_Hold" or (v228 == "Gojo" and "GojoC_Hold" or v231)
														end
														v_u_37:Play(v231)
													end
													v_u_48:FireServer(v_u_87, {
														["Variant"] = 2
													})
												end
											else
												if v_u_91 then
													v_u_91:Disconnect()
												end
												v_u_91 = nil
											end
										end)
									end
								elseif v219.Type == "ChargedInstant" then
									local v232 = v_u_84[v216 .. "_" .. v215]
									local v233
									if v232 and tick() < v232 then
										local _ = v232 - tick()
										v233 = true
									else
										v233 = false
									end
									if not v233 then
										v_u_96 = p212.KeyCode
										v_u_97 = tick()
										v_u_98 = v215
										v_u_99 = v216
										v_u_100 = v219
										v_u_168(v219)
										if v216 == "Yuji" and v215 == 3 then
											local v234 = v_u_7.Character
											if v234 then
												v234 = v234:FindFirstChild("HumanoidRootPart")
											end
											if v234 then
												v_u_37:PlayAt("YujiC_HoldStart", v234.Position)
											end
											task.delay(0.15, function()
												-- upvalues: (ref) v_u_96, (ref) v_u_98, (ref) v_u_7, (ref) v_u_3, (ref) v_u_107
												if v_u_96 then
													if v_u_98 == 3 then
														local v235 = v_u_7.Character
														if v235 then
															v235 = v235:FindFirstChildOfClass("Humanoid")
														end
														if v235 then
															local v236 = v235:FindFirstChildOfClass("Animator") or Instance.new("Animator", v235)
															local v237 = v_u_3.AbilitySystem.Animations:FindFirstChild("Yuji")
															if v237 then
																v237 = v237:FindFirstChild("Yuji_C_Anim_Hold")
															end
															if v237 then
																if v_u_107 then
																	v_u_107:Stop(0)
																	v_u_107 = nil
																end
																v_u_107 = v236:LoadAnimation(v237)
																v_u_107.Priority = Enum.AnimationPriority.Action4
																v_u_107.Looped = true
																v_u_107:Play()
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
									local v238 = v_u_84[v216 .. "_" .. v215]
									local v239
									if v238 and tick() < v238 then
										local _ = v238 - tick()
										v239 = true
									else
										v239 = false
									end
									if v239 then
										return
									else
										if v_u_96 then
											v_u_173()
											if v_u_107 then
												v_u_107:Stop(0)
												v_u_107 = nil
											end
											v_u_96 = nil
											v_u_97 = 0
											v_u_98 = nil
											v_u_99 = nil
											v_u_100 = nil
										end
										if v219.Type == "TargetedCutscene" then
											local v240, v241 = v_u_34(v219.TargetRange or 30)
											if v240 then
												local v242 = v_u_84[v216 .. "_" .. v215]
												local v243
												if v242 and tick() < v242 then
													local _ = v242 - tick()
													v243 = true
												else
													v243 = false
												end
												if not v243 then
													v_u_48:FireServer(v215, {
														["TargetName"] = v240.Name,
														["TargetPosition"] = v241.Position
													})
												end
											else
												if v_u_2:GetLastInputType() == Enum.UserInputType.Gamepad1 then
													local v244 = v_u_3:FindFirstChild("Remotes")
													if v244 then
														v244 = v_u_3.Remotes:FindFirstChild("ShowNotification")
													end
													if v244 then
														v244:FireServer("Ability", {
															["message"] = "No target in range",
															["duration"] = 1.5
														})
													end
												end
												return
											end
										else
											if v216 == "Shadow" then
												local v245 = v_u_84[v216 .. "_" .. v215]
												local v246
												if v245 and tick() < v245 then
													local _ = v245 - tick()
													v246 = true
												else
													v246 = false
												end
												if not v246 then
													if v215 == 2 then
														v_u_37:Play("ShadowX_Dash")
													elseif v215 == 4 then
														v_u_37:Play("ShadowV_Ultimate")
													end
												end
											end
											v_u_48:FireServer(v215)
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
					end
				else
					return
				end
			end
		end
	end)
	v_u_2.InputEnded:Connect(function(p247, _)
		-- upvalues: (ref) v_u_96, (ref) v_u_97, (ref) v_u_99, (ref) v_u_98, (ref) v_u_100, (copy) v_u_173, (ref) v_u_107, (ref) v_u_108, (copy) v_u_84, (copy) v_u_48, (ref) v_u_85, (ref) v_u_89, (ref) v_u_88, (ref) v_u_87, (ref) v_u_93, (ref) v_u_86, (ref) v_u_90, (ref) v_u_91, (copy) v_u_36, (ref) v_u_92, (copy) v_u_45, (copy) v_u_37
		if v_u_96 and p247.KeyCode == v_u_96 then
			local v248 = tick() - v_u_97
			local v249 = v_u_99
			local v250 = v_u_98
			local v251 = v_u_100
			v_u_173()
			if v_u_107 then
				v_u_107:Stop(0.1)
				v_u_107 = nil
			end
			if v_u_108 then
				v_u_108:Stop()
				v_u_108 = nil
			end
			_G.YujiCharging = false
			v_u_96 = nil
			v_u_97 = 0
			v_u_98 = nil
			v_u_99 = nil
			v_u_100 = nil
			if v249 and (v250 and v251) then
				local v252 = (v251.ChargeTier3Time or 5) <= v248 and 3 or ((v251.ChargeTier2Time or 2.5) <= v248 and 2 or 1)
				if v251.Cooldown then
					local v253 = v251.Cooldown
					v_u_84[v249 .. "_" .. v250] = tick() + v253
				end
				v_u_48:FireServer(v250, {
					["ChargeTier"] = v252,
					["HoldDuration"] = v248
				})
			end
		elseif v_u_85 then
			if p247.KeyCode == v_u_85 then
				local v254 = v_u_88
				local v255 = v_u_87
				local v256 = v_u_93
				v_u_85 = nil
				v_u_86 = 0
				v_u_87 = nil
				v_u_88 = nil
				v_u_89 = 0
				v_u_90 = 0.5
				v_u_93 = false
				if v_u_91 then
					v_u_91:Disconnect()
					v_u_91 = nil
				end
				if v254 and v255 then
					if not v256 then
						local v257 = v_u_36.Movesets[v254]
						if v257 then
							v257 = v257.Abilities[v255]
						end
						if v257 and v257.Cooldown then
							local v258 = v257.Cooldown
							v_u_84[v254 .. "_" .. v255] = tick() + v258
						end
						v_u_92 = true
						local v259 = v_u_45[v254]
						local v260 = v259 and v259[v255]
						if v260 then
							local _ = v255 == 3
							v_u_37:Play(v260)
						end
						v_u_48:FireServer(v255, {
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
	local v_u_261 = workspace:GetServerTimeNow()
	v49.OnClientEvent:Connect(function(p_u_262)
		-- upvalues: (copy) v_u_261, (copy) v_u_7, (ref) v_u_95, (copy) v_u_186, (ref) v_u_73, (copy) v_u_53, (copy) v_u_55, (copy) v_u_36, (ref) v_u_51, (copy) v_u_84, (ref) v_u_92, (copy) v_u_45, (copy) v_u_37, (copy) v_u_74
		if workspace:GetServerTimeNow() - v_u_261 < 2 and p_u_262.Caster ~= v_u_7 then
			return
		elseif p_u_262.Timestamp and p_u_262.Timestamp < v_u_261 then
			return
		elseif p_u_262.Type == "HealingInterrupted" and p_u_262.Caster == v_u_7 then
			v_u_95 = false
			v_u_186()
			return
		elseif p_u_262.Type == "Hit" then
			return
		else
			local v263 = false
			if p_u_262.Caster == v_u_7 and p_u_262.Cooldown then
				if not v_u_73 and pcall(function()
					-- upvalues: (ref) v_u_53
					v_u_53:Init()
				end) then
					v_u_73 = true
				end
				local v264 = p_u_262.MovesetName or "Ability"
				local v265 = v_u_55[p_u_262.Keybind or 1] or "Z"
				v_u_53:StartCooldown(v264, p_u_262.AbilityName, v265, p_u_262.Cooldown)
			end
			if p_u_262.Caster == v_u_7 and (p_u_262.AbilitySlot and p_u_262.MovesetName) then
				local v266 = v_u_36.Movesets[p_u_262.MovesetName]
				if v266 then
					v266 = v266.Abilities[p_u_262.AbilitySlot]
				end
				if v266 then
					local v267
					if v266.Type == "HoldVariant" then
						v267 = false
					else
						v267 = v266.Type ~= "Toggle"
					end
					if v266.AbilityLockDuration == 0 then
						v267 = false
					end
					if v267 then
						v_u_51 = true
						local v268 = (v266.ChargeTime or v266.Duration or (v266.MovementLockDuration or 5)) + 2
						local v269 = math.max(v268, 5)
						task.delay(v269, function()
							-- upvalues: (ref) v_u_51
							if v_u_51 == true then
								v_u_51 = false
							end
						end)
					end
					if p_u_262.Cooldown then
						local v270 = p_u_262.MovesetName
						local v271 = p_u_262.AbilitySlot
						local v272 = p_u_262.Cooldown
						v_u_84[v270 .. "_" .. v271] = tick() + v272
					end
					if v266.Type == "HoldVariant" then
						v263 = v_u_92
					else
						v263 = false
					end
					if not v263 then
						local v273 = p_u_262.MovesetName
						local v274 = p_u_262.AbilitySlot
						local v275 = p_u_262.Variant
						local v276 = v_u_45[v273]
						local v277 = v276 and v276[v274]
						if v277 then
							if v274 == 3 and v275 == 2 then
								v277 = v273 == "Sukuna" and "SukunaC_Hold" or (v273 == "Gojo" and "GojoC_Hold" or v277)
							end
							v_u_37:Play(v277)
						end
					end
					if v266.Type == "HoldVariant" then
						v_u_92 = false
					end
				end
			end
			local v278 = p_u_262.Caster
			local v279 = p_u_262.MovesetName
			local v280 = p_u_262.AbilityName
			if v278 and v278.Character then
				local v281 = v_u_36.Movesets[v279]
				if v281 then
					v281 = v281.Abilities[p_u_262.AbilitySlot]
				end
				local v282
				if v281 then
					v282 = v281.Type == "HoldVariant"
				else
					v282 = v281
				end
				local v283 = p_u_262.Caster == v_u_7
				if v282 and (v283 and v263) then
					return
				else
					p_u_262.SkipLocalVFX = v263
					local v284 = v_u_74[v279]
					if not v_u_7:GetAttribute("DisableOtherVFX") or v278 == v_u_7 then
						if v284 then
							local v_u_285 = v284[v280]
							if v_u_285 then
								task.spawn(function()
									-- upvalues: (copy) v_u_285, (copy) p_u_262
									local v286, v287 = pcall(v_u_285, p_u_262)
									if not v286 then
										warn("[AbilityClient] VFX error:", v287)
									end
								end)
							else
								warn("[AbilityClient] No handler for " .. v280)
							end
						else
							warn("[AbilityClient] No VFX handler for moveset " .. v279)
						end
						if v281 and (v281.Type == "ContinuousDamage" and (v283 and not (v281.AnchorHitbox or (p_u_262.AnchorHitbox or (v281.DirectDamage or v281.WorldAnchorHitbox))))) then
							local v_u_288 = v278.Character
							local v_u_289 = p_u_262.HitboxSize or (v281.HitboxSize or Vector3.new(30, 15, 30))
							local v_u_290 = p_u_262.HitboxOffset or (v281.HitboxOffset or Vector3.new(0, 0, 0))
							local v_u_291 = p_u_262.DamageDuration or (v281.Duration or 3)
							local v292 = p_u_262.DamageDelay or (v281.DamageDelay or 0)
							if v_u_288 then
								local v_u_293 = require(game:GetService("ReplicatedStorage"):WaitForChild("HitboxVisualizer"))
								task.delay(v292, function()
									-- upvalues: (copy) v_u_288, (copy) v_u_293, (copy) v_u_289, (copy) v_u_291, (copy) v_u_290
									if v_u_288 and v_u_288.Parent then
										v_u_293.ShowFollowingAOE(v_u_288, v_u_289, v_u_291, v_u_290)
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
	local v_u_294 = require(v_u_3:WaitForChild("VFXService"))
	local v_u_295 = game:GetService("TweenService")
	local function v_u_300(p296)
		-- upvalues: (copy) v_u_7, (copy) v_u_295
		local v297 = v_u_7.PlayerGui:FindFirstChild("ScreenEffects")
		if not v297 then
			v297 = Instance.new("ScreenGui")
			v297.Name = "ScreenEffects"
			v297.IgnoreGuiInset = true
			v297.DisplayOrder = 10
			v297.Parent = v_u_7.PlayerGui
		end
		local v_u_298 = Instance.new("Frame")
		v_u_298.Size = UDim2.new(1, 0, 1, 0)
		v_u_298.BackgroundColor3 = p296.Color or Color3.new(1, 1, 1)
		v_u_298.BackgroundTransparency = 0.7
		v_u_298.BorderSizePixel = 0
		v_u_298.Parent = v297
		local v299 = v_u_295:Create(v_u_298, TweenInfo.new(p296.Duration or 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 1
		})
		v299:Play()
		v299.Completed:Connect(function()
			-- upvalues: (copy) v_u_298
			v_u_298:Destroy()
		end)
	end
	local v_u_301 = {}
	local function v_u_807(p_u_302)
		-- upvalues: (copy) v_u_3, (copy) v_u_74, (copy) v_u_301, (copy) v_u_37
		local v_u_303 = game:GetService("Debris")
		game:GetService("TweenService")
		local v_u_304 = game:GetService("TweenService")
		local v305 = v_u_3:FindFirstChild("AbilitySystem")
		if v305 then
			local v306 = v305:FindFirstChild("VFX")
			if v306 then
				local v_u_307 = p_u_302.MovesetType or "Saber"
				local v_u_308 = v306:FindFirstChild(v_u_307) or v306:FindFirstChild("Saber")
				if v_u_308 then
					local v309 = p_u_302.Position
					CFrame.new(v309)
					if p_u_302.LookVector then
						CFrame.lookAt(v309, v309 + p_u_302.LookVector)
					end
					local v_u_310 = p_u_302.NPCModel
					if v_u_310 then
						v_u_310 = workspace.NPCs:FindFirstChild(p_u_302.NPCModel) or workspace:FindFirstChild(p_u_302.NPCModel)
					end
					local v_u_311
					if v_u_310 then
						v_u_311 = v_u_310:FindFirstChild("HumanoidRootPart")
					else
						v_u_311 = v_u_310
					end
					local function v_u_317(p312, p313, p314)
						-- upvalues: (copy) v_u_303
						local v315 = p312:Clone()
						v315.CFrame = p313
						v315.Anchored = true
						v315.CanCollide = false
						v315.Transparency = 1
						v315.CastShadow = false
						v315.CanQuery = false
						v315.Parent = workspace
						v_u_303:AddItem(v315, p314)
						for _, v316 in v315:GetDescendants() do
							if v316:IsA("ParticleEmitter") then
								v316:Emit(v316:GetAttribute("EmitCount") or 20)
							end
						end
						return v315
					end
					local function v_u_323(p318, p319)
						-- upvalues: (copy) v_u_304
						local v320 = TweenInfo.new(p319, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						for _, v321 in p318:GetDescendants() do
							if v321:IsA("Beam") then
								local v322 = v321.Width0
								v321.Width0 = 0
								v321.Width1 = 0
								v321.Enabled = true
								v_u_304:Create(v321, v320, {
									["Width0"] = v322,
									["Width1"] = v322
								}):Play()
							end
						end
					end
					local function v_u_329(p324, p325)
						-- upvalues: (copy) v_u_304
						local v326 = TweenInfo.new(p325, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
						for _, v_u_327 in p324:GetDescendants() do
							if v_u_327:IsA("Beam") then
								local v328 = v_u_304:Create(v_u_327, v326, {
									["Width0"] = 0,
									["Width1"] = 0
								})
								v328:Play()
								v328.Completed:Once(function()
									-- upvalues: (copy) v_u_327
									v_u_327.Enabled = false
								end)
							end
						end
					end
					if p_u_302.VFXName == "Z" then
						task.spawn(function()
							-- upvalues: (copy) v_u_311, (copy) v_u_307, (copy) v_u_310, (ref) v_u_308, (copy) v_u_303, (copy) v_u_304, (ref) v_u_74, (ref) v_u_3, (copy) v_u_317
							if v_u_311 and v_u_311.Parent then
								if v_u_307 == "Gojo" then
									local v_u_330 = v_u_310:FindFirstChild("Right Arm")
									if v_u_330 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_311, (ref) v_u_308, (copy) v_u_330, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												local v331 = v_u_308.Z:FindFirstChild("RedVFXFirst")
												if v331 then
													local v332 = v331:Clone()
													v332.CFrame = v_u_330.CFrame * CFrame.new(0, -1.05, 0)
													v332.Anchored = true
													v332.CanCollide = false
													v332.Transparency = 1
													v332.CastShadow = false
													v332.CanQuery = false
													v332.Parent = workspace
													v_u_303:AddItem(v332, 4)
													for _, v_u_333 in v332:GetDescendants() do
														if v_u_333:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_333
																local v334 = v_u_333:GetAttribute("EmitDelay") or 0
																task.wait(v334)
																v_u_333:Emit(v_u_333:GetAttribute("EmitCount") or v_u_333.Rate)
															end)
														end
													end
													v332.Anchored = false
													local v335 = Instance.new("WeldConstraint")
													v335.Part0 = v_u_330
													v335.Part1 = v332
													v335.Parent = v332
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_311, (ref) v_u_308, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												local v336 = v_u_308.Z:FindFirstChild("RedVFX")
												if v336 then
													local v337 = v336:Clone()
													v337.CFrame = v_u_311.CFrame * CFrame.new(0, 1, -10)
													v337.Anchored = true
													v337.CanCollide = false
													v337.Transparency = 1
													v337.CastShadow = false
													v337.CanQuery = false
													v337.Parent = workspace
													v_u_303:AddItem(v337, 3)
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
												end
											else
												return
											end
										end)
									end
								elseif v_u_307 == "Sukuna" then
									local v_u_340 = v_u_308.Z
									if v_u_340 then
										local v341 = v_u_311.Position + Vector3.new(0, 1, 0)
										local v_u_342 = v_u_311.CFrame.LookVector
										local v343 = v_u_340:FindFirstChild("StartExplosionVFX")
										if v343 then
											local v344 = v343:Clone()
											v344.CFrame = CFrame.new(v341) * CFrame.Angles(0, 1.5707963267948966, 0)
											v344.Anchored = true
											v344.CanCollide = false
											v344.Transparency = 1
											v344.Parent = workspace
											v_u_303:AddItem(v344, 3)
											for _, v_u_345 in v344:GetDescendants() do
												task.spawn(function()
													-- upvalues: (copy) v_u_345
													if v_u_345:IsA("ParticleEmitter") then
														local v346 = v_u_345:GetAttribute("EmitDelay") or 0
														if v346 > 0 then
															task.wait(v346)
														end
														v_u_345:Emit(v_u_345:GetAttribute("EmitCount") or v_u_345.Rate)
													end
												end)
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_311, (copy) v_u_342, (copy) v_u_340, (ref) v_u_303, (ref) v_u_304
											if v_u_311 and v_u_311.Parent then
												local v347 = v_u_311.Position + v_u_342 * 3 + Vector3.new(0, 1, 0)
												local v348 = v_u_311.Position + v_u_342 * 65 + Vector3.new(0, 1, 0)
												local v349 = v_u_340:FindFirstChild("DismantleVFX")
												if v349 then
													local v_u_350 = v349:Clone()
													v_u_350.CFrame = CFrame.new(v347, v348)
													v_u_350.Anchored = true
													v_u_350.CanCollide = false
													v_u_350.Transparency = 1
													v_u_350.Parent = workspace
													v_u_303:AddItem(v_u_350, 2)
													for _, v351 in v_u_350:GetDescendants() do
														if v351:IsA("ParticleEmitter") then
															v351.Enabled = true
														end
													end
													v_u_304:Create(v_u_350, TweenInfo.new(1, Enum.EasingStyle.Linear), {
														["CFrame"] = CFrame.new(v348, v348 + v_u_342)
													}):Play()
													task.delay(1, function()
														-- upvalues: (copy) v_u_350
														for _, v352 in v_u_350:GetDescendants() do
															if v352:IsA("ParticleEmitter") then
																v352.Enabled = false
															end
														end
													end)
												end
											end
										end)
									end
								else
									if v_u_307 == "Ragna" then
										local v353 = v_u_308.Z
										if v353 then
											local v354 = v353:FindFirstChild("DashVFX")
											local v355 = v353:FindFirstChild("SlashesVFX")
											local v356 = v_u_311.CFrame.LookVector
											local v357 = CFrame.lookAt(v_u_311.Position, v_u_311.Position + v356)
											if v354 then
												local v_u_358 = v354:Clone()
												v_u_358.CFrame = v357
												v_u_358.Anchored = false
												v_u_358.CanCollide = false
												v_u_358.Transparency = 1
												v_u_358.CastShadow = false
												v_u_358.CanQuery = false
												v_u_358.Massless = true
												v_u_358.Parent = workspace
												v_u_303:AddItem(v_u_358, 1.5)
												local v359 = Instance.new("WeldConstraint")
												v359.Part0 = v_u_311
												v359.Part1 = v_u_358
												v359.Parent = v_u_358
												for _, v360 in v_u_358:GetDescendants() do
													if v360:IsA("ParticleEmitter") then
														v360.Enabled = true
														v360:Emit(v360:GetAttribute("EmitCount") or 30)
													end
												end
												task.delay(0.5, function()
													-- upvalues: (copy) v_u_358
													if v_u_358 and v_u_358.Parent then
														for _, v361 in v_u_358:GetDescendants() do
															if v361:IsA("ParticleEmitter") then
																v361.Enabled = false
															end
														end
													end
												end)
											end
											if v355 then
												local v362 = v355:Clone()
												v362.CFrame = v357 * CFrame.new(0, 0, -20)
												v362.Anchored = true
												v362.CanCollide = false
												v362.Transparency = 1
												v362.Parent = workspace
												v_u_303:AddItem(v362, 1.5)
												for _, v_u_363 in v362:GetDescendants() do
													if v_u_363:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_363
															local v364 = v_u_363:GetAttribute("EmitDelay") or 0
															if v364 > 0 then
																task.wait(v364)
															end
															v_u_363:Emit(v_u_363:GetAttribute("EmitCount") or v_u_363.Rate)
														end)
													end
												end
												return
											end
										end
									else
										if v_u_307 == "Aizen" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_311, (ref) v_u_308, (ref) v_u_303
												if v_u_311 and v_u_311.Parent then
													local v365 = v_u_308.Z:FindFirstChild("LightningVFX")
													if v365 then
														local v366 = v365:Clone()
														v366.CFrame = v_u_311.CFrame * CFrame.new(0, 0, -5)
														v366.Anchored = true
														v366.CanCollide = false
														v366.Transparency = 1
														v366.CastShadow = false
														v366.CanQuery = false
														v366.Parent = workspace
														v_u_303:AddItem(v366, 3)
														for _, v_u_367 in v366:GetDescendants() do
															if v_u_367:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_367
																	local v368 = v_u_367:GetAttribute("EmitDelay") or 0.05
																	task.delay(v368, function()
																		-- upvalues: (ref) v_u_367
																		v_u_367:Emit(v_u_367:GetAttribute("EmitCount") or v_u_367.Rate)
																	end)
																end)
															end
														end
													end
													local v369 = v_u_308.Z:FindFirstChild("EnergyThrust")
													if v369 then
														local v370 = v369:Clone()
														v370.CFrame = v_u_311.CFrame * CFrame.new(0, 0, -25)
														v370.Anchored = true
														v370.CanCollide = false
														v370.Transparency = 1
														v370.CastShadow = false
														v370.CanQuery = false
														v370.Parent = workspace
														v_u_303:AddItem(v370, 3)
														for _, v_u_371 in v370:GetDescendants() do
															if v_u_371:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_371
																	local v372 = v_u_371:GetAttribute("EmitDelay") or 0.05
																	task.delay(v372, function()
																		-- upvalues: (ref) v_u_371
																		v_u_371:Emit(v_u_371:GetAttribute("EmitCount") or v_u_371.Rate)
																	end)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_307 == "QinShi" then
											task.delay(0.4, function()
												-- upvalues: (ref) v_u_311, (ref) v_u_308, (ref) v_u_303
												if v_u_311 and v_u_311.Parent then
													local v373 = v_u_308.Z:FindFirstChild("PunchVFX")
													if v373 then
														local v374 = v373:Clone()
														v374.CFrame = v_u_311.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
														v374.Anchored = true
														v374.CanCollide = false
														v374.Transparency = 1
														v374.CastShadow = false
														v374.CanQuery = false
														v374.Parent = workspace
														v_u_303:AddItem(v374, 3)
														for _, v_u_375 in v374:GetDescendants() do
															if v_u_375:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_375
																	local v376 = v_u_375:GetAttribute("EmitDelay") or 0
																	task.wait(v376)
																	v_u_375:Emit(v_u_375:GetAttribute("EmitCount") or v_u_375.Rate)
																end)
															end
														end
													end
													local v377 = v_u_308.Z:FindFirstChild("EnergyThrust")
													if v377 then
														local v378 = v377:Clone()
														v378.CFrame = v_u_311.CFrame * CFrame.new(0, 0, -25)
														v378.Anchored = true
														v378.CanCollide = false
														v378.Transparency = 1
														v378.CastShadow = false
														v378.CanQuery = false
														v378.Parent = workspace
														v_u_303:AddItem(v378, 3)
														for _, v_u_379 in v378:GetDescendants() do
															if v_u_379:IsA("ParticleEmitter") then
																task.spawn(function()
																	-- upvalues: (copy) v_u_379
																	local v380 = v_u_379:GetAttribute("EmitDelay") or 0
																	task.wait(v380)
																	v_u_379:Emit(v_u_379:GetAttribute("EmitCount") or v_u_379.Rate)
																end)
															end
														end
													end
												end
											end)
											return
										end
										if v_u_307 == "Yuji" then
											task.delay(0.3, function()
												-- upvalues: (ref) v_u_311, (ref) v_u_308, (ref) v_u_303
												if v_u_311 and v_u_311.Parent then
													local v381 = v_u_308.Z
													if v381 then
														local v382 = v381:FindFirstChild("SlamVFX")
														if v382 then
															local v383 = v382:Clone()
															v383:PivotTo(v_u_311.CFrame * CFrame.new(0, -1.5, -5))
															v383.Parent = workspace
															v_u_303:AddItem(v383, 3)
															for _, v384 in v383:GetDescendants() do
																if v384:IsA("BasePart") then
																	v384.Anchored = true
																	v384.CanCollide = false
																	v384.CanQuery = false
																end
															end
															for _, v_u_385 in v383:GetDescendants() do
																if v_u_385:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_385
																		local v386 = v_u_385:GetAttribute("EmitDelay") or 0
																		if v386 > 0 then
																			task.wait(v386)
																		end
																		v_u_385:Emit(v_u_385:GetAttribute("EmitCount") or v_u_385.Rate)
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
										if v_u_307 == "Alucard" then
											local v387 = v_u_74.Alucard
											if v387 and v387["Skill 1"] then
												local v388 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v387["Skill 1"](v388)
												return
											end
										elseif v_u_307 == "GojoV2" then
											local v389 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v389 then
												v389 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v389 then
												local v390 = require(v389)
												if v390["Skill 1"] then
													local v391 = {
														["Caster"] = {
															["Character"] = v_u_310
														}
													}
													v390["Skill 1"](v391)
													return
												end
											end
										elseif v_u_307 == "StrongestInHistory" then
											local v392 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v392 then
												v392 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v392 then
												local v393 = require(v392)
												if v393["Skill 1"] then
													local v394 = {
														["Caster"] = {
															["Character"] = v_u_310
														}
													}
													v393["Skill 1"](v394)
													return
												end
											end
										elseif v_u_307 == "Rimuru" then
											local v395 = v_u_74.Rimuru
											if v395 and v395["Skill 1"] then
												local v396 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v395["Skill 1"](v396)
												return
											end
										elseif v_u_307 == "Madoka" then
											local v397 = v_u_74.Madoka
											if v397 and v397["Skill 1"] then
												local v398 = {
													["Caster"] = {
														["Character"] = v_u_310
													}
												}
												v397["Skill 1"](v398)
												return
											end
										elseif v_u_307 == "Gilgamesh" then
											local v399 = v_u_74.Gilgamesh
											if v399 and v399["Skill 1"] then
												local v400 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v399["Skill 1"](v400)
												return
											end
										elseif v_u_307 == "Anos" then
											local v401 = v_u_74.Anos
											if v401 and v401["Skill 1"] then
												local v402 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v401["Skill 1"](v402)
												return
											end
										elseif v_u_307 == "BlessedMaiden" then
											local v403 = v_u_74.BlessedMaiden
											if v403 and v403["Skill 1"] then
												local v404 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v403["Skill 1"](v404)
												return
											end
										elseif v_u_307 == "Yamato" then
											local v405 = v_u_74.Yamato
											if v405 and v405["Skill 1"] then
												local v406 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v405["Skill 1"](v406)
												return
											end
										elseif v_u_307 == "TrueAizen" then
											local v407 = v_u_74.TrueAizen
											if v407 and v407["Skill 1"] then
												local v408 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v407["Skill 1"](v408)
												return
											end
										else
											task.wait(0.45)
											if not (v_u_311 and v_u_311.Parent) then
												return
											end
											local v409 = v_u_311.CFrame
											local v410 = v_u_308.Z:FindFirstChild("EnergyThrust")
											local v411 = v_u_308.Z:FindFirstChild("EnergyPart")
											if v410 then
												v_u_317(v410, v409 * CFrame.new(0, 2, -35), 3)
											end
											if v411 then
												v_u_317(v411, v409 * CFrame.new(0, 2, -2), 3)
											end
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_302.VFXName == "X" then
						task.spawn(function()
							-- upvalues: (copy) v_u_311, (copy) v_u_307, (copy) v_u_310, (ref) v_u_308, (copy) v_u_303, (copy) v_u_304, (ref) v_u_74, (ref) v_u_3, (copy) p_u_302
							if v_u_311 and v_u_311.Parent then
								if v_u_307 == "Gojo" then
									local v_u_412 = v_u_310:FindFirstChild("Right Arm")
									if v_u_412 then
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_311, (ref) v_u_308, (copy) v_u_412, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												local v413 = v_u_308.X:FindFirstChild("BlueVFXFirst")
												if v413 then
													local v414 = v413:Clone()
													v414.CFrame = v_u_412.CFrame * CFrame.new(0, -1.05, 0)
													v414.Anchored = true
													v414.CanCollide = false
													v414.Transparency = 1
													v414.CastShadow = false
													v414.CanQuery = false
													v414.Parent = workspace
													v_u_303:AddItem(v414, 4)
													for _, v_u_415 in v414:GetDescendants() do
														if v_u_415:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_415
																local v416 = v_u_415:GetAttribute("EmitDelay") or 0
																task.wait(v416)
																v_u_415:Emit(v_u_415:GetAttribute("EmitCount") or v_u_415.Rate)
															end)
														end
													end
													v414.Anchored = false
													local v417 = Instance.new("WeldConstraint")
													v417.Part0 = v_u_412
													v417.Part1 = v414
													v417.Parent = v414
												end
											else
												return
											end
										end)
										task.delay(0.6, function()
											-- upvalues: (ref) v_u_311, (ref) v_u_308, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												local v418 = v_u_311.CFrame
												local v419 = v_u_308.X:FindFirstChild("BlueMainVFX")
												if v419 then
													local v420 = v419:Clone()
													v420.CFrame = v418 * CFrame.new(0, 0, -25)
													v420.Anchored = true
													v420.CanCollide = false
													v420.Transparency = 1
													v420.CastShadow = false
													v420.CanQuery = false
													v420.Parent = workspace
													v_u_303:AddItem(v420, 3)
													for _, v_u_421 in v420:GetDescendants() do
														if v_u_421:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_421
																local v422 = v_u_421:GetAttribute("EmitDelay") or 0
																task.wait(v422)
																v_u_421:Emit(v_u_421:GetAttribute("EmitCount") or v_u_421.Rate)
															end)
														end
													end
												end
												local v423 = v_u_308.X:FindFirstChild("Blue_Additional_VFX")
												if v423 then
													local v424 = v423:Clone()
													v424.CFrame = v418 * CFrame.new(0, 0, -5)
													v424.Anchored = true
													v424.CanCollide = false
													v424.Transparency = 1
													v424.CastShadow = false
													v424.CanQuery = false
													v424.Parent = workspace
													v_u_303:AddItem(v424, 4)
													for _, v_u_425 in v424:GetDescendants() do
														if v_u_425:IsA("ParticleEmitter") then
															task.spawn(function()
																-- upvalues: (copy) v_u_425
																local v426 = v_u_425:GetAttribute("EmitDelay") or 0
																task.wait(v426)
																v_u_425:Emit(v_u_425:GetAttribute("EmitCount") or v_u_425.Rate)
															end)
														end
													end
												end
											end
										end)
									end
								else
									if v_u_307 == "Sukuna" then
										local v427 = v_u_308.X
										if not v427 then
											return
										end
										local v428 = v427:FindFirstChild("GroundVFX")
										if v428 then
											local v_u_429 = v428:Clone()
											v_u_429:PivotTo(v_u_311.CFrame * CFrame.new(0, -2.5, 0))
											v_u_429.Parent = workspace
											v_u_303:AddItem(v_u_429, 3.5)
											local v430 = v_u_429.PrimaryPart or v_u_429:FindFirstChildWhichIsA("BasePart")
											for _, v431 in v_u_429:GetDescendants() do
												if v431:IsA("BasePart") then
													v431.Anchored = false
													v431.CanCollide = false
													v431.CanQuery = false
													v431.CanTouch = false
													v431.Massless = true
												end
											end
											if v430 then
												local v432 = Instance.new("WeldConstraint")
												v432.Part0 = v_u_311
												v432.Part1 = v430
												v432.Parent = v430
											end
											task.delay(2.6, function()
												-- upvalues: (copy) v_u_429
												if v_u_429 and v_u_429.Parent then
													for _, v433 in v_u_429:GetDescendants() do
														if v433:IsA("ParticleEmitter") then
															v433.Enabled = false
														end
													end
												end
											end)
											return
										end
									elseif v_u_307 == "Jinwoo" then
										local v434 = v_u_308.X
										if not v434 then
											return
										end
										local v435 = v434:FindFirstChild("DashVFX")
										local v436 = v434:FindFirstChild("SlashesVFX")
										local v437 = v_u_311.CFrame.LookVector
										local v438 = CFrame.lookAt(v_u_311.Position, v_u_311.Position + v437)
										if v435 then
											local v_u_439 = v435:Clone()
											v_u_439.CFrame = v438
											v_u_439.Anchored = false
											v_u_439.CanCollide = false
											v_u_439.Transparency = 1
											v_u_439.CastShadow = false
											v_u_439.CanQuery = false
											v_u_439.Massless = true
											v_u_439.Parent = workspace
											v_u_303:AddItem(v_u_439, 1.5)
											local v440 = Instance.new("WeldConstraint")
											v440.Part0 = v_u_311
											v440.Part1 = v_u_439
											v440.Parent = v_u_439
											for _, v441 in v_u_439:GetDescendants() do
												if v441:IsA("ParticleEmitter") then
													v441.Enabled = true
													v441:Emit(v441:GetAttribute("EmitCount") or 30)
												end
											end
											task.delay(0.5, function()
												-- upvalues: (copy) v_u_439
												if v_u_439 and v_u_439.Parent then
													for _, v442 in v_u_439:GetDescendants() do
														if v442:IsA("ParticleEmitter") then
															v442.Enabled = false
														end
													end
												end
											end)
										end
										if v436 then
											local v443 = v436:Clone()
											v443.CFrame = v438 * CFrame.new(0, 0, -20)
											v443.Anchored = true
											v443.CanCollide = false
											v443.Transparency = 1
											v443.CastShadow = false
											v443.CanQuery = false
											v443.Parent = workspace
											v_u_303:AddItem(v443, 1.5)
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
											return
										end
									elseif v_u_307 == "Ragna" then
										local v_u_446 = v_u_308.X
										if v_u_446 then
											local v447 = v_u_446:FindFirstChild("GroundVFX")
											if v447 then
												local v448 = v447:Clone()
												v448.CFrame = v_u_311.CFrame * CFrame.new(0, -2.5, 0)
												v448.Anchored = true
												v448.CanCollide = false
												v448.Transparency = 1
												v448.Parent = workspace
												v_u_303:AddItem(v448, 5)
												for _, v_u_449 in v448:GetDescendants() do
													if v_u_449:IsA("ParticleEmitter") then
														task.spawn(function()
															-- upvalues: (copy) v_u_449
															local v450 = v_u_449:GetAttribute("EmitDelay") or 0
															if v450 > 0 then
																task.wait(v450)
															end
															v_u_449:Emit(v_u_449:GetAttribute("EmitCount") or v_u_449.Rate)
														end)
													end
												end
											end
											local v451 = v_u_446:FindFirstChild("ChargeVFX")
											if v451 then
												local v_u_452 = v451:Clone()
												v_u_452.CFrame = v_u_311.CFrame
												v_u_452.Anchored = false
												v_u_452.CanCollide = false
												v_u_452.Transparency = 1
												v_u_452.Massless = true
												v_u_452.Parent = workspace
												v_u_303:AddItem(v_u_452, 1.3)
												local v453 = Instance.new("WeldConstraint")
												v453.Part0 = v_u_311
												v453.Part1 = v_u_452
												v453.Parent = v_u_452
												for _, v454 in v_u_452:GetDescendants() do
													if v454:IsA("ParticleEmitter") then
														v454.Enabled = true
													end
												end
												task.delay(0.4, function()
													-- upvalues: (copy) v_u_452
													if v_u_452 and v_u_452.Parent then
														for _, v455 in v_u_452:GetDescendants() do
															if v455:IsA("ParticleEmitter") then
																v455.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(0.44999999999999996, function()
												-- upvalues: (ref) v_u_311, (copy) v_u_446, (ref) v_u_303
												if v_u_311 and v_u_311.Parent then
													local v456 = v_u_446:FindFirstChild("BarrageVFX")
													if v456 then
														local v_u_457 = v456:Clone()
														v_u_457.CFrame = v_u_311.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_457.Anchored = true
														v_u_457.CanCollide = false
														v_u_457.Transparency = 1
														v_u_457.Parent = workspace
														v_u_303:AddItem(v_u_457, 2.9)
														for _, v458 in v_u_457:GetDescendants() do
															if v458:IsA("ParticleEmitter") then
																v458.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_457
															if v_u_457 and v_u_457.Parent then
																for _, v459 in v_u_457:GetDescendants() do
																	if v459:IsA("ParticleEmitter") then
																		v459.Enabled = false
																	end
																end
															end
														end)
													end
													local v460 = v_u_446:FindFirstChild("BarrageGroundVFX")
													if v460 then
														local v_u_461 = v460:Clone()
														v_u_461.CFrame = v_u_311.CFrame * CFrame.new(0, -37.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
														v_u_461.Anchored = true
														v_u_461.CanCollide = false
														v_u_461.Transparency = 1
														v_u_461.Parent = workspace
														v_u_303:AddItem(v_u_461, 2.7)
														for _, v462 in v_u_461:GetDescendants() do
															if v462:IsA("ParticleEmitter") then
																v462.Enabled = true
															end
														end
														task.delay(1.5, function()
															-- upvalues: (copy) v_u_461
															if v_u_461 and v_u_461.Parent then
																for _, v463 in v_u_461:GetDescendants() do
																	if v463:IsA("ParticleEmitter") then
																		v463.Enabled = false
																	end
																end
															end
														end)
													end
												end
											end)
											task.delay(2, function()
												-- upvalues: (ref) v_u_311, (copy) v_u_446, (ref) v_u_303
												if v_u_311 and v_u_311.Parent then
													local v464 = v_u_446:FindFirstChild("ChargeVFX")
													if v464 then
														local v_u_465 = v464:Clone()
														v_u_465.CFrame = v_u_311.CFrame
														v_u_465.Anchored = false
														v_u_465.CanCollide = false
														v_u_465.Transparency = 1
														v_u_465.Massless = true
														v_u_465.Parent = workspace
														v_u_303:AddItem(v_u_465, 1)
														local v466 = Instance.new("WeldConstraint")
														v466.Part0 = v_u_311
														v466.Part1 = v_u_465
														v466.Parent = v_u_465
														for _, v467 in v_u_465:GetDescendants() do
															if v467:IsA("ParticleEmitter") then
																v467.Enabled = true
															end
														end
														task.delay(0.6, function()
															-- upvalues: (copy) v_u_465
															if v_u_465 and v_u_465.Parent then
																for _, v468 in v_u_465:GetDescendants() do
																	if v468:IsA("ParticleEmitter") then
																		v468.Enabled = false
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
										if v_u_307 == "Aizen" then
											local v469 = v_u_308.X:FindFirstChild("BarrageVFX")
											if v469 then
												local v_u_470 = v469:Clone()
												v_u_470.CFrame = v_u_311.CFrame * CFrame.new(0, 4, -15)
												v_u_470.Anchored = false
												v_u_470.CanCollide = false
												v_u_470.Transparency = 1
												v_u_470.CastShadow = false
												v_u_470.CanQuery = false
												v_u_470.Massless = true
												v_u_470.Parent = workspace
												v_u_303:AddItem(v_u_470, 3.7)
												local v471 = Instance.new("WeldConstraint")
												v471.Part0 = v_u_311
												v471.Part1 = v_u_470
												v471.Parent = v_u_470
												for _, v472 in v_u_470:GetDescendants() do
													if v472:IsA("ParticleEmitter") or (v472:IsA("Beam") or v472:IsA("Trail")) then
														v472.Enabled = true
													end
												end
												task.delay(1.7, function()
													-- upvalues: (copy) v_u_470
													if v_u_470 and v_u_470.Parent then
														for _, v473 in v_u_470:GetDescendants() do
															if v473:IsA("ParticleEmitter") or (v473:IsA("Beam") or v473:IsA("Trail")) then
																v473.Enabled = false
															end
														end
													end
												end)
											end
											task.delay(1.9, function()
												-- upvalues: (ref) v_u_311, (ref) v_u_308, (ref) v_u_303, (ref) v_u_304
												if not (v_u_311 and v_u_311.Parent) then
													return
												end
												local v474 = { 0, 0 }
												local v475 = {
													{ 180, 180, 135 },
													{ 180, 180, 45 }
												}
												for v476 = 1, 2 do
													if not (v_u_311 and v_u_311.Parent) then
														break
													end
													local v477 = v474[v476]
													local v478 = v475[v476][1]
													local v479 = v475[v476][2]
													local v480 = v475[v476][3]
													local v481 = v_u_311.CFrame * CFrame.Angles(0, math.rad(v477), 0)
													local v482 = v481.Position
													local v483 = v482 + v481.LookVector * 80
													local v484 = CFrame.Angles(math.rad(v478), math.rad(v479), (math.rad(v480)))
													local v485 = CFrame.lookAt(v482, v483) * v484
													local v486 = CFrame.lookAt(v483, v483 + v481.LookVector) * v484
													local v487 = v_u_308.X:FindFirstChild("StartVFX")
													if v487 then
														local v488 = v487:Clone()
														v488.CFrame = v485
														v488.Anchored = true
														v488.CanCollide = false
														v488.Transparency = 1
														v488.Parent = workspace
														v_u_303:AddItem(v488, 2)
														for _, v489 in v488:GetDescendants() do
															if v489:IsA("ParticleEmitter") then
																v489:Emit(v489:GetAttribute("EmitCount") or v489.Rate)
															end
														end
													end
													local v490 = v_u_308.X:FindFirstChild("SlashVFX")
													if v490 then
														local v_u_491 = v490:Clone()
														v_u_491.CFrame = v485
														v_u_491.Anchored = true
														v_u_491.CanCollide = false
														v_u_491.Transparency = 1
														v_u_491.Parent = workspace
														v_u_303:AddItem(v_u_491, 3)
														for _, v492 in v_u_491:GetDescendants() do
															if v492:IsA("ParticleEmitter") or (v492:IsA("Beam") or v492:IsA("Trail")) then
																v492.Enabled = true
															end
														end
														local v493 = v_u_304:Create(v_u_491, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
															["CFrame"] = v486
														})
														v493:Play()
														v493.Completed:Connect(function()
															-- upvalues: (copy) v_u_491
															for _, v494 in v_u_491:GetDescendants() do
																if v494:IsA("ParticleEmitter") or (v494:IsA("Beam") or v494:IsA("Trail")) then
																	v494.Enabled = false
																end
															end
														end)
													end
													if v476 < 2 then
														task.wait(0.3)
													end
												end
											end)
											return
										end
										if v_u_307 == "QinShi" then
											task.delay(0.5, function()
												-- upvalues: (ref) v_u_311, (ref) v_u_308, (ref) v_u_303
												if v_u_311 and v_u_311.Parent then
													local v495 = v_u_308:FindFirstChild("X")
													if v495 then
														local v496 = v495:FindFirstChild("StompVFX")
														if v496 then
															local v497 = v_u_311.Position - Vector3.new(0, 2.5, 0)
															local v498 = v496:Clone()
															local v499 = v498:FindFirstChild("Main")
															local v500 = v498:FindFirstChild("Lightning")
															if v499 then
																v499.CFrame = CFrame.new(v497)
																v499.Anchored = true
																v499.CanCollide = false
																v499.Transparency = 1
															end
															if v500 then
																v500.CFrame = CFrame.new(v497 + Vector3.new(0, 13, 0))
																v500.Anchored = true
																v500.CanCollide = false
																v500.Transparency = 1
															end
															v498.Parent = workspace
															v_u_303:AddItem(v498, 3)
															for _, v_u_501 in v498:GetDescendants() do
																if v_u_501:IsA("ParticleEmitter") then
																	task.spawn(function()
																		-- upvalues: (copy) v_u_501
																		local v502 = v_u_501:GetAttribute("EmitDelay") or 0
																		task.wait(v502)
																		v_u_501:Emit(v_u_501:GetAttribute("EmitCount") or v_u_501.Rate)
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
										if v_u_307 == "Yuji" then
											local v503 = v_u_308.X
											local v504 = v503 and v503:FindFirstChild("BarrageVFX")
											if v504 then
												local v_u_505 = v504:Clone()
												v_u_505.CFrame = v_u_311.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, -1.5707963267948966, 0)
												v_u_505.Anchored = false
												v_u_505.CanCollide = false
												v_u_505.Transparency = 1
												v_u_505.CastShadow = false
												v_u_505.CanQuery = false
												v_u_505.Massless = true
												v_u_505.Parent = workspace
												v_u_303:AddItem(v_u_505, 4)
												local v506 = Instance.new("WeldConstraint")
												v506.Part0 = v_u_311
												v506.Part1 = v_u_505
												v506.Parent = v_u_505
												for _, v507 in v_u_505:GetDescendants() do
													if v507:IsA("ParticleEmitter") then
														v507.Enabled = true
													end
												end
												task.delay(3.2, function()
													-- upvalues: (copy) v_u_505
													if v_u_505 and v_u_505.Parent then
														for _, v508 in v_u_505:GetDescendants() do
															if v508:IsA("ParticleEmitter") then
																v508.Enabled = false
															end
														end
													end
												end)
												return
											end
										elseif v_u_307 == "Alucard" then
											local v509 = v_u_74.Alucard
											if v509 and v509["Skill 2"] then
												local v510 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v509["Skill 2"](v510)
												return
											end
										elseif v_u_307 == "GojoV2" then
											local v511 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v511 then
												v511 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
											end
											if v511 then
												local v512 = require(v511)
												if v512["Skill 2"] then
													v512["Skill 2"]({
														["Caster"] = {
															["Character"] = v_u_310
														},
														["Duration"] = p_u_302.Duration or 6
													})
													return
												end
											end
										elseif v_u_307 == "StrongestInHistory" then
											local v513 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v513 then
												v513 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
											end
											if v513 then
												local v514 = require(v513)
												if v514["Skill 2"] then
													local v515 = {
														["Caster"] = {
															["Character"] = v_u_310
														}
													}
													v514["Skill 2"](v515)
													return
												end
											end
										elseif v_u_307 == "Ichigo" then
											local v516 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
											if v516 then
												v516 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("Ichigo")
											end
											if v516 then
												local v517 = require(v516)
												if v517 and v517["Skill 2"] then
													local v518 = {
														["Caster"] = {
															["Character"] = v_u_310
														},
														["Duration"] = 4
													}
													v517["Skill 2"](v518)
													return
												end
											end
										elseif v_u_307 == "Rimuru" then
											local v519 = v_u_74.Rimuru
											if v519 and v519["Skill 2"] then
												local v520 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v519["Skill 2"](v520)
												return
											end
										elseif v_u_307 == "Madoka" then
											local v521 = v_u_74.Madoka
											if v521 and v521["Skill 2"] then
												v521["Skill 2"]({
													["Caster"] = {
														["Character"] = v_u_310
													},
													["Position"] = v_u_311 and v_u_311.Position + v_u_311.CFrame.LookVector * 50 or nil
												})
												return
											end
										elseif v_u_307 == "Gilgamesh" then
											local v522 = v_u_74.Gilgamesh
											if v522 and v522["Skill 2"] then
												local v523 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v522["Skill 2"](v523)
												return
											end
										elseif v_u_307 == "Anos" then
											local v524 = v_u_74.Anos
											if v524 and v524["Skill 2"] then
												local v525 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v524["Skill 2"](v525)
												return
											end
										elseif v_u_307 == "BlessedMaiden" then
											local v526 = v_u_74.BlessedMaiden
											if v526 and v526["Skill 2"] then
												local v527 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v526["Skill 2"](v527)
												return
											end
										elseif v_u_307 == "Yamato" then
											local v528 = v_u_74.Yamato
											if v528 and v528["Skill 2"] then
												local v529 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v528["Skill 2"](v529)
												return
											end
										elseif v_u_307 == "TrueAizen" then
											local v530 = v_u_74.TrueAizen
											if v530 and v530["Skill 2"] then
												local v531 = {
													["Caster"] = {
														["Character"] = v_u_310
													},
													["AbilityConfig"] = {}
												}
												v530["Skill 2"](v531)
												return
											end
										else
											task.wait(0.35)
											if not (v_u_311 and v_u_311.Parent) then
												return
											end
											local v532 = v_u_311.CFrame
											local v533 = v_u_308.X:FindFirstChild("EnergySlashes")
											if not v533 then
												return
											end
											local v_u_534 = v533:Clone()
											v_u_534.CFrame = v532 * CFrame.new(0, 1.5, -20)
											v_u_534.Anchored = false
											v_u_534.CanCollide = false
											v_u_534.Transparency = 1
											v_u_534.CastShadow = false
											v_u_534.CanQuery = false
											v_u_534.Massless = true
											v_u_534.Parent = workspace
											v_u_303:AddItem(v_u_534, 4)
											local v535 = Instance.new("WeldConstraint")
											v535.Part0 = v_u_534
											v535.Part1 = v_u_311
											v535.Parent = v_u_534
											v_u_303:AddItem(v535, 2.06)
											task.delay(2.05, function()
												-- upvalues: (copy) v_u_534
												for _, v536 in v_u_534:GetDescendants() do
													if v536:IsA("ParticleEmitter") then
														v536.Enabled = false
													end
												end
												v_u_534.Anchored = true
											end)
										end
									end
									return
								end
							else
								return
							end
						end)
					elseif p_u_302.VFXName == "C" then
						task.spawn(function()
							-- upvalues: (copy) v_u_311, (copy) v_u_307, (ref) v_u_3, (copy) v_u_310, (copy) p_u_302, (ref) v_u_308, (copy) v_u_303, (ref) v_u_74, (copy) v_u_323, (copy) v_u_329
							if v_u_311 and v_u_311.Parent then
								if v_u_307 == "GojoV2" then
									local v537 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v537 then
										v537 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v537 then
										local v538 = require(v537)
										if v538["Skill 3"] then
											local v539 = v538["Skill 3"]
											local v540 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["Duration"] = p_u_302.Duration or 6
											}
											v539(v540)
										end
									end
									return
								elseif v_u_307 == "StrongestInHistory" then
									local v541 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v541 then
										v541 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v541 then
										local v_u_542 = require(v541)
										if v_u_542["Skill 3"] then
											local v543 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["ChargeTime"] = 2.5
											}
											v_u_542["Skill 3"](v543)
										end
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_311, (copy) v_u_542, (ref) v_u_310
											if v_u_311 and v_u_311.Parent then
												local v544 = v_u_311.Position + v_u_311.CFrame.LookVector * 85
												if v_u_542["Skill 3"] then
													local v545 = v_u_542["Skill 3"]
													local v546 = {
														["Caster"] = {
															["Character"] = v_u_310
														},
														["Phase"] = "Explosion",
														["Position"] = v544,
														["CFrame"] = CFrame.new(v544),
														["DOTDuration"] = 3.5
													}
													v545(v546)
												end
											end
										end)
									end
									return
								elseif v_u_307 == "Gojo" then
									local v547 = v_u_308.C:FindFirstChild("DamageVFX")
									if v547 then
										local v548 = v547:Clone()
										v548.CFrame = v_u_311.CFrame
										v548.Anchored = false
										v548.CanCollide = false
										v548.Transparency = 1
										v548.Massless = true
										v548.Parent = workspace
										local v549 = Instance.new("WeldConstraint")
										v549.Part0 = v548
										v549.Part1 = v_u_311
										v549.Parent = v548
										for _, v550 in v548:GetDescendants() do
											if v550:IsA("ParticleEmitter") then
												v550:Emit(v550:GetAttribute("EmitCount") or 30)
											end
										end
										v_u_303:AddItem(v548, 3)
									end
									return
								elseif v_u_307 == "Jinwoo" then
									local v551 = v_u_308.C
									if v551 then
										local v552 = v551:FindFirstChild("EnergySlashes")
										local v553 = v551:FindFirstChild("ShadowVFX")
										if v552 then
											local v_u_554 = v552:Clone()
											v_u_554.CFrame = v_u_311.CFrame * CFrame.new(0, 3.9, 0)
											v_u_554.Anchored = false
											v_u_554.CanCollide = false
											v_u_554.Transparency = 1
											v_u_554.CastShadow = false
											v_u_554.CanQuery = false
											v_u_554.Massless = true
											v_u_554.Parent = workspace
											v_u_303:AddItem(v_u_554, 3.65)
											local v555 = Instance.new("WeldConstraint")
											v555.Part0 = v_u_311
											v555.Part1 = v_u_554
											v555.Parent = v_u_554
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_554
												if v_u_554 and v_u_554.Parent then
													for _, v556 in v_u_554:GetDescendants() do
														if v556:IsA("ParticleEmitter") then
															v556:Emit(v556:GetAttribute("EmitCount") or v556.Rate)
															v556.Enabled = false
														end
													end
												end
											end)
										end
										if v553 then
											local v_u_557 = v553:Clone()
											v_u_557.CFrame = v_u_311.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
											v_u_557.Anchored = false
											v_u_557.CanCollide = false
											v_u_557.Transparency = 1
											v_u_557.CastShadow = false
											v_u_557.CanQuery = false
											v_u_557.Massless = true
											v_u_557.Parent = workspace
											v_u_303:AddItem(v_u_557, 2.65)
											local v558 = Instance.new("WeldConstraint")
											v558.Part0 = v_u_311
											v558.Part1 = v_u_557
											v558.Parent = v_u_557
											for _, v_u_559 in v_u_557:GetDescendants() do
												if v_u_559:IsA("ParticleEmitter") then
													task.spawn(function()
														-- upvalues: (copy) v_u_559
														local v560 = v_u_559:GetAttribute("EmitDelay") or 0
														if v560 > 0 then
															task.wait(v560)
														end
														v_u_559:Emit(v_u_559:GetAttribute("EmitCount") or v_u_559.Rate)
													end)
												end
											end
											task.delay(1.8499999999999999, function()
												-- upvalues: (copy) v_u_557
												if v_u_557 and v_u_557.Parent then
													for _, v561 in v_u_557:GetDescendants() do
														if v561:IsA("ParticleEmitter") then
															v561.Enabled = false
														end
													end
												end
											end)
										end
									end
								elseif v_u_307 == "Ragna" then
									local v562 = v_u_308.C
									if v562 then
										local v_u_563 = v562:FindFirstChild("Sword")
										local v_u_564 = v562:FindFirstChild("StartVFX")
										local v_u_565 = v562:FindFirstChild("ExpVFX")
										if v_u_563 then
											local v_u_566 = {}
											local v_u_567 = {}
											for _ = 1, 6 do
												local v568 = 4 + math.random() * 4
												local v569 = (math.random() - 0.5) * 2 * 6
												local v570 = -(3 + math.random() * 3)
												local v571 = {
													["offset"] = Vector3.new(v569, v568, v570)
												}
												table.insert(v_u_566, v571)
											end
											local v_u_572 = 0
											task.spawn(function()
												-- upvalues: (ref) v_u_572, (ref) v_u_311, (copy) v_u_566, (copy) v_u_563, (ref) v_u_303, (copy) v_u_564, (copy) v_u_567
												while v_u_572 < 6 and (v_u_311 and v_u_311.Parent) do
													local v573 = 6 - v_u_572
													local v574 = math.min(2, v573)
													for v575 = 1, v574 do
														local v576 = v_u_566[v_u_572 + v575]
														local v577 = v_u_311.CFrame
														local v578 = v577:VectorToWorldSpace(v576.offset)
														local v579 = v577.Position + v578
														local v580 = v_u_563:Clone()
														v580.CFrame = CFrame.new(v579) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
														v580.Anchored = true
														v580.CanCollide = false
														v580.CanQuery = false
														v580.Transparency = 0
														v580.Parent = workspace
														v_u_303:AddItem(v580, 3)
														if v_u_564 then
															local v581 = v_u_564:Clone()
															v581.CFrame = v580.CFrame
															v581.Anchored = true
															v581.CanCollide = false
															v581.Transparency = 1
															v581.Parent = workspace
															v_u_303:AddItem(v581, 1)
															for _, v582 in v581:GetDescendants() do
																if v582:IsA("ParticleEmitter") then
																	v582:Emit(v582:GetAttribute("EmitCount") or 20)
																end
															end
														end
														local v583 = v_u_567
														table.insert(v583, {
															["sword"] = v580,
															["spawnData"] = v576
														})
													end
													v_u_572 = v_u_572 + v574
													task.wait(0.25)
												end
											end)
											local v584 = game:GetService("RunService")
											local v_u_585 = nil
											v_u_585 = v584.Heartbeat:Connect(function()
												-- upvalues: (ref) v_u_311, (ref) v_u_585, (copy) v_u_567
												if v_u_311 and v_u_311.Parent then
													local v586 = (1 / 0)
													local v587 = nil
													for _, v588 in ipairs(game.Players:GetPlayers()) do
														if v588.Character and v588.Character:FindFirstChild("HumanoidRootPart") then
															local v589 = v588.Character.HumanoidRootPart
															local v590 = (v589.Position - v_u_311.Position).Magnitude
															if v590 < v586 and v590 < 150 then
																v587 = v589.Position
																v586 = v590
															end
														end
													end
													for _, v591 in ipairs(v_u_567) do
														local v592 = v591.sword
														if v592 and (v592.Parent and not v591.launched) then
															local v593 = v592.Position
															local v594
															if v587 then
																local v595 = v587 - v593
																if v595.Magnitude > 0.1 then
																	local v596 = v595.Unit
																	v594 = CFrame.lookAt(v593, v593 + v596) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793)
																else
																	v594 = CFrame.new(v593) * CFrame.Angles(1.5707963267948966, 0, 0)
																end
															else
																v594 = CFrame.new(v593) * v_u_311.CFrame.Rotation * CFrame.Angles(1.5707963267948966, 0, 0)
															end
															v592.CFrame = v592.CFrame:Lerp(v594, 0.12)
														end
													end
												elseif v_u_585 then
													v_u_585:Disconnect()
												end
											end)
											task.delay(1.05, function()
												-- upvalues: (ref) v_u_585, (ref) v_u_311, (copy) v_u_567, (copy) v_u_565, (ref) v_u_303
												if v_u_585 then
													v_u_585:Disconnect()
												end
												if v_u_311 and v_u_311.Parent then
													local v597 = v_u_311.Position + v_u_311.CFrame.LookVector * 30
													local v598 = (1 / 0)
													for _, v599 in ipairs(game.Players:GetPlayers()) do
														if v599.Character and v599.Character:FindFirstChild("HumanoidRootPart") then
															local v600 = v599.Character.HumanoidRootPart
															local v601 = (v600.Position - v_u_311.Position).Magnitude
															if v601 < v598 and v601 < 150 then
																v597 = v600.Position
																v598 = v601
															end
														end
													end
													local v_u_602 = CFrame.new(v597)
													for v603, v_u_604 in ipairs(v_u_567) do
														task.delay((v603 - 1) * 0.1, function()
															-- upvalues: (copy) v_u_604, (copy) v_u_602, (ref) v_u_565, (ref) v_u_303
															local v_u_605 = v_u_604.sword
															if v_u_605 and v_u_605.Parent then
																v_u_604.launched = true
																local v_u_606 = v_u_605.Position
																local v607 = v_u_602.Position
																local v608 = math.random(-8, 8)
																local v609 = math.random
																local v_u_610 = v607 + Vector3.new(v608, 0, v609(-8, 8))
																local v611 = (v_u_606 + v_u_610) / 2
																local v612 = math.random(-60, 60)
																local v613 = math.rad(v612)
																local v614 = 12 + math.random() * 5
																local v615 = math.sin(v613) * 5
																local v616 = math.cos(v613) * 5
																local v_u_617 = v611 + Vector3.new(v615, v614, v616)
																local v_u_618 = tick()
																task.spawn(function()
																	-- upvalues: (copy) v_u_618, (copy) v_u_606, (copy) v_u_617, (copy) v_u_610, (copy) v_u_605, (ref) v_u_565, (ref) v_u_303
																	while tick() - v_u_618 < 0.4 do
																		local v619 = (tick() - v_u_618) / 0.4
																		local v620 = v_u_606
																		local v621 = v_u_617
																		local v622 = v_u_610
																		local v623 = 1 - v619
																		local v624 = v623 * v623 * v620 + 2 * v623 * v619 * v621 + v619 * v619 * v622
																		local v625 = v619 + 0.05
																		local v626 = math.min(v625, 1)
																		local v627 = v_u_606
																		local v628 = v_u_617
																		local v629 = v_u_610
																		local v630 = 1 - v626
																		local v631 = v630 * v630 * v627 + 2 * v630 * v626 * v628 + v626 * v626 * v629 - v624
																		if v_u_605 and (v_u_605.Parent and v631.Magnitude > 0.01) then
																			v_u_605.CFrame = CFrame.lookAt(v624, v624 + v631.Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
																		end
																		task.wait()
																	end
																	if v_u_565 and (v_u_605 and v_u_605.Parent) then
																		local v632 = v_u_565:Clone()
																		v632.CFrame = CFrame.new(v_u_610)
																		v632.Anchored = true
																		v632.CanCollide = false
																		v632.Transparency = 1
																		v632.Parent = workspace
																		v_u_303:AddItem(v632, 1.5)
																		for _, v633 in v632:GetDescendants() do
																			if v633:IsA("ParticleEmitter") then
																				v633:Emit(v633:GetAttribute("EmitCount") or 30)
																			end
																		end
																	end
																	if v_u_605 and v_u_605.Parent then
																		v_u_605:Destroy()
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
								elseif v_u_307 == "Aizen" then
									local v_u_634 = v_u_308.C
									if v_u_634 then
										local v_u_635 = {}
										local function v_u_641(p636, p637)
											-- upvalues: (ref) v_u_311, (ref) v_u_303
											if not p636 then
												return nil
											end
											local v638 = p636:Clone()
											v638.CFrame = v_u_311.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
											v638.Anchored = false
											v638.CanCollide = false
											v638.Transparency = 1
											v638.CastShadow = false
											v638.CanQuery = false
											v638.Massless = true
											v638.Parent = workspace
											v_u_303:AddItem(v638, p637)
											local v639 = Instance.new("WeldConstraint")
											v639.Part0 = v_u_311
											v639.Part1 = v638
											v639.Parent = v638
											for _, v640 in v638:GetDescendants() do
												if v640:IsA("ParticleEmitter") or (v640:IsA("Beam") or v640:IsA("Trail")) then
													v640.Enabled = true
												end
											end
											return v638
										end
										local v642 = v_u_641(v_u_634:FindFirstChild("ChargeVFX"), 4)
										if v642 then
											table.insert(v_u_635, v642)
										end
										local v643 = v_u_641(v_u_634:FindFirstChild("AuraVFX1"), 4)
										if v643 then
											table.insert(v_u_635, v643)
										end
										task.delay(0.25, function()
											-- upvalues: (ref) v_u_311, (copy) v_u_641, (copy) v_u_634, (copy) v_u_635
											if v_u_311 and v_u_311.Parent then
												local v644 = v_u_641(v_u_634:FindFirstChild("AuraVFX2"), 3.75)
												if v644 then
													local v645 = v_u_635
													table.insert(v645, v644)
												end
											end
										end)
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_311, (copy) v_u_641, (copy) v_u_634, (copy) v_u_635
											if v_u_311 and v_u_311.Parent then
												local v646 = v_u_641(v_u_634:FindFirstChild("AuraVFX3"), 3.5)
												if v646 then
													local v647 = v_u_635
													table.insert(v647, v646)
												end
											end
										end)
										task.delay(3, function()
											-- upvalues: (copy) v_u_635
											for _, v648 in pairs(v_u_635) do
												if v648 and v648.Parent then
													for _, v649 in v648:GetDescendants() do
														if v649:IsA("ParticleEmitter") or (v649:IsA("Beam") or v649:IsA("Trail")) then
															v649.Enabled = false
														end
													end
												end
											end
										end)
									end
								elseif v_u_307 == "Rimuru" then
									return
								elseif v_u_307 == "Yamato" then
									return
								elseif v_u_307 == "TrueAizen" then
									local v650 = v_u_74.TrueAizen
									if v650 and v650["Skill 3"] then
										local v651 = {
											["Caster"] = {
												["Character"] = v_u_310
											},
											["AbilityConfig"] = {}
										}
										v650["Skill 3"](v651)
									end
									return
								else
									local v652 = v_u_308.C:FindFirstChild("FirstEffects")
									if v652 then
										local v_u_653 = v652:Clone()
										for _, v654 in v_u_653:GetDescendants() do
											if v654:IsA("BasePart") then
												v654.Anchored = true
												v654.CanCollide = false
												v654.CanQuery = false
												v654.CanTouch = false
												v654.CastShadow = false
												v654.Transparency = 1
											end
										end
										v_u_653:PivotTo(v_u_311.CFrame * CFrame.new(0, -2, 0))
										v_u_653.Parent = workspace
										v_u_303:AddItem(v_u_653, 6)
										task.delay(4.85, function()
											-- upvalues: (copy) v_u_653
											for _, v655 in v_u_653:GetDescendants() do
												if v655:IsA("ParticleEmitter") then
													v655.Enabled = false
												end
											end
										end)
									end
									task.wait(3.85)
									if v_u_311 and v_u_311.Parent then
										local v_u_656 = v_u_311.CFrame
										local v657 = v_u_308.C:FindFirstChild("HorizontalBeam")
										if v657 then
											local v658 = v657:Clone()
											for _, v659 in v658:GetDescendants() do
												if v659:IsA("BasePart") then
													v659.Anchored = true
													v659.CanCollide = false
													v659.CanQuery = false
													v659.CanTouch = false
													v659.CastShadow = false
													v659.Massless = true
													v659.Transparency = 1
												end
												if v659:IsA("Beam") then
													v659.Enabled = false
												end
											end
											v658:PivotTo(v_u_656 * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0))
											v658.Parent = workspace
											v_u_303:AddItem(v658, 6)
											local v660 = {
												["BigBeam1"] = 0,
												["BigBeam2"] = 0.25,
												["BigBeams3"] = 0.5
											}
											local v661 = {
												["BigBeam1"] = 0.36,
												["BigBeam2"] = 0.61,
												["BigBeams3"] = 0.76
											}
											for _, v_u_662 in v658:GetChildren() do
												if v_u_662:IsA("Model") then
													local v_u_663 = v_u_662:FindFirstChild("Beam")
													local v664 = v660[v_u_662.Name] or 0
													local v665 = v661[v_u_662.Name] or 2
													task.delay(v664, function()
														-- upvalues: (copy) v_u_663, (ref) v_u_323, (copy) v_u_662
														if v_u_663 then
															v_u_323(v_u_663, 0.3)
														end
														for _, v666 in v_u_662:GetDescendants() do
															if v666:IsA("ParticleEmitter") and not (v_u_663 and v666:IsDescendantOf(v_u_663)) then
																v666:Emit(v666:GetAttribute("EmitCount") or 10)
															end
														end
													end)
													task.delay(v665, function()
														-- upvalues: (copy) v_u_663, (ref) v_u_329
														if v_u_663 then
															v_u_329(v_u_663, 0.5)
														end
													end)
												end
											end
										end
										task.delay(0.8, function()
											-- upvalues: (ref) v_u_311, (ref) v_u_308, (copy) v_u_656, (ref) v_u_303, (ref) v_u_329
											if v_u_311 and v_u_311.Parent then
												local v667 = v_u_308.C:FindFirstChild("Explosion")
												if v667 then
													local v_u_668 = v667:Clone()
													for _, v669 in v_u_668:GetDescendants() do
														if v669:IsA("BasePart") then
															v669.Anchored = true
															v669.CanCollide = false
															v669.CanQuery = false
															v669.CanTouch = false
															v669.CastShadow = false
															v669.Transparency = 1
														end
													end
													v_u_668:PivotTo(v_u_656 * CFrame.new(0, 8, -75) * CFrame.Angles(0, 0, 1.5707963267948966))
													v_u_668.Parent = workspace
													v_u_303:AddItem(v_u_668, 5)
													task.delay(2, function()
														-- upvalues: (ref) v_u_329, (copy) v_u_668
														v_u_329(v_u_668, 0.5)
														for _, v670 in v_u_668:GetDescendants() do
															if v670:IsA("ParticleEmitter") then
																v670.Enabled = false
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
						if v_u_307 == "QinShi" then
							task.spawn(function()
								-- upvalues: (copy) v_u_311, (ref) v_u_308, (copy) v_u_303
								if v_u_311 and v_u_311.Parent then
									local v671 = v_u_308:FindFirstChild("C")
									if v671 then
										local v672 = v671:FindFirstChild("BarrageVFX")
										if v672 then
											local v_u_673 = v672:Clone()
											v_u_673.CFrame = v_u_311.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
											v_u_673.Anchored = false
											v_u_673.CanCollide = false
											v_u_673.CanQuery = false
											v_u_673.CanTouch = false
											v_u_673.Transparency = 1
											v_u_673.CastShadow = false
											v_u_673.Parent = workspace
											local v674 = Instance.new("WeldConstraint")
											v674.Part0 = v_u_673
											v674.Part1 = v_u_311
											v674.Parent = v_u_673
											for _, v675 in v_u_673:GetDescendants() do
												if v675:IsA("ParticleEmitter") then
													v675.Enabled = true
												end
											end
											task.delay(3, function()
												-- upvalues: (copy) v_u_673
												if v_u_673 and v_u_673.Parent then
													for _, v676 in v_u_673:GetDescendants() do
														if v676:IsA("ParticleEmitter") then
															v676.Enabled = false
														end
													end
												end
											end)
											v_u_303:AddItem(v_u_673, 4)
										end
									end
								else
									return
								end
							end)
						end
						if v_u_307 == "Yuji" then
							task.spawn(function()
								-- upvalues: (copy) v_u_311, (ref) v_u_308, (copy) v_u_303
								if v_u_311 and v_u_311.Parent then
									local v_u_677 = v_u_308:FindFirstChild("C")
									if v_u_677 then
										local v678 = v_u_677:FindFirstChild("AuraVFX3")
										if v678 then
											local v_u_679 = v678:Clone()
											v_u_679.CFrame = v_u_311.CFrame
											v_u_679.Anchored = false
											v_u_679.CanCollide = false
											v_u_679.Transparency = 1
											v_u_679.Massless = true
											v_u_679.Parent = workspace
											local v680 = Instance.new("WeldConstraint")
											v680.Part0 = v_u_311
											v680.Part1 = v_u_679
											v680.Parent = v_u_679
											for _, v681 in v_u_679:GetDescendants() do
												if v681:IsA("ParticleEmitter") then
													v681.Enabled = true
												end
											end
											task.delay(0.8, function()
												-- upvalues: (copy) v_u_679
												if v_u_679 and v_u_679.Parent then
													for _, v682 in v_u_679:GetDescendants() do
														if v682:IsA("ParticleEmitter") then
															v682.Enabled = false
														end
													end
												end
											end)
											v_u_303:AddItem(v_u_679, 2)
										end
										task.delay(0.5, function()
											-- upvalues: (ref) v_u_311, (copy) v_u_677, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												local v683 = v_u_677:FindFirstChild("BlackFlashVFX3")
												if v683 then
													local v684 = v683:Clone()
													v684.CFrame = v_u_311.CFrame * CFrame.new(0, 0, -10)
													v684.Anchored = true
													v684.CanCollide = false
													v684.Transparency = 1
													v684.Parent = workspace
													for _, v685 in v684:GetDescendants() do
														if v685:IsA("ParticleEmitter") then
															v685:Emit(v685:GetAttribute("EmitCount") or v685.Rate)
														end
													end
													v_u_303:AddItem(v684, 3)
												end
											end
										end)
									end
								else
									return
								end
							end)
						end
						if v_u_307 == "Alucard" then
							local v686 = v_u_74.Alucard
							if v686 and v686["Skill 3"] then
								v686["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_310
									},
									["DamageDelay"] = 2.5,
									["Duration"] = 5,
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_307 == "Ichigo" then
							local v687 = v_u_74.Ichigo
							if v687 and v687["Skill 3"] then
								v687["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_310
									},
									["ChargeTime"] = 3.5,
									["SlashCount"] = 1,
									["SlashInterval"] = 0.15,
									["SlashDistance"] = 80,
									["SlashSpeed"] = 180
								})
							end
						end
						if v_u_307 == "Rimuru" then
							local v688 = v_u_74.Rimuru
							if v688 and v688["Skill 3"] then
								v688["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_310
									},
									["DamageDelay"] = 2.5,
									["Duration"] = 5,
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_307 == "Madoka" then
							local v689 = v_u_74.Madoka
							if v689 and v689["Skill 3"] then
								v689["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_310
									},
									["DamageDelay"] = 1.03,
									["Duration"] = 3.97
								})
							end
						end
						if v_u_307 == "Gilgamesh" then
							local v690 = v_u_74.Gilgamesh
							if v690 and v690["Skill 3"] then
								v690["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_310
									},
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_307 == "Anos" then
							local v691 = v_u_74.Anos
							if v691 and v691["Skill 3"] then
								v691["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_310
									},
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_307 == "BlessedMaiden" then
							local v692 = v_u_74.BlessedMaiden
							if v692 and v692["Skill 3"] then
								v692["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_310
									},
									["AbilityConfig"] = {}
								})
							end
						end
						if v_u_307 == "Yamato" then
							local v693 = v_u_74.Yamato
							if v693 and v693["Skill 3"] then
								v693["Skill 3"]({
									["Caster"] = {
										["Character"] = v_u_310
									},
									["AbilityConfig"] = {}
								})
							end
						end
					elseif p_u_302.VFXName == "V" then
						task.spawn(function()
							-- upvalues: (copy) v_u_311, (copy) v_u_307, (ref) v_u_3, (copy) v_u_310, (ref) v_u_308, (copy) v_u_303, (copy) v_u_304, (copy) p_u_302, (ref) v_u_301, (ref) v_u_37, (ref) v_u_74
							if v_u_311 and v_u_311.Parent then
								if v_u_307 == "GojoV2" then
									local v694 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v694 then
										v694 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestOfToday")
									end
									if v694 then
										local v695 = require(v694)
										if v695["Skill 4"] then
											local v696 = {
												["Caster"] = {
													["Character"] = v_u_310
												}
											}
											v695["Skill 4"](v696)
										end
									end
									return
								elseif v_u_307 == "StrongestInHistory" then
									local v697 = v_u_3:FindFirstChild("AbilitySystem") and v_u_3.AbilitySystem:FindFirstChild("VFXHandlers")
									if v697 then
										v697 = v_u_3.AbilitySystem.VFXHandlers:FindFirstChild("StrongestInHistory")
									end
									if v697 then
										local v698 = require(v697)
										if v698["Skill 4"] then
											local v699 = v698["Skill 4"]
											local v700 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["CutsceneDuration"] = 6.5,
												["DamageDelay"] = 5,
												["CharAnimationId"] = "rbxassetid://125013796988038"
											}
											local v701 = v_u_311
											if v701 then
												v701 = v_u_311.CFrame
											end
											v700.CFrame = v701
											v699(v700)
										end
									end
								else
									if v_u_307 == "Gojo" then
										local v_u_702 = v_u_308.V
										if not v_u_702 then
											return
										end
										local v_u_703 = Instance.new("Attachment")
										v_u_703.Name = "BlueAtt"
										v_u_703.Position = Vector3.new(7, 2, 5)
										v_u_703.Parent = v_u_311
										local v_u_704 = Instance.new("Attachment")
										v_u_704.Name = "RedAtt"
										v_u_704.Position = Vector3.new(-7, 2, 5)
										v_u_704.Parent = v_u_311
										local v_u_705 = nil
										local v_u_706 = nil
										local function v_u_715(p707, p708)
											-- upvalues: (copy) v_u_702, (ref) v_u_311
											local v709 = v_u_702:FindFirstChild(p707)
											if not v709 then
												return nil
											end
											local v710 = v709:Clone()
											v710.CFrame = v_u_311.CFrame * CFrame.new(p708.Position)
											v710.Anchored = true
											v710.CanCollide = false
											v710.Massless = true
											v710.Transparency = 1
											v710.Parent = workspace
											local v711 = Instance.new("Attachment")
											v711.Parent = v710
											local v712 = Instance.new("AlignPosition")
											v712.Attachment0 = v711
											v712.Attachment1 = p708
											v712.RigidityEnabled = false
											v712.Responsiveness = 100
											v712.MaxForce = (1 / 0)
											v712.Parent = v710
											local v713 = Instance.new("AlignOrientation")
											v713.Attachment0 = v711
											v713.Attachment1 = p708
											v713.RigidityEnabled = false
											v713.Responsiveness = 100
											v713.MaxTorque = (1 / 0)
											v713.Parent = v710
											v710.Anchored = false
											for _, v714 in v710:GetDescendants() do
												if v714:IsA("ParticleEmitter") then
													v714.Enabled = true
												elseif v714:IsA("Beam") or v714:IsA("Trail") then
													v714.Enabled = true
												end
											end
											return v710
										end
										local function v_u_719(p716, p717)
											if p716 and p716.Parent then
												for _, v_u_718 in p716:GetDescendants() do
													if v_u_718:IsA("ParticleEmitter") then
														v_u_718.Enabled = false
														if p717 then
															pcall(function()
																-- upvalues: (copy) v_u_718
																v_u_718:Clear()
															end)
														end
													elseif v_u_718:IsA("Beam") or v_u_718:IsA("Trail") then
														v_u_718.Enabled = false
													end
												end
											end
										end
										task.delay(0.1, function()
											-- upvalues: (ref) v_u_311, (ref) v_u_705, (copy) v_u_715, (copy) v_u_703, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												v_u_705 = v_u_715("Blue", v_u_703)
												if v_u_705 then
													v_u_303:AddItem(v_u_705, 4)
												end
											end
										end)
										task.delay(1, function()
											-- upvalues: (ref) v_u_311, (ref) v_u_706, (copy) v_u_715, (copy) v_u_704, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												v_u_706 = v_u_715("Red", v_u_704)
												if v_u_706 then
													v_u_303:AddItem(v_u_706, 3)
												end
											end
										end)
										task.delay(2, function()
											-- upvalues: (ref) v_u_311, (ref) v_u_304, (copy) v_u_703, (copy) v_u_704, (copy) v_u_702, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												local v720 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
												v_u_304:Create(v_u_703, v720, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												v_u_304:Create(v_u_704, v720, {
													["Position"] = Vector3.new(0, 2, 6)
												}):Play()
												task.delay(0.6000000000000001, function()
													-- upvalues: (ref) v_u_311, (ref) v_u_702, (ref) v_u_303
													if v_u_311 and v_u_311.Parent then
														local v721 = v_u_702:FindFirstChild("StarEff")
														if v721 then
															local v722 = v721:Clone()
															v722.CFrame = v_u_311.CFrame * CFrame.new(Vector3.new(0, 2, 6))
															v722.Anchored = true
															v722.CanCollide = false
															v722.Transparency = 1
															v722.Parent = workspace
															for _, v723 in v722:GetDescendants() do
																if v723:IsA("ParticleEmitter") then
																	v723:Emit(v723:GetAttribute("EmitCount") or 20)
																end
															end
															v_u_303:AddItem(v722, 2)
														end
													end
												end)
											end
										end)
										task.delay(3, function()
											-- upvalues: (ref) v_u_311, (copy) v_u_719, (ref) v_u_705, (ref) v_u_706, (copy) v_u_703, (copy) v_u_704, (copy) v_u_702, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												v_u_719(v_u_705, true)
												v_u_719(v_u_706, true)
												if v_u_703 and v_u_703.Parent then
													v_u_703:Destroy()
												end
												if v_u_704 and v_u_704.Parent then
													v_u_704:Destroy()
												end
												local v724 = v_u_702:FindFirstChild("MiniExplosionVFX")
												if v724 then
													local v725 = v724:Clone()
													v725.CFrame = v_u_311.CFrame * CFrame.new(0, 0, -2)
													v725.Anchored = true
													v725.CanCollide = false
													v725.Transparency = 1
													v725.Parent = workspace
													for _, v726 in v725:GetDescendants() do
														if v726:IsA("ParticleEmitter") then
															v726:Emit(v726:GetAttribute("EmitCount") or 30)
														end
													end
													v_u_303:AddItem(v725, 3)
												end
												local v_u_727 = v_u_311.Position + v_u_311.CFrame.LookVector * 6
												local v_u_728 = v_u_311.CFrame.LookVector
												local v729 = v_u_702:FindFirstChild("Purple")
												if v729 then
													local v_u_730 = v729:Clone()
													v_u_730.Anchored = true
													v_u_730.CanCollide = false
													v_u_730.Parent = workspace
													v_u_303:AddItem(v_u_730, 3)
													for _, v731 in v_u_730:GetDescendants() do
														if v731:IsA("ParticleEmitter") then
															v731.Enabled = true
														end
													end
													task.spawn(function()
														-- upvalues: (copy) v_u_727, (copy) v_u_730, (copy) v_u_728
														local v732 = v_u_727
														local v733 = 0
														while v733 < 200 and (v_u_730 and v_u_730.Parent) do
															v732 = v732 + v_u_728 * 3.9899999999999998
															v733 = v733 + 3.9899999999999998
															v_u_730.CFrame = CFrame.lookAt(v732, v732 + v_u_728)
															task.wait(0.03)
														end
														for _, v734 in v_u_730:GetDescendants() do
															if v734:IsA("ParticleEmitter") then
																v734.Enabled = false
															end
														end
													end)
												end
											end
										end)
									elseif v_u_307 == "Sukuna" then
										local v_u_735 = v_u_308.V
										if not v_u_735 then
											return
										end
										local v736 = (p_u_302.NPCModel or "NPC") .. "_SukunaV"
										local v737 = tick()
										if not v_u_301[v736] or v737 - v_u_301[v736] > 0.5 then
											v_u_301[v736] = v737
											v_u_37:PlayAt("SukunaV_Part1", p_u_302.Position)
										end
										local v738 = v_u_735:FindFirstChild("GroundVFX")
										if v738 then
											local v_u_739 = v738:Clone()
											v_u_739.CFrame = v_u_311.CFrame * CFrame.new(0, -2, 0)
											v_u_739.Anchored = false
											v_u_739.Parent = workspace
											v_u_303:AddItem(v_u_739, 3)
											local v740 = Instance.new("WeldConstraint")
											v740.Part0 = v_u_311
											v740.Part1 = v_u_739
											v740.Parent = v_u_739
											for _, v741 in v_u_739:GetDescendants() do
												if v741:IsA("ParticleEmitter") then
													v741.Enabled = true
													v741:Emit(v741:GetAttribute("EmitCount") or 40)
												elseif v741:IsA("Beam") then
													v741.Enabled = true
												end
											end
											task.delay(2.35, function()
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
										task.delay(1.9, function()
											-- upvalues: (ref) v_u_311, (copy) v_u_735, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												local v743 = v_u_735:FindFirstChild("MiniExplosionVFX")
												if v743 then
													local v744 = v743:Clone()
													v744.CFrame = v_u_311.CFrame * CFrame.new(1, 0, 0)
													v744.Anchored = false
													v744.Parent = workspace
													v_u_303:AddItem(v744, 2)
													local v745 = Instance.new("WeldConstraint")
													v745.Part0 = v_u_311
													v745.Part1 = v744
													v745.Parent = v744
													for _, v746 in v744:GetDescendants() do
														if v746:IsA("ParticleEmitter") then
															v746:Emit(v746:GetAttribute("EmitCount") or 40)
														end
													end
												end
												local v747 = v_u_735:FindFirstChild("ArrowVFX")
												if v747 then
													local v_u_748 = v747:Clone()
													v_u_748.CFrame = v_u_311.CFrame * CFrame.new(1, 0, 0)
													v_u_748.Anchored = false
													v_u_748.Parent = workspace
													v_u_303:AddItem(v_u_748, 2)
													local v749 = Instance.new("WeldConstraint")
													v749.Part0 = v_u_311
													v749.Part1 = v_u_748
													v749.Parent = v_u_748
													task.delay(0.45, function()
														-- upvalues: (copy) v_u_748
														if v_u_748 and v_u_748.Parent then
															for _, v750 in v_u_748:GetDescendants() do
																if v750:IsA("ParticleEmitter") or v750:IsA("Beam") then
																	v750.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
										task.delay(2.5, function()
											-- upvalues: (ref) v_u_311, (ref) p_u_302, (ref) v_u_301, (ref) v_u_37, (copy) v_u_735, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												local v751 = (p_u_302.NPCModel or "NPC") .. "_SukunaV2"
												local v752 = tick()
												if not v_u_301[v751] or v752 - v_u_301[v751] > 0.5 then
													v_u_301[v751] = v752
													v_u_37:PlayAt("SukunaV_Part2", v_u_311.Position)
												end
												local v753 = v_u_311.CFrame.LookVector
												local v754 = v_u_311.Position + v753 * 85
												local v755 = v_u_735:FindFirstChild("ExplosionVFX")
												if v755 then
													local v_u_756 = v755:Clone()
													if v_u_756:IsA("Model") then
														v_u_756:PivotTo(CFrame.new(v754) * CFrame.new(0, 73, 0))
													else
														v_u_756.CFrame = CFrame.new(v754) * CFrame.new(0, 73, 0)
													end
													v_u_756.Parent = workspace
													v_u_303:AddItem(v_u_756, 4)
													for _, v757 in v_u_756:GetDescendants() do
														if v757:IsA("ParticleEmitter") then
															v757.Enabled = true
															v757:Emit(v757:GetAttribute("EmitCount") or 30)
														elseif v757:IsA("Beam") or v757:IsA("Trail") then
															v757.Enabled = true
														end
													end
													task.delay(2.75, function()
														-- upvalues: (copy) v_u_756
														if v_u_756 and v_u_756.Parent then
															for _, v758 in v_u_756:GetDescendants() do
																if v758:IsA("ParticleEmitter") or (v758:IsA("Beam") or v758:IsA("Trail")) then
																	v758.Enabled = false
																end
															end
														end
													end)
												end
											end
										end)
									elseif v_u_307 == "Ragna" then
										v_u_37:PlayAt("RagnaV", p_u_302.Position)
										local v_u_759 = v_u_308.V
										if not v_u_759 then
											return
										end
										local v760 = v_u_759:FindFirstChild("FirstEffects")
										if v760 then
											local v_u_761 = v760:Clone()
											v_u_761.CFrame = v_u_311.CFrame * CFrame.new(0, -2.5, 0)
											v_u_761.Anchored = false
											v_u_761.CanCollide = false
											v_u_761.Transparency = 1
											v_u_761.CastShadow = false
											v_u_761.CanQuery = false
											v_u_761.Massless = true
											v_u_761.Parent = workspace
											v_u_303:AddItem(v_u_761, 6)
											local v762 = Instance.new("WeldConstraint")
											v762.Part0 = v_u_311
											v762.Part1 = v_u_761
											v762.Parent = v_u_761
											for _, v763 in v_u_761:GetDescendants() do
												if v763:IsA("ParticleEmitter") then
													v763.Enabled = true
												end
											end
											task.delay(5.5, function()
												-- upvalues: (copy) v_u_761
												if v_u_761 and v_u_761.Parent then
													for _, v764 in v_u_761:GetDescendants() do
														if v764:IsA("ParticleEmitter") then
															v764.Enabled = false
														end
													end
												end
											end)
										end
										task.delay(1.5, function()
											-- upvalues: (ref) v_u_311, (copy) v_u_759, (ref) v_u_303
											if v_u_311 and v_u_311.Parent then
												local v765 = v_u_759:FindFirstChild("UltVFX")
												if v765 then
													local v_u_766 = v765:Clone()
													v_u_766:PivotTo(v_u_311.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(4.71238898038469, 1.5707963267948966, 0))
													for _, v767 in v_u_766:GetDescendants() do
														if v767:IsA("BasePart") then
															v767.Anchored = true
															v767.CanCollide = false
															v767.CastShadow = false
															v767.CanQuery = false
														end
													end
													v_u_766.Parent = workspace
													v_u_303:AddItem(v_u_766, 4.5)
													for _, v768 in v_u_766:GetDescendants() do
														if v768:IsA("ParticleEmitter") then
															v768.Enabled = true
														elseif v768:IsA("Beam") then
															v768.Enabled = true
														end
													end
													task.delay(3, function()
														-- upvalues: (copy) v_u_766
														if v_u_766 and v_u_766.Parent then
															for _, v769 in v_u_766:GetDescendants() do
																if v769:IsA("ParticleEmitter") then
																	v769.Enabled = false
																end
															end
															for _, v_u_770 in v_u_766:GetDescendants() do
																if v_u_770:IsA("Beam") then
																	local v_u_771 = v_u_770.Transparency.Keypoints
																	task.spawn(function()
																		-- upvalues: (copy) v_u_771, (copy) v_u_770
																		local v772 = tick()
																		while tick() - v772 < 0.5 do
																			local v773 = (tick() - v772) / 0.5
																			local v774 = {}
																			for _, v775 in ipairs(v_u_771) do
																				local v776 = v775.Value + (1 - v775.Value) * v773
																				local v777 = NumberSequenceKeypoint.new
																				local v778 = v775.Time
																				table.insert(v774, v777(v778, v776))
																			end
																			v_u_770.Transparency = NumberSequence.new(v774)
																			task.wait()
																		end
																		v_u_770.Transparency = NumberSequence.new(1)
																	end)
																end
															end
														end
													end)
												end
											end
										end)
									elseif v_u_307 == "Ichigo" then
										local v779 = v_u_74.Ichigo
										if v779 and v779["Skill 4"] then
											local v780 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["CutsceneDuration"] = 8.33,
												["CharAnimationId"] = "rbxassetid://98446587158184",
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v779["Skill 4"](v780)
										end
									elseif v_u_307 == "Alucard" then
										local v781 = v_u_74.Alucard
										if v781 and v781["Skill 4"] then
											local v782 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["AbilityConfig"] = {},
												["CutsceneDuration"] = 5.5,
												["EnableCameraAnim"] = false,
												["EnableLetterbox"] = false,
												["EnableDarken"] = false
											}
											v781["Skill 4"](v782)
										end
									elseif v_u_307 == "Rimuru" then
										local v783 = v_u_74.Rimuru
										if v783 and v783["Skill 4"] then
											local v784 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v783["Skill 4"](v784)
										end
									elseif v_u_307 == "Madoka" then
										local v785 = v_u_74.Madoka
										if v785 and v785["Skill 4"] then
											local v786 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["DamageDelay"] = 3.13,
												["Duration"] = 8.63
											}
											v785["Skill 4"](v786)
										end
									elseif v_u_307 == "Gilgamesh" then
										local v787 = v_u_74.Gilgamesh
										if v787 and v787["Skill 4"] then
											local v788 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["AbilityConfig"] = {}
											}
											v787["Skill 4"](v788)
										end
									elseif v_u_307 == "Anos" then
										local v789 = v_u_74.Anos
										if v789 and v789["Skill 4"] then
											local v790 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v789["Skill 4"](v790)
										end
									elseif v_u_307 == "BlessedMaiden" then
										local v791 = v_u_74.BlessedMaiden
										if v791 and v791["Skill 4"] then
											local v792 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v791["Skill 4"](v792)
										end
									elseif v_u_307 == "TrueAizen" then
										local v793 = v_u_74.TrueAizen
										if v793 and v793["Skill 4"] then
											local v794 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["AbilityConfig"] = {},
												["DisableCutscene"] = true
											}
											v793["Skill 4"](v794)
										end
									end
									if v_u_307 == "Yamato" then
										local v795 = v_u_74.Yamato
										if v795 and v795["Skill 3"] then
											local v796 = {
												["Caster"] = {
													["Character"] = v_u_310
												},
												["AbilityConfig"] = {}
											}
											v795["Skill 3"](v796)
										end
									end
								end
							else
								return
							end
						end)
					elseif p_u_302.VFXName == "F" then
						task.spawn(function()
							-- upvalues: (copy) v_u_311, (copy) v_u_307, (ref) v_u_74, (copy) v_u_310
							if v_u_311 and v_u_311.Parent then
								if v_u_307 == "Rimuru" then
									local v797 = v_u_74.Rimuru
									if v797 and v797["Skill 5"] then
										local v798 = {
											["Caster"] = {
												["Character"] = v_u_310
											},
											["AbilityConfig"] = {},
											["DisableCutscene"] = true
										}
										v797["Skill 5"](v798)
									end
								end
								if v_u_307 == "Gilgamesh" then
									local v799 = v_u_74.Gilgamesh
									if v799 and v799["Skill 5"] then
										local v800 = {
											["Caster"] = {
												["Character"] = v_u_310
											},
											["AbilityConfig"] = {}
										}
										v799["Skill 5"](v800)
									end
								end
								if v_u_307 == "BlessedMaiden" then
									local v801 = v_u_74.BlessedMaiden
									if v801 and v801["Skill 5"] then
										local v802 = {
											["Caster"] = {
												["Character"] = v_u_310
											},
											["AbilityConfig"] = {}
										}
										v801["Skill 5"](v802)
									end
								end
								if v_u_307 == "Yamato" then
									local v803 = v_u_74.Yamato
									if v803 and v803["Skill 5"] then
										local v804 = {
											["Caster"] = {
												["Character"] = v_u_310
											},
											["AbilityConfig"] = {}
										}
										v803["Skill 5"](v804)
									end
								end
								if v_u_307 == "TrueAizen" then
									local v805 = v_u_74.TrueAizen
									if v805 and v805["Skill 5"] then
										local v806 = {
											["Caster"] = {
												["Character"] = v_u_310
											},
											["AbilityConfig"] = {},
											["DisableCutscene"] = true
										}
										v805["Skill 5"](v806)
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
	local v_u_808 = {}
	v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityResponse").OnClientEvent:Connect(function(p809, p_u_810)
		-- upvalues: (copy) v_u_808, (copy) v_u_807, (copy) v_u_44, (copy) v_u_37, (copy) v_u_294, (copy) v_u_7, (copy) v_u_300, (copy) v_u_4
		if p809 == "SpawnVFX" then
			if p_u_810.IsNPC and (p_u_810.VFXName == "Z" or (p_u_810.VFXName == "X" or (p_u_810.VFXName == "C" or (p_u_810.VFXName == "V" or p_u_810.VFXName == "F")))) then
				local v811 = (p_u_810.NPCModel or "NPC") .. "_" .. p_u_810.VFXName
				local v812 = tick()
				if v_u_808[v811] and v812 - v_u_808[v811] < 1 then
					return
				end
				v_u_808[v811] = v812
				task.spawn(function()
					-- upvalues: (ref) v_u_807, (copy) p_u_810
					v_u_807(p_u_810)
				end)
				local v813 = p_u_810.MovesetType or "Saber"
				if p_u_810.VFXName == "Z" then
					if v813 == "Gojo" then
						local v814 = (p_u_810.NPCModel or "unknown") .. "_Z"
						local v815 = tick()
						local v816
						if v_u_44[v814] and v815 - v_u_44[v814] < 1.5 then
							v816 = false
						else
							v_u_44[v814] = v815
							v816 = true
						end
						if v816 then
							v_u_37:PlayAt("GojoZ", p_u_810.Position)
						end
					elseif v813 == "Sukuna" then
						local v817 = (p_u_810.NPCModel or "unknown") .. "_Z"
						local v818 = tick()
						local v819
						if v_u_44[v817] and v818 - v_u_44[v817] < 1.5 then
							v819 = false
						else
							v_u_44[v817] = v818
							v819 = true
						end
						if v819 then
							v_u_37:PlayAt("SukunaZ", p_u_810.Position)
						end
					elseif v813 == "Jinwoo" then
						local v820 = (p_u_810.NPCModel or "unknown") .. "_Z"
						local v821 = tick()
						local v822
						if v_u_44[v820] and v821 - v_u_44[v820] < 1.5 then
							v822 = false
						else
							v_u_44[v820] = v821
							v822 = true
						end
						if v822 then
							v_u_37:PlayAt("JinwooZ", p_u_810.Position)
						end
					elseif v813 == "Ragna" then
						local v823 = (p_u_810.NPCModel or "unknown") .. "_Z"
						local v824 = tick()
						local v825
						if v_u_44[v823] and v824 - v_u_44[v823] < 1.5 then
							v825 = false
						else
							v_u_44[v823] = v824
							v825 = true
						end
						if v825 then
							v_u_37:PlayAt("RagnaZ", p_u_810.Position)
						end
					elseif v813 == "Aizen" then
						local v826 = (p_u_810.NPCModel or "unknown") .. "_Z"
						local v827 = tick()
						local v828
						if v_u_44[v826] and v827 - v_u_44[v826] < 1.5 then
							v828 = false
						else
							v_u_44[v826] = v827
							v828 = true
						end
						if v828 then
							v_u_37:PlayAt("AizenZ", p_u_810.Position)
						end
					elseif v813 == "QinShi" then
						local v829 = (p_u_810.NPCModel or "unknown") .. "_Z"
						local v830 = tick()
						local v831
						if v_u_44[v829] and v830 - v_u_44[v829] < 1.5 then
							v831 = false
						else
							v_u_44[v829] = v830
							v831 = true
						end
						if v831 then
							v_u_37:PlayAt("QinShiZ", p_u_810.Position)
						end
					elseif v813 == "Yuji" then
						local v832 = (p_u_810.NPCModel or "unknown") .. "_Z"
						local v833 = tick()
						local v834
						if v_u_44[v832] and v833 - v_u_44[v832] < 1.5 then
							v834 = false
						else
							v_u_44[v832] = v833
							v834 = true
						end
						if v834 then
							v_u_37:PlayAt("YujiZ", p_u_810.Position)
						end
					elseif v813 ~= "Alucard" then
						if v813 == "GojoV2" then
							local v835 = (p_u_810.NPCModel or "unknown") .. "_Z"
							local v836 = tick()
							local v837
							if v_u_44[v835] and v836 - v_u_44[v835] < 1.5 then
								v837 = false
							else
								v_u_44[v835] = v836
								v837 = true
							end
							if v837 then
								v_u_37:PlayAt("GojoV2Z", p_u_810.Position)
							end
						elseif v813 ~= "StrongestInHistory" and (v813 ~= "Rimuru" and (v813 ~= "Madoka" and v813 ~= "Anos")) then
							if v813 == "BlessedMaiden" then
								local v838 = (p_u_810.NPCModel or "unknown") .. "_Z"
								local v839 = tick()
								local v840
								if v_u_44[v838] and v839 - v_u_44[v838] < 1.5 then
									v840 = false
								else
									v_u_44[v838] = v839
									v840 = true
								end
								if v840 then
									v_u_37:PlayAt("BlessedMaidenZ", p_u_810.Position)
								end
							elseif v813 ~= "Gilgamesh" then
								if v813 == "Yamato" then
									local v841 = (p_u_810.NPCModel or "unknown") .. "_Z"
									local v842 = tick()
									local v843
									if v_u_44[v841] and v842 - v_u_44[v841] < 1.5 then
										v843 = false
									else
										v_u_44[v841] = v842
										v843 = true
									end
									if v843 then
										v_u_37:PlayAt("VergilZ", p_u_810.Position)
									end
								elseif v813 ~= "TrueAizen" then
									local v844 = (p_u_810.NPCModel or "unknown") .. "_Z"
									local v845 = tick()
									local v846
									if v_u_44[v844] and v845 - v_u_44[v844] < 1.5 then
										v846 = false
									else
										v_u_44[v844] = v845
										v846 = true
									end
									if v846 then
										v_u_37:PlayAt("SaberZ", p_u_810.Position)
									end
								end
							end
						end
					end
				elseif p_u_810.VFXName == "X" then
					if v813 == "Gojo" then
						local v847 = (p_u_810.NPCModel or "unknown") .. "_X"
						local v848 = tick()
						local v849
						if v_u_44[v847] and v848 - v_u_44[v847] < 1.5 then
							v849 = false
						else
							v_u_44[v847] = v848
							v849 = true
						end
						if v849 then
							v_u_37:PlayAt("GojoX", p_u_810.Position)
						end
					elseif v813 == "Sukuna" then
						local v850 = (p_u_810.NPCModel or "unknown") .. "_X"
						local v851 = tick()
						local v852
						if v_u_44[v850] and v851 - v_u_44[v850] < 1.5 then
							v852 = false
						else
							v_u_44[v850] = v851
							v852 = true
						end
						if v852 then
							v_u_37:PlayAt("SukunaX", p_u_810.Position)
						end
					elseif v813 == "Jinwoo" then
						local v853 = (p_u_810.NPCModel or "unknown") .. "_X"
						local v854 = tick()
						local v855
						if v_u_44[v853] and v854 - v_u_44[v853] < 1.5 then
							v855 = false
						else
							v_u_44[v853] = v854
							v855 = true
						end
						if v855 then
							v_u_37:PlayAt("JinwooX", p_u_810.Position)
						end
					elseif v813 == "Ragna" then
						local v856 = (p_u_810.NPCModel or "unknown") .. "_X"
						local v857 = tick()
						local v858
						if v_u_44[v856] and v857 - v_u_44[v856] < 1.5 then
							v858 = false
						else
							v_u_44[v856] = v857
							v858 = true
						end
						if v858 then
							v_u_37:PlayAt("RagnaX", p_u_810.Position)
						end
					elseif v813 == "Aizen" then
						local v859 = (p_u_810.NPCModel or "unknown") .. "_X"
						local v860 = tick()
						local v861
						if v_u_44[v859] and v860 - v_u_44[v859] < 1.5 then
							v861 = false
						else
							v_u_44[v859] = v860
							v861 = true
						end
						if v861 then
							v_u_37:PlayAt("AizenX", p_u_810.Position)
						end
					elseif v813 == "QinShi" then
						local v862 = (p_u_810.NPCModel or "unknown") .. "_X"
						local v863 = tick()
						local v864
						if v_u_44[v862] and v863 - v_u_44[v862] < 1.5 then
							v864 = false
						else
							v_u_44[v862] = v863
							v864 = true
						end
						if v864 then
							v_u_37:PlayAt("QinShiX", p_u_810.Position)
						end
					elseif v813 == "Yuji" then
						local v865 = (p_u_810.NPCModel or "unknown") .. "_X"
						local v866 = tick()
						local v867
						if v_u_44[v865] and v866 - v_u_44[v865] < 1.5 then
							v867 = false
						else
							v_u_44[v865] = v866
							v867 = true
						end
						if v867 then
							v_u_37:PlayAt("YujiX", p_u_810.Position)
						end
					elseif v813 ~= "Ichigo" and v813 ~= "Alucard" then
						if v813 == "GojoV2" then
							local v868 = (p_u_810.NPCModel or "unknown") .. "_X"
							local v869 = tick()
							local v870
							if v_u_44[v868] and v869 - v_u_44[v868] < 1.5 then
								v870 = false
							else
								v_u_44[v868] = v869
								v870 = true
							end
							if v870 then
								v_u_37:PlayAt("GojoV2X", p_u_810.Position)
							end
						elseif v813 ~= "StrongestInHistory" and (v813 ~= "Rimuru" and (v813 ~= "Madoka" and v813 ~= "Anos")) then
							if v813 == "BlessedMaiden" then
								local v871 = (p_u_810.NPCModel or "unknown") .. "_X"
								local v872 = tick()
								local v873
								if v_u_44[v871] and v872 - v_u_44[v871] < 1.5 then
									v873 = false
								else
									v_u_44[v871] = v872
									v873 = true
								end
								if v873 then
									v_u_37:PlayAt("BlessedMaidenX", p_u_810.Position)
								end
							elseif v813 == "Yamato" then
								local v874 = (p_u_810.NPCModel or "unknown") .. "_X"
								local v875 = tick()
								local v876
								if v_u_44[v874] and v875 - v_u_44[v874] < 1.5 then
									v876 = false
								else
									v_u_44[v874] = v875
									v876 = true
								end
								if v876 then
									v_u_37:PlayAt("VergilX", p_u_810.Position)
								end
							elseif v813 ~= "TrueAizen" then
								local v877 = (p_u_810.NPCModel or "unknown") .. "_X"
								local v878 = tick()
								local v879
								if v_u_44[v877] and v878 - v_u_44[v877] < 1.5 then
									v879 = false
								else
									v_u_44[v877] = v878
									v879 = true
								end
								if v879 then
									v_u_37:PlayAt("SaberX", p_u_810.Position)
								end
							end
						end
					end
				elseif p_u_810.VFXName == "C" then
					if v813 == "Gojo" then
						local v880 = (p_u_810.NPCModel or "unknown") .. "_C"
						local v881 = tick()
						local v882
						if v_u_44[v880] and v881 - v_u_44[v880] < 1.5 then
							v882 = false
						else
							v_u_44[v880] = v881
							v882 = true
						end
						if v882 then
							v_u_37:PlayAt("GojoC", p_u_810.Position)
							v_u_37:PlayAt("GojoC_Hold", p_u_810.Position)
						end
					elseif v813 == "Jinwoo" then
						local v883 = (p_u_810.NPCModel or "unknown") .. "_C"
						local v884 = tick()
						local v885
						if v_u_44[v883] and v884 - v_u_44[v883] < 1.5 then
							v885 = false
						else
							v_u_44[v883] = v884
							v885 = true
						end
						if v885 then
							v_u_37:PlayAt("JinwooC", p_u_810.Position)
						end
					elseif v813 == "Ragna" then
						local v886 = (p_u_810.NPCModel or "unknown") .. "_C"
						local v887 = tick()
						local v888
						if v_u_44[v886] and v887 - v_u_44[v886] < 1.5 then
							v888 = false
						else
							v_u_44[v886] = v887
							v888 = true
						end
						if v888 then
							v_u_37:PlayAt("RagnaC_Startup", p_u_810.Position)
						end
					elseif v813 == "Aizen" then
						local v889 = (p_u_810.NPCModel or "unknown") .. "_C"
						local v890 = tick()
						local v891
						if v_u_44[v889] and v890 - v_u_44[v889] < 1.5 then
							v891 = false
						else
							v_u_44[v889] = v890
							v891 = true
						end
						if v891 then
							v_u_37:PlayAt("AizenC", p_u_810.Position)
						end
					elseif v813 == "QinShi" then
						local v892 = (p_u_810.NPCModel or "unknown") .. "_C"
						local v893 = tick()
						local v894
						if v_u_44[v892] and v893 - v_u_44[v892] < 1.5 then
							v894 = false
						else
							v_u_44[v892] = v893
							v894 = true
						end
						if v894 then
							v_u_37:PlayAt("QinShiC", p_u_810.Position)
						end
					elseif v813 == "Yuji" then
						local v895 = (p_u_810.NPCModel or "unknown") .. "_C"
						local v896 = tick()
						local v897
						if v_u_44[v895] and v896 - v_u_44[v895] < 1.5 then
							v897 = false
						else
							v_u_44[v895] = v896
							v897 = true
						end
						if v897 then
							v_u_37:PlayAt("YujiC_Press", p_u_810.Position)
						end
					elseif v813 ~= "Ichigo" and (v813 ~= "Alucard" and (v813 ~= "GojoV2" and (v813 ~= "StrongestInHistory" and (v813 ~= "Rimuru" and (v813 ~= "Madoka" and v813 ~= "Anos"))))) then
						if v813 == "BlessedMaiden" then
							local v898 = (p_u_810.NPCModel or "unknown") .. "_C"
							local v899 = tick()
							local v900
							if v_u_44[v898] and v899 - v_u_44[v898] < 1.5 then
								v900 = false
							else
								v_u_44[v898] = v899
								v900 = true
							end
							if v900 then
								v_u_37:PlayAt("BlessedMaidenC", p_u_810.Position)
							end
						elseif v813 ~= "Gilgamesh" then
							if v813 == "Yamato" then
								local v901 = (p_u_810.NPCModel or "unknown") .. "_C"
								local v902 = tick()
								local v903
								if v_u_44[v901] and v902 - v_u_44[v901] < 1.5 then
									v903 = false
								else
									v_u_44[v901] = v902
									v903 = true
								end
								if v903 then
									v_u_37:PlayAt("VergilC", p_u_810.Position)
								end
							elseif v813 ~= "TrueAizen" then
								local v904 = (p_u_810.NPCModel or "unknown") .. "_C"
								local v905 = tick()
								local v906
								if v_u_44[v904] and v905 - v_u_44[v904] < 1.5 then
									v906 = false
								else
									v_u_44[v904] = v905
									v906 = true
								end
								if v906 then
									v_u_37:PlayAt("SaberC_Cast", p_u_810.Position)
									task.delay(3.85, function()
										-- upvalues: (ref) v_u_37, (copy) p_u_810
										v_u_37:PlayAt("SaberC_Beam", p_u_810.Position)
									end)
									task.delay(4.4, function()
										-- upvalues: (ref) v_u_37, (copy) p_u_810
										v_u_37:PlayAt("SaberC_Explosion", p_u_810.Position)
									end)
								end
							end
						end
					end
				elseif p_u_810.VFXName == "V" then
					if v813 == "Gojo" then
						v_u_37:PlayAt("GojoV", p_u_810.Position)
					elseif v813 ~= "Sukuna" and (v813 ~= "Ichigo" and (v813 ~= "Alucard" and (v813 ~= "GojoV2" and (v813 ~= "StrongestInHistory" and (v813 ~= "Rimuru" and (v813 ~= "Madoka" and v813 ~= "Anos")))))) then
						if v813 == "BlessedMaiden" then
							local v907 = (p_u_810.NPCModel or "unknown") .. "_V"
							local v908 = tick()
							local v909
							if v_u_44[v907] and v908 - v_u_44[v907] < 1.5 then
								v909 = false
							else
								v_u_44[v907] = v908
								v909 = true
							end
							if v909 then
								v_u_37:PlayAt("BlessedMaidenV", p_u_810.Position)
							end
						elseif v813 == "Yamato" then
							local v910 = (p_u_810.NPCModel or "unknown") .. "_V"
							local v911 = tick()
							local v912
							if v_u_44[v910] and v911 - v_u_44[v910] < 1.5 then
								v912 = false
							else
								v_u_44[v910] = v911
								v912 = true
							end
							if v912 then
								v_u_37:PlayAt("VergilV", p_u_810.Position)
							end
						end
					end
				end
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_294, (copy) p_u_810
					v_u_294.SpawnVFX(p_u_810.VFXName, p_u_810.Position, p_u_810.Scale, p_u_810.Duration, p_u_810.AbilityName)
				end)
			end
			if p_u_810.CameraShake then
				task.delay(p_u_810.CameraShake.Delay or 0, function()
					-- upvalues: (copy) p_u_810, (ref) v_u_7
					local v_u_913 = p_u_810.CameraShake.Intensity or 5
					local v_u_914 = p_u_810.CameraShake.Duration or 0.3
					if v_u_7:GetAttribute("DisableScreenShake") then
						return
					else
						local v_u_915 = workspace.CurrentCamera
						if v_u_915 then
							task.spawn(function()
								-- upvalues: (copy) v_u_915, (copy) v_u_914, (copy) v_u_913
								local v916 = tick()
								local _ = v_u_915.CFrame
								while tick() - v916 < v_u_914 do
									local v917 = v_u_913 * (1 - (tick() - v916) / v_u_914)
									local v918 = (math.random() - 0.5) * v917 * 0.1
									local v919 = (math.random() - 0.5) * v917 * 0.1
									v_u_915.CFrame = v_u_915.CFrame * CFrame.new(v918, v919, 0)
									task.wait()
								end
							end)
						end
					end
				end)
			end
			if p_u_810.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_300, (copy) p_u_810
					v_u_300(p_u_810.ScreenFlash)
				end)
				return
			end
		elseif p809 == "SpawnKatanaSlashPart1" then
			task.spawn(function()
				-- upvalues: (ref) v_u_294, (copy) p_u_810, (ref) v_u_4
				local v920 = v_u_294.SpawnVFXWithRotation(p_u_810.VFXName, p_u_810.Position, p_u_810.Rotation, p_u_810.Scale, p_u_810.Duration, "KatanaAbilities")
				if v920 then
					v_u_4:AddItem(v920, (p_u_810.Duration or 0.4) + 1)
				end
			end)
			if p_u_810.IsNPC then
				v_u_37:PlayAt("KatanaZ", p_u_810.Position)
			end
			if p_u_810.CameraShake then
				local v_u_921 = p_u_810.CameraShake.Intensity or 3
				local v_u_922 = p_u_810.CameraShake.Duration or 0.2
				if v_u_7:GetAttribute("DisableScreenShake") then
					return
				else
					local v_u_923 = workspace.CurrentCamera
					if v_u_923 then
						task.spawn(function()
							-- upvalues: (copy) v_u_923, (copy) v_u_922, (copy) v_u_921
							local v924 = tick()
							local _ = v_u_923.CFrame
							while tick() - v924 < v_u_922 do
								local v925 = v_u_921 * (1 - (tick() - v924) / v_u_922)
								local v926 = (math.random() - 0.5) * v925 * 0.1
								local v927 = (math.random() - 0.5) * v925 * 0.1
								v_u_923.CFrame = v_u_923.CFrame * CFrame.new(v926, v927, 0)
								task.wait()
							end
						end)
					end
				end
			end
		elseif p809 == "SpawnKatanaSlashPart2" then
			task.spawn(function()
				-- upvalues: (ref) v_u_294, (copy) p_u_810, (ref) v_u_4
				local v928 = v_u_294.SpawnTravelingVFX(p_u_810.VFXName, p_u_810.StartPosition, p_u_810.Direction, p_u_810.TravelDistance, p_u_810.TravelSpeed, p_u_810.Scale, p_u_810.Duration, "KatanaAbilities")
				if v928 then
					v_u_4:AddItem(v928, (p_u_810.TravelDistance or 50) / (p_u_810.TravelSpeed or 70) + 2)
				end
			end)
			if p_u_810.CameraShake then
				local v_u_929 = p_u_810.CameraShake.Intensity or 6
				local v_u_930 = p_u_810.CameraShake.Duration or 0.3
				local v_u_931 = not v_u_7:GetAttribute("DisableScreenShake") and workspace.CurrentCamera
				if v_u_931 then
					task.spawn(function()
						-- upvalues: (copy) v_u_931, (copy) v_u_930, (copy) v_u_929
						local v932 = tick()
						local _ = v_u_931.CFrame
						while tick() - v932 < v_u_930 do
							local v933 = v_u_929 * (1 - (tick() - v932) / v_u_930)
							local v934 = (math.random() - 0.5) * v933 * 0.1
							local v935 = (math.random() - 0.5) * v933 * 0.1
							v_u_931.CFrame = v_u_931.CFrame * CFrame.new(v934, v935, 0)
							task.wait()
						end
					end)
				end
			end
			if p_u_810.ScreenFlash then
				task.spawn(function()
					-- upvalues: (ref) v_u_300, (copy) p_u_810
					v_u_300(p_u_810.ScreenFlash)
				end)
			end
		end
	end)
	local v936 = v_u_3:WaitForChild("RemoteEvents"):WaitForChild("AbilityHitSound")
	local v_u_937 = 1
	v936.OnClientEvent:Connect(function(p938)
		-- upvalues: (ref) v_u_937, (copy) v_u_37
		if p938 and p938.Position then
			v_u_37:PlayAt("CombatHit" .. v_u_937, p938.Position)
			v_u_937 = v_u_937 % 7 + 1
		end
	end)
	local v_u_939 = require(v_u_3:WaitForChild("HitboxVisualizer"))
	local v940 = v46:WaitForChild("HitboxVisualize", 5)
	if v940 then
		v940.OnClientEvent:Connect(function(p941)
			-- upvalues: (copy) v_u_939
			if p941.Type == "Box" then
				v_u_939.ShowBox(p941.CFrame, p941.Size, p941.Duration, p941.Color)
				return
			elseif p941.Type == "Sphere" then
				v_u_939.ShowSphere(p941.Position, p941.Radius, p941.Duration, p941.Color)
				return
			elseif p941.Type == "Traveling" then
				v_u_939.ShowTraveling(p941.StartPos, p941.Direction, p941.Size, p941.Speed, p941.Distance, p941.HitboxType, p941.Color)
			elseif p941.Type == "FollowingAOE" then
				local v942 = p941.Character
				if v942 then
					v_u_939.ShowFollowingAOE(v942, p941.Size, p941.Duration, p941.Offset, p941.Color, p941.Shape)
					return
				end
			else
				if p941.Type == "MultiWave" then
					v_u_939.ShowMultiWave(p941.OriginCFrame, p941.Waves)
					return
				end
				if p941.Type == "Explosion" then
					v_u_939.ShowExplosion(p941.Position, p941.Radius, p941.Duration, p941.Color)
					return
				end
				if p941.Type == "StaticBox" then
					v_u_939.ShowStaticBox(p941.StartPos, p941.EndPos, p941.Width, p941.Height, p941.Duration, p941.Color)
				end
			end
		end)
	end
end)
if not v943 then
	warn("=====================================")
	warn("[AbilityClient] FATAL ERROR DURING INITIALIZATION:")
	warn(v944)
	warn("=====================================")
end