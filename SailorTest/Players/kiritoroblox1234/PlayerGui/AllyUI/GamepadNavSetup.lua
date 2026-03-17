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
local v_u_7 = v4:WaitForChild("AllyUI"):WaitForChild("MainFrame")
local function v_u_19()
	-- upvalues: (copy) v_u_7, (ref) v_u_5
	local v8 = v_u_7:WaitForChild("Frame")
	local v9 = v8:WaitForChild("Content")
	local v10 = v8:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
	v10.Selectable = v_u_5
	local v11 = { v10 }
	local v12 = v9:FindFirstChild("CreateAllyScreen")
	local v13 = v12 and v12.Visible and v12:FindFirstChild("Create")
	if v13 then
		v13.Selectable = v_u_5
		table.insert(v11, v13)
	end
	local v14 = v9:FindFirstChild("LeaveAlly")
	if v14 and v14.Visible then
		v14.Selectable = v_u_5
		table.insert(v11, v14)
	end
	local v15 = v9:FindFirstChild("Players")
	if v15 then
		for _, v16 in ipairs(v15:GetChildren()) do
			if v16:IsA("ImageButton") or v16:IsA("TextButton") then
				v16.Selectable = v_u_5
				table.insert(v11, v16)
			end
		end
	end
	for v17, v18 in ipairs(v11) do
		v18.NextSelectionUp = v11[v17 - 1]
		v18.NextSelectionDown = v11[v17 + 1]
	end
	return v11[2] or v11[1]
end
local function v21()
	-- upvalues: (copy) v_u_7, (copy) v_u_19, (ref) v_u_5, (copy) v_u_2
	if v_u_7.Visible then
		task.wait(0.15)
		local v20 = v_u_19()
		if v20 and v_u_5 then
			v_u_2.SelectedObject = v20
		end
	end
end
v_u_7:GetPropertyChangedSignal("Visible"):Connect(v21)