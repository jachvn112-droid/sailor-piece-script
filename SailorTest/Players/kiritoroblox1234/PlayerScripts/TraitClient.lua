local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = v1.LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui")
local v_u_6 = require(v2:WaitForChild("Modules"):WaitForChild("TraitConfig"))
local v_u_7 = require(v2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v_u_8 = require(v2:WaitForChild("Modules"):WaitForChild("NotificationService"))
local v9 = v2:WaitForChild("RemoteEvents")
local v_u_10 = v9:WaitForChild("TraitReroll")
local v_u_11 = v9:WaitForChild("TraitConfirm")
local v_u_12 = v9:WaitForChild("TraitUpdateFilters")
local v_u_13 = v9:WaitForChild("TraitUpdateAutoSkip")
local v_u_14 = v9:WaitForChild("TraitGetData")
local v15 = v9:WaitForChild("TraitDataUpdate")
local v_u_16 = v9:WaitForChild("OpenTraitUI")
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = {}
local v_u_44 = {
	["Epic"] = false,
	["Legendary"] = false,
	["Mythical"] = false,
	["Secret"] = false
}
local v_u_45 = nil
local v_u_46 = nil
local v_u_47 = false
local v_u_48 = false
local v_u_49 = {}
local function v_u_59()
	-- upvalues: (ref) v_u_17, (copy) v_u_5, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (ref) v_u_21, (ref) v_u_22, (ref) v_u_23, (ref) v_u_38, (ref) v_u_39, (ref) v_u_24, (ref) v_u_25, (ref) v_u_28, (ref) v_u_29, (ref) v_u_30, (ref) v_u_31, (ref) v_u_32, (ref) v_u_33, (ref) v_u_34, (ref) v_u_35, (ref) v_u_36, (ref) v_u_27, (ref) v_u_37, (ref) v_u_26, (ref) v_u_40, (ref) v_u_41, (copy) v_u_7, (ref) v_u_45
	if v_u_17 then
		return true
	end
	v_u_17 = v_u_5:WaitForChild("TraitRerollUI", 5)
	if not v_u_17 then
		return false
	end
	v_u_18 = v_u_17:WaitForChild("MainFrame")
	local v50 = v_u_18:WaitForChild("Frame")
	v_u_19 = v50:WaitForChild("Content")
	v_u_20 = v_u_19:WaitForChild("TraitPage")
	v_u_21 = v_u_19:WaitForChild("FiltersPage")
	v_u_22 = v_u_19:WaitForChild("AreYouSureYouWantToRerollFrame")
	local v51 = v_u_20:WaitForChild("Buttons")
	local v52 = v51:WaitForChild("RerollButtonHolder")
	v_u_23 = v52:WaitForChild("RerollButton")
	local v53 = v52:FindFirstChild("AutoReroll")
	if v53 then
		local v54 = v53:FindFirstChild("Holder")
		v_u_38 = v54 and v54:FindFirstChild("Checkmark")
		if v_u_38 then
			v_u_39 = v_u_38:FindFirstChild("Icon")
		end
	end
	v_u_24 = v51:WaitForChild("IndexButton")
	v_u_25 = v51:WaitForChild("FiltersButton")
	v_u_28 = v_u_20:WaitForChild("TraitGottenFrame")
	v_u_29 = v_u_20:WaitForChild("TraitIndex")
	v_u_30 = v_u_20:WaitForChild("PityFrame")
	v_u_31 = v_u_20:WaitForChild("AmountOfTraitRerollYouHaveFrame")
	v_u_32 = v_u_30:FindFirstChild("PityHolder")
	v_u_33 = v_u_30:FindFirstChild("PityHolderSecretRarity")
	v_u_34 = v_u_30:FindFirstChild("TxtMythicalRarityPity")
	v_u_35 = v_u_30:FindFirstChild("TxtSecretRarityPity")
	local v55 = v_u_20:WaitForChild("AutoSkip"):WaitForChild("Buttons")
	v_u_36 = {
		["Epic"] = v55:FindFirstChild("EpicRarity"),
		["Legendary"] = v55:FindFirstChild("LegendaryRarity"),
		["Mythical"] = v55:FindFirstChild("MythicalRarity"),
		["Secret"] = v55:FindFirstChild("SecretRarity")
	}
	v_u_27 = v_u_21:WaitForChild("BackButton")
	local v56 = v_u_21:WaitForChild("Filters")
	v_u_37 = {}
	for _, v57 in ipairs(v56:GetChildren()) do
		if v57:IsA("ImageButton") and v57.Name:find("Filter") then
			v_u_37[v57.Name:gsub("Filter", "")] = v57
		end
	end
	v_u_26 = v50:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
	local v58 = v_u_22:WaitForChild("Buttons")
	v_u_40 = v58:WaitForChild("Accept")
	v_u_41 = v58:WaitForChild("Cancel")
	v_u_7:Register("Trait", v_u_18, {
		["onOpen"] = function()
			-- upvalues: (ref) v_u_20, (ref) v_u_21, (ref) v_u_29, (ref) v_u_22
			v_u_20.Visible = true
			v_u_21.Visible = false
			v_u_29.Visible = false
			v_u_22.Visible = false
		end,
		["onClose"] = function()
			-- upvalues: (ref) v_u_45
			v_u_45 = nil
			if stopAutoReroll then
				stopAutoReroll()
			end
		end
	})
	return true
end
local function v_u_78(p60, p61, p62, p63, p64)
	-- upvalues: (ref) v_u_30, (ref) v_u_47, (ref) v_u_32, (ref) v_u_33, (ref) v_u_34, (ref) v_u_35, (copy) v_u_3
	if v_u_30 then
		v_u_47 = p64 or v_u_47
		if v_u_32 then
			v_u_32.Visible = not v_u_47
		end
		if v_u_33 then
			v_u_33.Visible = v_u_47
		end
		if v_u_34 then
			v_u_34.Visible = not v_u_47
		end
		if v_u_35 then
			v_u_35.Visible = v_u_47
		end
		local v65 = v_u_30:FindFirstChild("PityLabel")
		if v_u_47 then
			local v66 = p62 or 0
			local v67 = p63 or 2500
			if v65 then
				v65.Text = v66 .. "/" .. v67
			end
			local v68 = v_u_33 and v_u_33:FindFirstChild("LoaderSecretRarity")
			if v68 then
				local v69 = v66 / v67
				local v70 = math.clamp(v69, 0, 1)
				v_u_3:Create(v68, TweenInfo.new(0.3), {
					["Size"] = UDim2.new(v70, 0, 1, 0)
				}):Play()
				local v71 = v68:FindFirstChild("Secret")
				if v71 then
					v71.Enabled = true
					return
				end
			end
		else
			local v72 = p60 or 0
			local v73 = p61 or 400
			if v65 then
				v65.Text = v72 .. "/" .. v73
			end
			local v74 = v_u_32 and v_u_32:FindFirstChild("Loader")
			if v74 then
				local v75 = v72 / v73
				local v76 = math.clamp(v75, 0, 1)
				v_u_3:Create(v74, TweenInfo.new(0.3), {
					["Size"] = UDim2.new(v76, 0, 1, 0)
				}):Play()
				local v77 = v74:FindFirstChild("Mythical")
				if v77 then
					v77.Enabled = true
				end
			end
		end
	end
end
local function v_u_84(p79, p80)
	for _, v81 in ipairs(p79:GetChildren()) do
		if v81:IsA("UIGradient") then
			v81.Enabled = false
		end
	end
	local v82 = p79:FindFirstChild(p80)
	if v82 and v82:IsA("UIGradient") then
		v82.Enabled = true
		return v82
	else
		if p80 == "Uncommon" then
			local v83 = p79:FindFirstChild("UnCommon")
			if v83 and v83:IsA("UIGradient") then
				v83.Enabled = true
				return v83
			end
		end
		return nil
	end
end
local function v_u_95(p85)
	-- upvalues: (ref) v_u_28, (copy) v_u_6, (copy) v_u_84
	if v_u_28 then
		local v86 = v_u_28:FindFirstChild("Holder")
		if v86 then
			local v87 = v86:FindFirstChild("Trait")
			if v87 then
				local v88 = v87:FindFirstChild("TraitGotten")
				if v88 then
					if p85 then
						local v89 = v_u_6.Traits[p85]
						v88.Text = p85
						if v89 then
							v_u_84(v88, v89.Rarity)
						end
						local v90 = v87:FindFirstChild("TraitColor")
						if v90 and v_u_84(v90, v89 and v89.Rarity or "Common") then
							return
						end
					else
						v88.Text = "None"
						v_u_84(v88, "Common")
						local v91 = v_u_28:FindFirstChild("Holder")
						if v91 then
							local v92 = v91:FindFirstChild("Trait")
							local v93 = v92 and v92:FindFirstChild("TraitColor")
							if v93 then
								for _, v94 in ipairs(v93:GetChildren()) do
									v94:IsA("UIGradient")
								end
							end
						end
					end
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
local function v_u_101()
	-- upvalues: (ref) v_u_36, (ref) v_u_44
	for v96, v97 in pairs(v_u_36) do
		if v97 then
			local v98 = v97:FindFirstChild("On")
			local v99 = v97:FindFirstChild("Off")
			if v98 and v99 then
				local v100 = v_u_44[v96] == true
				v98.Visible = v100
				v99.Visible = not v100
			end
		end
	end
end
local function v_u_104()
	-- upvalues: (ref) v_u_37, (ref) v_u_43
	for v102, v103 in pairs(v_u_37) do
		v103.BackgroundTransparency = table.find(v_u_43, v102) ~= nil and 0.95 or 0.8
	end
end
local function v_u_108()
	-- upvalues: (copy) v_u_59, (copy) v_u_7, (copy) v_u_14, (ref) v_u_42, (ref) v_u_43, (ref) v_u_44, (ref) v_u_46, (ref) v_u_47, (copy) v_u_95, (ref) v_u_31, (copy) v_u_78, (copy) v_u_101, (copy) v_u_104
	if v_u_59() then
		if not v_u_7:IsOpen("Trait") then
			v_u_7:Open("Trait")
			local v105 = v_u_14:InvokeServer()
			if v105 then
				v_u_42 = v105.Trait
				v_u_43 = v105.Filters or {}
				v_u_44 = v105.AutoSkip or {
					["Epic"] = false,
					["Legendary"] = false,
					["Mythical"] = false,
					["Secret"] = false
				}
				v_u_46 = v105.TraitConfig
				v_u_47 = v105.HasUnlockedSecretBar or false
				v_u_95(v_u_42)
				local v106 = v105.RerollCount
				local v107 = v_u_31 and v_u_31:FindFirstChild("CurrentTraitRerollYouHave")
				if v107 then
					v107.Text = tostring(v106 or 0) .. " Trait Rerolls"
				end
				v_u_78(v105.MythicPity or v105.Pity, v105.MaxMythicPity or v105.MaxPity, v105.SecretPity, v105.MaxSecretPity, v105.HasUnlockedSecretBar)
				v_u_101()
				v_u_104()
			end
		end
	else
		return
	end
end
local function v_u_112()
	-- upvalues: (ref) v_u_42, (copy) v_u_6, (ref) v_u_43, (ref) v_u_44
	if not v_u_42 then
		return false
	end
	local v109 = v_u_6.Traits[v_u_42]
	if not v109 then
		return false
	end
	for _, v110 in ipairs(v_u_43) do
		if v110 == v_u_42 then
			return true
		end
	end
	local v111 = v109.Rarity
	return v_u_6.ConfirmationRarities and (v_u_6.ConfirmationRarities[v111] and not v_u_44[v111]) and true or false
end
local function v_u_115()
	-- upvalues: (ref) v_u_48, (copy) v_u_112, (copy) v_u_8, (ref) v_u_42, (ref) v_u_39, (copy) v_u_10
	if v_u_48 then
		return
	elseif v_u_112() then
		v_u_8:Show("Quest", {
			["message"] = "Cannot Auto-Roll: " .. (v_u_42 or "Unknown") .. " is protected!"
		})
	else
		v_u_48 = true
		if v_u_39 then
			v_u_39.Visible = v_u_48
		end
		task.spawn(function()
			-- upvalues: (ref) v_u_48, (ref) v_u_112, (ref) v_u_8, (ref) v_u_42, (ref) v_u_39, (ref) v_u_10
			while v_u_48 do
				if v_u_112() then
					local v113 = v_u_8
					local v114 = {
						["message"] = "Auto-Roll stopped: Got " .. (v_u_42 or "Unknown") .. "!"
					}
					v113:Show("Quest", v114)
					v_u_48 = false
					if v_u_39 then
						v_u_39.Visible = v_u_48
						return
					end
					break
				end
				v_u_10:FireServer()
				task.wait(0.1)
			end
		end)
	end
end
function toggleAutoReroll()
	-- upvalues: (ref) v_u_48, (ref) v_u_39, (copy) v_u_115
	if v_u_48 then
		v_u_48 = false
		if v_u_39 then
			v_u_39.Visible = v_u_48
			return
		end
	else
		v_u_115()
	end
end
local function v_u_150()
	-- upvalues: (copy) v_u_59, (ref) v_u_23, (copy) v_u_49, (copy) v_u_10, (ref) v_u_38, (ref) v_u_24, (ref) v_u_29, (ref) v_u_25, (ref) v_u_20, (ref) v_u_21, (ref) v_u_27, (ref) v_u_26, (copy) v_u_7, (ref) v_u_40, (ref) v_u_45, (copy) v_u_11, (ref) v_u_22, (ref) v_u_41, (ref) v_u_36, (ref) v_u_44, (copy) v_u_101, (copy) v_u_13, (ref) v_u_37, (ref) v_u_43, (copy) v_u_104, (copy) v_u_12
	if v_u_59() then
		v_u_23.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_49, (ref) v_u_10
			local v116 = tick()
			local v117
			if v_u_49.Reroll and (0.1 or 0.5) > v116 - v_u_49.Reroll then
				v117 = false
			else
				v_u_49.Reroll = v116
				v117 = true
			end
			if v117 then
				v_u_10:FireServer()
			end
		end)
		if v_u_38 then
			v_u_38.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_49
				local v118 = tick()
				local v119
				if v_u_49.AutoReroll and (nil or 0.5) > v118 - v_u_49.AutoReroll then
					v119 = false
				else
					v_u_49.AutoReroll = v118
					v119 = true
				end
				if v119 then
					toggleAutoReroll()
				end
			end)
		end
		v_u_24.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_49, (ref) v_u_29
			local v120 = tick()
			local v121
			if v_u_49.Index and (nil or 0.5) > v120 - v_u_49.Index then
				v121 = false
			else
				v_u_49.Index = v120
				v121 = true
			end
			if v121 then
				v_u_29.Visible = not v_u_29.Visible
			end
		end)
		v_u_25.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_49, (ref) v_u_20, (ref) v_u_21
			local v122 = tick()
			local v123
			if v_u_49.Filters and (nil or 0.5) > v122 - v_u_49.Filters then
				v123 = false
			else
				v_u_49.Filters = v122
				v123 = true
			end
			if v123 then
				v_u_20.Visible = false
				v_u_21.Visible = true
			end
		end)
		v_u_27.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_49, (ref) v_u_21, (ref) v_u_20
			local v124 = tick()
			local v125
			if v_u_49.Back and (nil or 0.5) > v124 - v_u_49.Back then
				v125 = false
			else
				v_u_49.Back = v124
				v125 = true
			end
			if v125 then
				v_u_21.Visible = false
				v_u_20.Visible = true
			end
		end)
		v_u_26.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_49, (ref) v_u_7
			local v126 = tick()
			local v127
			if v_u_49.Close and (nil or 0.5) > v126 - v_u_49.Close then
				v127 = false
			else
				v_u_49.Close = v126
				v127 = true
			end
			if v127 then
				v_u_7:Close("Trait")
			end
		end)
		v_u_40.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_49, (ref) v_u_45, (ref) v_u_11, (ref) v_u_22
			local v128 = tick()
			local v129
			if v_u_49.Accept and (nil or 0.5) > v128 - v_u_49.Accept then
				v129 = false
			else
				v_u_49.Accept = v128
				v129 = true
			end
			if v129 then
				if v_u_45 then
					v_u_11:FireServer(true)
					v_u_45 = nil
				end
				if v_u_22 then
					v_u_22.Visible = false
				end
			else
				return
			end
		end)
		v_u_41.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_49, (ref) v_u_45, (ref) v_u_11, (ref) v_u_22
			local v130 = tick()
			local v131
			if v_u_49.Cancel and (nil or 0.5) > v130 - v_u_49.Cancel then
				v131 = false
			else
				v_u_49.Cancel = v130
				v131 = true
			end
			if v131 then
				if v_u_45 then
					v_u_11:FireServer(false)
					v_u_45 = nil
				end
				if v_u_22 then
					v_u_22.Visible = false
				end
			else
				return
			end
		end)
		for v_u_132, v133 in pairs(v_u_36) do
			if v133 then
				local v134 = v133:FindFirstChild("On")
				local v135 = v133:FindFirstChild("Off")
				if v134 then
					v134.MouseButton1Click:Connect(function()
						-- upvalues: (copy) v_u_132, (ref) v_u_49, (ref) v_u_44, (ref) v_u_101, (ref) v_u_13
						local v136 = "AutoSkip_" .. v_u_132
						local v137 = tick()
						local v138
						if v_u_49[v136] and (nil or 0.5) > v137 - v_u_49[v136] then
							v138 = false
						else
							v_u_49[v136] = v137
							v138 = true
						end
						if v138 then
							v_u_44[v_u_132] = false
							v_u_101()
							v_u_13:FireServer(v_u_44)
						end
					end)
				end
				if v135 then
					v135.MouseButton1Click:Connect(function()
						-- upvalues: (copy) v_u_132, (ref) v_u_49, (ref) v_u_44, (ref) v_u_101, (ref) v_u_13
						local v139 = "AutoSkip_" .. v_u_132
						local v140 = tick()
						local v141
						if v_u_49[v139] and (nil or 0.5) > v140 - v_u_49[v139] then
							v141 = false
						else
							v_u_49[v139] = v140
							v141 = true
						end
						if v141 then
							v_u_44[v_u_132] = true
							v_u_101()
							v_u_13:FireServer(v_u_44)
						end
					end)
				end
			end
		end
		for v_u_142, v143 in pairs(v_u_37) do
			v143.MouseButton1Click:Connect(function()
				-- upvalues: (copy) v_u_142, (ref) v_u_49, (ref) v_u_43, (ref) v_u_104, (ref) v_u_12
				local v144 = "Filter_" .. v_u_142
				local v145 = tick()
				local v146
				if v_u_49[v144] and (nil or 0.5) > v145 - v_u_49[v144] then
					v146 = false
				else
					v_u_49[v144] = v145
					v146 = true
				end
				if v146 then
					local v147 = table.find(v_u_43, v_u_142)
					if v147 then
						table.remove(v_u_43, v147)
					else
						local v148 = v_u_43
						local v149 = v_u_142
						table.insert(v148, v149)
					end
					v_u_104()
					v_u_12:FireServer(v_u_43)
				end
			end)
		end
	end
end
v15.OnClientEvent:Connect(function(p151)
	-- upvalues: (ref) v_u_48, (copy) v_u_8, (ref) v_u_39, (ref) v_u_31, (copy) v_u_78, (ref) v_u_45, (ref) v_u_22, (ref) v_u_42, (copy) v_u_95, (ref) v_u_43, (copy) v_u_104, (ref) v_u_44, (copy) v_u_101
	if p151 then
		if p151.Error then
			if v_u_48 then
				v_u_8:Show("Quest", {
					["message"] = "Auto-Roll stopped: Out of rerolls!"
				})
			end
			v_u_48 = false
			if v_u_39 then
				v_u_39.Visible = v_u_48
			end
			if p151.RerollCount ~= nil then
				local v152 = p151.RerollCount
				if not v_u_31 then
					return
				end
				local v153 = v_u_31:FindFirstChild("CurrentTraitRerollYouHave")
				if v153 then
					v153.Text = tostring(v152 or 0) .. " Trait Rerolls"
				end
			end
			return
		else
			if p151.RerollCount ~= nil then
				local v154 = p151.RerollCount
				local v155 = v_u_31 and v_u_31:FindFirstChild("CurrentTraitRerollYouHave")
				if v155 then
					v155.Text = tostring(v154 or 0) .. " Trait Rerolls"
				end
			end
			if p151.MythicPity == nil and (p151.SecretPity == nil and p151.HasUnlockedSecretBar == nil) then
				if p151.Pity ~= nil then
					v_u_78(p151.Pity, p151.MaxPity, 0, 4000, false)
				end
			else
				v_u_78(p151.MythicPity or p151.Pity, p151.MaxMythicPity or p151.MaxPity, p151.SecretPity, p151.MaxSecretPity, p151.HasUnlockedSecretBar)
			end
			if p151.PendingRoll then
				if v_u_48 then
					v_u_8:Show("Quest", {
						["message"] = "Auto-Roll stopped: Got " .. p151.PendingRoll .. "!"
					})
				end
				v_u_48 = false
				if v_u_39 then
					v_u_39.Visible = v_u_48
				end
				v_u_45 = p151.PendingRoll
				if v_u_22 then
					v_u_22.Visible = true
				end
			else
				if p151.RolledTrait then
					v_u_42 = p151.RolledTrait
					v_u_95(v_u_42)
				end
				if p151.Trait ~= nil then
					v_u_42 = p151.Trait
					v_u_95(v_u_42)
				end
				if p151.Filters then
					v_u_43 = p151.Filters
					v_u_104()
				end
				if p151.AutoSkip then
					v_u_44 = p151.AutoSkip
					v_u_101()
				end
				return
			end
		end
	else
		return
	end
end);
(function()
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_5, (copy) v_u_16, (copy) v_u_108, (copy) v_u_59, (copy) v_u_150
	if not v_u_4.Character then
		v_u_4.CharacterAdded:Wait()
	end
	v_u_8:Init(v_u_5)
	v_u_16.OnClientEvent:Connect(function()
		-- upvalues: (ref) v_u_108
		v_u_108()
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_59, (ref) v_u_150
		task.wait(1)
		v_u_59()
		v_u_150()
	end)
end)()