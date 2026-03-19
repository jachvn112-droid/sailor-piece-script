local v1 = game:GetService("ReplicatedStorage")
local v2 = script.Parent:WaitForChild("ServerInfo"):WaitForChild("AutoSizeHolder")
local v3 = v2:WaitForChild("ServerTime")
local v_u_4 = v2:WaitForChild("x2EXP")
local v_u_5 = v2:WaitForChild("x2Coins")
local v_u_6 = v2:WaitForChild("x2Gems")
local v_u_7 = v2:WaitForChild("x2Luck")
local v_u_8 = v2:WaitForChild("Sep_EXP_Coins")
local v_u_9 = v2:WaitForChild("Sep_Coins_Gems")
local v_u_10 = v2:WaitForChild("Sep_Gems_Luck")
local v_u_11 = v2:WaitForChild("EventLabel")
local v_u_12 = v2:WaitForChild("Separator")
local v13 = v1:WaitForChild("GetServerStartTime"):InvokeServer()
local v_u_14 = {
	["x2EXP"] = false,
	["x2Coins"] = false,
	["x2Gems"] = false,
	["x2Luck"] = false
}
local v15 = v1:WaitForChild("Remotes"):WaitForChild("EventRemotes")
local v16 = v15:WaitForChild("SyncEvents")
local v_u_17 = v15:WaitForChild("GetEvents")
v16.OnClientEvent:Connect(function(p18)
	-- upvalues: (copy) v_u_14, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12
	if p18 then
		for v19, v20 in pairs(p18) do
			v_u_14[v19] = v20
		end
		local v21 = v_u_14.x2EXP == true
		local v22 = v_u_14.x2Coins == true
		local v23 = v_u_14.x2Gems == true
		local v24 = v_u_14.x2Luck == true
		local v25 = v21 or (v22 or (v23 or v24))
		v_u_4.Visible = v21
		v_u_5.Visible = v22
		v_u_6.Visible = v23
		v_u_7.Visible = v24
		local v26 = v_u_8
		if v21 then
			v21 = v22 or (v23 or v24)
		end
		v26.Visible = v21
		local v27 = v_u_9
		if v22 then
			v22 = v23 or v24
		end
		v27.Visible = v22
		v_u_10.Visible = v23 and v24
		v_u_11.Visible = v25
		v_u_12.Visible = v25
	end
end)
task.spawn(function()
	-- upvalues: (copy) v_u_17, (copy) v_u_14, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12
	local v28 = v_u_17:InvokeServer()
	if v28 then
		for v29, v30 in pairs(v28) do
			v_u_14[v29] = v30
		end
		local v31 = v_u_14.x2EXP == true
		local v32 = v_u_14.x2Coins == true
		local v33 = v_u_14.x2Gems == true
		local v34 = v_u_14.x2Luck == true
		local v35 = v31 or (v32 or (v33 or v34))
		v_u_4.Visible = v31
		v_u_5.Visible = v32
		v_u_6.Visible = v33
		v_u_7.Visible = v34
		local v36 = v_u_8
		if v31 then
			v31 = v32 or (v33 or v34)
		end
		v36.Visible = v31
		local v37 = v_u_9
		if v32 then
			v32 = v33 or v34
		end
		v37.Visible = v32
		v_u_10.Visible = v33 and v34
		v_u_11.Visible = v35
		v_u_12.Visible = v35
	end
end)
while true do
	local v38 = os.time() - v13
	local v39 = v38 / 3600
	local v40 = math.floor(v39)
	local v41 = v38 % 3600 / 60
	local v42 = math.floor(v41)
	local v43 = v38 % 60
	v3.Text = string.format("Server Time (%02d:%02d:%02d)", v40, v42, v43)
	task.wait(1)
end