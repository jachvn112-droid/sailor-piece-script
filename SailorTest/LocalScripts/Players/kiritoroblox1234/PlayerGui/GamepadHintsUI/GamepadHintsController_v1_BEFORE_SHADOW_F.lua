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
local v_u_10 = v8:WaitForChild("ObservationHakiRemote")
local v_u_11 = nil
local v_u_12 = nil
pcall(function()
	-- upvalues: (ref) v_u_11, (copy) v_u_3
	v_u_11 = require(v_u_3:WaitForChild("AbilitySystem"):WaitForChild("AbilityConfig"))
end)
pcall(function()
	-- upvalues: (copy) v_u_3, (ref) v_u_12
	local v13 = v_u_3:FindFirstChild("FruitPowerSystem")
	if v13 then
		v_u_12 = require(v13:WaitForChild("FruitPowerConfig"))
	end
end)
local v_u_14 = script.Parent:WaitForChild("HintsContainer")
local v_u_15 = {
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
	}
}
local v_u_16 = "default"
local v_u_17 = {}
local v_u_18 = nil
local v_u_19 = false
local v_u_20 = false
local function v_u_22()
	-- upvalues: (ref) v_u_17
	for _, v21 in ipairs(v_u_17) do
		v21:Destroy()
	end
	v_u_17 = {}
end
local function v_u_35(p23, p24, p25)
	-- upvalues: (copy) v_u_7, (copy) v_u_14, (ref) v_u_17
	local v26 = Instance.new("Frame")
	v26.Name = "Hint_" .. p23
	v26.Size = UDim2.new(0, 150, 0, 32)
	v26.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	v26.BackgroundTransparency = 0.3
	v26.LayoutOrder = p25
	local v27 = Instance.new("UICorner")
	v27.CornerRadius = UDim.new(0, 8)
	v27.Parent = v26
	local v28 = Instance.new("UIPadding")
	v28.PaddingLeft = UDim.new(0, 8)
	v28.PaddingRight = UDim.new(0, 8)
	v28.Parent = v26
	local v29 = v_u_7:GetKeyCode(p23)
	local v30 = Instance.new("ImageLabel")
	v30.Name = "ButtonIcon"
	v30.Size = UDim2.new(0, 24, 0, 24)
	v30.Position = UDim2.new(0, 0, 0.5, 0)
	v30.AnchorPoint = Vector2.new(0, 0.5)
	v30.BackgroundTransparency = 1
	v30.ScaleType = Enum.ScaleType.Fit
	local v31 = v_u_7:GetButtonIcon(v29)
	if v31 then
		v30.Image = v31
	end
	v30.Parent = v26
	local v32 = Instance.new("TextLabel")
	v32.Name = "ButtonText"
	v32.Size = UDim2.new(0, 24, 0, 24)
	v32.Position = UDim2.new(0, 0, 0.5, 0)
	v32.AnchorPoint = Vector2.new(0, 0.5)
	v32.BackgroundTransparency = 1
	v32.TextColor3 = Color3.fromRGB(255, 255, 255)
	v32.TextSize = 12
	v32.Font = Enum.Font.GothamBold
	v32.Text = v31 and "" or v_u_7:GetButtonName(p23)
	v32.Visible = not v31
	v32.Parent = v26
	local v33 = Instance.new("TextLabel")
	v33.Name = "ActionLabel"
	v33.Size = UDim2.new(1, -32, 1, 0)
	v33.Position = UDim2.new(0, 32, 0, 0)
	v33.BackgroundTransparency = 1
	v33.TextColor3 = Color3.fromRGB(255, 255, 255)
	v33.TextSize = 14
	v33.Font = Enum.Font.GothamMedium
	v33.TextXAlignment = Enum.TextXAlignment.Left
	v33.Text = p24
	v33.Parent = v26
	v26.Parent = v_u_14
	local v34 = v_u_17
	table.insert(v34, v26)
	return v26
end
local function v_u_45()
	-- upvalues: (copy) v_u_4, (ref) v_u_12, (ref) v_u_11
	local v36 = v_u_4.Character
	if not v36 then
		return 0
	end
	local v37 = v36:FindFirstChildOfClass("Tool")
	if not v37 then
		return 0
	end
	local v38 = v37.Name
	if v_u_12 and v_u_12.Powers then
		for v39, v40 in pairs(v_u_12.Powers) do
			if (v40.ToolName == v38 or v39 == v38) and (v40.Abilities and v40.Enabled) then
				return #v40.Abilities
			end
		end
	end
	if v_u_11 and v_u_11.Movesets then
		for v41, v42 in pairs(v_u_11.Movesets) do
			if (v42.ToolName == v38 or v41 == v38) and v42.Abilities then
				local v43 = 0
				for v44, _ in pairs(v42.Abilities) do
					if type(v44) == "number" and v43 < v44 then
						v43 = v44
					end
				end
				return v43
			end
		end
	end
	return 0
end
local function v_u_56(p46)
	-- upvalues: (copy) v_u_22, (copy) v_u_35, (copy) v_u_45, (copy) v_u_15, (ref) v_u_19, (ref) v_u_20
	v_u_22()
	if p46 == "menu" then
		v_u_35("UIConfirm", "Select", 1)
		v_u_35("UIBack", "Back", 2)
	elseif p46 == "combat" then
		local v47 = v_u_45()
		local v48 = 1
		v_u_35("Attack", "Attack", v48)
		local v49 = v48 + 1
		v_u_35("Dash", "Dash", v49)
		local v50 = v49 + 1
		for v51 = 1, math.min(v47, 4) do
			local v52 = v_u_15[v51]
			if v52 then
				v_u_35(v52.action, v52.text, v50)
				v50 = v50 + 1
			end
		end
		if v_u_19 then
			v_u_35("Haki", "Haki", v50)
			v50 = v50 + 1
		end
		if v_u_20 then
			v_u_35("ObservationHaki", "Obs (x2)", v50)
			return
		end
	else
		local v53 = 1
		v_u_35("Attack", "Attack", v53)
		local v54 = v53 + 1
		v_u_35("Dash", "Dash", v54)
		local v55 = v54 + 1
		if v_u_19 then
			v_u_35("Haki", "Haki", v55)
			v55 = v55 + 1
		end
		if v_u_20 then
			v_u_35("ObservationHaki", "Obs (x2)", v55)
		end
	end
end
v_u_9.OnClientEvent:Connect(function(p57, p58)
	-- upvalues: (ref) v_u_19, (copy) v_u_56, (ref) v_u_16
	if p57 == "Status" then
		v_u_19 = p58.hasHaki or false
		v_u_56(v_u_16)
	elseif p57 == "Unlocked" then
		v_u_19 = true
		v_u_56(v_u_16)
	end
end)
v_u_10.OnClientEvent:Connect(function(p59, p60)
	-- upvalues: (ref) v_u_20, (copy) v_u_56, (ref) v_u_16
	if p59 == "Status" then
		v_u_20 = p60.hasObsHaki or false
		v_u_56(v_u_16)
	elseif p59 == "PurchaseSuccess" then
		v_u_20 = true
		v_u_56(v_u_16)
	end
end)
local function v62()
	-- upvalues: (copy) v_u_7, (copy) v_u_14, (copy) v_u_56, (ref) v_u_16
	local v61 = v_u_7.IsGamepad or v_u_7:IsConsole()
	v_u_14.Visible = v61
	if v61 then
		v_u_56(v_u_16)
	end
end
local v_u_63 = v_u_16
local function v64()
	-- upvalues: (copy) v_u_9, (copy) v_u_10
	v_u_9:FireServer("GetStatus")
	v_u_10:FireServer("GetStatus")
end
local function v_u_69()
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	for _, v65 in ipairs({
		"InventoryPanelUI",
		"SettingsUI",
		"ShopUI",
		"StatsPanelUI",
		"TravelUI"
	}) do
		local v66 = v_u_5:FindFirstChild(v65)
		if v66 then
			local v67 = v66:FindFirstChild("MainFrame") or v66:FindFirstChild("Frame")
			if v67 and v67.Visible then
				return "menu"
			end
		end
	end
	local v68 = v_u_4.Character
	return v68 and v68:FindFirstChildOfClass("Tool") and "combat" or "default"
end
for _, v70 in ipairs(v_u_14:GetChildren()) do
	if v70:IsA("Frame") then
		v70:Destroy()
	end
end
local v71 = v_u_7.IsGamepad or v_u_7:IsConsole()
v_u_14.Visible = v71
if v71 then
	v_u_56(v_u_63)
end
v2.LastInputTypeChanged:Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_14, (copy) v_u_56, (ref) v_u_63
	task.wait(0.1)
	local v72 = v_u_7.IsGamepad or v_u_7:IsConsole()
	v_u_14.Visible = v72
	if v72 then
		v_u_56(v_u_63)
	end
end)
v2.GamepadConnected:Connect(v62)
v2.GamepadDisconnected:Connect(v62)
v_u_4.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_9, (copy) v_u_10
	task.wait(1)
	v_u_9:FireServer("GetStatus")
	v_u_10:FireServer("GetStatus")
end)
if v_u_4.Character then
	task.delay(1, v64)
end
task.spawn(function()
	-- upvalues: (copy) v_u_69, (copy) v_u_4, (ref) v_u_63, (copy) v_u_56, (ref) v_u_18
	while true do
		task.wait(0.5)
		local v73 = v_u_69()
		local v74 = v_u_4.Character
		local v75
		if v74 then
			local v76 = v74:FindFirstChildOfClass("Tool")
			v75 = v76 and v76.Name or nil
		else
			v75 = nil
		end
		if v73 == v_u_63 then
			if v73 == "combat" and v75 ~= v_u_18 then
				v_u_56("combat")
				v_u_18 = v75
			end
		else
			if v_u_63 ~= v73 then
				v_u_63 = v73
				v_u_56(v73)
			end
			v_u_18 = v75
		end
	end
end)