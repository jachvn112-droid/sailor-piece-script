local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = script.Parent
local _ = v_u_2.LocalPlayer
local v_u_4 = v1.AbilitySystem.Weapons.Saber
local v_u_5 = v_u_4:WaitForChild("EquipSwordEvent")
local function v_u_21(p6)
	-- upvalues: (copy) v_u_4
	local v7 = p6:WaitForChild("Right Arm")
	local v8 = v_u_4:WaitForChild("SwordR6RigTemplate")
	local v9 = v8:FindFirstChild("Handle")
	local v10 = v8:FindFirstChild("Sword")
	local v11 = v9:Clone()
	local v12 = v10:Clone()
	local v13 = v12.WeldPart1.Value.Name
	local v14 = p6:FindFirstChild(v13) or p6:WaitForChild(v13, 5)
	local v15 = v11.WeldPart2.Value.Name
	local v16 = p6:FindFirstChild(v15) or p6:WaitForChild(v15, 5)
	local v17 = v12.WeldPart1.Value.CFrame:Inverse() * v12.CFrame
	v12.CFrame = v14.CFrame * v17
	v12.Parent = p6
	local v18 = v11.WeldPart2.Value.CFrame:Inverse() * v11.CFrame
	v11.CFrame = v16.CFrame * v18
	v11.Parent = p6
	local v19 = Instance.new("Motor6D")
	v19.Name = "WeaponAttachment"
	v19.Part0 = v7
	v19.Part1 = v11
	v19.Parent = v7
	local v20 = Instance.new("WeldConstraint")
	v20.Name = "WeaponWeld"
	v20.Part0 = v11
	v20.Part1 = v12
	v20.Parent = v11
end
v_u_3.Equipped:Connect(function()
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_21, (copy) v_u_5
	if v_u_3.Name == "Saber" then
		local v22 = v_u_2.LocalPlayer
		v_u_21(v22.Character or v22.CharacterAdded:Wait())
		v_u_5:FireServer("Equip")
	end
end)
v_u_3.Unequipped:Connect(function()
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_5
	if v_u_3.Name == "Saber" then
		local v23 = v_u_2.LocalPlayer.Character
		if v23 then
			local v24 = v23:FindFirstChild("Handle")
			if v24 then
				v24:Destroy()
			end
			local v25 = v23:FindFirstChild("Greatsword")
			if v25 then
				v25:Destroy()
			end
		end
		v_u_5:FireServer("Unequip")
	end
end)