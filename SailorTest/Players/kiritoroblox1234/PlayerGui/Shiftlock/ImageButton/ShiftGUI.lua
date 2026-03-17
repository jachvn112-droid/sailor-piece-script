local v1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("ContextActionService")
local v_u_4 = v1.LocalPlayer
local v_u_5 = v_u_4.Character or v_u_4.CharacterAdded:Wait()
local v_u_6 = v_u_5:WaitForChild("HumanoidRootPart")
local v_u_7 = v_u_5.Humanoid
local v_u_8 = workspace.CurrentCamera
local v_u_9 = script.Parent
uis = game:GetService("UserInputService")
ismobile = uis.TouchEnabled
v_u_9.Visible = ismobile
local v_u_10 = {
	["OFF"] = "rbxasset://textures/ui/mouseLock_off@2x.png",
	["ON"] = "rbxasset://textures/ui/mouseLock_on@2x.png"
}
local v_u_11 = false
local v_u_12 = false
local v_u_13 = CFrame.new(1.7, 0, 0)
local v_u_14 = CFrame.new(-1.7, 0, 0)
local function v_u_16()
	-- upvalues: (ref) v_u_12, (copy) v_u_8, (copy) v_u_14, (ref) v_u_7, (copy) v_u_9, (copy) v_u_10, (ref) v_u_11
	if v_u_12 then
		v_u_8.CFrame = v_u_8.CFrame * v_u_14
	end
	v_u_12 = false
	if v_u_7 and v_u_7.Parent then
		v_u_7.AutoRotate = true
	end
	v_u_9.Image = v_u_10.OFF
	pcall(function()
		-- upvalues: (ref) v_u_11
		if v_u_11 then
			local v15 = v_u_11
			if typeof(v15) == "RBXScriptConnection" then
				v_u_11:Disconnect()
			end
		end
	end)
	v_u_11 = false
end
local function v19(p17)
	-- upvalues: (ref) v_u_11, (ref) v_u_12, (copy) v_u_8, (copy) v_u_14, (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (copy) v_u_9, (copy) v_u_10
	if v_u_11 then
		pcall(function()
			-- upvalues: (ref) v_u_11
			local v18 = v_u_11
			if typeof(v18) == "RBXScriptConnection" then
				v_u_11:Disconnect()
			end
		end)
		v_u_11 = false
	end
	if v_u_12 then
		v_u_8.CFrame = v_u_8.CFrame * v_u_14
	end
	v_u_12 = false
	v_u_5 = p17
	v_u_6 = v_u_5:WaitForChild("HumanoidRootPart")
	v_u_7 = v_u_5:WaitForChild("Humanoid")
	v_u_9.Image = v_u_10.OFF
end
v_u_4.CharacterAdded:Connect(v19)
v_u_9.Image = v_u_10.OFF
v_u_11 = false
function ShiftLock()
	-- upvalues: (ref) v_u_11, (copy) v_u_4, (ref) v_u_6, (ref) v_u_7, (ref) v_u_12, (copy) v_u_9, (copy) v_u_10, (copy) v_u_8, (copy) v_u_13, (copy) v_u_2, (copy) v_u_16
	if v_u_11 then
		v_u_16()
		return
	else
		local v20 = v_u_4.Character
		if v20 then
			v_u_6 = v20:FindFirstChild("HumanoidRootPart")
			v_u_7 = v20:FindFirstChild("Humanoid")
		end
		local v21 = v_u_6 and (v_u_6.Parent and v_u_7)
		if v21 then
			v21 = v_u_7.Parent
		end
		if v21 then
			local v22
			if v_u_6 and (v_u_6.Parent and (v_u_7 and v_u_7.Parent)) then
				v_u_12 = true
				if v_u_7 and v_u_7.Parent then
					v_u_7.AutoRotate = false
				end
				v_u_9.Image = v_u_10.ON
				v_u_8.CFrame = v_u_8.CFrame * v_u_13
				v22 = true
			else
				v22 = false
			end
			if v22 then
				v_u_11 = v_u_2.RenderStepped:Connect(function()
					-- upvalues: (ref) v_u_4, (ref) v_u_6, (ref) v_u_7, (ref) v_u_16, (ref) v_u_8
					local v23 = v_u_4.Character
					if v23 then
						v_u_6 = v23:FindFirstChild("HumanoidRootPart")
						v_u_7 = v23:FindFirstChild("Humanoid")
					end
					local v24 = v_u_6 and (v_u_6.Parent and v_u_7)
					if v24 then
						v24 = v_u_7.Parent
					end
					if v24 then
						if v_u_6 then
							if not v_u_6.Parent then
								return
							end
							if v_u_4:GetAttribute("InCutscene") == true then
								return
							end
							local v25 = v_u_6
							local v26 = v_u_6
							local v27 = v_u_8
							local v28 = CFrame.new
							local v29 = v26.Position
							local v30 = v27.CFrame.LookVector.X * 900000
							local v31 = v26.Position.Y
							local v32 = v27.CFrame.LookVector.Z * 900000
							v25.CFrame = v28(v29, (Vector3.new(v30, v31, v32)))
						end
					else
						v_u_16()
					end
				end)
			end
		else
			return
		end
	end
end
v3:BindAction("ShiftLOCK", ShiftLock, false, "On")
v3:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0))
v_u_4:GetAttributeChangedSignal("ShiftLockEnabled"):Connect(function()
	-- upvalues: (copy) v_u_4, (ref) v_u_11
	if (v_u_4:GetAttribute("ShiftLockEnabled") or false) ~= (v_u_11 and true or false) then
		ShiftLock()
	end
end)
v_u_9.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_11, (copy) v_u_4, (ref) v_u_6, (ref) v_u_7, (ref) v_u_12, (copy) v_u_9, (copy) v_u_10, (copy) v_u_8, (copy) v_u_13, (copy) v_u_2, (copy) v_u_16
	if v_u_11 then
		v_u_16()
		return
	else
		local v33 = v_u_4.Character
		if v33 then
			v_u_6 = v33:FindFirstChild("HumanoidRootPart")
			v_u_7 = v33:FindFirstChild("Humanoid")
		end
		local v34 = v_u_6 and (v_u_6.Parent and v_u_7)
		if v34 then
			v34 = v_u_7.Parent
		end
		if v34 then
			local v35
			if v_u_6 and (v_u_6.Parent and (v_u_7 and v_u_7.Parent)) then
				v_u_12 = true
				if v_u_7 and v_u_7.Parent then
					v_u_7.AutoRotate = false
				end
				v_u_9.Image = v_u_10.ON
				v_u_8.CFrame = v_u_8.CFrame * v_u_13
				v35 = true
			else
				v35 = false
			end
			if v35 then
				v_u_11 = v_u_2.RenderStepped:Connect(function()
					-- upvalues: (ref) v_u_4, (ref) v_u_6, (ref) v_u_7, (ref) v_u_16, (ref) v_u_8
					local v36 = v_u_4.Character
					if v36 then
						v_u_6 = v36:FindFirstChild("HumanoidRootPart")
						v_u_7 = v36:FindFirstChild("Humanoid")
					end
					local v37 = v_u_6 and (v_u_6.Parent and v_u_7)
					if v37 then
						v37 = v_u_7.Parent
					end
					if v37 then
						if v_u_6 then
							if not v_u_6.Parent then
								return
							end
							if v_u_4:GetAttribute("InCutscene") == true then
								return
							end
							local v38 = v_u_6
							local v39 = v_u_6
							local v40 = v_u_8
							local v41 = CFrame.new
							local v42 = v39.Position
							local v43 = v40.CFrame.LookVector.X * 900000
							local v44 = v39.Position.Y
							local v45 = v40.CFrame.LookVector.Z * 900000
							v38.CFrame = v41(v42, (Vector3.new(v43, v44, v45)))
						end
					else
						v_u_16()
					end
				end)
			end
		else
			return
		end
	end
end)
return {}