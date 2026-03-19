local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Debris")
local v_u_4 = v1.LocalPlayer
local v_u_5 = {
	["Burn"] = v2:WaitForChild("VFXAssets"):WaitForChild("RuneVFX"):FindFirstChild("BurnVFXModel"),
	["Freeze"] = v2:WaitForChild("VFXAssets"):WaitForChild("RuneVFX"):FindFirstChild("FreezeVFXAndIceCubeModel"),
	["Bleed"] = v2:WaitForChild("VFXAssets"):WaitForChild("RuneVFX"):FindFirstChild("BleedVFXModel")
}
local v_u_6 = {}
local function v_u_12(p7)
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	if p7 and v_u_5.Burn then
		v_u_6[p7] = v_u_6[p7] or {}
		if not v_u_6[p7].burn then
			for _, v8 in pairs(p7:GetChildren()) do
				if v8:IsA("BasePart") and v8.Name ~= "HumanoidRootPart" then
					local v9 = v_u_5.Burn:FindFirstChild(v8.Name)
					if v9 then
						for _, v10 in pairs(v9:GetDescendants()) do
							if v10:IsA("ParticleEmitter") then
								local v11 = v10:Clone()
								v11.Name = "BurnEffect"
								v11.Enabled = true
								v11.Parent = v8
							end
						end
					end
				end
			end
			v_u_6[p7].burn = true
		end
	else
		return
	end
end
local function v_u_15(p13)
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	if p13 then
		for _, v14 in pairs(p13:GetDescendants()) do
			if v14:IsA("ParticleEmitter") and v14.Name == "BurnEffect" then
				v14.Enabled = false
				v_u_3:AddItem(v14, v14.Lifetime.Max)
			end
		end
		if v_u_6[p13] then
			v_u_6[p13].burn = nil
		end
	end
end
local function v_u_21(p16)
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	if p16 and v_u_5.Bleed then
		v_u_6[p16] = v_u_6[p16] or {}
		if not v_u_6[p16].bleed then
			for _, v17 in pairs(p16:GetChildren()) do
				if v17:IsA("BasePart") and v17.Name ~= "HumanoidRootPart" then
					local v18 = v_u_5.Bleed:FindFirstChild(v17.Name)
					if v18 then
						for _, v19 in pairs(v18:GetDescendants()) do
							if v19:IsA("ParticleEmitter") then
								local v20 = v19:Clone()
								v20.Name = "BleedEffect"
								v20.Enabled = true
								v20.Parent = v17
							end
						end
					end
				end
			end
			v_u_6[p16].bleed = true
		end
	else
		return
	end
end
local function v_u_24(p22)
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	if p22 then
		for _, v23 in pairs(p22:GetDescendants()) do
			if v23:IsA("ParticleEmitter") and v23.Name == "BleedEffect" then
				v23.Enabled = false
				v_u_3:AddItem(v23, v23.Lifetime.Max)
			end
		end
		if v_u_6[p22] then
			v_u_6[p22].bleed = nil
		end
	end
end
local function v_u_38(p_u_25, p26)
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	if p_u_25 then
		local v27 = p_u_25:FindFirstChild("FreezeIceCube_Active")
		if v27 then
			v27:Destroy()
		end
		if v_u_6[p_u_25] then
			v_u_6[p_u_25].freeze = nil
		end
		v_u_6[p_u_25] = v_u_6[p_u_25] or {}
		local v28 = v_u_5.Freeze
		if v28 then
			local v29 = v28:FindFirstChild("IceCubeModel")
			if v29 then
				local v30 = p_u_25:FindFirstChild("HumanoidRootPart")
				if v30 then
					local v_u_31 = v29:Clone()
					v_u_31.Name = "FreezeIceCube_Active"
					v_u_31.Anchored = false
					v_u_31.CanCollide = false
					v_u_31.Transparency = 0.3
					v_u_31.Parent = p_u_25
					v_u_31.CFrame = v30.CFrame
					local v32 = Instance.new("WeldConstraint")
					v32.Part0 = v30
					v32.Part1 = v_u_31
					v32.Parent = v_u_31
					local v33 = v_u_31:FindFirstChild("Icefx")
					if v33 then
						for _, v34 in ipairs(v33:GetChildren()) do
							if v34:IsA("BasePart") then
								v34.Anchored = false
								v34.CanCollide = false
								v34.Transparency = 1
								v34.CFrame = v_u_31.CFrame
								local v35 = Instance.new("WeldConstraint")
								v35.Part0 = v_u_31
								v35.Part1 = v34
								v35.Parent = v34
								for _, v36 in ipairs(v34:GetChildren()) do
									if v36:IsA("ParticleEmitter") then
										v36.Enabled = true
									elseif v36:IsA("PointLight") then
										v36.Enabled = true
									end
								end
							end
						end
					end
					v_u_6[p_u_25].freeze = v_u_31
					task.delay(p26 or 2, function()
						-- upvalues: (copy) v_u_31, (ref) v_u_6, (copy) p_u_25
						if v_u_31 and v_u_31.Parent then
							for _, v37 in ipairs(v_u_31:GetDescendants()) do
								if v37:IsA("ParticleEmitter") then
									v37.Enabled = false
								end
							end
							task.wait(0.5)
							if v_u_31 and v_u_31.Parent then
								v_u_31:Destroy()
							end
						end
						if v_u_6[p_u_25] then
							v_u_6[p_u_25].freeze = nil
						end
					end)
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
local function v_u_42(p39)
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	if p39 then
		local v40 = p39:FindFirstChild("FreezeIceCube_Active")
		if v40 then
			v40:Destroy()
		end
		for _, v41 in pairs(p39:GetDescendants()) do
			if v41:IsA("ParticleEmitter") and v41.Name == "FreezeEffect" then
				v41.Enabled = false
				v_u_3:AddItem(v41, 0.5)
			end
		end
		if v_u_6[p39] then
			v_u_6[p39].freeze = nil
		end
	end
end
v2:WaitForChild("Remotes"):WaitForChild("RuneEffectVFX").OnClientEvent:Connect(function(p43, p44, p45, p46)
	-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_15, (copy) v_u_21, (copy) v_u_24, (copy) v_u_38, (copy) v_u_42
	if p45 and p45.Parent then
		if _G.GetPlayerData then
			local v47 = _G.GetPlayerData(v_u_4)
			if v47 and (v47.Settings and v47.Settings.DisableVFX) then
				return
			end
		end
		if p43 == "Burn" then
			if p44 == "Start" then
				v_u_12(p45)
			else
				v_u_15(p45)
			end
		elseif p43 == "Bleed" then
			if p44 == "Start" then
				v_u_21(p45)
			else
				v_u_24(p45)
			end
		else
			if p43 == "Freeze" then
				if p44 == "Start" then
					v_u_38(p45, p46)
					return
				end
				v_u_42(p45)
			end
			return
		end
	else
		return
	end
end)
workspace.DescendantRemoving:Connect(function(p48)
	-- upvalues: (copy) v_u_6
	if v_u_6[p48] then
		v_u_6[p48] = nil
	end
end)