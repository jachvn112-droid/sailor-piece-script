local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1.LocalPlayer
local v4 = v2:WaitForChild("AbilitySystem")
local v_u_5 = require(v4:WaitForChild("AbilityConfig"))
local v6 = v4:WaitForChild("Remotes")
local v_u_7 = v6:WaitForChild("RequestAbility")
local v8 = v6:WaitForChild("AbilityFeedback")
local v9 = v6:WaitForChild("AbilityStateChanged", 5)
local v10 = v2:WaitForChild("FruitPowerSystem")
local v_u_11 = require(v10:WaitForChild("FruitPowerConfig"))
local v12 = v2:WaitForChild("RemoteEvents")
local v_u_13 = v12:WaitForChild("FruitPowerRemote")
local v14 = v12:WaitForChild("FruitPowerResponse")
local v_u_15 = {
	Enum.KeyCode.Z,
	Enum.KeyCode.X,
	Enum.KeyCode.C,
	Enum.KeyCode.V,
	Enum.KeyCode.F
}
local v_u_16 = {
	["HoldVariant"] = true
}
local v_u_17 = {
	["Toggle"] = true,
	["HoldRelease"] = true
}
local v_u_18 = 0
local v_u_19 = false
local v_u_20 = false
local v_u_21 = {}
local v_u_22 = {}
local function v23()
	-- upvalues: (ref) v_u_19, (ref) v_u_20, (ref) v_u_21, (ref) v_u_22
	v_u_19 = false
	v_u_20 = false
	v_u_21 = {}
	v_u_22 = {}
	task.delay(1.5, function()
		-- upvalues: (ref) v_u_20
		v_u_20 = true
	end)
end
v_u_3.CharacterAdded:Connect(v23)
if v_u_3.Character then
	task.spawn(v23)
end
v_u_3:GetAttributeChangedSignal("AutoSkillSlot"):Connect(function()
	-- upvalues: (ref) v_u_18, (copy) v_u_3
	v_u_18 = v_u_3:GetAttribute("AutoSkillSlot") or 0
end)
task.spawn(function()
	-- upvalues: (copy) v_u_3, (ref) v_u_18
	for _ = 1, 50 do
		local v24 = v_u_3:GetAttribute("AutoSkillSlot")
		if v24 and v24 ~= 0 then
			v_u_18 = v24
			return
		end
		task.wait(0.2)
	end
	v_u_18 = v_u_3:GetAttribute("AutoSkillSlot") or 0
end)
if v9 then
	v9.OnClientEvent:Connect(function(p25)
		-- upvalues: (ref) v_u_19
		v_u_19 = p25 == true
	end)
end
v8.OnClientEvent:Connect(function(p26)
	-- upvalues: (copy) v_u_3, (ref) v_u_21
	if p26.Caster == v_u_3 then
		if p26.AbilitySlot and (p26.Cooldown and p26.MovesetName) then
			v_u_21[p26.MovesetName .. "_" .. p26.AbilitySlot] = tick() + p26.Cooldown
		end
	else
		return
	end
end)
v14.OnClientEvent:Connect(function(p27, p28)
	-- upvalues: (ref) v_u_22
	if p27 == "CooldownStarted" and (p28 and (p28.Ability and p28.Duration)) then
		v_u_22[p28.Ability] = tick() + p28.Duration
	end
end)
local function v_u_31()
	-- upvalues: (copy) v_u_3
	local v29 = v_u_3:GetMouse()
	local v30 = workspace:Raycast(v29.UnitRay.Origin, v29.UnitRay.Direction * 500, RaycastParams.new())
	return v30 and v30.Position or v29.UnitRay.Origin + v29.UnitRay.Direction * 500
end
local function v_u_42(p32)
	-- upvalues: (copy) v_u_3, (copy) v_u_15, (copy) v_u_5, (copy) v_u_16, (copy) v_u_11, (copy) v_u_17
	local v33 = v_u_3.Character
	if not v33 then
		return nil
	end
	local v34 = v_u_15[p32]
	if not v34 then
		return nil
	end
	local v35 = v33:FindFirstChildOfClass("Tool")
	if v35 then
		for v36, v37 in pairs(v_u_5.Movesets) do
			if v37.ToolName == v35.Name then
				local v38 = v37.Abilities
				if v38 then
					v38 = v37.Abilities[p32]
				end
				if v38 then
					if v_u_16[v38.Type] then
						return nil
					else
						return "weapon", v36, p32
					end
				end
			end
		end
		for v39, v40 in pairs(v_u_11.Powers) do
			if v40.ToolName == v35.Name then
				local v41 = v_u_11.GetAbilityByKey(v39, v34)
				if v41 then
					if v_u_17[v41.Type] then
						return nil
					else
						return "fruit", v39, v34
					end
				end
			end
		end
	end
	return nil
end
task.spawn(function()
	-- upvalues: (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (copy) v_u_3, (copy) v_u_42, (ref) v_u_21, (copy) v_u_7, (copy) v_u_11, (ref) v_u_22, (copy) v_u_13, (copy) v_u_31
	while true do
		repeat
			task.wait(0.4)
		until v_u_18 ~= 0 and (not v_u_19 and v_u_20)
		local v43 = v_u_3.Character
		local v44 = v43 and v43:FindFirstChildOfClass("Humanoid")
		if v44 then
			v44 = v44.Health > 0
		end
		if v44 then
			local v45, v46, v47 = v_u_42(v_u_18)
			if v45 then
				if v45 == "weapon" then
					local v48 = v_u_21[v46 .. "_" .. v47]
					if not v48 or tick() >= v48 + 0.3 then
						v_u_7:FireServer(v47)
					end
				else
					local v49 = v45 == "fruit" and v_u_11.GetAbilityByKey(v46, v47)
					if v49 then
						local v50 = v_u_22[v49.Name]
						if not v50 or tick() >= v50 + 0.3 then
							v_u_13:FireServer("UseAbility", {
								["FruitPower"] = v46,
								["KeyCode"] = v47,
								["TargetPosition"] = v_u_31()
							})
						end
					end
				end
			end
		end
	end
end)