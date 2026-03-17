local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("Debris")
local v_u_4 = v2.LocalPlayer
local v5 = v1:WaitForChild("RemoteEvents"):WaitForChild("NPCCombatVFX", 10)
if v5 then
	local v_u_6 = v1:WaitForChild("CombatSystem", 10)
	if v_u_6 then
		v_u_6 = v_u_6:FindFirstChild("VFX")
	end
	local v_u_7 = require(v1:WaitForChild("Modules"):WaitForChild("SoundManager"))
	local v_u_8 = {}
	local function v_u_10(p9)
		-- upvalues: (copy) v_u_8
		if not v_u_8[p9] then
			v_u_8[p9] = {
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
				["ichigoM1"] = 1
			}
		end
		return v_u_8[p9]
	end
	local v_u_11 = { CFrame.Angles(0, 0, 0.7853981633974483), CFrame.Angles(0, 0, -0.7853981633974483), CFrame.Angles(0, 0, 0) }
	local v_u_12 = { 1, 1.2, 1.5 }
	local function v_u_22(p13, p14)
		local v15 = workspace:FindFirstChild("NPCs")
		if v15 then
			if p14 then
				local v16 = (1 / 0)
				local v17 = nil
				for _, v18 in ipairs(v15:GetChildren()) do
					if v18.Name == p13 and v18:IsA("Model") then
						local v19 = v18:FindFirstChild("HumanoidRootPart")
						if v19 then
							local v20 = (v19.Position - p14).Magnitude
							if v20 < v16 then
								v17 = v18
								v16 = v20
							end
						end
					end
				end
				if v17 then
					return v17
				end
			end
			local v21 = v15:FindFirstChild(p13)
			if v21 then
				return v21
			end
		end
		return workspace:FindFirstChild(p13)
	end
	local function v_u_29(p23, p24, p25, p26, p27)
		-- upvalues: (copy) v_u_10, (copy) v_u_7
		local v28 = v_u_10(p23)
		if p24 == "Combat" then
			if p26 then
				v_u_7:PlayAt("CombatHit" .. v28.hit, p27)
				v28.hit = v28.hit % 7 + 1
			else
				v_u_7:PlayAt("CombatSwing" .. v28.swing, p27)
				v28.swing = v28.swing % 4 + 1
			end
		elseif p24 == "Katana" or p24 == "Saber" then
			if p26 then
				v_u_7:PlayAt("SwordHit" .. v28.swordHit, p27)
				v28.swordHit = v28.swordHit % 2 + 1
				return
			elseif p24 == "Katana" then
				v_u_7:PlayAt(({ "KatanaM1_1", "KatanaM1_2", "KatanaM1_3" })[v28.katanaM1], p27)
				v28.katanaM1 = v28.katanaM1 % 3 + 1
			else
				v_u_7:PlayAt(p25 % 2 == 1 and "SaberSlash1" or "SaberSlash2", p27)
			end
		else
			if p24 == "Jinwoo" then
				v_u_7:PlayAt(({ "JinwooM1_1", "JinwooM1_2", "JinwooM1_3" })[v28.jinwooM1], p27)
				v28.jinwooM1 = v28.jinwooM1 % 3 + 1
				if p26 then
					v_u_7:PlayAt("SwordHit" .. v28.swordHit, p27)
					v28.swordHit = v28.swordHit % 2 + 1
					return
				end
			elseif p24 == "Gojo" then
				v_u_7:PlayAt(({ "GojoM1_Blue", "GojoM1_Red", "GojoM1_Purple" })[v28.gojoM1], p27)
				v28.gojoM1 = v28.gojoM1 % 3 + 1
				if p26 then
					v_u_7:PlayAt("CombatHit" .. v28.hit, p27)
					v28.hit = v28.hit % 7 + 1
					return
				end
			elseif p24 == "Sukuna" then
				v_u_7:PlayAt(({ "SukunaM1_1", "SukunaM1_2", "SukunaM1_3" })[v28.sukunaM1], p27)
				v28.sukunaM1 = v28.sukunaM1 % 3 + 1
				if p26 then
					v_u_7:PlayAt("CombatHit" .. v28.hit, p27)
					v28.hit = v28.hit % 7 + 1
					return
				end
			elseif p24 == "Ragna" then
				v_u_7:PlayAt(({ "RagnaM1_1", "RagnaM1_2" })[(p25 - 1) % 2 + 1], p27)
				if p26 then
					v_u_7:PlayAt("SwordHit" .. v28.swordHit, p27)
					v28.swordHit = v28.swordHit % 2 + 1
					return
				end
			elseif p24 == "Aizen" then
				v_u_7:PlayAt(({ "AizenM1_1", "AizenM1_2", "AizenM1_3" })[v28.aizenM1], p27)
				v28.aizenM1 = v28.aizenM1 % 3 + 1
				if p26 then
					v_u_7:PlayAt("SwordHit" .. v28.swordHit, p27)
					v28.swordHit = v28.swordHit % 2 + 1
					return
				end
			else
				if p24 == "QinShi" or p24 == "Qin Shi" then
					if p26 then
						v_u_7:PlayAt("CombatHit" .. v28.hit, p27)
						v28.hit = v28.hit % 7 + 1
					else
						v_u_7:PlayAt("CombatSwing" .. v28.swing, p27)
						v28.swing = v28.swing % 4 + 1
					end
				end
				if p24 == "Alucard" then
					v_u_7:PlayAt(({ "AlucardM1_1", "AlucardM1_2", "AlucardM1_3" })[v28.alucardM1], p27)
					v28.alucardM1 = v28.alucardM1 % 3 + 1
					if p26 then
						v_u_7:PlayAt("CombatHit" .. v28.hit, p27)
						v28.hit = v28.hit % 7 + 1
						return
					end
				elseif p24 == "Ichigo" then
					v_u_7:PlayAt(({ "IchigoM1_1", "IchigoM1_2", "IchigoM1_3" })[v28.ichigoM1], p27)
					v28.ichigoM1 = v28.ichigoM1 % 3 + 1
					if p26 then
						v_u_7:PlayAt("CombatHit" .. v28.hit, p27)
						v28.hit = v28.hit % 7 + 1
						return
					end
				elseif p24 == "StrongestInHistory" then
					v_u_7:PlayAt(({ "StrongestInHistoryM1_1", "StrongestInHistoryM1_2", "StrongestInHistoryM1_3" })[v28.strongestHistoryM1], p27)
					v28.strongestHistoryM1 = v28.strongestHistoryM1 % 3 + 1
					if p26 then
						v_u_7:PlayAt("CombatHit" .. v28.hit, p27)
						v28.hit = v28.hit % 7 + 1
					end
				end
			end
			return
		end
	end
	local v_u_30 = {}
	local v_u_31 = {}
	v5.OnClientEvent:Connect(function(p32)
		-- upvalues: (copy) v_u_30, (copy) v_u_22, (copy) v_u_31, (copy) v_u_29, (copy) v_u_4, (copy) v_u_6, (copy) v_u_3, (copy) v_u_11, (copy) v_u_12
		if p32 then
			local v33 = p32.NPCModel .. "_vfx"
			local v34 = tick()
			if v_u_30[v33] and v34 - v_u_30[v33] < 0.4 then
				return
			else
				v_u_30[v33] = v34
				local v35 = v_u_22(p32.NPCModel, p32.Position)
				if v35 then
					local v36 = v35:FindFirstChild("HumanoidRootPart")
					if v36 then
						local v37 = p32.ComboIndex or 1
						local v38 = p32.DidHit ~= false
						local v39 = p32.NPCModel .. "_sound"
						local v40 = tick()
						if (not v_u_31[v39] or v40 - v_u_31[v39] >= 0.4) and true or false then
							v_u_31[v39] = v40
							v_u_29(p32.NPCModel, p32.WeaponName, v37, v38, v36.Position)
						end
						if v_u_4:GetAttribute("DisableVFX") == true then
							return
						elseif p32.WeaponName == "Combat" then
							return
						elseif v_u_6 then
							if p32.WeaponName == "Alucard" then
								local v41 = v_u_6:FindFirstChild("Alucard")
								if v41 then
									local v42 = p32.ComboIndex or 1
									local v43 = v41:FindFirstChild("Punch" .. (v42 - 1) % 3 + 1)
									if v43 then
										local v44 = v43:Clone()
										v44.CFrame = v36.CFrame * CFrame.new(0, 0, -5.5) * CFrame.Angles(0, 1.5707963267948966, 0)
										v44.Anchored = false
										v44.CanCollide = false
										v44.CanQuery = false
										v44.CanTouch = false
										v44.Massless = true
										v44.Transparency = 1
										v44.Parent = workspace
										local v45 = Instance.new("WeldConstraint")
										v45.Part0 = v44
										v45.Part1 = v36
										v45.Parent = v44
										local v46 = Color3.fromRGB(0, 133, 200)
										local v47 = Color3.fromRGB(255, 50, 50)
										if v42 == 1 then
											v47 = v46
										elseif v42 == 2 then
											v46 = v47
										end
										for _, v48 in v44:GetDescendants() do
											if v48:IsA("ParticleEmitter") then
												local v49 = v48.Color
												local v50 = {}
												for _, v51 in ipairs(v49.Keypoints) do
													local v52 = v46:Lerp(v47, v51.Time)
													local v53 = ColorSequenceKeypoint.new
													local v54 = v51.Time
													table.insert(v50, v53(v54, v52))
												end
												v48.Color = ColorSequence.new(v50)
												local v55 = v48.Size
												local v56 = {}
												for _, v57 in ipairs(v55.Keypoints) do
													local v58 = NumberSequenceKeypoint.new
													local v59 = v57.Time
													local v60 = v57.Value * 0.6
													local v61 = v57.Envelope * 0.6
													table.insert(v56, v58(v59, v60, v61))
												end
												v48.Size = NumberSequence.new(v56)
												v48:Emit(v48:GetAttribute("EmitCount") or 1)
											end
										end
										v_u_3:AddItem(v44, 2)
									end
								else
									return
								end
							elseif p32.WeaponName == "StrongestInHistory" then
								local v62 = v_u_6:FindFirstChild("Strongest In History")
								if v62 then
									local v63 = v62:FindFirstChild("Punch" .. ((p32.ComboIndex or 1) - 1) % 3 + 1)
									if v63 then
										local v64 = v63:Clone()
										v64.CFrame = v36.CFrame * CFrame.new(0, 0, -5.5) * CFrame.Angles(0, 1.5707963267948966, 0)
										v64.Anchored = false
										v64.CanCollide = false
										v64.CanQuery = false
										v64.CanTouch = false
										v64.Massless = true
										v64.Transparency = 1
										v64.Parent = workspace
										local v65 = Instance.new("WeldConstraint")
										v65.Part0 = v64
										v65.Part1 = v36
										v65.Parent = v64
										for _, v66 in v64:GetDescendants() do
											if v66:IsA("ParticleEmitter") then
												v66:Emit(v66:GetAttribute("EmitCount") or 1)
											end
										end
										v_u_3:AddItem(v64, 2)
									end
								else
									return
								end
							elseif p32.WeaponName == "QinShi" or p32.WeaponName == "Qin Shi" then
								local v67 = v_u_6:FindFirstChild("Qin Shi") or v_u_6:FindFirstChild("QinShi")
								if v67 then
									local v68 = v67:FindFirstChild("Punch" .. ((p32.ComboIndex or 1) - 1) % 3 + 1)
									if v68 then
										local v69 = v68:Clone()
										v69.CFrame = v36.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0)
										v69.Anchored = false
										v69.CanCollide = false
										v69.CanQuery = false
										v69.CanTouch = false
										v69.Massless = true
										v69.Transparency = 1
										v69.Parent = workspace
										local v70 = Instance.new("WeldConstraint")
										v70.Part0 = v69
										v70.Part1 = v36
										v70.Parent = v69
										for _, v71 in v69:GetDescendants() do
											if v71:IsA("ParticleEmitter") then
												v71:Emit(v71:GetAttribute("EmitCount") or 1)
											end
										end
										v_u_3:AddItem(v69, 2)
									end
								else
									return
								end
							else
								local v72 = v_u_6:FindFirstChild(p32.WeaponName)
								if v72 then
									local v73 = v72:FindFirstChild("SlashVFX")
									if v73 then
										local v74 = (v37 - 1) % 3 + 1
										local v75 = p32.WeaponName == "Aizen"
										local v76 = v75 and CFrame.identity or (v_u_11[v74] or CFrame.Angles(0, 0, 0))
										local v77 = v75 and 1 or (v_u_12[v74] or 1)
										local v78 = v73:Clone()
										v78.CFrame = v36.CFrame * v76
										if v77 ~= 1 and v78:IsA("BasePart") then
											v78.Size = v78.Size * v77
										end
										v78.Anchored = false
										v78.CanCollide = false
										v78.CanQuery = false
										v78.CanTouch = false
										v78.Massless = true
										v78.Transparency = 1
										v78.Parent = workspace
										local v79 = Instance.new("WeldConstraint")
										v79.Part0 = v78
										v79.Part1 = v36
										v79.Parent = v78
										local v80 = v78:FindFirstChild("Slash" .. v74)
										if v80 then
											for _, v81 in ipairs(v80:GetDescendants()) do
												if v81:IsA("ParticleEmitter") then
													v81:Emit(v81:GetAttribute("EmitCount") or 1)
												end
											end
										end
										v_u_3:AddItem(v78, 2)
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