local v1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_5 = require(v_u_2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v_u_6 = require(v_u_2:WaitForChild("Modules"):WaitForChild("ItemRarityConfig"))
local v_u_7 = require(v_u_2:WaitForChild("Modules"):WaitForChild("ItemImageConfig"))
local v_u_8 = {
	["REQUEST_DISPLAY_TIME"] = 15,
	["REQUEST_TWEEN_TIME"] = 0.35,
	["MAX_ITEMS_PER_SIDE"] = 25,
	["TRADABLE_CATEGORIES"] = { "Items" }
}
local v9 = v_u_2:WaitForChild("Remotes"):WaitForChild("TradeRemotes")
local v_u_10 = v9.SendTradeRequest
local v_u_11 = v9.RespondToRequest
local v_u_12 = v9.AddItemToTrade
local v_u_13 = v9.RemoveItemFromTrade
local v_u_14 = v9.SetReady
local v_u_15 = v9.CancelTrade
local v_u_16 = v9.ConfirmTrade
local v17 = v9.TradeRequestReceived
local v18 = v9.TradeStarted
local v19 = v9.TradeUpdated
local v20 = v9.TradeCancelled
local v21 = v9.TradeCompleted
local v_u_22 = v9.GetTradablePlayers
local v23 = v9.PlayerStatusChanged
local v24 = v4:WaitForChild("BasicStatsCurrencyAndButtonsUI").MainFrame.UIButtons.TradeButtonFrame.Button
local v25 = v4:WaitForChild("TradingUI").MainFrame
local v_u_26 = v25.Frame.Content.Users
local v27 = v4:WaitForChild("TradeRequestUI")
local v_u_28 = v27:FindFirstChild("TradeRequest") or v27
local v_u_29 = v4:WaitForChild("InTradingUI").MainFrame
local v30 = v4:WaitForChild("InventoryPanelUI").MainFrame.Frame.Content.Holder.StorageHolder.Storage
local v_u_31 = {
	["Common"] = v30:FindFirstChild("Slot"),
	["Uncommon"] = v30:FindFirstChild("SlotUncommonRarity"),
	["Rare"] = v30:FindFirstChild("SlotRareRarity"),
	["Epic"] = v30:FindFirstChild("SlotEpicRarity"),
	["Legendary"] = v30:FindFirstChild("SlotLegendaryRarity"),
	["Mythical"] = v30:FindFirstChild("SlotMythicalRarity"),
	["Secret"] = v30:FindFirstChild("SlotSecretRarity")
}
local v_u_32 = v_u_29.Frame.Content
local v33 = v_u_32.Player1Side.Player1Holder
local v_u_34 = v33.Player1Items
local v_u_35 = v_u_34:FindFirstChild("AddToTrade")
local v_u_36 = v_u_34:FindFirstChild("Slot")
local v_u_37 = v33.PopupHolder.InventoryPopup
local v_u_38 = v_u_37.Content.Inventory
local v_u_39 = v_u_37.Content.Actions.QuantityBox.Quantity
local v_u_40 = v_u_37.Content.Actions.SearchBox.Search
local v_u_41 = v_u_32.TimerFrame.Frame.Txt
local v42 = v_u_32.Player2Side.Player2Holder.Player2Holder
local v_u_43 = v42.Player2Items
local v_u_44 = v33:FindFirstChild("ReadyIndicator")
local v_u_45 = v42:FindFirstChild("ReadyIndicator")
local v_u_46 = false
local v_u_47 = false
v_u_5:Register("TradeSelection", v25)
v_u_5:Register("TradeMain", v_u_29, {
	["onClose"] = function()
		-- upvalues: (ref) v_u_46, (ref) v_u_47, (copy) v_u_15
		if v_u_46 and not v_u_47 then
			v_u_15:FireServer()
		end
	end
})
local v_u_48 = v_u_28.Position
local v_u_49 = v_u_46
local v_u_50 = v_u_47
local v_u_51 = {}
local v_u_52 = {}
local v_u_53 = 0
local v_u_54 = "trading"
local v_u_55 = nil
local v_u_56 = {}
local v_u_57 = {}
local v_u_58 = true
local v_u_59 = 1
local v_u_60 = {}
local v_u_61 = {}
local v_u_62 = nil
for _, v63 in ipairs(v_u_26:GetChildren()) do
	if v63:IsA("ImageButton") and v63.Name == "UserFrame" then
		v_u_62 = v63:Clone()
		break
	end
end
(function()
	-- upvalues: (copy) v_u_36, (copy) v_u_38, (copy) v_u_43
	if v_u_36 then
		v_u_36.Visible = false
	end
	for _, v64 in ipairs(v_u_38:GetChildren()) do
		if v64:IsA("Frame") and v64.Name == "Frame" then
			v64.Visible = false
		end
	end
	for _, v65 in ipairs(v_u_43:GetChildren()) do
		if v65:IsA("Frame") and v65.Name == "Frame" then
			v65.Visible = false
		end
	end
end)()
local v66 = v_u_2:WaitForChild("Remotes"):WaitForChild("SyncUntradeableItems", 5)
if v66 then
	v66.OnClientEvent:Connect(function(p67)
		-- upvalues: (ref) v_u_56
		v_u_56 = p67 or {}
	end)
end
local v_u_68 = nil
local function v_u_70()
	-- upvalues: (ref) v_u_61
	for _, v69 in ipairs(v_u_61) do
		if v69.Connected then
			v69:Disconnect()
		end
	end
	v_u_61 = {}
end
local function v_u_72()
	-- upvalues: (copy) v_u_26, (ref) v_u_52
	for _, v71 in ipairs(v_u_26:GetChildren()) do
		if v71:IsA("ImageButton") or v71:IsA("TextLabel") then
			v71:Destroy()
		end
	end
	v_u_52 = {}
end
local function v_u_76(p73)
	-- upvalues: (ref) v_u_51
	v_u_51 = {}
	for _, v74 in ipairs(p73 or {}) do
		local v75 = v74.category .. "_" .. v74.name
		v_u_51[v75] = (v_u_51[v75] or 0) + v74.quantity
	end
end
local function v_u_77()
	-- upvalues: (copy) v_u_35, (ref) v_u_53, (copy) v_u_8
	if v_u_35 then
		v_u_35.LayoutOrder = -1
		v_u_35.Visible = v_u_53 < v_u_8.MAX_ITEMS_PER_SIDE
	end
end
v_u_68 = function()
	-- upvalues: (copy) v_u_2, (copy) v_u_38, (copy) v_u_8, (copy) v_u_57, (ref) v_u_51, (ref) v_u_56, (copy) v_u_6, (copy) v_u_31, (copy) v_u_7, (ref) v_u_59, (copy) v_u_12, (copy) v_u_40
	local v78 = v_u_2:WaitForChild("Remotes"):FindFirstChild("RequestInventory")
	if v78 then
		v78:FireServer()
	end
	task.wait(0.15)
	for _, v79 in ipairs(v_u_38:GetChildren()) do
		if v79:IsA("ImageButton") then
			v79:Destroy()
		end
	end
	local v80 = {}
	for _, v81 in ipairs(v_u_8.TRADABLE_CATEGORIES) do
		local v82 = v_u_57[v81] or {}
		for _, v83 in ipairs(v82) do
			local v84 = v_u_51[v81 .. "_" .. v83.name] or 0
			local v85 = (v83.quantity or 1) - v84
			local v86 = v_u_56[v83.name] or 0
			if v86 > 0 then
				v85 = v85 - math.min(v86, v85)
			end
			if v85 > 0 then
				local v87 = {
					["category"] = v81,
					["name"] = v83.name,
					["quantity"] = v85,
					["image"] = v83.image
				}
				table.insert(v80, v87)
			end
		end
	end
	v_u_6:SortByRarity(v80)
	for v88, v89 in ipairs(v80) do
		local v90 = v_u_31[v_u_6:GetRarity(v89.name) or "Common"] or v_u_31.Common
		if v90 then
			local v91 = v90:Clone()
			v91.Name = v89.name
			v91.LayoutOrder = v88
			v91.Visible = true
			v91.Parent = v_u_38
			local v92 = v91:FindFirstChild("Slot")
			if v92 then
				v92 = v92:FindFirstChild("Holder")
			end
			if v92 then
				if v92:FindFirstChild("ItemName") then
					v92.ItemName.Text = v89.name
				end
				if v92:FindFirstChild("Quantity") then
					v92.Quantity.Text = "x" .. v89.quantity
					v92.Quantity.Visible = true
				end
				if v92:FindFirstChild("Placeholder") then
					local v93 = v_u_7:GetImage(v89.name)
					if v93 and v93 ~= "rbxassetid://0" then
						v92.Placeholder.Image = v93
						v92.Placeholder.Visible = true
					end
				end
			end
			v91:SetAttribute("MaxQuantity", v89.quantity)
			v91:SetAttribute("Category", v89.category)
			local v_u_94 = v89.category
			local v_u_95 = v89.name
			local v_u_96 = v89.quantity
			v91.Activated:Connect(function()
				-- upvalues: (ref) v_u_59, (copy) v_u_96, (ref) v_u_12, (copy) v_u_94, (copy) v_u_95
				local v97 = v_u_59
				local v98 = v_u_96
				v_u_12:FireServer(v_u_94, v_u_95, (math.clamp(v97, 1, v98)))
			end)
		end
	end
	local v99 = v_u_40.Text:lower()
	if v99 ~= "" then
		for _, v100 in ipairs(v_u_38:GetChildren()) do
			if v100:IsA("ImageButton") then
				v100.Visible = v100.Name:lower():find(v99, 1, true) ~= nil
			end
		end
	end
	local v_u_101 = v_u_38:FindFirstChild("UIGridLayout")
	if v_u_101 then
		task.defer(function()
			-- upvalues: (ref) v_u_38, (copy) v_u_101
			local v102 = 0
			for _, v103 in ipairs(v_u_38:GetChildren()) do
				if v103:IsA("ImageButton") and v103.Visible then
					v102 = v102 + 1
				end
			end
			if v102 > 0 then
				local v104 = v_u_38.AbsoluteSize.X
				local v105 = v_u_38.AbsoluteSize.Y
				local v106 = v_u_101.CellSize.X.Scale * v104 + v_u_101.CellSize.X.Offset
				local v107 = v_u_101.CellSize.Y.Scale * v105 + v_u_101.CellSize.Y.Offset
				local v108 = v_u_101.CellPadding.X.Scale * v104 + v_u_101.CellPadding.X.Offset
				local v109 = (v104 + v108) / (v106 + v108)
				local v110 = math.floor(v109)
				local v111 = v102 / math.max(1, v110)
				local v112 = math.ceil(v111)
				local v113 = v_u_101.CellPadding.Y.Scale * v105 + v_u_101.CellPadding.Y.Offset
				local v114 = v112 * v107 + (v112 - 1) * v113
				v_u_38.CanvasSize = UDim2.new(0, 0, 0, v114)
			else
				v_u_38.CanvasSize = UDim2.new(0, 0, 0, 0)
			end
		end)
	end
end
local function v_u_117()
	-- upvalues: (copy) v_u_39, (ref) v_u_59
	v_u_39.Text = "x1"
	v_u_59 = 1
	v_u_39.FocusLost:Connect(function()
		-- upvalues: (ref) v_u_39, (ref) v_u_59
		local v115 = v_u_39.Text:gsub("^x", ""):gsub("%D", "")
		local v116 = tonumber(v115)
		if v116 and v116 >= 1 then
			v_u_59 = math.floor(v116)
			v_u_39.Text = "x" .. v_u_59
		else
			v_u_59 = 1
			v_u_39.Text = "x1"
		end
	end)
	v_u_39.Focused:Connect(function()
		-- upvalues: (ref) v_u_39
		v_u_39.CursorPosition = #v_u_39.Text + 1
	end)
end
local function v_u_151()
	-- upvalues: (copy) v_u_70, (copy) v_u_29, (copy) v_u_32, (ref) v_u_61, (copy) v_u_15, (ref) v_u_54, (copy) v_u_16, (copy) v_u_14, (copy) v_u_35, (ref) v_u_58, (copy) v_u_37, (ref) v_u_68, (copy) v_u_38, (copy) v_u_117, (copy) v_u_40
	v_u_70()
	local v118 = v_u_29.Frame.CloseButtonFrame.CloseButton
	local v119 = v_u_32.Player2Side.Player2Holder.Buttons.Ready
	local v120 = v_u_32.Player2Side.Player2Holder.Buttons.Decline
	local v121 = v_u_61
	local v122 = v118.Activated
	local function v123()
		-- upvalues: (ref) v_u_15
		v_u_15:FireServer()
	end
	table.insert(v121, v122:Connect(v123))
	local v124 = v_u_61
	local v125 = v119.Activated
	local function v126()
		-- upvalues: (ref) v_u_54, (ref) v_u_16, (ref) v_u_14
		if v_u_54 == "confirming" then
			v_u_16:FireServer()
		elseif v_u_54 == "trading" then
			v_u_14:FireServer(true)
		end
	end
	table.insert(v124, v125:Connect(v126))
	local v127 = v_u_61
	local v128 = v120.Activated
	local function v129()
		-- upvalues: (ref) v_u_15
		v_u_15:FireServer()
	end
	table.insert(v127, v128:Connect(v129))
	local v130 = v_u_61
	local v131 = v_u_35.Activated
	local function v132()
		-- upvalues: (ref) v_u_58, (ref) v_u_37, (ref) v_u_68, (ref) v_u_38
		v_u_58 = not v_u_58
		v_u_37.Visible = v_u_58
		if v_u_58 then
			v_u_68()
			v_u_38.CanvasPosition = Vector2.new(0, 0)
		end
	end
	table.insert(v130, v131:Connect(v132))
	v_u_117()
	v_u_40:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (ref) v_u_40, (ref) v_u_38
		local v133 = v_u_40.Text:lower()
		for _, v134 in ipairs(v_u_38:GetChildren()) do
			if v134:IsA("ImageButton") then
				v134.Visible = v133 == "" and true or v134.Name:lower():find(v133, 1, true) ~= nil
			end
		end
		local v_u_135 = v_u_38:FindFirstChild("UIGridLayout")
		if v_u_135 then
			task.defer(function()
				-- upvalues: (ref) v_u_38, (copy) v_u_135
				local v136 = 0
				for _, v137 in ipairs(v_u_38:GetChildren()) do
					if v137:IsA("ImageButton") and v137.Visible then
						v136 = v136 + 1
					end
				end
				local v138 = v_u_38.AbsoluteSize.X
				local v139 = v_u_38.AbsoluteSize.Y
				local v140 = v_u_135.CellSize.X.Scale * v138 + v_u_135.CellSize.X.Offset
				local v141 = v_u_135.CellSize.Y.Scale * v139 + v_u_135.CellSize.Y.Offset
				local v142 = v_u_135.CellPadding.X.Scale * v138 + v_u_135.CellPadding.X.Offset
				local v143 = v_u_135.CellPadding.Y.Scale * v139 + v_u_135.CellPadding.Y.Offset
				local v144 = (v138 + v142) / (v140 + v142)
				local v145 = math.floor(v144)
				local v146 = v136 / math.max(1, v145)
				local v147 = math.ceil(v146)
				local v148 = v147 * v141
				local v149 = v147 - 1
				local v150 = v148 + math.max(0, v149) * v143
				v_u_38.CanvasSize = UDim2.new(0, 0, 0, v150)
			end)
		end
	end)
end
local function v_u_152()
	-- upvalues: (copy) v_u_5
	v_u_5:Close("TradeSelection")
end
local function v_u_157(p153, p154, p155)
	if p155 == "available" then
		p153.Username.Text = p154
		p153.Username.TextColor3 = Color3.fromRGB(255, 255, 255)
		p153.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
		p153.AutoButtonColor = true
	else
		local v156 = p155 == "disabled" and " (Trading Disabled)" or (p155 == "inTrade" and " (In Trade)" or " (Busy)")
		p153.Username.Text = p154 .. v156
		p153.Username.TextColor3 = Color3.fromRGB(120, 120, 120)
		p153.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
		p153.AutoButtonColor = false
	end
end
local function v_u_164()
	-- upvalues: (copy) v_u_72, (copy) v_u_22, (ref) v_u_62, (copy) v_u_26, (ref) v_u_52, (copy) v_u_10, (ref) v_u_152
	v_u_72()
	local v158 = v_u_22:InvokeServer()
	for _, v_u_159 in ipairs(v158) do
		if v_u_62 then
			local v160 = v_u_62:Clone()
			v160.Visible = true
			v160.Parent = v_u_26
			v_u_52[v_u_159.userId] = {
				["frame"] = v160,
				["displayName"] = v_u_159.displayName or v_u_159.name
			}
			if v_u_159.status == "available" then
				v160.Username.Text = v_u_159.displayName or v_u_159.name
				v160.Activated:Connect(function()
					-- upvalues: (ref) v_u_52, (copy) v_u_159, (ref) v_u_10, (ref) v_u_152
					local v161 = v_u_52[v_u_159.userId]
					if v161 and v161.status == "available" then
						v_u_10:FireServer(v_u_159.userId)
						v_u_152()
					end
				end)
			else
				local v162 = v_u_159.status == "disabled" and " (Trading Disabled)" or (v_u_159.status == "inTrade" and " (In Trade)" or " (Busy)")
				v160.Username.Text = (v_u_159.displayName or v_u_159.name) .. v162
				v160.Username.TextColor3 = Color3.fromRGB(120, 120, 120)
				v160.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
				v160.AutoButtonColor = false
			end
			v_u_52[v_u_159.userId].status = v_u_159.status
		end
	end
	if #v158 == 0 then
		local v163 = Instance.new("TextLabel")
		v163.Name = "NoPlayers"
		v163.Size = UDim2.new(1, 0, 0, 40)
		v163.BackgroundTransparency = 1
		v163.Text = "No other players in server"
		v163.TextColor3 = Color3.fromRGB(150, 150, 150)
		v163.Font = Enum.Font.Gotham
		v163.TextSize = 16
		v163.Parent = v_u_26
	end
end
local function v_u_169(p165)
	-- upvalues: (copy) v_u_48, (copy) v_u_28, (copy) v_u_3, (copy) v_u_8
	local v166 = UDim2.new(v_u_48.X.Scale, v_u_48.X.Offset, -0.2, 0)
	local v167
	if p165 then
		v167 = v_u_48 or v166
	else
		v167 = v166
	end
	if p165 then
		v_u_28.Visible = true
		v_u_28.Position = v166
	end
	local v168 = v_u_3:Create(v_u_28, TweenInfo.new(v_u_8.REQUEST_TWEEN_TIME, Enum.EasingStyle.Back, p165 and Enum.EasingDirection.Out or Enum.EasingDirection.In), {
		["Position"] = v167
	})
	v168:Play()
	if not p165 then
		v168.Completed:Connect(function()
			-- upvalues: (ref) v_u_28
			v_u_28.Visible = false
		end)
	end
end
local function v_u_174(p170)
	-- upvalues: (ref) v_u_49, (ref) v_u_54, (ref) v_u_53, (ref) v_u_51, (ref) v_u_60, (ref) v_u_59, (ref) v_u_58, (copy) v_u_5, (copy) v_u_29, (copy) v_u_32, (copy) v_u_34, (copy) v_u_36, (copy) v_u_43, (copy) v_u_41, (copy) v_u_39, (copy) v_u_40, (copy) v_u_37, (ref) v_u_77, (copy) v_u_44, (copy) v_u_45, (ref) v_u_151, (ref) v_u_68
	v_u_49 = true
	v_u_54 = "trading"
	v_u_53 = 0
	v_u_51 = {}
	v_u_60 = {}
	v_u_59 = 1
	v_u_58 = true
	v_u_5:Close("TradeSelection", true)
	for _, v171 in ipairs(v_u_29.Frame.Header.HeaderLayer:GetDescendants()) do
		if v171:IsA("TextLabel") and v171.Name == "HeaderTxt" then
			v171.Text = "TRADING"
		end
	end
	v_u_32.Player2Side.Player2Label.Frame.Txt.Text = (p170.partnerName or "Partner") .. "\'s"
	for _, v172 in ipairs(v_u_34:GetChildren()) do
		if v172:IsA("ImageButton") and (v172.Name ~= "AddToTrade" and v172 ~= v_u_36) then
			v172:Destroy()
		end
	end
	for _, v173 in ipairs(v_u_43:GetChildren()) do
		if v173:IsA("ImageButton") then
			v173:Destroy()
		end
	end
	v_u_41.Text = "-"
	v_u_39.Text = "x1"
	v_u_40.Text = ""
	v_u_37.Visible = true
	v_u_77()
	if v_u_44 then
		v_u_44.Visible = false
	end
	if v_u_45 then
		v_u_45.Visible = false
	end
	v_u_5:Open("TradeMain", false, true)
	v_u_151()
	v_u_68()
end
local function v175()
	-- upvalues: (ref) v_u_50, (ref) v_u_49, (ref) v_u_54, (ref) v_u_53, (ref) v_u_51, (ref) v_u_60, (ref) v_u_59, (ref) v_u_58, (copy) v_u_70, (copy) v_u_5
	v_u_50 = true
	v_u_49 = false
	v_u_54 = "trading"
	v_u_53 = 0
	v_u_51 = {}
	v_u_60 = {}
	v_u_59 = 1
	v_u_58 = true
	v_u_70()
	v_u_5:Close("TradeMain")
	v_u_50 = false
end
local function v199(p176)
	-- upvalues: (ref) v_u_49, (ref) v_u_60, (copy) v_u_76, (copy) v_u_34, (copy) v_u_36, (ref) v_u_53, (ref) v_u_77, (copy) v_u_6, (copy) v_u_31, (copy) v_u_7, (copy) v_u_13, (copy) v_u_43, (ref) v_u_54, (copy) v_u_32, (copy) v_u_41, (copy) v_u_44, (copy) v_u_45, (ref) v_u_58, (ref) v_u_68
	if v_u_49 then
		v_u_60 = p176.myItems or {}
		v_u_76(v_u_60)
		for _, v177 in ipairs(v_u_34:GetChildren()) do
			if v177:IsA("ImageButton") and (v177.Name ~= "AddToTrade" and v177 ~= v_u_36) then
				v177:Destroy()
			end
		end
		v_u_53 = #v_u_60
		v_u_77()
		for v_u_178, v179 in ipairs(v_u_60) do
			local v180 = v_u_31[v_u_6:GetRarity(v179.name) or "Common"] or v_u_31.Common
			if v180 then
				local v181 = v180:Clone()
				v181.Name = "TradeSlot_" .. v_u_178
				v181.LayoutOrder = v_u_178
				v181.Visible = true
				v181.Parent = v_u_34
				local v182 = v181:FindFirstChild("Slot")
				if v182 then
					v182 = v182:FindFirstChild("Holder")
				end
				if v182 then
					if v182:FindFirstChild("ItemName") then
						v182.ItemName.Text = v179.name
					end
					if v182:FindFirstChild("Quantity") then
						v182.Quantity.Text = "x" .. (v179.quantity or 1)
						v182.Quantity.Visible = true
					end
					if v182:FindFirstChild("Placeholder") then
						local v183 = v_u_7:GetImage(v179.name)
						if v183 and v183 ~= "rbxassetid://0" then
							v182.Placeholder.Image = v183
							v182.Placeholder.Visible = true
						elseif v179.image and v179.image ~= "rbxassetid://0" then
							v182.Placeholder.Image = v179.image
							v182.Placeholder.Visible = true
						end
					end
				end
				local v_u_184 = v181:FindFirstChild("RemoveIndicator")
				if v_u_184 then
					v_u_184.Visible = false
					v181.MouseEnter:Connect(function()
						-- upvalues: (copy) v_u_184
						v_u_184.Visible = true
					end)
					v181.MouseLeave:Connect(function()
						-- upvalues: (copy) v_u_184
						v_u_184.Visible = false
					end)
				end
				v181.Activated:Connect(function()
					-- upvalues: (ref) v_u_13, (copy) v_u_178
					v_u_13:FireServer(v_u_178)
				end)
			end
		end
		for _, v185 in ipairs(v_u_43:GetChildren()) do
			if v185:IsA("ImageButton") then
				v185:Destroy()
			end
		end
		for v186, v187 in ipairs(p176.theirItems or {}) do
			local v188 = v_u_31[v_u_6:GetRarity(v187.name) or "Common"] or v_u_31.Common
			if v188 then
				local v189 = v188:Clone()
				v189.Name = "TheirSlot_" .. v186
				v189.LayoutOrder = v186
				v189.Visible = true
				v189.AutoButtonColor = false
				v189.Parent = v_u_43
				local v190 = v189:FindFirstChild("Slot")
				if v190 then
					v190 = v190:FindFirstChild("Holder")
				end
				if v190 then
					if v190:FindFirstChild("ItemName") then
						v190.ItemName.Text = v187.name
					end
					if v190:FindFirstChild("Quantity") then
						v190.Quantity.Text = "x" .. (v187.quantity or 1)
						v190.Quantity.Visible = true
					end
					if v190:FindFirstChild("Placeholder") then
						local v191 = v_u_7:GetImage(v187.name)
						if v191 and v191 ~= "rbxassetid://0" then
							v190.Placeholder.Image = v191
							v190.Placeholder.Visible = true
						elseif v187.image and v187.image ~= "rbxassetid://0" then
							v190.Placeholder.Image = v187.image
							v190.Placeholder.Visible = true
						end
					end
				end
				local v192 = v189:FindFirstChild("RemoveIndicator")
				if v192 then
					v192.Visible = false
				end
			end
		end
		local v193 = p176.phase or "trading"
		v_u_54 = v193
		local v194 = v_u_32.Player2Side.Player2Holder.Buttons.Ready
		if v193 == "trading" then
			if p176.myReady then
				v194.Txt.Text = "Waiting..."
				v194.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
			else
				v194.Txt.Text = "Ready"
				v194.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
			end
			v_u_41.Text = "-"
			v_u_41.TextColor3 = Color3.new(1, 1, 1)
		elseif v193 == "countdown" then
			v194.Txt.Text = "Locked..."
			v194.BackgroundColor3 = Color3.fromRGB(100, 100, 60)
			local v195 = v_u_41
			local v196 = p176.countdown or "..."
			v195.Text = tostring(v196)
			v_u_41.TextColor3 = Color3.fromRGB(255, 200, 100)
		elseif v193 == "confirming" then
			if p176.myConfirm then
				v194.Txt.Text = "Waiting..."
				v194.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
			else
				v194.Txt.Text = "CONFIRM"
				v194.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
			end
			v_u_41.Text = "\226\156\147"
			v_u_41.TextColor3 = Color3.fromRGB(100, 255, 100)
		end
		local v197 = v_u_44 and v_u_44:FindFirstChild("Txt")
		if v197 then
			if v193 == "confirming" then
				if p176.myConfirm then
					v197.Text = "CONFIRMED"
					v_u_44.Visible = true
				else
					v_u_44.Visible = false
				end
			elseif p176.myReady then
				v197.Text = "READY"
				v_u_44.Visible = true
			else
				v_u_44.Visible = false
			end
		end
		local v198 = v_u_45 and v_u_45:FindFirstChild("Txt")
		if v198 then
			if v193 == "confirming" then
				if p176.theirConfirm then
					v198.Text = "CONFIRMED"
					v_u_45.Visible = true
				else
					v_u_45.Visible = false
				end
			elseif p176.theirReady then
				v198.Text = "READY"
				v_u_45.Visible = true
			else
				v_u_45.Visible = false
			end
		end
		if v_u_58 then
			v_u_68()
		end
	end
end
v23.OnClientEvent:Connect(function(p200)
	-- upvalues: (copy) v_u_5, (ref) v_u_49, (ref) v_u_52, (copy) v_u_157
	if v_u_5:IsOpen("TradeSelection") then
		if not v_u_49 then
			local v201 = v_u_52[p200.userId]
			if v201 and (v201.frame and v201.frame.Parent) then
				v201.status = p200.status
				v_u_157(v201.frame, v201.displayName, p200.status)
			end
		end
	else
		return
	end
end)
v17.OnClientEvent:Connect(function(p202)
	-- upvalues: (copy) v_u_28, (copy) v_u_70, (ref) v_u_61, (copy) v_u_11, (copy) v_u_169, (ref) v_u_55, (copy) v_u_8
	v_u_28.InfoHolder.Txt.Text = "Incoming Trade Request:\n<font color=\"#CC4A4D\">" .. (p202.senderDisplayName or p202.senderName) .. "</font>\nwants to trade with you!"
	local v203 = v_u_28.ButtonsHolder.Yes
	local v204 = v_u_28.ButtonsHolder.No
	v203.Txt.Text = "Accept"
	v204.Txt.Text = "Decline"
	v_u_70()
	local v205 = v_u_61
	local v206 = v203.Activated
	local function v207()
		-- upvalues: (ref) v_u_11, (ref) v_u_169, (ref) v_u_55
		v_u_11:FireServer(true)
		v_u_169(false)
		if v_u_55 then
			task.cancel(v_u_55)
			v_u_55 = nil
		end
	end
	table.insert(v205, v206:Connect(v207))
	local v208 = v_u_61
	local v209 = v204.Activated
	local function v210()
		-- upvalues: (ref) v_u_11, (ref) v_u_169, (ref) v_u_55
		v_u_11:FireServer(false)
		v_u_169(false)
		if v_u_55 then
			task.cancel(v_u_55)
			v_u_55 = nil
		end
	end
	table.insert(v208, v209:Connect(v210))
	v_u_169(true)
	if v_u_55 then
		task.cancel(v_u_55)
	end
	v_u_55 = task.delay(v_u_8.REQUEST_DISPLAY_TIME, function()
		-- upvalues: (ref) v_u_11, (ref) v_u_169
		v_u_11:FireServer(false)
		v_u_169(false)
	end)
end)
v18.OnClientEvent:Connect(function(p211)
	-- upvalues: (copy) v_u_5, (copy) v_u_174
	v_u_5:Close("TradeSelection", true)
	v_u_174(p211)
end)
v19.OnClientEvent:Connect(v199)
v20.OnClientEvent:Connect(v175)
v21.OnClientEvent:Connect(v175)
local v212 = v_u_2:WaitForChild("Remotes"):FindFirstChild("UpdateInventory")
if v212 then
	v212.OnClientEvent:Connect(function(p213, p214)
		-- upvalues: (copy) v_u_57
		v_u_57[p213] = p214
	end)
end
v1.PlayerAdded:Connect(function()
	-- upvalues: (copy) v_u_5, (ref) v_u_49, (copy) v_u_164
	if v_u_5:IsOpen("TradeSelection") and not v_u_49 then
		v_u_164()
	end
end)
v1.PlayerRemoving:Connect(function()
	-- upvalues: (copy) v_u_5, (ref) v_u_49, (copy) v_u_164
	if v_u_5:IsOpen("TradeSelection") and not v_u_49 then
		task.wait(0.1)
		v_u_164()
	end
end)
v25.Frame.CloseButtonFrame.CloseButton.Activated:Connect(v_u_152)
v24.Activated:Connect(function()
	-- upvalues: (copy) v_u_5, (ref) v_u_152, (ref) v_u_49, (copy) v_u_164
	if v_u_5:IsOnCooldown() then
		return
	elseif v_u_5:IsOpen("TradeSelection") then
		v_u_152()
		return
	elseif v_u_49 then
		return
	elseif not v_u_5:IsOpen("TradeSelection") then
		v_u_164()
		v_u_5:Open("TradeSelection")
	end
end)