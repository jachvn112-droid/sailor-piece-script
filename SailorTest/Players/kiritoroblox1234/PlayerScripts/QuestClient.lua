local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("UserInputService")
local v_u_5 = v1.LocalPlayer
local v6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = require(v2:WaitForChild("Modules"):WaitForChild("QuestConfig"))
local v_u_8 = require(v2:WaitForChild("Modules"):WaitForChild("NotificationService"))
local v_u_9 = require(v2:WaitForChild("Modules"):WaitForChild("TitlesConfig"))
local v10 = v2:WaitForChild("RemoteEvents")
local v_u_11 = v10:WaitForChild("QuestAccept")
local v_u_12 = v10:WaitForChild("QuestAbandon")
local v13 = v10:WaitForChild("QuestProgress")
local v14 = v10:WaitForChild("QuestComplete")
local v15 = v10:WaitForChild("QuestUIUpdate")
local v_u_16 = v10:WaitForChild("QuestRepeat")
local v_u_17 = v2:WaitForChild("Remotes"):WaitForChild("ShopRemotes"):WaitForChild("GetBoosts")
local v_u_18 = v2:WaitForChild("Remotes"):WaitForChild("GetTitlesData")
local v_u_19 = v2:WaitForChild("Remotes"):WaitForChild("EventRemotes"):WaitForChild("GetEvents")
local v_u_20 = v6:WaitForChild("QuestUI")
local v_u_21 = v_u_20:WaitForChild("Quest")
local v_u_22 = v_u_21:WaitForChild("Quest")
local v_u_23 = v_u_22:WaitForChild("Holder")
local v_u_24 = v_u_23:WaitForChild("Content")
local v_u_25 = v_u_21:WaitForChild("Reward")
local v26 = v_u_24:WaitForChild("QuestInfo")
local v_u_27 = v26:WaitForChild("QuestTitle"):WaitForChild("QuestTitle")
local v_u_28 = v26:WaitForChild("QuestDescription")
local v_u_29 = v26:WaitForChild("QuestRequirement")
local v_u_30 = v_u_24:WaitForChild("QuestProgress"):WaitForChild("Holder"):WaitForChild("LoaderHolder"):WaitForChild("Loader")
local v31 = v_u_24:WaitForChild("Exit"):WaitForChild("CloseButton")
local v_u_32 = v_u_25:WaitForChild("RewardCoins")
local v_u_33 = v_u_25:WaitForChild("RewardGems")
local v_u_34 = v_u_25:WaitForChild("RewardExp")
local v_u_35 = v_u_23:WaitForChild("QuestRepeat")
local v_u_36 = v_u_35:WaitForChild("Timer")
local v37 = v_u_35:WaitForChild("ButtonsHolder")
local v38 = v37:WaitForChild("Yes")
local v39 = v37:WaitForChild("No")
local v_u_40 = v_u_24:WaitForChild("QuestSwitchButton")
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = nil
local v_u_44 = false
local v_u_45 = nil
local v_u_46 = false
local v_u_47 = false
local v_u_48 = 0
local v_u_49 = v_u_7.Settings.buttonCooldown or 0.5
local v_u_50 = v_u_7.Settings.promptCooldown or 1
local function v_u_51()
	-- upvalues: (ref) v_u_47, (ref) v_u_48
	v_u_47 = false
	v_u_48 = 0
end
local function v_u_62(p52)
	if not p52 or p52 == 0 then
		return "0"
	end
	local v53 = math.abs(p52)
	local v54 = p52 < 0 and "-" or ""
	if v53 >= 1000000000 then
		local v55 = v53 / 100000000
		local v56 = math.floor(v55) / 10
		return v54 .. string.format("%.1f", v56):gsub("%.0$", "") .. "B"
	end
	if v53 >= 1000000 then
		local v57 = v53 / 100000
		local v58 = math.floor(v57) / 10
		return v54 .. string.format("%.1f", v58):gsub("%.0$", "") .. "M"
	end
	if v53 < 1000 then
		local v59 = math.floor(v53)
		return v54 .. tostring(v59)
	end
	local v60 = v53 / 100
	local v61 = math.floor(v60) / 10
	return v54 .. string.format("%.1f", v61):gsub("%.0$", "") .. "K"
end
local function v_u_66()
	-- upvalues: (ref) v_u_42, (copy) v_u_7
	if not v_u_42 then
		return false
	end
	local v63 = v_u_7.Questlines[v_u_42.questlineId]
	if v63 and v63.stages then
		local v64 = v63.stages[v_u_42.currentStage]
		if v64 and v64.trackingType == "PlayTime" then
			return true
		end
	end
	local v65 = v_u_42.description or ""
	return v65:lower():find("play the game for") and v65:lower():find("minute") and true or false
end
local function v_u_72()
	-- upvalues: (ref) v_u_41, (ref) v_u_42, (ref) v_u_47, (ref) v_u_48, (ref) v_u_43, (copy) v_u_40
	local v67
	if v_u_41 == nil then
		v67 = false
	else
		v67 = v_u_42 ~= nil
	end
	if v67 then
		local v68
		if v_u_47 then
			if tick() - v_u_48 > 3 then
				v_u_47 = false
				v68 = false
			else
				v68 = true
			end
		else
			v68 = false
		end
		if not v68 then
			v_u_47 = true
			v_u_48 = tick()
			local v_u_69 = 0.3
			task.delay(0.3, function()
				-- upvalues: (ref) v_u_47, (ref) v_u_48, (copy) v_u_69
				if v_u_47 and tick() - v_u_48 >= v_u_69 - 0.1 then
					v_u_47 = false
				end
			end)
			if v_u_43 == "repeatable" then
				v_u_43 = "questline"
				showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
			else
				v_u_43 = "repeatable"
				showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
			end
			local v70 = v_u_40
			local v71
			if v_u_41 == nil then
				v71 = false
			else
				v71 = v_u_42 ~= nil
			end
			v70.Visible = v71
		end
	else
		return
	end
end
local v_u_73 = false
v_u_40.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_73, (copy) v_u_40, (copy) v_u_3, (copy) v_u_72
	if not v_u_73 then
		v_u_73 = true
		local v74 = v_u_40:FindFirstChild("Arrow")
		if v74 then
			v_u_3:Create(v74, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				["Rotation"] = v74.Rotation + 180
			}):Play()
		end
		v_u_72()
		task.delay(0.3, function()
			-- upvalues: (ref) v_u_73
			v_u_73 = false
		end)
	end
end)
local function v_u_83(p75, p76)
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_30, (copy) v_u_29, (copy) v_u_62
	local v77 = v_u_7.GetRepeatableQuest(p76)
	if v77 then
		local v78 = 0
		local v79 = 0
		for _, v80 in ipairs(v77.requirements) do
			v78 = v78 + (p75[v80.npcType] or 0)
			v79 = v79 + v80.amount
		end
		local v81 = v79 > 0 and (v78 / v79 or 0) or 0
		local v82 = math.clamp(v81, 0, 1)
		v_u_3:Create(v_u_30, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			["Size"] = UDim2.new(v82, 0, 1, 0)
		}):Play()
		v_u_29.Text = v_u_62(v78) .. "/" .. v_u_62(v79) .. " Defeated"
	end
end
local function v_u_106(p84, p85, p86)
	-- upvalues: (copy) v_u_3, (copy) v_u_30, (copy) v_u_29, (copy) v_u_66, (copy) v_u_62
	local v87 = p85 > 0 and (p84 / p85 or 0) or 0
	local v88 = math.clamp(v87, 0, 1)
	v_u_3:Create(v_u_30, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
		["Size"] = UDim2.new(v88, 0, 1, 0)
	}):Play()
	if p86 then
		local v89 = {}
		for _, v90 in ipairs({
			"SaberBoss",
			"GojoBoss",
			"SukunaBoss",
			"JinwooBoss",
			"RagnaBoss"
		}) do
			local v91 = (p86[v90] or 0) .. "/15"
			table.insert(v89, v91)
		end
		v_u_29.Text = table.concat(v89, " ")
		return
	elseif v_u_66() then
		local v92 = v_u_29
		local v93 = (not p84 or p84 < 0) and 0 or p84
		local v94 = math.floor(v93)
		local v95 = v94 / 60
		local v96 = math.floor(v95)
		local v97 = v94 % 60
		local v98
		if v96 > 0 and v97 > 0 then
			v98 = v96 .. "m " .. v97 .. "s"
		elseif v96 > 0 then
			v98 = v96 .. "m"
		else
			v98 = v97 .. "s"
		end
		local v99 = " / "
		local v100 = (not p85 or p85 < 0) and 0 or p85
		local v101 = math.floor(v100)
		local v102 = v101 / 60
		local v103 = math.floor(v102)
		local v104 = v101 % 60
		local v105
		if v103 > 0 and v104 > 0 then
			v105 = v103 .. "m " .. v104 .. "s"
		elseif v103 > 0 then
			v105 = v103 .. "m"
		else
			v105 = v104 .. "s"
		end
		v92.Text = v98 .. v99 .. v105
	else
		v_u_29.Text = v_u_62(p84) .. "/" .. v_u_62(p85) .. " Completed"
	end
end
local v_u_107 = false
function showRepeatableQuestDetails(p108, p109)
	-- upvalues: (copy) v_u_7, (copy) v_u_27, (copy) v_u_28, (copy) v_u_17, (copy) v_u_18, (copy) v_u_9, (copy) v_u_19, (copy) v_u_32, (copy) v_u_62, (copy) v_u_33, (copy) v_u_34, (copy) v_u_83
	local v110 = v_u_7.GetRepeatableQuest(p108)
	if v110 then
		v_u_27.Text = v110.title
		v_u_28.Text = v110.description
		local v_u_111 = {}
		local v_u_112 = {}
		pcall(function()
			-- upvalues: (ref) v_u_111, (ref) v_u_17
			v_u_111 = v_u_17:InvokeServer() or {}
		end)
		pcall(function()
			-- upvalues: (ref) v_u_18, (ref) v_u_9, (ref) v_u_112
			local v113 = v_u_18:InvokeServer()
			local v114 = v113 and (v113.equipped and v_u_9:GetTitle(v113.equipped))
			if v114 then
				v_u_112 = v114.statBonuses or {}
			end
		end)
		local v115 = v110.rewards.money or 0
		local v116 = v110.rewards.gems or 0
		local v117 = v110.rewards.xp or 0
		if v_u_112.MoneyPercent then
			local v118 = v115 * (1 + v_u_112.MoneyPercent / 100)
			v115 = math.floor(v118)
		end
		if v_u_112.GemPercent then
			local v119 = v116 * (1 + v_u_112.GemPercent / 100)
			v116 = math.floor(v119)
		end
		if v_u_112.XPPercent then
			local v120 = v117 * (1 + v_u_112.XPPercent / 100)
			v117 = math.floor(v120)
		end
		if v_u_111["2xMoney"] then
			v115 = v115 * 2
		end
		if v_u_111["2xGems"] then
			v116 = v116 * 2
		end
		if v_u_111["2xExp"] then
			v117 = v117 * 2
		end
		local v_u_121 = {}
		pcall(function()
			-- upvalues: (ref) v_u_121, (ref) v_u_19
			v_u_121 = v_u_19:InvokeServer() or {}
		end)
		if v_u_121.x2Coins then
			v115 = v115 * 2
		end
		if v_u_121.x2Gems then
			v116 = v116 * 2
		end
		if v_u_121.x2EXP then
			v117 = v117 * 2
		end
		local v122 = v_u_32
		local v123 = v_u_62(v115)
		local v124 = v122:FindFirstChild("CurrencyIndicator")
		if v124 and v124:IsA("TextLabel") then
			v124.Text = v123
			local v125 = v124:FindFirstChild("CurrencyIndicator")
			if v125 then
				v125.Text = v123
			end
		end
		local v126 = v_u_33
		local v127 = v_u_62(v116)
		local v128 = v126:FindFirstChild("CurrencyIndicator")
		if v128 and v128:IsA("TextLabel") then
			v128.Text = v127
			local v129 = v128:FindFirstChild("CurrencyIndicator")
			if v129 then
				v129.Text = v127
			end
		end
		local v130 = v_u_34
		local v131 = v_u_62(v117)
		local v132 = v130:FindFirstChild("CurrencyIndicator")
		if v132 and v132:IsA("TextLabel") then
			v132.Text = v131
			local v133 = v132:FindFirstChild("CurrencyIndicator")
			if v133 then
				v133.Text = v131
			end
		end
		v_u_83(p109 or {}, p108)
	end
end
function showQuestlineDetails(_, _, p134, p135, p136, p137, p138, p139)
	-- upvalues: (copy) v_u_27, (copy) v_u_28, (copy) v_u_19, (copy) v_u_32, (copy) v_u_62, (copy) v_u_33, (copy) v_u_34, (copy) v_u_106
	v_u_27.Text = p136 or "Quest"
	v_u_28.Text = p137 or ""
	local v140 = p139 and (p139.money or 0) or 0
	local v141 = p139 and (p139.gems or 0) or 0
	local v142 = p139 and p139.xp or 0
	local v_u_143 = {}
	pcall(function()
		-- upvalues: (ref) v_u_143, (ref) v_u_19
		v_u_143 = v_u_19:InvokeServer() or {}
	end)
	if v_u_143.x2Coins then
		v140 = v140 * 2
	end
	if v_u_143.x2Gems then
		v141 = v141 * 2
	end
	if v_u_143.x2EXP then
		v142 = v142 * 2
	end
	local v144 = v_u_32
	local v145 = v_u_62(v140)
	local v146 = v144:FindFirstChild("CurrencyIndicator")
	if v146 and v146:IsA("TextLabel") then
		v146.Text = v145
		local v147 = v146:FindFirstChild("CurrencyIndicator")
		if v147 then
			v147.Text = v145
		end
	end
	local v148 = v_u_33
	local v149 = v_u_62(v141)
	local v150 = v148:FindFirstChild("CurrencyIndicator")
	if v150 and v150:IsA("TextLabel") then
		v150.Text = v149
		local v151 = v150:FindFirstChild("CurrencyIndicator")
		if v151 then
			v151.Text = v149
		end
	end
	local v152 = v_u_34
	local v153 = v_u_62(v142)
	local v154 = v152:FindFirstChild("CurrencyIndicator")
	if v154 and v154:IsA("TextLabel") then
		v154.Text = v153
		local v155 = v154:FindFirstChild("CurrencyIndicator")
		if v155 then
			v155.Text = v153
		end
	end
	v_u_106(p134 or 0, p135 or 1, p138)
end
v_u_5:GetAttributeChangedSignal("HideQuestUI"):Connect(function()
	-- upvalues: (copy) v_u_5, (ref) v_u_46, (copy) v_u_21, (copy) v_u_20, (ref) v_u_44, (ref) v_u_41, (ref) v_u_42, (ref) v_u_43, (copy) v_u_40
	if v_u_5:GetAttribute("HideQuestUI") == true then
		if not v_u_46 then
			v_u_21.Visible = false
			v_u_20.Enabled = false
			v_u_44 = false
		end
	else
		if v_u_41 or v_u_42 then
			if (v_u_43 ~= "repeatable" or not v_u_41) and (v_u_43 ~= "questline" or not v_u_42) then
				if v_u_41 then
					v_u_43 = "repeatable"
				elseif v_u_42 then
					v_u_43 = "questline"
				else
					v_u_43 = nil
				end
			end
			if v_u_43 == "repeatable" and v_u_41 then
				showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
			elseif v_u_43 == "questline" and v_u_42 then
				showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
			end
			local v156 = v_u_40
			local v157
			if v_u_41 == nil then
				v157 = false
			else
				v157 = v_u_42 ~= nil
			end
			v156.Visible = v157
			v_u_44 = true
			v_u_20.Enabled = true
			v_u_21.Visible = true
		end
		return
	end
end)
local function v_u_170(p158)
	-- upvalues: (ref) v_u_47, (ref) v_u_48, (copy) v_u_50, (copy) v_u_7, (ref) v_u_41, (ref) v_u_43, (ref) v_u_42, (copy) v_u_40, (copy) v_u_5, (ref) v_u_44, (copy) v_u_20, (copy) v_u_21, (copy) v_u_24, (copy) v_u_25, (copy) v_u_35, (copy) v_u_8, (copy) v_u_11
	local v159
	if v_u_47 then
		if tick() - v_u_48 > 3 then
			v_u_47 = false
			v159 = false
		else
			v159 = true
		end
	else
		v159 = false
	end
	if v159 then
		return
	else
		local v_u_160 = v_u_50
		v_u_47 = true
		v_u_48 = tick()
		task.delay(v_u_160, function()
			-- upvalues: (ref) v_u_47, (ref) v_u_48, (copy) v_u_160
			if v_u_47 and tick() - v_u_48 >= v_u_160 - 0.1 then
				v_u_47 = false
			end
		end)
		local v161, _ = v_u_7.GetQuestType(p158)
		if v161 == "repeatable" then
			if v_u_41 and v_u_41.npcName == p158 then
				v_u_43 = "repeatable"
				if v_u_43 == "repeatable" and v_u_41 then
					showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
				elseif v_u_43 == "questline" and v_u_42 then
					showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
				end
				local v162 = v_u_40
				local v163
				if v_u_41 == nil then
					v163 = false
				else
					v163 = v_u_42 ~= nil
				end
				v162.Visible = v163
				if v_u_5:GetAttribute("HideQuestUI") ~= true then
					v_u_44 = true
					v_u_20.Enabled = true
					v_u_21.Visible = true
					v_u_24.Visible = true
					v_u_25.Visible = true
					v_u_35.Visible = false
					local v164 = v_u_40
					local v165
					if v_u_41 == nil then
						v165 = false
					else
						v165 = v_u_42 ~= nil
					end
					v164.Visible = v165
				end
			elseif v_u_41 then
				v_u_8:Show("Quest", {
					["alreadyInQuest"] = true
				})
			else
				v_u_11:FireServer(p158)
			end
		else
			if v161 == "questline" then
				if v_u_42 and v_u_7.GetQuestlineForNPC(p158) == v_u_42.questlineId then
					v_u_43 = "questline"
					if v_u_43 == "repeatable" and v_u_41 then
						showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
					elseif v_u_43 == "questline" and v_u_42 then
						showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
					end
					local v166 = v_u_40
					local v167
					if v_u_41 == nil then
						v167 = false
					else
						v167 = v_u_42 ~= nil
					end
					v166.Visible = v167
					if v_u_5:GetAttribute("HideQuestUI") ~= true then
						v_u_44 = true
						v_u_20.Enabled = true
						v_u_21.Visible = true
						v_u_24.Visible = true
						v_u_25.Visible = true
						v_u_35.Visible = false
						local v168 = v_u_40
						local v169
						if v_u_41 == nil then
							v169 = false
						else
							v169 = v_u_42 ~= nil
						end
						v168.Visible = v169
					end
				end
				if v_u_42 then
					v_u_8:Show("Quest", {
						["alreadyInQuest"] = true
					})
					return
				end
				v_u_11:FireServer(p158)
			end
			return
		end
	end
end
v31.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_47, (ref) v_u_48, (copy) v_u_49, (ref) v_u_43, (ref) v_u_41, (copy) v_u_12, (ref) v_u_42, (ref) v_u_44, (ref) v_u_46, (copy) v_u_21
	local v171
	if v_u_47 then
		if tick() - v_u_48 > 3 then
			v_u_47 = false
			v171 = false
		else
			v171 = true
		end
	else
		v171 = false
	end
	if v171 then
		return
	else
		local v_u_172 = v_u_49
		v_u_47 = true
		v_u_48 = tick()
		task.delay(v_u_172, function()
			-- upvalues: (ref) v_u_47, (ref) v_u_48, (copy) v_u_172
			if v_u_47 and tick() - v_u_48 >= v_u_172 - 0.1 then
				v_u_47 = false
			end
		end)
		if v_u_43 == "repeatable" and v_u_41 then
			v_u_12:FireServer("repeatable")
			return
		elseif v_u_43 == "questline" and v_u_42 then
			v_u_12:FireServer(v_u_42.questlineId)
		elseif v_u_44 then
			if v_u_46 then
				return
			end
			v_u_44 = false
			v_u_21.Visible = false
		end
	end
end)
v15.OnClientEvent:Connect(function(p173, p174)
	-- upvalues: (ref) v_u_41, (ref) v_u_43, (ref) v_u_42, (copy) v_u_40, (copy) v_u_5, (ref) v_u_44, (copy) v_u_20, (copy) v_u_21, (copy) v_u_24, (copy) v_u_25, (copy) v_u_35, (ref) v_u_107, (copy) v_u_106, (ref) v_u_46
	local v175 = p174 or {}
	if p173 == "accepted" or p173 == "restore" then
		if v175.questType == "repeatable" then
			v_u_41 = {
				["npcName"] = v175.questNpcName,
				["progress"] = v175.progress
			}
			if p173 == "accepted" then
				v_u_43 = "repeatable"
			end
			if (v_u_43 ~= "repeatable" or not v_u_41) and (v_u_43 ~= "questline" or not v_u_42) then
				if v_u_41 then
					v_u_43 = "repeatable"
				elseif v_u_42 then
					v_u_43 = "questline"
				else
					v_u_43 = nil
				end
			end
			if v_u_43 == "repeatable" and v_u_41 then
				showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
			elseif v_u_43 == "questline" and v_u_42 then
				showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
			end
			local v176 = v_u_40
			local v177
			if v_u_41 == nil then
				v177 = false
			else
				v177 = v_u_42 ~= nil
			end
			v176.Visible = v177
			if v_u_5:GetAttribute("HideQuestUI") ~= true then
				if v_u_5:GetAttribute("HideQuestUI") ~= true then
					v_u_44 = true
					v_u_20.Enabled = true
					v_u_21.Visible = true
					v_u_24.Visible = true
					v_u_25.Visible = true
					v_u_35.Visible = false
					local v178 = v_u_40
					local v179
					if v_u_41 == nil then
						v179 = false
					else
						v179 = v_u_42 ~= nil
					end
					v178.Visible = v179
				end
			end
		elseif v175.questType == "questline" then
			v_u_42 = {
				["questlineId"] = v175.questlineId,
				["currentStage"] = v175.currentStage,
				["progress"] = v175.progress,
				["goal"] = v175.goal,
				["title"] = v175.title,
				["description"] = v175.description,
				["bossProgress"] = v175.bossProgress,
				["stageRewards"] = v175.stageRewards
			}
			if p173 == "accepted" then
				v_u_43 = "questline"
			end
			if (v_u_43 ~= "repeatable" or not v_u_41) and (v_u_43 ~= "questline" or not v_u_42) then
				if v_u_41 then
					v_u_43 = "repeatable"
				elseif v_u_42 then
					v_u_43 = "questline"
				else
					v_u_43 = nil
				end
			end
			if v_u_43 == "repeatable" and v_u_41 then
				showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
			elseif v_u_43 == "questline" and v_u_42 then
				showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
			end
			local v180 = v_u_40
			local v181
			if v_u_41 == nil then
				v181 = false
			else
				v181 = v_u_42 ~= nil
			end
			v180.Visible = v181
			if not v_u_107 and (v_u_42 and (v_u_42.questlineId == "Christmas" and v_u_42.currentStage == 1)) then
				v_u_107 = true
				task.spawn(function()
					-- upvalues: (ref) v_u_107, (ref) v_u_42, (ref) v_u_44, (ref) v_u_43, (ref) v_u_106
					while v_u_107 and v_u_42 do
						task.wait(1)
						if not v_u_42 or (v_u_42.questlineId ~= "Christmas" or v_u_42.currentStage ~= 1) then
							break
						end
						local v182 = v_u_42
						local v183 = (v_u_42.progress or 0) + 1
						local v184 = v_u_42.goal
						v182.progress = math.min(v183, v184)
						if v_u_44 and v_u_43 == "questline" then
							v_u_106(v_u_42.progress, v_u_42.goal)
						end
					end
					v_u_107 = false
				end)
			end
			if v_u_5:GetAttribute("HideQuestUI") ~= true then
				if v_u_5:GetAttribute("HideQuestUI") ~= true then
					v_u_44 = true
					v_u_20.Enabled = true
					v_u_21.Visible = true
					v_u_24.Visible = true
					v_u_25.Visible = true
					v_u_35.Visible = false
					local v185 = v_u_40
					local v186
					if v_u_41 == nil then
						v186 = false
					else
						v186 = v_u_42 ~= nil
					end
					v185.Visible = v186
				end
			end
		end
	elseif p173 == "abandoned" then
		if v175.questType == "repeatable" or not (v175.questType or v175.questlineId) then
			v_u_41 = nil
		end
		if v175.questType == "questline" or v175.questlineId then
			v_u_107 = false
			v_u_42 = nil
		end
		if (v_u_43 ~= "repeatable" or not v_u_41) and (v_u_43 ~= "questline" or not v_u_42) then
			if v_u_41 then
				v_u_43 = "repeatable"
			elseif v_u_42 then
				v_u_43 = "questline"
			else
				v_u_43 = nil
			end
		end
		if v_u_43 then
			if v_u_43 == "repeatable" and v_u_41 then
				showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
			elseif v_u_43 == "questline" and v_u_42 then
				showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
			end
			local v187 = v_u_40
			local v188
			if v_u_41 == nil then
				v188 = false
			else
				v188 = v_u_42 ~= nil
			end
			v187.Visible = v188
			return
		end
		if v_u_44 then
			if not v_u_46 then
				v_u_44 = false
				v_u_21.Visible = false
			end
		end
	elseif p173 == "stageAdvanced" then
		if v_u_42 and v_u_42.questlineId == v175.questlineId then
			v_u_42.currentStage = v175.currentStage
			v_u_42.progress = v175.progress
			v_u_42.goal = v175.goal
			v_u_42.title = v175.title
			v_u_42.description = v175.description
			v_u_42.stageRewards = v175.stageRewards
			if v_u_43 == "questline" then
				if v_u_43 == "repeatable" and v_u_41 then
					showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
				elseif v_u_43 == "questline" and v_u_42 then
					showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
				end
				local v189 = v_u_40
				local v190
				if v_u_41 == nil then
					v190 = false
				else
					v190 = v_u_42 ~= nil
				end
				v189.Visible = v190
			end
			v_u_107 = false
			if v_u_107 then
				return
			end
			if v_u_42 and v_u_42.questlineId == "Christmas" then
				if v_u_42.currentStage == 1 then
					v_u_107 = true
					task.spawn(function()
						-- upvalues: (ref) v_u_107, (ref) v_u_42, (ref) v_u_44, (ref) v_u_43, (ref) v_u_106
						while v_u_107 and v_u_42 do
							task.wait(1)
							if not v_u_42 or (v_u_42.questlineId ~= "Christmas" or v_u_42.currentStage ~= 1) then
								break
							end
							local v191 = v_u_42
							local v192 = (v_u_42.progress or 0) + 1
							local v193 = v_u_42.goal
							v191.progress = math.min(v192, v193)
							if v_u_44 and v_u_43 == "questline" then
								v_u_106(v_u_42.progress, v_u_42.goal)
							end
						end
						v_u_107 = false
					end)
				end
			end
		end
	elseif p173 == "questlineComplete" then
		v_u_42 = nil
		if (v_u_43 ~= "repeatable" or not v_u_41) and (v_u_43 ~= "questline" or not v_u_42) then
			if v_u_41 then
				v_u_43 = "repeatable"
			elseif v_u_42 then
				v_u_43 = "questline"
			else
				v_u_43 = nil
			end
		end
		if v_u_43 then
			if v_u_43 == "repeatable" and v_u_41 then
				showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
			elseif v_u_43 == "questline" and v_u_42 then
				showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
			end
			local v194 = v_u_40
			local v195
			if v_u_41 == nil then
				v195 = false
			else
				v195 = v_u_42 ~= nil
			end
			v194.Visible = v195
			return
		end
		if v_u_44 then
			if v_u_46 then
				return
			end
			v_u_44 = false
			v_u_21.Visible = false
		end
	end
end)
v13.OnClientEvent:Connect(function(p196)
	-- upvalues: (ref) v_u_41, (ref) v_u_44, (ref) v_u_43, (copy) v_u_83, (ref) v_u_42, (copy) v_u_106
	local v197 = p196 or {}
	if v197.questType == "repeatable" and v_u_41 then
		v_u_41.progress = v197.progress
		if v_u_44 and v_u_43 == "repeatable" then
			v_u_83(v197.progress, v_u_41.npcName)
			return
		end
	elseif v197.questType == "questline" and v_u_42 then
		v_u_42.progress = v197.progress
		v_u_42.goal = v197.goal
		v_u_42.bossProgress = v197.bossProgress
		if v_u_44 and v_u_43 == "questline" then
			v_u_106(v197.progress, v197.goal, v197.bossProgress)
		end
	end
end)
local v_u_198 = nil
local function v_u_203(p199)
	-- upvalues: (ref) v_u_45, (copy) v_u_5, (copy) v_u_16, (ref) v_u_46, (ref) v_u_44, (copy) v_u_20, (copy) v_u_21, (copy) v_u_22, (copy) v_u_23, (copy) v_u_24, (copy) v_u_25, (copy) v_u_40, (copy) v_u_35, (copy) v_u_36, (ref) v_u_198, (ref) v_u_43, (ref) v_u_41, (ref) v_u_42
	v_u_45 = p199
	if v_u_5:GetAttribute("AutoQuestRepeat") == true then
		v_u_16:FireServer(p199)
	else
		v_u_46 = true
		task.defer(function()
			-- upvalues: (ref) v_u_44, (ref) v_u_20, (ref) v_u_21, (ref) v_u_22, (ref) v_u_23, (ref) v_u_24, (ref) v_u_25, (ref) v_u_40, (ref) v_u_35, (ref) v_u_36, (ref) v_u_198, (ref) v_u_46, (ref) v_u_43, (ref) v_u_41, (ref) v_u_42
			v_u_44 = true
			v_u_20.Enabled = true
			v_u_21.Visible = true
			v_u_22.Visible = true
			v_u_23.Visible = true
			v_u_24.Visible = false
			v_u_25.Visible = false
			v_u_40.Visible = false
			v_u_35.Visible = true
			v_u_36.Text = tostring(5)
			v_u_198 = task.spawn(function()
				-- upvalues: (ref) v_u_46, (ref) v_u_36, (ref) v_u_35, (ref) v_u_24, (ref) v_u_25, (ref) v_u_198, (ref) v_u_43, (ref) v_u_41, (ref) v_u_42, (ref) v_u_40, (ref) v_u_44, (ref) v_u_21
				for v200 = 5, 1, -1 do
					if not v_u_46 then
						return
					end
					v_u_36.Text = tostring(v200)
					task.wait(1)
				end
				if v_u_46 then
					v_u_46 = false
					v_u_35.Visible = false
					v_u_24.Visible = true
					v_u_25.Visible = true
					if v_u_198 then
						pcall(function()
							-- upvalues: (ref) v_u_198
							task.cancel(v_u_198)
						end)
					end
					v_u_198 = nil
					if (v_u_43 ~= "repeatable" or not v_u_41) and (v_u_43 ~= "questline" or not v_u_42) then
						if v_u_41 then
							v_u_43 = "repeatable"
						elseif v_u_42 then
							v_u_43 = "questline"
						else
							v_u_43 = nil
						end
					end
					if v_u_43 then
						if v_u_43 == "repeatable" and v_u_41 then
							showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
						elseif v_u_43 == "questline" and v_u_42 then
							showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
						end
						local v201 = v_u_40
						local v202
						if v_u_41 == nil then
							v202 = false
						else
							v202 = v_u_42 ~= nil
						end
						v201.Visible = v202
						return
					end
					if v_u_44 then
						if v_u_46 then
							return
						end
						v_u_44 = false
						v_u_21.Visible = false
					end
				end
			end)
		end)
	end
end
v38.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_45, (ref) v_u_46, (copy) v_u_35, (copy) v_u_24, (copy) v_u_25, (ref) v_u_198, (copy) v_u_16
	if v_u_45 then
		v_u_46 = false
		v_u_35.Visible = false
		v_u_24.Visible = true
		v_u_25.Visible = true
		if v_u_198 then
			pcall(function()
				-- upvalues: (ref) v_u_198
				task.cancel(v_u_198)
			end)
		end
		v_u_198 = nil
		v_u_16:FireServer(v_u_45)
	end
end)
v39.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_46, (copy) v_u_35, (copy) v_u_24, (copy) v_u_25, (ref) v_u_198, (ref) v_u_43, (ref) v_u_41, (ref) v_u_42, (copy) v_u_40, (ref) v_u_44, (copy) v_u_21
	v_u_46 = false
	v_u_35.Visible = false
	v_u_24.Visible = true
	v_u_25.Visible = true
	if v_u_198 then
		pcall(function()
			-- upvalues: (ref) v_u_198
			task.cancel(v_u_198)
		end)
	end
	v_u_198 = nil
	if (v_u_43 ~= "repeatable" or not v_u_41) and (v_u_43 ~= "questline" or not v_u_42) then
		if v_u_41 then
			v_u_43 = "repeatable"
		elseif v_u_42 then
			v_u_43 = "questline"
		else
			v_u_43 = nil
		end
	end
	if v_u_43 then
		if v_u_43 == "repeatable" and v_u_41 then
			showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
		elseif v_u_43 == "questline" and v_u_42 then
			showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
		end
		local v204 = v_u_40
		local v205
		if v_u_41 == nil then
			v205 = false
		else
			v205 = v_u_42 ~= nil
		end
		v204.Visible = v205
	elseif v_u_44 then
		if v_u_46 then
			return
		end
		v_u_44 = false
		v_u_21.Visible = false
	end
end)
v14.OnClientEvent:Connect(function(p206)
	-- upvalues: (ref) v_u_41, (copy) v_u_5, (copy) v_u_203, (ref) v_u_43, (ref) v_u_42, (copy) v_u_40, (ref) v_u_44, (ref) v_u_46, (copy) v_u_21
	if p206.questType == "repeatable" then
		local v207 = v_u_41 and v_u_41.npcName or nil
		v_u_41 = nil
		if v207 and v_u_5:GetAttribute("EnableQuestRepeat") == true then
			v_u_203(v207)
			return
		end
		if (v_u_43 ~= "repeatable" or not v_u_41) and (v_u_43 ~= "questline" or not v_u_42) then
			if v_u_41 then
				v_u_43 = "repeatable"
			elseif v_u_42 then
				v_u_43 = "questline"
			else
				v_u_43 = nil
			end
		end
		if v_u_43 then
			if v_u_43 == "repeatable" and v_u_41 then
				showRepeatableQuestDetails(v_u_41.npcName, v_u_41.progress)
			elseif v_u_43 == "questline" and v_u_42 then
				showQuestlineDetails(v_u_42.questlineId, v_u_42.currentStage, v_u_42.progress, v_u_42.goal, v_u_42.title, v_u_42.description, v_u_42.bossProgress, v_u_42.stageRewards)
			end
			local v208 = v_u_40
			local v209
			if v_u_41 == nil then
				v209 = false
			else
				v209 = v_u_42 ~= nil
			end
			v208.Visible = v209
			return
		end
		if v_u_44 then
			if v_u_46 then
				return
			end
			v_u_44 = false
			v_u_21.Visible = false
		end
	end
end)
local v_u_210 = {}
local v_u_211 = {}
local function v_u_217(p_u_212)
	-- upvalues: (copy) v_u_7, (copy) v_u_210, (copy) v_u_170, (copy) v_u_211
	if v_u_7.GetQuestType(p_u_212.Name) ~= nil and not v_u_210[p_u_212] then
		if not (function()
			-- upvalues: (copy) p_u_212, (ref) v_u_210, (ref) v_u_170
			for _, v213 in ipairs(p_u_212:GetDescendants()) do
				if v213:IsA("ProximityPrompt") and (v213.Name == "QuestPrompt" or v213.Name == "HakiQuestPrompt") then
					if not v_u_210[p_u_212] then
						v_u_210[p_u_212] = v213.Triggered:Connect(function()
							-- upvalues: (ref) v_u_170, (ref) p_u_212
							v_u_170(p_u_212.Name)
						end)
					end
					return true
				end
			end
			return false
		end)() then
			local v_u_214 = nil
			v_u_214 = p_u_212.DescendantAdded:Connect(function(p215)
				-- upvalues: (ref) v_u_210, (copy) p_u_212, (ref) v_u_170, (ref) v_u_214, (ref) v_u_211
				if p215:IsA("ProximityPrompt") and (p215.Name == "QuestPrompt" or p215.Name == "HakiQuestPrompt") then
					if not v_u_210[p_u_212] then
						v_u_210[p_u_212] = p215.Triggered:Connect(function()
							-- upvalues: (ref) v_u_170, (ref) p_u_212
							v_u_170(p_u_212.Name)
						end)
					end
					v_u_214:Disconnect()
					v_u_211[p_u_212] = nil
				end
			end)
			v_u_211[p_u_212] = v_u_214
			p_u_212.Destroying:Connect(function()
				-- upvalues: (copy) p_u_212, (ref) v_u_210, (ref) v_u_211
				local v216 = p_u_212
				if v_u_210[v216] then
					v_u_210[v216]:Disconnect()
					v_u_210[v216] = nil
				end
				if v_u_211[v216] then
					v_u_211[v216]:Disconnect()
					v_u_211[v216] = nil
				end
			end)
		end
	else
		return
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_217, (copy) v_u_210, (copy) v_u_211
	task.wait(1.5)
	for _, v218 in ipairs(workspace:GetChildren()) do
		if v218:IsA("Model") then
			v_u_217(v218)
		end
	end
	local v219 = workspace:FindFirstChild("ServiceNPCs")
	if v219 then
		for _, v220 in ipairs(v219:GetChildren()) do
			if v220:IsA("Model") then
				v_u_217(v220)
			end
		end
		v219.ChildAdded:Connect(function(p221)
			-- upvalues: (ref) v_u_217
			if p221:IsA("Model") then
				task.wait(0.1)
				v_u_217(p221)
			end
		end)
		v219.ChildRemoved:Connect(function(p222)
			-- upvalues: (ref) v_u_210, (ref) v_u_211
			if p222:IsA("Model") then
				if v_u_210[p222] then
					v_u_210[p222]:Disconnect()
					v_u_210[p222] = nil
				end
				if v_u_211[p222] then
					v_u_211[p222]:Disconnect()
					v_u_211[p222] = nil
				end
			end
		end)
	end
	workspace.ChildAdded:Connect(function(p223)
		-- upvalues: (ref) v_u_217
		if p223:IsA("Model") then
			task.wait(0.1)
			v_u_217(p223)
		end
	end)
	workspace.ChildRemoved:Connect(function(p224)
		-- upvalues: (ref) v_u_210, (ref) v_u_211
		if p224:IsA("Model") then
			if v_u_210[p224] then
				v_u_210[p224]:Disconnect()
				v_u_210[p224] = nil
			end
			if v_u_211[p224] then
				v_u_211[p224]:Disconnect()
				v_u_211[p224] = nil
			end
		end
	end)
end)
local function v227(p225)
	-- upvalues: (ref) v_u_47, (ref) v_u_48, (copy) v_u_51
	v_u_47 = false
	v_u_48 = 0
	local v226 = p225:WaitForChild("Humanoid", 10)
	if v226 then
		v226.Died:Connect(v_u_51)
	end
end
if v_u_5.Character then
	task.spawn(function()
		-- upvalues: (copy) v_u_5, (ref) v_u_47, (ref) v_u_48, (copy) v_u_51
		local v228 = v_u_5.Character
		v_u_47 = false
		v_u_48 = 0
		local v229 = v228:WaitForChild("Humanoid", 10)
		if v229 then
			v229.Died:Connect(v_u_51)
		end
	end)
end
v_u_5.CharacterAdded:Connect(v227)
v4.InputBegan:Connect(function(p230, p231)
	-- upvalues: (ref) v_u_41, (ref) v_u_42, (ref) v_u_44, (ref) v_u_73, (copy) v_u_72
	if not p231 then
		if p230.KeyCode == Enum.KeyCode.Tab then
			local v232
			if v_u_41 == nil then
				v232 = false
			else
				v232 = v_u_42 ~= nil
			end
			if v232 and (v_u_44 and not v_u_73) then
				v_u_73 = true
				v_u_72()
				task.delay(0.3, function()
					-- upvalues: (ref) v_u_73
					v_u_73 = false
				end)
			end
		end
	end
end)
v_u_21.Visible = false
v_u_20.Enabled = false
v_u_35.Visible = false
v_u_40.Visible = false
v_u_46 = false
v_u_8:Init(v6)
task.spawn(function()
	-- upvalues: (ref) v_u_47, (ref) v_u_48
	while true do
		repeat
			task.wait(5)
		until v_u_47 and tick() - v_u_48 > 3
		v_u_47 = false
		v_u_48 = 0
	end
end)
task.spawn(function()
	-- upvalues: (copy) v_u_210, (copy) v_u_7, (copy) v_u_217
	task.wait(3)
	for _ = 1, 6 do
		task.wait(5)
		local v233 = false
		for _, v234 in ipairs(workspace:GetChildren()) do
			if v234:IsA("Model") and not v_u_210[v234] and v_u_7.GetQuestType(v234.Name) ~= nil then
				v_u_217(v234)
				v233 = true
			end
		end
		local v235 = workspace:FindFirstChild("ServiceNPCs")
		if v235 then
			for _, v236 in ipairs(v235:GetChildren()) do
				if v236:IsA("Model") and not v_u_210[v236] and v_u_7.GetQuestType(v236.Name) ~= nil then
					v_u_217(v236)
					v233 = true
				end
			end
		end
		if not v233 then
			break
		end
	end
end)