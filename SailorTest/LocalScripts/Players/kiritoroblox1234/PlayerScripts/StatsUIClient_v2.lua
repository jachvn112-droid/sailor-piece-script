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
local function v_u_148(p142)
	-- upvalues: (copy) v_u_141
	local v143 = tonumber(p142) or 0
	local v144 = v143 ~= v143 and 0 or v143
	if v144 >= 1000000000000 then
		local v145 = v144 / 1000000000000
		if v145 >= 100 then
			return string.format("%.0fT", v145)
		else
			return string.format("%.2fT", v145)
		end
	elseif v144 >= 1000000000 then
		local v146 = v144 / 1000000000
		if v146 >= 100 then
			return string.format("%.0fB", v146)
		else
			return string.format("%.2fB", v146)
		end
	elseif v144 >= 1000000 then
		local v147 = v144 / 1000000
		if v147 >= 100 then
			return string.format("%.0fM", v147)
		else
			return string.format("%.2fM", v147)
		end
	elseif v144 >= 100000 then
		return string.format("%.0fK", v144 / 1000)
	elseif v144 >= 1000 then
		return string.format("%.2fK", v144 / 1000)
	else
		return v_u_141(v144)
	end
end
local function v_u_173(p149)
	-- upvalues: (copy) v_u_69, (copy) v_u_7, (copy) v_u_74
	if v_u_69 then
		local v150 = "None"
		if p149 then
			if p149.Clan then
				v150 = p149.Clan
			elseif p149.Inventory and (p149.Inventory.Equipped and p149.Inventory.Equipped.Clan) then
				v150 = p149.Inventory.Equipped.Clan
			end
		end
		local v151 = v_u_69:FindFirstChild("StatName")
		if v151 then
			v151.Text = "Clan: " .. v150
		end
		local v152 = v_u_7 and v_u_7.GetAllBuffs and (v_u_7:GetAllBuffs(v150) or {}) or {}
		local v153
		if v_u_7 and v_u_7.GetPassive then
			v153 = v_u_7:GetPassive(v150)
		else
			v153 = nil
		end
		local v154 = {}
		for _, v155 in ipairs(v_u_69:GetChildren()) do
			if v155:IsA("TextLabel") and v155.Name:match("^Stat%d+$") then
				table.insert(v154, v155)
			end
		end
		table.sort(v154, function(p156, p157)
			return p156.Name < p157.Name
		end)
		for _, v158 in ipairs(v154) do
			v158.Visible = false
		end
		local v159 = {}
		local v160 = {}
		for _, v161 in ipairs({
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
			local v162 = v152[v161]
			if v162 and (type(v162) == "number" and v162 > 0) then
				table.insert(v159, {
					["name"] = v161,
					["value"] = v162
				})
				v160[v161] = true
			end
		end
		for v163, v164 in pairs(v152) do
			if not v160[v163] then
				if type(v164) == "number" and v164 > 0 then
					table.insert(v159, {
						["name"] = v163,
						["value"] = v164
					})
				elseif type(v164) == "table" then
					for v165, v166 in pairs(v164) do
						if type(v166) == "number" and v166 > 0 then
							table.insert(v159, {
								["name"] = v163,
								["value"] = v166,
								["subKey"] = v165
							})
						end
					end
				end
			end
		end
		local v167 = v_u_69:FindFirstChild("Stat1")
		local v168 = 1
		for _, v169 in ipairs(v159) do
			local v170 = v154[v168]
			if not v170 and v167 then
				v170 = v167:Clone()
				v170.Name = "Stat" .. v168
				v170.Parent = v_u_69
				table.insert(v154, v170)
			end
			if v170 then
				if v169.subKey then
					v170.Text = string.format("+%d%% %s Damage", v169.value, v169.subKey)
				else
					local v171 = v_u_74[v169.name] or "+%d%% " .. v169.name
					v170.Text = string.format(v171, v169.value)
				end
				v170.LayoutOrder = v168 + 1
				v170.Visible = true
				v168 = v168 + 1
			end
		end
		if v153 then
			local v172 = v154[v168]
			if not v172 and v167 then
				v172 = v167:Clone()
				v172.Name = "Stat" .. v168
				v172.Parent = v_u_69
				table.insert(v154, v172)
			end
			if v172 then
				if v153.Type == "ExecuteDamage" then
					v172.Text = string.format("+%d%%DMG to NPC below %d%%HP", v153.Bonus, v153.Threshold)
				elseif v153.Type == "DropBonus" then
					v172.Text = string.format("%d%% chance +%d drop", v153.Chance, v153.Amount)
				elseif v153.Type == "ComboRamp" then
					v172.Text = string.format("Each dmg tick = %gx DMG Cap: %gx DMG %ds DUR", v153.PerTick, v153.Cap, v153.Duration)
				else
					v172.Text = "Passive: " .. v153.Type
				end
				v172.LayoutOrder = v168 + 1
				v172.Visible = true
			end
		end
	end
end
local function v_u_204(p174)
	-- upvalues: (ref) v_u_78, (copy) v_u_64, (copy) v_u_65, (copy) v_u_66, (copy) v_u_67, (copy) v_u_135, (copy) v_u_68, (copy) v_u_6, (copy) v_u_73, (copy) v_u_69, (copy) v_u_173, (copy) v_u_70
	if p174 then
		v_u_78 = p174
		local v175 = p174.Melee or "None"
		local v176 = p174.Sword or "None"
		local v177 = p174.Power or "None"
		v_u_64.Stat.Text = v175
		v_u_65.Stat.Text = v176
		v_u_66.Stat.Text = v177
		local v178 = p174.Accessory
		local v179 = p174.AccessoryStats
		local v180 = p174.AccessoryEnchantLevel or 0
		if v178 and v178 ~= "" then
			if v180 > 0 then
				v178 = v178 .. " [E" .. v180 .. "]"
			end
			v_u_67.StatName.Text = "Accessory: " .. v178
			local v181 = { v_u_67.Stat1, v_u_67.Stat2, v_u_67.Stat3 }
			local v182 = 1
			for _, v183 in ipairs(v181) do
				v183.Visible = false
			end
			if v179 then
				for v184, v185 in pairs(v179) do
					if v185 and (v185 > 0 and v182 <= 3) then
						local v186 = v_u_135[v184] or "+%d%% " .. v184
						v181[v182].Text = string.format(v186, v185)
						v181[v182].Visible = true
						v182 = v182 + 1
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
			local v187 = p174.Race or "Human"
			local v188 = v_u_68:FindFirstChild("StatName")
			if v188 then
				v188.Text = "Race: " .. v187
			end
			local v189 = v_u_6 and v_u_6.GetAllBuffs and (v_u_6:GetAllBuffs(v187) or {}) or {}
			local v190 = {}
			for _, v191 in ipairs(v_u_68:GetChildren()) do
				if v191:IsA("TextLabel") and v191.Name:match("^Stat%d+$") then
					table.insert(v190, v191)
				end
			end
			table.sort(v190, function(p192, p193)
				return p192.Name < p193.Name
			end)
			for _, v194 in ipairs(v190) do
				v194.Visible = false
			end
			local v195 = v_u_68:FindFirstChild("Stat1")
			local v196 = 1
			for v197, v198 in pairs(v189) do
				if type(v198) == "number" and v198 > 0 then
					local v199 = v190[v196]
					if not v199 and v195 then
						v199 = v195:Clone()
						v199.Name = "Stat" .. v196
						v199.Parent = v_u_68
						table.insert(v190, v199)
					end
					if v199 then
						local v200 = v_u_73[v197] or "+%d%% " .. v197
						v199.Text = string.format(v200, v198)
						v199.Visible = true
						v196 = v196 + 1
					end
				elseif type(v198) == "table" then
					for v201, v202 in pairs(v198) do
						if type(v202) == "number" and v202 > 0 then
							local v203 = v190[v196]
							if not v203 and v195 then
								v203 = v195:Clone()
								v203.Name = "Stat" .. v196
								v203.Parent = v_u_68
								table.insert(v190, v203)
							end
							if v203 then
								v203.Text = string.format("+%d%% %s Damage", v202, v201)
								v203.Visible = true
								v196 = v196 + 1
							end
						end
					end
				end
			end
		end
		if v_u_69 then
			v_u_173({
				["Clan"] = p174.Clan or p174.Inventory and (p174.Inventory.Equipped and p174.Inventory.Equipped.Clan) or "None"
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
local function v_u_214(p205)
	-- upvalues: (copy) v_u_55, (copy) v_u_141, (copy) v_u_59, (copy) v_u_60, (copy) v_u_61, (copy) v_u_62
	if p205 then
		v_u_55.Text = "Stat Points: " .. v_u_141(p205.StatPoints or 0)
		local v206 = {
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
		for _, v207 in ipairs(v206) do
			local v208 = p205.Stats and (p205.Stats[v207.stat] or 0) or 0
			local v209 = v207.frame:FindFirstChild("Content")
			local v210 = v209 and v209:FindFirstChild("StatFrame") or v207.frame:FindFirstChild("StatFrame")
			if v210 then
				local v211 = v210:FindFirstChild("AutoSizeHolder")
				if v211 then
					local v212 = v211:FindFirstChild("StatValue")
					local v213 = v211:FindFirstChild("MaxTxt")
					if v212 then
						v212.Text = v_u_141(v208)
					end
					if v213 then
						v213.Visible = v208 >= 11500
					end
				end
			end
		end
	end
end
local function v_u_233(p215)
	-- upvalues: (copy) v_u_173, (copy) v_u_68, (copy) v_u_6, (copy) v_u_73
	if p215.Clan or p215.Inventory and (p215.Inventory.Equipped and p215.Inventory.Equipped.Clan) then
		v_u_173(p215)
	end
	if v_u_68 then
		local v216 = "Human"
		if p215 then
			if p215.Race then
				v216 = p215.Race
			elseif p215.Inventory and (p215.Inventory.Equipped and p215.Inventory.Equipped.Race) then
				v216 = p215.Inventory.Equipped.Race
			end
		end
		local v217 = v_u_68:FindFirstChild("StatName")
		if v217 then
			v217.Text = "Race: " .. v216
		end
		local v218 = v_u_6 and v_u_6.GetAllBuffs and (v_u_6:GetAllBuffs(v216) or {}) or {}
		local v219 = {}
		for _, v220 in ipairs(v_u_68:GetChildren()) do
			if v220:IsA("TextLabel") and v220.Name:match("^Stat%d+$") then
				table.insert(v219, v220)
			end
		end
		table.sort(v219, function(p221, p222)
			return p221.Name < p222.Name
		end)
		for _, v223 in ipairs(v219) do
			v223.Visible = false
		end
		local v224 = v_u_68:FindFirstChild("Stat1")
		local v225 = 1
		for v226, v227 in pairs(v218) do
			if type(v227) == "number" and v227 > 0 then
				local v228 = v219[v225]
				if not v228 and v224 then
					v228 = v224:Clone()
					v228.Name = "Stat" .. v225
					v228.Parent = v_u_68
					table.insert(v219, v228)
				end
				if v228 then
					local v229 = v_u_73[v226] or "+%d%% " .. v226
					v228.Text = string.format(v229, v227)
					v228.Visible = true
					v225 = v225 + 1
				end
			elseif type(v227) == "table" then
				for v230, v231 in pairs(v227) do
					if type(v231) == "number" and v231 > 0 then
						local v232 = v219[v225]
						if not v232 and v224 then
							v232 = v224:Clone()
							v232.Name = "Stat" .. v225
							v232.Parent = v_u_68
							table.insert(v219, v232)
						end
						if v232 then
							v232.Text = string.format("+%d%% %s Damage", v231, v230)
							v232.Visible = true
							v225 = v225 + 1
						end
					end
				end
			end
		end
	end
end
local function v_u_242(p234)
	-- upvalues: (copy) v_u_71, (copy) v_u_8
	if v_u_71 then
		local v235 = v_u_71:FindFirstChild("StatName")
		local v236 = v_u_71:FindFirstChild("Stat1")
		local v237 = v_u_71:FindFirstChild("Stat2")
		local v238 = v_u_71:FindFirstChild("Stat3")
		if v236 then
			v236.Visible = false
		end
		if v237 then
			v237.Visible = false
		end
		if v238 then
			v238.Visible = false
		end
		if p234 and p234 ~= "" then
			if v235 then
				v235.Text = "Trait: " .. p234
			end
			local v239 = v_u_8
			if v239 then
				v239 = v_u_8:GetTraitData(p234)
			end
			if v239 then
				local v240 = { v236, v237, v238 }
				local v241 = 1
				if v239.DamageMult and (v239.DamageMult > 1 and v240[v241]) then
					v240[v241].Text = string.format("%.2fx Damage", v239.DamageMult)
					v240[v241].Visible = true
					v241 = v241 + 1
				end
				if v239.DefenseMult and (v239.DefenseMult > 1 and v240[v241]) then
					v240[v241].Text = string.format("%.2fx Defense", v239.DefenseMult)
					v240[v241].Visible = true
					v241 = v241 + 1
				end
				if v239.CooldownReduction and (v239.CooldownReduction > 0 and v240[v241]) then
					v240[v241].Text = string.format("-%d%% Cooldown", v239.CooldownReduction)
					v240[v241].Visible = true
					local _ = v241 + 1
				end
			end
		else
			if v235 then
				v235.Text = "Trait: None"
			end
			return
		end
	else
		return
	end
end
local function v_u_261(p243)
	-- upvalues: (copy) v_u_233, (copy) v_u_242, (copy) v_u_111, (copy) v_u_129, (copy) v_u_30, (copy) v_u_148, (copy) v_u_42, (copy) v_u_43, (copy) v_u_44, (copy) v_u_45, (copy) v_u_10, (copy) v_u_35, (copy) v_u_36, (copy) v_u_141, (copy) v_u_37, (copy) v_u_38, (copy) v_u_39, (copy) v_u_40
	if p243 then
		if p243.Race or p243.Inventory and (p243.Inventory.Equipped and p243.Inventory.Equipped.Race) then
			v_u_233(p243)
		end
		if p243.Trait ~= nil then
			v_u_242(p243.Trait)
		end
		v_u_111(p243.RuneEquipped, p243.RuneProgression)
		if p243.RuneProgression then
			v_u_129(p243.RuneProgression)
		end
		local v244 = v_u_30
		local v245 = p243.Level or 0
		v244.Text = "Lv. " .. tostring(v245)
		local v246 = p243.Currency
		if v246 then
			v246 = p243.Currency.Money
		end
		local v247 = tonumber(v246) or 0
		local v248 = v247 ~= v247 and 0 or v247
		local v249 = p243.Currency
		if v249 then
			v249 = p243.Currency.Gems
		end
		local v250 = tonumber(v249) or 0
		local v251 = v250 ~= v250 and 0 or v250
		local v252 = v_u_148(v248)
		local v253 = v_u_148(v251)
		v_u_42.Text = v252
		v_u_43.Text = v252
		v_u_44.Text = v253
		v_u_45.Text = v253
		local v254 = v_u_10.Character
		if v254 then
			local v255 = v254:FindFirstChild("Humanoid")
			if v255 and v255.Health > 0 then
				local v256 = v255.Health / v255.MaxHealth
				v_u_35.Size = UDim2.new(v256, 0, 1, 0)
				v_u_36.Text = v_u_141(v255.Health)
				v_u_37.Text = "/" .. v_u_141(v255.MaxHealth)
			end
		end
		if p243.isMaxLevel or false then
			v_u_38.Size = UDim2.new(1, 0, 1, 0)
			v_u_39.Text = "MAX"
			v_u_40.Text = ""
		else
			local v257 = p243.Experience or 0
			local v258 = p243.xpRequired or 200
			local v259
			if v258 > 0 then
				local v260 = v257 / v258
				v259 = math.min(v260, 1) or 1
			else
				v259 = 1
			end
			v_u_38.Size = UDim2.new(v259, 0, 1, 0)
			v_u_39.Text = v_u_141(v257)
			v_u_40.Text = "/" .. v_u_141(v258)
		end
	else
		return
	end
end
local function v266()
	-- upvalues: (copy) v_u_21, (ref) v_u_75, (ref) v_u_76, (copy) v_u_261
	local v262 = 0
	local v263 = 0.5
	while v262 < 5 do
		v262 = v262 + 1
		if v262 > 1 then
			task.wait(v263)
			v263 = v263 * 1.5
		else
			task.wait(0.5)
		end
		if v_u_21:IsA("RemoteFunction") then
			local v264, v265 = pcall(function()
				-- upvalues: (ref) v_u_21
				return v_u_21:InvokeServer()
			end)
			if v264 and v265 then
				v_u_75 = v265
				v_u_76 = true
				v_u_261(v265)
				return true
			end
		end
	end
	warn("[StatsUI] Failed to load stats after " .. 5 .. " attempts")
	return false
end
local function v269()
	-- upvalues: (copy) v_u_27, (copy) v_u_204
	task.spawn(function()
		-- upvalues: (ref) v_u_27, (ref) v_u_204
		local v267, v268 = pcall(function()
			-- upvalues: (ref) v_u_27
			return v_u_27:InvokeServer()
		end)
		if v267 and v268 then
			v_u_204({
				["Melee"] = v268.Melee,
				["Sword"] = v268.Sword,
				["Power"] = v268.Power,
				["Accessory"] = v268.Accessory,
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
local function v_u_274()
	-- upvalues: (copy) v_u_1, (copy) v_u_10, (copy) v_u_54, (copy) v_u_204, (ref) v_u_78, (copy) v_u_21, (ref) v_u_75, (ref) v_u_76, (copy) v_u_261, (copy) v_u_214
	local v270, v271 = pcall(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_10
		return v_u_1:GetUserThumbnailAsync(v_u_10.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	if v270 and v271 then
		v_u_54.Image = v271
	end
	v_u_204(v_u_78)
	if v_u_21:IsA("RemoteFunction") then
		task.spawn(function()
			-- upvalues: (ref) v_u_21, (ref) v_u_75, (ref) v_u_76, (ref) v_u_261, (ref) v_u_214
			local v272, v273 = pcall(function()
				-- upvalues: (ref) v_u_21
				return v_u_21:InvokeServer()
			end)
			if v272 and v273 then
				v_u_75 = v273
				v_u_76 = true
				v_u_261(v273)
				v_u_214(v273)
			end
		end)
	elseif v_u_75 and v_u_76 then
		v_u_214(v_u_75)
	end
end
v46.Activated:Connect(function()
	-- upvalues: (copy) v_u_5, (copy) v_u_274
	if not v_u_5:IsOnCooldown() then
		v_u_5:Toggle("Stats")
		if v_u_5:IsOpen("Stats") then
			v_u_274()
		end
	end
end)
v49.Activated:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:Close("Stats")
end)
local function v287(p275, p_u_276)
	-- upvalues: (ref) v_u_75, (copy) v_u_16, (copy) v_u_58
	local v277 = p275:FindFirstChild("Content")
	if v277 then
		local v278 = v277:FindFirstChild("UpgradeFrame")
		local v279 = v278 and v278:FindFirstChild("AddPoints")
		if v279 then
			v279.Activated:Connect(function()
				-- upvalues: (ref) v_u_75, (ref) v_u_16, (copy) p_u_276, (ref) v_u_58
				if v_u_75 and (v_u_75.StatPoints or 0) > 0 then
					local v280 = v_u_16
					local v281 = p_u_276
					local v282 = v_u_58.Text
					local v283
					if v282 == "" or v282 == nil then
						v283 = 1
					else
						local v284 = tonumber(v282)
						if v284 then
							local v285 = math.abs(v284)
							local v286 = math.floor(v285)
							if v286 > 25000 then
								v_u_58.Text = tostring(25000)
								v286 = 25000
							end
							v283 = math.max(v286, 1)
						else
							warn("[StatsUI] Invalid amount: " .. v282)
							v283 = 1
						end
					end
					v280:FireServer(v281, v283)
				end
			end)
		end
	end
end
v287(v_u_59, "Melee")
v287(v_u_60, "Defense")
v287(v_u_61, "Sword")
v287(v_u_62, "Power")
v57.Activated:Connect(function()
	-- upvalues: (copy) v_u_17, (copy) v_u_3
	v_u_17:FireServer()
	v_u_3:Play("ResetStatPoints")
end)
v22.OnClientEvent:Connect(function(p288)
	-- upvalues: (ref) v_u_75, (ref) v_u_76, (copy) v_u_261, (copy) v_u_47, (copy) v_u_214, (copy) v_u_1, (copy) v_u_10, (copy) v_u_54
	if p288 then
		v_u_75 = p288
		v_u_76 = true
		v_u_261(p288)
		if v_u_47.Visible then
			v_u_214(p288)
			local v289, v290 = pcall(function()
				-- upvalues: (ref) v_u_1, (ref) v_u_10
				return v_u_1:GetUserThumbnailAsync(v_u_10.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)
			if v289 and v290 then
				v_u_54.Image = v290
			end
		end
	end
end)
v15.OnClientEvent:Connect(function(p291)
	-- upvalues: (ref) v_u_75, (ref) v_u_76, (copy) v_u_261, (copy) v_u_47, (copy) v_u_214
	if p291 then
		v_u_75 = p291
		v_u_76 = true
		v_u_261(p291)
		if v_u_47.Visible then
			v_u_214(p291)
		end
	end
end)
v19.OnClientEvent:Connect(function(p292, p293)
	-- upvalues: (ref) v_u_75, (copy) v_u_148, (copy) v_u_42, (copy) v_u_43, (copy) v_u_44, (copy) v_u_45
	local v294 = tonumber(p292) or 0
	local v295 = v294 ~= v294 and 0 or v294
	local v296 = tonumber(p293) or 0
	local v297 = v296 ~= v296 and 0 or v296
	if v_u_75 then
		v_u_75.Currency = v_u_75.Currency or {}
		v_u_75.Currency.Money = v295
		v_u_75.Currency.Gems = v297
	end
	local v298 = v_u_148(v295)
	local v299 = v_u_148(v297)
	v_u_42.Text = v298
	v_u_43.Text = v298
	v_u_44.Text = v299
	v_u_45.Text = v299
end)
v18.OnClientEvent:Connect(function(p300, _)
	-- upvalues: (copy) v_u_30
	v_u_30.Text = "Lv. " .. tostring(p300)
end)
v20.OnClientEvent:Connect(function(_) end)
v26.OnClientEvent:Connect(function(p301)
	-- upvalues: (copy) v_u_204
	if p301 then
		v_u_204(p301)
	end
end)
v23.OnClientEvent:Connect(function(p302)
	-- upvalues: (copy) v_u_242
	if p302 and p302.Trait ~= nil then
		v_u_242(p302.Trait)
	elseif p302 and p302.RolledTrait then
		v_u_242(p302.RolledTrait)
	end
end)
local function v_u_309(p303)
	-- upvalues: (ref) v_u_77, (copy) v_u_10, (copy) v_u_35, (copy) v_u_36, (copy) v_u_141, (copy) v_u_37
	if v_u_77 then
		v_u_77:Disconnect()
		v_u_77 = nil
	end
	local v304 = p303 or v_u_10.Character
	if v304 then
		local v_u_305 = v304:WaitForChild("Humanoid")
		if v_u_305 then
			local function v307()
				-- upvalues: (copy) v_u_305, (ref) v_u_35, (ref) v_u_36, (ref) v_u_141, (ref) v_u_37
				local v306 = v_u_305.Health / v_u_305.MaxHealth
				v_u_35.Size = UDim2.new(v306, 0, 1, 0)
				v_u_36.Text = v_u_141(v_u_305.Health)
				v_u_37.Text = "/" .. v_u_141(v_u_305.MaxHealth)
			end
			v_u_77 = v_u_305.HealthChanged:Connect(v307)
			local v308 = v_u_305.Health / v_u_305.MaxHealth
			v_u_35.Size = UDim2.new(v308, 0, 1, 0)
			v_u_36.Text = v_u_141(v_u_305.Health)
			v_u_37.Text = "/" .. v_u_141(v_u_305.MaxHealth)
		end
	else
		return
	end
end
v_u_10.CharacterAdded:Connect(function(p310)
	-- upvalues: (copy) v_u_309, (copy) v_u_21, (ref) v_u_75, (ref) v_u_76, (copy) v_u_261
	task.wait(0.1)
	v_u_309(p310)
	task.spawn(function()
		-- upvalues: (ref) v_u_21, (ref) v_u_75, (ref) v_u_76, (ref) v_u_261
		task.wait(0.5)
		if v_u_21:IsA("RemoteFunction") then
			local v311, v312 = pcall(function()
				-- upvalues: (ref) v_u_21
				return v_u_21:InvokeServer()
			end)
			if v311 and v312 then
				v_u_75 = v312
				v_u_76 = true
				v_u_261(v312)
			end
		end
	end)
end)
if v_u_10.Character then
	task.spawn(v_u_309, v_u_10.Character)
end
task.spawn(v266)
task.spawn(v269)