local v_u_1 = game:GetService("TweenService")
local v_u_2 = script.Parent
if v_u_2 and v_u_2:IsA("GuiButton") then
	pcall(function()
		-- upvalues: (copy) v_u_2
		v_u_2.AutoButtonColor = false
	end)
	local v_u_3 = v_u_2:FindFirstChild("HoverPressScale")
	if not (v_u_3 and v_u_3:IsA("UIScale")) then
		v_u_3 = Instance.new("UIScale")
		v_u_3.Name = "HoverPressScale"
		v_u_3.Scale = 1
		v_u_3.Parent = v_u_2
	end
	v_u_3.Scale = 1
	local v_u_4 = nil
	local function v_u_9(p5, p6, p7, p8)
		-- upvalues: (ref) v_u_4, (copy) v_u_1, (ref) v_u_3
		if v_u_4 then
			v_u_4:Cancel()
		end
		v_u_4 = v_u_1:Create(v_u_3, TweenInfo.new(p6, p7 or Enum.EasingStyle.Quad, p8 or Enum.EasingDirection.Out), {
			["Scale"] = p5
		})
		v_u_4:Play()
	end
	local v_u_10 = false
	local v_u_11 = false
	v_u_2.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_11, (copy) v_u_9
		v_u_10 = true
		if not v_u_11 then
			v_u_9(1.06, 0.1)
		end
	end)
	v_u_2.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_11, (copy) v_u_9
		v_u_10 = false
		if not v_u_11 then
			v_u_9(1, 0.12)
		end
	end)
	v_u_2.SelectionGained:Connect(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_11, (copy) v_u_9
		v_u_10 = true
		if not v_u_11 then
			v_u_9(1.06, 0.1)
		end
	end)
	v_u_2.SelectionLost:Connect(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_11, (copy) v_u_9
		v_u_10 = false
		if not v_u_11 then
			v_u_9(1, 0.12)
		end
	end)
	v_u_2.InputBegan:Connect(function(p12)
		-- upvalues: (ref) v_u_11, (copy) v_u_9, (ref) v_u_10
		local v13 = p12.UserInputType
		if v13 == Enum.UserInputType.MouseButton1 or (v13 == Enum.UserInputType.Touch or v13.Name:match("^Gamepad")) then
			v_u_11 = true
			local v14 = v_u_9
			local v15 = v_u_10 and 1.06 or 1
			if v_u_11 then
				v15 = v15 * 0.96 or v15
			end
			v14(v15, 0.06)
		end
	end)
	v_u_2.InputEnded:Connect(function(p16)
		-- upvalues: (ref) v_u_11, (copy) v_u_9, (ref) v_u_10
		local v17 = p16.UserInputType
		if v17 == Enum.UserInputType.MouseButton1 or (v17 == Enum.UserInputType.Touch or v17.Name:match("^Gamepad")) then
			v_u_11 = false
			local v18 = v_u_9
			local v19 = v_u_10 and 1.06 or 1
			if v_u_11 then
				v19 = v19 * 0.96 or v19
			end
			v18(v19, 0.08)
		end
	end)
	v_u_2.Activated:Connect(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_11, (copy) v_u_9
		local v20 = v_u_10 and 1.06 or 1
		if v_u_11 then
			v20 = v20 * 0.96 or v20
		end
		v_u_9(v20 * 1.02, 0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.delay(0.05, function()
			-- upvalues: (ref) v_u_9, (ref) v_u_10, (ref) v_u_11
			local v21 = v_u_9
			local v22 = v_u_10 and 1.06 or 1
			if v_u_11 then
				v22 = v22 * 0.96 or v22
			end
			v21(v22, 0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		end)
	end)
end