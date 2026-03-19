local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v_u_2:WaitForChild("Modules"):WaitForChild("SoundManager"))
local v_u_4 = game:GetService("TweenService")
require(v_u_2:WaitForChild("Modules"):WaitForChild("LevelingConfig"))
local v_u_5 = require(v_u_2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v_u_6 = require(v_u_2:WaitForChild("Modules"):WaitForChild("RaceConfig"))
local v_u_7 = require(v_u_2:WaitForChild("Modules"):WaitForChild("ClanConfig"))
local v_u_8 = require(v_u_2:WaitForChild("Modules"):WaitForChild("TraitConfig"))
local v_u_9 = require(v_u_2:WaitForChild("Modules"):WaitForChild("RuneConfig"))
local v_u_10 = v_u_1.LocalPlayer
local v11 = v_u_10:WaitForChild("PlayerGui")
local v12 = v11:WaitForChild("BasicStatsCurrencyAndButtonsUI")
local v13 = v11:WaitForChild("StatsPanelUI")
local v14 = v_u_2:WaitForChild("RemoteEvents")
local v15 = v14:WaitForChild("UpdatePlayerStats")
local v_u_16 = v14:WaitForChild("AllocateStat")
local v_u_17 = v14:WaitForChild("ResetStats")
local v18 = v14:WaitForChild("LevelUp")
local v19 = v14:WaitForChild("UpdateCurrency")
local v20 = v14:WaitForChild("NPCReward")
local v_u_21 = v14:WaitForChild("GetPlayerStats")
local v22 = v14:WaitForChild("ProfileLoaded")
local v23 = v14:WaitForChild("TraitDataUpdate")
local v_u_24 = v_u_2:WaitForChild("Remotes")
local v25 = v_u_24:WaitForChild("UpdateRuneUI", 10)
local v26 = v_u_24:WaitForChild("UpdateEquipped")
local v_u_27 = v_u_24:WaitForChild("GetEquipped")
local v28 = v12:WaitForChild("MainFrame")
local v29 = v28:WaitForChild("LevelInfo")
local v_u_30 = v29:WaitForChild("LevelFrame"):WaitForChild("AutoSizeHolder"):WaitForChild("Level")
local v_u_31 = v29:WaitForChild("Title")
local v32 = v28:WaitForChild("HPAndXPBars")
local v33 = v32:WaitForChild("HealthBar")
local v34 = v32:WaitForChild("XPBar")
local v_u_35 = v33:WaitForChild("LoaderFrame"):WaitForChild("LoaderHolder"):WaitForChild("Loader")
local v_u_36 = v33:WaitForChild("LoaderFrame"):WaitForChild("LoaderHolder"):WaitForChild("Stat"):WaitForChild("AutoSizeHolder"):WaitForChild("Amount")
local v_u_37 = v33:WaitForChild("LoaderFrame"):WaitForChild("LoaderHolder"):WaitForChild("Stat"):WaitForChild("AutoSizeHolder"):WaitForChild("FullCapacity")
local v_u_38 = v34:WaitForChild("LoaderFrame"):WaitForChild("LoaderHolder"):WaitForChild("Loader")
local v_u_39 = v34:WaitForChild("LoaderFrame"):WaitForChild("LoaderHolder"):WaitForChild("Stat"):WaitForChild("AutoSizeHolder"):WaitForChild("Amount")
local v_u_40 = v34:WaitForChild("LoaderFrame"):WaitForChild("LoaderHolder"):WaitForChild("Stat"):WaitForChild("AutoSizeHolder"):WaitForChild("FullCapacity")
local v41 = v28:WaitForChild("MoneyAndGemsFrame")
local v_u_42 = v41:WaitForChild("MoneyFrame"):WaitForChild("MoneyIndicator")
local v_u_43 = v_u_42:WaitForChild("CurrencyIndicator")
local v_u_44 = v41:WaitForChild("GemsFrame"):WaitForChild("GemsIndicator")
local v_u_45 = v_u_44:WaitForChild("CurrencyIndicator")
local v46 = v28:WaitForChild("UIButtons"):WaitForChild("StatsButtonFrame"):WaitForChild("StatsButton")
local v_u_47 = v13:WaitForChild("MainFrame")
v_u_47.Visible = false
local v48 = v_u_47:WaitForChild("Frame")
local v49 = v48:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v50 = v48:WaitForChild("Content")
local v51 = v50:WaitForChild("StatsFrame"):WaitForChild("Holder")
local v52 = v50:WaitForChild("SideFrame")
local v53 = v50:WaitForChild("InfoFrame")
local v_u_54 = v52:WaitForChild("Holder"):WaitForChild("PlayerAvatar"):WaitForChild("Avatar")
local v_u_55 = v53:WaitForChild("PointsAmount")
local v56 = v53:WaitForChild("GroupRestats")
local v57 = v56:WaitForChild("Holder"):WaitForChild("ResetStatsButton")
local v_u_58 = v56:WaitForChild("Input"):WaitForChild("AmountBox")
local v_u_59 = v51:WaitForChild("MeleeStatFrame")
local v_u_60 = v51:WaitForChild("DefenseStatFrame")
local v_u_61 = v51:WaitForChild("SwordStatFrame")
local v_u_62 = v51:WaitForChild("PowerStatFrame")
local v63 = v52:WaitForChild("UserStats")
local v_u_64 = v63:WaitForChild("MeleeWeapon")
local v_u_65 = v63:WaitForChild("SwordWeapon")
local v_u_66 = v63:WaitForChild("PowerWeapon")
local v_u_67 = v63:WaitForChild("AccessoryEquipped")
local v_u_68 = v63:FindFirstChild("RaceEquipped")
local v_u_69 = v63:FindFirstChild("ClanEquipped")
local v_u_70 = v63:FindFirstChild("ArtifactEquipped")
local v_u_71 = v63:FindFirstChild("TraitEquipped")
local v_u_72 = v63:WaitForChild("RuneEquipped", 5)
local v_u_73 = {
	["DamageMulti"] = "+%d%% Damage",
	["DefenseMulti"] = "+%d%% Max HP",
	["SpeedMulti"] = "+%d%% Sprint Speed",
	["JumpMulti"] = "+%d%% Jump Height",
	["ExtraJumps"] = "+%d Extra Jumps",
	["ExpMulti"] = "+%d%% XP Gain",
	["MoneyMulti"] = "+%d%% Money Gain",
	["GemsMulti"] = "+%d%% Gems Gain",
	["Lifesteal"] = "+%d%% Lifesteal"
}
local v_u_74 = {
	["DamageMulti"] = "+%d%% Damage",
	["DefenseMulti"] = "+%d%% Max HP",
	["SpeedMulti"] = "+%d%% Sprint Speed",
	["JumpMulti"] = "+%d%% Jump Height",
	["MeleeDamageMulti"] = "+%d%% Melee Damage",
	["SwordDamageMulti"] = "+%d%% Sword Damage",
	["DamageReduction"] = "+%d%% Damage Reduction",
	["LuckMulti"] = "+%d%% Luck",
	["Lifesteal"] = "+%d%% Lifesteal",
	["ExpMulti"] = "+%d%% XP Gain",
	["MoneyMulti"] = "+%d%% Money Gain",
	["GemsMulti"] = "+%d%% Gems Gain"
}
local v_u_75 = nil
local v_u_76 = false
local v_u_77 = nil
local v_u_78 = {
	["Melee"] = nil,
	["Sword"] = nil,
	["Power"] = nil,
	["Accessory"] = nil,
	["AccessoryStats"] = nil
}
local v_u_79 = require(v_u_2:WaitForChild("Modules"):WaitForChild("TitlesConfig"))
v14:WaitForChild("TitleDataSync").OnClientEvent:Connect(function(p80)
	-- upvalues: (copy) v_u_31, (copy) v_u_79
	if p80 then
		local v81 = p80.equipped
		if not v81 then
			v_u_31.Text = "Title: None"
			return
		end
		local v82 = v_u_79:GetTitle(v81)
		if not v82 then
			v_u_31.Text = "Title: " .. v81
			return
		end
		v_u_31.Text = "Title: " .. v82.displayName
	end
end)
task.spawn(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_31, (copy) v_u_79
	task.wait(1.5)
	local v_u_83 = v_u_2:WaitForChild("Remotes"):FindFirstChild("GetTitlesData")
	if v_u_83 then
		local v84, v85 = pcall(function()
			-- upvalues: (copy) v_u_83
			return v_u_83:InvokeServer()
		end)
		if v84 and v85 then
			local v86 = v85.equipped
			if not v86 then
				v_u_31.Text = "Title: None"
				return
			end
			local v87 = v_u_79:GetTitle(v86)
			if not v87 then
				v_u_31.Text = "Title: " .. v86
				return
			end
			v_u_31.Text = "Title: " .. v87.displayName
		end
	end
end)
local function v_u_111(p88, p89)
	-- upvalues: (copy) v_u_72, (copy) v_u_9
	if v_u_72 then
		local v90 = v_u_72:FindFirstChild("StatName")
		local v91 = v_u_72:FindFirstChild("Stat1")
		local v92 = v_u_72:FindFirstChild("Stat2")
		if v91 then
			v91.Visible = false
		end
		if v92 then
			v92.Visible = false
		end
		if p88 then
			local v93 = v_u_9:GetRune(p88)
			if v93 then
				if v90 then
					v90.Text = "Rune: " .. p88
				end
				local v94 = v_u_9:GetPotencyMultiplier(p89 and p89.Level or 0)
				if v93.type == "Effect" then
					local v95 = v_u_9.EFFECTS[v93.effectType:upper()]
					local v96 = (v93.baseDamagePercent or 0.25) * v94 * 100
					local v97 = math.floor(v96)
					if v93.effectType == "Burn" then
						local v98 = v95 and (v95.DURATION or 5) or 5
						local v99 = v95 and v95.TICK_COUNT or 5
						if v91 then
							v91.Text = string.format("Burn: %d%% dmg", v97)
							v91.Visible = true
						end
						if v92 then
							v92.Text = string.format("Duration: %ds (%d ticks)", v98, v99)
							v92.Visible = true
							return
						end
					elseif v93.effectType == "Bleed" then
						local v100 = v95 and (v95.DURATION or 4) or 4
						local v101 = v95 and v95.TICK_COUNT or 4
						if v91 then
							v91.Text = string.format("Bleed: %d%% dmg", v97)
							v91.Visible = true
						end
						if v92 then
							v92.Text = string.format("Duration: %ds (%d ticks)", v100, v101)
							v92.Visible = true
							return
						end
					elseif v93.effectType == "Freeze" then
						local v102 = (v93.baseDuration or 2) * v94
						if v91 then
							v91.Text = string.format("Freeze: %.1fs stun", v102)
							v91.Visible = true
						end
						if v92 then
							v92.Text = string.format("Impact: %d%% dmg", v97)
							v92.Visible = true
							return
						end
					end
				elseif v93.type == "Buff" then
					if v93.buffType == "Damage" then
						local v103 = (v93.multiplier - 1) * v94 * 100
						local v104 = math.floor(v103)
						if v91 then
							v91.Text = string.format("+%d%% Damage", v104)
							v91.Visible = true
						end
						if v92 then
							v92.Text = string.format("Multiplier: x%.2f", v104 / 100 + 1)
							v92.Visible = true
							return
						end
					elseif v93.buffType == "Health" then
						local v105 = (v93.multiplier - 1) * v94 * 100
						local v106 = math.floor(v105)
						if v91 then
							v91.Text = string.format("+%d%% Max HP", v106)
							v91.Visible = true
						end
						if v92 then
							v92.Text = string.format("Multiplier: x%.2f", v106 / 100 + 1)
							v92.Visible = true
							return
						end
					elseif v93.buffType == "DamageReduction" then
						local v107 = (v93.flatBonus or 10) * v94
						local v108 = math.floor(v107)
						if v91 then
							v91.Text = string.format("+%d%% Dmg Reduction", v108)
							v91.Visible = true
							return
						end
					elseif v93.buffType == "Luck" then
						local v109 = (v93.baseLuckPercent or 10) * v94
						local v110 = math.floor(v109)
						if v91 then
							v91.Text = string.format("+%d%% Luck", v110)
							v91.Visible = true
						end
					end
				end
			elseif v90 then
				v90.Text = "Rune: " .. p88
			end
		else
			if v90 then
				v90.Text = "Rune: None"
			end
			return
		end
	else
		return
	end
end
local v112 = v50:FindFirstChild("Page2")
local v_u_113 = v112 and v112:FindFirstChild("StatsHolder")
if v_u_113 then
	v_u_113 = v112:FindFirstChild("StatsHolder"):FindFirstChild("RuneProgressionFrame")
end
local function v_u_129(p114)
	-- upvalues: (copy) v_u_113, (copy) v_u_9, (copy) v_u_4
	if v_u_113 then
		local v115 = v_u_113:FindFirstChild("Txts")
		if v115 then
			local v116 = v115:FindFirstChild("RuneExperience")
			local v117 = v115:FindFirstChild("RuneLevel")
			local v118 = v_u_113:FindFirstChild("Loader")
			local v119
			if v118 then
				v119 = v118:FindFirstChild("Holder")
			else
				v119 = v118
			end
			local v120 = p114 and (p114.Level or 0) or 0
			local v121 = p114 and p114.XP or 0
			local v122 = v_u_9.PROGRESSION.MAX_LEVEL
			local v123 = v_u_9:GetXPForLevel(v120 + 1)
			local v124 = v_u_9:GetXPForLevel(v120)
			local v125 = v121 - v124
			local v126 = v123 - v124
			if v116 then
				v116.Text = "Rune Lv. " .. v120
			end
			if v117 then
				if v122 <= v120 then
					v117.Text = "MAX LEVEL"
				else
					v117.Text = v125 .. " / " .. v126 .. " XP"
				end
			end
			if v118 then
				local v127 = v122 <= v120 and 1 or (v126 > 0 and v125 / v126 or 0)
				local v128 = math.clamp(v127, 0, 1)
				if v119 then
					v119 = v119:FindFirstChild("Loader")
				end
				if v119 then
					v_u_4:Create(v119, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
						["Size"] = UDim2.new(v128, 0, 1, 0)
					}):Play()
				end
			end
		end
	else
		return
	end
end
if v25 then
	v25.OnClientEvent:Connect(function(p130, p131)
		-- upvalues: (copy) v_u_111, (copy) v_u_129
		v_u_111(p130, p131)
		v_u_129(p131)
	end)
end
task.spawn(function()
	-- upvalues: (copy) v_u_24, (copy) v_u_111, (copy) v_u_129
	task.wait(2)
	local v_u_132 = v_u_24:FindFirstChild("GetRuneData")
	if v_u_132 then
		local v133, v134 = pcall(function()
			-- upvalues: (copy) v_u_132
			return v_u_132:InvokeServer()
		end)
		if v133 and v134 then
			v_u_111(v134.equipped, v134.progression)
			v_u_129(v134.progression)
		end
	end
end)
local v_u_135 = {
	["Damage"] = "+%d%% Damage",
	["Defense"] = "+%d%% Defense",
	["DamageReduction"] = "+%d%% Dmg Reduction",
	["Cooldown"] = "-%d%% Cooldown",
	["Speed"] = "+%d%% Speed"
}
local function v_u_141(p136)
	local v137 = tonumber(p136) or 0
	local v138 = math.floor(v137)
	local v139 = tostring(v138)
	repeat
		local v140
		v139, v140 = string.gsub(v139, "^(-?%d+)(%d%d%d)", "%1,%2")
	until v140 == 0
	return v139
end
local function v_u_147(p142)
	-- upvalues: (copy) v_u_141
	local v143 = tonumber(p142) or 0
	if v143 >= 1000000000000 then
		local v144 = v143 / 1000000000000
		if v144 >= 100 then
			return string.format("%.0fT", v144)
		else
			return string.format("%.2fT", v144)
		end
	elseif v143 >= 1000000000 then
		local v145 = v143 / 1000000000
		if v145 >= 100 then
			return string.format("%.0fB", v145)
		else
			return string.format("%.2fB", v145)
		end
	elseif v143 >= 1000000 then
		local v146 = v143 / 1000000
		if v146 >= 100 then
			return string.format("%.0fM", v146)
		else
			return string.format("%.2fM", v146)
		end
	elseif v143 >= 100000 then
		return string.format("%.0fK", v143 / 1000)
	elseif v143 >= 1000 then
		return string.format("%.2fK", v143 / 1000)
	else
		return v_u_141(v143)
	end
end
local function v_u_172(p148)
	-- upvalues: (copy) v_u_69, (copy) v_u_7, (copy) v_u_74
	if v_u_69 then
		local v149 = "None"
		if p148 then
			if p148.Clan then
				v149 = p148.Clan
			elseif p148.Inventory and (p148.Inventory.Equipped and p148.Inventory.Equipped.Clan) then
				v149 = p148.Inventory.Equipped.Clan
			end
		end
		local v150 = v_u_69:FindFirstChild("StatName")
		if v150 then
			v150.Text = "Clan: " .. v149
		end
		local v151 = v_u_7 and v_u_7.GetAllBuffs and (v_u_7:GetAllBuffs(v149) or {}) or {}
		local v152
		if v_u_7 and v_u_7.GetPassive then
			v152 = v_u_7:GetPassive(v149)
		else
			v152 = nil
		end
		local v153 = {}
		for _, v154 in ipairs(v_u_69:GetChildren()) do
			if v154:IsA("TextLabel") and v154.Name:match("^Stat%d+$") then
				table.insert(v153, v154)
			end
		end
		table.sort(v153, function(p155, p156)
			return p155.Name < p156.Name
		end)
		for _, v157 in ipairs(v153) do
			v157.Visible = false
		end
		local v158 = {}
		local v159 = {}
		for _, v160 in ipairs({
			"DamageMulti",
			"DefenseMulti",
			"MeleeDamageMulti",
			"SwordDamageMulti",
			"DamageReduction",
			"SpeedMulti",
			"JumpMulti",
			"LuckMulti",
			"Lifesteal",
			"ExpMulti",
			"MoneyMulti",
			"GemsMulti"
		}) do
			local v161 = v151[v160]
			if v161 and (type(v161) == "number" and v161 > 0) then
				table.insert(v158, {
					["name"] = v160,
					["value"] = v161
				})
				v159[v160] = true
			end
		end
		for v162, v163 in pairs(v151) do
			if not v159[v162] then
				if type(v163) == "number" and v163 > 0 then
					table.insert(v158, {
						["name"] = v162,
						["value"] = v163
					})
				elseif type(v163) == "table" then
					for v164, v165 in pairs(v163) do
						if type(v165) == "number" and v165 > 0 then
							table.insert(v158, {
								["name"] = v162,
								["value"] = v165,
								["subKey"] = v164
							})
						end
					end
				end
			end
		end
		local v166 = v_u_69:FindFirstChild("Stat1")
		local v167 = 1
		for _, v168 in ipairs(v158) do
			local v169 = v153[v167]
			if not v169 and v166 then
				v169 = v166:Clone()
				v169.Name = "Stat" .. v167
				v169.Parent = v_u_69
				table.insert(v153, v169)
			end
			if v169 then
				if v168.subKey then
					v169.Text = string.format("+%d%% %s Damage", v168.value, v168.subKey)
				else
					local v170 = v_u_74[v168.name] or "+%d%% " .. v168.name
					v169.Text = string.format(v170, v168.value)
				end
				v169.LayoutOrder = v167 + 1
				v169.Visible = true
				v167 = v167 + 1
			end
		end
		if v152 then
			local v171 = v153[v167]
			if not v171 and v166 then
				v171 = v166:Clone()
				v171.Name = "Stat" .. v167
				v171.Parent = v_u_69
				table.insert(v153, v171)
			end
			if v171 then
				if v152.Type == "ExecuteDamage" then
					v171.Text = string.format("+%d%%DMG to NPC below %d%%HP", v152.Bonus, v152.Threshold)
				elseif v152.Type == "DropBonus" then
					v171.Text = string.format("%d%% chance +%d drop", v152.Chance, v152.Amount)
				else
					v171.Text = "Passive: " .. v152.Type
				end
				v171.LayoutOrder = v167 + 1
				v171.Visible = true
			end
		end
	end
end
local function v_u_203(p173)
	-- upvalues: (ref) v_u_78, (copy) v_u_64, (copy) v_u_65, (copy) v_u_66, (copy) v_u_67, (copy) v_u_135, (copy) v_u_68, (copy) v_u_6, (copy) v_u_73, (copy) v_u_69, (copy) v_u_172, (copy) v_u_70
	if p173 then
		v_u_78 = p173
		local v174 = p173.Melee or "None"
		local v175 = p173.Sword or "None"
		local v176 = p173.Power or "None"
		v_u_64.Stat.Text = v174
		v_u_65.Stat.Text = v175
		v_u_66.Stat.Text = v176
		local v177 = p173.Accessory
		local v178 = p173.AccessoryStats
		local v179 = p173.AccessoryEnchantLevel or 0
		if v177 and v177 ~= "" then
			if v179 > 0 then
				v177 = v177 .. " [E" .. v179 .. "]"
			end
			v_u_67.StatName.Text = "Accessory: " .. v177
			local v180 = { v_u_67.Stat1, v_u_67.Stat2, v_u_67.Stat3 }
			local v181 = 1
			for _, v182 in ipairs(v180) do
				v182.Visible = false
			end
			if v178 then
				for v183, v184 in pairs(v178) do
					if v184 and (v184 > 0 and v181 <= 3) then
						local v185 = v_u_135[v183] or "+%d%% " .. v183
						v180[v181].Text = string.format(v185, v184)
						v180[v181].Visible = true
						v181 = v181 + 1
					end
				end
			end
		else
			v_u_67.StatName.Text = "Accessory: None"
			v_u_67.Stat1.Visible = false
			v_u_67.Stat2.Visible = false
			v_u_67.Stat3.Visible = false
		end
		if v_u_68 then
			local v186 = p173.Race or "Human"
			local v187 = v_u_68:FindFirstChild("StatName")
			if v187 then
				v187.Text = "Race: " .. v186
			end
			local v188 = v_u_6 and v_u_6.GetAllBuffs and (v_u_6:GetAllBuffs(v186) or {}) or {}
			local v189 = {}
			for _, v190 in ipairs(v_u_68:GetChildren()) do
				if v190:IsA("TextLabel") and v190.Name:match("^Stat%d+$") then
					table.insert(v189, v190)
				end
			end
			table.sort(v189, function(p191, p192)
				return p191.Name < p192.Name
			end)
			for _, v193 in ipairs(v189) do
				v193.Visible = false
			end
			local v194 = v_u_68:FindFirstChild("Stat1")
			local v195 = 1
			for v196, v197 in pairs(v188) do
				if type(v197) == "number" and v197 > 0 then
					local v198 = v189[v195]
					if not v198 and v194 then
						v198 = v194:Clone()
						v198.Name = "Stat" .. v195
						v198.Parent = v_u_68
						table.insert(v189, v198)
					end
					if v198 then
						local v199 = v_u_73[v196] or "+%d%% " .. v196
						v198.Text = string.format(v199, v197)
						v198.Visible = true
						v195 = v195 + 1
					end
				elseif type(v197) == "table" then
					for v200, v201 in pairs(v197) do
						if type(v201) == "number" and v201 > 0 then
							local v202 = v189[v195]
							if not v202 and v194 then
								v202 = v194:Clone()
								v202.Name = "Stat" .. v195
								v202.Parent = v_u_68
								table.insert(v189, v202)
							end
							if v202 then
								v202.Text = string.format("+%d%% %s Damage", v201, v200)
								v202.Visible = true
								v195 = v195 + 1
							end
						end
					end
				end
			end
		end
		if v_u_69 then
			v_u_172({
				["Clan"] = p173.Clan or p173.Inventory and (p173.Inventory.Equipped and p173.Inventory.Equipped.Clan) or "None"
			})
		end
		if v_u_70 then
			v_u_70.StatName.Text = "Artifact: None"
			if v_u_70:FindFirstChild("Stat1") then
				v_u_70.Stat1.Visible = false
			end
			if v_u_70:FindFirstChild("Stat2") then
				v_u_70.Stat2.Visible = false
			end
			if v_u_70:FindFirstChild("Stat3") then
				v_u_70.Stat3.Visible = false
			end
		end
	end
end
local function v_u_213(p204)
	-- upvalues: (copy) v_u_55, (copy) v_u_141, (copy) v_u_59, (copy) v_u_60, (copy) v_u_61, (copy) v_u_62
	if p204 then
		v_u_55.Text = "Stat Points: " .. v_u_141(p204.StatPoints or 0)
		local v205 = {
			{
				["frame"] = v_u_59,
				["stat"] = "Melee"
			},
			{
				["frame"] = v_u_60,
				["stat"] = "Defense"
			},
			{
				["frame"] = v_u_61,
				["stat"] = "Sword"
			},
			{
				["frame"] = v_u_62,
				["stat"] = "Power"
			}
		}
		for _, v206 in ipairs(v205) do
			local v207 = p204.Stats and (p204.Stats[v206.stat] or 0) or 0
			local v208 = v206.frame:FindFirstChild("Content")
			local v209 = v208 and v208:FindFirstChild("StatFrame") or v206.frame:FindFirstChild("StatFrame")
			if v209 then
				local v210 = v209:FindFirstChild("AutoSizeHolder")
				if v210 then
					local v211 = v210:FindFirstChild("StatValue")
					local v212 = v210:FindFirstChild("MaxTxt")
					if v211 then
						v211.Text = v_u_141(v207)
					end
					if v212 then
						v212.Visible = v207 >= 10000
					end
				end
			end
		end
	end
end
local function v_u_232(p214)
	-- upvalues: (copy) v_u_172, (copy) v_u_68, (copy) v_u_6, (copy) v_u_73
	if p214.Clan or p214.Inventory and (p214.Inventory.Equipped and p214.Inventory.Equipped.Clan) then
		v_u_172(p214)
	end
	if v_u_68 then
		local v215 = "Human"
		if p214 then
			if p214.Race then
				v215 = p214.Race
			elseif p214.Inventory and (p214.Inventory.Equipped and p214.Inventory.Equipped.Race) then
				v215 = p214.Inventory.Equipped.Race
			end
		end
		local v216 = v_u_68:FindFirstChild("StatName")
		if v216 then
			v216.Text = "Race: " .. v215
		end
		local v217 = v_u_6 and v_u_6.GetAllBuffs and (v_u_6:GetAllBuffs(v215) or {}) or {}
		local v218 = {}
		for _, v219 in ipairs(v_u_68:GetChildren()) do
			if v219:IsA("TextLabel") and v219.Name:match("^Stat%d+$") then
				table.insert(v218, v219)
			end
		end
		table.sort(v218, function(p220, p221)
			return p220.Name < p221.Name
		end)
		for _, v222 in ipairs(v218) do
			v222.Visible = false
		end
		local v223 = v_u_68:FindFirstChild("Stat1")
		local v224 = 1
		for v225, v226 in pairs(v217) do
			if type(v226) == "number" and v226 > 0 then
				local v227 = v218[v224]
				if not v227 and v223 then
					v227 = v223:Clone()
					v227.Name = "Stat" .. v224
					v227.Parent = v_u_68
					table.insert(v218, v227)
				end
				if v227 then
					local v228 = v_u_73[v225] or "+%d%% " .. v225
					v227.Text = string.format(v228, v226)
					v227.Visible = true
					v224 = v224 + 1
				end
			elseif type(v226) == "table" then
				for v229, v230 in pairs(v226) do
					if type(v230) == "number" and v230 > 0 then
						local v231 = v218[v224]
						if not v231 and v223 then
							v231 = v223:Clone()
							v231.Name = "Stat" .. v224
							v231.Parent = v_u_68
							table.insert(v218, v231)
						end
						if v231 then
							v231.Text = string.format("+%d%% %s Damage", v230, v229)
							v231.Visible = true
							v224 = v224 + 1
						end
					end
				end
			end
		end
	end
end
local function v_u_241(p233)
	-- upvalues: (copy) v_u_71, (copy) v_u_8
	if v_u_71 then
		local v234 = v_u_71:FindFirstChild("StatName")
		local v235 = v_u_71:FindFirstChild("Stat1")
		local v236 = v_u_71:FindFirstChild("Stat2")
		local v237 = v_u_71:FindFirstChild("Stat3")
		if v235 then
			v235.Visible = false
		end
		if v236 then
			v236.Visible = false
		end
		if v237 then
			v237.Visible = false
		end
		if p233 and p233 ~= "" then
			if v234 then
				v234.Text = "Trait: " .. p233
			end
			local v238 = v_u_8
			if v238 then
				v238 = v_u_8:GetTraitData(p233)
			end
			if v238 then
				local v239 = { v235, v236, v237 }
				local v240 = 1
				if v238.DamageMult and (v238.DamageMult > 1 and v239[v240]) then
					v239[v240].Text = string.format("%.2fx Damage", v238.DamageMult)
					v239[v240].Visible = true
					v240 = v240 + 1
				end
				if v238.DefenseMult and (v238.DefenseMult > 1 and v239[v240]) then
					v239[v240].Text = string.format("%.2fx Defense", v238.DefenseMult)
					v239[v240].Visible = true
					v240 = v240 + 1
				end
				if v238.CooldownReduction and (v238.CooldownReduction > 0 and v239[v240]) then
					v239[v240].Text = string.format("-%d%% Cooldown", v238.CooldownReduction)
					v239[v240].Visible = true
					local _ = v240 + 1
				end
			end
		else
			if v234 then
				v234.Text = "Trait: None"
			end
			return
		end
	else
		return
	end
end
local function v_u_258(p242)
	-- upvalues: (copy) v_u_232, (copy) v_u_241, (copy) v_u_111, (copy) v_u_129, (copy) v_u_30, (copy) v_u_147, (copy) v_u_42, (copy) v_u_43, (copy) v_u_44, (copy) v_u_45, (copy) v_u_10, (copy) v_u_35, (copy) v_u_36, (copy) v_u_141, (copy) v_u_37, (copy) v_u_38, (copy) v_u_39, (copy) v_u_40
	if p242 then
		if p242.Race or p242.Inventory and (p242.Inventory.Equipped and p242.Inventory.Equipped.Race) then
			v_u_232(p242)
		end
		if p242.Trait ~= nil then
			v_u_241(p242.Trait)
		end
		v_u_111(p242.RuneEquipped, p242.RuneProgression)
		if p242.RuneProgression then
			v_u_129(p242.RuneProgression)
		end
		local v243 = v_u_30
		local v244 = p242.Level or 0
		v243.Text = "Lv. " .. tostring(v244)
		local v245 = p242.Currency and (p242.Currency.Money or 0) or 0
		local v246 = tonumber(v245)
		local v247 = p242.Currency and (p242.Currency.Gems or 0) or 0
		local v248 = tonumber(v247)
		local v249 = v_u_147(v246)
		local v250 = v_u_147(v248)
		v_u_42.Text = v249
		v_u_43.Text = v249
		v_u_44.Text = v250
		v_u_45.Text = v250
		local v251 = v_u_10.Character
		if v251 then
			local v252 = v251:FindFirstChild("Humanoid")
			if v252 and v252.Health > 0 then
				local v253 = v252.Health / v252.MaxHealth
				v_u_35.Size = UDim2.new(v253, 0, 1, 0)
				v_u_36.Text = v_u_141(v252.Health)
				v_u_37.Text = "/" .. v_u_141(v252.MaxHealth)
			end
		end
		if p242.isMaxLevel or false then
			v_u_38.Size = UDim2.new(1, 0, 1, 0)
			v_u_39.Text = "MAX"
			v_u_40.Text = ""
		else
			local v254 = p242.Experience or 0
			local v255 = p242.xpRequired or 200
			local v256
			if v255 > 0 then
				local v257 = v254 / v255
				v256 = math.min(v257, 1) or 1
			else
				v256 = 1
			end
			v_u_38.Size = UDim2.new(v256, 0, 1, 0)
			v_u_39.Text = v_u_141(v254)
			v_u_40.Text = "/" .. v_u_141(v255)
		end
	else
		return
	end
end
local function v263()
	-- upvalues: (copy) v_u_21, (ref) v_u_75, (ref) v_u_76, (copy) v_u_258
	local v259 = 0
	local v260 = 0.5
	while v259 < 5 do
		v259 = v259 + 1
		if v259 > 1 then
			task.wait(v260)
			v260 = v260 * 1.5
		else
			task.wait(0.5)
		end
		if v_u_21:IsA("RemoteFunction") then
			local v261, v262 = pcall(function()
				-- upvalues: (ref) v_u_21
				return v_u_21:InvokeServer()
			end)
			if v261 and v262 then
				v_u_75 = v262
				v_u_76 = true
				v_u_258(v262)
				return true
			end
		end
	end
	warn("[StatsUI] Failed to load stats after " .. 5 .. " attempts")
	return false
end
local function v266()
	-- upvalues: (copy) v_u_27, (copy) v_u_203
	task.spawn(function()
		-- upvalues: (ref) v_u_27, (ref) v_u_203
		local v264, v265 = pcall(function()
			-- upvalues: (ref) v_u_27
			return v_u_27:InvokeServer()
		end)
		if v264 and v265 then
			v_u_203({
				["Melee"] = v265.Melee,
				["Sword"] = v265.Sword,
				["Power"] = v265.Power,
				["Accessory"] = v265.Accessory,
				["AccessoryStats"] = nil
			})
		end
	end)
end
task.spawn(function()
	-- upvalues: (copy) v_u_5, (copy) v_u_47
	task.wait(0.1)
	v_u_5:Register("Stats", v_u_47)
end)
local function v_u_271()
	-- upvalues: (copy) v_u_1, (copy) v_u_10, (copy) v_u_54, (copy) v_u_203, (ref) v_u_78, (copy) v_u_21, (ref) v_u_75, (ref) v_u_76, (copy) v_u_258, (copy) v_u_213
	local v267, v268 = pcall(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_10
		return v_u_1:GetUserThumbnailAsync(v_u_10.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	if v267 and v268 then
		v_u_54.Image = v268
	end
	v_u_203(v_u_78)
	if v_u_21:IsA("RemoteFunction") then
		task.spawn(function()
			-- upvalues: (ref) v_u_21, (ref) v_u_75, (ref) v_u_76, (ref) v_u_258, (ref) v_u_213
			local v269, v270 = pcall(function()
				-- upvalues: (ref) v_u_21
				return v_u_21:InvokeServer()
			end)
			if v269 and v270 then
				v_u_75 = v270
				v_u_76 = true
				v_u_258(v270)
				v_u_213(v270)
			end
		end)
	elseif v_u_75 and v_u_76 then
		v_u_213(v_u_75)
	end
end
v46.Activated:Connect(function()
	-- upvalues: (copy) v_u_5, (copy) v_u_271
	if not v_u_5:IsOnCooldown() then
		v_u_5:Toggle("Stats")
		if v_u_5:IsOpen("Stats") then
			v_u_271()
		end
	end
end)
v49.Activated:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:Close("Stats")
end)
local function v284(p272, p_u_273)
	-- upvalues: (ref) v_u_75, (copy) v_u_16, (copy) v_u_58
	local v274 = p272:FindFirstChild("Content")
	if v274 then
		local v275 = v274:FindFirstChild("UpgradeFrame")
		local v276 = v275 and v275:FindFirstChild("AddPoints")
		if v276 then
			v276.Activated:Connect(function()
				-- upvalues: (ref) v_u_75, (ref) v_u_16, (copy) p_u_273, (ref) v_u_58
				if v_u_75 and (v_u_75.StatPoints or 0) > 0 then
					local v277 = v_u_16
					local v278 = p_u_273
					local v279 = v_u_58.Text
					local v280
					if v279 == "" or v279 == nil then
						v280 = 1
					else
						local v281 = tonumber(v279)
						if v281 then
							local v282 = math.abs(v281)
							local v283 = math.floor(v282)
							if v283 > 25000 then
								v_u_58.Text = tostring(25000)
								v283 = 25000
							end
							v280 = math.max(v283, 1)
						else
							warn("[StatsUI] Invalid amount: " .. v279)
							v280 = 1
						end
					end
					v277:FireServer(v278, v280)
				end
			end)
		end
	end
end
v284(v_u_59, "Melee")
v284(v_u_60, "Defense")
v284(v_u_61, "Sword")
v284(v_u_62, "Power")
v57.Activated:Connect(function()
	-- upvalues: (copy) v_u_17, (copy) v_u_3
	v_u_17:FireServer()
	v_u_3:Play("ResetStatPoints")
end)
v22.OnClientEvent:Connect(function(p285)
	-- upvalues: (ref) v_u_75, (ref) v_u_76, (copy) v_u_258, (copy) v_u_47, (copy) v_u_213, (copy) v_u_1, (copy) v_u_10, (copy) v_u_54
	if p285 then
		v_u_75 = p285
		v_u_76 = true
		v_u_258(p285)
		if v_u_47.Visible then
			v_u_213(p285)
			local v286, v287 = pcall(function()
				-- upvalues: (ref) v_u_1, (ref) v_u_10
				return v_u_1:GetUserThumbnailAsync(v_u_10.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)
			if v286 and v287 then
				v_u_54.Image = v287
			end
		end
	end
end)
v15.OnClientEvent:Connect(function(p288)
	-- upvalues: (ref) v_u_75, (ref) v_u_76, (copy) v_u_258, (copy) v_u_47, (copy) v_u_213
	if p288 then
		v_u_75 = p288
		v_u_76 = true
		v_u_258(p288)
		if v_u_47.Visible then
			v_u_213(p288)
		end
	end
end)
v19.OnClientEvent:Connect(function(p289, p290)
	-- upvalues: (ref) v_u_75, (copy) v_u_147, (copy) v_u_42, (copy) v_u_43, (copy) v_u_44, (copy) v_u_45
	local v291 = tonumber(p289) or 0
	local v292 = tonumber(p290) or 0
	if v_u_75 then
		v_u_75.Currency = v_u_75.Currency or {}
		v_u_75.Currency.Money = v291
		v_u_75.Currency.Gems = v292
	end
	local v293 = v_u_147(v291)
	local v294 = v_u_147(v292)
	v_u_42.Text = v293
	v_u_43.Text = v293
	v_u_44.Text = v294
	v_u_45.Text = v294
end)
v18.OnClientEvent:Connect(function(p295, _)
	-- upvalues: (copy) v_u_30
	v_u_30.Text = "Lv. " .. tostring(p295)
end)
v20.OnClientEvent:Connect(function(_) end)
v26.OnClientEvent:Connect(function(p296)
	-- upvalues: (copy) v_u_203
	if p296 then
		v_u_203(p296)
	end
end)
v23.OnClientEvent:Connect(function(p297)
	-- upvalues: (copy) v_u_241
	if p297 and p297.Trait ~= nil then
		v_u_241(p297.Trait)
	elseif p297 and p297.RolledTrait then
		v_u_241(p297.RolledTrait)
	end
end)
local function v_u_304(p298)
	-- upvalues: (ref) v_u_77, (copy) v_u_10, (copy) v_u_35, (copy) v_u_36, (copy) v_u_141, (copy) v_u_37
	if v_u_77 then
		v_u_77:Disconnect()
		v_u_77 = nil
	end
	local v299 = p298 or v_u_10.Character
	if v299 then
		local v_u_300 = v299:WaitForChild("Humanoid")
		if v_u_300 then
			local function v302()
				-- upvalues: (copy) v_u_300, (ref) v_u_35, (ref) v_u_36, (ref) v_u_141, (ref) v_u_37
				local v301 = v_u_300.Health / v_u_300.MaxHealth
				v_u_35.Size = UDim2.new(v301, 0, 1, 0)
				v_u_36.Text = v_u_141(v_u_300.Health)
				v_u_37.Text = "/" .. v_u_141(v_u_300.MaxHealth)
			end
			v_u_77 = v_u_300.HealthChanged:Connect(v302)
			local v303 = v_u_300.Health / v_u_300.MaxHealth
			v_u_35.Size = UDim2.new(v303, 0, 1, 0)
			v_u_36.Text = v_u_141(v_u_300.Health)
			v_u_37.Text = "/" .. v_u_141(v_u_300.MaxHealth)
		end
	else
		return
	end
end
v_u_10.CharacterAdded:Connect(function(p305)
	-- upvalues: (copy) v_u_304, (copy) v_u_21, (ref) v_u_75, (ref) v_u_76, (copy) v_u_258
	task.wait(0.1)
	v_u_304(p305)
	task.spawn(function()
		-- upvalues: (ref) v_u_21, (ref) v_u_75, (ref) v_u_76, (ref) v_u_258
		task.wait(0.5)
		if v_u_21:IsA("RemoteFunction") then
			local v306, v307 = pcall(function()
				-- upvalues: (ref) v_u_21
				return v_u_21:InvokeServer()
			end)
			if v306 and v307 then
				v_u_75 = v307
				v_u_76 = true
				v_u_258(v307)
			end
		end
	end)
end)
if v_u_10.Character then
	task.spawn(v_u_304, v_u_10.Character)
end
task.spawn(v263)
task.spawn(v266)