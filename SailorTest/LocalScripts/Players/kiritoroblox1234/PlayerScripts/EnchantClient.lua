local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v4 = v2:WaitForChild("Modules")
local v_u_5 = require(v4:WaitForChild("EnchantConfig"))
require(v4:WaitForChild("AccessoryConfig"))
local v_u_6 = require(v4:WaitForChild("ItemRarityConfig"))
local v_u_7 = require(v4:WaitForChild("ItemImageConfig"))
local v_u_8 = require(v4:WaitForChild("NotificationService"))
local v_u_9 = require(v4:WaitForChild("UIManager"))
local v_u_10 = v2:WaitForChild("Remotes")
local v_u_11 = v_u_10:WaitForChild("EnchantAccessory")
local v_u_12 = v_u_10:WaitForChild("GetEnchantData")
local v13 = v_u_10:WaitForChild("EnchantResult")
local v14 = v_u_10:WaitForChild("UpdateInventory")
local v15 = v_u_10:WaitForChild("OpenEnchantUI")
local v_u_16 = v3:WaitForChild("EnchantUI"):WaitForChild("MainFrame")
local v17 = v_u_16:WaitForChild("Frame")
local v18 = v17:WaitForChild("Content")
local v_u_19 = v18:WaitForChild("PopupHolder")
local v20 = v_u_19:WaitForChild("InventoryPopup")
local v_u_21 = v20.Content:WaitForChild("AccessoryInventory")
local v_u_22 = v20.Content:WaitForChild("Search"):WaitForChild("Search")
local v_u_23 = {
	["Secret"] = v_u_21:FindFirstChild("SlotSecretRarity"),
	["Mythical"] = v_u_21:FindFirstChild("SlotMythicalRarity"),
	["Legendary"] = v_u_21:FindFirstChild("SlotLegendaryRarity"),
	["Epic"] = v_u_21:FindFirstChild("SlotEpicRarity"),
	["Rare"] = v_u_21:FindFirstChild("SlotRareRarity"),
	["Uncommon"] = v_u_21:FindFirstChild("SlotUncommonRarity"),
	["Common"] = v_u_21:FindFirstChild("Slot")
}
for _, v24 in pairs(v_u_23) do
	if v24 then
		v24.Visible = false
	end
end
local v25 = v18:WaitForChild("ItemsHolder")
local v26 = v25:WaitForChild("Holder")
local v27 = v26:WaitForChild("Item1")
local v_u_28 = v26:WaitForChild("Item2")
local v_u_29 = v27:WaitForChild("AddAccessory")
local v_u_30 = v27:WaitForChild("AccessorySlot")
local v_u_31 = v25:WaitForChild("AbleToEnchant")
local v_u_32 = v25:WaitForChild("UnAbleToEnchant")
local v_u_33 = v_u_31:WaitForChild("SuccessChanceLabel")
local v_u_34 = v_u_31.ToolTip.NextEnchantStatsPreviewFrame
local v_u_35 = v_u_34.Holder.AutoSizeHolder:WaitForChild("NextEnchantStat")
local v_u_36 = v_u_32.ToolTip.Holder:WaitForChild("Holder")
local v_u_37 = v_u_36:WaitForChild("RequirementComplete")
local v_u_38 = v_u_36:WaitForChild("RequirementIncomplete")
local v39 = v18:WaitForChild("EnchantButton")
local v_u_40 = v39:WaitForChild("On")
local v_u_41 = v39:WaitForChild("Off")
local v42 = v17.CloseButtonFrame:WaitForChild("CloseButton")
local v_u_43 = false
local v_u_44 = nil
local v_u_45 = nil
local v_u_46 = {}
local v_u_47 = 0
local v_u_48 = {
	["Damage"] = "+%d%% Damage",
	["Defense"] = "+%d%% Defense",
	["DamageReduction"] = "+%d%% Dmg Reduction",
	["Cooldown"] = "-%d%% Cooldown",
	["Speed"] = "+%d%% Speed"
}
local v_u_49 = {
	["Common"] = Color3.fromRGB(255, 255, 255),
	["Uncommon"] = Color3.fromRGB(28, 190, 53),
	["Rare"] = Color3.fromRGB(60, 178, 229),
	["Epic"] = Color3.fromRGB(255, 0, 255),
	["Legendary"] = Color3.fromRGB(255, 202, 79),
	["Mythical"] = Color3.fromRGB(184, 0, 15)
}
local function v_u_53()
	-- upvalues: (copy) v_u_21, (copy) v_u_23
	for _, v50 in pairs(v_u_21:GetChildren()) do
		if v50:IsA("ImageButton") then
			local v51 = false
			for _, v52 in pairs(v_u_23) do
				if v50 == v52 then
					v51 = true
					break
				end
			end
			if not v51 then
				v50:Destroy()
			end
		end
	end
end
local function v_u_57(p54, p55)
	for _, v56 in pairs(p54:GetChildren()) do
		if v56:IsA("GuiObject") and (v56.Name ~= p55 and not (v56:IsA("UIGridLayout") or v56:IsA("UIListLayout"))) then
			v56:Destroy()
		end
	end
end
local function v_u_81(p58)
	-- upvalues: (copy) v_u_53, (ref) v_u_46, (copy) v_u_6, (copy) v_u_5, (copy) v_u_23, (copy) v_u_7, (ref) v_u_47, (copy) v_u_21
	v_u_53()
	local v59 = (p58 or ""):lower()
	local v60 = {}
	local v61 = {}
	for _, v62 in pairs(v_u_46) do
		local v63 = v62.name
		local v64 = v62.enchantLevel or 0
		local v65 = v62.quantity or 0
		if v60[v63] then
			v60[v63].totalQuantity = v60[v63].totalQuantity + v65
			if v60[v63].enchantLevel < v64 then
				v60[v63].enchantLevel = v64
			end
		else
			v60[v63] = {
				["name"] = v63,
				["enchantLevel"] = v64,
				["totalQuantity"] = v65,
				["quantity"] = v65,
				["image"] = v62.image
			}
			table.insert(v61, v63)
		end
	end
	local v66 = {}
	for _, v67 in ipairs(v61) do
		local v68 = v60[v67]
		v68.quantity = v68.totalQuantity
		table.insert(v66, v68)
	end
	v_u_6:SortByRarity(v66)
	for _, v_u_69 in pairs(v66) do
		local v_u_70 = v_u_69.name
		local v_u_71 = v_u_69.enchantLevel or 0
		local v72
		if v_u_71 and v_u_71 > 0 then
			v72 = v_u_70 .. " [E" .. v_u_71 .. "]"
		else
			v72 = v_u_70
		end
		if (v59 == "" or v72:lower():find(v59, 1, true)) and (v_u_5:CanBeEnchanted(v_u_70) and v_u_71 < v_u_5.MaxEnchantLevel) then
			local v73 = v_u_23[v_u_6:GetRarity(v_u_70)] or v_u_23.Common
			if v73 then
				local v74 = v73:Clone()
				v74.Visible = true
				v74.Name = "Item_" .. v_u_70
				local v75 = v74:FindFirstChild("Slot")
				local v76 = v75 and v75:FindFirstChild("Holder")
				if v76 then
					local v77 = v76:FindFirstChild("ItemName")
					if v77 then
						v77.Text = v72
					end
					local v78 = v76:FindFirstChild("Quantity")
					if v78 then
						if v_u_69.quantity and v_u_69.quantity > 1 then
							v78.Text = "x" .. v_u_69.quantity
							v78.Visible = true
						else
							v78.Visible = false
						end
					end
					local v79 = v76:FindFirstChild("Placeholder")
					if v79 then
						local v80 = v_u_7:GetImage(v_u_70)
						if v80 and (v80 ~= "rbxassetid://0" and v80 ~= "") then
							v79.Image = v80
							v79.Visible = true
						else
							v79.Visible = false
						end
					end
				end
				v74.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_47, (copy) v_u_70, (copy) v_u_71, (copy) v_u_69
					if tick() - v_u_47 >= 0.35 then
						v_u_47 = tick()
						selectAccessory(v_u_70, v_u_71, v_u_69)
					end
				end)
				v74.Parent = v_u_21
			end
		end
	end
end
function selectAccessory(p82, p83, p84)
	-- upvalues: (ref) v_u_44, (copy) v_u_19, (copy) v_u_29, (copy) v_u_30, (copy) v_u_6, (copy) v_u_49, (copy) v_u_7, (copy) v_u_28
	v_u_44 = p82
	v_u_19.Visible = false
	v_u_29.Visible = false
	v_u_30.Visible = true
	local v85
	if p83 and p83 > 0 then
		v85 = p82 .. " [E" .. p83 .. "]"
	else
		v85 = p82
	end
	local v86 = v_u_6:GetRarity(p82)
	local v87 = v_u_30
	local v88 = v_u_49[v86] or v_u_49.Common
	local v89 = v87:FindFirstChild("Glows")
	if v89 then
		v89.ImageColor3 = v88
	end
	local v90 = v87:FindFirstChild("Slot")
	local v91 = v90 and v90:FindFirstChild("Inline")
	if v91 then
		v91.Color = v88
	end
	local v92 = v_u_30.Slot.Holder
	local v93 = v92:FindFirstChild("ItemName")
	if v93 then
		v93.Text = v85
	end
	local v94 = v92:FindFirstChild("Quantity")
	if v94 then
		if p84 and (p84.quantity and p84.quantity > 1) then
			v94.Text = "x" .. p84.quantity
			v94.Visible = true
		else
			v94.Visible = false
		end
	end
	local v95 = v92:FindFirstChild("Placeholder")
	if v95 then
		local v96 = v_u_7:GetImage(p82)
		if v96 and (v96 ~= "rbxassetid://0" and v96 ~= "") then
			v95.Image = v96
			v95.Visible = true
		else
			v95.Visible = false
		end
	end
	v_u_28.Visible = true
	local v97 = v_u_28:FindFirstChild("Slot")
	if v97 then
		local v98 = v97:FindFirstChild("Glows")
		if v98 then
			v98.ImageColor3 = v_u_49[v86] or v_u_49.Common
		end
		local v99 = v97:FindFirstChild("Slot")
		if v99 then
			local v100 = v99:FindFirstChild("Inline")
			if v100 then
				v100.Color = v_u_49[v86] or v_u_49.Common
			end
			local v101 = v99:FindFirstChild("Holder")
			if v101 then
				local v102 = v101:FindFirstChild("ItemName")
				if v102 then
					local v103 = (p83 or 0) + 1
					local v104
					if v103 and v103 > 0 then
						v104 = p82 .. " [E" .. v103 .. "]"
					else
						v104 = p82
					end
					v102.Text = v104
				end
				local v105 = v101:FindFirstChild("Quantity")
				if v105 then
					v105.Visible = false
				end
				local v106 = v101:FindFirstChild("Placeholder")
				if v106 then
					local v107 = v_u_7:GetImage(p82)
					if v107 and (v107 ~= "rbxassetid://0" and v107 ~= "") then
						v106.Image = v107
						v106.Visible = true
					else
						v106.Visible = false
					end
				end
			end
		end
	end
	refreshEnchantData()
end
function refreshEnchantData()
	-- upvalues: (ref) v_u_44, (copy) v_u_12, (ref) v_u_45, (copy) v_u_31, (copy) v_u_32, (copy) v_u_57, (copy) v_u_36, (copy) v_u_37, (copy) v_u_40, (copy) v_u_41, (copy) v_u_33, (copy) v_u_34, (copy) v_u_35, (copy) v_u_48, (copy) v_u_38
	if v_u_44 then
		local v108, v109 = pcall(function()
			-- upvalues: (ref) v_u_12, (ref) v_u_44
			return v_u_12:InvokeServer(v_u_44)
		end)
		if v108 and v109 then
			v_u_45 = v109
			if v109.maxed then
				v_u_31.Visible = false
				v_u_32.Visible = true
				v_u_57(v_u_36, "RequirementComplete", "RequirementIncomplete")
				local v110 = v_u_37:Clone()
				v110.Name = "MaxLabel"
				v110.Text = "Maximum enchant level reached!"
				v110.Visible = true
				v110.Parent = v_u_36
				v_u_40.Visible = false
				v_u_41.Visible = true
				return
			elseif v109.canEnchant then
				v_u_31.Visible = true
				v_u_32.Visible = false
				if v109.pityBonus and v109.pityBonus > 0 then
					v_u_33.Text = "Success: " .. v109.successChance .. "% (+" .. v109.pityBonus .. "% pity)"
				else
					v_u_33.Text = "Success Chance: " .. v109.successChance .. "%"
				end
				v_u_57(v_u_34.Holder.AutoSizeHolder, "NextEnchantStat")
				for v111, v112 in pairs(v109.statGains) do
					local v113 = v_u_35:Clone()
					v113.Name = v111
					local v114 = v_u_48[v111] or "+%d%% " .. v111
					v113.Text = string.format(v114, v112)
					v113.Visible = true
					v113.Parent = v_u_34.Holder.AutoSizeHolder
				end
				v_u_40.Visible = true
				v_u_41.Visible = false
			else
				v_u_31.Visible = false
				v_u_32.Visible = true
				local v115 = {}
				for _, v116 in pairs(v109.requirements) do
					table.insert(v115, v116)
				end
				table.sort(v115, function(p117, p118)
					if p117.complete == p118.complete then
						return p117.need > p118.need
					else
						return p117.complete
					end
				end)
				v_u_57(v_u_36, "RequirementComplete", "RequirementIncomplete")
				for _, v119 in pairs(v115) do
					local v120 = (v119.complete and v_u_37 or v_u_38):Clone()
					v120.Name = v119.name
					v120.Text = v119.have .. "/" .. v119.need .. " " .. v119.name
					v120.Visible = true
					v120.Parent = v_u_36
				end
				v_u_40.Visible = false
				v_u_41.Visible = true
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_121()
	-- upvalues: (ref) v_u_47, (ref) v_u_44, (copy) v_u_8, (ref) v_u_45, (copy) v_u_40, (copy) v_u_41, (copy) v_u_11
	if tick() - v_u_47 >= 0.35 then
		v_u_47 = tick()
		if v_u_44 then
			if v_u_45 and v_u_45.maxed then
				task.spawn(function()
					-- upvalues: (ref) v_u_8
					v_u_8:Show("Quest", {
						["message"] = "Can\'t enchant further!"
					})
				end)
				return
			elseif v_u_45 and v_u_45.canEnchant then
				v_u_40.Visible = false
				v_u_41.Visible = true
				v_u_11:FireServer(v_u_44)
			else
				task.spawn(function()
					-- upvalues: (ref) v_u_8
					v_u_8:Show("Quest", {
						["message"] = "Not enough materials!"
					})
				end)
			end
		else
			task.spawn(function()
				-- upvalues: (ref) v_u_8
				v_u_8:Show("Quest", {
					["message"] = "Select an accessory first!"
				})
			end)
			return
		end
	else
		return
	end
end
v13.OnClientEvent:Connect(function(p_u_122)
	-- upvalues: (copy) v_u_8, (ref) v_u_44, (copy) v_u_30, (copy) v_u_28
	if p_u_122.success then
		task.spawn(function()
			-- upvalues: (ref) v_u_8
			v_u_8:Show("Quest", {
				["message"] = "Enchant successful!"
			})
		end)
		task.wait(0.5)
		refreshEnchantData()
		if p_u_122.data and p_u_122.data.newLevel then
			local v123 = v_u_44
			local v124 = p_u_122.data.newLevel
			if v124 and v124 > 0 then
				v123 = v123 .. " [E" .. v124 .. "]"
			end
			local v125 = v_u_30.Slot.Holder:FindFirstChild("ItemName")
			if v125 then
				v125.Text = v123
			end
			local v126 = v_u_28:FindFirstChild("ItemName", true)
			if v126 then
				local v127 = v_u_44
				local v128 = p_u_122.data.newLevel + 1
				if v128 and v128 > 0 then
					v127 = v127 .. " [E" .. v128 .. "]"
				end
				v126.Text = v127
				return
			end
		end
	else
		task.spawn(function()
			-- upvalues: (ref) v_u_8, (copy) p_u_122
			v_u_8:Show("Quest", {
				["message"] = p_u_122.message or "Enchant failed!"
			})
		end)
		refreshEnchantData()
	end
end)
v14.OnClientEvent:Connect(function(p129, p130)
	-- upvalues: (ref) v_u_46, (ref) v_u_43, (copy) v_u_19, (copy) v_u_81, (copy) v_u_22, (ref) v_u_44, (copy) v_u_30
	if p129 == "Accessories" then
		v_u_46 = p130
		if v_u_43 and v_u_19.Visible then
			v_u_81(v_u_22.Text)
		end
		if v_u_44 then
			for _, v131 in pairs(p130) do
				if v131.name == v_u_44 then
					local v132 = v_u_30.Slot.Holder:FindFirstChild("Quantity")
					if v132 then
						if v131.quantity and v131.quantity > 1 then
							v132.Text = "x" .. v131.quantity
							v132.Visible = true
						else
							v132.Visible = false
						end
					end
					break
				end
			end
		end
	end
end)
v42.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_47, (ref) v_u_43, (copy) v_u_9, (ref) v_u_44, (ref) v_u_45, (copy) v_u_29, (copy) v_u_30, (copy) v_u_28, (copy) v_u_31, (copy) v_u_32, (copy) v_u_40, (copy) v_u_41, (copy) v_u_19
	if tick() - v_u_47 >= 0.35 then
		v_u_47 = tick()
		if v_u_43 then
			v_u_43 = false
			v_u_9:Close("Enchant")
			v_u_44 = nil
			v_u_45 = nil
			v_u_29.Visible = true
			v_u_30.Visible = false
			v_u_28.Visible = false
			v_u_31.Visible = false
			v_u_32.Visible = false
			v_u_40.Visible = false
			v_u_41.Visible = true
			v_u_19.Visible = false
		end
	else
		return
	end
end)
v_u_29.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_47, (copy) v_u_19, (copy) v_u_81, (copy) v_u_22
	if tick() - v_u_47 >= 0.35 then
		v_u_47 = tick()
		v_u_19.Visible = not v_u_19.Visible
		if v_u_19.Visible then
			v_u_81(v_u_22.Text)
		end
	end
end)
v_u_30.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_47, (ref) v_u_44, (ref) v_u_45, (copy) v_u_29, (copy) v_u_30, (copy) v_u_28, (copy) v_u_31, (copy) v_u_32, (copy) v_u_40, (copy) v_u_41
	if tick() - v_u_47 >= 0.35 then
		v_u_47 = tick()
		v_u_44 = nil
		v_u_45 = nil
		v_u_29.Visible = true
		v_u_30.Visible = false
		v_u_28.Visible = false
		v_u_31.Visible = false
		v_u_32.Visible = false
		v_u_40.Visible = false
		v_u_41.Visible = true
	end
end)
v_u_40.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_121
	v_u_121()
end)
v_u_41.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_121
	v_u_121()
end)
v_u_22:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (ref) v_u_43, (copy) v_u_19, (copy) v_u_81, (copy) v_u_22
	if v_u_43 and v_u_19.Visible then
		v_u_81(v_u_22.Text)
	end
end)
v15.OnClientEvent:Connect(function()
	-- upvalues: (ref) v_u_43, (copy) v_u_9, (ref) v_u_44, (ref) v_u_45, (copy) v_u_29, (copy) v_u_30, (copy) v_u_28, (copy) v_u_31, (copy) v_u_32, (copy) v_u_40, (copy) v_u_41, (copy) v_u_19, (copy) v_u_81
	if v_u_43 then
		if v_u_43 then
			v_u_43 = false
			v_u_9:Close("Enchant")
			v_u_44 = nil
			v_u_45 = nil
			v_u_29.Visible = true
			v_u_30.Visible = false
			v_u_28.Visible = false
			v_u_31.Visible = false
			v_u_32.Visible = false
			v_u_40.Visible = false
			v_u_41.Visible = true
			v_u_19.Visible = false
		end
	elseif v_u_43 then
		return
	elseif not v_u_9:IsOnCooldown() then
		v_u_43 = true
		v_u_9:Open("Enchant")
		v_u_44 = nil
		v_u_45 = nil
		v_u_29.Visible = true
		v_u_30.Visible = false
		v_u_28.Visible = false
		v_u_31.Visible = false
		v_u_32.Visible = false
		v_u_40.Visible = false
		v_u_41.Visible = true
		v_u_81("")
	end
end)
task.spawn(function()
	-- upvalues: (copy) v_u_9, (copy) v_u_16, (ref) v_u_43
	task.wait(0.1)
	v_u_9:Register("Enchant", v_u_16, {
		["onClose"] = function()
			-- upvalues: (ref) v_u_43
			v_u_43 = false
		end
	})
end)
task.spawn(function()
	-- upvalues: (copy) v_u_10
	task.wait(1)
	local v133 = v_u_10:FindFirstChild("RequestInventory")
	if v133 then
		v133:FireServer()
	end
end)