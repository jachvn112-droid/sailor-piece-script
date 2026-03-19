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
	for _, v12 in ipairs(v_u_2:GetDescendants()) do
		if v12:IsA("UIScale") and v12 ~= v_u_11 then
			warn(("[HoverPressFX] Extra UIScale \'%s\' found under \'%s\'. It will multiply with HoverPressScale. Consider removing it."):format(v12.Name, v_u_2.Name))
		end
	end
	local v_u_13 = nil
	local function v_u_18(p14, p15, p16, p17)
		-- upvalues: (ref) v_u_13, (copy) v_u_1, (ref) v_u_11
		if v_u_13 then
			v_u_13:Cancel()
		end
		v_u_13 = v_u_1:Create(v_u_11, TweenInfo.new(p15, p16 or Enum.EasingStyle.Quad, p17 or Enum.EasingDirection.Out), {
			["Scale"] = p14
		})
		v_u_13:Play()
	end
	local v_u_19 = false
	local v_u_20 = false
	v_u_2.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_19, (ref) v_u_20, (copy) v_u_18, (copy) v_u_3, (copy) v_u_5
		v_u_19 = true
		if not v_u_20 then
			v_u_18(v_u_3, v_u_5)
		end
	end)
	v_u_2.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_19, (ref) v_u_20, (copy) v_u_18, (copy) v_u_6
		v_u_19 = false
		if not v_u_20 then
			v_u_18(1, v_u_6)
		end
	end)
	v_u_2.SelectionGained:Connect(function()
		-- upvalues: (ref) v_u_19, (ref) v_u_20, (copy) v_u_18, (copy) v_u_3, (copy) v_u_5
		v_u_19 = true
		if not v_u_20 then
			v_u_18(v_u_3, v_u_5)
		end
	end)
	v_u_2.SelectionLost:Connect(function()
		-- upvalues: (ref) v_u_19, (ref) v_u_20, (copy) v_u_18, (copy) v_u_6
		v_u_19 = false
		if not v_u_20 then
			v_u_18(1, v_u_6)
		end
	end)
	v_u_2.InputBegan:Connect(function(p21)
		-- upvalues: (ref) v_u_20, (copy) v_u_18, (ref) v_u_19, (copy) v_u_3, (copy) v_u_4, (copy) v_u_7
		local v22 = p21.UserInputType
		if v22 == Enum.UserInputType.MouseButton1 or (v22 == Enum.UserInputType.Touch or v22.Name:match("^Gamepad")) then
			v_u_20 = true
			local v23 = v_u_18
			local v24 = v_u_19 and v_u_3 or 1
			if v_u_20 then
				v24 = v24 * v_u_4 or v24
			end
			v23(v24, v_u_7)
		end
	end)
	v_u_2.InputEnded:Connect(function(p25)
		-- upvalues: (ref) v_u_20, (copy) v_u_18, (ref) v_u_19, (copy) v_u_3, (copy) v_u_4
		local v26 = p25.UserInputType
		if v26 == Enum.UserInputType.MouseButton1 or (v26 == Enum.UserInputType.Touch or v26.Name:match("^Gamepad")) then
			v_u_20 = false
			local v27 = v_u_18
			local v28 = v_u_19 and v_u_3 or 1
			if v_u_20 then
				v28 = v28 * v_u_4 or v28
			end
			v27(v28, 0.08)
		end
	end)
	v_u_2.Activated:Connect(function()
		-- upvalues: (ref) v_u_19, (copy) v_u_3, (ref) v_u_20, (copy) v_u_4, (copy) v_u_8, (copy) v_u_18, (copy) v_u_9, (copy) v_u_10
		local v29 = v_u_19 and v_u_3 or 1
		if v_u_20 then
			v29 = v29 * v_u_4 or v29
		end
		v_u_18(v29 * v_u_8, v_u_9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.delay(v_u_9, function()
			-- upvalues: (ref) v_u_18, (ref) v_u_19, (ref) v_u_3, (ref) v_u_20, (ref) v_u_4, (ref) v_u_10
			local v30 = v_u_18
			local v31 = v_u_19 and v_u_3 or 1
			if v_u_20 then
				v31 = v31 * v_u_4 or v31
			end
			v30(v31, v_u_10, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		end)
	end)
else
	warn("[HoverPressFX] Place this script under an ImageButton or TextButton.")
end