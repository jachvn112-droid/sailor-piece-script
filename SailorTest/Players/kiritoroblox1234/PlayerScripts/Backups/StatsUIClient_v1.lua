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
	["Lifesteal"] = "+%d%% Lifesteal"
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
local function v_u_168(p148)
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
		local v158 = v_u_69:FindFirstChild("Stat1")
		local v159 = 1
		for v160, v161 in pairs(v151) do
			if type(v161) == "number" and v161 > 0 then
				local v162 = v153[v159]
				if not v162 and v158 then
					v162 = v158:Clone()
					v162.Name = "Stat" .. v159
					v162.Parent = v_u_69
					table.insert(v153, v162)
				end
				if v162 then
					local v163 = v_u_74[v160] or "+%d%% " .. v160
					v162.Text = string.format(v163, v161)
					v162.Visible = true
					v159 = v159 + 1
				end
			elseif type(v161) == "table" then
				for v164, v165 in pairs(v161) do
					if type(v165) == "number" and v165 > 0 then
						local v166 = v153[v159]
						if not v166 and v158 then
							v166 = v158:Clone()
							v166.Name = "Stat" .. v159
							v166.Parent = v_u_69
							table.insert(v153, v166)
						end
						if v166 then
							v166.Text = string.format("+%d%% %s Damage", v165, v164)
							v166.Visible = true
							v159 = v159 + 1
						end
					end
				end
			end
		end
		if v152 then
			local v167 = v153[v159]
			if not v167 and v158 then
				v167 = v158:Clone()
				v167.Name = "Stat" .. v159
				v167.Parent = v_u_69
				table.insert(v153, v167)
			end
			if v167 then
				if v152.Type == "ExecuteDamage" then
					v167.Text = string.format("+%d%% DMG below %d%% HP", v152.Bonus, v152.Threshold)
				elseif v152.Type == "DropBonus" then
					v167.Text = string.format("%d%% chance +%d drop", v152.Chance, v152.Amount)
				else
					v167.Text = "Passive: " .. v152.Type
				end
				v167.Visible = true
			end
		end
	end
end
local function v_u_199(p169)
	-- upvalues: (ref) v_u_78, (copy) v_u_64, (copy) v_u_65, (copy) v_u_66, (copy) v_u_67, (copy) v_u_135, (copy) v_u_68, (copy) v_u_6, (copy) v_u_73, (copy) v_u_69, (copy) v_u_168, (copy) v_u_70
	if p169 then
		v_u_78 = p169
		local v170 = p169.Melee or "None"
		local v171 = p169.Sword or "None"
		local v172 = p169.Power or "None"
		v_u_64.Stat.Text = v170
		v_u_65.Stat.Text = v171
		v_u_66.Stat.Text = v172
		local v173 = p169.Accessory
		local v174 = p169.AccessoryStats
		local v175 = p169.AccessoryEnchantLevel or 0
		if v173 and v173 ~= "" then
			if v175 > 0 then
				v173 = v173 .. " [E" .. v175 .. "]"
			end
			v_u_67.StatName.Text = "Accessory: " .. v173
			local v176 = { v_u_67.Stat1, v_u_67.Stat2, v_u_67.Stat3 }
			local v177 = 1
			for _, v178 in ipairs(v176) do
				v178.Visible = false
			end
			if v174 then
				for v179, v180 in pairs(v174) do
					if v180 and (v180 > 0 and v177 <= 3) then
						local v181 = v_u_135[v179] or "+%d%% " .. v179
						v176[v177].Text = string.format(v181, v180)
						v176[v177].Visible = true
						v177 = v177 + 1
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
			local v182 = p169.Race or "Human"
			local v183 = v_u_68:FindFirstChild("StatName")
			if v183 then
				v183.Text = "Race: " .. v182
			end
			local v184 = v_u_6 and v_u_6.GetAllBuffs and (v_u_6:GetAllBuffs(v182) or {}) or {}
			local v185 = {}
			for _, v186 in ipairs(v_u_68:GetChildren()) do
				if v186:IsA("TextLabel") and v186.Name:match("^Stat%d+$") then
					table.insert(v185, v186)
				end
			end
			table.sort(v185, function(p187, p188)
				return p187.Name < p188.Name
			end)
			for _, v189 in ipairs(v185) do
				v189.Visible = false
			end
			local v190 = v_u_68:FindFirstChild("Stat1")
			local v191 = 1
			for v192, v193 in pairs(v184) do
				if type(v193) == "number" and v193 > 0 then
					local v194 = v185[v191]
					if not v194 and v190 then
						v194 = v190:Clone()
						v194.Name = "Stat" .. v191
						v194.Parent = v_u_68
						table.insert(v185, v194)
					end
					if v194 then
						local v195 = v_u_73[v192] or "+%d%% " .. v192
						v194.Text = string.format(v195, v193)
						v194.Visible = true
						v191 = v191 + 1
					end
				elseif type(v193) == "table" then
					for v196, v197 in pairs(v193) do
						if type(v197) == "number" and v197 > 0 then
							local v198 = v185[v191]
							if not v198 and v190 then
								v198 = v190:Clone()
								v198.Name = "Stat" .. v191
								v198.Parent = v_u_68
								table.insert(v185, v198)
							end
							if v198 then
								v198.Text = string.format("+%d%% %s Damage", v197, v196)
								v198.Visible = true
								v191 = v191 + 1
							end
						end
					end
				end
			end
		end
		if v_u_69 then
			v_u_168({
				["Clan"] = p169.Clan or p169.Inventory and (p169.Inventory.Equipped and p169.Inventory.Equipped.Clan) or "None"
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
local function v_u_209(p200)
	-- upvalues: (copy) v_u_55, (copy) v_u_141, (copy) v_u_59, (copy) v_u_60, (copy) v_u_61, (copy) v_u_62
	if p200 then
		v_u_55.Text = "Stat Points: " .. v_u_141(p200.StatPoints or 0)
		local v201 = {
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
		for _, v202 in ipairs(v201) do
			local v203 = p200.Stats and (p200.Stats[v202.stat] or 0) or 0
			local v204 = v202.frame:FindFirstChild("Content")
			local v205 = v204 and v204:FindFirstChild("StatFrame") or v202.frame:FindFirstChild("StatFrame")
			if v205 then
				local v206 = v205:FindFirstChild("AutoSizeHolder")
				if v206 then
					local v207 = v206:FindFirstChild("StatValue")
					local v208 = v206:FindFirstChild("MaxTxt")
					if v207 then
						v207.Text = v_u_141(v203)
					end
					if v208 then
						v208.Visible = v203 >= 10000
					end
				end
			end
		end
	end
end
local function v_u_228(p210)
	-- upvalues: (copy) v_u_168, (copy) v_u_68, (copy) v_u_6, (copy) v_u_73
	if p210.Clan or p210.Inventory and (p210.Inventory.Equipped and p210.Inventory.Equipped.Clan) then
		v_u_168(p210)
	end
	if v_u_68 then
		local v211 = "Human"
		if p210 then
			if p210.Race then
				v211 = p210.Race
			elseif p210.Inventory and (p210.Inventory.Equipped and p210.Inventory.Equipped.Race) then
				v211 = p210.Inventory.Equipped.Race
			end
		end
		local v212 = v_u_68:FindFirstChild("StatName")
		if v212 then
			v212.Text = "Race: " .. v211
		end
		local v213 = v_u_6 and v_u_6.GetAllBuffs and (v_u_6:GetAllBuffs(v211) or {}) or {}
		local v214 = {}
		for _, v215 in ipairs(v_u_68:GetChildren()) do
			if v215:IsA("TextLabel") and v215.Name:match("^Stat%d+$") then
				table.insert(v214, v215)
			end
		end
		table.sort(v214, function(p216, p217)
			return p216.Name < p217.Name
		end)
		for _, v218 in ipairs(v214) do
			v218.Visible = false
		end
		local v219 = v_u_68:FindFirstChild("Stat1")
		local v220 = 1
		for v221, v222 in pairs(v213) do
			if type(v222) == "number" and v222 > 0 then
				local v223 = v214[v220]
				if not v223 and v219 then
					v223 = v219:Clone()
					v223.Name = "Stat" .. v220
					v223.Parent = v_u_68
					table.insert(v214, v223)
				end
				if v223 then
					local v224 = v_u_73[v221] or "+%d%% " .. v221
					v223.Text = string.format(v224, v222)
					v223.Visible = true
					v220 = v220 + 1
				end
			elseif type(v222) == "table" then
				for v225, v226 in pairs(v222) do
					if type(v226) == "number" and v226 > 0 then
						local v227 = v214[v220]
						if not v227 and v219 then
							v227 = v219:Clone()
							v227.Name = "Stat" .. v220
							v227.Parent = v_u_68
							table.insert(v214, v227)
						end
						if v227 then
							v227.Text = string.format("+%d%% %s Damage", v226, v225)
							v227.Visible = true
							v220 = v220 + 1
						end
					end
				end
			end
		end
	end
end
local function v_u_237(p229)
	-- upvalues: (copy) v_u_71, (copy) v_u_8
	if v_u_71 then
		local v230 = v_u_71:FindFirstChild("StatName")
		local v231 = v_u_71:FindFirstChild("Stat1")
		local v232 = v_u_71:FindFirstChild("Stat2")
		local v233 = v_u_71:FindFirstChild("Stat3")
		if v231 then
			v231.Visible = false
		end
		if v232 then
			v232.Visible = false
		end
		if v233 then
			v233.Visible = false
		end
		if p229 and p229 ~= "" then
			if v230 then
				v230.Text = "Trait: " .. p229
			end
			local v234 = v_u_8
			if v234 then
				v234 = v_u_8:GetTraitData(p229)
			end
			if v234 then
				local v235 = { v231, v232, v233 }
				local v236 = 1
				if v234.DamageMult and (v234.DamageMult > 1 and v235[v236]) then
					v235[v236].Text = string.format("%.2fx Damage", v234.DamageMult)
					v235[v236].Visible = true
					v236 = v236 + 1
				end
				if v234.DefenseMult and (v234.DefenseMult > 1 and v235[v236]) then
					v235[v236].Text = string.format("%.2fx Defense", v234.DefenseMult)
					v235[v236].Visible = true
					v236 = v236 + 1
				end
				if v234.CooldownReduction and (v234.CooldownReduction > 0 and v235[v236]) then
					v235[v236].Text = string.format("-%d%% Cooldown", v234.CooldownReduction)
					v235[v236].Visible = true
					local _ = v236 + 1
				end
			end
		else
			if v230 then
				v230.Text = "Trait: None"
			end
			return
		end
	else
		return
	end
end
local function v_u_254(p238)
	-- upvalues: (copy) v_u_228, (copy) v_u_237, (copy) v_u_111, (copy) v_u_129, (copy) v_u_30, (copy) v_u_147, (copy) v_u_42, (copy) v_u_43, (copy) v_u_44, (copy) v_u_45, (copy) v_u_10, (copy) v_u_35, (copy) v_u_36, (copy) v_u_141, (copy) v_u_37, (copy) v_u_38, (copy) v_u_39, (copy) v_u_40
	if p238 then
		if p238.Race or p238.Inventory and (p238.Inventory.Equipped and p238.Inventory.Equipped.Race) then
			v_u_228(p238)
		end
		if p238.Trait ~= nil then
			v_u_237(p238.Trait)
		end
		v_u_111(p238.RuneEquipped, p238.RuneProgression)
		if p238.RuneProgression then
			v_u_129(p238.RuneProgression)
		end
		local v239 = v_u_30
		local v240 = p238.Level or 0
		v239.Text = "Lv. " .. tostring(v240)
		local v241 = p238.Currency and (p238.Currency.Money or 0) or 0
		local v242 = tonumber(v241)
		local v243 = p238.Currency and (p238.Currency.Gems or 0) or 0
		local v244 = tonumber(v243)
		local v245 = v_u_147(v242)
		local v246 = v_u_147(v244)
		v_u_42.Text = v245
		v_u_43.Text = v245
		v_u_44.Text = v246
		v_u_45.Text = v246
		local v247 = v_u_10.Character
		if v247 then
			local v248 = v247:FindFirstChild("Humanoid")
			if v248 and v248.Health > 0 then
				local v249 = v248.Health / v248.MaxHealth
				v_u_35.Size = UDim2.new(v249, 0, 1, 0)
				v_u_36.Text = v_u_141(v248.Health)
				v_u_37.Text = "/" .. v_u_141(v248.MaxHealth)
			end
		end
		if p238.isMaxLevel or false then
			v_u_38.Size = UDim2.new(1, 0, 1, 0)
			v_u_39.Text = "MAX"
			v_u_40.Text = ""
		else
			local v250 = p238.Experience or 0
			local v251 = p238.xpRequired or 200
			local v252
			if v251 > 0 then
				local v253 = v250 / v251
				v252 = math.min(v253, 1) or 1
			else
				v252 = 1
			end
			v_u_38.Size = UDim2.new(v252, 0, 1, 0)
			v_u_39.Text = v_u_141(v250)
			v_u_40.Text = "/" .. v_u_141(v251)
		end
	else
		return
	end
end
local function v259()
	-- upvalues: (copy) v_u_21, (ref) v_u_75, (ref) v_u_76, (copy) v_u_254
	local v255 = 0
	local v256 = 0.5
	while v255 < 5 do
		v255 = v255 + 1
		if v255 > 1 then
			task.wait(v256)
			v256 = v256 * 1.5
		else
			task.wait(0.5)
		end
		if v_u_21:IsA("RemoteFunction") then
			local v257, v258 = pcall(function()
				-- upvalues: (ref) v_u_21
				return v_u_21:InvokeServer()
			end)
			if v257 and v258 then
				v_u_75 = v258
				v_u_76 = true
				v_u_254(v258)
				return true
			end
		end
	end
	warn("[StatsUI] Failed to load stats after " .. 5 .. " attempts")
	return false
end
local function v262()
	-- upvalues: (copy) v_u_27, (copy) v_u_199
	task.spawn(function()
		-- upvalues: (ref) v_u_27, (ref) v_u_199
		local v260, v261 = pcall(function()
			-- upvalues: (ref) v_u_27
			return v_u_27:InvokeServer()
		end)
		if v260 and v261 then
			v_u_199({
				["Melee"] = v261.Melee,
				["Sword"] = v261.Sword,
				["Power"] = v261.Power,
				["Accessory"] = v261.Accessory,
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
local function v_u_267()
	-- upvalues: (copy) v_u_1, (copy) v_u_10, (copy) v_u_54, (copy) v_u_199, (ref) v_u_78, (copy) v_u_21, (ref) v_u_75, (ref) v_u_76, (copy) v_u_254, (copy) v_u_209
	local v263, v264 = pcall(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_10
		return v_u_1:GetUserThumbnailAsync(v_u_10.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	if v263 and v264 then
		v_u_54.Image = v264
	end
	v_u_199(v_u_78)
	if v_u_21:IsA("RemoteFunction") then
		task.spawn(function()
			-- upvalues: (ref) v_u_21, (ref) v_u_75, (ref) v_u_76, (ref) v_u_254, (ref) v_u_209
			local v265, v266 = pcall(function()
				-- upvalues: (ref) v_u_21
				return v_u_21:InvokeServer()
			end)
			if v265 and v266 then
				v_u_75 = v266
				v_u_76 = true
				v_u_254(v266)
				v_u_209(v266)
			end
		end)
	elseif v_u_75 and v_u_76 then
		v_u_209(v_u_75)
	end
end
v46.Activated:Connect(function()
	-- upvalues: (copy) v_u_5, (copy) v_u_267
	if not v_u_5:IsOnCooldown() then
		v_u_5:Toggle("Stats")
		if v_u_5:IsOpen("Stats") then
			v_u_267()
		end
	end
end)
v49.Activated:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:Close("Stats")
end)
local function v280(p268, p_u_269)
	-- upvalues: (ref) v_u_75, (copy) v_u_16, (copy) v_u_58
	local v270 = p268:FindFirstChild("Content")
	if v270 then
		local v271 = v270:FindFirstChild("UpgradeFrame")
		local v272 = v271 and v271:FindFirstChild("AddPoints")
		if v272 then
			v272.Activated:Connect(function()
				-- upvalues: (ref) v_u_75, (ref) v_u_16, (copy) p_u_269, (ref) v_u_58
				if v_u_75 and (v_u_75.StatPoints or 0) > 0 then
					local v273 = v_u_16
					local v274 = p_u_269
					local v275 = v_u_58.Text
					local v276
					if v275 == "" or v275 == nil then
						v276 = 1
					else
						local v277 = tonumber(v275)
						if v277 then
							local v278 = math.abs(v277)
							local v279 = math.floor(v278)
							if v279 > 25000 then
								v_u_58.Text = tostring(25000)
								v279 = 25000
							end
							v276 = math.max(v279, 1)
						else
							warn("[StatsUI] Invalid amount: " .. v275)
							v276 = 1
						end
					end
					v273:FireServer(v274, v276)
				end
			end)
		end
	end
end
v280(v_u_59, "Melee")
v280(v_u_60, "Defense")
v280(v_u_61, "Sword")
v280(v_u_62, "Power")
v57.Activated:Connect(function()
	-- upvalues: (copy) v_u_17, (copy) v_u_3
	v_u_17:FireServer()
	v_u_3:Play("ResetStatPoints")
end)
v22.OnClientEvent:Connect(function(p281)
	-- upvalues: (ref) v_u_75, (ref) v_u_76, (copy) v_u_254, (copy) v_u_47, (copy) v_u_209, (copy) v_u_1, (copy) v_u_10, (copy) v_u_54
	if p281 then
		v_u_75 = p281
		v_u_76 = true
		v_u_254(p281)
		if v_u_47.Visible then
			v_u_209(p281)
			local v282, v283 = pcall(function()
				-- upvalues: (ref) v_u_1, (ref) v_u_10
				return v_u_1:GetUserThumbnailAsync(v_u_10.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)
			if v282 and v283 then
				v_u_54.Image = v283
			end
		end
	end
end)
v15.OnClientEvent:Connect(function(p284)
	-- upvalues: (ref) v_u_75, (ref) v_u_76, (copy) v_u_254, (copy) v_u_47, (copy) v_u_209
	if p284 then
		v_u_75 = p284
		v_u_76 = true
		v_u_254(p284)
		if v_u_47.Visible then
			v_u_209(p284)
		end
	end
end)
v19.OnClientEvent:Connect(function(p285, p286)
	-- upvalues: (ref) v_u_75, (copy) v_u_147, (copy) v_u_42, (copy) v_u_43, (copy) v_u_44, (copy) v_u_45
	local v287 = tonumber(p285) or 0
	local v288 = tonumber(p286) or 0
	if v_u_75 then
		v_u_75.Currency = v_u_75.Currency or {}
		v_u_75.Currency.Money = v287
		v_u_75.Currency.Gems = v288
	end
	local v289 = v_u_147(v287)
	local v290 = v_u_147(v288)
	v_u_42.Text = v289
	v_u_43.Text = v289
	v_u_44.Text = v290
	v_u_45.Text = v290
end)
v18.OnClientEvent:Connect(function(p291, _)
	-- upvalues: (copy) v_u_30
	v_u_30.Text = "Lv. " .. tostring(p291)
end)
v20.OnClientEvent:Connect(function(_) end)
v26.OnClientEvent:Connect(function(p292)
	-- upvalues: (copy) v_u_199
	if p292 then
		v_u_199(p292)
	end
end)
v23.OnClientEvent:Connect(function(p293)
	-- upvalues: (copy) v_u_237
	if p293 and p293.Trait ~= nil then
		v_u_237(p293.Trait)
	elseif p293 and p293.RolledTrait then
		v_u_237(p293.RolledTrait)
	end
end)
local function v_u_300(p294)
	-- upvalues: (ref) v_u_77, (copy) v_u_10, (copy) v_u_35, (copy) v_u_36, (copy) v_u_141, (copy) v_u_37
	if v_u_77 then
		v_u_77:Disconnect()
		v_u_77 = nil
	end
	local v295 = p294 or v_u_10.Character
	if v295 then
		local v_u_296 = v295:WaitForChild("Humanoid")
		if v_u_296 then
			local function v298()
				-- upvalues: (copy) v_u_296, (ref) v_u_35, (ref) v_u_36, (ref) v_u_141, (ref) v_u_37
				local v297 = v_u_296.Health / v_u_296.MaxHealth
				v_u_35.Size = UDim2.new(v297, 0, 1, 0)
				v_u_36.Text = v_u_141(v_u_296.Health)
				v_u_37.Text = "/" .. v_u_141(v_u_296.MaxHealth)
			end
			v_u_77 = v_u_296.HealthChanged:Connect(v298)
			local v299 = v_u_296.Health / v_u_296.MaxHealth
			v_u_35.Size = UDim2.new(v299, 0, 1, 0)
			v_u_36.Text = v_u_141(v_u_296.Health)
			v_u_37.Text = "/" .. v_u_141(v_u_296.MaxHealth)
		end
	else
		return
	end
end
v_u_10.CharacterAdded:Connect(function(p301)
	-- upvalues: (copy) v_u_300, (copy) v_u_21, (ref) v_u_75, (ref) v_u_76, (copy) v_u_254
	task.wait(0.1)
	v_u_300(p301)
	task.spawn(function()
		-- upvalues: (ref) v_u_21, (ref) v_u_75, (ref) v_u_76, (ref) v_u_254
		task.wait(0.5)
		if v_u_21:IsA("RemoteFunction") then
			local v302, v303 = pcall(function()
				-- upvalues: (ref) v_u_21
				return v_u_21:InvokeServer()
			end)
			if v302 and v303 then
				v_u_75 = v303
				v_u_76 = true
				v_u_254(v303)
			end
		end
	end)
end)
if v_u_10.Character then
	task.spawn(v_u_300, v_u_10.Character)
end
task.spawn(v259)
task.spawn(v262)