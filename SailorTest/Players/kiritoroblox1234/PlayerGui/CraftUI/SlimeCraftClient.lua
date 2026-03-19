local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_4 = require(v2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v5 = v2:WaitForChild("RemoteEvents")
local v6 = v2:WaitForChild("Remotes")
local v7 = v5:WaitForChild("OpenSlimeCraftUI")
local v_u_8 = v6:WaitForChild("RequestSlimeCraft")
local v9 = v3:WaitForChild("CraftUI"):WaitForChild("MainFrame")
local v10 = v9:WaitForChild("Frame")
local v11 = v10.CloseButtonFrame:WaitForChild("CloseButton")
local v12 = v10.Content.Holder:WaitForChild("SlimeKeyItemFrame")
local v13 = v12:WaitForChild("CraftButton")
local v_u_14 = v12:WaitForChild("QuantityFrame"):WaitForChild("QuantityInput")
local v_u_15 = v12:WaitForChild("Holder"):WaitForChild("Txt")
local v_u_16 = false
v_u_14:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (copy) v_u_14, (copy) v_u_15
	local v17 = v_u_14.Text
	local v18 = v17:gsub("[^%d]", "")
	local v19 = tonumber(v18)
	if v19 and v19 > 99 then
		v_u_14.Text = tostring(99)
	elseif v18 ~= v17 then
		v_u_14.Text = v18
	end
	local v20 = v_u_14.Text
	local v21 = tonumber(v20)
	local v22
	if v21 and v21 >= 1 then
		local v23 = math.floor(v21)
		v22 = v23 > 99 and 99 or v23
	else
		v22 = 1
	end
	v_u_15.Text = "x" .. 2 * v22 .. " Slime Shard"
end)
v_u_4:Register("SlimeCraftUI", v9)
v11.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_4
	v_u_4:Close("SlimeCraftUI")
end)
v7.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_15
	v_u_4:Open("SlimeCraftUI")
	v_u_14.Text = ""
	local v24 = v_u_14.Text
	local v25 = tonumber(v24)
	local v26
	if v25 and v25 >= 1 then
		local v27 = math.floor(v25)
		v26 = v27 > 99 and 99 or v27
	else
		v26 = 1
	end
	v_u_15.Text = "x" .. 2 * v26 .. " Slime Shard"
end)
v13.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_16, (copy) v_u_14, (copy) v_u_8
	if not v_u_16 then
		v_u_16 = true
		local v28 = v_u_14.Text
		local v29 = tonumber(v28)
		local v_u_30
		if v29 and v29 >= 1 then
			local v31 = math.floor(v29)
			v_u_30 = v31 > 99 and 99 or v31
		else
			v_u_30 = 1
		end
		local v32, v33, _ = pcall(function()
			-- upvalues: (ref) v_u_8, (copy) v_u_30
			return v_u_8:InvokeServer("SlimeKey", v_u_30)
		end)
		if not v32 then
			warn("[SlimeCraft] Remote error:", v33)
		end
		task.wait(0.5)
		v_u_16 = false
	end
end)