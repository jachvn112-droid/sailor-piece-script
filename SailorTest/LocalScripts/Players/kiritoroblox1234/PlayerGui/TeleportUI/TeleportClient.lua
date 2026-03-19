local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
local v4 = v1.LocalPlayer
local v5 = require(v2:WaitForChild("PortalConfig"))
local v_u_6 = script.Parent:WaitForChild("MainFrame")
local v7 = v_u_6:WaitForChild("Frame")
local v_u_8 = v7:WaitForChild("Content"):WaitForChild("Holder")
local v9 = v7:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v10 = v_u_8:WaitForChild("Teleport")
v10.Visible = false
v10.Name = "Template"
local v11 = v2:WaitForChild("Remotes")
local v12 = v11:WaitForChild("OpenTeleportUI")
local v_u_13 = v11:WaitForChild("TeleportToPortal")
local v_u_14 = false
local v_u_15 = nil
local function v16()
	-- upvalues: (ref) v_u_14, (ref) v_u_15, (copy) v_u_6
	if v_u_14 then
		v_u_14 = false
		v_u_15 = nil
		v_u_6.Visible = false
	end
end
local function v18(p17)
	-- upvalues: (ref) v_u_14, (ref) v_u_15, (copy) v_u_6
	if not v_u_14 then
		v_u_14 = true
		v_u_15 = p17
		v_u_6.Visible = true
		if refreshLockStatus then
			task.spawn(refreshLockStatus)
		end
	end
end
local v_u_19 = v11:FindFirstChild("CheckPortalUnlock")
local v20 = v5.GetSortedPortals()
local v_u_21 = v_u_14
local v_u_22 = v_u_15
local v23 = {}
for _, v24 in ipairs(v20) do
	local v_u_25 = v24.id
	local v_u_26 = v24.data
	local v27 = v10:Clone()
	v27.Name = "Teleport_" .. v_u_25
	v27.Visible = true
	local v28 = v27:FindFirstChild("TeleportPlace")
	if v28 and (v28:IsA("ImageLabel") and v_u_26.Image) then
		v28.Image = v_u_26.Image
	end
	local v29 = v27:FindFirstChild("Holder")
	local v30
	if v29 then
		v30 = v29:FindFirstChild("TeleportPlace")
	else
		v30 = v29
	end
	if v29 then
		v29 = v29:FindFirstChild("Txt")
	end
	local v31 = v27:FindFirstChild("Teleport")
	if v30 then
		v30.Text = v_u_26.DisplayName
	end
	if v29 then
		if v_u_26.IsSpecial and v_u_26.SpecialText then
			v29.Text = v_u_26.SpecialText
		elseif v_u_26.Description then
			v29.Text = v_u_26.Description
		else
			v29.Text = ""
		end
		v29.Visible = true
	end
	local v32 = false
	if v_u_26.RequiresQuestline and v_u_19 then
		local v33, v34 = pcall(function()
			-- upvalues: (copy) v_u_19, (copy) v_u_25
			return v_u_19:InvokeServer(v_u_25)
		end)
		if not (v33 and v34) then
			v32 = true
			if v31 then
				v31.AutoButtonColor = false
				v31.BackgroundTransparency = 0.6
			end
			if v29 then
				v29.Text = "\240\159\148\146 " .. (v_u_26.SpecialText or "Locked")
			end
			if v28 then
				v28.ImageTransparency = 0.5
			end
		end
	end
	v23[v_u_25] = {
		["frame"] = v27,
		["locked"] = v32,
		["data"] = v_u_26,
		["teleportButton"] = v31,
		["txtLabel"] = v29,
		["imageLabel"] = v28
	}
	if v31 then
		v31.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_25, (ref) v_u_22, (copy) v_u_26, (copy) v_u_19, (copy) v_u_13, (ref) v_u_21, (copy) v_u_6
			if v_u_25 == v_u_22 then
				return
			else
				if v_u_26.RequiresQuestline and v_u_19 then
					local v35, v36 = pcall(function()
						-- upvalues: (ref) v_u_19, (ref) v_u_25
						return v_u_19:InvokeServer(v_u_25)
					end)
					if not (v35 and v36) then
						return
					end
				end
				v_u_13:FireServer(v_u_25)
				if v_u_21 then
					v_u_21 = false
					v_u_22 = nil
					v_u_6.Visible = false
				end
			end
		end)
	end
	v27.Parent = v_u_8
end
local v_u_37 = v_u_8:FindFirstChild("UIListLayout")
if v_u_37 then
	task.defer(function()
		-- upvalues: (copy) v_u_8, (copy) v_u_37
		v_u_8.CanvasSize = UDim2.new(0, 0, 0, v_u_37.AbsoluteContentSize.Y + 10)
	end)
end
v_u_6.Visible = false
v9.MouseButton1Click:Connect(v16)
v12.OnClientEvent:Connect(v18)
v4.CharacterAdded:Connect(v16)
v3.InputBegan:Connect(function(p38, p39)
	-- upvalues: (ref) v_u_21, (ref) v_u_22, (copy) v_u_6
	if not p39 then
		if p38.KeyCode == Enum.KeyCode.Escape and v_u_21 then
			if not v_u_21 then
				return
			end
			v_u_21 = false
			v_u_22 = nil
			v_u_6.Visible = false
		end
	end
end)