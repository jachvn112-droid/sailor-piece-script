local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v4 = v2:WaitForChild("Modules")
local v_u_5 = require(v4:WaitForChild("StatRerollConfig"))
local v_u_6 = require(v4:WaitForChild("UIManager"))
local v7 = v3:WaitForChild("RerollStatsUI"):WaitForChild("MainFrame")
local v8 = v7:WaitForChild("Frame")
local v9 = v8:WaitForChild("Content")
local v_u_10 = v9:WaitForChild("Stats")
local v11 = v9:WaitForChild("Info")
local v12 = v8:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v13 = v11:WaitForChild("RerollAllStatsAtOnceButton")
local v_u_14 = v13:WaitForChild("RerollAllStatsAtOnceButton")
local v15 = v13:WaitForChild("AutoFrame"):WaitForChild("Holder"):WaitForChild("Checkmark")
local v_u_16 = v15:WaitForChild("Icon")
local v_u_17 = v11:WaitForChild("CurrentAmountOfGemsYouHaveLabel")
local v_u_18 = v11:WaitForChild("PityLabel")
local v_u_19 = v3:WaitForChild("ConfirmUI")
local v_u_20 = v_u_19:WaitForChild("MainFrame")
local v21 = v_u_20:WaitForChild("ButtonsHolder")
local v_u_22 = v21:WaitForChild("Yes")
local v_u_23 = v21:WaitForChild("No")
local v_u_24 = v21:WaitForChild("Input")
local v_u_25 = v_u_20:WaitForChild("InfoHolder"):WaitForChild("Txt")
local v26 = v9:WaitForChild("AutoSkip"):WaitForChild("Buttons")
local v_u_27 = {
	["A"] = v26:FindFirstChild("ARank"),
	["S"] = v26:FindFirstChild("SRank"),
	["SS"] = v26:FindFirstChild("SSRank")
}
local v28 = v2:WaitForChild("RemoteEvents")
local v29 = v2:WaitForChild("Remotes")
local v30 = v28:WaitForChild("OpenStatRerollUI")
local v_u_31 = v29:WaitForChild("RerollAllStats")
local v_u_32 = v29:WaitForChild("RerollSingleStat")
local v_u_33 = v29:WaitForChild("GetStatRerollData")
local v34 = v28:WaitForChild("StatRerollUpdate")
local v_u_35 = v28:WaitForChild("StatRerollUpdateAutoSkip")
local v_u_36 = false
local v_u_37 = nil
local v_u_38 = {}
local v_u_39 = 0
local v_u_40 = 0
local v_u_41 = {
	["RerollAll"] = 500,
	["RerollSingle"] = 1000
}
local v_u_42 = 200
local v_u_43 = 0
local v_u_44 = false
local v_u_45 = {}
local v_u_46 = {
	["A"] = false,
	["S"] = false,
	["SS"] = false
}
local v_u_47 = false
local v_u_48 = {}
local v_u_49 = false
local v_u_50 = {
	["Damage"] = "Damage[1]",
	["Defense"] = "Defense[2]",
	["CooldownReduction"] = "CooldownReduction[3]",
	["CritChance"] = "CritChance[4]",
	["CritDamage"] = "CritDamage[5]",
	["DamageReduction"] = "DamageReduction[6]",
	["Luck"] = "Luck[7]"
}
local v_u_51 = {
	["Damage"] = "Damage",
	["Defense"] = "Defense",
	["CooldownReduction"] = "CooldownReduction",
	["CritChance"] = "CritChance",
	["CritDamage"] = "CritDamage",
	["DamageReduction"] = "DmgReduction",
	["Luck"] = "Luck"
}
local function v_u_53()
	-- upvalues: (ref) v_u_45
	for _, v52 in ipairs(v_u_45) do
		if v52.Connected then
			v52:Disconnect()
		end
	end
	v_u_45 = {}
end
local function v_u_60(p54)
	local v55 = tostring(p54)
	local v56 = #v55 % 3
	local v57 = v56 == 0 and 3 or v56
	local v58 = v55:sub(1, v57)
	for v59 = v57 + 1, #v55, 3 do
		v58 = v58 .. "," .. v55:sub(v59, v59 + 2)
	end
	return v58
end
local function v_u_63()
	-- upvalues: (copy) v_u_5, (ref) v_u_48
	local v61 = {}
	for _, v62 in ipairs(v_u_5.StatKeys) do
		if v_u_48[v62] then
			table.insert(v61, v62)
		end
	end
	return v61
end
local function v_u_78(p64, p65)
	-- upvalues: (copy) v_u_50, (copy) v_u_51, (copy) v_u_10, (copy) v_u_5
	local v66 = v_u_50[p64]
	local v67 = v_u_51[p64]
	if v66 and v67 then
		local v68 = v_u_10:FindFirstChild(v66)
		if v68 then
			local v69 = p65.Rank or "F"
			local v70 = p65.Value or 0
			local v71 = v_u_5.GetRankColor(v69)
			local v72 = v68:FindFirstChild("Part2")
			if v72 then
				local v73 = v72:FindFirstChild("Holder")
				local v74 = v73 and v73:FindFirstChild("StatRankYouGotFromRollingThisStat" .. v67)
				if v74 then
					v74.Text = v69
					v74.TextColor3 = v71
				end
			end
			local v75 = v68:FindFirstChild("Part3")
			if v75 then
				local v76 = v75:FindFirstChild("Holder")
				local v77 = v76 and v76:FindFirstChild("PercentageAmountYouGotForThisStatFromReroll" .. v67)
				if v77 then
					v77.Text = "+" .. (v70 % 1 == 0 and tostring(v70) or string.format("%.1f", v70)) .. "%"
				end
			end
		end
	else
		return
	end
end
local function v_u_84()
	-- upvalues: (copy) v_u_27, (ref) v_u_46
	for v79, v80 in pairs(v_u_27) do
		if v80 then
			local v81 = v80:FindFirstChild("On")
			local v82 = v80:FindFirstChild("Off")
			if v81 and v82 then
				local v83 = v_u_46[v79] == true
				v81.Visible = v83
				v82.Visible = not v83
			end
		end
	end
end
local function v_u_98()
	-- upvalues: (copy) v_u_16, (ref) v_u_47, (copy) v_u_50, (copy) v_u_10, (ref) v_u_48, (copy) v_u_14, (ref) v_u_49
	v_u_16.Visible = v_u_47
	for _, v85 in pairs(v_u_50) do
		local v86 = v_u_10:FindFirstChild(v85)
		if v86 then
			local v87 = v86:FindFirstChild("Part4")
			if v87 then
				local v88 = v87:FindFirstChild("AutoFrame")
				if v88 then
					v88.Visible = v_u_47
				end
			end
		end
	end
	for v89, v90 in pairs(v_u_50) do
		local v91 = v_u_10:FindFirstChild(v90)
		if v91 then
			local v92 = v91:FindFirstChild("Part4")
			if v92 then
				local v93 = v92:FindFirstChild("AutoFrame")
				if v93 then
					local v94 = v93:FindFirstChild("Holder")
					if v94 then
						local v95 = v94:FindFirstChild("Checkmark")
						if v95 then
							local v96 = v95:FindFirstChild("Icon")
							if v96 then
								v96.Visible = v_u_48[v89] == true
							end
						end
					end
				end
			end
		end
	end
	local v97 = v_u_14:FindFirstChild("Txt")
	if v97 then
		v97.Text = v_u_49 and "Stop" or "Reroll All"
	end
end
local function v_u_108(p99, p_u_100)
	-- upvalues: (ref) v_u_36, (ref) v_u_37, (copy) v_u_19, (copy) v_u_20, (copy) v_u_53, (copy) v_u_25, (copy) v_u_24, (ref) v_u_45, (copy) v_u_22, (ref) v_u_43, (copy) v_u_23
	if v_u_36 and v_u_36 then
		v_u_36 = false
		v_u_37 = nil
		v_u_19.Enabled = false
		v_u_20.Visible = false
		v_u_53()
	end
	local v_u_101 = {}
	v_u_37 = v_u_101
	v_u_36 = true
	v_u_25.Text = p99
	v_u_24.Visible = false
	v_u_19.Enabled = true
	v_u_20.Visible = true
	v_u_53()
	local v102 = v_u_45
	local v103 = v_u_22.MouseButton1Click
	local function v104()
		-- upvalues: (ref) v_u_43, (ref) v_u_37, (copy) v_u_101, (ref) v_u_36, (ref) v_u_19, (ref) v_u_20, (ref) v_u_53, (copy) p_u_100
		if tick() - v_u_43 < 0.125 then
			return
		elseif v_u_37 == v_u_101 then
			if v_u_36 then
				v_u_36 = false
				v_u_37 = nil
				v_u_19.Enabled = false
				v_u_20.Visible = false
				v_u_53()
			end
			if p_u_100 then
				task.wait(0.05)
				p_u_100()
			end
		end
	end
	table.insert(v102, v103:Connect(v104))
	local v105 = v_u_45
	local v106 = v_u_23.MouseButton1Click
	local function v107()
		-- upvalues: (ref) v_u_43, (ref) v_u_37, (copy) v_u_101, (ref) v_u_36, (ref) v_u_19, (ref) v_u_20, (ref) v_u_53
		if tick() - v_u_43 < 0.125 then
			return
		elseif v_u_37 == v_u_101 then
			v_u_43 = tick()
			if v_u_36 then
				v_u_36 = false
				v_u_37 = nil
				v_u_19.Enabled = false
				v_u_20.Visible = false
				v_u_53()
			end
		else
			return
		end
	end
	table.insert(v105, v106:Connect(v107))
	task.spawn(function()
		-- upvalues: (ref) v_u_37, (copy) v_u_101, (ref) v_u_19, (ref) v_u_20, (ref) v_u_36, (ref) v_u_53
		while v_u_37 == v_u_101 do
			task.wait(0.1)
			if v_u_37 == v_u_101 and not (v_u_19.Enabled and v_u_20.Visible) then
				if v_u_36 then
					v_u_36 = false
					v_u_37 = nil
					v_u_53()
					return
				end
				break
			end
		end
	end)
end
local function v_u_113()
	-- upvalues: (ref) v_u_40, (ref) v_u_41, (copy) v_u_31, (ref) v_u_38, (ref) v_u_39, (copy) v_u_78, (copy) v_u_17, (copy) v_u_60, (copy) v_u_18, (ref) v_u_42, (copy) v_u_84, (copy) v_u_98
	if v_u_40 < v_u_41.RerollAll then
		return false
	end
	local v109, v110 = pcall(function()
		-- upvalues: (ref) v_u_31
		return v_u_31:InvokeServer()
	end)
	if not (v109 and (v110 and v110.success)) then
		return false
	end
	v_u_38 = v110.Stats or v_u_38
	v_u_39 = v110.SSPity or v_u_39
	v_u_40 = v110.Gems or v_u_40
	for v111, v112 in pairs(v_u_38) do
		v_u_78(v111, v112)
	end
	v_u_17.Text = v_u_60(v_u_40) .. " Gems"
	v_u_18.Text = "Pity: " .. v_u_39 .. "/" .. v_u_42
	v_u_84()
	v_u_98()
	return true
end
local function v_u_119(p_u_114)
	-- upvalues: (ref) v_u_40, (ref) v_u_41, (copy) v_u_32, (ref) v_u_38, (ref) v_u_39, (copy) v_u_78, (copy) v_u_17, (copy) v_u_60, (copy) v_u_18, (ref) v_u_42, (copy) v_u_84, (copy) v_u_98
	if v_u_40 < v_u_41.RerollSingle then
		return false
	end
	local v115, v116 = pcall(function()
		-- upvalues: (ref) v_u_32, (copy) p_u_114
		return v_u_32:InvokeServer(p_u_114)
	end)
	if not (v115 and (v116 and v116.success)) then
		return false
	end
	v_u_38 = v116.Stats or v_u_38
	v_u_39 = v116.SSPity or v_u_39
	v_u_40 = v116.Gems or v_u_40
	for v117, v118 in pairs(v_u_38) do
		v_u_78(v117, v118)
	end
	v_u_17.Text = v_u_60(v_u_40) .. " Gems"
	v_u_18.Text = "Pity: " .. v_u_39 .. "/" .. v_u_42
	v_u_84()
	v_u_98()
	return true
end
local function v_u_123()
	-- upvalues: (ref) v_u_38, (copy) v_u_5, (ref) v_u_46
	for v120, v121 in pairs(v_u_38) do
		local v122 = v121.Rank
		if v122 and v_u_5.NeedsConfirmation(v122) and ((v122 ~= "A" or not v_u_46.A) and (v122 ~= "S" or not v_u_46.S) and (v122 ~= "SS" or not v_u_46.SS)) then
			return true, v120, v122
		end
	end
	return false
end
local function v127()
	-- upvalues: (ref) v_u_43, (ref) v_u_49, (copy) v_u_98, (ref) v_u_40, (ref) v_u_41, (ref) v_u_47, (copy) v_u_63, (copy) v_u_5, (copy) v_u_119, (ref) v_u_38, (ref) v_u_46, (copy) v_u_113, (ref) v_u_44, (copy) v_u_123, (copy) v_u_108
	if tick() - v_u_43 < 0.125 then
		return
	else
		v_u_43 = tick()
		if v_u_49 then
			v_u_49 = false
			v_u_98()
			return
		elseif v_u_40 < v_u_41.RerollAll then
			return
		elseif v_u_47 then
			if v_u_49 then
				v_u_49 = false
				v_u_98()
			else
				v_u_49 = true
				v_u_98()
				task.spawn(function()
					-- upvalues: (ref) v_u_49, (ref) v_u_63, (ref) v_u_5, (ref) v_u_41, (ref) v_u_40, (ref) v_u_98, (ref) v_u_119, (ref) v_u_38, (ref) v_u_46, (ref) v_u_113
					-- failed to decompile
				end)
			end
		elseif v_u_44 then
			return
		else
			local v124, v125, v126 = v_u_123()
			if v124 then
				v_u_108("You have a " .. v126 .. " rank " .. (v_u_5.StatDisplayNames[v125] or v125) .. "!\nAre you sure you want to reroll all stats?", function()
					-- upvalues: (ref) v_u_44, (ref) v_u_113
					v_u_44 = true
					v_u_113()
					v_u_44 = false
				end)
			else
				v_u_44 = true
				v_u_113()
				v_u_44 = false
			end
		end
	end
end
local function v_u_136(p_u_128)
	-- upvalues: (ref) v_u_43, (ref) v_u_49, (copy) v_u_98, (ref) v_u_40, (ref) v_u_41, (ref) v_u_47, (copy) v_u_119, (ref) v_u_38, (copy) v_u_5, (ref) v_u_46, (ref) v_u_44, (copy) v_u_108
	if tick() - v_u_43 < 0.125 then
		return
	else
		v_u_43 = tick()
		if v_u_49 then
			v_u_49 = false
			v_u_98()
			return
		elseif v_u_40 < v_u_41.RerollSingle then
			return
		elseif v_u_47 then
			if v_u_49 then
				v_u_49 = false
				v_u_98()
			else
				v_u_49 = true
				v_u_98()
				task.spawn(function()
					-- upvalues: (ref) v_u_49, (ref) v_u_40, (ref) v_u_41, (ref) v_u_98, (ref) v_u_119, (copy) p_u_128, (ref) v_u_38, (ref) v_u_5, (ref) v_u_46
					while v_u_49 do
						if v_u_40 < v_u_41.RerollSingle then
							v_u_49 = false
							v_u_98()
							return
						end
						v_u_119(p_u_128)
						local v129 = v_u_38[p_u_128]
						local v130
						if v129 and v129.Rank then
							local v131 = v129.Rank
							v130 = v_u_5.NeedsConfirmation(v131)
							if v130 then
								local v132 = v131 == "A" and v_u_46.A and true or (v131 == "S" and v_u_46.S and true or (v131 == "SS" and v_u_46.SS and true or false))
								v130 = not v132
							end
						else
							v130 = false
						end
						if v130 then
							v_u_49 = false
							v_u_98()
							return
						end
						task.wait(0.125)
					end
				end)
			end
		elseif v_u_44 then
			return
		else
			local v133 = v_u_38[p_u_128]
			local v134, v135
			if v133 and v133.Rank then
				v134 = v133.Rank
				if v_u_5.NeedsConfirmation(v134) then
					if (v134 == "A" and v_u_46.A or v134 == "S" and v_u_46.S) and true or (v134 == "SS" and v_u_46.SS and true or false) then
						v135 = false
						v134 = nil
					else
						v135 = true
					end
				else
					v135 = false
					v134 = nil
				end
			else
				v135 = false
				v134 = nil
			end
			if v135 then
				v_u_108("You have a " .. v134 .. " rank " .. (v_u_5.StatDisplayNames[p_u_128] or p_u_128) .. "!\nAre you sure you want to reroll this stat?", function()
					-- upvalues: (ref) v_u_44, (ref) v_u_119, (copy) p_u_128
					v_u_44 = true
					v_u_119(p_u_128)
					v_u_44 = false
				end)
			else
				v_u_44 = true
				v_u_119(p_u_128)
				v_u_44 = false
			end
		end
	end
end
local function v140()
	-- upvalues: (copy) v_u_6, (copy) v_u_33, (ref) v_u_38, (ref) v_u_39, (ref) v_u_40, (ref) v_u_41, (ref) v_u_42, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_49, (copy) v_u_78, (copy) v_u_17, (copy) v_u_60, (copy) v_u_18, (copy) v_u_84, (copy) v_u_98
	if not v_u_6:IsOpen("RerollStatsUI") then
		local v137 = v_u_33:InvokeServer()
		if v137 then
			v_u_38 = v137.Stats or {}
			v_u_39 = v137.SSPity or 0
			v_u_40 = v137.Gems or 0
			v_u_41 = v137.Costs or v_u_41
			v_u_42 = v137.PityMax or v_u_42
			if v137.AutoSkip then
				v_u_46 = v137.AutoSkip
			end
		end
		v_u_47 = false
		v_u_48 = {}
		v_u_49 = false
		for v138, v139 in pairs(v_u_38) do
			v_u_78(v138, v139)
		end
		v_u_17.Text = v_u_60(v_u_40) .. " Gems"
		v_u_18.Text = "Pity: " .. v_u_39 .. "/" .. v_u_42
		v_u_84()
		v_u_98()
		v_u_6:Open("RerollStatsUI")
	end
end
v15.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_43, (ref) v_u_49, (copy) v_u_98, (ref) v_u_47, (ref) v_u_48
	if tick() - v_u_43 >= 0.125 then
		v_u_43 = tick()
		if v_u_49 then
			v_u_49 = false
			v_u_98()
		end
		v_u_47 = not v_u_47
		if not v_u_47 then
			v_u_48 = {}
		end
		v_u_98()
	end
end)
local function v148()
	-- upvalues: (copy) v_u_50, (copy) v_u_10, (ref) v_u_43, (ref) v_u_49, (copy) v_u_98, (ref) v_u_48
	for v_u_141, v142 in pairs(v_u_50) do
		local v143 = v_u_10:FindFirstChild(v142)
		if v143 then
			local v144 = v143:FindFirstChild("Part4")
			if v144 then
				local v145 = v144:FindFirstChild("AutoFrame")
				if v145 then
					local v146 = v145:FindFirstChild("Holder")
					if v146 then
						local v147 = v146:FindFirstChild("Checkmark")
						if v147 then
							v147.MouseButton1Click:Connect(function()
								-- upvalues: (ref) v_u_43, (ref) v_u_49, (ref) v_u_98, (ref) v_u_48, (copy) v_u_141
								if tick() - v_u_43 >= 0.125 then
									v_u_43 = tick()
									if v_u_49 then
										v_u_49 = false
										v_u_98()
									end
									v_u_48[v_u_141] = not v_u_48[v_u_141]
									v_u_98()
								end
							end)
						end
					end
				end
			end
		end
	end
end
local function v153()
	-- upvalues: (copy) v_u_27, (ref) v_u_43, (ref) v_u_46, (copy) v_u_84, (copy) v_u_35
	for v_u_149, v150 in pairs(v_u_27) do
		if v150 then
			local v151 = v150:FindFirstChild("On")
			local v152 = v150:FindFirstChild("Off")
			if v151 then
				v151.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_43, (ref) v_u_46, (copy) v_u_149, (ref) v_u_84, (ref) v_u_35
					if tick() - v_u_43 >= 0.125 then
						v_u_43 = tick()
						v_u_46[v_u_149] = false
						v_u_84()
						v_u_35:FireServer(v_u_46)
					end
				end)
			end
			if v152 then
				v152.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_43, (ref) v_u_46, (copy) v_u_149, (ref) v_u_84, (ref) v_u_35
					if tick() - v_u_43 >= 0.125 then
						v_u_43 = tick()
						v_u_46[v_u_149] = true
						v_u_84()
						v_u_35:FireServer(v_u_46)
					end
				end)
			end
		end
	end
end
v12.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_43, (copy) v_u_6, (ref) v_u_49, (copy) v_u_98, (ref) v_u_36, (ref) v_u_37, (copy) v_u_19, (copy) v_u_20, (copy) v_u_53
	if tick() - v_u_43 < 0.125 then
		return
	else
		v_u_43 = tick()
		if v_u_6:IsOpen("RerollStatsUI") then
			v_u_49 = false
			v_u_98()
			v_u_6:Close("RerollStatsUI")
			if v_u_36 then
				v_u_36 = false
				v_u_37 = nil
				v_u_19.Enabled = false
				v_u_20.Visible = false
				v_u_53()
			end
		else
			return
		end
	end
end)
v_u_14.MouseButton1Click:Connect(v127)
local v_u_154 = v_u_40
local v_u_155 = v_u_39
local v_u_156 = v_u_37
local v_u_157 = v_u_36
local v_u_158 = v_u_46
local v_u_159 = v_u_38
local v_u_160 = v_u_42
local v_u_161 = v_u_49
local v162 = {
	["Damage"] = "Damage",
	["Defense"] = "Hp",
	["CooldownReduction"] = "CooldownReduction",
	["CritChance"] = "CritChance",
	["CritDamage"] = "CritDamage",
	["DamageReduction"] = "DmgReduction",
	["Luck"] = "Luck"
}
for v_u_163, v164 in pairs(v_u_50) do
	local v165 = v_u_10:FindFirstChild(v164)
	if v165 then
		local v166 = v165:FindFirstChild("Part4")
		if v166 then
			local v167 = v162[v_u_163]
			local v168 = v166:FindFirstChild("Frame")
			if v168 then
				v168 = v168:FindFirstChild("RerollASingleStatButton" .. v167)
			end
			if v168 then
				v168.MouseButton1Click:Connect(function()
					-- upvalues: (copy) v_u_136, (copy) v_u_163
					v_u_136(v_u_163)
				end)
			end
		end
	end
end
v30.OnClientEvent:Connect(v140)
v34.OnClientEvent:Connect(function(p169)
	-- upvalues: (ref) v_u_159, (ref) v_u_155, (ref) v_u_154, (ref) v_u_158, (copy) v_u_6, (copy) v_u_78, (copy) v_u_17, (copy) v_u_60, (copy) v_u_18, (ref) v_u_160, (copy) v_u_84, (copy) v_u_98
	if p169 then
		v_u_159 = p169.Stats or v_u_159
		v_u_155 = p169.SSPity or v_u_155
		v_u_154 = p169.Gems or v_u_154
		if p169.AutoSkip then
			v_u_158 = p169.AutoSkip
		end
		if v_u_6:IsOpen("RerollStatsUI") then
			for v170, v171 in pairs(v_u_159) do
				v_u_78(v170, v171)
			end
			v_u_17.Text = v_u_60(v_u_154) .. " Gems"
			v_u_18.Text = "Pity: " .. v_u_155 .. "/" .. v_u_160
			v_u_84()
			v_u_98()
		end
	end
end)
v7.Visible = false
v_u_6:Register("RerollStatsUI", v7, {
	["onClose"] = function()
		-- upvalues: (ref) v_u_161, (copy) v_u_98, (ref) v_u_157, (ref) v_u_156, (copy) v_u_19, (copy) v_u_20, (copy) v_u_53
		v_u_161 = false
		v_u_98()
		if v_u_157 then
			v_u_157 = false
			v_u_156 = nil
			v_u_19.Enabled = false
			v_u_20.Visible = false
			v_u_53()
		end
	end
})
v153()
v148()