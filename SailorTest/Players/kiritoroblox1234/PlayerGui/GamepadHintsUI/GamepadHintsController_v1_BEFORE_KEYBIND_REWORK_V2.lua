local v1 = game:GetService("Players")
local v2 = game:GetService("UserInputService")
game:GetService("GuiService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = v1.LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui")
local v6 = v_u_3:WaitForChild("Modules")
local v_u_7 = require(v6:WaitForChild("InputManager")):Init()
local v8 = v_u_3:WaitForChild("RemoteEvents")
local v_u_9 = v8:WaitForChild("HakiRemote")
local v10 = v_u_3:FindFirstChild("Remotes")
if v10 then
	v10 = v_u_3.Remotes:FindFirstChild("ConquerorHakiRemote")
end
local v_u_11 = v8:WaitForChild("ObservationHakiRemote")
local v_u_12 = nil
local v_u_13 = nil
pcall(function()
	-- upvalues: (ref) v_u_12, (copy) v_u_3
	v_u_12 = require(v_u_3:WaitForChild("AbilitySystem"):WaitForChild("AbilityConfig"))
end)
pcall(function()
	-- upvalues: (copy) v_u_3, (ref) v_u_13
	local v14 = v_u_3:FindFirstChild("FruitPowerSystem")
	if v14 then
		v_u_13 = require(v14:WaitForChild("FruitPowerConfig"))
	end
end)
local v_u_15 = script.Parent:WaitForChild("HintsContainer")
local v_u_16 = {
	{
		["action"] = "AbilityZ",
		["text"] = "Skill Z"
	},
	{
		["action"] = "AbilityX",
		["text"] = "Skill X"
	},
	{
		["action"] = "AbilityC",
		["text"] = "Skill C"
	},
	{
		["action"] = "AbilityV",
		["text"] = "Skill V"
	},
	{
		["action"] = "AbilityF",
		["text"] = "Skill F"
	}
}
local v_u_17 = "default"
local v_u_18 = {}
local v_u_19 = nil
local v_u_20 = false
local v_u_21 = false
local v_u_22 = false
local function v_u_24()
	-- upvalues: (ref) v_u_18
	for _, v23 in ipairs(v_u_18) do
		v23:Destroy()
	end
	v_u_18 = {}
end
local function v_u_37(p25, p26, p27)
	-- upvalues: (copy) v_u_7, (copy) v_u_15, (ref) v_u_18
	local v28 = Instance.new("Frame")
	v28.Name = "Hint_" .. p25
	v28.Size = UDim2.new(0, 150, 0, 32)
	v28.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	v28.BackgroundTransparency = 0.3
	v28.LayoutOrder = p27
	local v29 = Instance.new("UICorner")
	v29.CornerRadius = UDim.new(0, 8)
	v29.Parent = v28
	local v30 = Instance.new("UIPadding")
	v30.PaddingLeft = UDim.new(0, 8)
	v30.PaddingRight = UDim.new(0, 8)
	v30.Parent = v28
	local v31 = v_u_7:GetKeyCode(p25)
	local v32 = Instance.new("ImageLabel")
	v32.Name = "ButtonIcon"
	v32.Size = UDim2.new(0, 24, 0, 24)
	v32.Position = UDim2.new(0, 0, 0.5, 0)
	v32.AnchorPoint = Vector2.new(0, 0.5)
	v32.BackgroundTransparency = 1
	v32.ScaleType = Enum.ScaleType.Fit
	local v33 = v_u_7:GetButtonIcon(v31)
	if v33 then
		v32.Image = v33
	end
	v32.Parent = v28
	local v34 = Instance.new("TextLabel")
	v34.Name = "ButtonText"
	v34.Size = UDim2.new(0, 24, 0, 24)
	v34.Position = UDim2.new(0, 0, 0.5, 0)
	v34.AnchorPoint = Vector2.new(0, 0.5)
	v34.BackgroundTransparency = 1
	v34.TextColor3 = Color3.fromRGB(255, 255, 255)
	v34.TextSize = 12
	v34.Font = Enum.Font.GothamBold
	v34.Text = v33 and "" or v_u_7:GetButtonName(p25)
	v34.Visible = not v33
	v34.Parent = v28
	local v35 = Instance.new("TextLabel")
	v35.Name = "ActionLabel"
	v35.Size = UDim2.new(1, -32, 1, 0)
	v35.Position = UDim2.new(0, 32, 0, 0)
	v35.BackgroundTransparency = 1
	v35.TextColor3 = Color3.fromRGB(255, 255, 255)
	v35.TextSize = 14
	v35.Font = Enum.Font.GothamMedium
	v35.TextXAlignment = Enum.TextXAlignment.Left
	v35.Text = p26
	v35.Parent = v28
	v28.Parent = v_u_15
	local v36 = v_u_18
	table.insert(v36, v28)
	return v28
end
local function v_u_47()
	-- upvalues: (copy) v_u_4, (ref) v_u_13, (ref) v_u_12
	local v38 = v_u_4.Character
	if not v38 then
		return 0
	end
	local v39 = v38:FindFirstChildOfClass("Tool")
	if not v39 then
		return 0
	end
	local v40 = v39.Name
	if v_u_13 and v_u_13.Powers then
		for v41, v42 in pairs(v_u_13.Powers) do
			if (v42.ToolName == v40 or v41 == v40) and (v42.Abilities and v42.Enabled) then
				return #v42.Abilities
			end
		end
	end
	if v_u_12 and v_u_12.Movesets then
		for v43, v44 in pairs(v_u_12.Movesets) do
			if (v44.ToolName == v40 or v43 == v40) and v44.Abilities then
				local v45 = 0
				for v46, _ in pairs(v44.Abilities) do
					if type(v46) == "number" and v45 < v46 then
						v45 = v46
					end
				end
				return v45
			end
		end
	end
	return 0
end
local function v_u_58(p48)
	-- upvalues: (copy) v_u_24, (copy) v_u_37, (copy) v_u_47, (copy) v_u_16, (ref) v_u_20, (ref) v_u_21, (ref) v_u_22
	v_u_24()
	if p48 == "menu" then
		v_u_37("UIConfirm", "Select", 1)
		v_u_37("UIBack", "Back", 2)
	elseif p48 == "combat" then
		local v49 = v_u_47()
		local v50 = 1
		v_u_37("Attack", "Attack", v50)
		local v51 = v50 + 1
		v_u_37("Dash", "Dash", v51)
		local v52 = v51 + 1
		for v53 = 1, math.min(v49, 5) do
			local v54 = v_u_16[v53]
			if v54 then
				v_u_37(v54.action, v54.text, v52)
				v52 = v52 + 1
			end
		end
		if v_u_20 then
			v_u_37("Haki", "Haki", v52)
			v52 = v52 + 1
		end
		if v_u_21 then
			v_u_37("ObservationHaki", "Obs Haki", v52)
			v52 = v52 + 1
		end
		if v_u_22 then
			v_u_37("ConquerorHaki", "Hold Conq", v52)
			return
		end
	else
		local v55 = 1
		v_u_37("Attack", "Attack", v55)
		local v56 = v55 + 1
		v_u_37("Dash", "Dash", v56)
		local v57 = v56 + 1
		if v_u_20 then
			v_u_37("Haki", "Haki", v57)
			v57 = v57 + 1
		end
		if v_u_21 then
			v_u_37("ObservationHaki", "Obs Haki", v57)
			v57 = v57 + 1
		end
		if v_u_22 then
			v_u_37("ConquerorHaki", "Hold Conq", v57)
		end
	end
end
local function v59()
	-- upvalues: (copy) v_u_9, (copy) v_u_11
	v_u_9:FireServer("GetStatus")
	v_u_11:FireServer("GetStatus")
end
v_u_9.OnClientEvent:Connect(function(p60, p61)
	-- upvalues: (ref) v_u_20, (copy) v_u_58, (ref) v_u_17
	if p60 == "Status" then
		v_u_20 = p61.hasHaki or false
		v_u_58(v_u_17)
	elseif p60 == "Unlocked" then
		v_u_20 = true
		v_u_58(v_u_17)
	end
end)
v_u_11.OnClientEvent:Connect(function(p62, p63)
	-- upvalues: (ref) v_u_21, (copy) v_u_58, (ref) v_u_17
	if p62 == "Status" then
		v_u_21 = p63.hasObsHaki or false
		v_u_58(v_u_17)
	elseif p62 == "PurchaseSuccess" then
		v_u_21 = true
		v_u_58(v_u_17)
	end
end)
if v10 then
	v10.OnClientEvent:Connect(function(p64, p65)
		-- upvalues: (ref) v_u_22, (copy) v_u_58, (ref) v_u_17
		if p64 == "Unlocked" then
			v_u_22 = true
			v_u_58(v_u_17)
		elseif p64 == "Status" then
			if p65 and (p65.canUse or p65.reason ~= "AbilityLocked") then
				v_u_22 = true
			end
			v_u_58(v_u_17)
		end
	end)
end
if v_u_4:GetAttribute("HasConquerorHaki") == true then
	v_u_22 = true
else
	v_u_22 = false
end
v_u_4:GetAttributeChangedSignal("HasConquerorHaki"):Connect(function()
	-- upvalues: (ref) v_u_22, (copy) v_u_4, (copy) v_u_58, (ref) v_u_17
	v_u_22 = v_u_4:GetAttribute("HasConquerorHaki") == true
	v_u_58(v_u_17)
end)
local function v67()
	-- upvalues: (copy) v_u_7, (copy) v_u_15, (copy) v_u_58, (ref) v_u_17
	local v66 = v_u_7.IsGamepad or v_u_7:IsConsole()
	v_u_15.Visible = v66
	if v66 then
		v_u_58(v_u_17)
	end
end
local v_u_68 = v_u_17
local function v_u_73()
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	for _, v69 in ipairs({
		"InventoryPanelUI",
		"SettingsUI",
		"ShopUI",
		"StatsPanelUI",
		"TravelUI"
	}) do
		local v70 = v_u_5:FindFirstChild(v69)
		if v70 then
			local v71 = v70:FindFirstChild("MainFrame") or v70:FindFirstChild("Frame")
			if v71 and v71.Visible then
				return "menu"
			end
		end
	end
	local v72 = v_u_4.Character
	return v72 and v72:FindFirstChildOfClass("Tool") and "combat" or "default"
end
for _, v74 in ipairs(v_u_15:GetChildren()) do
	if v74:IsA("Frame") then
		v74:Destroy()
	end
end
local v75 = v_u_7.IsGamepad or v_u_7:IsConsole()
v_u_15.Visible = v75
if v75 then
	v_u_58(v_u_68)
end
v2.LastInputTypeChanged:Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_15, (copy) v_u_58, (ref) v_u_68
	task.wait(0.1)
	local v76 = v_u_7.IsGamepad or v_u_7:IsConsole()
	v_u_15.Visible = v76
	if v76 then
		v_u_58(v_u_68)
	end
end)
v2.GamepadConnected:Connect(v67)
v2.GamepadDisconnected:Connect(v67)
v_u_4.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_9, (copy) v_u_11
	task.wait(1)
	v_u_9:FireServer("GetStatus")
	v_u_11:FireServer("GetStatus")
end)
if v_u_4.Character then
	task.delay(1, v59)
end
task.spawn(function()
	-- upvalues: (copy) v_u_73, (copy) v_u_4, (ref) v_u_68, (copy) v_u_58, (ref) v_u_19
	while true do
		task.wait(0.5)
		local v77 = v_u_73()
		local v78 = v_u_4.Character
		local v79
		if v78 then
			local v80 = v78:FindFirstChildOfClass("Tool")
			v79 = v80 and v80.Name or nil
		else
			v79 = nil
		end
		if v77 == v_u_68 then
			if v77 == "combat" and v79 ~= v_u_19 then
				v_u_58("combat")
				v_u_19 = v79
			end
		else
			if v_u_68 ~= v77 then
				v_u_68 = v77
				v_u_58(v77)
			end
			v_u_19 = v79
		end
	end
end)