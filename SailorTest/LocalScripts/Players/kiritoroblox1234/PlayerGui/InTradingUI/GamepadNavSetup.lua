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
local v_u_7 = v4:WaitForChild("InTradingUI"):WaitForChild("MainFrame")
local function v_u_20()
	-- upvalues: (copy) v_u_7, (ref) v_u_5
	local v8 = v_u_7:WaitForChild("Frame")
	local v9 = v8:WaitForChild("Content")
	local v10 = v8:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
	v10.Selectable = v_u_5
	local v11 = { v10 }
	local v12 = v9:FindFirstChild("Player1Side")
	if v12 then
		local v13 = v12:FindFirstChild("AddToTrade")
		if v13 then
			v13.Selectable = v_u_5
			table.insert(v11, v13)
		end
		for _, v14 in ipairs(v12:GetDescendants()) do
			if v14.Name == "Slot" and (v14:IsA("ImageButton") or v14:IsA("TextButton")) then
				v14.Selectable = v_u_5
				table.insert(v11, v14)
			end
		end
	end
	local v15 = v9:FindFirstChild("Player2Side")
	if v15 then
		local v16 = v15:FindFirstChild("Ready")
		local v17 = v15:FindFirstChild("Decline")
		if v16 then
			v16.Selectable = v_u_5
			table.insert(v11, v16)
		end
		if v17 then
			v17.Selectable = v_u_5
			table.insert(v11, v17)
		end
		if v16 and v17 then
			v16.NextSelectionRight = v17
			v17.NextSelectionLeft = v16
		end
	end
	for v18, v19 in ipairs(v11) do
		if not v19.NextSelectionUp then
			v19.NextSelectionUp = v11[v18 - 1]
		end
		if not v19.NextSelectionDown then
			v19.NextSelectionDown = v11[v18 + 1]
		end
	end
	return v11[2] or v11[1]
end
local function v22()
	-- upvalues: (copy) v_u_7, (copy) v_u_20, (ref) v_u_5, (copy) v_u_2
	if v_u_7.Visible then
		task.wait(0.15)
		local v21 = v_u_20()
		if v21 and v_u_5 then
			v_u_2.SelectedObject = v21
		end
	end
end
v_u_7:GetPropertyChangedSignal("Visible"):Connect(v22)