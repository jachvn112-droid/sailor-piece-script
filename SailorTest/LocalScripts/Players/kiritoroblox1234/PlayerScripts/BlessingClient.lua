local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
if require(v2:WaitForChild("PlaceConfig")).IsDungeon() then
	return
end
local v4 = v2:WaitForChild("Modules")
local v_u_5 = require(v4:WaitForChild("BlessingConfig"))
local v_u_6 = require(v4:WaitForChild("ItemRarityConfig"))
local v_u_7 = require(v4:WaitForChild("ItemImageConfig"))
local _ = require(v4:WaitForChild("WeaponClassification"))
local v_u_8 = require(v4:WaitForChild("NotificationService"))
local v_u_9 = require(v4:WaitForChild("UIManager"))
local v_u_10 = v3:WaitForChild("BlessingUI"):WaitForChild("MainFrame")
local v11 = v_u_10:WaitForChild("Frame")
local v12 = v11:WaitForChild("Content")
local v_u_13 = v12:WaitForChild("PopupHolder"):WaitForChild("InventoryPopup")
local v_u_14 = v_u_13:WaitForChild("Content"):WaitForChild("MeleeAndSwordInventory")
local v_u_15 = v_u_13:WaitForChild("Content"):WaitForChild("Search"):WaitForChild("Search")
local v16 = v12:WaitForChild("ItemsHolder")
local v17 = v16:WaitForChild("Holder")
local v18 = v17:WaitForChild("Item1")
local v_u_19 = v17:WaitForChild("Item2")
local v_u_20 = v18:WaitForChild("AccessorySlot")
local v_u_21 = v18:WaitForChild("AddAccessory")
local v_u_22 = v_u_19:WaitForChild("Slot")
local v_u_23 = v16:WaitForChild("AbleToEnchant")
local v_u_24 = v16:WaitForChild("UnAbleToEnchant")
local v_u_25 = v_u_23:WaitForChild("ToolTip"):WaitForChild("ScrollingFrame")
local v_u_26 = v_u_25:WaitForChild("PreviewStatFrame")
local v_u_27 = v_u_24:WaitForChild("ToolTip"):WaitForChild("Holder"):WaitForChild("Holder")
local v_u_28 = v_u_27:WaitForChild("RequirementComplete")
local v_u_29 = v_u_27:WaitForChild("RequirementIncomplete")
local v30 = v12:WaitForChild("EnchantButton")
local v_u_31 = v30:WaitForChild("On")
local v_u_32 = v30:WaitForChild("Off")
local v_u_33 = v30:WaitForChild("Txt")
local v34 = v11:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
v11:WaitForChild("Header"):WaitForChild("HeaderLayer"):WaitForChild("HeaderTxt")
local v_u_35 = {}
for _, v36 in ipairs(v_u_14:GetChildren()) do
	if v36:IsA("ImageButton") then
		v_u_35[v36.Name] = v36
		v36.Visible = false
	end
end
local v_u_37 = v2:WaitForChild("Remotes")
local v_u_38 = v_u_37:WaitForChild("BlessWeapon")
local v_u_39 = v_u_37:WaitForChild("GetBlessingData")
local v40 = v_u_37:WaitForChild("BlessingResult")
local v41 = v_u_37:WaitForChild("OpenBlessingUI")
local v42 = v_u_37:WaitForChild("UpdateInventory")
local v_u_43 = false
local v_u_44 = nil
local v_u_45 = nil
local v_u_46 = nil
local v_u_47 = {
	["Melee"] = {},
	["Sword"] = {}
}
local v_u_48 = 0
local v_u_49 = {
	["Common"] = Color3.fromRGB(255, 255, 255),
	["Uncommon"] = Color3.fromRGB(28, 190, 53),
	["Rare"] = Color3.fromRGB(60, 178, 229),
	["Epic"] = Color3.fromRGB(255, 0, 255),
	["Legendary"] = Color3.fromRGB(255, 202, 79),
	["Mythical"] = Color3.fromRGB(184, 0, 15)
}
local function v_u_51()
	-- upvalues: (copy) v_u_14, (copy) v_u_35
	for _, v50 in ipairs(v_u_14:GetChildren()) do
		if v50:IsA("ImageButton") and not v_u_35[v50.Name] then
			v50:Destroy()
		end
	end
end
local function v_u_53()
	-- upvalues: (copy) v_u_25, (copy) v_u_26
	for _, v52 in ipairs(v_u_25:GetChildren()) do
		if v52:IsA("Frame") and v52 ~= v_u_26 then
			v52:Destroy()
		end
	end
end
local function v_u_55()
	-- upvalues: (copy) v_u_27, (copy) v_u_28, (copy) v_u_29
	for _, v54 in ipairs(v_u_27:GetChildren()) do
		if v54:IsA("TextLabel") and (v54 ~= v_u_28 and v54 ~= v_u_29) then
			v54:Destroy()
		end
	end
end
local function v_u_72(p56, p57, p58, p59)
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_49
	local v60 = p56:FindFirstChild("Slot")
	if v60 then
		local v61 = v60:FindFirstChild("Holder")
		if v61 then
			local v62 = v61:FindFirstChild("ItemName")
			if v62 then
				local v63
				if p58 and p58 > 0 then
					v63 = p57 .. " [B" .. p58 .. "]"
				else
					v63 = p57
				end
				v62.Text = v63
			end
			local v64 = v61:FindFirstChild("Quantity")
			if v64 then
				v64.Text = "x" .. tostring(p59 or 1)
				v64.Visible = (p59 or 1) > 1
			end
			local v65 = not (v_u_7 and v_u_7.GetImage) and "rbxassetid://0" or v_u_7:GetImage(p57)
			local v66 = v61:FindFirstChild("Placeholder")
			if v66 then
				v66.Image = v65
				v66.Visible = true
			end
			local v67 = v61:FindFirstChild("WeaponIcon")
			if v67 then
				v67.Image = v65
				v67.Visible = true
			end
			local v68 = v_u_49[v_u_6:GetRarity(p57)] or v_u_49.Common
			local v69 = p56:FindFirstChild("Glows")
			if v69 then
				v69.ImageColor3 = v68
			end
			local v70 = p56:FindFirstChild("Slot")
			local v71 = v70 and v70:FindFirstChild("Inline")
			if v71 then
				v71.Color = v68
			end
		end
	else
		return
	end
end
local function v_u_86()
	-- upvalues: (copy) v_u_51, (copy) v_u_15, (copy) v_u_47, (copy) v_u_6, (copy) v_u_5, (copy) v_u_35, (copy) v_u_72, (ref) v_u_48, (copy) v_u_14
	v_u_51()
	local v73 = v_u_15.Text:lower()
	local v74 = {}
	for _, v75 in pairs(v_u_47.Melee or {}) do
		v75.category = "Melee"
		table.insert(v74, v75)
	end
	for _, v76 in pairs(v_u_47.Sword or {}) do
		v76.category = "Sword"
		table.insert(v74, v76)
	end
	v_u_6:SortByRarity(v74)
	for _, v_u_77 in ipairs(v74) do
		local v_u_78 = v_u_77.name
		local v79 = v_u_78:lower()
		if v73 == "" or v79:find(v73, 1, true) then
			local v80 = v_u_77.blessingLevel or 0
			if v_u_5:CanBeBlessed(v_u_78) and v80 < v_u_5.MaxBlessingLevel then
				local v81 = v_u_6:GetRarity(v_u_78)
				local v82 = v_u_35[v_u_6.SlotTemplates[v81] or "Slot"] or v_u_35.Slot
				if v82 then
					local v83 = v82:Clone()
					v83.Visible = true
					v83.Name = "Weapon_" .. v_u_78
					v_u_72(v83, v_u_78, v_u_77.blessingLevel, v_u_77.quantity)
					v83.MouseButton1Click:Connect(function()
						-- upvalues: (ref) v_u_48, (copy) v_u_78, (copy) v_u_77
						local v84 = tick()
						local v85
						if v84 - v_u_48 < 0.25 then
							v85 = false
						else
							v_u_48 = v84
							v85 = true
						end
						if v85 then
							selectWeapon(v_u_78, v_u_77.category)
						end
					end)
					v83.Parent = v_u_14
				end
			end
		end
	end
end
function selectWeapon(p87, p88)
	-- upvalues: (ref) v_u_44, (ref) v_u_45, (copy) v_u_21, (copy) v_u_20, (copy) v_u_19, (copy) v_u_7, (copy) v_u_47, (copy) v_u_72, (copy) v_u_5, (copy) v_u_22, (copy) v_u_13
	v_u_44 = p87
	v_u_45 = p88
	v_u_21.Visible = false
	v_u_20.Visible = true
	v_u_19.Visible = true
	local v89 = not (v_u_7 and v_u_7.GetImage) and "rbxassetid://0" or v_u_7:GetImage(p87)
	local v90 = 0
	for _, v91 in pairs(v_u_47[p88] or {}) do
		if v91.name == p87 then
			v90 = v91.blessingLevel or 0
			v_u_72(v_u_20, p87, v90, 1)
			break
		end
	end
	local v92 = v_u_20:FindFirstChild("Slot")
	if v92 then
		v92 = v92:FindFirstChild("Holder")
	end
	local v93 = v92 and v92:FindFirstChild("WeaponIcon")
	if v93 then
		v93.Image = v89
		v93.Visible = true
	end
	local v94 = v90 + 1
	if v94 <= v_u_5.MaxBlessingLevel then
		v_u_72(v_u_22, p87, v94, 1)
	else
		v_u_72(v_u_22, p87, v90, 1)
	end
	local v95 = v_u_22:FindFirstChild("Slot")
	if v95 then
		local v96 = v95:FindFirstChild("Holder")
		local v97 = v96 and v96:FindFirstChild("WeaponIcon")
		if v97 then
			v97.Image = v89
			v97.Visible = true
		end
	end
	v_u_13.Visible = false
	refreshBlessingData()
end
function refreshBlessingData()
	-- upvalues: (ref) v_u_44, (ref) v_u_46, (copy) v_u_39
	if v_u_44 then
		v_u_46 = v_u_39:InvokeServer(v_u_44)
		updateBlessingUI()
	end
end
function updateBlessingUI()
	-- upvalues: (ref) v_u_46, (copy) v_u_23, (copy) v_u_24, (copy) v_u_31, (copy) v_u_32, (copy) v_u_33, (copy) v_u_53, (copy) v_u_5, (ref) v_u_44
	if v_u_46 then
		if v_u_46.maxed then
			v_u_23.Visible = true
			v_u_24.Visible = false
			v_u_31.Visible = false
			v_u_32.Visible = true
			v_u_33.Text = "MAX LEVEL"
			v_u_53()
			local v98 = v_u_5:GetStatBonuses(v_u_44, v_u_46.currentLevel)
			showStatPreviews(v98, v98)
			return
		elseif v_u_46.canBless then
			v_u_23.Visible = true
			v_u_24.Visible = false
			v_u_31.Visible = true
			v_u_32.Visible = false
			v_u_33.Text = "BLESS"
			showStatPreviews(v_u_46.statPreview)
		else
			v_u_23.Visible = false
			v_u_24.Visible = true
			v_u_31.Visible = false
			v_u_32.Visible = true
			v_u_33.Text = "MISSING ITEMS"
			showRequirements(v_u_46.requirements)
		end
	else
		v_u_23.Visible = false
		v_u_24.Visible = false
		v_u_31.Visible = false
		v_u_32.Visible = true
		v_u_33.Text = "Select Weapon"
		return
	end
end
function showStatPreviews(p99, p100)
	-- upvalues: (copy) v_u_53, (copy) v_u_26, (copy) v_u_25
	v_u_53()
	v_u_26.Visible = false
	local v101 = {
		["Damage"] = "rbxassetid://7733912735",
		["CritChance"] = "rbxassetid://7733911683",
		["CritDamage"] = "rbxassetid://7733911683"
	}
	local v102 = {
		["Damage"] = "DMG",
		["CritChance"] = "Crit C.",
		["CritDamage"] = "Crit D."
	}
	for _, v103 in ipairs({ "Damage", "CritChance", "CritDamage" }) do
		local v104 = p99[v103]
		if v104 then
			local v105 = v_u_26:Clone()
			v105.Visible = true
			v105.Name = "Stat_" .. v103
			local v106 = v105:FindFirstChild("Icon")
			if v106 then
				v106.Image = v101[v103] or ""
			end
			local v107 = v105:FindFirstChild("NameOfTheStat")
			if v107 then
				v107.Text = v102[v103] or v103
			end
			local v108 = v105:FindFirstChild("CurrentStat")
			if v108 then
				local v109 = v104.current or 0
				local v110 = string.format
				local v111 = v109 + 0.5
				v108.Text = v110("%d%%", (math.floor(v111)))
			end
			local v112 = v105:FindFirstChild("StatAfterTheBless")
			if v112 then
				if p100 then
					local v113 = v104.next or (v104.current or 0)
					local v114 = string.format
					local v115 = v113 + 0.5
					v112.Text = v114("%d%%", (math.floor(v115)))
				else
					local v116 = v104.next or 0
					local v117 = string.format
					local v118 = v116 + 0.5
					v112.Text = v117("%d%%", (math.floor(v118)))
				end
			end
			local v119 = v105:FindFirstChild("TheAmountGainedByBless")
			if v119 then
				local v120 = v104.gain or 0
				if v120 > 0 then
					local v121 = string.format
					local v122 = v120 + 0.5
					v119.Text = "+" .. v121("%d%%", (math.floor(v122)))
					v119.TextColor3 = Color3.fromRGB(0, 255, 100)
				else
					v119.Text = "+0.00%"
					v119.TextColor3 = Color3.fromRGB(200, 200, 200)
				end
			end
			v105.Parent = v_u_25
		end
	end
end
function showRequirements(p123)
	-- upvalues: (copy) v_u_55, (copy) v_u_28, (copy) v_u_29, (copy) v_u_27
	v_u_55()
	v_u_28.Visible = false
	v_u_29.Visible = false
	for _, v124 in ipairs(p123 or {}) do
		local v125 = (v124.complete and v_u_28 or v_u_29):Clone()
		v125.Visible = true
		v125.Name = "Req_" .. v124.name
		v125.Text = v124.name .. " (" .. v124.have .. "/" .. v124.need .. ")"
		v125.Parent = v_u_27
	end
end
local function v_u_132()
	-- upvalues: (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (copy) v_u_21, (copy) v_u_20, (copy) v_u_19, (copy) v_u_13, (copy) v_u_23, (copy) v_u_24, (copy) v_u_31, (copy) v_u_32, (copy) v_u_33, (copy) v_u_22, (copy) v_u_53, (copy) v_u_55, (copy) v_u_15, (copy) v_u_86
	v_u_44 = nil
	v_u_45 = nil
	v_u_46 = nil
	v_u_21.Visible = true
	v_u_20.Visible = false
	v_u_19.Visible = false
	v_u_13.Visible = true
	v_u_23.Visible = false
	v_u_24.Visible = false
	v_u_31.Visible = false
	v_u_32.Visible = true
	v_u_33.Text = "Select Weapon"
	local v126 = v_u_20:FindFirstChild("Slot")
	if v126 then
		v126 = v126:FindFirstChild("Holder")
	end
	local v127 = v126 and v126:FindFirstChild("WeaponIcon")
	if v127 then
		v127.Image = ""
		v127.Visible = false
	end
	local v128 = v_u_22:FindFirstChild("Slot"):FindFirstChild("Holder")
	if v128 then
		local v129 = v128:FindFirstChild("ItemName")
		if v129 then
			v129.Text = "?"
		end
		local v130 = v128:FindFirstChild("Placeholder")
		if v130 then
			v130.Image = ""
		end
		local v131 = v128:FindFirstChild("WeaponIcon")
		if v131 then
			v131.Image = ""
			v131.Visible = false
		end
	end
	v_u_53()
	v_u_55()
	v_u_15.Text = ""
	v_u_86()
end
local function v133()
	-- upvalues: (ref) v_u_43, (copy) v_u_9, (copy) v_u_10, (copy) v_u_132
	if not v_u_43 then
		v_u_43 = true
		v_u_9:Open("Blessing")
		v_u_10.Visible = true
		v_u_132()
	end
end
local function v136()
	-- upvalues: (ref) v_u_48, (ref) v_u_44, (ref) v_u_46, (copy) v_u_38
	local v134 = tick()
	local v135
	if v134 - v_u_48 < 0.25 then
		v135 = false
	else
		v_u_48 = v134
		v135 = true
	end
	if v135 then
		if v_u_44 then
			if v_u_46 then
				if v_u_46.maxed then
					return
				elseif v_u_46.canBless then
					v_u_38:FireServer(v_u_44)
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
v40.OnClientEvent:Connect(function(p137)
	-- upvalues: (copy) v_u_6, (ref) v_u_44, (copy) v_u_8, (ref) v_u_45, (copy) v_u_72, (copy) v_u_20, (copy) v_u_5, (copy) v_u_22
	if p137.success then
		v_u_6:GetRarity(v_u_44)
		v_u_8:Show("Quest", {
			["message"] = "Blessing successful! " .. v_u_44 .. " is now B" .. p137.data.newLevel
		})
		task.wait(0.3)
		refreshBlessingData()
		if v_u_44 and v_u_45 then
			local v138 = p137.data.newLevel
			v_u_72(v_u_20, v_u_44, v138, 1)
			local v139 = v138 + 1
			if v139 <= v_u_5.MaxBlessingLevel then
				v_u_72(v_u_22, v_u_44, v139, 1)
			else
				v_u_72(v_u_22, v_u_44, v138, 1)
			end
		end
	else
		v_u_8:ShowError(p137.message or "Blessing failed!")
		task.wait(0.3)
		refreshBlessingData()
	end
end)
v42.OnClientEvent:Connect(function(p140, p141)
	-- upvalues: (copy) v_u_47, (ref) v_u_43, (copy) v_u_86
	if p140 == "Melee" or p140 == "Sword" then
		v_u_47[p140] = p141
		if v_u_43 then
			v_u_86()
		end
	end
end)
v34.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_48, (ref) v_u_43, (copy) v_u_9, (copy) v_u_10
	local v142 = tick()
	local v143
	if v142 - v_u_48 < 0.25 then
		v143 = false
	else
		v_u_48 = v142
		v143 = true
	end
	if v143 then
		if not v_u_43 then
			return
		end
		v_u_43 = false
		v_u_9:Close("Blessing")
		v_u_10.Visible = false
	end
end)
v_u_21.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_48, (copy) v_u_13, (copy) v_u_86
	local v144 = tick()
	local v145
	if v144 - v_u_48 < 0.25 then
		v145 = false
	else
		v_u_48 = v144
		v145 = true
	end
	if v145 then
		v_u_13.Visible = not v_u_13.Visible
		if v_u_13.Visible then
			v_u_86()
		end
	end
end)
local function v148()
	-- upvalues: (ref) v_u_48, (copy) v_u_13, (copy) v_u_86
	local v146 = tick()
	local v147
	if v146 - v_u_48 < 0.25 then
		v147 = false
	else
		v_u_48 = v146
		v147 = true
	end
	if v147 then
		v_u_13.Visible = not v_u_13.Visible
		if v_u_13.Visible then
			v_u_86()
		end
	end
end
v_u_20.MouseButton1Click:Connect(v148)
local v149 = v_u_20:FindFirstChild("Slot")
if v149 and v149:IsA("GuiButton") then
	v149.MouseButton1Click:Connect(v148)
end
v_u_31.MouseButton1Click:Connect(v136)
v_u_32.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_48, (ref) v_u_44, (copy) v_u_13
	local v150 = tick()
	local v151
	if v150 - v_u_48 < 0.25 then
		v151 = false
	else
		v_u_48 = v150
		v151 = true
	end
	if v151 then
		if not v_u_44 then
			v_u_13.Visible = true
		end
	end
end)
v_u_15:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (ref) v_u_43, (copy) v_u_86
	if v_u_43 then
		v_u_86()
	end
end)
local v152 = v_u_13:FindFirstChild("CloseButtonFrame")
if v152 then
	v152 = v152:FindFirstChild("CloseButton")
end
local v153 = v152 or v_u_13:FindFirstChild("CloseButton")
if not v153 then
	local v154 = v_u_13:FindFirstChild("Content")
	if v154 then
		local v155 = v154:FindFirstChild("CloseButtonFrame")
		if v155 then
			v153 = v155:FindFirstChild("CloseButton")
		end
	end
end
local v_u_156, v_u_157
if v153 then
	v_u_156 = v_u_43
	v_u_157 = v_u_48
else
	v_u_156 = v_u_43
	v_u_157 = v_u_48
	for _, v158 in ipairs(v_u_13:GetDescendants()) do
		if v158:IsA("GuiButton") and (v158.Name == "CloseButton" or (v158.Name == "Close" or v158.Name == "X")) then
			v153 = v158
			break
		end
	end
end
if v153 then
	v153.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_157, (copy) v_u_13
		local v159 = tick()
		local v160
		if v159 - v_u_157 < 0.25 then
			v160 = false
		else
			v_u_157 = v159
			v160 = true
		end
		if v160 then
			v_u_13.Visible = false
		end
	end)
end
v41.OnClientEvent:Connect(v133)
v_u_10.Visible = false
v_u_26.Visible = false
v_u_28.Visible = false
v_u_29.Visible = false
task.spawn(function()
	-- upvalues: (copy) v_u_37
	task.wait(1)
	local v161 = v_u_37:FindFirstChild("RequestInventory")
	if v161 then
		v161:FireServer()
	end
end)
task.defer(function()
	-- upvalues: (copy) v_u_10, (copy) v_u_9, (ref) v_u_156
	if v_u_10 then
		v_u_9:Register("Blessing", v_u_10, {
			["onClose"] = function()
				-- upvalues: (ref) v_u_156
				v_u_156 = false
			end
		})
	end
end)