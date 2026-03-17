local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v5 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v6 = v2:WaitForChild("Remotes"):WaitForChild("MerchantRemotes")
local v_u_7 = v6:WaitForChild("GetMerchantStock")
local v_u_8 = v6:WaitForChild("PurchaseMerchantItem")
local v9 = v6:WaitForChild("MerchantStockUpdate")
local v10 = v2:WaitForChild("Modules")
local v11 = require(v10:WaitForChild("MerchantConfig"))
local v12 = require(v10:WaitForChild("ItemImageConfig"))
local v_u_13 = require(v10:WaitForChild("NotificationService"))
local v_u_14 = require(v10:WaitForChild("UIManager"))
v_u_13:Init(v5)
local v_u_15 = v11.BUTTON_COOLDOWN
local v_u_16 = v11.REFRESH_INTERVAL
local v_u_17 = v11.MESSAGES
local v_u_18 = v12.DefaultImage
local v19 = v5:WaitForChild("MerchantUI"):WaitForChild("MainFrame")
local v20 = v19:WaitForChild("Frame")
local v_u_21 = v20:WaitForChild("Content"):WaitForChild("Holder")
local v_u_22 = v_u_21:WaitForChild("Item")
local v23 = v20:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_24 = v20:WaitForChild("RefreshTimerLabel")
local v_u_25 = {
	["Money"] = "rbxassetid://135089258609447",
	["Gems"] = "rbxassetid://111306650775266"
}
local v_u_26 = {
	["Secret"] = "Mythical"
}
local v_u_27 = 0
local v_u_28 = 0
local v_u_29 = {}
local v_u_30 = nil
local v_u_31 = 0
local v_u_32 = 0
local v_u_33 = math.floor
local v_u_34 = math.max
local v_u_35 = string.format
local v_u_36 = tick
local v_u_37 = os.time
local function v_u_39(p38)
	-- upvalues: (copy) v_u_35
	if p38 >= 1000000000 then
		return v_u_35("%.1fB", p38 / 1000000000)
	elseif p38 >= 1000000 then
		return v_u_35("%.1fM", p38 / 1000000)
	elseif p38 >= 1000 then
		return v_u_35("%.1fK", p38 / 1000)
	else
		return tostring(p38)
	end
end
local function v_u_42()
	-- upvalues: (copy) v_u_29
	for _, v40 in pairs(v_u_29) do
		for _, v41 in ipairs(v40.connections) do
			v41:Disconnect()
		end
		if v40.frame and v40.frame.Parent then
			v40.frame:Destroy()
		end
	end
	table.clear(v_u_29)
end
local function v_u_48(p43, p44)
	-- upvalues: (copy) v_u_26
	local v45 = p43:FindFirstChild("ColorForRaritiesStrokeDependingOnWhatTheItemRarityIs")
	if v45 then
		local v46 = v_u_26[p44] or p44
		for _, v47 in ipairs(v45:GetChildren()) do
			if v47:IsA("UIGradient") then
				v47.Enabled = v47.Name == v46
			end
		end
	end
end
local function v_u_92(p_u_49, p_u_50)
	-- upvalues: (copy) v_u_22, (copy) v_u_18, (copy) v_u_48, (copy) v_u_35, (copy) v_u_25, (copy) v_u_36, (copy) v_u_15, (copy) v_u_33, (copy) v_u_17, (copy) v_u_13, (copy) v_u_8, (copy) v_u_21, (copy) v_u_29
	local v51 = v_u_22:Clone()
	v51.Name = p_u_49
	v51.Visible = true
	local v_u_52 = v51.Holder
	v_u_52.TheIconOfTheItem.Image = p_u_50.image or v_u_18
	v_u_52.ItemName.Text = p_u_49
	v_u_52.StockAmountForThatItem.Text = "Stock: " .. p_u_50.stock
	v_u_48(v51, p_u_50.rarity)
	local v53 = v51.BuyButtonsHolder
	local v54 = v53:FindFirstChild("Holder")
	local v55
	if v54 then
		v55 = v54:FindFirstChild("ButtonsContainer")
	else
		v55 = v54
	end
	local v56 = v55 or (v54 or v53)
	local v57 = v56:FindFirstChild("BuyWithGems")
	local v58 = v56:FindFirstChild("BuyWithCoins")
	local v_u_59 = v54 and v54:FindFirstChild("StockFrame")
	if v_u_59 then
		v_u_59 = v54.StockFrame:FindFirstChild("Stock")
	end
	local v60 = p_u_50.currency == "Gems" and v57 and v57 or v58
	local v61 = p_u_50.currency == "Gems" and v58 and v58 or v57
	if v61 then
		v61.Visible = false
	end
	if v60 then
		v60.Visible = true
	end
	local v_u_62 = nil
	if v60 then
		local v63 = v60:FindFirstChild("PriceFrame")
		if v63 then
			local v64 = v63:FindFirstChild("AutoSizeHolder")
			if v64 then
				v_u_62 = v64:FindFirstChild("Txt")
				local v65 = v64:FindFirstChild("Icon")
				if v_u_62 then
					local v66 = p_u_50.price
					local v67
					if v66 >= 1000000000 then
						v67 = v_u_35("%.1fB", v66 / 1000000000)
					elseif v66 >= 1000000 then
						v67 = v_u_35("%.1fM", v66 / 1000000)
					elseif v66 >= 1000 then
						v67 = v_u_35("%.1fK", v66 / 1000)
					else
						v67 = tostring(v66)
					end
					v_u_62.Text = v67
				end
				if v65 then
					v65.Image = v_u_25[p_u_50.currency]
				end
			end
		end
	end
	local v68 = {}
	if v_u_59 and v_u_62 then
		local v69 = v_u_59:GetPropertyChangedSignal("Text")
		local function v77()
			-- upvalues: (copy) v_u_59, (ref) v_u_62, (copy) p_u_50, (ref) v_u_35
			local v70 = v_u_59.Text
			local v71 = v70:gsub("[^%d]", "")
			local v72 = tonumber(v71)
			if v72 and v72 > 99 then
				v_u_59.Text = tostring(99)
				return
			elseif v71 == v70 then
				local v73 = v72 and math.max(1, v72) or 1
				local v74 = v_u_62
				local v75 = p_u_50.price * v73
				local v76
				if v75 >= 1000000000 then
					v76 = v_u_35("%.1fB", v75 / 1000000000)
				elseif v75 >= 1000000 then
					v76 = v_u_35("%.1fM", v75 / 1000000)
				elseif v75 >= 1000 then
					v76 = v_u_35("%.1fK", v75 / 1000)
				else
					v76 = tostring(v75)
				end
				v74.Text = v76
			else
				v_u_59.Text = v71
			end
		end
		table.insert(v68, v69:Connect(v77))
	end
	local v_u_78 = 0
	local function v90()
		-- upvalues: (ref) v_u_36, (ref) v_u_78, (ref) v_u_15, (copy) v_u_59, (ref) v_u_33, (copy) p_u_50, (ref) v_u_17, (ref) v_u_13, (ref) v_u_8, (copy) p_u_49, (copy) v_u_52, (ref) v_u_62, (ref) v_u_35
		local v79 = v_u_36()
		if v79 - v_u_78 < v_u_15 then
			return
		else
			v_u_78 = v79
			local v80
			if v_u_59 then
				local v81 = v_u_59.Text
				local v82 = tonumber(v81)
				local v83
				if v82 and v82 >= 1 then
					local v84 = v_u_33(v82)
					v83 = v84 > 99 and 99 or v84
				else
					v83 = 1
				end
				v80 = v83 or 1
			else
				v80 = 1
			end
			if p_u_50.stock <= 0 then
				v_u_13:Show("Quest", {
					["message"] = v_u_17.OUT_OF_STOCK
				})
			else
				if p_u_50.stock < v80 then
					v80 = p_u_50.stock
				end
				local v85 = v_u_8:InvokeServer(p_u_49, v80)
				if v85.success then
					p_u_50.stock = v85.newStock
					v_u_52.StockAmountForThatItem.Text = "Stock: " .. v85.newStock
					v_u_13:ShowPurchased(p_u_49 .. " x" .. (v85.quantity or v80), p_u_50.rarity or "Common")
					if v_u_59 then
						v_u_59.Text = ""
					end
					if v_u_62 then
						local v86 = v_u_62
						local v87 = p_u_50.price * 1
						local v88
						if v87 >= 1000000000 then
							v88 = v_u_35("%.1fB", v87 / 1000000000)
						elseif v87 >= 1000000 then
							v88 = v_u_35("%.1fM", v87 / 1000000)
						elseif v87 >= 1000 then
							v88 = v_u_35("%.1fK", v87 / 1000)
						else
							v88 = tostring(v87)
						end
						v86.Text = v88
						return
					end
				else
					if v85.error == "not_enough" then
						local v89 = v85.currency == "Money" and "coins" or "gems"
						v_u_13:Show("Quest", {
							["message"] = v_u_35(v_u_17.NOT_ENOUGH_CURRENCY, v89)
						})
						return
					end
					if v85.error == "out_of_stock" then
						v_u_13:Show("Quest", {
							["message"] = v_u_17.OUT_OF_STOCK
						})
					end
				end
			end
		end
	end
	if v60 then
		local v91 = v60.MouseButton1Click
		table.insert(v68, v91:Connect(v90))
	end
	v51.Parent = v_u_21
	v_u_29[p_u_49] = {
		["frame"] = v51,
		["stockLabel"] = v_u_52.StockAmountForThatItem,
		["data"] = p_u_50,
		["connections"] = v68
	}
end
local function v_u_100()
	-- upvalues: (copy) v_u_37, (ref) v_u_32, (ref) v_u_31, (copy) v_u_16, (copy) v_u_34, (copy) v_u_24, (copy) v_u_33, (copy) v_u_35
	local v93 = v_u_37()
	if v93 ~= v_u_32 then
		v_u_32 = v93
		local v94 = v_u_24
		local v95 = "Refresh: "
		local v96 = v_u_34(0, (v_u_33((v_u_34(0, v_u_16 - (v93 - v_u_31))))))
		local v97 = v_u_33(v96 / 60)
		local v98 = v96 % 60
		local v99
		if v97 >= 60 then
			v99 = v_u_35("%d:%02d:%02d", v_u_33(v97 / 60), v97 % 60, v98)
		else
			v99 = v_u_35("%02d:%02d", v97, v98)
		end
		v94.Text = v95 .. v99
	end
end
local function v106()
	-- upvalues: (copy) v_u_14, (copy) v_u_36, (ref) v_u_27, (copy) v_u_15, (copy) v_u_7, (copy) v_u_35, (copy) v_u_17, (copy) v_u_39, (copy) v_u_13, (ref) v_u_31, (copy) v_u_37, (ref) v_u_32, (copy) v_u_42, (copy) v_u_92, (ref) v_u_30, (copy) v_u_4, (copy) v_u_100
	if v_u_14:IsOpen("MerchantUI") then
		return
	else
		local v101 = v_u_36()
		if v101 - v_u_27 < v_u_15 then
			return
		else
			v_u_27 = v101
			local v102 = v_u_7:InvokeServer()
			if v102.success then
				v_u_31 = v102.lastRefresh or v_u_37()
				v_u_32 = 0
				local v103 = v102.stock
				v_u_42()
				for v104, v105 in pairs(v103) do
					v_u_92(v104, v105)
				end
				if not v_u_30 then
					v_u_30 = v_u_4.Heartbeat:Connect(v_u_100)
				end
				v_u_14:Open("MerchantUI")
			elseif v102.error == "level" then
				v_u_13:Show("Quest", {
					["message"] = v_u_35(v_u_17.LEVEL_REQUIRED, v_u_39(v102.levelRequired))
				})
			end
		end
	end
end
v23.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_36, (ref) v_u_28, (copy) v_u_15, (copy) v_u_14, (ref) v_u_30
	local v107 = v_u_36()
	if v107 - v_u_28 < v_u_15 then
		return
	else
		v_u_28 = v107
		if v_u_14:IsOpen("MerchantUI") then
			if v_u_30 then
				v_u_30:Disconnect()
				v_u_30 = nil
			end
			v_u_14:Close("MerchantUI")
		end
	end
end)
v9.OnClientEvent:Connect(function(p108, p109)
	-- upvalues: (copy) v_u_29
	local v110 = v_u_29[p108]
	if v110 then
		v110.data.stock = p109
		v110.stockLabel.Text = "Stock: " .. p109
	end
end)
v6:WaitForChild("OpenMerchantUI").OnClientEvent:Connect(v106)
v3.InputBegan:Connect(function(p111, p112)
	-- upvalues: (copy) v_u_14, (ref) v_u_30
	if not p112 then
		if p111.KeyCode == Enum.KeyCode.Escape and v_u_14:IsOpen("MerchantUI") then
			if not v_u_14:IsOpen("MerchantUI") then
				return
			end
			if v_u_30 then
				v_u_30:Disconnect()
				v_u_30 = nil
			end
			v_u_14:Close("MerchantUI")
		end
	end
end)
v_u_22.Visible = false
v19.Visible = false
v_u_14:Register("MerchantUI", v19, {
	["onClose"] = function()
		-- upvalues: (ref) v_u_30
		if v_u_30 then
			v_u_30:Disconnect()
			v_u_30 = nil
		end
	end
})