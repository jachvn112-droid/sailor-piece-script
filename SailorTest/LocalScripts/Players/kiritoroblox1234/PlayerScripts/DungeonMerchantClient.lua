local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
local v4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v5 = v2:WaitForChild("Remotes"):WaitForChild("DungeonMerchantRemotes")
local v_u_6 = v5:WaitForChild("GetDungeonMerchantStock")
local v_u_7 = v5:WaitForChild("PurchaseDungeonMerchantItem")
local v8 = v5:WaitForChild("OpenDungeonMerchantUI")
local v9 = v2:WaitForChild("Modules")
local v_u_10 = require(v9:WaitForChild("DungeonMerchantConfig"))
local v11 = require(v9:WaitForChild("ItemImageConfig"))
local v_u_12 = require(v9:WaitForChild("NotificationService"))
local v_u_13 = require(v9:WaitForChild("UIManager"))
v_u_12:Init(v4)
local v_u_14 = v_u_10.BUTTON_COOLDOWN
local v_u_15 = v_u_10.MESSAGES
local v_u_16 = v11.DefaultImage
local v17 = v4:WaitForChild("DungeonMerchantUI"):WaitForChild("MainFrame")
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
local v_u_30 = tick
local function v_u_32(p31)
	-- upvalues: (copy) v_u_29
	if p31 >= 1000000000 then
		return v_u_29("%.1fB", p31 / 1000000000)
	elseif p31 >= 1000000 then
		return v_u_29("%.1fM", p31 / 1000000)
	elseif p31 >= 1000 then
		return v_u_29("%.1fK", p31 / 1000)
	else
		return tostring(p31)
	end
end
local function v_u_35()
	-- upvalues: (copy) v_u_25
	for _, v33 in pairs(v_u_25) do
		for _, v34 in ipairs(v33.connections) do
			v34:Disconnect()
		end
		if v33.frame and v33.frame.Parent then
			v33.frame:Destroy()
		end
	end
	table.clear(v_u_25)
end
local function v_u_41(p36, p37)
	-- upvalues: (copy) v_u_27
	local v38 = p36:FindFirstChild("ColorForRaritiesStrokeDependingOnWhatTheItemRarityIs")
	if v38 then
		local v39 = v_u_27[p37] or p37
		for _, v40 in ipairs(v38:GetChildren()) do
			if v40:IsA("UIGradient") then
				v40.Enabled = v40.Name == v39
			end
		end
	end
end
local function v_u_84(p_u_42, p_u_43)
	-- upvalues: (copy) v_u_20, (copy) v_u_16, (copy) v_u_41, (copy) v_u_29, (copy) v_u_30, (copy) v_u_14, (copy) v_u_28, (ref) v_u_26, (copy) v_u_15, (copy) v_u_12, (copy) v_u_7, (copy) v_u_22, (copy) v_u_19, (copy) v_u_25
	local v44 = v_u_20:Clone()
	v44.Name = p_u_42
	v44.Visible = true
	local v45 = v44.Holder
	v45.TheIconOfTheItem.Image = p_u_43.image or v_u_16
	v45.ItemName.Text = p_u_42
	v45.StockAmountForThatItem.Text = "\226\136\158"
	v_u_41(v44, p_u_43.rarity)
	local v46 = v44.BuyButtonsHolder
	local v47 = v46:FindFirstChild("Holder")
	local v48 = v47 and v47:FindFirstChild("BuyWithTokens") or v46:FindFirstChild("BuyWithTokens")
	local v_u_49 = v47 and v47:FindFirstChild("StockFrame")
	if v_u_49 then
		v_u_49 = v47.StockFrame:FindFirstChild("Stock")
	end
	local v50 = v47 and v47:FindFirstChild("BuyWithGems_Hidden") or v46:FindFirstChild("BuyWithGems_Hidden")
	if v50 then
		v50.Visible = false
	end
	local v_u_51 = nil
	if v48 then
		v48.Visible = true
		local v52 = v48:FindFirstChild("PriceFrame")
		if v52 then
			local v53 = v52:FindFirstChild("AutoSizeHolder")
			if v53 then
				v_u_51 = v53:FindFirstChild("Txt")
				local v54 = v53:FindFirstChild("Icon")
				if v_u_51 then
					local v55 = p_u_43.price
					local v56
					if v55 >= 1000000000 then
						v56 = v_u_29("%.1fB", v55 / 1000000000)
					elseif v55 >= 1000000 then
						v56 = v_u_29("%.1fM", v55 / 1000000)
					elseif v55 >= 1000 then
						v56 = v_u_29("%.1fK", v55 / 1000)
					else
						v56 = tostring(v55)
					end
					v_u_51.Text = v56
				end
				if v54 then
					v54.Image = "rbxassetid://135089258609447"
				end
			end
		end
	end
	local v57 = {}
	if v_u_49 and v_u_51 then
		local v58 = v_u_49:GetPropertyChangedSignal("Text")
		local function v66()
			-- upvalues: (copy) v_u_49, (ref) v_u_51, (copy) p_u_43, (ref) v_u_29
			local v59 = v_u_49.Text
			local v60 = v59:gsub("[^%d]", "")
			local v61 = tonumber(v60)
			if v61 and v61 > 99 then
				v_u_49.Text = tostring(99)
				return
			elseif v60 == v59 then
				local v62 = v61 and math.max(1, v61) or 1
				local v63 = v_u_51
				local v64 = p_u_43.price * v62
				local v65
				if v64 >= 1000000000 then
					v65 = v_u_29("%.1fB", v64 / 1000000000)
				elseif v64 >= 1000000 then
					v65 = v_u_29("%.1fM", v64 / 1000000)
				elseif v64 >= 1000 then
					v65 = v_u_29("%.1fK", v64 / 1000)
				else
					v65 = tostring(v64)
				end
				v63.Text = v65
			else
				v_u_49.Text = v60
			end
		end
		table.insert(v57, v58:Connect(v66))
	end
	local v_u_67 = 0
	local v68 = v48.MouseButton1Click
	local function v83()
		-- upvalues: (ref) v_u_30, (ref) v_u_67, (ref) v_u_14, (copy) v_u_49, (ref) v_u_28, (copy) p_u_43, (ref) v_u_26, (ref) v_u_15, (ref) v_u_12, (ref) v_u_7, (copy) p_u_42, (ref) v_u_22, (ref) v_u_29, (ref) v_u_51
		local v69 = v_u_30()
		if v69 - v_u_67 < v_u_14 then
			return
		else
			v_u_67 = v69
			local v70
			if v_u_49 then
				local v71 = v_u_49.Text
				local v72 = tonumber(v71)
				local v73
				if v72 and v72 >= 1 then
					local v74 = v_u_28(v72)
					v73 = v74 > 99 and 99 or v74
				else
					v73 = 1
				end
				v70 = v73 or 1
			else
				v70 = 1
			end
			if v_u_26 < p_u_43.price * v70 then
				v_u_12:Show("Quest", {
					["message"] = v_u_15.NOT_ENOUGH_TOKENS
				})
			else
				local v75 = v_u_7:InvokeServer(p_u_42, v70)
				if v75.success then
					v_u_26 = v75.newTokens
					local v76 = v_u_22
					local v77 = "Tokens: "
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
					v76.Text = v77 .. v79
					v_u_12:ShowPurchased(p_u_42 .. " x" .. (v75.quantity or v70), p_u_43.rarity or "Common")
					if v_u_49 then
						v_u_49.Text = ""
					end
					if v_u_51 then
						local v80 = v_u_51
						local v81 = p_u_43.price * 1
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
				elseif v75.error == "not_enough_tokens" then
					v_u_12:Show("Quest", {
						["message"] = v_u_15.NOT_ENOUGH_TOKENS
					})
				end
			end
		end
	end
	table.insert(v57, v68:Connect(v83))
	v44.Parent = v_u_19
	v_u_25[p_u_42] = {
		["frame"] = v44,
		["stockLabel"] = v45.StockAmountForThatItem,
		["data"] = p_u_43,
		["connections"] = v57
	}
end
local function v_u_94(p85)
	-- upvalues: (copy) v_u_35, (copy) v_u_10, (copy) v_u_84
	v_u_35()
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
local function v101()
	-- upvalues: (copy) v_u_13, (copy) v_u_30, (ref) v_u_23, (copy) v_u_14, (copy) v_u_6, (copy) v_u_29, (copy) v_u_15, (copy) v_u_32, (copy) v_u_12, (ref) v_u_26, (copy) v_u_22, (copy) v_u_94
	if v_u_13:IsOpen("DungeonMerchantUI") then
		return
	else
		local v95 = v_u_30()
		if v95 - v_u_23 < v_u_14 then
			return
		else
			v_u_23 = v95
			local v96 = v_u_6:InvokeServer()
			if v96.success then
				v_u_26 = v96.tokens or 0
				local v97 = v_u_22
				local v98 = "Tokens: "
				local v99 = v_u_26
				local v100
				if v99 >= 1000000000 then
					v100 = v_u_29("%.1fB", v99 / 1000000000)
				elseif v99 >= 1000000 then
					v100 = v_u_29("%.1fM", v99 / 1000000)
				elseif v99 >= 1000 then
					v100 = v_u_29("%.1fK", v99 / 1000)
				else
					v100 = tostring(v99)
				end
				v97.Text = v98 .. v100
				v_u_94(v96.stock)
				v_u_13:Open("DungeonMerchantUI")
			elseif v96.error == "level" then
				v_u_12:Show("Quest", {
					["message"] = v_u_29(v_u_15.LEVEL_REQUIRED, v_u_32(v96.levelRequired))
				})
			end
		end
	end
end
v21.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_30, (ref) v_u_24, (copy) v_u_14, (copy) v_u_13
	local v102 = v_u_30()
	if v102 - v_u_24 < v_u_14 then
		return
	else
		v_u_24 = v102
		if v_u_13:IsOpen("DungeonMerchantUI") then
			v_u_13:Close("DungeonMerchantUI")
		end
	end
end)
v8.OnClientEvent:Connect(v101)
v3.InputBegan:Connect(function(p103, p104)
	-- upvalues: (copy) v_u_13
	if not p104 then
		if p103.KeyCode == Enum.KeyCode.Escape and v_u_13:IsOpen("DungeonMerchantUI") then
			if not v_u_13:IsOpen("DungeonMerchantUI") then
				return
			end
			v_u_13:Close("DungeonMerchantUI")
		end
	end
end)
v_u_20.Visible = false
v17.Visible = false
v_u_13:Register("DungeonMerchantUI", v17)