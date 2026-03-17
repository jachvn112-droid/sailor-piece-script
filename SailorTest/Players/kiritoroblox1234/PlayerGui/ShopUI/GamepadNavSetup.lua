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
local v_u_7 = v4:WaitForChild("ShopUI"):WaitForChild("MainFrame")
local v_u_8 = nil
local function v_u_44()
	-- upvalues: (copy) v_u_7, (ref) v_u_8, (ref) v_u_5
	local v9 = v_u_7:WaitForChild("Frame")
	local v10 = v9:WaitForChild("Content"):WaitForChild("ShopHolder")
	if v10:IsA("ScrollingFrame") then
		v_u_8 = v10
	end
	local v11 = v9:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
	v11.Selectable = v_u_5
	local v12 = {}
	for _, v13 in ipairs({
		"JinwooSwordAndJinwooOutfitBundleFrame",
		"MostGamepassesBundleFrame",
		"StarterPackBundleFrame",
		"GojoAndSukunaMeleesBundleFrame"
	}) do
		local v14 = v10:FindFirstChild(v13)
		if v14 then
			local v15 = v14:FindFirstChild("Holder")
			if v15 and v15:IsA("ImageButton") then
				v15.Selectable = v_u_5
				local v16 = {
					["holder"] = v15,
					["order"] = v14.LayoutOrder or 0
				}
				table.insert(v12, v16)
			end
		end
	end
	table.sort(v12, function(p17, p18)
		return p17.order < p18.order
	end)
	local v19 = {}
	for _, v20 in ipairs(v10:GetChildren()) do
		if v20:IsA("Frame") and not (v20.Name:find("Bundle") or (v20.Name:find("Label") or v20.Name:find("Padding"))) then
			local v21 = false
			for _, v22 in ipairs(v20:GetChildren()) do
				if v22:IsA("Frame") and (v22:FindFirstChild("Holder") or v22:FindFirstChild("Pass")) then
					v21 = true
					break
				end
			end
			if v21 then
				table.insert(v19, v20)
			end
		end
	end
	table.sort(v19, function(p23, p24)
		return (p23.LayoutOrder or 0) < (p24.LayoutOrder or 0)
	end)
	local v25 = {}
	for _, v26 in ipairs(v12) do
		local v27 = { v26.holder }
		table.insert(v25, v27)
	end
	for _, v28 in ipairs(v19) do
		local v29 = {}
		local v30 = {}
		for _, v31 in ipairs(v28:GetChildren()) do
			if v31:IsA("Frame") then
				table.insert(v29, v31)
			end
		end
		table.sort(v29, function(p32, p33)
			return (p32.LayoutOrder or 0) < (p33.LayoutOrder or 0)
		end)
		for _, v34 in ipairs(v29) do
			local v35 = v34:FindFirstChild("Holder")
			if v35 and v35:IsA("ImageButton") then
				v35.Selectable = v_u_5
				table.insert(v30, v35)
			end
		end
		if #v30 > 0 then
			table.insert(v25, v30)
		end
	end
	for v36, v37 in ipairs(v25) do
		for v38, v39 in ipairs(v37) do
			if v38 > 1 then
				v39.NextSelectionLeft = v37[v38 - 1]
			end
			if v38 < #v37 then
				v39.NextSelectionRight = v37[v38 + 1]
			end
			if v36 > 1 then
				local v40 = v25[v36 - 1]
				local v41 = #v40
				v39.NextSelectionUp = v40[math.min(v38, v41)]
			else
				v39.NextSelectionUp = v11
			end
			if v36 < #v25 then
				local v42 = v25[v36 + 1]
				local v43 = #v42
				v39.NextSelectionDown = v42[math.min(v38, v43)]
			end
		end
	end
	if #v25 > 0 and #v25[1] > 0 then
		v11.NextSelectionDown = v25[1][1]
	end
	if v25[1] then
		v11 = v25[1][1] or v11
	end
	return v11
end
local function v_u_54(p45)
	-- upvalues: (ref) v_u_8
	if v_u_8 and p45 then
		if p45:IsDescendantOf(v_u_8) then
			local v46 = p45
			while p45.Parent and p45.Parent ~= v_u_8 do
				p45 = p45.Parent
			end
			if p45 and p45 ~= v46 then
				local v47 = v_u_8.AbsoluteSize.Y
				local v48 = p45.AbsolutePosition.Y - v_u_8.AbsolutePosition.Y + v_u_8.CanvasPosition.Y
				local v49 = p45.AbsoluteSize.Y
				local v50 = v_u_8.CanvasPosition.Y
				if v48 < v50 then
					local v51 = v_u_8
					local v52 = Vector2.new
					local v53 = v48 - 20
					v51.CanvasPosition = v52(0, (math.max(0, v53)))
				elseif v48 + v49 > v50 + v47 then
					v_u_8.CanvasPosition = Vector2.new(0, v48 + v49 - v47 + 20)
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v56()
	-- upvalues: (copy) v_u_7, (copy) v_u_44, (ref) v_u_5, (copy) v_u_2
	if v_u_7.Visible then
		task.wait(0.2)
		local v55 = v_u_44()
		if v55 and v_u_5 then
			v_u_2.SelectedObject = v55
		end
	end
end
v_u_7:GetPropertyChangedSignal("Visible"):Connect(v56)
v_u_2:GetPropertyChangedSignal("SelectedObject"):Connect(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (ref) v_u_5, (copy) v_u_54
	local v_u_57 = v_u_2.SelectedObject
	if v_u_57 and (v_u_7.Visible and v_u_5) then
		task.defer(function()
			-- upvalues: (ref) v_u_54, (copy) v_u_57
			v_u_54(v_u_57)
		end)
	end
end)