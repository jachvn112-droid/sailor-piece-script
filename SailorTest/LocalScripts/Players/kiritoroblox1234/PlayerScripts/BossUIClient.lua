local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = v1.LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui"):WaitForChild("BossUI"):WaitForChild("MainFrame")
local v6 = v2:WaitForChild("Remotes")
local v7 = v6:WaitForChild("BossUIUpdate")
local v8 = v6:WaitForChild("BossUIShow")
local v9 = v6:WaitForChild("BossUIHide")
local v10 = v6:WaitForChild("BossPityUpdate")
local v_u_11 = v_u_5:WaitForChild("BossName")
local v12 = v_u_5:WaitForChild("BossHPBar")
local v_u_13 = v12:WaitForChild("HPOfBoss")
local v_u_14 = v12:WaitForChild("LoaderHolder"):WaitForChild("Loader")
local v_u_15 = v12:WaitForChild("Pity")
local v16 = v_u_5:WaitForChild("StatsHolder")
local v_u_17 = v16:WaitForChild("DropStats")
local v18 = v16:WaitForChild("Holder")
local v_u_19 = v18:WaitForChild("StatYou")
local v_u_20 = v18:WaitForChild("Holder2"):WaitForChild("DamageStats")
local v_u_21 = false
local v_u_22 = nil
local v_u_23 = nil
local v_u_24 = {
	["Mythical"] = "StatMythical",
	["Legendary"] = "StatLegendary",
	["Epic"] = "StatEpic",
	["Rare"] = "StatRare",
	["Uncommon"] = "StatUncommon",
	["Common"] = "StatCommon"
}
local function v_u_29(p25)
	local v26 = math.floor(p25)
	local v27 = tostring(v26)
	repeat
		local v28
		v27, v28 = string.gsub(v27, "^(-?%d+)(%d%d%d)", "%1,%2")
	until v28 == 0
	return v27
end
local function v_u_34(p30, p31)
	-- upvalues: (copy) v_u_13, (copy) v_u_29, (copy) v_u_3, (copy) v_u_14
	v_u_13.Text = v_u_29(p30) .. "/" .. v_u_29(p31)
	local v32 = p30 / p31
	local v33 = math.clamp(v32, 0, 1)
	v_u_3:Create(v_u_14, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
		["Size"] = UDim2.new(v33, 0, 1, 0)
	}):Play()
end
local function v_u_45(p35)
	-- upvalues: (copy) v_u_17, (copy) v_u_24
	for _, v36 in ipairs(v_u_17:GetChildren()) do
		if v36:IsA("TextLabel") then
			if v36:GetAttribute("IsClone") then
				v36:Destroy()
			else
				v36.Visible = false
			end
		end
	end
	if p35 and #p35 ~= 0 then
		table.sort(p35, function(p37, p38)
			return (p37.chance or 0) > (p38.chance or 0)
		end)
		local v39 = {}
		for _, v40 in ipairs(v_u_17:GetChildren()) do
			if v40:IsA("TextLabel") and not v40:GetAttribute("IsClone") then
				v39[v40.Name] = v40
			end
		end
		for v41, v42 in ipairs(p35) do
			local v43 = v_u_24[v42.rarity or "Common"] or "StatCommon"
			local v44 = v39[v43]
			if v44 then
				if v44.Visible then
					v44 = v44:Clone()
					v44:SetAttribute("IsClone", true)
					v44.Name = v43 .. "_" .. v41
					v44.Parent = v_u_17
				end
				if v44 then
					v44.LayoutOrder = v41
					v44.Text = v42.name .. " " .. string.format("%.2f", v42.chance) .. "%"
					v44.Visible = true
				end
			end
		end
	end
end
local function v_u_57(p46)
	-- upvalues: (copy) v_u_19, (copy) v_u_20, (copy) v_u_4
	v_u_19.Text = "YOU: " .. string.format("%.1f", p46.yourPercent or 0) .. "%"
	local v47 = {}
	for _, v48 in ipairs(v_u_20:GetChildren()) do
		if v48:IsA("TextLabel") and v48.Name == "Stat" then
			table.insert(v47, v48)
		end
	end
	local v49 = p46.stats or {}
	local v50 = {}
	for _, v51 in ipairs(v49) do
		if v51.player ~= v_u_4 then
			table.insert(v50, v51)
		end
	end
	for v52, v53 in ipairs(v50) do
		local v54 = v47[v52]
		if v54 then
			v54.LayoutOrder = v52
			local v55 = v53.player.DisplayName or v53.player.Name
			if #v55 > 12 then
				v55 = string.sub(v55, 1, 12) .. ".."
			end
			v54.Text = v55 .. ": " .. string.format("%.1f", v53.percent) .. "%"
			v54.Visible = true
		end
	end
	for v56 = #v50 + 1, #v47 do
		v47[v56].Visible = false
	end
end
local function v_u_63(p58)
	-- upvalues: (ref) v_u_23, (copy) v_u_4, (ref) v_u_22, (ref) v_u_21, (copy) v_u_11, (copy) v_u_34, (copy) v_u_15, (copy) v_u_45, (copy) v_u_19, (copy) v_u_20, (copy) v_u_5, (copy) v_u_3
	v_u_23 = p58
	if not v_u_4:GetAttribute("HideBossHealthBar") then
		v_u_22 = p58
		v_u_21 = true
		local v59 = v_u_11
		local v60 = p58.bossName
		local v61 = p58.displayLevel
		v59.Text = v60 .. " [Lv." .. tostring(v61) .. "]"
		v_u_34(p58.currentHP, p58.maxHP)
		v_u_15.Text = "Pity: " .. p58.pity .. "/" .. p58.maxPity
		v_u_45(p58.drops)
		v_u_19.Text = "YOU: 0%"
		for _, v62 in ipairs(v_u_20:GetChildren()) do
			if v62:IsA("TextLabel") and v62.Name == "Stat" then
				v62.Visible = false
			end
		end
		v_u_5.Visible = true
		v_u_5.Position = UDim2.new(0.5, 0, -0.5, 0)
		v_u_3:Create(v_u_5, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Position"] = UDim2.new(0.5, 0, 0.017, 0)
		}):Play()
	end
end
local function v_u_65()
	-- upvalues: (ref) v_u_21, (ref) v_u_22, (copy) v_u_3, (copy) v_u_5
	if v_u_21 then
		v_u_21 = false
		v_u_22 = nil
		local v64 = v_u_3:Create(v_u_5, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			["Position"] = UDim2.new(0.5, 0, -0.5, 0)
		})
		v64:Play()
		v64.Completed:Connect(function()
			-- upvalues: (ref) v_u_21, (ref) v_u_5
			if not v_u_21 then
				v_u_5.Visible = false
			end
		end)
	end
end
v8.OnClientEvent:Connect(function(p66)
	-- upvalues: (copy) v_u_63
	v_u_63(p66)
end)
v9.OnClientEvent:Connect(function()
	-- upvalues: (ref) v_u_23, (copy) v_u_65
	v_u_23 = nil
	v_u_65()
end)
v7.OnClientEvent:Connect(function(p67, p68)
	-- upvalues: (ref) v_u_23, (ref) v_u_21, (copy) v_u_34, (copy) v_u_57
	if p67 == "Health" then
		if v_u_23 then
			v_u_23.currentHP = p68.current
			v_u_23.maxHP = p68.max
		end
		if v_u_21 then
			v_u_34(p68.current, p68.max)
			return
		end
	elseif p67 == "DamageStats" and v_u_21 then
		v_u_57(p68)
	end
end)
v10.OnClientEvent:Connect(function(p69, p70)
	-- upvalues: (copy) v_u_15
	v_u_15.Text = "Pity: " .. p69 .. "/" .. p70
end)
v_u_5.Visible = false
v_u_5.Position = UDim2.new(0.5, 0, -0.5, 0)
v_u_4:GetAttributeChangedSignal("HideBossHealthBar"):Connect(function()
	-- upvalues: (copy) v_u_4, (ref) v_u_21, (copy) v_u_65, (ref) v_u_23, (copy) v_u_63
	local v71 = v_u_4:GetAttribute("HideBossHealthBar")
	if v71 and v_u_21 then
		v_u_65()
	elseif not v71 and (v_u_23 and not v_u_21) then
		v_u_63(v_u_23)
	end
end)