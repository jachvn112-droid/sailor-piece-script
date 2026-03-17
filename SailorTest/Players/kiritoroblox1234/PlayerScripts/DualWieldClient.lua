local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = v_u_1:WaitForChild("RemoteEvents"):WaitForChild("DualWieldSync")
local v_u_4 = v2.LocalPlayer
local v_u_5 = {
	["Jinwoo"] = {
		["LeftWeaponPath"] = "AbilitySystem.VFX.Jinwoo.LeftHandDagger",
		["AttachTo"] = "Left Arm",
		["AttachToR15"] = "LeftHand",
		["Offset"] = CFrame.new(0, -0.95, -1.25) * CFrame.Angles(1.5707963267948966, 4.71238898038469, 1.1040080183490133),
		["OffsetR15"] = CFrame.new(0, -0.3, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
	},
	["Light"] = {
		["LeftWeaponPath"] = "FruitPowerSystem.VFX.Light.Handle",
		["AttachTo"] = "Right Arm",
		["AttachToR15"] = "RightHand",
		["Offset"] = CFrame.Angles(-1.5707963267948966, 4.71238898038469, 0) * CFrame.new(-1, 2.33, 0),
		["OffsetR15"] = CFrame.Angles(0, 4.71238898038469, 0) * CFrame.new(0, -0.8, 0)
	},
	["Alucard"] = {
		["DualWield"] = true,
		["WeaponModelPath"] = "AbilitySystem.VFX.Alucard.2guns",
		["LeftGunName"] = "gundone",
		["RightGunName"] = "gundone.001",
		["AttachToLeft"] = "Left Arm",
		["AttachToLeftR15"] = "LeftHand",
		["LeftOffset"] = CFrame.new(-0.0171508789, -1.9086647, -0.49597168, 0.999999404, -0.00111249834, 0.0000186536799, -0.0000200340273, -0.00124076754, 0.999999225, -0.00111247425, -0.999998629, -0.00124078908),
		["LeftOffsetR15"] = CFrame.new(0, -0.3, 0) * CFrame.Angles(-1.5707963267948966, 0, 0),
		["AttachToRight"] = "Right Arm",
		["AttachToRightR15"] = "RightHand",
		["RightOffset"] = CFrame.new(0.115966797, -1.90624118, -0.499450684, 0.999999404, -0.00111249834, 0.0000186536763, -0.0000200340291, -0.00124076882, 0.999999225, -0.00111247425, -0.999998629, -0.00124079036),
		["RightOffsetR15"] = CFrame.new(0, -0.3, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
	}
}
local v_u_6 = {}
local function v_u_10(p7)
	-- upvalues: (copy) v_u_1
	local v8 = v_u_1
	for v9 in p7:gmatch("[^.]+") do
		v8 = v8:FindFirstChild(v9)
		if not v8 then
			return nil
		end
	end
	return v8
end
local function v_u_37(p11, p12)
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_10
	if p11 and p11.Parent then
		local v13 = v_u_5[p12]
		if v13 then
			if v_u_6[p11] then
				v_u_6[p11]:Destroy()
				v_u_6[p11] = nil
			end
			local v14 = p11:FindFirstChildOfClass("Humanoid") or p11:WaitForChild("Humanoid", 3)
			if v14 then
				local v15 = v14.RigType == Enum.HumanoidRigType.R15
				if v13.DualWield then
					local v16 = v_u_10(v13.WeaponModelPath)
					if v16 then
						local v17 = v15 and v13.AttachToLeftR15 or v13.AttachToLeft
						local v18 = v15 and v13.AttachToRightR15 or v13.AttachToRight
						local v19 = p11:FindFirstChild(v17) or p11:WaitForChild(v17, 2)
						local v20 = p11:FindFirstChild(v18) or p11:WaitForChild(v18, 2)
						if v19 and v20 then
							local v21 = v16:Clone()
							v21.Name = "DualWeapon_" .. p12
							local v22 = v21:FindFirstChild(v13.LeftGunName)
							local v23 = v21:FindFirstChild(v13.RightGunName)
							v21.Parent = p11
							if v22 then
								local v24 = v15 and v13.LeftOffsetR15 or v13.LeftOffset
								if v22 and v19 then
									v22.CanCollide = false
									v22.Massless = true
									v22.Anchored = false
									v22.CFrame = v19.CFrame * v24
									local v25 = Instance.new("WeldConstraint")
									v25.Part0 = v19
									v25.Part1 = v22
									v25.Parent = v22
								end
							end
							if v23 then
								local v26 = v15 and v13.RightOffsetR15 or v13.RightOffset
								if v23 and v20 then
									v23.CanCollide = false
									v23.Massless = true
									v23.Anchored = false
									v23.CFrame = v20.CFrame * v26
									local v27 = Instance.new("WeldConstraint")
									v27.Part0 = v20
									v27.Part1 = v23
									v27.Parent = v23
								end
							end
							v_u_6[p11] = v21
						else
							warn("DualWieldClient: Could not find hands for", p12)
						end
					else
						warn("DualWieldClient: Could not find weapon model at", v13.WeaponModelPath)
						return
					end
				else
					local v28 = v_u_10(v13.LeftWeaponPath)
					if v28 then
						local v29 = v15 and v13.AttachToR15 or v13.AttachTo
						local v30 = p11:FindFirstChild(v29) or p11:WaitForChild(v29, 2)
						if not v30 and (v13.AttachToR15 and v13.AttachTo) then
							v30 = p11:FindFirstChild(v15 and v13.AttachTo or v13.AttachToR15)
							if v30 then
								v15 = not v15
							end
						end
						if v30 then
							local v31 = v28:Clone()
							v31.Name = "LeftWeapon_" .. p12
							local _ = v31
							for _, v32 in v31:GetDescendants() do
								if v32:IsA("BasePart") then
									v32.CanCollide = false
									v32.Massless = true
									v32.Anchored = false
								end
							end
							local v33
							if v31:IsA("BasePart") then
								v31.CanCollide = false
								v31.Massless = true
								v31.Anchored = false
								v33 = v31
							else
								v33 = v31:IsA("Model") and (v31.PrimaryPart or v31:FindFirstChildWhichIsA("BasePart"))
								if v33 then
									v33.CanCollide = false
									v33.Massless = true
									v33.Anchored = false
								end
							end
							if v33 then
								local v34 = Instance.new("Weld")
								v34.Name = "LeftWeaponWeld"
								v34.Part0 = v30
								v34.Part1 = v33
								v34.C0 = v15 and v13.OffsetR15 or v13.Offset
								v34.Parent = v33
								for _, v35 in v31:GetDescendants() do
									if v35:IsA("BasePart") and v35 ~= v33 then
										local v36 = Instance.new("WeldConstraint")
										v36.Part0 = v33
										v36.Part1 = v35
										v36.Parent = v35
									end
								end
								v31.Parent = p11
								v_u_6[p11] = v31
							else
								warn("DualWieldClient: No main part found for left weapon")
								v31:Destroy()
							end
						else
							return
						end
					else
						warn("DualWieldClient: Could not find left weapon at", v13.LeftWeaponPath)
						return
					end
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
local function v_u_42()
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_3
	local v38 = v_u_4.Character
	if v38 then
		v38.ChildAdded:Connect(function(p39)
			-- upvalues: (ref) v_u_5, (ref) v_u_3
			if p39:IsA("Tool") and v_u_5[p39.Name] then
				v_u_3:FireServer("Equip", p39.Name)
			end
		end)
		v38.ChildRemoved:Connect(function(p40)
			-- upvalues: (ref) v_u_5, (ref) v_u_3
			if p40:IsA("Tool") and v_u_5[p40.Name] then
				v_u_3:FireServer("Unequip", p40.Name)
			end
		end)
		for _, v41 in v38:GetChildren() do
			if v41:IsA("Tool") and v_u_5[v41.Name] then
				v_u_3:FireServer("Equip", v41.Name)
			end
		end
	end
end
v_u_4.CharacterAdded:Connect(function(_)
	-- upvalues: (copy) v_u_42
	task.wait(0.1)
	v_u_42()
end)
if v_u_4.Character then
	v_u_42()
end
v_u_3.OnClientEvent:Connect(function(p43, p44, p45)
	-- upvalues: (copy) v_u_37, (copy) v_u_6
	local v46 = p43.Character
	if v46 then
		if p44 == "Equip" then
			v_u_37(v46, p45)
		elseif p44 == "Unequip" and v_u_6[v46] then
			v_u_6[v46]:Destroy()
			v_u_6[v46] = nil
		end
	else
		return
	end
end)
v2.PlayerRemoving:Connect(function(p47)
	-- upvalues: (copy) v_u_6
	local v48 = p47.Character
	if v48 and v_u_6[v48] then
		v_u_6[v48] = nil
	end
end)