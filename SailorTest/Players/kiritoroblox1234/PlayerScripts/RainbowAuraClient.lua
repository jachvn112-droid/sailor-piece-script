local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v_u_3 = {}
local function v_u_8(p4)
	local v5 = {}
	for _, v6 in p4:GetDescendants() do
		if (v6:IsA("ParticleEmitter") or v6:IsA("Beam")) and not v6:GetAttribute("$NOT_RECOLORED") then
			local v7 = not v6:GetAttribute("AuraVFX") and v6.Parent
			if v7 then
				v7 = v6.Parent:GetAttribute("AuraVFX")
			end
			if v7 then
				table.insert(v5, v6)
			end
		end
	end
	return v5
end
local function v_u_11(p_u_9)
	-- upvalues: (copy) v_u_3, (copy) v_u_8
	if p_u_9:GetAttribute("RainbowAura") and p_u_9:GetAttribute("RainbowAura") then
		v_u_3[p_u_9] = v_u_8(p_u_9)
	end
	p_u_9:GetAttributeChangedSignal("RainbowAura"):Connect(function()
		-- upvalues: (copy) p_u_9, (ref) v_u_3, (ref) v_u_8
		if p_u_9:GetAttribute("RainbowAura") then
			local v10 = p_u_9
			if v10:GetAttribute("RainbowAura") then
				v_u_3[v10] = v_u_8(v10)
			end
		else
			v_u_3[p_u_9] = nil
			return
		end
	end)
end
local function v15(p12)
	-- upvalues: (copy) v_u_11, (copy) v_u_3
	if p12.Character then
		v_u_11(p12.Character)
	end
	p12.CharacterAdded:Connect(function(p13)
		-- upvalues: (ref) v_u_11
		task.wait(2)
		v_u_11(p13)
	end)
	p12.CharacterRemoving:Connect(function(p14)
		-- upvalues: (ref) v_u_3
		v_u_3[p14] = nil
	end)
end
local v_u_16 = 0
for _, v17 in v1:GetPlayers() do
	task.spawn(v15, v17)
end
v1.PlayerAdded:Connect(v15)
v1.PlayerRemoving:Connect(function(p18)
	-- upvalues: (copy) v_u_3
	if p18.Character then
		v_u_3[p18.Character] = nil
	end
end)
v2.RenderStepped:Connect(function()
	-- upvalues: (ref) v_u_16, (copy) v_u_3, (copy) v_u_8
	local v19 = tick()
	local v20 = v19 - v_u_16 >= 1
	for v21, v23 in pairs(v_u_3) do
		if v21.Parent then
			if v20 then
				v_u_3[v21] = v_u_8(v21)
				local v23 = v_u_3[v21]
			end
			if #v23 ~= 0 then
				local v24 = v19 / 0.5 % 1
				local v25 = Color3.fromHSV(v24, 0.8, 1)
				local v26 = ColorSequence.new(v25)
				for _, v27 in v23 do
					if v27 and v27.Parent then
						v27.Color = v26
					end
				end
			end
		else
			v_u_3[v21] = nil
		end
	end
	if v20 then
		v_u_16 = v19
	end
end)