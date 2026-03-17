local v_u_1 = game:GetService("VRService")
local v_u_2 = {
	"BasePart",
	"Decal",
	"Beam",
	"ParticleEmitter",
	"Trail",
	"Fire",
	"Smoke",
	"Sparkles",
	"Explosion"
}
local v_u_3 = require(script.Parent:WaitForChild("CameraUtils"))
local v4, v5 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserHideCharacterParticlesInFirstPerson")
end)
local v_u_6 = v4 and v5
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7.new()
	-- upvalues: (copy) v_u_7
	local v8 = v_u_7
	local v9 = setmetatable({}, v8)
	v9.transparencyDirty = false
	v9.enabled = false
	v9.lastTransparency = nil
	v9.descendantAddedConn = nil
	v9.descendantRemovingConn = nil
	v9.toolDescendantAddedConns = {}
	v9.toolDescendantRemovingConns = {}
	v9.cachedParts = {}
	return v9
end
function v_u_7.HasToolAncestor(p10, p11)
	if p11.Parent == nil then
		return false
	end
	local v12 = p11.Parent
	assert(v12, "")
	return p11.Parent:IsA("Tool") or p10:HasToolAncestor(p11.Parent)
end
function v_u_7.IsValidPartToModify(p13, p14)
	-- upvalues: (ref) v_u_6, (copy) v_u_2
	if v_u_6 then
		for _, v15 in v_u_2 do
			if p14:IsA(v15) then
				return not p13:HasToolAncestor(p14)
			end
		end
	elseif p14:IsA("BasePart") or p14:IsA("Decal") then
		return not p13:HasToolAncestor(p14)
	end
	return false
end
function v_u_7.CachePartsRecursive(p16, p17)
	if p17 then
		if p16:IsValidPartToModify(p17) then
			p16.cachedParts[p17] = true
			p16.transparencyDirty = true
		end
		for _, v18 in pairs(p17:GetChildren()) do
			p16:CachePartsRecursive(v18)
		end
	end
end
function v_u_7.TeardownTransparency(p19)
	for v20, _ in pairs(p19.cachedParts) do
		v20.LocalTransparencyModifier = 0
	end
	p19.cachedParts = {}
	p19.transparencyDirty = true
	p19.lastTransparency = nil
	if p19.descendantAddedConn then
		p19.descendantAddedConn:disconnect()
		p19.descendantAddedConn = nil
	end
	if p19.descendantRemovingConn then
		p19.descendantRemovingConn:disconnect()
		p19.descendantRemovingConn = nil
	end
	for v21, v22 in pairs(p19.toolDescendantAddedConns) do
		v22:Disconnect()
		p19.toolDescendantAddedConns[v21] = nil
	end
	for v23, v24 in pairs(p19.toolDescendantRemovingConns) do
		v24:Disconnect()
		p19.toolDescendantRemovingConns[v23] = nil
	end
end
function v_u_7.SetupTransparency(p_u_25, p_u_26)
	p_u_25:TeardownTransparency()
	if p_u_25.descendantAddedConn then
		p_u_25.descendantAddedConn:disconnect()
	end
	p_u_25.descendantAddedConn = p_u_26.DescendantAdded:Connect(function(p27)
		-- upvalues: (copy) p_u_25, (copy) p_u_26
		if p_u_25:IsValidPartToModify(p27) then
			p_u_25.cachedParts[p27] = true
			p_u_25.transparencyDirty = true
		elseif p27:IsA("Tool") then
			if p_u_25.toolDescendantAddedConns[p27] then
				p_u_25.toolDescendantAddedConns[p27]:Disconnect()
			end
			p_u_25.toolDescendantAddedConns[p27] = p27.DescendantAdded:Connect(function(p28)
				-- upvalues: (ref) p_u_25
				p_u_25.cachedParts[p28] = nil
				if p28:IsA("BasePart") or p28:IsA("Decal") then
					p28.LocalTransparencyModifier = 0
				end
			end)
			if p_u_25.toolDescendantRemovingConns[p27] then
				p_u_25.toolDescendantRemovingConns[p27]:disconnect()
			end
			p_u_25.toolDescendantRemovingConns[p27] = p27.DescendantRemoving:Connect(function(p29)
				-- upvalues: (ref) p_u_26, (ref) p_u_25
				wait()
				if p_u_26 and (p29 and (p29:IsDescendantOf(p_u_26) and p_u_25:IsValidPartToModify(p29))) then
					p_u_25.cachedParts[p29] = true
					p_u_25.transparencyDirty = true
				end
			end)
		end
	end)
	if p_u_25.descendantRemovingConn then
		p_u_25.descendantRemovingConn:disconnect()
	end
	p_u_25.descendantRemovingConn = p_u_26.DescendantRemoving:connect(function(p30)
		-- upvalues: (copy) p_u_25
		if p_u_25.cachedParts[p30] then
			p_u_25.cachedParts[p30] = nil
			p30.LocalTransparencyModifier = 0
		end
	end)
	p_u_25:CachePartsRecursive(p_u_26)
end
function v_u_7.Enable(p31, p32)
	if p31.enabled ~= p32 then
		p31.enabled = p32
	end
end
function v_u_7.SetSubject(p33, p34)
	local v35
	if p34 and p34:IsA("Humanoid") then
		v35 = p34.Parent
	else
		v35 = nil
	end
	if p34 and (p34:IsA("VehicleSeat") and p34.Occupant) then
		v35 = p34.Occupant.Parent
	end
	if v35 then
		p33:SetupTransparency(v35)
	else
		p33:TeardownTransparency()
	end
end
function v_u_7.Update(p36, p37)
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	local v38 = workspace.CurrentCamera
	if v38 and p36.enabled then
		local v39 = (v38.Focus.p - v38.CoordinateFrame.p).magnitude
		local v40 = v39 < 2 and 1 - (v39 - 0.5) / 1.5 or 0
		local v41 = v40 < 0.5 and 0 or v40
		if p36.lastTransparency and (v41 < 1 and p36.lastTransparency < 0.95) then
			local v42 = v41 - p36.lastTransparency
			local v43 = 2.8 * p37
			local v44 = -v43
			local v45 = math.clamp(v42, v44, v43)
			v41 = p36.lastTransparency + v45
		else
			p36.transparencyDirty = true
		end
		local v46 = v_u_3.Round(v41, 2)
		local v47 = math.clamp(v46, 0, 1)
		if p36.transparencyDirty or p36.lastTransparency ~= v47 then
			for v48, _ in pairs(p36.cachedParts) do
				if v_u_1.VREnabled and v_u_1.AvatarGestures then
					local v49 = {
						[Enum.AccessoryType.Hat] = true,
						[Enum.AccessoryType.Hair] = true,
						[Enum.AccessoryType.Face] = true,
						[Enum.AccessoryType.Eyebrow] = true,
						[Enum.AccessoryType.Eyelash] = true
					}
					if v48.Parent:IsA("Accessory") and v49[v48.Parent.AccessoryType] or v48.Name == "Head" then
						v48.LocalTransparencyModifier = v47
					else
						v48.LocalTransparencyModifier = 0
					end
				else
					v48.LocalTransparencyModifier = v47
				end
			end
			p36.transparencyDirty = false
			p36.lastTransparency = v47
		end
	end
end
return v_u_7