local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = v2.LocalPlayer
local v4 = v2.LocalPlayer
local v_u_5 = v4.Character or v4.CharacterAdded:Wait()
local v_u_6 = v1:WaitForChild("VFXAssets"):WaitForChild("LevelUpVFX")
local function v_u_12()
	-- upvalues: (copy) v_u_3, (ref) v_u_5, (copy) v_u_6
	if v_u_3:GetAttribute("DisableVFX") == true then
		return
	elseif v_u_5 and v_u_5.Parent then
		local v7 = v_u_5:FindFirstChild("HumanoidRootPart")
		if v7 then
			local v8 = v_u_6:Clone()
			v8.CFrame = v7.CFrame
			v8.Parent = workspace
			for _, v9 in ipairs(v8:GetDescendants()) do
				if v9:IsA("ParticleEmitter") then
					v9:Emit(v9:GetAttribute("EmitCount") or 20)
				end
			end
			local v10 = v8:FindFirstChild("LevelUpVFX")
			if v10 then
				for _, v11 in ipairs(v10:GetDescendants()) do
					if v11:IsA("ParticleEmitter") then
						v11:Emit(v11:GetAttribute("EmitCount") or 20)
					end
				end
			end
			game:GetService("Debris"):AddItem(v8, 3)
		end
	else
		return
	end
end
v1:WaitForChild("RemoteEvents"):WaitForChild("LevelUp").OnClientEvent:Connect(function(_, _)
	-- upvalues: (copy) v_u_12
	v_u_12()
end)
v4.CharacterAdded:Connect(function(p13)
	-- upvalues: (ref) v_u_5
	v_u_5 = p13
end)