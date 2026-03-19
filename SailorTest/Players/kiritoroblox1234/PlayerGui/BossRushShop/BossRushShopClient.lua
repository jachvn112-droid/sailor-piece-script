local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_4 = require(v2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v_u_5 = require(v2:WaitForChild("BossRushShopConfig"))
local v6 = v2:WaitForChild("RemoteEvents")
local v7 = v2:WaitForChild("Remotes")
local v8 = v6:WaitForChild("OpenBossRushShop")
local v9 = v6:WaitForChild("BossRushShopSync")
local v_u_10 = v7:WaitForChild("RequestBossRushUpgrade")
local v_u_11 = v3:WaitForChild("BossRushShop")
local v12 = v_u_11:WaitForChild("MainFrame")
local v13 = v12:WaitForChild("Frame")
local v14 = v13.CloseButtonFrame:WaitForChild("CloseButton")
local v_u_15 = v13.Content.Holder:WaitForChild("Holder")
local v16 = v13.Content.Holder:WaitForChild("TokensFrameHolder")
local v_u_17 = v16.Holder.TXTHolder.BossTokens:WaitForChild("BossTokens")
local v_u_18 = v16.Holder.TXTHolder:WaitForChild("Txt")
local v_u_19 = false
local v_u_20 = {}
local v_u_21 = 0
v_u_4:Register("BossRushShop", v12)
local function v_u_25(p22)
	local v23 = math.floor(p22)
	local v24 = tostring(v23):reverse():gsub("(%d%d%d)", "%1,"):reverse()
	if v24:sub(1, 1) == "," then
		v24 = v24:sub(2)
	end
	return v24
end
local function v_u_43()
	-- upvalues: (copy) v_u_17, (copy) v_u_25, (ref) v_u_21, (copy) v_u_18, (copy) v_u_5, (copy) v_u_15, (ref) v_u_20
	v_u_17.Text = v_u_25(v_u_21)
	v_u_18.Text = "Rush Coins:"
	for _, v26 in ipairs(v_u_5.Upgrades) do
		local v27 = v_u_15:FindFirstChild(v26.FrameName)
		if v27 then
			local v28 = v_u_20[v26.Key] or 0
			local v29 = v26.MaxLevel <= v28
			local v30 = v_u_5.GetBonus(v26.Key, v28)
			local v31 = v_u_5.GetBonus(v26.Key, v28 + 1)
			local v32 = v_u_5.GetCost(v26.Key, v28)
			local v33 = v27.ItemInfo.BossTokens:FindFirstChild("BossTokens")
			if v33 then
				v33.Text = v29 and "MAX" or v_u_25(v32 or 0)
			end
			local v34 = nil
			local v35 = nil
			for _, v36 in ipairs(v27.Upgrades:GetChildren()) do
				if v36.Name == "Txt" and v36:IsA("Frame") then
					local v37 = v36:FindFirstChild("AutoSizeHolder")
					if v37 then
						if v37:FindFirstChild("UpgTxt1") then
							v34 = v37
						elseif v37:FindFirstChild("Upgrades") then
							v35 = v37
						end
					end
				end
			end
			if v34 then
				local v38 = v34:FindFirstChild("UpgTxt1")
				local v39 = v34:FindFirstChild("UpgTxt2")
				if v38 then
					v38.Text = "+" .. v30 .. v26.BonusUnit
				end
				if v39 then
					v39.Text = v29 and "MAX" or "+" .. v31 .. v26.BonusUnit
				end
			end
			local v40 = v35 and v35:FindFirstChild("Upgrades")
			if v40 then
				v40.Text = v28 .. "/" .. v26.MaxLevel .. " Upgrades"
			end
			local v41 = v27.ButtonHolder:FindFirstChild("Upgrade")
			local v42 = v27.ButtonHolder:FindFirstChild("NoTokens")
			if v29 then
				if v41 then
					v41.Visible = false
				end
				if v42 then
					v42.Visible = true
					v42:FindFirstChild("Txt", true).Text = "Maxed"
				end
			elseif v32 and v32 <= v_u_21 then
				if v41 then
					v41.Visible = true
				end
				if v42 then
					v42.Visible = false
				end
			else
				if v41 then
					v41.Visible = false
				end
				if v42 then
					v42.Visible = true
					v42:FindFirstChild("Txt", true).Text = "No Tokens"
				end
			end
		end
	end
end
v8.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_4
	v_u_11.Enabled = true
	v_u_4:Open("BossRushShop")
end)
v14.Activated:Connect(function()
	-- upvalues: (copy) v_u_4, (copy) v_u_11
	v_u_4:Close("BossRushShop")
	task.wait(0.3)
	v_u_11.Enabled = false
end)
v9.OnClientEvent:Connect(function(p44)
	-- upvalues: (ref) v_u_20, (ref) v_u_21, (copy) v_u_43
	if p44.Upgrades then
		v_u_20 = p44.Upgrades
	end
	if p44.RushCoins then
		v_u_21 = p44.RushCoins
	end
	v_u_43()
end)
for _, v_u_45 in ipairs(v_u_5.Upgrades) do
	local v46 = v_u_15:FindFirstChild(v_u_45.FrameName)
	if v46 then
		local v47 = v46.ButtonHolder:FindFirstChild("Upgrade")
		if v47 then
			v47.Activated:Connect(function()
				-- upvalues: (ref) v_u_19, (copy) v_u_10, (copy) v_u_45
				if not v_u_19 then
					v_u_19 = true
					local _, _ = v_u_10:InvokeServer(v_u_45.Key)
					task.wait(0.3)
					v_u_19 = false
				end
			end)
		end
	end
end