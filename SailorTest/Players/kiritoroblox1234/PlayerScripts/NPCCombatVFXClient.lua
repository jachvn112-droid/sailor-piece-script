local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("Debris")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = v2.LocalPlayer
local v7 = v1:WaitForChild("RemoteEvents"):WaitForChild("NPCCombatVFX", 10)
if v7 then
	local v_u_8 = v1:WaitForChild("CombatSystem", 10)
	if v_u_8 then
		v_u_8 = v_u_8:FindFirstChild("VFX")
	end
	local v_u_9 = require(v1:WaitForChild("Modules"):WaitForChild("SoundManager"))
	local v_u_10 = {}
	local function v_u_12(p11)
		-- upvalues: (copy) v_u_10
		if not v_u_10[p11] then
			v_u_10[p11] = {
				["swing"] = 1,
				["hit"] = 1,
				["swordHit"] = 1,
				["jinwooM1"] = 1,
				["gojoM1"] = 1,
				["sukunaM1"] = 1,
				["katanaM1"] = 1,
				["aizenM1"] = 1,
				["qinshiM1"] = 1,
				["yujiM1"] = 1,
				["alucardM1"] = 1,
				["strongestHistoryM1"] = 1,
				["ichigoM1"] = 1,
				["rimuruM1"] = 1,
				["madokaM1"] = 1,
				["gilgameshM1"] = 1,
				["anosM1"] = 1,
				["yamatoM1"] = 1,
				["blessedMaidenM1"] = 1,
				["trueAizenM1"] = 1
			}
		end
		return v_u_10[p11]
	end
	local v_u_13 = { CFrame.Angles(0, 0, 0.7853981633974483), CFrame.Angles(0, 0, -0.7853981633974483), CFrame.Angles(0, 0, 0) }
	local v_u_14 = { 1, 1.2, 1.5 }
	local function v_u_24(p15, p16)
		local v17 = workspace:FindFirstChild("NPCs")
		if v17 then
			if p16 then
				local v18 = (1 / 0)
				local v19 = nil
				for _, v20 in ipairs(v17:GetChildren()) do
					if v20.Name == p15 and v20:IsA("Model") then
						local v21 = v20:FindFirstChild("HumanoidRootPart")
						if v21 then
							local v22 = (v21.Position - p16).Magnitude
							if v22 < v18 then
								v19 = v20
								v18 = v22
							end
						end
					end
				end
				if v19 then
					return v19
				end
			end
			local v23 = v17:FindFirstChild(p15)
			if v23 then
				return v23
			end
		end
		return workspace:FindFirstChild(p15)
	end
	local function v_u_31(p25, p26, p27, p28, p29)
		-- upvalues: (copy) v_u_12, (copy) v_u_9
		local v30 = v_u_12(p25)
		if p26 == "Combat" then
			if p28 then
				v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
				v30.hit = v30.hit % 7 + 1
			else
				v_u_9:PlayAt("CombatSwing" .. v30.swing, p29)
				v30.swing = v30.swing % 4 + 1
			end
		elseif p26 == "Katana" or p26 == "Saber" then
			if p28 then
				v_u_9:PlayAt("SwordHit" .. v30.swordHit, p29)
				v30.swordHit = v30.swordHit % 2 + 1
				return
			elseif p26 == "Katana" then
				v_u_9:PlayAt(({ "KatanaM1_1", "KatanaM1_2", "KatanaM1_3" })[v30.katanaM1], p29)
				v30.katanaM1 = v30.katanaM1 % 3 + 1
			else
				v_u_9:PlayAt(p27 % 2 == 1 and "SaberSlash1" or "SaberSlash2", p29)
			end
		else
			if p26 == "Jinwoo" then
				v_u_9:PlayAt(({ "JinwooM1_1", "JinwooM1_2", "JinwooM1_3" })[v30.jinwooM1], p29)
				v30.jinwooM1 = v30.jinwooM1 % 3 + 1
				if p28 then
					v_u_9:PlayAt("SwordHit" .. v30.swordHit, p29)
					v30.swordHit = v30.swordHit % 2 + 1
					return
				end
			elseif p26 == "Gojo" then
				v_u_9:PlayAt(({ "GojoM1_Blue", "GojoM1_Red", "GojoM1_Purple" })[v30.gojoM1], p29)
				v30.gojoM1 = v30.gojoM1 % 3 + 1
				if p28 then
					v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
					v30.hit = v30.hit % 7 + 1
					return
				end
			elseif p26 == "Sukuna" then
				v_u_9:PlayAt(({ "SukunaM1_1", "SukunaM1_2", "SukunaM1_3" })[v30.sukunaM1], p29)
				v30.sukunaM1 = v30.sukunaM1 % 3 + 1
				if p28 then
					v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
					v30.hit = v30.hit % 7 + 1
					return
				end
			elseif p26 == "Ragna" then
				v_u_9:PlayAt(({ "RagnaM1_1", "RagnaM1_2" })[(p27 - 1) % 2 + 1], p29)
				if p28 then
					v_u_9:PlayAt("SwordHit" .. v30.swordHit, p29)
					v30.swordHit = v30.swordHit % 2 + 1
					return
				end
			elseif p26 == "Aizen" then
				v_u_9:PlayAt(({ "AizenM1_1", "AizenM1_2", "AizenM1_3" })[v30.aizenM1], p29)
				v30.aizenM1 = v30.aizenM1 % 3 + 1
				if p28 then
					v_u_9:PlayAt("SwordHit" .. v30.swordHit, p29)
					v30.swordHit = v30.swordHit % 2 + 1
					return
				end
			else
				if p26 == "QinShi" or p26 == "Qin Shi" then
					if p28 then
						v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
						v30.hit = v30.hit % 7 + 1
					else
						v_u_9:PlayAt("CombatSwing" .. v30.swing, p29)
						v30.swing = v30.swing % 4 + 1
					end
				end
				if p26 == "Alucard" then
					v_u_9:PlayAt(({ "AlucardM1_1", "AlucardM1_2", "AlucardM1_3" })[v30.alucardM1], p29)
					v30.alucardM1 = v30.alucardM1 % 3 + 1
					if p28 then
						v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
						v30.hit = v30.hit % 7 + 1
						return
					end
				elseif p26 == "Ichigo" then
					v_u_9:PlayAt(({ "IchigoM1_1", "IchigoM1_2", "IchigoM1_3" })[v30.ichigoM1], p29)
					v30.ichigoM1 = v30.ichigoM1 % 3 + 1
					if p28 then
						v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
						v30.hit = v30.hit % 7 + 1
						return
					end
				elseif p26 == "StrongestInHistory" then
					v_u_9:PlayAt(({ "StrongestInHistoryM1_1", "StrongestInHistoryM1_2", "StrongestInHistoryM1_3" })[v30.strongestHistoryM1], p29)
					v30.strongestHistoryM1 = v30.strongestHistoryM1 % 3 + 1
					if p28 then
						v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
						v30.hit = v30.hit % 7 + 1
						return
					end
				elseif p26 == "Rimuru" then
					v_u_9:PlayAt(({ "RimuruM1_1", "RimuruM1_2", "RimuruM1_3" })[v30.rimuruM1], p29)
					v30.rimuruM1 = v30.rimuruM1 % 3 + 1
					if p28 then
						v_u_9:PlayAt("SwordHit" .. v30.swordHit, p29)
						v30.swordHit = v30.swordHit % 2 + 1
						return
					end
				elseif p26 == "Madoka" then
					v_u_9:PlayAt(({ "MadokaM1_1", "MadokaM1_2", "MadokaM1_3" })[v30.madokaM1], p29)
					v30.madokaM1 = v30.madokaM1 % 3 + 1
					if p28 then
						v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
						v30.hit = v30.hit % 7 + 1
						return
					end
				elseif p26 == "Gilgamesh" then
					v_u_9:PlayAt(({
						"GilgameshM1_1",
						"GilgameshM1_2",
						"GilgameshM1_3",
						"GilgameshM1_4"
					})[v30.gilgameshM1], p29)
					v30.gilgameshM1 = v30.gilgameshM1 % 4 + 1
					if p28 then
						v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
						v30.hit = v30.hit % 7 + 1
						return
					end
				elseif p26 == "Anos" then
					v_u_9:PlayAt(({ "AnosM1_1", "AnosM1_2", "AnosM1_3" })[v30.anosM1], p29)
					v30.anosM1 = v30.anosM1 % 3 + 1
					if p28 then
						v_u_9:PlayAt("CombatHit" .. v30.hit, p29)
						v30.hit = v30.hit % 7 + 1
						return
					end
				elseif p26 == "Yamato" then
					v_u_9:PlayAt(({
						"YamatoM1_1",
						"YamatoM1_2",
						"YamatoM1_3",
						"YamatoM1_4"
					})[v30.yamatoM1], p29)
					v30.yamatoM1 = v30.yamatoM1 % 4 + 1
					if p28 then
						v_u_9:PlayAt("SwordHit" .. v30.swordHit, p29)
						v30.swordHit = v30.swordHit % 2 + 1
						return
					end
				elseif p26 == "BlessedMaiden" then
					v_u_9:PlayAt(({
						"BlessedMaidenM1_1",
						"BlessedMaidenM1_2",
						"BlessedMaidenM1_3",
						"BlessedMaidenM1_4"
					})[v30.blessedMaidenM1], p29)
					v30.blessedMaidenM1 = v30.blessedMaidenM1 % 4 + 1
					if p28 then
						v_u_9:PlayAt("SwordHit" .. v30.swordHit, p29)
						v30.swordHit = v30.swordHit % 2 + 1
						return
					end
				elseif p26 == "TrueAizen" then
					v_u_9:PlayAt(({
						"TrueAizenM1_1",
						"TrueAizenM1_2",
						"TrueAizenM1_3",
						"TrueAizenM1_4"
					})[v30.trueAizenM1], p29)
					v30.trueAizenM1 = v30.trueAizenM1 % 4 + 1
					if p28 then
						v_u_9:PlayAt("SwordHit" .. v30.swordHit, p29)
						v30.swordHit = v30.swordHit % 2 + 1
					end
				end
			end
			return
		end
	end
	local v_u_32 = {}
	local v_u_33 = {}
	v7.OnClientEvent:Connect(function(p34)
		-- upvalues: (copy) v_u_32, (copy) v_u_24, (copy) v_u_33, (copy) v_u_31, (copy) v_u_6, (copy) v_u_8, (copy) v_u_3, (copy) v_u_5, (copy) v_u_9, (copy) v_u_4, (copy) v_u_13, (copy) v_u_14
		if p34 then
			local v35 = p34.NPCModel .. "_vfx"
			local v36 = tick()
			if v_u_32[v35] and v36 - v_u_32[v35] < 0.4 then
				return
			else
				v_u_32[v35] = v36
				local v37 = v_u_24(p34.NPCModel, p34.Position)
				if v37 then
					local v_u_38 = v37:FindFirstChild("HumanoidRootPart")
					if v_u_38 then
						local v39 = p34.ComboIndex or 1
						local v40 = p34.DidHit ~= false
						local v41 = p34.NPCModel .. "_sound"
						local v42 = tick()
						if (not v_u_33[v41] or v42 - v_u_33[v41] >= 0.4) and true or false then
							v_u_33[v41] = v42
							v_u_31(p34.NPCModel, p34.WeaponName, v39, v40, v_u_38.Position)
						end
						if v_u_6:GetAttribute("DisableVFX") == true then
							return
						elseif p34.WeaponName == "Combat" then
							return
						elseif v_u_8 then
							if p34.WeaponName == "Alucard" then
								local v43 = v_u_8:FindFirstChild("Alucard")
								if v43 then
									local v44 = p34.ComboIndex or 1
									local v45 = v43:FindFirstChild("Punch" .. (v44 - 1) % 3 + 1)
									if v45 then
										local v46 = v45:Clone()
										v46.CFrame = v_u_38.CFrame * CFrame.new(0, 0, -5.5) * CFrame.Angles(0, 1.5707963267948966, 0)
										v46.Anchored = false
										v46.CanCollide = false
										v46.CanQuery = false
										v46.CanTouch = false
										v46.Massless = true
										v46.Transparency = 1
										v46.Parent = workspace
										local v47 = Instance.new("WeldConstraint")
										v47.Part0 = v46
										v47.Part1 = v_u_38
										v47.Parent = v46
										local v48 = Color3.fromRGB(0, 133, 200)
										local v49 = Color3.fromRGB(255, 50, 50)
										if v44 == 1 then
											v49 = v48
										elseif v44 == 2 then
											v48 = v49
										end
										for _, v50 in v46:GetDescendants() do
											if v50:IsA("ParticleEmitter") then
												local v51 = v50.Color
												local v52 = {}
												for _, v53 in ipairs(v51.Keypoints) do
													local v54 = v48:Lerp(v49, v53.Time)
													local v55 = ColorSequenceKeypoint.new
													local v56 = v53.Time
													table.insert(v52, v55(v56, v54))
												end
												v50.Color = ColorSequence.new(v52)
												local v57 = v50.Size
												local v58 = {}
												for _, v59 in ipairs(v57.Keypoints) do
													local v60 = NumberSequenceKeypoint.new
													local v61 = v59.Time
													local v62 = v59.Value * 0.6
													local v63 = v59.Envelope * 0.6
													table.insert(v58, v60(v61, v62, v63))
												end
												v50.Size = NumberSequence.new(v58)
												v50:Emit(v50:GetAttribute("EmitCount") or 1)
											end
										end
										v_u_3:AddItem(v46, 2)
									end
								else
									return
								end
							elseif p34.WeaponName == "StrongestInHistory" then
								local v64 = v_u_8:FindFirstChild("Strongest In History")
								if v64 then
									local v65 = v64:FindFirstChild("Punch" .. ((p34.ComboIndex or 1) - 1) % 3 + 1)
									if v65 then
										local v66 = v65:Clone()
										v66.CFrame = v_u_38.CFrame * CFrame.new(0, 0, -5.5) * CFrame.Angles(0, 1.5707963267948966, 0)
										v66.Anchored = false
										v66.CanCollide = false
										v66.CanQuery = false
										v66.CanTouch = false
										v66.Massless = true
										v66.Transparency = 1
										v66.Parent = workspace
										local v67 = Instance.new("WeldConstraint")
										v67.Part0 = v66
										v67.Part1 = v_u_38
										v67.Parent = v66
										for _, v68 in v66:GetDescendants() do
											if v68:IsA("ParticleEmitter") then
												v68:Emit(v68:GetAttribute("EmitCount") or 1)
											end
										end
										v_u_3:AddItem(v66, 2)
									end
								else
									return
								end
							elseif p34.WeaponName == "QinShi" or p34.WeaponName == "Qin Shi" then
								local v69 = v_u_8:FindFirstChild("Qin Shi") or v_u_8:FindFirstChild("QinShi")
								if v69 then
									local v70 = v69:FindFirstChild("Punch" .. ((p34.ComboIndex or 1) - 1) % 3 + 1)
									if v70 then
										local v71 = v70:Clone()
										v71.CFrame = v_u_38.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0)
										v71.Anchored = false
										v71.CanCollide = false
										v71.CanQuery = false
										v71.CanTouch = false
										v71.Massless = true
										v71.Transparency = 1
										v71.Parent = workspace
										local v72 = Instance.new("WeldConstraint")
										v72.Part0 = v71
										v72.Part1 = v_u_38
										v72.Parent = v71
										for _, v73 in v71:GetDescendants() do
											if v73:IsA("ParticleEmitter") then
												v73:Emit(v73:GetAttribute("EmitCount") or 1)
											end
										end
										v_u_3:AddItem(v71, 2)
									end
								else
									return
								end
							elseif p34.WeaponName == "Madoka" then
								local v74 = v_u_8:FindFirstChild("Madoka")
								if v74 then
									local v75 = v74:FindFirstChild("Punch" .. ((p34.ComboIndex or 1) - 1) % 3 + 1)
									if v75 then
										local v76 = v75:Clone()
										v76.CFrame = v_u_38.CFrame * CFrame.new(0, 0, -5.5) * CFrame.Angles(0, 1.5707963267948966, 0)
										v76.Anchored = false
										v76.CanCollide = false
										v76.CanQuery = false
										v76.CanTouch = false
										v76.Massless = true
										v76.Transparency = 1
										v76.Parent = workspace
										local v77 = Instance.new("WeldConstraint")
										v77.Part0 = v76
										v77.Part1 = v_u_38
										v77.Parent = v76
										for _, v78 in v76:GetDescendants() do
											if v78:IsA("ParticleEmitter") then
												v78:Emit(v78:GetAttribute("EmitCount") or 1)
											end
										end
										v_u_3:AddItem(v76, 2)
									end
								else
									return
								end
							elseif p34.WeaponName == "Rimuru" then
								local v79 = v_u_8:FindFirstChild("Rimuru")
								if v79 then
									local v80 = v79:FindFirstChild("SlashVFX")
									if v80 then
										local v81 = ({ 30, -30, 0 })[(v39 - 1) % 3 + 1] or 0
										local v82 = v80:Clone()
										v82.CFrame = v_u_38.CFrame * CFrame.Angles(0, 3.141592653589793, (math.rad(v81)))
										v82.Anchored = false
										v82.CanCollide = false
										v82.CanQuery = false
										v82.CanTouch = false
										v82.Massless = true
										v82.Transparency = 1
										v82.Parent = workspace
										local v83 = Instance.new("WeldConstraint")
										v83.Part0 = v82
										v83.Part1 = v_u_38
										v83.Parent = v82
										for v84 = 1, 3 do
											local v85 = v82:FindFirstChild("Slash" .. v84)
											if v85 then
												for _, v86 in v85:GetDescendants() do
													if v86:IsA("ParticleEmitter") then
														v86:Emit(v86:GetAttribute("EmitCount") or 1)
													end
												end
											end
										end
										v_u_3:AddItem(v82, 2)
									end
								else
									return
								end
							elseif p34.WeaponName == "Gilgamesh" then
								local v_u_87 = v_u_8
								if v_u_87 then
									v_u_87 = v_u_8:FindFirstChild("Gilgamesh")
								end
								if v_u_87 then
									local v_u_88 = p34.TargetPosition
									local v_u_89 = CFrame.new(-437.6, 3, -192.8)
									local function v_u_98(p90)
										-- upvalues: (copy) v_u_87, (copy) v_u_89, (copy) v_u_38
										local v91 = v_u_87:FindFirstChild(p90)
										if not v91 then
											return nil
										end
										local v92 = v91:Clone()
										local v93 = {}
										if v92:IsA("BasePart") then
											table.insert(v93, v92)
										end
										for _, v94 in v92:GetDescendants() do
											if v94:IsA("BasePart") then
												table.insert(v93, v94)
											end
										end
										for _, v95 in ipairs(v93) do
											local v96 = v_u_89:Inverse() * v95.CFrame
											v95.CFrame = v_u_38.CFrame * v96
											v95.Anchored = true
											v95.CanCollide = false
											v95.CanQuery = false
											v95.CanTouch = false
											v95.CastShadow = false
											v95.Massless = true
										end
										for _, v97 in v92:GetDescendants() do
											if v97:IsA("ParticleEmitter") then
												v97.Enabled = false
											end
										end
										v92.Parent = workspace
										return v92
									end
									local function v_u_102(p99, p100)
										-- upvalues: (ref) v_u_5, (ref) v_u_3
										if p99 and p99.Parent then
											for _, v101 in p99:GetDescendants() do
												if v101:IsA("BasePart") then
													v_u_5:Create(v101, TweenInfo.new(p100, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
														["Transparency"] = 1
													}):Play()
												elseif v101:IsA("ParticleEmitter") then
													v101.Enabled = false
												elseif v101:IsA("Beam") or v101:IsA("Trail") then
													v101.Enabled = false
												end
											end
											v_u_3:AddItem(p99, p100 + 0.5)
										end
									end
									local function v_u_131(p_u_103, p_u_104, p_u_105)
										-- upvalues: (copy) v_u_87, (ref) v_u_9, (ref) v_u_4, (copy) v_u_102, (copy) v_u_88, (ref) v_u_3
										local v106 = v_u_87:FindFirstChild("Trail")
										if v106 then
											local v_u_107 = v106:Clone()
											if v_u_107:IsA("BasePart") then
												v_u_107.CFrame = CFrame.new(p_u_103, p_u_103 + p_u_104)
												v_u_107.Anchored = true
												v_u_107.CanCollide = false
												v_u_107.CanQuery = false
												v_u_107.CanTouch = false
												v_u_107.CastShadow = false
											elseif v_u_107:IsA("Model") then
												v_u_107:PivotTo(CFrame.new(p_u_103, p_u_103 + p_u_104))
												for _, v108 in v_u_107:GetDescendants() do
													if v108:IsA("BasePart") then
														v108.Anchored = true
														v108.CanCollide = false
														v108.CanQuery = false
														v108.CanTouch = false
														v108.CastShadow = false
													end
												end
											end
											v_u_107.Parent = workspace
											for _, v109 in v_u_107:GetDescendants() do
												if v109:IsA("ParticleEmitter") then
													v109.Enabled = true
													local v110 = v109:GetAttribute("EmitCount")
													if v110 and v110 > 0 then
														v109:Emit(v110)
													end
												elseif v109:IsA("Beam") or v109:IsA("Trail") then
													v109.Enabled = true
												end
											end
											if v_u_9 and p_u_105 then
												pcall(function()
													-- upvalues: (ref) v_u_9, (copy) p_u_105, (copy) p_u_103
													v_u_9:PlayAt(p_u_105, p_u_103)
												end)
											end
											local v_u_111 = {}
											local v_u_112
											if v_u_107:IsA("Model") then
												v_u_112 = v_u_107.PrimaryPart or v_u_107:FindFirstChildWhichIsA("BasePart")
												if v_u_112 then
													for _, v113 in v_u_107:GetDescendants() do
														if v113:IsA("BasePart") and v113 ~= v_u_112 then
															v_u_111[v113] = v_u_112.CFrame:Inverse() * v113.CFrame
														end
													end
												end
											else
												v_u_112 = v_u_107
											end
											if v_u_112 then
												local v_u_114 = 0
												local v_u_115 = false
												local v_u_116 = nil
												v_u_116 = v_u_4.Heartbeat:Connect(function(p117)
													-- upvalues: (ref) v_u_115, (ref) v_u_112, (ref) v_u_116, (ref) v_u_114, (ref) v_u_102, (copy) v_u_107, (copy) p_u_104, (ref) v_u_88, (ref) v_u_9, (ref) v_u_87, (ref) v_u_3, (copy) v_u_111
													if v_u_115 or not (v_u_112 and v_u_112.Parent) then
														if v_u_116 then
															v_u_116:Disconnect()
														end
														return
													else
														v_u_114 = v_u_114 + p117
														if v_u_114 >= 2 then
															v_u_115 = true
															v_u_116:Disconnect()
															v_u_102(v_u_107, 0.3)
															return
														else
															local v118 = v_u_88 or v_u_112.Position + p_u_104 * 80
															local v119 = v118 - v_u_112.Position
															local v120 = v119.Magnitude
															if v120 < 3 then
																if v_u_9 then
																	pcall(function()
																		-- upvalues: (ref) v_u_9, (ref) v_u_112
																		v_u_9:PlayAt("GilgameshZ_Hit", v_u_112.Position)
																	end)
																end
																local v121 = v_u_87:FindFirstChild("Explosion")
																if v121 then
																	local v122 = v121:Clone()
																	if v122:IsA("BasePart") then
																		v122.CFrame = CFrame.new(v118)
																		v122.Anchored = true
																		v122.CanCollide = false
																		v122.CanQuery = false
																		v122.CanTouch = false
																		v122.CastShadow = false
																	elseif v122:IsA("Model") then
																		v122:PivotTo(CFrame.new(v118))
																		for _, v123 in v122:GetDescendants() do
																			if v123:IsA("BasePart") then
																				v123.Anchored = true
																				v123.CanCollide = false
																				v123.CanQuery = false
																				v123.CanTouch = false
																				v123.CastShadow = false
																			end
																		end
																	end
																	v122.Parent = workspace
																	for _, v124 in v122:GetDescendants() do
																		if v124:IsA("ParticleEmitter") then
																			v124:Emit(v124:GetAttribute("EmitCount") or v124.Rate)
																		end
																	end
																	v_u_3:AddItem(v122, 3)
																end
																v_u_115 = true
																v_u_116:Disconnect()
																v_u_102(v_u_107, 0.3)
															else
																local v125 = v119.Unit
																local v126 = 250 * p117
																local v127 = v_u_112.Position + v125 * math.min(v126, v120)
																local v128 = CFrame.new(v127, v127 + v125)
																v_u_112.CFrame = v128
																for v129, v130 in pairs(v_u_111) do
																	if v129 and v129.Parent then
																		v129.CFrame = v128 * v130
																	end
																end
																if v_u_114 >= 1.4 and not v_u_115 then
																	v_u_115 = true
																	v_u_116:Disconnect()
																	v_u_102(v_u_107, 0.3)
																end
															end
														end
													end
												end)
											end
										end
									end
									local function v_u_135(p132, p133)
										-- upvalues: (ref) v_u_3
										if p132 then
											for _, v_u_134 in p132:GetDescendants() do
												if v_u_134:IsA("ParticleEmitter") then
													v_u_134.Enabled = true
													task.delay(p133, function()
														-- upvalues: (copy) v_u_134
														if v_u_134 and v_u_134.Parent then
															v_u_134.Enabled = false
														end
													end)
												end
											end
											v_u_3:AddItem(p132, 3)
										end
									end
									if v39 == 1 then
										local v136 = v_u_98("Gate2")
										local v_u_137 = v_u_38.Position + Vector3.new(0, 2, 0)
										if v136 then
											if v136:IsA("BasePart") then
												v_u_137 = v136.Position
											elseif v136:IsA("Model") then
												local v138 = v136.PrimaryPart or v136:FindFirstChildWhichIsA("BasePart")
												if v138 then
													v_u_137 = v138.Position
												end
											end
											v_u_135(v136, 0.4)
											if v_u_9 then
												pcall(function()
													-- upvalues: (ref) v_u_9, (ref) v_u_137
													v_u_9:PlayAt("GilgameshZ_GateSpawn", v_u_137)
												end)
											end
										end
										local v139 = v_u_38.CFrame.LookVector
										if v_u_88 then
											local v140 = v_u_88 - v_u_137
											if v140.Magnitude > 1 then
												v139 = v140.Unit
											end
										end
										v_u_131(v_u_137, v139, "GilgameshZ_Shot1")
										return
									elseif v39 == 2 then
										local v141 = v_u_38.Parent
										local v142 = v_u_87:FindFirstChild("gilgameshsword")
										if v142 and v141 then
											local v143 = v142:Clone()
											local v144 = v141:FindFirstChild("Right Arm") or v141:FindFirstChild("RightHand") or v_u_38
											local v_u_145 = v143:FindFirstChild("Cylinder") or (v143.PrimaryPart or v143:FindFirstChildWhichIsA("BasePart"))
											if v_u_145 then
												if v_u_145:IsA("BasePart") then
													v_u_145.Anchored = false
													v_u_145.CanCollide = false
													v_u_145.CanQuery = false
													v_u_145.CanTouch = false
													v_u_145.CastShadow = false
													v_u_145.Massless = true
												end
												for _, v146 in v_u_145:GetDescendants() do
													if v146:IsA("BasePart") then
														v146.Anchored = false
														v146.CanCollide = false
														v146.CanQuery = false
														v146.CanTouch = false
														v146.CastShadow = false
														v146.Massless = true
													end
												end
												v_u_145.Transparency = 1
												v143.Parent = v141
												local v_u_147 = Instance.new("Motor6D")
												v_u_147.Name = "GilgaM2Cylinder"
												v_u_147.Part0 = v144
												v_u_147.Part1 = v_u_145
												v_u_147.C0 = CFrame.new(-0.101, -1.13, -0.208) * CFrame.Angles(-1.5707963267948966, 0, 0)
												v_u_147.C1 = CFrame.new(-0.094, -2.6, -0.344)
												v_u_147.Parent = v144
												local v148 = v143:FindFirstChildOfClass("AnimationController")
												if v148 then
													local v_u_149 = v148:FindFirstChildOfClass("Animator")
													if not v_u_149 then
														v_u_149 = Instance.new("Animator")
														v_u_149.Parent = v148
													end
													task.defer(function()
														-- upvalues: (ref) v_u_149
														if v_u_149 and v_u_149.Parent then
															local v_u_150 = Instance.new("Animation")
															v_u_150.AnimationId = "rbxassetid://" .. 102619846532924
															pcall(function()
																-- upvalues: (ref) v_u_149, (copy) v_u_150
																local v151 = v_u_149:LoadAnimation(v_u_150)
																v151.Priority = Enum.AnimationPriority.Action4
																v151.Looped = false
																v151:Play()
															end)
														end
													end)
												end
												task.delay(0.25, function()
													-- upvalues: (copy) v_u_145
													if v_u_145 and v_u_145.Parent then
														v_u_145.Transparency = 0
													end
												end)
												v_u_3:AddItem(v143, 3)
												task.delay(3, function()
													-- upvalues: (copy) v_u_147
													if v_u_147 and v_u_147.Parent then
														v_u_147:Destroy()
													end
												end)
											else
												v143:Destroy()
											end
										end
										task.delay(0.16666666666666666, function()
											-- upvalues: (copy) v_u_38, (copy) v_u_98, (copy) v_u_135
											if v_u_38 and v_u_38.Parent then
												v_u_135(v_u_98("Gate"), 0.3)
											end
										end)
										task.delay(0.5666666666666667, function()
											-- upvalues: (copy) v_u_38, (copy) v_u_98, (ref) v_u_3
											if v_u_38 and v_u_38.Parent then
												local v152 = v_u_98("SlashVFX")
												if v152 then
													for _, v153 in v152:GetDescendants() do
														if v153:IsA("ParticleEmitter") then
															v153:Emit(v153:GetAttribute("EmitCount") or 1)
														end
													end
													v_u_3:AddItem(v152, 3)
												end
											end
										end)
										return
									elseif v39 == 3 then
										local v_u_154 = v_u_38.CFrame.LookVector
										local v_u_155 = { "GilgameshZ_Shot1", "GilgameshZ_Shot2", "GilgameshZ_Shot3" }
										for v_u_156, v_u_157 in ipairs({ "Gate3", "Gate4", "Gate5" }) do
											task.delay((v_u_156 - 1) * 0.15, function()
												-- upvalues: (copy) v_u_38, (copy) v_u_98, (copy) v_u_157, (copy) v_u_135, (ref) v_u_9, (copy) v_u_154, (copy) v_u_88, (copy) v_u_131, (copy) v_u_155, (copy) v_u_156
												if v_u_38 and v_u_38.Parent then
													local v158 = v_u_98(v_u_157)
													local v_u_159 = v_u_38.Position + Vector3.new(0, 2, 0)
													if v158 then
														if v158:IsA("BasePart") then
															v_u_159 = v158.Position
														elseif v158:IsA("Model") then
															local v160 = v158.PrimaryPart or v158:FindFirstChildWhichIsA("BasePart")
															if v160 then
																v_u_159 = v160.Position
															end
														end
														v_u_135(v158, 0.4)
														if v_u_9 then
															pcall(function()
																-- upvalues: (ref) v_u_9, (ref) v_u_159
																v_u_9:PlayAt("GilgameshZ_GateSpawn", v_u_159)
															end)
														end
													end
													local v161 = v_u_154
													if v_u_88 then
														local v162 = v_u_88 - v_u_159
														if v162.Magnitude > 1 then
															v161 = v162.Unit
														end
													end
													v_u_131(v_u_159, v161, v_u_155[v_u_156])
												end
											end)
										end
										return
									elseif v39 == 4 then
										v_u_135(v_u_98("Gate1"), 0.3)
										task.delay(0.43333333333333335, function()
											-- upvalues: (copy) v_u_38, (copy) v_u_98, (ref) v_u_3
											if v_u_38 and v_u_38.Parent then
												local v163 = v_u_98("Punch1")
												if v163 then
													for _, v164 in v163:GetDescendants() do
														if v164:IsA("ParticleEmitter") then
															v164:Emit(v164:GetAttribute("EmitCount") or 1)
														end
													end
													v_u_3:AddItem(v163, 3)
												end
											end
										end)
									end
								else
									return
								end
							elseif p34.WeaponName == "BlessedMaiden" or p34.WeaponName == "Blessed Maiden" then
								local v165 = v_u_8:FindFirstChild("BlessedMaiden") or v_u_8:FindFirstChild("Blessed Maiden")
								if v165 then
									local v166 = (v39 - 1) % 4 + 1
									local v167 = ({
										{
											["template"] = "m1/4",
											["delay"] = 0.13333333333333333
										},
										{
											["template"] = "m2/4",
											["delay"] = 0.11666666666666667
										},
										{
											["template"] = "m3/4",
											["delay"] = 0.08333333333333333
										},
										{
											["template"] = "m4/4",
											["delay"] = 0.16666666666666666
										}
									})[v166]
									if v167 then
										local v168 = v165:FindFirstChild(v167.template)
										if v168 then
											local v_u_169 = v168:Clone()
											local v170 = {}
											if v_u_169:IsA("BasePart") then
												table.insert(v170, v_u_169)
											end
											for _, v171 in v_u_169:GetDescendants() do
												if v171:IsA("BasePart") then
													table.insert(v170, v171)
												end
											end
											local v172 = CFrame.new(-73.2, 2.49, 1.48)
											for _, v173 in ipairs(v170) do
												local v174 = v172:Inverse() * v173.CFrame
												v173.CFrame = v_u_38.CFrame * v174
												v173.Anchored = true
												v173.CanCollide = false
												v173.CanQuery = false
												v173.CanTouch = false
												v173.CastShadow = false
												v173.Massless = true
											end
											for _, v175 in v_u_169:GetDescendants() do
												if v175:IsA("ParticleEmitter") then
													v175.Enabled = false
												end
											end
											v_u_169.Parent = workspace
											if shared.vfx and shared.vfx.emit then
												pcall(function()
													-- upvalues: (copy) v_u_169
													shared.vfx.emit(v_u_169)
												end)
											end
											if v166 == 2 then
												local v176 = v165:FindFirstChild("m2/4.2")
												if v176 then
													local v_u_177 = v176:Clone()
													local v178 = {}
													if v_u_177:IsA("BasePart") then
														table.insert(v178, v_u_177)
													end
													for _, v179 in v_u_177:GetDescendants() do
														if v179:IsA("BasePart") then
															table.insert(v178, v179)
														end
													end
													for _, v180 in ipairs(v178) do
														local v181 = v172:Inverse() * v180.CFrame
														v180.CFrame = v_u_38.CFrame * v181
														v180.Anchored = true
														v180.CanCollide = false
														v180.CanQuery = false
														v180.CanTouch = false
														v180.CastShadow = false
														v180.Massless = true
													end
													for _, v182 in v_u_177:GetDescendants() do
														if v182:IsA("ParticleEmitter") then
															v182.Enabled = false
														end
													end
													v_u_177.Parent = workspace
													task.delay(0.36666666666666664, function()
														-- upvalues: (copy) v_u_177
														if v_u_177 and v_u_177.Parent then
															if shared.vfx and shared.vfx.emit then
																pcall(function()
																	-- upvalues: (ref) v_u_177
																	shared.vfx.emit(v_u_177)
																end)
															end
														end
													end)
													v_u_3:AddItem(v_u_177, 3)
												end
											end
											v_u_3:AddItem(v_u_169, 3)
										end
									else
										return
									end
								else
									return
								end
							elseif p34.WeaponName == "TrueAizen" or p34.WeaponName == "True Aizen" then
								local v183 = v_u_8:FindFirstChild("TrueAizen") or v_u_8:FindFirstChild("True Aizen")
								if v183 then
									local v184 = ({
										{
											["template"] = "m1/4",
											["delay"] = 0.11666666666666667
										},
										{
											["template"] = "m2/4",
											["delay"] = 0.08333333333333333
										},
										{
											["template"] = "m3/4",
											["delay"] = 0.1
										},
										{
											["template"] = "m4/4",
											["delay"] = 0.11666666666666667
										}
									})[(v39 - 1) % 4 + 1]
									if v184 then
										local v185 = v183:FindFirstChild(v184.template)
										if v185 then
											local v_u_186 = v185:Clone()
											local v187 = {}
											if v_u_186:IsA("BasePart") then
												table.insert(v187, v_u_186)
											end
											for _, v188 in v_u_186:GetDescendants() do
												if v188:IsA("BasePart") then
													table.insert(v187, v188)
												end
											end
											local v189 = CFrame.new(-108.95, 2.49, 0.59)
											for _, v190 in ipairs(v187) do
												local v191 = v189:Inverse() * v190.CFrame
												v190.CFrame = v_u_38.CFrame * v191
												v190.Anchored = true
												v190.CanCollide = false
												v190.CanQuery = false
												v190.CanTouch = false
												v190.CastShadow = false
												v190.Massless = true
											end
											for _, v192 in v_u_186:GetDescendants() do
												if v192:IsA("ParticleEmitter") then
													v192.Enabled = false
												end
											end
											v_u_186.Parent = workspace
											if shared.vfx and shared.vfx.emit then
												pcall(function()
													-- upvalues: (copy) v_u_186
													shared.vfx.emit(v_u_186)
												end)
											end
											v_u_3:AddItem(v_u_186, 3)
										end
									else
										return
									end
								else
									return
								end
							elseif p34.WeaponName == "Yamato" then
								local v193 = v_u_8:FindFirstChild("Yamato")
								if v193 then
									local v194 = ({
										{
											["template"] = "m1/4"
										},
										{
											["template"] = "m2/4"
										},
										{
											["template"] = "m3/4"
										},
										{
											["template"] = "m4/4"
										}
									})[(v39 - 1) % 4 + 1]
									if v194 then
										local v195 = v193:FindFirstChild(v194.template)
										if v195 then
											local v_u_196 = v195:Clone()
											local v197 = {}
											if v_u_196:IsA("BasePart") then
												table.insert(v197, v_u_196)
											end
											for _, v198 in v_u_196:GetDescendants() do
												if v198:IsA("BasePart") then
													table.insert(v197, v198)
												end
											end
											local v199 = CFrame.new(-150.69, 2.49, -5.51)
											for _, v200 in ipairs(v197) do
												local v201 = v199:Inverse() * v200.CFrame
												v200.CFrame = v_u_38.CFrame * v201
												v200.Anchored = true
												v200.CanCollide = false
												v200.CanQuery = false
												v200.CanTouch = false
												v200.CastShadow = false
												v200.Massless = true
											end
											for _, v202 in v_u_196:GetDescendants() do
												if v202:IsA("ParticleEmitter") then
													v202.Enabled = false
												end
											end
											v_u_196.Parent = workspace
											if shared.vfx and shared.vfx.emit then
												pcall(function()
													-- upvalues: (copy) v_u_196
													shared.vfx.emit(v_u_196)
												end)
											end
											v_u_3:AddItem(v_u_196, 3)
										end
									else
										return
									end
								else
									return
								end
							else
								local v203 = v_u_8:FindFirstChild(p34.WeaponName)
								if v203 then
									local v204 = v203:FindFirstChild("SlashVFX")
									if v204 then
										local v205 = (v39 - 1) % 3 + 1
										local v206 = p34.WeaponName == "Aizen"
										local v207 = v206 and CFrame.identity or (v_u_13[v205] or CFrame.Angles(0, 0, 0))
										local v208 = v206 and 1 or (v_u_14[v205] or 1)
										local v209 = v204:Clone()
										v209.CFrame = v_u_38.CFrame * v207
										if v208 ~= 1 and v209:IsA("BasePart") then
											v209.Size = v209.Size * v208
										end
										v209.Anchored = false
										v209.CanCollide = false
										v209.CanQuery = false
										v209.CanTouch = false
										v209.Massless = true
										v209.Transparency = 1
										v209.Parent = workspace
										local v210 = Instance.new("WeldConstraint")
										v210.Part0 = v209
										v210.Part1 = v_u_38
										v210.Parent = v209
										local v211 = v209:FindFirstChild("Slash" .. v205)
										if v211 then
											for _, v212 in ipairs(v211:GetDescendants()) do
												if v212:IsA("ParticleEmitter") then
													v212:Emit(v212:GetAttribute("EmitCount") or 1)
												end
											end
										end
										v_u_3:AddItem(v209, 2)
									end
								else
									return
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
		else
			return
		end
	end)
else
	warn("[NPCCombatVFXClient] NPCCombatVFX remote not found")
end