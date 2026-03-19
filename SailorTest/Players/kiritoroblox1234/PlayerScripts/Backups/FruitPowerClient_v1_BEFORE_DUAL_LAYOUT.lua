local v1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = v1.LocalPlayer
local v_u_6 = v_u_5:GetMouse()
local v7 = v_u_2:WaitForChild("FruitPowerSystem")
local v_u_8 = require(v7:WaitForChild("FruitPowerConfig"))
local _ = {
	[Enum.KeyCode.ButtonX] = 1,
	[Enum.KeyCode.ButtonY] = 2,
	[Enum.KeyCode.ButtonB] = 3,
	[Enum.KeyCode.ButtonL2] = 4,
	[Enum.KeyCode.DPadRight] = 5
}
local v_u_9 = require(v_u_2:WaitForChild("CooldownUIManager"))
local v_u_10 = require(v_u_2:WaitForChild("HitboxVisualizer"))
local v_u_11 = false
local v12 = v_u_2:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("AbilityStateChanged", 5)
if v12 then
	v12.OnClientEvent:Connect(function(p13)
		-- upvalues: (ref) v_u_11
		v_u_11 = p13
		if p13 == true then
			task.delay(15, function()
				-- upvalues: (ref) v_u_11
				if v_u_11 == true then
					v_u_11 = false
				end
			end)
		end
	end)
end
local v_u_14 = {}
for _, v15 in v7:WaitForChild("VFXHandlers"):GetChildren() do
	if v15:IsA("ModuleScript") then
		local v16, v17 = pcall(require, v15)
		if v16 then
			v_u_14[v15.Name] = v17
		else
			warn("[FruitPowerClient] Failed to load VFXHandler:", v15.Name)
		end
	end
end
local v18 = v_u_2:WaitForChild("RemoteEvents")
local v_u_19 = v18:WaitForChild("FruitPowerRemote")
local v20 = v18:WaitForChild("FruitPowerResponse")
local v21 = v_u_2:WaitForChild("FruitPowerSystem"):WaitForChild("Remotes")
local v22 = v21:WaitForChild("RequestMousePos")
local v_u_23 = v21:WaitForChild("ReturnMousePos")
local v_u_24 = {}
local v_u_25 = 0
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = {}
local function v_u_32()
	-- upvalues: (copy) v_u_5, (copy) v_u_8
	local v29 = v_u_5.Character
	if not v29 then
		return nil
	end
	for v30, v31 in pairs(v_u_8.Powers) do
		if v29:FindFirstChild(v31.ToolName) then
			return v30, v31
		end
	end
	return nil
end
v3.InputBegan:Connect(function(p33, p34)
	-- upvalues: (copy) v_u_32, (copy) v_u_8, (copy) v_u_2, (ref) v_u_11, (copy) v_u_5, (copy) v_u_24, (ref) v_u_26, (copy) v_u_6, (copy) v_u_19, (ref) v_u_27, (copy) v_u_4, (ref) v_u_28
	if p34 then
		return
	else
		local v35, _ = v_u_32()
		if v35 then
			local v36 = v_u_8.GetAbilityByKey(v35, p33.KeyCode)
			if v36 and v36.Type == "Toggle" then
				if v35 == "Light" and v36.Key == "V" then
					local v37 = v_u_2:FindFirstChild("Light")
					if v37 then
						v37 = v37:FindFirstChild("LightFlightEvent")
					end
					if v37 then
						local v38 = workspace.CurrentCamera
						v37:FireServer("toggle", {
							["Direction"] = v38 and v38.CFrame.LookVector or Vector3.new(0, 0, -1)
						})
					end
				end
				return
			end
		end
		if v_u_11 then
			return
		else
			local v39 = (p33.KeyCode == Enum.KeyCode.Z or (p33.KeyCode == Enum.KeyCode.X or (p33.KeyCode == Enum.KeyCode.C or (p33.KeyCode == Enum.KeyCode.V or (p33.KeyCode == Enum.KeyCode.ButtonX or (p33.KeyCode == Enum.KeyCode.ButtonY or (p33.KeyCode == Enum.KeyCode.ButtonB or p33.KeyCode == Enum.KeyCode.ButtonL2))))))) and true or p33.KeyCode == Enum.KeyCode.DPadRight
			if v35 then
				local v40 = v_u_8.GetAbilityByKey(v35, p33.KeyCode)
				if v40 then
					if v40.Type == "HoldRelease" then
						local v41 = v_u_24[v40.Name]
						if v41 then
							v41 = tick() < v41
						end
						if v41 then
							return
						elseif not v_u_26 then
							local v42 = workspace:Raycast(v_u_6.UnitRay.Origin, v_u_6.UnitRay.Direction * 500, RaycastParams.new())
							local v43 = v42 and v42.Position or v_u_6.UnitRay.Origin + v_u_6.UnitRay.Direction * 100
							v_u_26 = {
								["PowerName"] = v35,
								["Ability"] = v40,
								["KeyCode"] = p33.KeyCode,
								["TargetPosition"] = v43
							}
							v_u_11 = true
							v_u_19:FireServer("UseAbility", {
								["FruitPower"] = v35,
								["KeyCode"] = p33.KeyCode,
								["TargetPosition"] = v43
							})
							if v_u_27 then
								v_u_27:Disconnect()
							end
							local v_u_44 = 0
							v_u_27 = v_u_4.RenderStepped:Connect(function()
								-- upvalues: (ref) v_u_26, (ref) v_u_6, (ref) v_u_44, (ref) v_u_19
								if v_u_26 then
									local v45 = workspace:Raycast(v_u_6.UnitRay.Origin, v_u_6.UnitRay.Direction * 500, RaycastParams.new())
									local v46 = v45 and v45.Position or v_u_6.UnitRay.Origin + v_u_6.UnitRay.Direction * 100
									v_u_26.TargetPosition = v46
									local v47 = tick()
									if v47 - v_u_44 >= 0.05 then
										v_u_44 = v47
										v_u_19:FireServer("HoldReleaseUpdate", {
											["TargetPosition"] = v46
										})
									end
								end
							end)
						end
					elseif v40.Type == "Toggle" then
						return
					else
						local v48 = v_u_24[v40.Name]
						if v48 then
							v48 = tick() < v48
						end
						if not v48 then
							local v49 = {
								["FruitPower"] = v35,
								["KeyCode"] = p33.KeyCode
							}
							if v40.Type == "Targeted" or v40.Type == "Channeled" then
								local v50 = workspace:Raycast(v_u_6.UnitRay.Origin, v_u_6.UnitRay.Direction * 500, RaycastParams.new())
								v49.TargetPosition = v50 and v50.Position or v_u_6.UnitRay.Origin + v_u_6.UnitRay.Direction * 100
							elseif v40.Type == "Projectile" then
								local v51 = v_u_5.Character
								local v52 = v51
								if v52 then
									v52 = v51:FindFirstChild("HumanoidRootPart")
								end
								if v52 then
									local v53 = workspace:Raycast(v_u_6.UnitRay.Origin, v_u_6.UnitRay.Direction * 500, RaycastParams.new())
									v49.Direction = ((v53 and v53.Position or v_u_6.UnitRay.Origin + v_u_6.UnitRay.Direction * 100) - v52.Position).Unit
								end
							elseif v40.Type == "ProjectileOrb" then
								local v54 = v_u_5.Character
								local v55 = v54
								if v55 then
									v55 = v54:FindFirstChild("HumanoidRootPart")
								end
								if v55 then
									local v56 = workspace:Raycast(v_u_6.UnitRay.Origin, v_u_6.UnitRay.Direction * 500, RaycastParams.new())
									local v57 = v56 and v56.Position or v_u_6.UnitRay.Origin + v_u_6.UnitRay.Direction * 100
									v49.TargetPosition = v57
									v49.Direction = (v57 - v55.Position).Unit
								end
							end
							v_u_11 = true
							v_u_19:FireServer("UseAbility", v49)
							if v40.Type == "Channeled" then
								v_u_28[v40.Name] = true
							end
						end
					end
				else
					return
				end
			else
				local v58 = v39 and v_u_5.Character
				if v58 then
					for _, v59 in v58:GetChildren() do
						v59:IsA("Tool")
					end
				end
				return
			end
		end
	end
end)
v_u_4.RenderStepped:Connect(function()
	-- upvalues: (ref) v_u_28, (copy) v_u_6, (copy) v_u_19
	for _, _ in pairs(v_u_28) do
		local v60 = workspace:Raycast(v_u_6.UnitRay.Origin, v_u_6.UnitRay.Direction * 500, RaycastParams.new())
		v_u_19:FireServer("UpdateChannelPosition", {
			["Position"] = v60 and v60.Position or v_u_6.UnitRay.Origin + v_u_6.UnitRay.Direction * 100
		})
	end
end)
v3.InputEnded:Connect(function(p61)
	-- upvalues: (copy) v_u_32, (copy) v_u_8, (ref) v_u_28, (copy) v_u_19
	local v62, _ = v_u_32()
	if v62 then
		local v63 = v_u_8.GetAbilityByKey(v62, p61.KeyCode)
		if v63 and (v63.Type == "Channeled" and v_u_28[v63.Name]) then
			v_u_28[v63.Name] = nil
			v_u_19:FireServer("CancelChannel", {})
		end
	end
end)
v3.InputBegan:Connect(function(p64, p65)
	-- upvalues: (ref) v_u_26, (ref) v_u_27, (copy) v_u_19
	if not p65 then
		if p64.UserInputType == Enum.UserInputType.MouseButton1 and v_u_26 then
			if v_u_27 then
				v_u_27:Disconnect()
				v_u_27 = nil
			end
			v_u_19:FireServer("HoldReleaseExecute", {
				["TargetPosition"] = v_u_26.TargetPosition
			})
			v_u_26 = nil
		end
	end
end)
local v_u_66 = {}
v20.OnClientEvent:Connect(function(p67, p68)
	-- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_14, (ref) v_u_25, (copy) v_u_2, (copy) v_u_66, (copy) v_u_10, (copy) v_u_4, (copy) v_u_9, (copy) v_u_24
	if p67 == "AbilityVFX" then
		local v69 = p68.PowerName
		local v70 = p68.AbilityName
		local v71 = p68.Player
		if v_u_5:GetAttribute("DisableOtherVFX") and v71 ~= v_u_5 then
			return
		end
		local v72
		if v71 then
			v72 = v71.Character
		else
			v72 = v71
		end
		if not v72 then
			return
		end
		if v71 == v_u_5 and p68.StartCFrame then
			local v73 = v_u_8.GetPower(v69)
			if v73 then
				v73 = v_u_8.GetAbilityByKey(v69, p68.AbilityKey)
			end
			local v74 = v73 and v73.MovementLockDuration
			if v74 then
				v74 = v73.MovementLockDuration > 0
			end
			local v75 = v74 and v72:FindFirstChild("HumanoidRootPart")
			if v75 then
				v75.CFrame = p68.StartCFrame
			end
		end
		local v76 = v_u_14[v69]
		if v69 == "Light" and (v70 == "LightStrike" and v71 == v_u_5) then
			local v77 = tick()
			if v77 - v_u_25 > 3 then
				v_u_25 = v77
				require(v_u_2:WaitForChild("Modules"):WaitForChild("SoundManager")):Play("LightC")
			end
		end
		if v76 and v76[v70] then
			local v78 = v_u_8.GetPower(v69)
			local v79 = nil
			if v78 and v78.Abilities then
				for _, v80 in ipairs(v78.Abilities) do
					if v80.VFXName == v70 or v80.Name == v70 then
						v79 = v80
						break
					end
				end
			end
			local v81 = v79 or {}
			for v82, v83 in pairs(p68) do
				v81[v82] = v83
			end
			local v84 = v76[v70](v72, v81, p68.Direction, p68.TargetPosition or p68.Position)
			if p68.IsChanneled and v84 then
				v_u_66[v71] = v84
			end
		end
		if p68.HitboxPosition or p68.IsContinuousAura then
			local v85 = Color3.fromRGB(255, 50, 50)
			if p68.IsContinuousAura and p68.HitboxRadius then
				local v86 = v72:FindFirstChild("HumanoidRootPart")
				if v86 then
					local v87 = Color3.fromRGB(255, 50, 50)
					v_u_10.ShowWeldedSphere(v86, p68.HitboxRadius, (p68.Duration or 3) - 1, v87, v71)
				end
			elseif p68.HitboxShape == "Sphere" and p68.HitboxRadius then
				local v88 = p68.HitboxDuration or 0.5
				v_u_10.ShowSphere(p68.HitboxPosition, p68.HitboxRadius, v88, v85)
			elseif p68.HitboxSize then
				local v89 = p68.HitboxDuration or 0.5
				local v90 = p68.HitboxCFrame or CFrame.new(p68.HitboxPosition)
				v_u_10.ShowBox(v90, p68.HitboxSize, v89, v85)
			end
		end
		if p68.IsTravelingProjectile and (p68.Direction and (v71 == v_u_5 and v_u_5:GetAttribute("ShowHitbox"))) then
			local v_u_91 = p68.Position + Vector3.new(0, 1, 0)
			local v_u_92 = p68.Direction.Unit
			local v_u_93 = p68.ProjectileDistance or 75
			local v_u_94 = p68.ProjectileDuration or 1
			local v95 = p68.ProjectileDelay or 0.05
			local v_u_96 = p68.HitboxRadius or 25
			local v_u_97 = p68.HitboxSize or Vector3.new(25, 25, 25)
			local v_u_98 = p68.HitboxShape or "Sphere"
			task.delay(v95, function()
				-- upvalues: (copy) v_u_98, (copy) v_u_96, (copy) v_u_97, (copy) v_u_91, (ref) v_u_4, (copy) v_u_94, (copy) v_u_92, (copy) v_u_93
				local v99 = Color3.fromRGB(255, 50, 50)
				local v100 = Enum.Material.Neon
				local v_u_101 = Instance.new("Part")
				v_u_101.Name = "TravelingHitbox"
				v_u_101.Anchored = true
				v_u_101.CanCollide = false
				v_u_101.CanQuery = false
				v_u_101.CastShadow = false
				v_u_101.Transparency = 0.8
				v_u_101.Color = v99
				v_u_101.Material = v100
				if v_u_98 == "Sphere" then
					v_u_101.Shape = Enum.PartType.Ball
					local v102 = v_u_96 * 2
					local v103 = v_u_96 * 2
					local v104 = v_u_96 * 2
					v_u_101.Size = Vector3.new(v102, v103, v104)
				else
					v_u_101.Size = v_u_97
				end
				v_u_101.CFrame = CFrame.new(v_u_91)
				v_u_101.Parent = workspace
				local v_u_105 = 0
				local v_u_106 = nil
				v_u_106 = v_u_4.Heartbeat:Connect(function(p107)
					-- upvalues: (ref) v_u_105, (ref) v_u_94, (ref) v_u_91, (ref) v_u_92, (ref) v_u_93, (ref) v_u_98, (copy) v_u_101, (ref) v_u_106, (ref) v_u_4
					v_u_105 = v_u_105 + p107
					local v108 = v_u_105 / v_u_94
					local v109 = math.clamp(v108, 0, 1)
					local v110 = v_u_91 + v_u_92 * (v_u_93 * v109)
					if v_u_98 == "Sphere" then
						v_u_101.CFrame = CFrame.new(v110)
					else
						local v111 = v_u_101
						local v112 = CFrame.new(v110)
						local v113 = CFrame.Angles
						local v114 = -v_u_92.X
						local v115 = -v_u_92.Z
						v111.CFrame = v112 * v113(0, math.atan2(v114, v115), 0)
					end
					if v109 >= 1 then
						v_u_106:Disconnect()
						local v_u_116 = tick()
						local v_u_117 = nil
						v_u_117 = v_u_4.Heartbeat:Connect(function()
							-- upvalues: (copy) v_u_116, (ref) v_u_101, (ref) v_u_117
							local v118 = tick() - v_u_116
							v_u_101.Transparency = 0.8 + v118 / 0.3 * 0.19999999999999996
							if v118 >= 0.3 then
								v_u_117:Disconnect()
								v_u_101:Destroy()
							end
						end)
					end
				end)
			end)
			return
		end
	elseif p67 == "SpawnMultipleOrbs" then
		local v119 = p68.Player
		if v119 then
			v119 = v119.Character
		end
		if v119 then
			local v120 = v_u_14[p68.PowerName]
			if v120 and v120.SpawnMultipleOrbs then
				v120.SpawnMultipleOrbs(v119, p68)
				return
			end
		end
	elseif p67 == "HoldReleaseStart" then
		if p68.PowerName == "Light" then
			require(v_u_2:WaitForChild("Modules"):WaitForChild("SoundManager")):Play("LightC")
		end
		local v121 = p68.Player
		if v121 then
			v121 = v121.Character
		end
		if v121 then
			local v122 = v_u_14[p68.PowerName]
			if v122 and v122.StartLightStrikeTarget then
				v122.StartLightStrikeTarget(v121, p68, nil, p68.TargetPosition)
				return
			end
		end
	elseif p67 == "HoldReleaseUpdate" then
		local v123 = p68.Player
		if v123 then
			v123 = v123.Character
		end
		if v123 then
			local v124 = v_u_14.Light
			if v124 and v124.UpdateLightStrikeTarget then
				v124.UpdateLightStrikeTarget(v123, p68, nil, p68.TargetPosition)
				return
			end
		end
	elseif p67 == "HoldReleaseExecute" then
		local v125 = p68.Player
		if v125 then
			v125 = v125.Character
		end
		if v125 then
			local v126 = v_u_14[p68.PowerName]
			if v126 and v126.LightStrike then
				v126.LightStrike(v125, p68, nil, p68.TargetPosition)
			end
		end
		if p68.HitboxRadius then
			v_u_10.ShowSphere(p68.TargetPosition, p68.HitboxRadius, p68.BeamTravelTime or 0.4)
			return
		end
	elseif p67 == "HoldReleaseCancel" then
		local v127 = p68.Player
		if v127 then
			v127 = v127.Character
		end
		if v127 then
			local v128 = v_u_14.Light
			if v128 and v128.CancelLightStrikeTarget then
				v128.CancelLightStrikeTarget(v127)
				return
			end
		end
	else
		if p67 == "CooldownStarted" then
			if not cooldownUIInitialized and pcall(function()
				-- upvalues: (ref) v_u_9
				v_u_9:Init()
			end) then
				cooldownUIInitialized = true
			end
			local v_u_129 = p68.Ability
			local v_u_130 = p68.Duration
			local v_u_131 = p68.Key
			local v_u_132 = p68.PowerName or "Fruit"
			v_u_24[v_u_129] = tick() + v_u_130
			pcall(function()
				-- upvalues: (copy) v_u_131, (ref) v_u_9, (copy) v_u_132, (copy) v_u_129, (copy) v_u_130
				v_u_9:StartCooldown(v_u_132, v_u_129, v_u_131, v_u_130)
			end)
			return
		end
		if p67 == "ChannelPositionUpdate" then
			local v133 = p68.Player
			local v134 = p68.Position
			if v_u_66[v133] then
				local v135 = v_u_14.Light
				if v135 and v135.UpdateBeamPosition then
					v135.UpdateBeamPosition(v_u_66[v133], v134)
					return
				end
			end
		elseif p67 == "ChannelCancelled" then
			local v136 = p68.Player
			if v_u_66[v136] then
				local v137 = v_u_14.Light
				if v137 and v137.StopBeam then
					v137.StopBeam(v_u_66[v136])
				end
				v_u_66[v136] = nil
				return
			end
		elseif p67 == "PlayerInvisible" then
			local v138 = p68.Player
			local v139
			if v138 then
				v139 = v138.Character
			else
				v139 = v138
			end
			if not v139 then
				return
			end
			local v140 = v138 == v_u_5
			local v141 = v_u_14.Invisible
			if v141 and v141.ShadowCloak then
				v141.ShadowCloak(v139, p68, v140)
				return
			end
		elseif p67 == "PlayerVisible" then
			local v142 = p68.Player
			if v142 then
				v142 = v142.Character
			end
			if not v142 then
				return
			end
			local v143 = v_u_14.Invisible
			if v143 and v143.EndShadowCloak then
				v143.EndShadowCloak(v142, p68)
				return
			end
		elseif p67 == "FlameOrbShake" then
			local v144 = v_u_14.Flame
			if v144 and v144.FlameOrbShake then
				v144.FlameOrbShake(p68.Position)
				return
			end
		elseif p67 == "ShowExplosionHitbox" then
			if p68.Position and p68.Radius then
				local v145 = Color3.fromRGB(255, 50, 50)
				v_u_10.ShowSphere(p68.Position, p68.Radius, p68.Duration or 0.4, v145)
				return
			end
		elseif p67 == "ContinuousAuraUpdate" then
			if p68.Position and p68.Radius then
				local v146 = Color3.fromRGB(255, 50, 50)
				v_u_10.ShowSphere(p68.Position, p68.Radius, 0.25, v146)
				return
			end
		else
			if p67 == "ContinuousAuraEnd" then
				local v147 = p68.Player
				local v148
				if v147 then
					v148 = v147.Character
				else
					v148 = v147
				end
				if v148 then
					local v149 = v_u_14.Flame
					if v149 and v149.EndFlameBurst then
						v149.EndFlameBurst(v147)
					end
				end
				v_u_10.EndWeldedSphere(v147)
				return
			end
			if p67 == "ProjectileOrbTravel" then
				local v150 = p68.Player
				local v151
				if v150 then
					v151 = v150.Character
				else
					v151 = v150
				end
				if v151 then
					local v152 = p68.PowerName or "Flame"
					local v153 = v_u_14[v152]
					local v154 = v153 and (v153[v152 .. "OrbTravel"] or (v153.FlameOrbTravel or v153.LightOrbTravel))
					if v154 then
						v154(v150, p68.TargetPosition, p68.Direction, p68.ProjectileSpeed, p68.MaxDistance, p68.OrbIndex or 1)
						return
					end
				end
			elseif p67 == "SpawnSingleOrb" then
				local v155 = p68.Player
				if v155 then
					v155 = v155.Character
				end
				if v155 then
					local v156 = v_u_14[p68.PowerName or "Light"]
					if v156 and v156.SpawnSingleOrb then
						v156.SpawnSingleOrb(v155, p68)
						return
					end
				end
			elseif p67 == "SequentialOrbTravel" then
				local v157 = p68.Player
				local v158
				if v157 then
					v158 = v157.Character
				else
					v158 = v157
				end
				if v158 then
					local v159 = v_u_14[p68.PowerName or "Light"]
					if v159 and v159.SequentialOrbTravel then
						v159.SequentialOrbTravel(v157, p68.TargetPosition, p68.Direction, p68.ProjectileSpeed, p68.MaxDistance, p68.OrbIndex or 1)
						return
					end
				end
			elseif p67 == "BezierOrbSpawn" and p68.Player then
				local v160 = v_u_14[p68.PowerName or "Light"]
				if v160 and v160.SpawnLightOrb then
					v160.SpawnLightOrb(p68)
				end
			end
		end
	end
end)
local function v161(_)
	-- upvalues: (ref) v_u_28, (copy) v_u_66, (copy) v_u_5, (ref) v_u_11
	v_u_28 = {}
	v_u_66[v_u_5] = nil
	v_u_11 = false
end
v_u_5.CharacterAdded:Connect(v161)
if v_u_5.Character then
	local _ = v_u_5.Character
	v_u_28 = {}
	v_u_66[v_u_5] = nil
	v_u_11 = false
end
v22.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_6, (copy) v_u_23
	local v162 = workspace:Raycast(v_u_6.UnitRay.Origin, v_u_6.UnitRay.Direction * 500, RaycastParams.new())
	v_u_23:FireServer(v162 and v162.Position or v_u_6.UnitRay.Origin + v_u_6.UnitRay.Direction * 100)
end)
local v_u_163 = false
local v_u_164 = nil
local function v169()
	-- upvalues: (ref) v_u_164, (ref) v_u_163, (copy) v_u_2, (copy) v_u_4
	if v_u_164 then
		return
	else
		v_u_163 = true
		local v_u_165 = v_u_2:FindFirstChild("Light")
		if v_u_165 then
			v_u_165 = v_u_165:FindFirstChild("LightFlightEvent")
		end
		if v_u_165 then
			local v_u_166 = workspace.CurrentCamera
			local v_u_167 = 0
			v_u_164 = v_u_4.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u_163, (ref) v_u_164, (ref) v_u_167, (copy) v_u_166, (copy) v_u_165
				if v_u_163 then
					local v168 = tick()
					if v168 - v_u_167 >= 0.05 then
						v_u_167 = v168
						if v_u_166 then
							v_u_165:FireServer("updateDirection", {
								["Direction"] = v_u_166.CFrame.LookVector
							})
						end
					end
				else
					if v_u_164 then
						v_u_164:Disconnect()
						v_u_164 = nil
					end
					return
				end
			end)
		end
	end
end
local function v170()
	-- upvalues: (ref) v_u_163, (ref) v_u_164
	v_u_163 = false
	if v_u_164 then
		v_u_164:Disconnect()
		v_u_164 = nil
	end
end
_G.StartLightFlightUpdates = v169
_G.StopLightFlightUpdates = v170
local function v173()
	-- upvalues: (copy) v_u_5, (ref) v_u_26, (ref) v_u_27, (copy) v_u_19, (ref) v_u_11
	local v171 = v_u_5.Character
	if v171 then
		local v172 = v171:FindFirstChildOfClass("Humanoid")
		if v172 then
			v172.Died:Connect(function()
				-- upvalues: (ref) v_u_26, (ref) v_u_27, (ref) v_u_19, (ref) v_u_11
				if v_u_26 then
					if v_u_27 then
						v_u_27:Disconnect()
						v_u_27 = nil
					end
					v_u_19:FireServer("HoldReleaseCancel", {})
					v_u_26 = nil
					v_u_11 = false
				end
			end)
		end
	end
end
v_u_5.CharacterAdded:Connect(v173)
if v_u_5.Character then
	local v174 = v_u_5.Character
	local v175 = v174 and v174:FindFirstChildOfClass("Humanoid")
	if v175 then
		v175.Died:Connect(function()
			-- upvalues: (ref) v_u_26, (ref) v_u_27, (copy) v_u_19, (ref) v_u_11
			if v_u_26 then
				if v_u_27 then
					v_u_27:Disconnect()
					v_u_27 = nil
				end
				v_u_19:FireServer("HoldReleaseCancel", {})
				v_u_26 = nil
				v_u_11 = false
			end
		end)
	end
end
local function v179()
	-- upvalues: (copy) v_u_5, (ref) v_u_26, (ref) v_u_27, (copy) v_u_19, (ref) v_u_11
	local v176 = v_u_5.Character
	if v176 then
		v176.ChildRemoved:Connect(function(p177)
			-- upvalues: (ref) v_u_26, (ref) v_u_27, (ref) v_u_19, (ref) v_u_11
			if p177:IsA("Tool") and v_u_26 then
				local v178 = v_u_26.PowerName
				if p177.Name == v178 or p177.Name:find(v178) then
					if not v_u_26 then
						return
					end
					if v_u_27 then
						v_u_27:Disconnect()
						v_u_27 = nil
					end
					v_u_19:FireServer("HoldReleaseCancel", {})
					v_u_26 = nil
					v_u_11 = false
				end
			end
		end)
	end
end
v_u_5.CharacterAdded:Connect(v179)
local v180 = v_u_5.Character and v_u_5.Character
if v180 then
	v180.ChildRemoved:Connect(function(p181)
		-- upvalues: (ref) v_u_26, (ref) v_u_27, (copy) v_u_19, (ref) v_u_11
		if p181:IsA("Tool") and v_u_26 then
			local v182 = v_u_26.PowerName
			if p181.Name == v182 or p181.Name:find(v182) then
				if not v_u_26 then
					return
				end
				if v_u_27 then
					v_u_27:Disconnect()
					v_u_27 = nil
				end
				v_u_19:FireServer("HoldReleaseCancel", {})
				v_u_26 = nil
				v_u_11 = false
			end
		end
	end)
end