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
local v_u_7 = v4:WaitForChild("SettingsUI"):WaitForChild("MainFrame")
local v_u_8 = nil
local function v_u_26()
	-- upvalues: (copy) v_u_7, (ref) v_u_8, (ref) v_u_5
	local v9 = v_u_7:WaitForChild("Frame")
	local v10 = v9:WaitForChild("Content"):WaitForChild("Settings")
	if v10:IsA("ScrollingFrame") then
		v_u_8 = v10
		v_u_8.Selectable = false
	end
	local v11 = v9:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
	local v12 = {}
	for _, v13 in ipairs(v10:GetChildren()) do
		if v13.Name:find("Toggle_") and v13:IsA("Frame") then
			local v14 = v13:FindFirstChild("SettingsHolder")
			if v14 and v14:IsA("ImageButton") then
				local v15 = {
					["frame"] = v13,
					["button"] = v14,
					["order"] = v13.LayoutOrder or 0
				}
				table.insert(v12, v15)
			end
		end
	end
	table.sort(v12, function(p16, p17)
		return p16.order < p17.order
	end)
	v11.Selectable = v_u_5
	for _, v18 in ipairs(v12) do
		v18.button.Selectable = v_u_5
	end
	local v19 = v12[1]
	if v19 then
		v19 = v12[1].button
	end
	v11.NextSelectionDown = v19
	for v20, v21 in ipairs(v12) do
		local v22 = v21.button
		local v23
		if v12[v20 - 1] then
			v23 = v12[v20 - 1].button or v11
		else
			v23 = v11
		end
		v22.NextSelectionUp = v23
		local v24 = v21.button
		local v25 = v12[v20 + 1]
		if v25 then
			v25 = v12[v20 + 1].button
		end
		v24.NextSelectionDown = v25
	end
	if v12[1] then
		v11 = v12[1].button or v11
	end
	return v11
end
local function v_u_38(p27)
	-- upvalues: (ref) v_u_8
	if v_u_8 and p27 then
		local v28 = p27.Parent
		if v28 and v28:IsDescendantOf(v_u_8) then
			task.wait()
			local v29 = v_u_8.AbsolutePosition.Y
			local v30 = v_u_8.AbsoluteSize.Y
			local v31 = v_u_8.CanvasPosition.Y
			local v32 = v28.AbsolutePosition.Y
			local v33 = v28.AbsoluteSize.Y
			local v34 = v32 - v29 + v31
			if v34 < v31 then
				local v35 = v_u_8
				local v36 = Vector2.new
				local v37 = v34 - 10
				v35.CanvasPosition = v36(0, (math.max(0, v37)))
			elseif v34 + v33 > v31 + v30 then
				v_u_8.CanvasPosition = Vector2.new(0, v34 + v33 - v30 + 10)
			end
		else
			return
		end
	else
		return
	end
end
local function v40()
	-- upvalues: (copy) v_u_7, (copy) v_u_26, (ref) v_u_5, (copy) v_u_2
	if v_u_7.Visible then
		task.wait(0.15)
		local v39 = v_u_26()
		if v39 and v_u_5 then
			v_u_2.SelectedObject = v39
		end
	end
end
v_u_7:GetPropertyChangedSignal("Visible"):Connect(v40)
v_u_2:GetPropertyChangedSignal("SelectedObject"):Connect(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (ref) v_u_5, (ref) v_u_8, (copy) v_u_38
	local v_u_41 = v_u_2.SelectedObject
	if v_u_41 and (v_u_7.Visible and (v_u_5 and (v_u_8 and v_u_41:IsDescendantOf(v_u_8)))) then
		task.defer(function()
			-- upvalues: (ref) v_u_38, (copy) v_u_41
			v_u_38(v_u_41)
		end)
	end
end)