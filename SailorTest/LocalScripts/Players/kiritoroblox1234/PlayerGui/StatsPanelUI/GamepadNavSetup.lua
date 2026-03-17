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
local v_u_7 = v4:WaitForChild("StatsPanelUI"):WaitForChild("MainFrame")
local function v_u_11(p8, p9)
	for _, v10 in ipairs(string.split(p9, ".")) do
		if p8 then
			p8 = p8:FindFirstChild(v10)
		end
	end
	return p8
end
local v_u_12 = {}
local v_u_13 = nil
local function v_u_34()
	-- upvalues: (copy) v_u_7, (copy) v_u_11, (ref) v_u_13, (ref) v_u_12
	local v14 = v_u_7:FindFirstChild("Frame")
	if not v14 then
		return nil
	end
	local v15 = v14:FindFirstChild("Content")
	if not v15 then
		return nil
	end
	local v16 = v14:FindFirstChild("CloseButtonFrame")
	if v16 then
		v16 = v16:FindFirstChild("CloseButton")
	end
	local v17 = v_u_11(v15, "StatsFrame.Holder.MeleeStatFrame.Content.UpgradeFrame.AddPoints")
	local v18 = v_u_11(v15, "StatsFrame.Holder.DefenseStatFrame.Content.UpgradeFrame.AddPoints")
	local v19 = v_u_11(v15, "StatsFrame.Holder.SwordStatFrame.Content.UpgradeFrame.AddPoints")
	local v20 = v_u_11(v15, "StatsFrame.Holder.PowerStatFrame.Content.UpgradeFrame.AddPoints")
	v_u_13 = v_u_11(v15, "InfoFrame.GroupRestats.Input.AmountBox")
	local v21 = v_u_11(v15, "InfoFrame.GroupRestats.Holder.ResetStatsButton")
	local v22 = v_u_11(v15, "SideFrame.Holder.Info")
	v_u_12 = {}
	if v16 then
		local v23 = v_u_12
		table.insert(v23, v16)
	end
	if v17 then
		local v24 = v_u_12
		table.insert(v24, v17)
	end
	if v18 then
		local v25 = v_u_12
		table.insert(v25, v18)
	end
	if v19 then
		local v26 = v_u_12
		table.insert(v26, v19)
	end
	if v20 then
		local v27 = v_u_12
		table.insert(v27, v20)
	end
	if v_u_13 then
		local v28 = v_u_12
		local v29 = v_u_13
		table.insert(v28, v29)
	end
	if v21 then
		local v30 = v_u_12
		table.insert(v30, v21)
	end
	if v22 then
		local v31 = v_u_12
		table.insert(v31, v22)
	end
	for v32, v33 in ipairs(v_u_12) do
		v33.Selectable = true
		v33.NextSelectionUp = v_u_12[v32 - 1]
		v33.NextSelectionDown = v_u_12[v32 + 1]
	end
	if v21 and v22 then
		v21.NextSelectionRight = v22
		v22.NextSelectionLeft = v21
	end
	return v17 or v16
end
v3.InputBegan:Connect(function(p35, _)
	-- upvalues: (ref) v_u_5, (copy) v_u_2, (ref) v_u_13
	if v_u_5 then
		if p35.KeyCode == Enum.KeyCode.ButtonA then
			local v36 = v_u_2.SelectedObject
			if v36 and (v36:IsA("TextBox") and v36 == v_u_13) then
				v36:CaptureFocus()
			end
		end
	else
		return
	end
end)
local function v38()
	-- upvalues: (copy) v_u_7, (ref) v_u_5, (copy) v_u_34, (copy) v_u_2
	if v_u_7.Visible and v_u_5 then
		task.wait(0.2)
		local v37 = v_u_34()
		if v37 then
			v_u_2.SelectedObject = v37
		end
	end
end
v_u_7:GetPropertyChangedSignal("Visible"):Connect(v38)
task.spawn(function()
	-- upvalues: (copy) v_u_7, (ref) v_u_5, (copy) v_u_34, (copy) v_u_2
	task.wait(1)
	if v_u_7.Visible and (v_u_5 and (v_u_7.Visible and v_u_5)) then
		task.wait(0.2)
		local v39 = v_u_34()
		if v39 then
			v_u_2.SelectedObject = v39
		end
	end
end)