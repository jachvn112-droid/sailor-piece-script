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
local v_u_40 = "SS"
local v_u_41 = 0
local v_u_42 = {
	["RerollAll"] = 500,
	["RerollSingle"] = 1000
}
local v_u_43 = 200
local v_u_44 = 0
local v_u_45 = false
local v_u_46 = {}
local v_u_47 = {
	["A"] = false,
	["S"] = false,
	["SS"] = false
}
local v_u_48 = false
local v_u_49 = {}
local v_u_50 = false
local v_u_51 = {
	["Damage"] = "Damage[1]",
	["Defense"] = "Defense[2]",
	["CooldownReduction"] = "CooldownReduction[3]",
	["CritChance"] = "CritChance[4]",
	["CritDamage"] = "CritDamage[5]",
	["DamageReduction"] = "DamageReduction[6]",
	["Luck"] = "Luck[7]"
}
local v_u_52 = {
	["Damage"] = "Damage",
	["Defense"] = "Defense",
	["CooldownReduction"] = "CooldownReduction",
	["CritChance"] = "CritChance",
	["CritDamage"] = "CritDamage",
	["DamageReduction"] = "DmgReduction",
	["Luck"] = "Luck"
}
local function v_u_54()
	-- upvalues: (ref) v_u_46
	for _, v53 in ipairs(v_u_46) do
		if v53.Connected then
			v53:Disconnect()
		end
	end
	v_u_46 = {}
end
local function v_u_61(p55)
	local v56 = tostring(p55)
	local v57 = #v56 % 3
	local v58 = v57 == 0 and 3 or v57
	local v59 = v56:sub(1, v58)
	for v60 = v58 + 1, #v56, 3 do
		v59 = v59 .. "," .. v56:sub(v60, v60 + 2)
	end
	return v59
end
local function v_u_64()
	-- upvalues: (copy) v_u_5, (ref) v_u_49
	local v62 = {}
	for _, v63 in ipairs(v_u_5.StatKeys) do
		if v_u_49[v63] then
			table.insert(v62, v63)
		end
	end
	return v62
end
local function v_u_79(p65, p66)
	-- upvalues: (copy) v_u_51, (copy) v_u_52, (copy) v_u_10, (copy) v_u_5
	local v67 = v_u_51[p65]
	local v68 = v_u_52[p65]
	if v67 and v68 then
		local v69 = v_u_10:FindFirstChild(v67)
		if v69 then
			local v70 = p66.Rank or "F"
			local v71 = p66.Value or 0
			local v72 = v_u_5.GetRankColor(v70)
			local v73 = v69:FindFirstChild("Part2")
			if v73 then
				local v74 = v73:FindFirstChild("Holder")
				local v75 = v74 and v74:FindFirstChild("StatRankYouGotFromRollingThisStat" .. v68)
				if v75 then
					v75.Text = v70
					v75.TextColor3 = v72
				end
			end
			local v76 = v69:FindFirstChild("Part3")
			if v76 then
				local v77 = v76:FindFirstChild("Holder")
				local v78 = v77 and v77:FindFirstChild("PercentageAmountYouGotForThisStatFromReroll" .. v68)
				if v78 then
					v78.Text = "+" .. (v71 % 1 == 0 and tostring(v71) or string.format("%.1f", v71)) .. "%"
				end
			end
		end
	else
		return
	end
end
local function v_u_85()
	-- upvalues: (copy) v_u_27, (ref) v_u_47
	for v80, v81 in pairs(v_u_27) do
		if v81 then
			local v82 = v81:FindFirstChild("On")
			local v83 = v81:FindFirstChild("Off")
			if v82 and v83 then
				local v84 = v_u_47[v80] == true
				v82.Visible = v84
				v83.Visible = not v84
			end
		end
	end
end
local function v_u_99()
	-- upvalues: (copy) v_u_16, (ref) v_u_48, (copy) v_u_51, (copy) v_u_10, (ref) v_u_49, (copy) v_u_14, (ref) v_u_50
	v_u_16.Visible = v_u_48
	for _, v86 in pairs(v_u_51) do
		local v87 = v_u_10:FindFirstChild(v86)
		if v87 then
			local v88 = v87:FindFirstChild("Part4")
			if v88 then
				local v89 = v88:FindFirstChild("AutoFrame")
				if v89 then
					v89.Visible = v_u_48
				end
			end
		end
	end
	for v90, v91 in pairs(v_u_51) do
		local v92 = v_u_10:FindFirstChild(v91)
		if v92 then
			local v93 = v92:FindFirstChild("Part4")
			if v93 then
				local v94 = v93:FindFirstChild("AutoFrame")
				if v94 then
					local v95 = v94:FindFirstChild("Holder")
					if v95 then
						local v96 = v95:FindFirstChild("Checkmark")
						if v96 then
							local v97 = v96:FindFirstChild("Icon")
							if v97 then
								v97.Visible = v_u_49[v90] == true
							end
						end
					end
				end
			end
		end
	end
	local v98 = v_u_14:FindFirstChild("Txt")
	if v98 then
		v98.Text = v_u_50 and "Stop" or "Reroll All"
	end
end
local function v_u_109(p100, p_u_101)
	-- upvalues: (ref) v_u_36, (ref) v_u_37, (copy) v_u_19, (copy) v_u_20, (copy) v_u_54, (copy) v_u_25, (copy) v_u_24, (ref) v_u_46, (copy) v_u_22, (ref) v_u_44, (copy) v_u_23
	if v_u_36 and v_u_36 then
		v_u_36 = false
		v_u_37 = nil
		v_u_19.Enabled = false
		v_u_20.Visible = false
		v_u_54()
	end
	local v_u_102 = {}
	v_u_37 = v_u_102
	v_u_36 = true
	v_u_25.Text = p100
	v_u_24.Visible = false
	v_u_19.Enabled = true
	v_u_20.Visible = true
	v_u_54()
	local v103 = v_u_46
	local v104 = v_u_22.MouseButton1Click
	local function v105()
		-- upvalues: (ref) v_u_44, (ref) v_u_37, (copy) v_u_102, (ref) v_u_36, (ref) v_u_19, (ref) v_u_20, (ref) v_u_54, (copy) p_u_101
		if tick() - v_u_44 < 0.125 then
			return
		elseif v_u_37 == v_u_102 then
			if v_u_36 then
				v_u_36 = false
				v_u_37 = nil
				v_u_19.Enabled = false
				v_u_20.Visible = false
				v_u_54()
			end
			if p_u_101 then
				task.wait(0.05)
				p_u_101()
			end
		end
	end
	table.insert(v103, v104:Connect(v105))
	local v106 = v_u_46
	local v107 = v_u_23.MouseButton1Click
	local function v108()
		-- upvalues: (ref) v_u_44, (ref) v_u_37, (copy) v_u_102, (ref) v_u_36, (ref) v_u_19, (ref) v_u_20, (ref) v_u_54
		if tick() - v_u_44 < 0.125 then
			return
		elseif v_u_37 == v_u_102 then
			v_u_44 = tick()
			if v_u_36 then
				v_u_36 = false
				v_u_37 = nil
				v_u_19.Enabled = false
				v_u_20.Visible = false
				v_u_54()
			end
		else
			return
		end
	end
	table.insert(v106, v107:Connect(v108))
	task.spawn(function()
		-- upvalues: (ref) v_u_37, (copy) v_u_102, (ref) v_u_19, (ref) v_u_20, (ref) v_u_36, (ref) v_u_54
		while v_u_37 == v_u_102 do
			task.wait(0.1)
			if v_u_37 == v_u_102 and not (v_u_19.Enabled and v_u_20.Visible) then
				if v_u_36 then
					v_u_36 = false
					v_u_37 = nil
					v_u_54()
					return
				end
				break
			end
		end
	end)
end
local function v_u_114()
	-- upvalues: (ref) v_u_41, (ref) v_u_42, (copy) v_u_31, (ref) v_u_38, (ref) v_u_39, (ref) v_u_40, (ref) v_u_43, (copy) v_u_79, (copy) v_u_17, (copy) v_u_61, (copy) v_u_18, (copy) v_u_85, (copy) v_u_99
	if v_u_41 < v_u_42.RerollAll then
		return false
	end
	local v110, v111 = pcall(function()
		-- upvalues: (ref) v_u_31
		return v_u_31:InvokeServer()
	end)
	if not (v110 and (v111 and v111.success)) then
		return false
	end
	v_u_38 = v111.Stats or v_u_38
	v_u_39 = v111.SSPity or v_u_39
	if v111.PityTier then
		v_u_40 = v111.PityTier
	end
	if v111.PityMax then
		v_u_43 = v111.PityMax
	end
	v_u_41 = v111.Gems or v_u_41
	for v112, v113 in pairs(v_u_38) do
		v_u_79(v112, v113)
	end
	v_u_17.Text = v_u_61(v_u_41) .. " Gems"
	v_u_18.Text = v_u_40 .. " Pity: " .. v_u_39 .. "/" .. v_u_43
	v_u_85()
	v_u_99()
	return true
end
local function v_u_120(p_u_115)
	-- upvalues: (ref) v_u_41, (ref) v_u_42, (copy) v_u_32, (ref) v_u_38, (ref) v_u_39, (ref) v_u_40, (ref) v_u_43, (copy) v_u_79, (copy) v_u_17, (copy) v_u_61, (copy) v_u_18, (copy) v_u_85, (copy) v_u_99
	if v_u_41 < v_u_42.RerollSingle then
		return false
	end
	local v116, v117 = pcall(function()
		-- upvalues: (ref) v_u_32, (copy) p_u_115
		return v_u_32:InvokeServer(p_u_115)
	end)
	if not (v116 and (v117 and v117.success)) then
		return false
	end
	v_u_38 = v117.Stats or v_u_38
	v_u_39 = v117.SSPity or v_u_39
	if v117.PityTier then
		v_u_40 = v117.PityTier
	end
	if v117.PityMax then
		v_u_43 = v117.PityMax
	end
	v_u_41 = v117.Gems or v_u_41
	for v118, v119 in pairs(v_u_38) do
		v_u_79(v118, v119)
	end
	v_u_17.Text = v_u_61(v_u_41) .. " Gems"
	v_u_18.Text = v_u_40 .. " Pity: " .. v_u_39 .. "/" .. v_u_43
	v_u_85()
	v_u_99()
	return true
end
local function v_u_124()
	-- upvalues: (ref) v_u_38, (copy) v_u_5, (ref) v_u_47
	for v121, v122 in pairs(v_u_38) do
		local v123 = v122.Rank
		if v123 and v_u_5.NeedsConfirmation(v123) and ((v123 ~= "A" or not v_u_47.A) and (v123 ~= "S" or not v_u_47.S) and (v123 ~= "SS" or not v_u_47.SS)) then
			return true, v121, v123
		end
	end
	return false
end
local function v128()
	-- upvalues: (ref) v_u_44, (ref) v_u_50, (copy) v_u_99, (ref) v_u_41, (ref) v_u_42, (ref) v_u_48, (copy) v_u_64, (copy) v_u_5, (copy) v_u_120, (ref) v_u_38, (ref) v_u_47, (copy) v_u_114, (ref) v_u_45, (copy) v_u_124, (copy) v_u_109
	if tick() - v_u_44 < 0.125 then
		return
	else
		v_u_44 = tick()
		if v_u_50 then
			v_u_50 = false
			v_u_99()
			return
		elseif v_u_41 < v_u_42.RerollAll then
			return
		elseif v_u_48 then
			if v_u_50 then
				v_u_50 = false
				v_u_99()
			else
				v_u_50 = true
				v_u_99()
				task.spawn(function()
					-- upvalues: (ref) v_u_50, (ref) v_u_64, (ref) v_u_5, (ref) v_u_42, (ref) v_u_41, (ref) v_u_99, (ref) v_u_120, (ref) v_u_38, (ref) v_u_47, (ref) v_u_114
					-- failed to decompile
				end)
			end
		elseif v_u_45 then
			return
		else
			local v125, v126, v127 = v_u_124()
			if v125 then
				v_u_109("You have a " .. v127 .. " rank " .. (v_u_5.StatDisplayNames[v126] or v126) .. "!\nAre you sure you want to reroll all stats?", function()
					-- upvalues: (ref) v_u_45, (ref) v_u_114
					v_u_45 = true
					v_u_114()
					v_u_45 = false
				end)
			else
				v_u_45 = true
				v_u_114()
				v_u_45 = false
			end
		end
	end
end
local function v_u_137(p_u_129)
	-- upvalues: (ref) v_u_44, (ref) v_u_50, (copy) v_u_99, (ref) v_u_41, (ref) v_u_42, (ref) v_u_48, (copy) v_u_120, (ref) v_u_38, (copy) v_u_5, (ref) v_u_47, (ref) v_u_45, (copy) v_u_109
	if tick() - v_u_44 < 0.125 then
		return
	else
		v_u_44 = tick()
		if v_u_50 then
			v_u_50 = false
			v_u_99()
			return
		elseif v_u_41 < v_u_42.RerollSingle then
			return
		elseif v_u_48 then
			if v_u_50 then
				v_u_50 = false
				v_u_99()
			else
				v_u_50 = true
				v_u_99()
				task.spawn(function()
					-- upvalues: (ref) v_u_50, (ref) v_u_41, (ref) v_u_42, (ref) v_u_99, (ref) v_u_120, (copy) p_u_129, (ref) v_u_38, (ref) v_u_5, (ref) v_u_47
					while v_u_50 do
						if v_u_41 < v_u_42.RerollSingle then
							v_u_50 = false
							v_u_99()
							return
						end
						v_u_120(p_u_129)
						local v130 = v_u_38[p_u_129]
						local v131
						if v130 and v130.Rank then
							local v132 = v130.Rank
							v131 = v_u_5.NeedsConfirmation(v132)
							if v131 then
								local v133 = v132 == "A" and v_u_47.A and true or (v132 == "S" and v_u_47.S and true or (v132 == "SS" and v_u_47.SS and true or false))
								v131 = not v133
							end
						else
							v131 = false
						end
						if v131 then
							v_u_50 = false
							v_u_99()
							return
						end
						task.wait(0.125)
					end
				end)
			end
		elseif v_u_45 then
			return
		else
			local v134 = v_u_38[p_u_129]
			local v135, v136
			if v134 and v134.Rank then
				v135 = v134.Rank
				if v_u_5.NeedsConfirmation(v135) then
					if (v135 == "A" and v_u_47.A or v135 == "S" and v_u_47.S) and true or (v135 == "SS" and v_u_47.SS and true or false) then
						v136 = false
						v135 = nil
					else
						v136 = true
					end
				else
					v136 = false
					v135 = nil
				end
			else
				v136 = false
				v135 = nil
			end
			if v136 then
				v_u_109("You have a " .. v135 .. " rank " .. (v_u_5.StatDisplayNames[p_u_129] or p_u_129) .. "!\nAre you sure you want to reroll this stat?", function()
					-- upvalues: (ref) v_u_45, (ref) v_u_120, (copy) p_u_129
					v_u_45 = true
					v_u_120(p_u_129)
					v_u_45 = false
				end)
			else
				v_u_45 = true
				v_u_120(p_u_129)
				v_u_45 = false
			end
		end
	end
end
local function v141()
	-- upvalues: (copy) v_u_6, (copy) v_u_33, (ref) v_u_38, (ref) v_u_39, (ref) v_u_40, (ref) v_u_41, (ref) v_u_42, (ref) v_u_43, (copy) v_u_5, (ref) v_u_47, (ref) v_u_48, (ref) v_u_49, (ref) v_u_50, (copy) v_u_79, (copy) v_u_17, (copy) v_u_61, (copy) v_u_18, (copy) v_u_85, (copy) v_u_99
	if not v_u_6:IsOpen("RerollStatsUI") then
		local v138 = v_u_33:InvokeServer()
		if v138 then
			v_u_38 = v138.Stats or {}
			v_u_39 = v138.SSPity or 0
			v_u_40 = v138.PityTier or "SS"
			v_u_41 = v138.Gems or 0
			v_u_42 = v138.Costs or v_u_42
			v_u_43 = v138.PityMax or v_u_5.GetPityThreshold(v_u_40)
			if v138.AutoSkip then
				v_u_47 = v138.AutoSkip
			end
		end
		v_u_48 = false
		v_u_49 = {}
		v_u_50 = false
		for v139, v140 in pairs(v_u_38) do
			v_u_79(v139, v140)
		end
		v_u_17.Text = v_u_61(v_u_41) .. " Gems"
		v_u_18.Text = v_u_40 .. " Pity: " .. v_u_39 .. "/" .. v_u_43
		v_u_85()
		v_u_99()
		v_u_6:Open("RerollStatsUI")
	end
end
v15.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_44, (ref) v_u_50, (copy) v_u_99, (ref) v_u_48, (ref) v_u_49
	if tick() - v_u_44 >= 0.125 then
		v_u_44 = tick()
		if v_u_50 then
			v_u_50 = false
			v_u_99()
		end
		v_u_48 = not v_u_48
		if not v_u_48 then
			v_u_49 = {}
		end
		v_u_99()
	end
end)
local function v149()
	-- upvalues: (copy) v_u_51, (copy) v_u_10, (ref) v_u_44, (ref) v_u_50, (copy) v_u_99, (ref) v_u_49
	for v_u_142, v143 in pairs(v_u_51) do
		local v144 = v_u_10:FindFirstChild(v143)
		if v144 then
			local v145 = v144:FindFirstChild("Part4")
			if v145 then
				local v146 = v145:FindFirstChild("AutoFrame")
				if v146 then
					local v147 = v146:FindFirstChild("Holder")
					if v147 then
						local v148 = v147:FindFirstChild("Checkmark")
						if v148 then
							v148.MouseButton1Click:Connect(function()
								-- upvalues: (ref) v_u_44, (ref) v_u_50, (ref) v_u_99, (ref) v_u_49, (copy) v_u_142
								if tick() - v_u_44 >= 0.125 then
									v_u_44 = tick()
									if v_u_50 then
										v_u_50 = false
										v_u_99()
									end
									v_u_49[v_u_142] = not v_u_49[v_u_142]
									v_u_99()
								end
							end)
						end
					end
				end
			end
		end
	end
end
local function v154()
	-- upvalues: (copy) v_u_27, (ref) v_u_44, (ref) v_u_47, (copy) v_u_85, (copy) v_u_35
	for v_u_150, v151 in pairs(v_u_27) do
		if v151 then
			local v152 = v151:FindFirstChild("On")
			local v153 = v151:FindFirstChild("Off")
			if v152 then
				v152.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_44, (ref) v_u_47, (copy) v_u_150, (ref) v_u_85, (ref) v_u_35
					if tick() - v_u_44 >= 0.125 then
						v_u_44 = tick()
						v_u_47[v_u_150] = false
						v_u_85()
						v_u_35:FireServer(v_u_47)
					end
				end)
			end
			if v153 then
				v153.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_44, (ref) v_u_47, (copy) v_u_150, (ref) v_u_85, (ref) v_u_35
					if tick() - v_u_44 >= 0.125 then
						v_u_44 = tick()
						v_u_47[v_u_150] = true
						v_u_85()
						v_u_35:FireServer(v_u_47)
					end
				end)
			end
		end
	end
end
v12.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_44, (copy) v_u_6, (ref) v_u_50, (copy) v_u_99, (ref) v_u_36, (ref) v_u_37, (copy) v_u_19, (copy) v_u_20, (copy) v_u_54
	if tick() - v_u_44 < 0.125 then
		return
	else
		v_u_44 = tick()
		if v_u_6:IsOpen("RerollStatsUI") then
			v_u_50 = false
			v_u_99()
			v_u_6:Close("RerollStatsUI")
			if v_u_36 then
				v_u_36 = false
				v_u_37 = nil
				v_u_19.Enabled = false
				v_u_20.Visible = false
				v_u_54()
			end
		else
			return
		end
	end
end)
v_u_14.MouseButton1Click:Connect(v128)
local v_u_155 = v_u_41
local v_u_156 = v_u_43
local v_u_157 = v_u_40
local v_u_158 = v_u_39
local v_u_159 = v_u_38
local v_u_160 = v_u_47
local v_u_161 = v_u_37
local v_u_162 = v_u_36
local v_u_163 = v_u_50
local v164 = {
	["Damage"] = "Damage",
	["Defense"] = "Hp",
	["CooldownReduction"] = "CooldownReduction",
	["CritChance"] = "CritChance",
	["CritDamage"] = "CritDamage",
	["DamageReduction"] = "DmgReduction",
	["Luck"] = "Luck"
}
for v_u_165, v166 in pairs(v_u_51) do
	local v167 = v_u_10:FindFirstChild(v166)
	if v167 then
		local v168 = v167:FindFirstChild("Part4")
		if v168 then
			local v169 = v164[v_u_165]
			local v170 = v168:FindFirstChild("Frame")
			if v170 then
				v170 = v170:FindFirstChild("RerollASingleStatButton" .. v169)
			end
			if v170 then
				v170.MouseButton1Click:Connect(function()
					-- upvalues: (copy) v_u_137, (copy) v_u_165
					v_u_137(v_u_165)
				end)
			end
		end
	end
end
v30.OnClientEvent:Connect(v141)
v34.OnClientEvent:Connect(function(p171)
	-- upvalues: (ref) v_u_159, (ref) v_u_158, (ref) v_u_157, (ref) v_u_156, (ref) v_u_155, (ref) v_u_160, (copy) v_u_6, (copy) v_u_79, (copy) v_u_17, (copy) v_u_61, (copy) v_u_18, (copy) v_u_85, (copy) v_u_99
	if p171 then
		v_u_159 = p171.Stats or v_u_159
		v_u_158 = p171.SSPity or v_u_158
		if p171.PityTier then
			v_u_157 = p171.PityTier
		end
		if p171.PityMax then
			v_u_156 = p171.PityMax
		end
		v_u_155 = p171.Gems or v_u_155
		if p171.AutoSkip then
			v_u_160 = p171.AutoSkip
		end
		if v_u_6:IsOpen("RerollStatsUI") then
			for v172, v173 in pairs(v_u_159) do
				v_u_79(v172, v173)
			end
			v_u_17.Text = v_u_61(v_u_155) .. " Gems"
			v_u_18.Text = v_u_157 .. " Pity: " .. v_u_158 .. "/" .. v_u_156
			v_u_85()
			v_u_99()
		end
	end
end)
v7.Visible = false
v_u_6:Register("RerollStatsUI", v7, {
	["onClose"] = function()
		-- upvalues: (ref) v_u_163, (copy) v_u_99, (ref) v_u_162, (ref) v_u_161, (copy) v_u_19, (copy) v_u_20, (copy) v_u_54
		v_u_163 = false
		v_u_99()
		if v_u_162 then
			v_u_162 = false
			v_u_161 = nil
			v_u_19.Enabled = false
			v_u_20.Visible = false
			v_u_54()
		end
	end
})
v154()
v149()