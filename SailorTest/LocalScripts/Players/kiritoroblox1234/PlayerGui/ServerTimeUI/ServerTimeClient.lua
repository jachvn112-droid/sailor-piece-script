local v1 = game:GetService("ReplicatedStorage")
local v2 = script.Parent:WaitForChild("ServerInfo"):WaitForChild("AutoSizeHolder")
local v3 = v2:WaitForChild("ServerTime")
local v_u_4 = {
	["EXP"] = v2:WaitForChild("x2EXP"),
	["Coins"] = v2:WaitForChild("x2Coins"),
	["Gems"] = v2:WaitForChild("x2Gems"),
	["Luck"] = v2:WaitForChild("x2Luck")
}
local v_u_5 = v2:WaitForChild("Sep_EXP_Coins")
local v_u_6 = v2:WaitForChild("Sep_Coins_Gems")
local v_u_7 = v2:WaitForChild("Sep_Gems_Luck")
local v_u_8 = v2:WaitForChild("EventLabel")
local v_u_9 = v2:WaitForChild("Separator")
local v10 = v1:WaitForChild("GetServerStartTime"):InvokeServer()
local v_u_11 = {}
local v_u_12 = {
	["EXP"] = "EXP",
	["Coins"] = "COINS",
	["Gems"] = "GEMS",
	["Luck"] = "LUCK"
}
local function v_u_23()
	-- upvalues: (copy) v_u_11, (copy) v_u_4, (copy) v_u_12, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9
	local v13 = {}
	for _, v14 in ipairs({
		"EXP",
		"Coins",
		"Gems",
		"Luck"
	}) do
		local v15 = v_u_11["x3" .. v14] == true
		local v16 = v15 or v_u_11["x2" .. v14] == true
		v13[v14] = v16
		local v17 = v_u_4[v14]
		v17.Visible = v16
		if v16 then
			v17.Text = (v15 and "3" or "2") .. "x " .. v_u_12[v14]
		end
	end
	local v18 = v13.EXP or v13.Coins or (v13.Gems or v13.Luck)
	v_u_5.Visible = not v13.EXP or v13.Coins or (v13.Gems or v13.Luck)
	local v19 = v_u_6
	local v20 = v13.Coins
	if v20 then
		v20 = v13.Gems or v13.Luck
	end
	v19.Visible = v20
	local v21 = v_u_7
	local v22 = v13.Gems
	if v22 then
		v22 = v13.Luck
	end
	v21.Visible = v22
	v_u_8.Visible = v18
	v_u_9.Visible = v18
end
local v24 = v1:WaitForChild("Remotes"):WaitForChild("EventRemotes")
local v25 = v24:WaitForChild("SyncEvents")
local v_u_26 = v24:WaitForChild("GetEvents")
v25.OnClientEvent:Connect(function(p27)
	-- upvalues: (copy) v_u_11, (copy) v_u_23
	if p27 then
		for v28, v29 in pairs(p27) do
			v_u_11[v28] = v29
		end
		v_u_23()
	end
end)
task.spawn(function()
	-- upvalues: (copy) v_u_26, (copy) v_u_11, (copy) v_u_23
	local v30 = v_u_26:InvokeServer()
	if v30 then
		for v31, v32 in pairs(v30) do
			v_u_11[v31] = v32
		end
		v_u_23()
	end
end)
while true do
	local v33 = os.time() - v10
	local v34 = v33 / 3600
	local v35 = math.floor(v34)
	local v36 = v33 % 3600 / 60
	local v37 = math.floor(v36)
	local v38 = v33 % 60
	v3.Text = string.format("Server Time (%02d:%02d:%02d)", v35, v37, v38)
	task.wait(1)
end