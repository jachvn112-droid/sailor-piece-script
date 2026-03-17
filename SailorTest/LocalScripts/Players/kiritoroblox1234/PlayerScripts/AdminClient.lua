local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v3 = game:GetService("UserInputService")
local v_u_4 = require(v2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v5 = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
local v6 = v2:WaitForChild("Remotes")
local v_u_7 = v6:WaitForChild("AdminExecute")
local v_u_8 = v6:WaitForChild("AdminCheckAccess")
local v_u_9 = v6:WaitForChild("AdminGetCommands")
local v_u_10 = v6:WaitForChild("AdminGetArgSuggestions")
local v11 = v6:WaitForChild("AdminResponse")
local v_u_12 = v5:WaitForChild("AdminUI")
local v_u_13 = v_u_12:WaitForChild("MainFrame")
local v_u_14 = v_u_13:WaitForChild("Frame")
local v15 = v_u_14:WaitForChild("Content"):WaitForChild("Holder")
local v16 = v15:WaitForChild("PlayerSection")
local v17 = v15:WaitForChild("CommandSection")
local v18 = v15:WaitForChild("LogSection")
local v_u_19 = v16:WaitForChild("PlayerDropdown")
local v_u_20 = v_u_13:WaitForChild("PlayerDropdownList")
local v_u_21 = v_u_20:WaitForChild("PlayerList")
local v22 = v17:WaitForChild("InputContainer")
local v_u_23 = v22:WaitForChild("CommandInput")
local v24 = v22:WaitForChild("ExecuteButton")
local v_u_25 = v22:WaitForChild("AutocompleteFrame")
local v_u_26 = v_u_25:WaitForChild("SuggestionList")
local v_u_27 = v18:WaitForChild("LogContainer")
local v28 = v18:WaitForChild("ClearButton")
local v_u_29 = v_u_12:WaitForChild("AdminToggleButton")
local v30 = v_u_29:FindFirstChild("Button")
local v_u_31 = false
local v_u_32 = false
local v_u_33 = nil
local v_u_34 = 1
local v_u_35 = false
local v_u_36 = {}
local v_u_37 = {}
local v_u_38 = 0
local v_u_39 = {
	["Success"] = Color3.fromRGB(100, 200, 100),
	["Error"] = Color3.fromRGB(255, 100, 100),
	["Info"] = Color3.fromRGB(100, 180, 255),
	["Warning"] = Color3.fromRGB(255, 200, 80),
	["System"] = Color3.fromRGB(180, 180, 180),
	["Selected"] = Color3.fromRGB(60, 120, 200),
	["Normal"] = Color3.fromRGB(35, 35, 45)
}
local function v_u_47(p40, p41)
	-- upvalues: (copy) v_u_39, (ref) v_u_34, (copy) v_u_27
	local v42 = p41 or v_u_39.System
	local v43 = Instance.new("TextLabel")
	v43.Name = "Log_" .. v_u_34
	v43.LayoutOrder = v_u_34
	v43.Size = UDim2.new(1, -10, 0, 14)
	v43.BackgroundTransparency = 1
	v43.Text = p40
	v43.TextColor3 = v42
	v43.TextSize = 11
	v43.Font = Enum.Font.Gotham
	v43.TextXAlignment = Enum.TextXAlignment.Left
	v43.TextWrapped = true
	v43.AutomaticSize = Enum.AutomaticSize.Y
	v43.Parent = v_u_27
	v_u_34 = v_u_34 + 1
	local v44 = 0
	for _, v45 in ipairs(v_u_27:GetChildren()) do
		if v45:IsA("TextLabel") then
			v44 = v44 + 1
		end
	end
	if v44 > 50 then
		for _, v46 in ipairs(v_u_27:GetChildren()) do
			if v46:IsA("TextLabel") then
				v46:Destroy()
				break
			end
		end
	end
	task.defer(function()
		-- upvalues: (ref) v_u_27
		v_u_27.CanvasPosition = Vector2.new(0, v_u_27.AbsoluteCanvasSize.Y)
	end)
end
local function v_u_49()
	-- upvalues: (copy) v_u_26, (ref) v_u_37, (ref) v_u_38, (copy) v_u_25
	for _, v48 in ipairs(v_u_26:GetChildren()) do
		if v48:IsA("TextButton") then
			v48:Destroy()
		end
	end
	v_u_37 = {}
	v_u_38 = 0
	v_u_25.Visible = false
	v_u_25.Size = UDim2.new(1, 0, 0, 0)
end
local function v_u_52()
	-- upvalues: (ref) v_u_37, (ref) v_u_38, (copy) v_u_39
	for v50, v51 in ipairs(v_u_37) do
		if v50 == v_u_38 then
			v51.BackgroundColor3 = v_u_39.Selected
			v51.BackgroundTransparency = 0.3
		else
			v51.BackgroundColor3 = v_u_39.Normal
			v51.BackgroundTransparency = 0.5
		end
	end
end
local function v_u_59(p_u_53, p_u_54)
	-- upvalues: (copy) v_u_39, (copy) v_u_23, (copy) v_u_49, (ref) v_u_38, (copy) v_u_52
	local v55 = Instance.new("TextButton")
	v55.Name = "Suggestion_" .. p_u_54
	v55.LayoutOrder = p_u_54
	v55.Size = UDim2.new(1, -6, 0, 24)
	v55.BackgroundColor3 = v_u_39.Normal
	v55.BackgroundTransparency = 0.5
	v55.BorderSizePixel = 0
	v55.Text = ""
	v55.AutoButtonColor = false
	v55.ZIndex = 22
	if p_u_53.fullCmd then
		v55:SetAttribute("FullCmd", p_u_53.fullCmd)
	end
	local v56 = Instance.new("UICorner")
	v56.CornerRadius = UDim.new(0.15, 0)
	v56.Parent = v55
	local v57 = Instance.new("TextLabel")
	v57.Name = "Name"
	v57.Size = UDim2.new(0.35, 0, 1, 0)
	v57.Position = UDim2.new(0, 8, 0, 0)
	v57.BackgroundTransparency = 1
	v57.Text = p_u_53.text or p_u_53.name
	v57.TextColor3 = v_u_39.Info
	v57.TextSize = 12
	v57.Font = Enum.Font.GothamBold
	v57.TextXAlignment = Enum.TextXAlignment.Left
	v57.ZIndex = 23
	v57.Parent = v55
	local v58 = Instance.new("TextLabel")
	v58.Name = "Desc"
	v58.Size = UDim2.new(0.6, 0, 1, 0)
	v58.Position = UDim2.new(0.38, 0, 0, 0)
	v58.BackgroundTransparency = 1
	v58.Text = p_u_53.desc
	v58.TextColor3 = Color3.fromRGB(150, 150, 150)
	v58.TextSize = 11
	v58.Font = Enum.Font.Gotham
	v58.TextXAlignment = Enum.TextXAlignment.Left
	v58.TextTruncate = Enum.TextTruncate.AtEnd
	v58.ZIndex = 23
	v58.Parent = v55
	v55.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_53, (ref) v_u_23, (ref) v_u_49
		if p_u_53.isCommand then
			v_u_23.Text = p_u_53.text .. " "
		else
			v_u_23.Text = (p_u_53.fullCmd or p_u_53.text) .. " "
		end
		v_u_23:CaptureFocus()
		v_u_23.CursorPosition = #v_u_23.Text + 1
		v_u_49()
	end)
	v55.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_38, (copy) p_u_54, (ref) v_u_52
		v_u_38 = p_u_54
		v_u_52()
	end)
	return v55
end
local function v_u_84(p60)
	-- upvalues: (copy) v_u_49, (ref) v_u_36, (copy) v_u_59, (copy) v_u_26, (ref) v_u_37, (copy) v_u_25, (copy) v_u_10
	v_u_49()
	if p60 == "" then
		return
	else
		local v_u_61 = p60:split(" ")
		local v_u_62 = v_u_61[1]:lower()
		local v_u_63 = #v_u_61 - 1
		local v_u_64 = v_u_61[#v_u_61] or ""
		if #v_u_61 == 1 then
			local v65 = {}
			for _, v66 in ipairs(v_u_36) do
				if v66.name:sub(1, #v_u_62) == v_u_62 then
					local v67 = {
						["text"] = v66.name,
						["desc"] = v66.desc,
						["isCommand"] = true
					}
					table.insert(v65, v67)
				end
			end
			table.sort(v65, function(p68, p69)
				return p68.text < p69.text
			end)
			local v70 = #v65
			local v71 = math.min(v70, 20)
			for v72 = 1, v71 do
				local v73 = v_u_59(v65[v72], v72)
				v73.Parent = v_u_26
				local v74 = v_u_37
				table.insert(v74, v73)
			end
			if v71 > 0 then
				local v75 = math.min(v71, 5) * 25 + 6
				v_u_25.Size = UDim2.new(1, 0, 0, v75)
				v_u_25.Visible = true
			end
		elseif v_u_63 >= 1 then
			task.spawn(function()
				-- upvalues: (ref) v_u_10, (copy) v_u_62, (copy) v_u_63, (copy) v_u_64, (ref) v_u_49, (ref) v_u_59, (copy) v_u_61, (ref) v_u_26, (ref) v_u_37, (ref) v_u_25
				local v76 = v_u_10:InvokeServer(v_u_62, v_u_63, v_u_64)
				if v76 and (v76.suggestions and #v76.suggestions ~= 0) then
					v_u_49()
					local v77 = v76.typeName or ""
					local v78 = #v76.suggestions
					local v79 = math.min(v78, 20)
					for v80 = 1, v79 do
						local v81 = v_u_59({
							["text"] = v76.suggestions[v80],
							["desc"] = v77,
							["isCommand"] = false,
							["fullCmd"] = table.concat(v_u_61, " ", 1, #v_u_61 - 1) .. " " .. v76.suggestions[v80]
						}, v80)
						v81.Parent = v_u_26
						local v82 = v_u_37
						table.insert(v82, v81)
					end
					if v79 > 0 then
						local v83 = math.min(v79, 5) * 25 + 6
						v_u_25.Size = UDim2.new(1, 0, 0, v83)
						v_u_25.Visible = true
					end
				end
			end)
		end
	end
end
local function v_u_88()
	-- upvalues: (ref) v_u_38, (ref) v_u_37, (copy) v_u_23, (copy) v_u_49
	if v_u_38 > 0 and v_u_38 <= #v_u_37 then
		local v85 = v_u_37[v_u_38]
		local v86 = v85:GetAttribute("FullCmd")
		local v87 = v85:FindFirstChild("Name")
		if v86 then
			v_u_23.Text = v86 .. " "
		elseif v87 then
			v_u_23.Text = v87.Text .. " "
		end
		v_u_23.CursorPosition = #v_u_23.Text + 1
		v_u_49()
	end
end
local function v_u_96()
	-- upvalues: (copy) v_u_21, (copy) v_u_1, (ref) v_u_33, (copy) v_u_19, (ref) v_u_32, (copy) v_u_20, (copy) v_u_47, (copy) v_u_39
	for _, v89 in ipairs(v_u_21:GetChildren()) do
		if v89:IsA("TextButton") then
			v89:Destroy()
		end
	end
	local v90 = v_u_1:GetPlayers()
	for _, v_u_91 in ipairs(v90) do
		local v92 = Instance.new("TextButton")
		v92.Name = v_u_91.Name
		v92.Size = UDim2.new(1, -8, 0, 22)
		v92.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
		v92.BackgroundTransparency = 0.3
		v92.BorderSizePixel = 0
		v92.Text = v_u_91.Name
		v92.TextColor3 = Color3.fromRGB(220, 220, 220)
		v92.TextSize = 12
		v92.Font = Enum.Font.Gotham
		v92.ZIndex = 502
		local v93 = Instance.new("UICorner")
		v93.CornerRadius = UDim.new(0.15, 0)
		v93.Parent = v92
		v92.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_33, (copy) v_u_91, (ref) v_u_19, (ref) v_u_32, (ref) v_u_20, (ref) v_u_47, (ref) v_u_39
			v_u_33 = v_u_91
			v_u_19.Text = v_u_91.Name
			v_u_19.TextColor3 = Color3.fromRGB(255, 255, 255)
			v_u_32 = false
			v_u_20.Visible = false
			v_u_19.Arrow.Text = "\226\150\188"
			v_u_47("[Select] " .. v_u_91.Name, v_u_39.Info)
		end)
		v92.Parent = v_u_21
	end
	local v94 = #v90 * 26 + 8
	local v95 = math.min(v94, 130)
	v_u_20.Size = UDim2.new(1, 0, 0, v95)
end
local function v100()
	-- upvalues: (ref) v_u_32, (copy) v_u_96, (copy) v_u_19, (copy) v_u_13, (copy) v_u_20
	v_u_32 = not v_u_32
	if v_u_32 then
		v_u_96()
		local v97 = v_u_19.AbsolutePosition
		local v98 = v_u_19.AbsoluteSize
		local v99 = v_u_13.AbsolutePosition
		v_u_20.Position = UDim2.new(0, v97.X - v99.X, 0, v97.Y - v99.Y + v98.Y + 4)
		v_u_20.Size = UDim2.new(0, v98.X, 0, 130)
		v_u_20.Visible = true
		v_u_19.Arrow.Text = "\226\150\178"
	else
		v_u_20.Visible = false
		v_u_19.Arrow.Text = "\226\150\188"
	end
end
local function v_u_103(p101)
	-- upvalues: (copy) v_u_47, (copy) v_u_39, (copy) v_u_49, (copy) v_u_7, (ref) v_u_33
	if p101 and p101 ~= "" then
		v_u_47("> " .. p101, v_u_39.System)
		v_u_49()
		local v102 = v_u_7:InvokeServer(p101, v_u_33 and v_u_33.Name or nil)
		if v102 then
			if v102.success then
				v_u_47(v102.message, v_u_39.Success)
			else
				v_u_47(v102.message, v_u_39.Error)
			end
		else
			v_u_47("[Error] No response from server", v_u_39.Error)
			return
		end
	else
		return
	end
end
local function v_u_104()
	-- upvalues: (ref) v_u_31
	v_u_31 = true
end
local function v_u_105()
	-- upvalues: (ref) v_u_31, (ref) v_u_32, (copy) v_u_20, (copy) v_u_19, (copy) v_u_49
	v_u_31 = false
	if v_u_32 then
		v_u_32 = false
		v_u_20.Visible = false
		v_u_19.Arrow.Text = "\226\150\188"
	end
	v_u_49()
end
local function v_u_106()
	-- upvalues: (copy) v_u_4
	v_u_4:Close("Admin")
end
local function v107()
	-- upvalues: (copy) v_u_4
	v_u_4:Toggle("Admin")
end
local function v111()
	-- upvalues: (copy) v_u_14, (copy) v_u_106
	local v108 = v_u_14:FindFirstChild("CloseButtonFrame")
	if v108 then
		local v109 = v108:FindFirstChild("CloseButton")
		if v109 then
			for _, v110 in ipairs(v109:GetChildren()) do
				if v110:IsA("LocalScript") then
					v110:Destroy()
				end
			end
			v109.MouseButton1Click:Connect(v_u_106)
		end
	end
end
v_u_23:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (copy) v_u_23, (copy) v_u_84
	local v112 = v_u_23.Text
	if v112:find("\t") then
		local v113 = v_u_23.CursorPosition
		v_u_23.Text = v112:gsub("\t", "")
		local v114 = v_u_23
		local v115 = v113 - 1
		v114.CursorPosition = math.max(1, v115)
	else
		v_u_84(v112)
	end
end)
v_u_23.FocusLost:Connect(function(p116)
	-- upvalues: (copy) v_u_103, (copy) v_u_23, (copy) v_u_49
	if p116 then
		v_u_103(v_u_23.Text)
		v_u_23.Text = ""
	end
	task.delay(0.1, function()
		-- upvalues: (ref) v_u_23, (ref) v_u_49
		if not v_u_23:IsFocused() then
			v_u_49()
		end
	end)
end)
v3.InputBegan:Connect(function(p117, _)
	-- upvalues: (copy) v_u_23, (ref) v_u_37, (ref) v_u_38, (copy) v_u_88, (copy) v_u_52, (copy) v_u_49
	if v_u_23:IsFocused() and p117.KeyCode == Enum.KeyCode.Tab then
		if #v_u_37 > 0 then
			if v_u_38 == 0 then
				v_u_38 = 1
			end
			v_u_88()
		end
	elseif v_u_23:IsFocused() and #v_u_37 > 0 then
		if p117.KeyCode == Enum.KeyCode.Down then
			local v118 = v_u_38 + 1
			local v119 = #v_u_37
			v_u_38 = math.min(v118, v119)
			v_u_52()
			return
		end
		if p117.KeyCode == Enum.KeyCode.Up then
			local v120 = v_u_38 - 1
			v_u_38 = math.max(v120, 1)
			v_u_52()
			return
		end
		if p117.KeyCode == Enum.KeyCode.Escape then
			v_u_49()
		end
	end
end)
v_u_19.MouseButton1Click:Connect(v100)
v24.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_103, (copy) v_u_23
	v_u_103(v_u_23.Text)
	v_u_23.Text = ""
end)
v28.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_27, (ref) v_u_34, (copy) v_u_47, (copy) v_u_39
	for _, v121 in ipairs(v_u_27:GetChildren()) do
		if v121:IsA("TextLabel") then
			v121:Destroy()
		end
	end
	v_u_34 = 1
	v_u_47("[System] Log cleared", v_u_39.Info)
end)
v_u_1.PlayerRemoving:Connect(function(p122)
	-- upvalues: (ref) v_u_33, (copy) v_u_19
	if v_u_33 == p122 then
		v_u_33 = nil
		v_u_19.Text = "Click to select player..."
		v_u_19.TextColor3 = Color3.fromRGB(180, 180, 180)
	end
end)
v11.OnClientEvent:Connect(function(p123, p124)
	-- upvalues: (copy) v_u_47, (copy) v_u_39
	v_u_47(p123, v_u_39[p124] or v_u_39.System)
end)
if v30 then
	v30.MouseButton1Click:Connect(v107)
end
v_u_13.Visible = false
v111()
task.spawn(function()
	-- upvalues: (copy) v_u_8, (ref) v_u_35, (copy) v_u_4, (copy) v_u_13, (copy) v_u_104, (copy) v_u_105, (copy) v_u_29, (ref) v_u_36, (copy) v_u_9, (copy) v_u_47, (copy) v_u_39, (copy) v_u_12
	local v125 = v_u_8:InvokeServer()
	v_u_35 = v125 ~= nil
	if v_u_35 then
		v_u_4:Register("Admin", v_u_13, {
			["onOpen"] = v_u_104,
			["onClose"] = v_u_105
		})
		if v_u_29 then
			v_u_29.Visible = true
		end
		v_u_36 = v_u_9:InvokeServer() or {}
		v_u_47("[System] Panel ready (" .. (v125 == "tester" and "TESTER" or (v125 == "banner" and "BANNER" or "ADMIN")) .. "). Click button to open.", v_u_39.Info)
		v_u_47("[System] Type command or use Tab/\226\134\145\226\134\147 for autocomplete.", v_u_39.System)
		if v125 == "tester" then
			v_u_47("[System] Tester mode: self-only commands.", v_u_39.Warning)
			return
		end
		if v125 == "banner" then
			v_u_47("[System] Banner mode: ban/unban/baninfo only.", v_u_39.Warning)
			return
		end
	else
		v_u_12.Enabled = false
		if v_u_29 then
			v_u_29.Visible = false
		end
	end
end)