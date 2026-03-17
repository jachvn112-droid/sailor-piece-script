local v1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = nil
local v_u_4 = {}
local function v_u_9()
	-- upvalues: (ref) v_u_3, (copy) v_u_2
	if v_u_3 then
		return v_u_3
	end
	local v5 = v_u_2:FindFirstChild("AbilitySystem")
	if not v5 then
		return nil
	end
	local v6 = v5:FindFirstChild("VFX")
	if not v6 then
		return nil
	end
	local v7 = v6:FindFirstChild("GojoV2")
	if not v7 then
		return nil
	end
	local v8 = v7:FindFirstChild("HandsAura")
	if not v8 then
		return nil
	end
	v_u_3 = v8:FindFirstChild("GojoV2HandVFX")
	return v_u_3
end
local function v_u_16(p10, p11)
	if p10 and p11 then
		for _, v12 in p11:GetChildren() do
			if v12:IsA("Attachment") then
				local v13 = v12:Clone()
				v13:SetAttribute("GojoV2HandAura", true)
				v13.Parent = p10
				for _, v14 in v13:GetDescendants() do
					if v14:IsA("ParticleEmitter") then
						v14.Enabled = true
					end
				end
			elseif v12:IsA("ParticleEmitter") or (v12:IsA("Trail") or v12:IsA("Beam")) then
				local v15 = v12:Clone()
				v15:SetAttribute("GojoV2HandAura", true)
				v15.Parent = p10
				if v15:IsA("ParticleEmitter") then
					v15.Enabled = true
				end
			end
		end
	end
end
local function v_u_23(p17)
	-- upvalues: (copy) v_u_9, (copy) v_u_16
	local v18 = v_u_9()
	if v18 then
		local v19 = v18:FindFirstChild("Left Arm")
		local v20 = v18:FindFirstChild("Right Arm")
		local v21 = p17:FindFirstChild("Left Arm") or p17:FindFirstChild("LeftHand")
		local v22 = p17:FindFirstChild("Right Arm") or p17:FindFirstChild("RightHand")
		v_u_16(v21, v19)
		v_u_16(v22, v20)
	end
end
local function v_u_28(p24)
	if p24 then
		for _, v25 in {
			"Left Arm",
			"Right Arm",
			"LeftHand",
			"RightHand"
		} do
			local v26 = p24:FindFirstChild(v25)
			if v26 then
				for _, v27 in v26:GetChildren() do
					if v27:GetAttribute("GojoV2HandAura") then
						v27:Destroy()
					end
				end
			end
		end
	end
end
local function v_u_41(p29, p_u_30)
	-- upvalues: (copy) v_u_28, (copy) v_u_4, (copy) v_u_23
	v_u_28(p_u_30)
	if not v_u_4[p29] then
		v_u_4[p29] = {}
	end
	local v33 = p_u_30.ChildAdded:Connect(function(p31)
		-- upvalues: (copy) p_u_30, (ref) v_u_23
		local v32 = p_u_30
		if p31:IsA("Tool") and p31.Name == "Strongest Of Today" then
			v_u_23(v32)
		end
	end)
	local v34 = v_u_4[p29]
	table.insert(v34, v33)
	local v37 = p_u_30.ChildRemoved:Connect(function(p35)
		-- upvalues: (copy) p_u_30, (ref) v_u_28
		local v36 = p_u_30
		if p35:IsA("Tool") and p35.Name == "Strongest Of Today" then
			v_u_28(v36)
		end
	end)
	local v38 = v_u_4[p29]
	table.insert(v38, v37)
	local v39 = p_u_30:FindFirstChildOfClass("Tool")
	local v40
	if v39 == nil then
		v40 = false
	else
		v40 = v39.Name == "Strongest Of Today"
	end
	if v40 then
		task.wait(0.1)
		v_u_23(p_u_30)
	end
end
local function v46(p_u_42)
	-- upvalues: (copy) v_u_4, (copy) v_u_41
	v_u_4[p_u_42] = {}
	if p_u_42.Character then
		v_u_41(p_u_42, p_u_42.Character)
	end
	local v44 = p_u_42.CharacterAdded:Connect(function(p43)
		-- upvalues: (ref) v_u_41, (copy) p_u_42
		v_u_41(p_u_42, p43)
	end)
	local v45 = v_u_4[p_u_42]
	table.insert(v45, v44)
end
local function v50(p47)
	-- upvalues: (copy) v_u_4, (copy) v_u_28
	local v48 = v_u_4[p47]
	if v48 then
		for _, v49 in v48 do
			v49:Disconnect()
		end
		v_u_4[p47] = nil
	end
	if p47.Character then
		v_u_28(p47.Character)
	end
end
for _, v51 in v1:GetPlayers() do
	v46(v51)
end
v1.PlayerAdded:Connect(v46)
v1.PlayerRemoving:Connect(v50)