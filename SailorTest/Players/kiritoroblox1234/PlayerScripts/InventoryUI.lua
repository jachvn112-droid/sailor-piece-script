local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer
local v4 = v3:WaitForChild("PlayerGui")
local v5 = v2:WaitForChild("Modules")
local v_u_6 = require(v5:WaitForChild("ItemRarityConfig"))
local v_u_7 = require(v5:WaitForChild("NotificationService"))
local v_u_8 = require(v5:WaitForChild("ItemImageConfig"))
local v_u_9 = require(v5:WaitForChild("UIManager"))
require(v5:WaitForChild("RuneConfig"))
require(v5:WaitForChild("AuraConfig"))
require(v5:WaitForChild("CosmeticConfig"))
require(v5:WaitForChild("CosmeticConfig"))
local v_u_10 = require(v5:WaitForChild("UsableItemConfig"))
local v_u_11 = v4:WaitForChild("InventoryPanelUI"):WaitForChild("MainFrame")
local v12 = v_u_11:WaitForChild("Frame")
local v13 = v12:WaitForChild("Content"):WaitForChild("Holder")
local v14 = v13:WaitForChild("Tabs")
local v_u_15 = v13:WaitForChild("StorageHolder"):WaitForChild("Storage")
local v_u_16 = v13:WaitForChild("SearchFrame"):WaitForChild("Search")
local v17 = v12:WaitForChild("Exit"):WaitForChild("CloseButton")
local v18 = v4:WaitForChild("BasicStatsCurrencyAndButtonsUI"):WaitForChild("MainFrame"):WaitForChild("UIButtons"):WaitForChild("InventoryButtonFrame"):WaitForChild("InventoryButton")
local v_u_19 = {
	["Secret"] = v_u_15:FindFirstChild("SlotSecretRarity"),
	["Mythical"] = v_u_15:FindFirstChild("SlotMythicalRarity"),
	["Legendary"] = v_u_15:FindFirstChild("SlotLegendaryRarity"),
	["Epic"] = v_u_15:FindFirstChild("SlotEpicRarity"),
	["Rare"] = v_u_15:FindFirstChild("SlotRareRarity"),
	["Uncommon"] = v_u_15:FindFirstChild("SlotUncommonRarity"),
	["Common"] = v_u_15:FindFirstChild("Slot")
}
for _, v20 in pairs(v_u_19) do
	if v20 then
		v20.Visible = false
	end
end
local v21 = v2:WaitForChild("Remotes")
local v22 = v21:WaitForChild("UpdateInventory")
local v_u_23 = v21:WaitForChild("RequestInventory")
local v_u_24 = v21:WaitForChild("GetEquipped")
local v_u_25 = v21:WaitForChild("EquipWeapon")
v21:WaitForChild("EquipAccessory")
local v_u_26 = v21:WaitForChild("EquipRune")
local v_u_27 = {}
local v28 = v21:FindFirstChild("SyncUntradeableItems") or v21:WaitForChild("SyncUntradeableItems", 5)
if v28 then
	v28.OnClientEvent:Connect(function(p29)
		-- upvalues: (ref) v_u_27, (copy) v_u_9
		v_u_27 = p29 or {}
		if currentTab == "Items" and v_u_9:IsOpen("Inventory") then
			updateStorage()
		end
	end)
end
task.delay(2, function()
	-- upvalues: (ref) v_u_27, (copy) v_u_23
	if next(v_u_27) == nil then
		v_u_23:FireServer()
	end
end)
local v_u_30 = "Items"
local v31 = "Items"
local v_u_32 = {
	["Items"] = {},
	["Melee"] = {},
	["Sword"] = {},
	["Power"] = {},
	["Accessories"] = {},
	["Runes"] = {},
	["Auras"] = {},
	["Cosmetics"] = {}
}
local v_u_33 = {
	["Melee"] = nil,
	["Sword"] = nil,
	["Power"] = nil,
	["AccessoryVisual"] = nil,
	["AccessoryStats"] = nil,
	["Rune"] = nil,
	["AuraVisual"] = nil,
	["AuraStats"] = nil,
	["CosmeticVisual"] = nil,
	["CosmeticStats"] = nil
}
local v_u_34 = 0
local v_u_35 = false
local v_u_36 = {
	["Melee"] = "Melee",
	["Sword"] = "Sword",
	["Power"] = "Power",
	["Accessories"] = "Accessory",
	["Runes"] = "Rune",
	["Auras"] = "Aura",
	["Cosmetics"] = "Cosmetic"
}
local v_u_37 = {
	["Items"] = v14:WaitForChild("ItemsTab"),
	["Melee"] = v14:WaitForChild("MeleeTab"),
	["Sword"] = v14:WaitForChild("SwordTab"),
	["Power"] = v14:WaitForChild("PowerTab"),
	["Accessories"] = v14:WaitForChild("AccessoryTab"),
	["Runes"] = v14:FindFirstChild("RuneTab"),
	["Auras"] = v14:FindFirstChild("AuraTab"),
	["Cosmetics"] = v14:FindFirstChild("CosmeticTab")
}
local function v_u_42()
	-- upvalues: (copy) v_u_37, (ref) v_u_30
	for v38, v39 in pairs(v_u_37) do
		local v40 = v39:FindFirstChild("ButonOn")
		local v41 = v39:FindFirstChild("ButtonOff")
		if v40 and v41 then
			v40.Visible = v38 == v_u_30
			v41.Visible = v38 ~= v_u_30
		end
	end
end
local function v_u_46()
	-- upvalues: (copy) v_u_15, (copy) v_u_19
	for _, v43 in pairs(v_u_15:GetChildren()) do
		if v43:IsA("ImageButton") then
			local v44 = false
			for _, v45 in pairs(v_u_19) do
				if v43 == v45 then
					v44 = true
					break
				end
			end
			if not v44 then
				v43:Destroy()
			end
		end
	end
end
local function v_u_54(p_u_47)
	-- upvalues: (ref) v_u_35, (ref) v_u_34, (copy) v_u_36, (ref) v_u_30, (copy) v_u_6, (ref) v_u_33, (copy) v_u_26, (copy) v_u_7, (copy) v_u_25
	local v48 = tick()
	local v49
	if v_u_35 then
		v49 = false
	else
		v49 = v48 - v_u_34 >= 0.5
	end
	if v49 then
		local v50 = v_u_36[v_u_30]
		if v50 then
			v_u_34 = tick()
			v_u_35 = true
			task.delay(0.5, function()
				-- upvalues: (ref) v_u_35
				v_u_35 = false
			end)
			if v_u_30 == "Accessories" then
				if _G.OpenAccessoryConfirm then
					_G.OpenAccessoryConfirm(p_u_47)
				end
				return
			elseif v_u_30 == "Auras" then
				if _G.OpenAuraConfirm then
					_G.OpenAuraConfirm(p_u_47)
				end
				return
			elseif v_u_30 == "Cosmetics" then
				if _G.OpenCosmeticConfirm then
					_G.OpenCosmeticConfirm(p_u_47)
				end
				return
			elseif v_u_30 == "Runes" then
				local v_u_51 = v_u_6:GetRarity(p_u_47)
				if v_u_33.Rune == p_u_47 then
					v_u_26:FireServer("Unequip", p_u_47)
					v_u_33.Rune = nil
					task.spawn(function()
						-- upvalues: (ref) v_u_7, (copy) p_u_47, (copy) v_u_51
						v_u_7:ShowUnequipped(p_u_47, v_u_51)
					end)
				else
					v_u_26:FireServer("Equip", p_u_47)
					v_u_33.Rune = p_u_47
					task.spawn(function()
						-- upvalues: (ref) v_u_7, (copy) p_u_47, (copy) v_u_51
						v_u_7:ShowEquipped(p_u_47, v_u_51)
					end)
				end
			elseif v_u_33[v50] == p_u_47 then
				v_u_25:FireServer("Unequip", p_u_47)
				v_u_33[v50] = nil
				local v_u_52 = v_u_6:GetRarity(p_u_47)
				task.spawn(function()
					-- upvalues: (ref) v_u_7, (copy) p_u_47, (copy) v_u_52
					v_u_7:ShowUnequipped(p_u_47, v_u_52)
				end)
			else
				v_u_25:FireServer("Equip", p_u_47)
				v_u_33[v50] = p_u_47
				local v_u_53 = v_u_6:GetRarity(p_u_47)
				task.spawn(function()
					-- upvalues: (ref) v_u_7, (copy) p_u_47, (copy) v_u_53
					v_u_7:ShowEquipped(p_u_47, v_u_53)
				end)
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_109()
	-- upvalues: (copy) v_u_46, (copy) v_u_32, (ref) v_u_30, (ref) v_u_27, (copy) v_u_16, (copy) v_u_36, (copy) v_u_6, (copy) v_u_19, (copy) v_u_8, (copy) v_u_54, (copy) v_u_10, (copy) v_u_15
	v_u_46()
	local v55 = v_u_32[v_u_30]
	if v55 then
		if v_u_30 == "Runes" then
			v55 = {}
			for v56, v57 in pairs(v55) do
				if type(v56) == "string" and type(v57) == "number" then
					table.insert(v55, {
						["name"] = v56,
						["quantity"] = v57
					})
				end
			end
		end
		if v_u_30 == "Auras" then
			v55 = {}
			for v58, v59 in pairs(v55) do
				if type(v58) == "string" and type(v59) == "number" then
					table.insert(v55, {
						["name"] = v58,
						["quantity"] = v59
					})
				end
			end
		end
		if v_u_30 == "Accessories" then
			local v60 = {}
			local v61 = {}
			for _, v62 in pairs(v55) do
				local v63 = v62.name
				local v64 = v63:match("^(.-)%s*%[E(%d+)%]$")
				local v65
				if v64 then
					v65 = tonumber(v63:match("%[E(%d+)%]$")) or 0
				else
					v64 = v63
					v65 = nil
				end
				local v66 = v62.enchantLevel or (v65 or 0)
				if v60[v64] then
					v60[v64].quantity = (v60[v64].quantity or 1) + (v62.quantity or 1)
					if (v60[v64].enchantLevel or 0) < v66 then
						v60[v64].enchantLevel = v66
					end
				else
					v60[v64] = {
						["name"] = v64,
						["quantity"] = v62.quantity or 1,
						["image"] = v62.image,
						["enchantLevel"] = v66
					}
					table.insert(v61, v64)
				end
			end
			v55 = {}
			for _, v67 in ipairs(v61) do
				local v68 = v60[v67]
				table.insert(v55, v68)
			end
		end
		if v_u_30 == "Items" and next(v_u_27) then
			v55 = {}
			for _, v69 in pairs(v55) do
				local v70 = v_u_27[v69.name] or 0
				if v70 > 0 then
					local v71 = v69.quantity or 1
					local v72 = math.min(v70, v71)
					local v73 = v71 - v72
					if v73 > 0 then
						local v74 = {
							["name"] = v69.name,
							["quantity"] = v73,
							["image"] = v69.image
						}
						table.insert(v55, v74)
					end
					local v75 = math.min(v72, v71)
					if v75 > 0 then
						local v76 = {
							["name"] = v69.name,
							["displayName"] = v69.name .. " (UNTRADEABLE)",
							["quantity"] = v75,
							["image"] = v69.image,
							["isUntradeable"] = true
						}
						table.insert(v55, v76)
					end
				else
					table.insert(v55, v69)
				end
			end
		end
		local v77 = v_u_16.Text:lower()
		local v78 = v_u_36[v_u_30]
		local v79 = {}
		for _, v80 in pairs(v55) do
			v79[#v79 + 1] = v80
		end
		v_u_6:SortByRarity(v79)
		for _, v81 in pairs(v79) do
			local v82 = (v81.displayName or v81.name):lower()
			if v77 == "" or v82:find(v77, 1, true) then
				local v83 = (v_u_19[v_u_6:GetRarity(v81.name)] or v_u_19.Common):Clone()
				v83.Visible = true
				v83.Name = "Item_" .. (v81.displayName or v81.name)
				local v84 = v83:FindFirstChild("Slot")
				local v85 = v84 and v84:FindFirstChild("Holder")
				if v85 then
					local v86 = v85:FindFirstChild("ItemName")
					if v86 then
						local v87 = v81.displayName or v81.name
						if v_u_30 == "Accessories" and (v81.enchantLevel and v81.enchantLevel > 0) then
							v87 = v81.name .. " [E" .. v81.enchantLevel .. "]"
						end
						if (v_u_30 == "Melee" or v_u_30 == "Sword") and (v81.blessingLevel and v81.blessingLevel > 0) then
							v87 = v81.name .. " [B" .. v81.blessingLevel .. "]"
						end
						v86.Text = v87
					end
					local v88 = v85:FindFirstChild("Quantity")
					if v88 then
						if (v81.quantity or 1) > 1 then
							v88.Text = "x" .. (v81.quantity or 1)
							v88.Visible = true
						else
							v88.Visible = false
						end
					end
					local v89 = v85:FindFirstChild("Placeholder")
					if v89 then
						local v90 = v_u_8:GetImage(v81.name)
						local v91 = v81.name == "Secret Chest" and (not v90 or v90 == "rbxassetid://0") and "rbxassetid://96379129878428" or v90
						if v91 and (v91 ~= "rbxassetid://0" and v91 ~= "") then
							v89.Image = v91
							v89.Visible = true
						else
							v89.Visible = false
						end
					end
				end
				if v78 then
					local v_u_92 = v81.name
					v83.Activated:Connect(function()
						-- upvalues: (ref) v_u_54, (copy) v_u_92
						v_u_54(v_u_92)
					end)
				end
				if v_u_30 == "Items" then
					local v_u_93 = v81.name
					if v_u_10.IsShopProduct and v_u_10.IsShopProduct(v_u_93) then
						v83.Activated:Connect(function()
							-- upvalues: (copy) v_u_93
							if _G.OpenShopProductConfirm then
								_G.OpenShopProductConfirm(v_u_93)
							end
						end)
					elseif v_u_10.IsUsable(v_u_93) then
						v83.Activated:Connect(function()
							-- upvalues: (copy) v_u_93
							if _G.OpenUsableItemConfirm then
								_G.OpenUsableItemConfirm(v_u_93)
							else
								warn("[InventoryUI] _G.OpenUsableItemConfirm is nil!")
							end
						end)
					end
				end
				v83.Parent = v_u_15
			end
		end
		task.defer(function()
			-- upvalues: (ref) v_u_15
			local v94 = {}
			for _, v95 in ipairs(v_u_15:GetChildren()) do
				if (v95:IsA("ImageButton") or v95:IsA("TextButton")) and (v95.Visible and v95.Name:find("Item_")) then
					table.insert(v94, v95)
				end
			end
			if #v94 ~= 0 then
				task.wait()
				table.sort(v94, function(p96, p97)
					local v98 = p96.AbsolutePosition
					local v99 = p97.AbsolutePosition
					local v100 = v98.Y - v99.Y
					if math.abs(v100) < 20 then
						return v98.X < v99.X
					else
						return v98.Y < v99.Y
					end
				end)
				for v101, v102 in ipairs(v94) do
					v102.Selectable = true
					local v103 = v101 / 5
					local v104 = math.ceil(v103)
					if (v101 - 1) % 5 + 1 > 1 then
						v102.NextSelectionLeft = v94[v101 - 1]
					end
					local v105 = v101 + 1
					if v105 <= #v94 then
						local v106 = v105 / 5
						if math.ceil(v106) == v104 then
							v102.NextSelectionRight = v94[v105]
						end
					end
					local v107 = v101 - 5
					if v107 >= 1 then
						v102.NextSelectionUp = v94[v107]
					end
					local v108 = v101 + 5
					if v108 <= #v94 then
						v102.NextSelectionDown = v94[v108]
					end
				end
			end
		end)
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_9, (copy) v_u_11
	task.wait(0.1)
	v_u_9:Register("Inventory", v_u_11)
end)
local v_u_110 = v_u_33
local v_u_111 = v31
local v_u_112 = v_u_30
for v_u_113, v114 in pairs(v_u_37) do
	local v115 = v114:FindFirstChild("ButtonOff")
	if v115 then
		v115.Activated:Connect(function()
			-- upvalues: (copy) v_u_113, (ref) v_u_112, (ref) v_u_111, (copy) v_u_42, (copy) v_u_109
			local v116 = v_u_113
			if v_u_112 ~= v116 then
				v_u_112 = v116
				v_u_111 = v116
				v_u_42()
				v_u_109()
			end
		end)
	end
end
v17.Activated:Connect(function()
	-- upvalues: (copy) v_u_9
	v_u_9:Close("Inventory")
end)
v18.Activated:Connect(function()
	-- upvalues: (copy) v_u_9, (copy) v_u_23, (ref) v_u_111, (ref) v_u_112, (copy) v_u_42, (copy) v_u_109
	if not v_u_9:IsOnCooldown() then
		v_u_9:Toggle("Inventory")
		if v_u_9:IsOpen("Inventory") then
			v_u_23:FireServer()
			local v117 = v_u_111
			if v_u_112 == v117 then
				return
			end
			v_u_112 = v117
			v_u_111 = v117
			v_u_42()
			v_u_109()
		end
	end
end)
local v_u_118 = false
v_u_16:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (ref) v_u_118, (copy) v_u_9, (copy) v_u_109
	if not v_u_118 then
		v_u_118 = true
		task.delay(0.15, function()
			-- upvalues: (ref) v_u_118, (ref) v_u_9, (ref) v_u_109
			v_u_118 = false
			if v_u_9:IsOpen("Inventory") then
				v_u_109()
			end
		end)
	end
end)
v22.OnClientEvent:Connect(function(p119, p120)
	-- upvalues: (copy) v_u_32, (ref) v_u_112, (copy) v_u_9, (copy) v_u_109
	v_u_32[p119] = p120
	if v_u_112 == p119 and v_u_9:IsOpen("Inventory") then
		v_u_109()
	end
end)
local function v_u_123()
	-- upvalues: (copy) v_u_24, (ref) v_u_110
	local v121, v122 = pcall(function()
		-- upvalues: (ref) v_u_24
		return v_u_24:InvokeServer()
	end)
	if v121 and v122 then
		v_u_110 = {
			["Melee"] = v122.Melee,
			["Sword"] = v122.Sword,
			["Power"] = v122.Power,
			["AccessoryVisual"] = v122.AccessoryVisual,
			["AccessoryStats"] = v122.AccessoryStats,
			["Rune"] = v122.Rune or v_u_110.Rune,
			["AuraVisual"] = v122.AuraVisual or v_u_110.AuraVisual,
			["AuraStats"] = v122.AuraStats or v_u_110.AuraStats,
			["CosmeticVisual"] = v122.CosmeticVisual or v_u_110.CosmeticVisual,
			["CosmeticStats"] = v122.CosmeticStats or v_u_110.CosmeticStats
		}
	else
		v_u_110 = {
			["Melee"] = nil,
			["Sword"] = nil,
			["Power"] = nil,
			["AccessoryVisual"] = nil,
			["AccessoryStats"] = nil,
			["Rune"] = nil,
			["AuraVisual"] = nil,
			["AuraStats"] = nil,
			["CosmeticVisual"] = nil,
			["CosmeticStats"] = nil
		}
	end
end
v3.CharacterAdded:Connect(function()
	-- upvalues: (ref) v_u_110, (copy) v_u_123
	v_u_110 = {
		["Melee"] = nil,
		["Sword"] = nil,
		["Power"] = nil,
		["AccessoryVisual"] = nil,
		["AccessoryStats"] = nil,
		["Rune"] = nil,
		["AuraVisual"] = nil,
		["AuraStats"] = nil,
		["CosmeticVisual"] = nil,
		["CosmeticStats"] = nil
	}
	task.delay(1, v_u_123)
end)
v_u_11.Visible = false
v_u_42()
task.delay(1, v_u_123)