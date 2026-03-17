local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v_u_1.LocalPlayer
local v_u_4 = v2:WaitForChild("IconAssets"):WaitForChild("AllyOverheadTemplate")
local v5 = v2:WaitForChild("RemoteEvents"):WaitForChild("AllyStateRemote")
local v_u_6 = {
	Color3.fromRGB(255, 85, 85),
	Color3.fromRGB(85, 170, 255),
	Color3.fromRGB(85, 255, 127),
	Color3.fromRGB(255, 255, 85),
	Color3.fromRGB(255, 170, 85),
	Color3.fromRGB(255, 85, 255),
	Color3.fromRGB(170, 85, 255),
	Color3.fromRGB(85, 255, 255)
}
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = {}
local function v_u_17(p10)
	-- upvalues: (copy) v_u_3, (ref) v_u_7, (copy) v_u_4, (ref) v_u_9, (copy) v_u_6
	if p10 == v_u_3 then
		return
	elseif v_u_7[p10.UserId] then
		return
	else
		local v11 = p10.Character
		if v11 then
			local v12 = v11:FindFirstChild("Head")
			if v12 then
				local v13 = v_u_4:Clone()
				v13.Name = "AllyOverhead_" .. p10.UserId
				v13.Adornee = v12
				v13.StudsOffset = Vector3.new(0, 4.1, 0)
				v13.Enabled = true
				local v14 = p10.UserId
				if not v_u_9[v14] then
					v_u_9[v14] = v_u_6[math.random(1, #v_u_6)]
				end
				local v15 = v_u_9[v14]
				local v16 = v13:FindFirstChild("AllyIcon")
				if v16 then
					v16.ImageColor3 = v15
				end
				v13.Parent = v11
				v_u_7[p10.UserId] = v13
			end
		else
			return
		end
	end
end
local function v_u_19()
	-- upvalues: (ref) v_u_7, (ref) v_u_8, (ref) v_u_9
	for _, v18 in pairs(v_u_7) do
		if v18 then
			v18:Destroy()
		end
	end
	v_u_7 = {}
	v_u_8 = {}
	v_u_9 = {}
end
local function v_u_27(p20)
	-- upvalues: (copy) v_u_19, (copy) v_u_3, (ref) v_u_8, (ref) v_u_7, (ref) v_u_9, (copy) v_u_1, (copy) v_u_17
	if p20 and p20.members then
		local v21 = {}
		for _, v22 in ipairs(p20.members) do
			if v22.UserId ~= v_u_3.UserId then
				v21[v22.UserId] = true
			end
		end
		for v23 in pairs(v_u_8) do
			if not v21[v23] then
				local v24 = v_u_7[v23]
				if v24 then
					v24:Destroy()
					v_u_7[v23] = nil
				end
				v_u_9[v23] = nil
			end
		end
		for v25 in pairs(v21) do
			if not v_u_7[v25] then
				local v26 = v_u_1:GetPlayerByUserId(v25)
				if v26 then
					v_u_17(v26)
				end
			end
		end
		v_u_8 = v21
	else
		v_u_19()
	end
end
local v_u_28 = v_u_9
local v_u_29 = v_u_7
local v_u_30 = v_u_8
for _, v_u_31 in ipairs(v_u_1:GetPlayers()) do
	v_u_31.CharacterAdded:Connect(function()
		-- upvalues: (copy) v_u_31, (ref) v_u_30, (ref) v_u_29, (copy) v_u_17
		local v_u_32 = v_u_31
		if v_u_30[v_u_32.UserId] then
			v_u_29[v_u_32.UserId] = nil
			task.defer(function()
				-- upvalues: (ref) v_u_30, (copy) v_u_32, (ref) v_u_17
				task.wait(0.5)
				if v_u_30[v_u_32.UserId] then
					v_u_17(v_u_32)
				end
			end)
		end
	end)
end
v_u_1.PlayerAdded:Connect(function(p_u_33)
	-- upvalues: (ref) v_u_30, (ref) v_u_29, (copy) v_u_17
	p_u_33.CharacterAdded:Connect(function()
		-- upvalues: (copy) p_u_33, (ref) v_u_30, (ref) v_u_29, (ref) v_u_17
		local v_u_34 = p_u_33
		if v_u_30[v_u_34.UserId] then
			v_u_29[v_u_34.UserId] = nil
			task.defer(function()
				-- upvalues: (ref) v_u_30, (copy) v_u_34, (ref) v_u_17
				task.wait(0.5)
				if v_u_30[v_u_34.UserId] then
					v_u_17(v_u_34)
				end
			end)
		end
	end)
end)
v_u_1.PlayerRemoving:Connect(function(p35)
	-- upvalues: (ref) v_u_29, (ref) v_u_30, (ref) v_u_28
	local v36 = p35.UserId
	local v37 = v_u_29[v36]
	if v37 then
		v37:Destroy()
		v_u_29[v36] = nil
	end
	v_u_30[p35.UserId] = nil
	v_u_28[p35.UserId] = nil
end)
v5.OnClientEvent:Connect(function(p38, p39)
	-- upvalues: (copy) v_u_27, (copy) v_u_19
	if p38 == "PartyCreated" or (p38 == "PartyUpdate" or p38 == "JoinedParty") then
		v_u_27(p39)
	elseif p38 == "LeftParty" or (p38 == "Kicked" or p38 == "PartyDisbanded") then
		v_u_19()
	end
end)