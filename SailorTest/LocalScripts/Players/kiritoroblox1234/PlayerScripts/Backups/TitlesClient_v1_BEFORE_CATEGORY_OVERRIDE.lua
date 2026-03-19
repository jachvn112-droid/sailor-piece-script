local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v4 = v2:WaitForChild("Modules")
local v_u_5 = require(v4:WaitForChild("TitlesConfig"))
local v_u_6 = require(v4:WaitForChild("UIManager"))
local v7 = v2:WaitForChild("RemoteEvents")
local v8 = v2:WaitForChild("Remotes")
local v_u_9 = v7:WaitForChild("TitleEquip")
local v_u_10 = v7:WaitForChild("TitleUnequip")
local v11 = v7:WaitForChild("TitleDataSync")
local v_u_12 = v7:WaitForChild("DisplayTitleEquip")
local v_u_13 = v7:WaitForChild("DisplayTitleUnequip")
local v14 = v8:WaitForChild("OpenTitlesUI")
local v_u_15 = v8:WaitForChild("GetTitlesData")
local v_u_16 = v8:WaitForChild("TitleLockedInfo")
local v17 = v3:WaitForChild("TitlesUI")
local v18 = v17:WaitForChild("MainFrame")
local v_u_19 = v18:WaitForChild("Frame")
local v_u_20 = v_u_19:WaitForChild("Content"):WaitForChild("Holder")
local v_u_21 = {
	["level"] = "Level",
	["itemDrops"] = "Collection",
	["bossKills"] = "Boss Kills",
	["bossDrop"] = "Boss Drops",
	["strongestBossDrop"] = "Boss Drops",
	["questline"] = "Events",
	["staff"] = "Staff"
}
local v_u_22 = {
	["Level"] = 100,
	["Collection"] = 200,
	["Boss Kills"] = 250,
	["Boss Drops"] = 300,
	["Events"] = 400,
	["Staff"] = 500
}
local v_u_23 = nil
local v_u_24 = {}
local v_u_25 = {}
local function v_u_33(p26, p27)
	local v28 = p26:FindFirstChild("BuffButtonsHolder")
	if v28 then
		local v29 = v28:FindFirstChild("Equip")
		local v30 = v28:FindFirstChild("UnEquip")
		local v31 = v28:FindFirstChild("Locked")
		local v32 = v28:FindFirstChild("Txt")
		if v29 then
			v29.Visible = false
		end
		if v30 then
			v30.Visible = false
		end
		if v31 then
			v31.Visible = false
		end
		if p27 == "locked" then
			if v31 then
				v31.Visible = true
			end
			if v32 then
				v32.Text = "Locked"
				return
			end
		elseif p27 == "equip" then
			if v29 then
				v29.Visible = true
			end
			if v32 then
				v32.Text = "Equip"
				return
			end
		elseif p27 == "unequip" then
			if v30 then
				v30.Visible = true
			end
			if v32 then
				v32.Text = "Unequip"
			end
		end
	end
end
local function v_u_41(p34, p35)
	local v36 = p34:FindFirstChild("DisplayButtonsHolder")
	if v36 then
		local v37 = v36:FindFirstChild("DisplayEquip")
		local v38 = v36:FindFirstChild("DisplayUnEquip")
		local v39 = v36:FindFirstChild("DisplayLocked")
		local v40 = v36:FindFirstChild("Txt")
		if v37 then
			v37.Visible = false
		end
		if v38 then
			v38.Visible = false
		end
		if v39 then
			v39.Visible = false
		end
		if p35 == "locked" then
			if v39 then
				v39.Visible = true
			end
			if v40 then
				v40.Text = "Locked"
				return
			end
		elseif p35 == "equip" then
			if v37 then
				v37.Visible = true
			end
			if v40 then
				v40.Text = "Display"
				return
			end
		elseif p35 == "undisplay" then
			if v38 then
				v38.Visible = true
			end
			if v40 then
				v40.Text = "Displayed"
			end
		end
	end
end
local function v_u_51()
	-- upvalues: (ref) v_u_25, (ref) v_u_23, (copy) v_u_5, (ref) v_u_24
	local v42 = v_u_25.Staff
	if not v42 then
		return
	end
	local v43 = v_u_23 and v_u_23.unlocked or {}
	local v44 = false
	for _, v45 in ipairs(v43) do
		local v46 = v_u_5:GetTitle(v45)
		if v46 and v46.unlockType == "staff" then
			v44 = true
			break
		end
	end
	v42.Visible = v44
	for v47, v48 in pairs(v_u_24) do
		local v49 = v_u_5:GetTitle(v47)
		if v49 and v49.unlockType == "staff" then
			local v50
			if v44 then
				v50 = table.find(v43, v47) ~= nil
			else
				v50 = v44
			end
			v48.Visible = v50
		end
	end
end
local function v_u_60()
	-- upvalues: (ref) v_u_23, (ref) v_u_24, (copy) v_u_33, (copy) v_u_41, (copy) v_u_51
	if v_u_23 then
		local v52 = v_u_23.unlocked or {}
		local v53 = v_u_23.equipped
		local v54 = v_u_23.displayTitle
		for v55, v56 in pairs(v_u_24) do
			local v57 = table.find(v52, v55) ~= nil
			local v58 = v53 == v55
			local v59 = v54 == v55
			if v58 then
				v_u_33(v56, "unequip")
			elseif v57 then
				v_u_33(v56, "equip")
			else
				v_u_33(v56, "locked")
			end
			if v59 then
				v_u_41(v56, "undisplay")
			elseif v57 then
				v_u_41(v56, "equip")
			else
				v_u_41(v56, "locked")
			end
		end
		v_u_51()
	end
end
local function v_u_73(p61, p_u_62)
	-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_16, (copy) v_u_12, (copy) v_u_13
	local v63 = p61:FindFirstChild("BuffButtonsHolder")
	if v63 then
		local v64 = v63:FindFirstChild("Equip")
		local v65 = v63:FindFirstChild("UnEquip")
		local v66 = v63:FindFirstChild("Locked")
		if v64 then
			v64.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_9, (copy) p_u_62
				v_u_9:FireServer(p_u_62)
			end)
		end
		if v65 then
			v65.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_10
				v_u_10:FireServer()
			end)
		end
		if v66 then
			local v67 = v66:FindFirstChild("ClickDetector")
			if not v67 then
				v67 = Instance.new("TextButton")
				v67.Name = "ClickDetector"
				v67.Size = UDim2.new(1, 0, 1, 0)
				v67.BackgroundTransparency = 1
				v67.Text = ""
				v67.Parent = v66
			end
			v67.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_16, (copy) p_u_62
				v_u_16:FireServer(p_u_62)
			end)
		end
	end
	local v68 = p61:FindFirstChild("DisplayButtonsHolder")
	if v68 then
		local v69 = v68:FindFirstChild("DisplayEquip")
		local v70 = v68:FindFirstChild("DisplayUnEquip")
		local v71 = v68:FindFirstChild("DisplayLocked")
		if v69 then
			v69.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_12, (copy) p_u_62
				v_u_12:FireServer(p_u_62)
			end)
		end
		if v70 then
			v70.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_13
				v_u_13:FireServer()
			end)
		end
		if v71 then
			local v72 = v71:FindFirstChild("ClickDetector")
			if not v72 then
				v72 = Instance.new("TextButton")
				v72.Name = "ClickDetector"
				v72.Size = UDim2.new(1, 0, 1, 0)
				v72.BackgroundTransparency = 1
				v72.Text = ""
				v72.Parent = v71
			end
			v72.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_16, (copy) p_u_62
				v_u_16:FireServer(p_u_62)
			end)
		end
	end
end
local function v_u_76()
	-- upvalues: (ref) v_u_24, (ref) v_u_25
	for _, v74 in pairs(v_u_24) do
		if v74 and v74.Parent then
			v74:Destroy()
		end
	end
	v_u_24 = {}
	for _, v75 in pairs(v_u_25) do
		if v75 and v75.Parent then
			v75:Destroy()
		end
	end
	v_u_25 = {}
end
local function v_u_89(p77, p78, p79)
	-- upvalues: (copy) v_u_20, (copy) v_u_5, (ref) v_u_24
	local v80 = v_u_20:FindFirstChild("Templates")
	local v81
	if v80 then
		v81 = v80:FindFirstChild("TitleTemplate")
		v80:FindFirstChild("CategoryTemplate")
	else
		v81 = nil
	end
	if not v81 then
		return nil
	end
	local v82 = v81:Clone()
	v82.Name = "Title_" .. p77:gsub(" ", ""):gsub("\'", "")
	v82.LayoutOrder = p79 + (p78.sortOrder or 999)
	v82.Visible = true
	local v83 = v_u_5:GetTitleColor(p77)
	local v84 = v82:FindFirstChild("Holder")
	if v84 then
		local v85 = v84:FindFirstChild("Title")
		if v85 then
			v85.Text = p78.displayName
			v85.TextColor3 = v83
			local v86 = v85:FindFirstChild("UIGradient")
			if v86 then
				v86.Color = ColorSequence.new(v83)
			end
		end
		local v87 = v84:FindFirstChild("Description")
		if v87 then
			local v88 = v_u_5:GetBonusDescription(p77)
			v87.Text = (v88 == "" or not v88) and (p78.description or "No bonuses") or v88
		end
	end
	v82:SetAttribute("TitleId", p77)
	v_u_24[p77] = v82
	return v82
end
local function v_u_118()
	-- upvalues: (copy) v_u_76, (ref) v_u_23, (copy) v_u_5, (copy) v_u_22, (copy) v_u_21, (copy) v_u_20, (ref) v_u_25, (copy) v_u_89, (copy) v_u_73, (copy) v_u_60
	v_u_76()
	local v90 = v_u_23 and v_u_23.unlocked or {}
	local v91 = false
	for _, v92 in ipairs(v90) do
		local v93 = v_u_5:GetTitle(v92)
		if v93 and v93.unlockType == "staff" then
			v91 = true
			break
		end
	end
	local v94 = {}
	for v95, _ in pairs(v_u_22) do
		v94[v95] = {}
	end
	for v96, v97 in pairs(v_u_5:GetAllTitles()) do
		if v97.unlockType ~= "staff" or v91 then
			local v98 = v_u_21[v97.unlockType] or "Level"
			if v94[v98] then
				local v99 = v94[v98]
				table.insert(v99, {
					["id"] = v96,
					["config"] = v97
				})
			end
		end
	end
	for _, v100 in pairs(v94) do
		table.sort(v100, function(p101, p102)
			return (p101.config.sortOrder or 999) < (p102.config.sortOrder or 999)
		end)
	end
	local v103 = {}
	for v104, v105 in pairs(v_u_22) do
		table.insert(v103, {
			["name"] = v104,
			["order"] = v105
		})
	end
	table.sort(v103, function(p106, p107)
		return p106.order < p107.order
	end)
	for _, v108 in ipairs(v103) do
		local v109 = v108.name
		local v110 = v108.order
		local v111 = v94[v109]
		if (v109 ~= "Staff" or v91) and #v111 > 0 then
			local v112 = v_u_20:FindFirstChild("Templates")
			local v113
			if v112 then
				v112:FindFirstChild("TitleTemplate")
				v113 = v112:FindFirstChild("CategoryTemplate")
			else
				v113 = nil
			end
			local v114
			if v113 then
				v114 = v113:Clone()
				v114.Name = "Category_" .. v109:gsub(" ", "")
				v114.LayoutOrder = v110
				v114.Visible = true
				local v115 = v114:FindFirstChild("Txt")
				if v115 then
					v115.Text = v109
				end
				v_u_25[v109] = v114
			else
				v114 = nil
			end
			if v114 then
				v114.Parent = v_u_20
			end
			for _, v116 in ipairs(v111) do
				if v116.config.unlockType ~= "staff" or table.find(v90, v116.id) then
					local v117 = v_u_89(v116.id, v116.config, v110)
					if v117 then
						v_u_73(v117, v116.id)
						v117.Parent = v_u_20
					end
				end
			end
		end
	end
	v_u_60()
end
local function v_u_119()
	-- upvalues: (copy) v_u_6
	if v_u_6:IsOpen("TitlesUI") then
		v_u_6:Close("TitlesUI")
	end
end
local function v120()
	-- upvalues: (copy) v_u_6, (ref) v_u_23, (copy) v_u_15, (copy) v_u_118
	if not v_u_6:IsOpen("TitlesUI") then
		v_u_23 = v_u_15:InvokeServer()
		v_u_118()
		v_u_6:Open("TitlesUI")
	end
end
v14.OnClientEvent:Connect(v120)
v11.OnClientEvent:Connect(function(p121)
	-- upvalues: (ref) v_u_23, (copy) v_u_6, (copy) v_u_60
	v_u_23 = p121
	if v_u_6:IsOpen("TitlesUI") then
		v_u_60()
	end
end)
v17.Enabled = true
v_u_6:Register("TitlesUI", v18)
v18.Visible = false
(function()
	-- upvalues: (copy) v_u_19, (copy) v_u_119
	local v122 = v_u_19:FindFirstChild("CloseButtonFrame")
	if v122 then
		local v123 = v122:FindFirstChild("CloseButton")
		if v123 then
			local v124 = v123:FindFirstChild("LocalScript")
			if v124 then
				v124:Destroy()
			end
			v123.MouseButton1Click:Connect(v_u_119)
		end
	end
end)()