local v1 = game:GetService("Players")
local v_u_2 = game:GetService("GuiService")
local v3 = game:GetService("UserInputService")
local v4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_5 = false
v3.InputBegan:Connect(function(p6)
	-- upvalues: (ref) v_u_5
	if p6.UserInputType == Enum.UserInputType.Gamepad1 then
		v_u_5 = true
	elseif p6.UserInputType == Enum.UserInputType.Keyboard or p6.UserInputType == Enum.UserInputType.MouseButton1 then
		v_u_5 = false
	end
end)
if #v3:GetConnectedGamepads() > 0 then
	v_u_5 = true
else
	v_u_5 = false
end
task.wait(0.5)
local v_u_7 = v4:WaitForChild("TradingUI"):WaitForChild("MainFrame")
local function v_u_18()
	-- upvalues: (copy) v_u_7, (ref) v_u_5
	local v8 = v_u_7:WaitForChild("Frame")
	local v9 = v8:WaitForChild("Content")
	local v10 = v8:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
	v10.Selectable = v_u_5
	local v11 = {}
	local v12 = v9:FindFirstChild("Users")
	if v12 then
		for _, v13 in ipairs(v12:GetChildren()) do
			if v13:IsA("ImageButton") or v13:IsA("TextButton") then
				v13.Selectable = v_u_5
				table.insert(v11, v13)
			end
		end
	end
	table.sort(v11, function(p14, p15)
		return p14.AbsolutePosition.Y < p15.AbsolutePosition.Y
	end)
	v10.NextSelectionDown = v11[1]
	for v16, v17 in ipairs(v11) do
		v17.NextSelectionUp = v11[v16 - 1] or v10
		v17.NextSelectionDown = v11[v16 + 1]
	end
	return v11[1] or v10
end
local function v20()
	-- upvalues: (copy) v_u_7, (copy) v_u_18, (ref) v_u_5, (copy) v_u_2
	if v_u_7.Visible then
		task.wait(0.15)
		local v19 = v_u_18()
		if v19 and v_u_5 then
			v_u_2.SelectedObject = v19
		end
	end
end
v_u_7:GetPropertyChangedSignal("Visible"):Connect(v20)