local v1 = game:GetService("Players")
local v_u_2 = game:GetService("GuiService")
game:GetService("UserInputService")
local v3 = game:GetService("ContextActionService")
local v_u_4 = v1.LocalPlayer:WaitForChild("PlayerGui")
task.wait(1)
local v_u_5 = v_u_4:WaitForChild("BasicStatsCurrencyAndButtonsUI"):WaitForChild("MainFrame")
local v_u_6 = false
local function v_u_10()
	-- upvalues: (copy) v_u_4
	for _, v7 in ipairs({
		"SettingsUI",
		"ShopUI",
		"StatsPanelUI",
		"AllyUI",
		"TradingUI",
		"InTradingUI",
		"InventoryUI"
	}) do
		local v8 = v_u_4:FindFirstChild(v7)
		if v8 then
			local v9 = v8:FindFirstChild("MainFrame")
			if v9 and v9.Visible then
				return true
			end
		end
	end
	return false
end
local function v_u_15()
	-- upvalues: (copy) v_u_5
	local v11 = v_u_5:FindFirstChild("UIButtons")
	if v11 then
		for _, v12 in ipairs(v11:GetChildren()) do
			if v12:IsA("Frame") then
				for _, v13 in ipairs(v12:GetChildren()) do
					if v13:IsA("ImageButton") then
						v13.Selectable = true
					end
				end
			end
		end
		local v14 = v11:FindFirstChild("StatsButtonFrame")
		if v14 then
			return v14:FindFirstChild("StatsButton")
		else
			return nil
		end
	else
		return nil
	end
end
local function v17(_, p16, _)
	-- upvalues: (ref) v_u_6, (copy) v_u_10, (copy) v_u_2
	if p16 ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass
	end
	if not v_u_6 or v_u_10() then
		return Enum.ContextActionResult.Pass
	end
	v_u_6 = false
	v_u_2.SelectedObject = nil
	return Enum.ContextActionResult.Sink
end
v3:BindAction("HUD_DPadDown", function(_, p18, _)
	-- upvalues: (copy) v_u_10, (ref) v_u_6, (copy) v_u_15, (copy) v_u_2
	if p18 ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass
	end
	if v_u_10() then
		return Enum.ContextActionResult.Pass
	end
	local v19 = not v_u_6 and v_u_15()
	if not v19 then
		return Enum.ContextActionResult.Pass
	end
	v_u_6 = true
	v_u_2.SelectedObject = v19
	return Enum.ContextActionResult.Sink
end, false, Enum.KeyCode.DPadDown)
v3:BindAction("HUD_ButtonB", v17, false, Enum.KeyCode.ButtonB)
local v_u_20 = v_u_6
for _, v21 in ipairs({
	"SettingsUI",
	"ShopUI",
	"StatsPanelUI",
	"AllyUI",
	"TradingUI",
	"InTradingUI",
	"InventoryUI"
}) do
	local v22 = v_u_4:FindFirstChild(v21)
	if v22 then
		local v_u_23 = v22:FindFirstChild("MainFrame")
		if v_u_23 then
			v_u_23:GetPropertyChangedSignal("Visible"):Connect(function()
				-- upvalues: (copy) v_u_23, (ref) v_u_20
				if v_u_23.Visible then
					v_u_20 = false
				end
			end)
		end
	end
end
v_u_2:GetPropertyChangedSignal("SelectedObject"):Connect(function()
	-- upvalues: (copy) v_u_2, (ref) v_u_20
	if v_u_2.SelectedObject == nil and v_u_20 then
		v_u_20 = false
	end
end)