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
local v17 = v15:WaitForChild("ActionsSection")
local v18 = v15:WaitForChild("CommandSection")
local v19 = v15:WaitForChild("LogSection")
local v_u_20 = v16:WaitForChild("PlayerDropdown")
local v_u_21 = v_u_13:WaitForChild("PlayerDropdownList")
local v_u_22 = v_u_21:WaitForChild("PlayerList")
local v_u_23 = v17:WaitForChild("ActionsHolder")
local v24 = v18:WaitForChild("InputContainer")
local v_u_25 = v24:WaitForChild("CommandInput")
local v26 = v24:WaitForChild("ExecuteButton")
local v_u_27 = v24:WaitForChild("AutocompleteFrame")
local v_u_28 = v_u_27:WaitForChild("SuggestionList")
local v_u_29 = v19:WaitForChild("LogContainer")
local v30 = v19:WaitForChild("ClearButton")
local v_u_31 = v_u_12:WaitForChild("AdminToggleButton")
local v32 = v_u_31:FindFirstChild("Button")
local v_u_33 = false
local v_u_34 = false
local v_u_35 = nil
local v_u_36 = 1
local v_u_37 = false
local v_u_38 = {}
local v_u_39 = {}
local v_u_40 = 0
local v_u_41 = {
	["Success"] = Color3.fromRGB(100, 200, 100),
	["Error"] = Color3.fromRGB(255, 100, 100),
	["Info"] = Color3.fromRGB(100, 180, 255),
	["Warning"] = Color3.fromRGB(255, 200, 80),
	["System"] = Color3.fromRGB(180, 180, 180),
	["Selected"] = Color3.fromRGB(60, 120, 200),
	["Normal"] = Color3.fromRGB(35, 35, 45)
}
local function v_u_49(p42, p43)
	-- upvalues: (copy) v_u_41, (ref) v_u_36, (copy) v_u_29
	local v44 = p43 or v_u_41.System
	local v45 = Instance.new("TextLabel")
	v45.Name = "Log_" .. v_u_36
	v45.LayoutOrder = v_u_36
	v45.Size = UDim2.new(1, -10, 0, 14)
	v45.BackgroundTransparency = 1
	v45.Text = p42
	v45.TextColor3 = v44
	v45.TextSize = 11
	v45.Font = Enum.Font.Gotham
	v45.TextXAlignment = Enum.TextXAlignment.Left
	v45.TextWrapped = true
	v45.AutomaticSize = Enum.AutomaticSize.Y
	v45.Parent = v_u_29
	v_u_36 = v_u_36 + 1
	local v46 = 0
	for _, v47 in ipairs(v_u_29:GetChildren()) do
		if v47:IsA("TextLabel") then
			v46 = v46 + 1
		end
	end
	if v46 > 50 then
		for _, v48 in ipairs(v_u_29:GetChildren()) do
			if v48:IsA("TextLabel") then
				v48:Destroy()
				break
			end
		end
	end
	task.defer(function()
		-- upvalues: (ref) v_u_29
		v_u_29.CanvasPosition = Vector2.new(0, v_u_29.AbsoluteCanvasSize.Y)
	end)
end
local function v_u_51()
	-- upvalues: (copy) v_u_28, (ref) v_u_39, (ref) v_u_40, (copy) v_u_27
	for _, v50 in ipairs(v_u_28:GetChildren()) do
		if v50:IsA("TextButton") then
			v50:Destroy()
		end
	end
	v_u_39 = {}
	v_u_40 = 0
	v_u_27.Visible = false
	v_u_27.Size = UDim2.new(1, 0, 0, 0)
end
local function v_u_54()
	-- upvalues: (ref) v_u_39, (ref) v_u_40, (copy) v_u_41
	for v52, v53 in ipairs(v_u_39) do
		if v52 == v_u_40 then
			v53.BackgroundColor3 = v_u_41.Selected
			v53.BackgroundTransparency = 0.3
		else
			v53.BackgroundColor3 = v_u_41.Normal
			v53.BackgroundTransparency = 0.5
		end
	end
end
local function v_u_61(p_u_55, p_u_56)
	-- upvalues: (copy) v_u_41, (copy) v_u_25, (copy) v_u_51, (ref) v_u_40, (copy) v_u_54
	local v57 = Instance.new("TextButton")
	v57.Name = "Suggestion_" .. p_u_56
	v57.LayoutOrder = p_u_56
	v57.Size = UDim2.new(1, -6, 0, 24)
	v57.BackgroundColor3 = v_u_41.Normal
	v57.BackgroundTransparency = 0.5
	v57.BorderSizePixel = 0
	v57.Text = ""
	v57.AutoButtonColor = false
	v57.ZIndex = 22
	if p_u_55.fullCmd then
		v57:SetAttribute("FullCmd", p_u_55.fullCmd)
	end
	local v58 = Instance.new("UICorner")
	v58.CornerRadius = UDim.new(0.15, 0)
	v58.Parent = v57
	local v59 = Instance.new("TextLabel")
	v59.Name = "Name"
	v59.Size = UDim2.new(0.35, 0, 1, 0)
	v59.Position = UDim2.new(0, 8, 0, 0)
	v59.BackgroundTransparency = 1
	v59.Text = p_u_55.text or p_u_55.name
	v59.TextColor3 = v_u_41.Info
	v59.TextSize = 12
	v59.Font = Enum.Font.GothamBold
	v59.TextXAlignment = Enum.TextXAlignment.Left
	v59.ZIndex = 23
	v59.Parent = v57
	local v60 = Instance.new("TextLabel")
	v60.Name = "Desc"
	v60.Size = UDim2.new(0.6, 0, 1, 0)
	v60.Position = UDim2.new(0.38, 0, 0, 0)
	v60.BackgroundTransparency = 1
	v60.Text = p_u_55.desc
	v60.TextColor3 = Color3.fromRGB(150, 150, 150)
	v60.TextSize = 11
	v60.Font = Enum.Font.Gotham
	v60.TextXAlignment = Enum.TextXAlignment.Left
	v60.TextTruncate = Enum.TextTruncate.AtEnd
	v60.ZIndex = 23
	v60.Parent = v57
	v57.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_55, (ref) v_u_25, (ref) v_u_51
		if p_u_55.isCommand then
			v_u_25.Text = p_u_55.text .. " "
		else
			v_u_25.Text = (p_u_55.fullCmd or p_u_55.text) .. " "
		end
		v_u_25:CaptureFocus()
		v_u_25.CursorPosition = #v_u_25.Text + 1
		v_u_51()
	end)
	v57.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_40, (copy) p_u_56, (ref) v_u_54
		v_u_40 = p_u_56
		v_u_54()
	end)
	return v57
end
local function v_u_86(p62)
	-- upvalues: (copy) v_u_51, (ref) v_u_38, (copy) v_u_61, (copy) v_u_28, (ref) v_u_39, (copy) v_u_27, (copy) v_u_10
	v_u_51()
	if p62 == "" then
		return
	else
		local v_u_63 = p62:split(" ")
		local v_u_64 = v_u_63[1]:lower()
		local v_u_65 = #v_u_63 - 1
		local v_u_66 = v_u_63[#v_u_63] or ""
		if #v_u_63 == 1 then
			local v67 = {}
			for _, v68 in ipairs(v_u_38) do
				if v68.name:sub(1, #v_u_64) == v_u_64 then
					local v69 = {
						["text"] = v68.name,
						["desc"] = v68.desc,
						["isCommand"] = true
					}
					table.insert(v67, v69)
				end
			end
			table.sort(v67, function(p70, p71)
				return p70.text < p71.text
			end)
			local v72 = #v67
			local v73 = math.min(v72, 20)
			for v74 = 1, v73 do
				local v75 = v_u_61(v67[v74], v74)
				v75.Parent = v_u_28
				local v76 = v_u_39
				table.insert(v76, v75)
			end
			if v73 > 0 then
				local v77 = math.min(v73, 5) * 25 + 6
				v_u_27.Size = UDim2.new(1, 0, 0, v77)
				v_u_27.Visible = true
			end
		elseif v_u_65 >= 1 then
			task.spawn(function()
				-- upvalues: (ref) v_u_10, (copy) v_u_64, (copy) v_u_65, (copy) v_u_66, (ref) v_u_51, (ref) v_u_61, (copy) v_u_63, (ref) v_u_28, (ref) v_u_39, (ref) v_u_27
				local v78 = v_u_10:InvokeServer(v_u_64, v_u_65, v_u_66)
				if v78 and (v78.suggestions and #v78.suggestions ~= 0) then
					v_u_51()
					local v79 = v78.typeName or ""
					local v80 = #v78.suggestions
					local v81 = math.min(v80, 20)
					for v82 = 1, v81 do
						local v83 = v_u_61({
							["text"] = v78.suggestions[v82],
							["desc"] = v79,
							["isCommand"] = false,
							["fullCmd"] = table.concat(v_u_63, " ", 1, #v_u_63 - 1) .. " " .. v78.suggestions[v82]
						}, v82)
						v83.Parent = v_u_28
						local v84 = v_u_39
						table.insert(v84, v83)
					end
					if v81 > 0 then
						local v85 = math.min(v81, 5) * 25 + 6
						v_u_27.Size = UDim2.new(1, 0, 0, v85)
						v_u_27.Visible = true
					end
				end
			end)
		end
	end
end
local function v_u_90()
	-- upvalues: (ref) v_u_40, (ref) v_u_39, (copy) v_u_25, (copy) v_u_51
	if v_u_40 > 0 and v_u_40 <= #v_u_39 then
		local v87 = v_u_39[v_u_40]
		local v88 = v87:GetAttribute("FullCmd")
		local v89 = v87:FindFirstChild("Name")
		if v88 then
			v_u_25.Text = v88 .. " "
		elseif v89 then
			v_u_25.Text = v89.Text .. " "
		end
		v_u_25.CursorPosition = #v_u_25.Text + 1
		v_u_51()
	end
end
local function v_u_98()
	-- upvalues: (copy) v_u_22, (copy) v_u_1, (ref) v_u_35, (copy) v_u_20, (ref) v_u_34, (copy) v_u_21, (copy) v_u_49, (copy) v_u_41
	for _, v91 in ipairs(v_u_22:GetChildren()) do
		if v91:IsA("TextButton") then
			v91:Destroy()
		end
	end
	local v92 = v_u_1:GetPlayers()
	for _, v_u_93 in ipairs(v92) do
		local v94 = Instance.new("TextButton")
		v94.Name = v_u_93.Name
		v94.Size = UDim2.new(1, -8, 0, 22)
		v94.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
		v94.BackgroundTransparency = 0.3
		v94.BorderSizePixel = 0
		v94.Text = v_u_93.Name
		v94.TextColor3 = Color3.fromRGB(220, 220, 220)
		v94.TextSize = 12
		v94.Font = Enum.Font.Gotham
		v94.ZIndex = 502
		local v95 = Instance.new("UICorner")
		v95.CornerRadius = UDim.new(0.15, 0)
		v95.Parent = v94
		v94.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_35, (copy) v_u_93, (ref) v_u_20, (ref) v_u_34, (ref) v_u_21, (ref) v_u_49, (ref) v_u_41
			v_u_35 = v_u_93
			v_u_20.Text = v_u_93.Name
			v_u_20.TextColor3 = Color3.fromRGB(255, 255, 255)
			v_u_34 = false
			v_u_21.Visible = false
			v_u_20.Arrow.Text = "\226\150\188"
			v_u_49("[Select] " .. v_u_93.Name, v_u_41.Info)
		end)
		v94.Parent = v_u_22
	end
	local v96 = #v92 * 26 + 8
	local v97 = math.min(v96, 130)
	v_u_21.Size = UDim2.new(1, 0, 0, v97)
end
local function v102()
	-- upvalues: (ref) v_u_34, (copy) v_u_98, (copy) v_u_20, (copy) v_u_13, (copy) v_u_21
	v_u_34 = not v_u_34
	if v_u_34 then
		v_u_98()
		local v99 = v_u_20.AbsolutePosition
		local v100 = v_u_20.AbsoluteSize
		local v101 = v_u_13.AbsolutePosition
		v_u_21.Position = UDim2.new(0, v99.X - v101.X, 0, v99.Y - v101.Y + v100.Y + 4)
		v_u_21.Size = UDim2.new(0, v100.X, 0, 130)
		v_u_21.Visible = true
		v_u_20.Arrow.Text = "\226\150\178"
	else
		v_u_21.Visible = false
		v_u_20.Arrow.Text = "\226\150\188"
	end
end
local function v_u_105(p103)
	-- upvalues: (copy) v_u_49, (copy) v_u_41, (copy) v_u_51, (copy) v_u_7, (ref) v_u_35
	if p103 and p103 ~= "" then
		v_u_49("> " .. p103, v_u_41.System)
		v_u_51()
		local v104 = v_u_7:InvokeServer(p103, v_u_35 and v_u_35.Name or nil)
		if v104 then
			if v104.success then
				v_u_49(v104.message, v_u_41.Success)
			else
				v_u_49(v104.message, v_u_41.Error)
			end
		else
			v_u_49("[Error] No response from server", v_u_41.Error)
			return
		end
	else
		return
	end
end
local function v109()
	-- upvalues: (copy) v_u_23, (ref) v_u_35, (copy) v_u_49, (copy) v_u_41, (copy) v_u_105
	local v_u_106 = {
		["God"] = "god",
		["Invis"] = "invis",
		["TeleportTo"] = "tp",
		["BringHere"] = "bring",
		["Noclip"] = "noclip"
	}
	local v_u_107 = {
		["God"] = false,
		["Invis"] = false,
		["Noclip"] = false
	}
	for _, v_u_108 in ipairs(v_u_23:GetChildren()) do
		if v_u_108:IsA("TextButton") and v_u_106[v_u_108.Name] then
			v_u_108.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_35, (copy) v_u_108, (ref) v_u_49, (ref) v_u_41, (copy) v_u_107, (ref) v_u_105, (copy) v_u_106
				if v_u_35 or v_u_108.Name ~= "TeleportTo" and v_u_108.Name ~= "BringHere" then
					if v_u_107[v_u_108.Name] ~= nil then
						v_u_107[v_u_108.Name] = not v_u_107[v_u_108.Name]
						if v_u_107[v_u_108.Name] then
							v_u_108.Text = v_u_108.Text:gsub(" \226\156\147", "") .. " \226\156\147"
						else
							v_u_108.Text = v_u_108.Text:gsub(" \226\156\147", "")
						end
					end
					v_u_105(v_u_106[v_u_108.Name])
				else
					v_u_49("[Error] Select a player first!", v_u_41.Error)
				end
			end)
		end
	end
end
local function v_u_110()
	-- upvalues: (ref) v_u_33
	v_u_33 = true
end
local function v_u_111()
	-- upvalues: (ref) v_u_33, (ref) v_u_34, (copy) v_u_21, (copy) v_u_20, (copy) v_u_51
	v_u_33 = false
	if v_u_34 then
		v_u_34 = false
		v_u_21.Visible = false
		v_u_20.Arrow.Text = "\226\150\188"
	end
	v_u_51()
end
local function v_u_112()
	-- upvalues: (copy) v_u_4
	v_u_4:Close("Admin")
end
local function v113()
	-- upvalues: (copy) v_u_4
	v_u_4:Toggle("Admin")
end
local function v117()
	-- upvalues: (copy) v_u_14, (copy) v_u_112
	local v114 = v_u_14:FindFirstChild("CloseButtonFrame")
	if v114 then
		local v115 = v114:FindFirstChild("CloseButton")
		if v115 then
			for _, v116 in ipairs(v115:GetChildren()) do
				if v116:IsA("LocalScript") then
					v116:Destroy()
				end
			end
			v115.MouseButton1Click:Connect(v_u_112)
		end
	end
end
v_u_25:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (copy) v_u_25, (copy) v_u_86
	local v118 = v_u_25.Text
	if v118:find("\t") then
		local v119 = v_u_25.CursorPosition
		v_u_25.Text = v118:gsub("\t", "")
		local v120 = v_u_25
		local v121 = v119 - 1
		v120.CursorPosition = math.max(1, v121)
	else
		v_u_86(v118)
	end
end)
v_u_25.FocusLost:Connect(function(p122)
	-- upvalues: (copy) v_u_105, (copy) v_u_25, (copy) v_u_51
	if p122 then
		v_u_105(v_u_25.Text)
		v_u_25.Text = ""
	end
	task.delay(0.1, function()
		-- upvalues: (ref) v_u_25, (ref) v_u_51
		if not v_u_25:IsFocused() then
			v_u_51()
		end
	end)
end)
v3.InputBegan:Connect(function(p123, _)
	-- upvalues: (copy) v_u_25, (ref) v_u_39, (ref) v_u_40, (copy) v_u_90, (copy) v_u_54, (copy) v_u_51
	if v_u_25:IsFocused() and p123.KeyCode == Enum.KeyCode.Tab then
		if #v_u_39 > 0 then
			if v_u_40 == 0 then
				v_u_40 = 1
			end
			v_u_90()
		end
	elseif v_u_25:IsFocused() and #v_u_39 > 0 then
		if p123.KeyCode == Enum.KeyCode.Down then
			local v124 = v_u_40 + 1
			local v125 = #v_u_39
			v_u_40 = math.min(v124, v125)
			v_u_54()
			return
		end
		if p123.KeyCode == Enum.KeyCode.Up then
			local v126 = v_u_40 - 1
			v_u_40 = math.max(v126, 1)
			v_u_54()
			return
		end
		if p123.KeyCode == Enum.KeyCode.Escape then
			v_u_51()
		end
	end
end)
v_u_20.MouseButton1Click:Connect(v102)
v26.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_105, (copy) v_u_25
	v_u_105(v_u_25.Text)
	v_u_25.Text = ""
end)
v30.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_29, (ref) v_u_36, (copy) v_u_49, (copy) v_u_41
	for _, v127 in ipairs(v_u_29:GetChildren()) do
		if v127:IsA("TextLabel") then
			v127:Destroy()
		end
	end
	v_u_36 = 1
	v_u_49("[System] Log cleared", v_u_41.Info)
end)
v_u_1.PlayerRemoving:Connect(function(p128)
	-- upvalues: (ref) v_u_35, (copy) v_u_20
	if v_u_35 == p128 then
		v_u_35 = nil
		v_u_20.Text = "Click to select player..."
		v_u_20.TextColor3 = Color3.fromRGB(180, 180, 180)
	end
end)
v11.OnClientEvent:Connect(function(p129, p130)
	-- upvalues: (copy) v_u_49, (copy) v_u_41
	v_u_49(p129, v_u_41[p130] or v_u_41.System)
end)
if v32 then
	v32.MouseButton1Click:Connect(v113)
end
v_u_13.Visible = false
v117()
v109()
task.spawn(function()
	-- upvalues: (copy) v_u_8, (ref) v_u_37, (copy) v_u_4, (copy) v_u_13, (copy) v_u_110, (copy) v_u_111, (copy) v_u_31, (ref) v_u_38, (copy) v_u_9, (copy) v_u_49, (copy) v_u_41, (copy) v_u_12
	local v131 = v_u_8:InvokeServer()
	v_u_37 = v131 ~= nil
	if v_u_37 then
		v_u_4:Register("Admin", v_u_13, {
			["onOpen"] = v_u_110,
			["onClose"] = v_u_111
		})
		if v_u_31 then
			v_u_31.Visible = true
		end
		v_u_38 = v_u_9:InvokeServer() or {}
		v_u_49("[System] Panel ready (" .. (v131 == "tester" and "TESTER" or "ADMIN") .. "). Click button to open.", v_u_41.Info)
		v_u_49("[System] Type command or use Tab/\226\134\145\226\134\147 for autocomplete.", v_u_41.System)
		if v131 == "tester" then
			v_u_49("[System] Tester mode: self-only commands.", v_u_41.Warning)
			return
		end
	else
		v_u_12.Enabled = false
		if v_u_31 then
			v_u_31.Visible = false
		end
	end
end)