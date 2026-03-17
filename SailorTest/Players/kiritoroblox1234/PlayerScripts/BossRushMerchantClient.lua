local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
local v4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v5 = v2:WaitForChild("Remotes"):WaitForChild("BossRushMerchantRemotes")
local v_u_6 = v5:WaitForChild("GetBossRushMerchantStock")
local v_u_7 = v5:WaitForChild("PurchaseBossRushMerchantItem")
local v8 = v5:WaitForChild("OpenBossRushMerchantUI")
local v9 = v2:WaitForChild("Modules")
local v_u_10 = require(v9:WaitForChild("BossRushMerchantConfig"))
local v11 = require(v9:WaitForChild("ItemImageConfig"))
local v_u_12 = require(v9:WaitForChild("NotificationService"))
local v_u_13 = require(v9:WaitForChild("UIManager"))
v_u_12:Init(v4)
local v_u_14 = v_u_10.BUTTON_COOLDOWN
local v_u_15 = v_u_10.MESSAGES
local v_u_16 = v11.DefaultImage
local v17 = v4:WaitForChild("BossRushMerchantUI"):WaitForChild("MainFrame")
local v18 = v17:WaitForChild("Frame")
local v_u_19 = v18:WaitForChild("Content"):WaitForChild("Holder")
local v_u_20 = v_u_19:WaitForChild("Item")
local v21 = v18:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_22 = v18:WaitForChild("TokenCountLabel")
local v_u_23 = 0
local v_u_24 = 0
local v_u_25 = {}
local v_u_26 = 0
local v_u_27 = {
	["Secret"] = "Mythical"
}
local v_u_28 = math.floor
local v_u_29 = string.format
local function v_u_31(p30)
	-- upvalues: (copy) v_u_29
	if p30 >= 1000000000 then
		return v_u_29("%.1fB", p30 / 1000000000)
	elseif p30 >= 1000000 then
		return v_u_29("%.1fM", p30 / 1000000)
	elseif p30 >= 1000 then
		return v_u_29("%.1fK", p30 / 1000)
	else
		return tostring(p30)
	end
end
local function v_u_34()
	-- upvalues: (copy) v_u_25
	for _, v32 in pairs(v_u_25) do
		for _, v33 in ipairs(v32.connections) do
			v33:Disconnect()
		end
		if v32.frame and v32.frame.Parent then
			v32.frame:Destroy()
		end
	end
	table.clear(v_u_25)
end
local function v_u_40(p35, p36)
	-- upvalues: (copy) v_u_27
	local v37 = p35:FindFirstChild("ColorForRaritiesStrokeDependingOnWhatTheItemRarityIs")
	if v37 then
		local v38 = v_u_27[p36] or p36
		for _, v39 in ipairs(v37:GetChildren()) do
			if v39:IsA("UIGradient") then
				v39.Enabled = v39.Name == v38
			end
		end
	end
end
local function v_u_84(p_u_41, p_u_42)
	-- upvalues: (copy) v_u_20, (copy) v_u_16, (copy) v_u_40, (copy) v_u_29, (copy) v_u_14, (copy) v_u_28, (ref) v_u_26, (copy) v_u_15, (copy) v_u_12, (copy) v_u_7, (copy) v_u_22, (copy) v_u_10, (copy) v_u_19, (copy) v_u_25
	local v43 = v_u_20:Clone()
	v43.Name = p_u_41
	v43.Visible = true
	local v44 = v43.Holder
	v44.TheIconOfTheItem.Image = p_u_42.image or v_u_16
	v44.ItemName.Text = p_u_41
	v44.StockAmountForThatItem.Text = "\226\136\158"
	v_u_40(v43, p_u_42.rarity)
	local v45 = v43.BuyButtonsHolder
	local v46 = v45:FindFirstChild("Holder")
	local v47 = v46 and v46:FindFirstChild("BuyWithTokens") or v45:FindFirstChild("BuyWithTokens")
	local v_u_48 = v46 and v46:FindFirstChild("StockFrame")
	if v_u_48 then
		v_u_48 = v46.StockFrame:FindFirstChild("Stock")
	end
	local v49 = v46 and v46:FindFirstChild("BuyWithGems_Hidden") or v45:FindFirstChild("BuyWithGems_Hidden")
	if v49 then
		v49.Visible = false
	end
	local v_u_50 = nil
	if v47 then
		v47.Visible = true
		local v51 = v47:FindFirstChild("PriceFrame")
		if v51 then
			local v52 = v51:FindFirstChild("AutoSizeHolder")
			if v52 then
				v_u_50 = v52:FindFirstChild("Txt")
				local v53 = v52:FindFirstChild("Icon")
				if v_u_50 then
					local v54 = p_u_42.price
					local v55
					if v54 >= 1000000000 then
						v55 = v_u_29("%.1fB", v54 / 1000000000)
					elseif v54 >= 1000000 then
						v55 = v_u_29("%.1fM", v54 / 1000000)
					elseif v54 >= 1000 then
						v55 = v_u_29("%.1fK", v54 / 1000)
					else
						v55 = tostring(v54)
					end
					v_u_50.Text = v55
				end
				if v53 then
					v53.Image = "rbxassetid://135089258609447"
				end
			end
		end
	end
	local v56 = {}
	if v_u_48 and v_u_50 then
		local v57 = v_u_48:GetPropertyChangedSignal("Text")
		local function v65()
			-- upvalues: (copy) v_u_48, (ref) v_u_50, (copy) p_u_42, (ref) v_u_29
			local v58 = v_u_48.Text
			local v59 = v58:gsub("[^%d]", "")
			local v60 = tonumber(v59)
			if v60 and v60 > 99 then
				v_u_48.Text = tostring(99)
				return
			elseif v59 == v58 then
				local v61 = v60 and math.max(1, v60) or 1
				local v62 = v_u_50
				local v63 = p_u_42.price * v61
				local v64
				if v63 >= 1000000000 then
					v64 = v_u_29("%.1fB", v63 / 1000000000)
				elseif v63 >= 1000000 then
					v64 = v_u_29("%.1fM", v63 / 1000000)
				elseif v63 >= 1000 then
					v64 = v_u_29("%.1fK", v63 / 1000)
				else
					v64 = tostring(v63)
				end
				v62.Text = v64
			else
				v_u_48.Text = v59
			end
		end
		table.insert(v56, v57:Connect(v65))
	end
	local v_u_66 = 0
	local v67 = v47.MouseButton1Click
	local function v83()
		-- upvalues: (ref) v_u_66, (ref) v_u_14, (copy) v_u_48, (ref) v_u_28, (copy) p_u_42, (ref) v_u_26, (ref) v_u_15, (ref) v_u_12, (ref) v_u_7, (copy) p_u_41, (ref) v_u_22, (ref) v_u_10, (ref) v_u_29, (ref) v_u_50
		local v68 = tick()
		if v68 - v_u_66 < v_u_14 then
			return
		else
			v_u_66 = v68
			local v69
			if v_u_48 then
				local v70 = v_u_48.Text
				local v71 = tonumber(v70)
				local v72
				if v71 and v71 >= 1 then
					local v73 = v_u_28(v71)
					v72 = v73 > 99 and 99 or v73
				else
					v72 = 1
				end
				v69 = v72 or 1
			else
				v69 = 1
			end
			if v_u_26 < p_u_42.price * v69 then
				v_u_12:Show("Quest", {
					["message"] = v_u_15.NOT_ENOUGH_TOKENS
				})
			else
				local v74 = v_u_7:InvokeServer(p_u_41, v69)
				if v74.success then
					v_u_26 = v74.newTokens
					local v75 = v_u_22
					local v76 = v_u_10.CURRENCY_DISPLAY
					local v77 = ": "
					local v78 = v_u_26
					local v79
					if v78 >= 1000000000 then
						v79 = v_u_29("%.1fB", v78 / 1000000000)
					elseif v78 >= 1000000 then
						v79 = v_u_29("%.1fM", v78 / 1000000)
					elseif v78 >= 1000 then
						v79 = v_u_29("%.1fK", v78 / 1000)
					else
						v79 = tostring(v78)
					end
					v75.Text = v76 .. v77 .. v79
					v_u_12:ShowPurchased(p_u_41 .. " x" .. (v74.quantity or v69), p_u_42.rarity or "Common")
					if v_u_48 then
						v_u_48.Text = ""
					end
					if v_u_50 then
						local v80 = v_u_50
						local v81 = p_u_42.price * 1
						local v82
						if v81 >= 1000000000 then
							v82 = v_u_29("%.1fB", v81 / 1000000000)
						elseif v81 >= 1000000 then
							v82 = v_u_29("%.1fM", v81 / 1000000)
						elseif v81 >= 1000 then
							v82 = v_u_29("%.1fK", v81 / 1000)
						else
							v82 = tostring(v81)
						end
						v80.Text = v82
						return
					end
				elseif v74.error == "not_enough_tokens" then
					v_u_12:Show("Quest", {
						["message"] = v_u_15.NOT_ENOUGH_TOKENS
					})
				end
			end
		end
	end
	table.insert(v56, v67:Connect(v83))
	v43.Parent = v_u_19
	v_u_25[p_u_41] = {
		["frame"] = v43,
		["stockLabel"] = v44.StockAmountForThatItem,
		["data"] = p_u_42,
		["connections"] = v56
	}
end
local function v_u_94(p85)
	-- upvalues: (copy) v_u_34, (copy) v_u_10, (copy) v_u_84
	v_u_34()
	local v86 = {}
	for v87, v88 in pairs(p85) do
		local v89 = v_u_10.ITEMS[v87]
		local v90 = v89 and v89.sortOrder or 999
		table.insert(v86, {
			["name"] = v87,
			["data"] = v88,
			["order"] = v90
		})
	end
	table.sort(v86, function(p91, p92)
		return p91.order < p92.order
	end)
	for _, v93 in ipairs(v86) do
		v_u_84(v93.name, v93.data)
	end
end
local function v102()
	-- upvalues: (copy) v_u_13, (ref) v_u_23, (copy) v_u_14, (copy) v_u_6, (copy) v_u_29, (copy) v_u_15, (copy) v_u_31, (copy) v_u_12, (ref) v_u_26, (copy) v_u_22, (copy) v_u_10, (copy) v_u_94
	if v_u_13:IsOpen("BossRushMerchantUI") then
		return
	else
		local v95 = tick()
		if v95 - v_u_23 < v_u_14 then
			return
		else
			v_u_23 = v95
			local v96 = v_u_6:InvokeServer()
			if v96.success then
				v_u_26 = v96.tokens or 0
				local v97 = v_u_22
				local v98 = v_u_10.CURRENCY_DISPLAY
				local v99 = ": "
				local v100 = v_u_26
				local v101
				if v100 >= 1000000000 then
					v101 = v_u_29("%.1fB", v100 / 1000000000)
				elseif v100 >= 1000000 then
					v101 = v_u_29("%.1fM", v100 / 1000000)
				elseif v100 >= 1000 then
					v101 = v_u_29("%.1fK", v100 / 1000)
				else
					v101 = tostring(v100)
				end
				v97.Text = v98 .. v99 .. v101
				v_u_94(v96.stock)
				v_u_13:Open("BossRushMerchantUI")
			elseif v96.error == "level" then
				v_u_12:Show("Quest", {
					["message"] = v_u_29(v_u_15.LEVEL_REQUIRED, v_u_31(v96.levelRequired))
				})
			end
		end
	end
end
v21.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_24, (copy) v_u_14, (copy) v_u_13
	local v103 = tick()
	if v103 - v_u_24 < v_u_14 then
		return
	else
		v_u_24 = v103
		if v_u_13:IsOpen("BossRushMerchantUI") then
			v_u_13:Close("BossRushMerchantUI")
		end
	end
end)
v8.OnClientEvent:Connect(v102)
v3.InputBegan:Connect(function(p104, p105)
	-- upvalues: (copy) v_u_13
	if not p105 then
		if p104.KeyCode == Enum.KeyCode.Escape and v_u_13:IsOpen("BossRushMerchantUI") then
			if not v_u_13:IsOpen("BossRushMerchantUI") then
				return
			end
			v_u_13:Close("BossRushMerchantUI")
		end
	end
end)
v_u_20.Visible = false
v17.Visible = false
v_u_13:Register("BossRushMerchantUI", v17)