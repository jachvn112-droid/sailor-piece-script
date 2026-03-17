local v_u_1 = game:GetService("TweenService")
local v_u_2 = script.Parent
if v_u_2 and v_u_2:IsA("GuiButton") then
	local v_u_3 = tonumber(v_u_2:GetAttribute("HoverScale")) or 1.06
	local v_u_4 = tonumber(v_u_2:GetAttribute("PressFactor")) or 0.96
	local v_u_5 = tonumber(v_u_2:GetAttribute("TweenIn")) or 0.1
	local v_u_6 = tonumber(v_u_2:GetAttribute("TweenOut")) or 0.12
	local v_u_7 = tonumber(v_u_2:GetAttribute("PressTime")) or 0.06
	local v_u_8 = tonumber(v_u_2:GetAttribute("ClickPop")) or 1.02
	local v_u_9 = tonumber(v_u_2:GetAttribute("ClickPopIn")) or 0.05
	local v_u_10 = tonumber(v_u_2:GetAttribute("ClickPopOut")) or 0.1
	pcall(function()
		-- upvalues: (copy) v_u_2
		v_u_2.AutoButtonColor = false
	end)
	local v_u_11 = v_u_2:FindFirstChild("HoverPressScale")
	if not (v_u_11 and v_u_11:IsA("UIScale")) then
		v_u_11 = Instance.new("UIScale")
		v_u_11.Name = "HoverPressScale"
		v_u_11.Scale = 1
		v_u_11.Parent = v_u_2
	end
	v_u_11.Scale = 1
	local v_u_12 = nil
	local function v_u_17(p13, p14, p15, p16)
		-- upvalues: (ref) v_u_12, (copy) v_u_1, (ref) v_u_11
		if v_u_12 then
			v_u_12:Cancel()
		end
		v_u_12 = v_u_1:Create(v_u_11, TweenInfo.new(p14, p15 or Enum.EasingStyle.Quad, p16 or Enum.EasingDirection.Out), {
			["Scale"] = p13
		})
		v_u_12:Play()
	end
	local v_u_18 = false
	local v_u_19 = false
	v_u_2.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_18, (ref) v_u_19, (copy) v_u_17, (copy) v_u_3, (copy) v_u_5
		v_u_18 = true
		if not v_u_19 then
			v_u_17(v_u_3, v_u_5)
		end
	end)
	v_u_2.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_18, (ref) v_u_19, (copy) v_u_17, (copy) v_u_6
		v_u_18 = false
		if not v_u_19 then
			v_u_17(1, v_u_6)
		end
	end)
	v_u_2.SelectionGained:Connect(function()
		-- upvalues: (ref) v_u_18, (ref) v_u_19, (copy) v_u_17, (copy) v_u_3, (copy) v_u_5
		v_u_18 = true
		if not v_u_19 then
			v_u_17(v_u_3, v_u_5)
		end
	end)
	v_u_2.SelectionLost:Connect(function()
		-- upvalues: (ref) v_u_18, (ref) v_u_19, (copy) v_u_17, (copy) v_u_6
		v_u_18 = false
		if not v_u_19 then
			v_u_17(1, v_u_6)
		end
	end)
	v_u_2.InputBegan:Connect(function(p20)
		-- upvalues: (ref) v_u_19, (copy) v_u_17, (ref) v_u_18, (copy) v_u_3, (copy) v_u_4, (copy) v_u_7
		local v21 = p20.UserInputType
		if v21 == Enum.UserInputType.MouseButton1 or (v21 == Enum.UserInputType.Touch or v21.Name:match("^Gamepad")) then
			v_u_19 = true
			local v22 = v_u_17
			local v23 = v_u_18 and v_u_3 or 1
			if v_u_19 then
				v23 = v23 * v_u_4 or v23
			end
			v22(v23, v_u_7)
		end
	end)
	v_u_2.InputEnded:Connect(function(p24)
		-- upvalues: (ref) v_u_19, (copy) v_u_17, (ref) v_u_18, (copy) v_u_3, (copy) v_u_4
		local v25 = p24.UserInputType
		if v25 == Enum.UserInputType.MouseButton1 or (v25 == Enum.UserInputType.Touch or v25.Name:match("^Gamepad")) then
			v_u_19 = false
			local v26 = v_u_17
			local v27 = v_u_18 and v_u_3 or 1
			if v_u_19 then
				v27 = v27 * v_u_4 or v27
			end
			v26(v27, 0.08)
		end
	end)
	v_u_2.Activated:Connect(function()
		-- upvalues: (ref) v_u_18, (copy) v_u_3, (ref) v_u_19, (copy) v_u_4, (copy) v_u_8, (copy) v_u_17, (copy) v_u_9, (copy) v_u_10
		local v28 = v_u_18 and v_u_3 or 1
		if v_u_19 then
			v28 = v28 * v_u_4 or v28
		end
		v_u_17(v28 * v_u_8, v_u_9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.delay(v_u_9, function()
			-- upvalues: (ref) v_u_17, (ref) v_u_18, (ref) v_u_3, (ref) v_u_19, (ref) v_u_4, (ref) v_u_10
			local v29 = v_u_17
			local v30 = v_u_18 and v_u_3 or 1
			if v_u_19 then
				v30 = v30 * v_u_4 or v30
			end
			v29(v30, v_u_10, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		end)
	end)
end