local v1 = game:GetService("Players")
local v_u_2 = game:GetService("GuiService")
game:GetService("UserInputService")
local v3 = game:GetService("ContextActionService")
local v_u_4 = v1.LocalPlayer:WaitForChild("PlayerGui")
task.wait(1)
local _ = v_u_4:WaitForChild("BasicStatsCurrencyAndButtonsUI"):WaitForChild("MainFrame")
local v_u_5 = false
local function v_u_9()
	-- upvalues: (copy) v_u_4
	for _, v6 in ipairs({
		"SettingsUI",
		"ShopUI",
		"StatsPanelUI",
		"AllyUI",
		"TradingUI",
		"InTradingUI",
		"InventoryUI"
	}) do
		local v7 = v_u_4:FindFirstChild(v6)
		if v7 then
			local v8 = v7:FindFirstChild("MainFrame")
			if v8 and v8.Visible then
				return true
			end
		end
	end
	return false
end
v3:BindAction("HUD_ButtonB", function(_, p10, _)
	-- upvalues: (ref) v_u_5, (copy) v_u_9, (copy) v_u_2
	if p10 ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass
	end
	if not v_u_5 or v_u_9() then
		return Enum.ContextActionResult.Pass
	end
	v_u_5 = false
	v_u_2.SelectedObject = nil
	return Enum.ContextActionResult.Sink
end, false, Enum.KeyCode.ButtonB)
local v_u_11 = v_u_5
for _, v12 in ipairs({
	"SettingsUI",
	"ShopUI",
	"StatsPanelUI",
	"AllyUI",
	"TradingUI",
	"InTradingUI",
	"InventoryUI"
}) do
	local v13 = v_u_4:FindFirstChild(v12)
	if v13 then
		local v_u_14 = v13:FindFirstChild("MainFrame")
		if v_u_14 then
			v_u_14:GetPropertyChangedSignal("Visible"):Connect(function()
				-- upvalues: (copy) v_u_14, (ref) v_u_11
				if v_u_14.Visible then
					v_u_11 = false
				end
			end)
		end
	end
end
v_u_2:GetPropertyChangedSignal("SelectedObject"):Connect(function()
	-- upvalues: (copy) v_u_2, (ref) v_u_11
	if v_u_2.SelectedObject == nil and v_u_11 then
		v_u_11 = false
	end
end)