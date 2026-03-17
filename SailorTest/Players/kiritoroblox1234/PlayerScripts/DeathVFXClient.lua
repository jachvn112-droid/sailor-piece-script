local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("Debris")
local v_u_4 = game:GetService("TweenService")
local v5 = v1:WaitForChild("RemoteEvents")
local v6 = v1:WaitForChild("VFXAssets")
local v_u_7 = v5:FindFirstChild("DeathVFX")
if not v_u_7 then
	v_u_7 = Instance.new("RemoteEvent")
	v_u_7.Name = "DeathVFX"
	v_u_7.Parent = v5
end
local v_u_8 = v6:WaitForChild("DeathVFX")
local v_u_9 = {
	["VFXScale"] = 1,
	["VFXDuration"] = 2,
	["MaxDistance"] = 400,
	["ParticleEmitDelay"] = 0.05
}
local v_u_10 = v2.LocalPlayer
local v_u_11 = v_u_10.Character or v_u_10.CharacterAdded:Wait()
local function v_u_25(p12)
	-- upvalues: (copy) v_u_10, (ref) v_u_11, (copy) v_u_9, (copy) v_u_8, (copy) v_u_4, (copy) v_u_3
	if v_u_10:GetAttribute("DisableVFX") == true then
		return
	elseif not (v_u_11 and v_u_11:FindFirstChild("HumanoidRootPart")) and true or (v_u_11.HumanoidRootPart.Position - p12).Magnitude <= v_u_9.MaxDistance then
		local v_u_13 = v_u_8:Clone()
		if v_u_13:IsA("BasePart") then
			v_u_13.CFrame = CFrame.new(p12)
			v_u_13.Anchored = true
			v_u_13.CanCollide = false
			if v_u_9.VFXScale ~= 1 then
				v_u_13.Size = v_u_13.Size * v_u_9.VFXScale
			end
		elseif v_u_13:IsA("Model") and v_u_13.PrimaryPart then
			v_u_13:SetPrimaryPartCFrame(CFrame.new(p12))
		end
		v_u_13.Parent = workspace
		local v_u_14 = 0
		for _, v_u_15 in ipairs(v_u_13:GetDescendants()) do
			if v_u_15:IsA("ParticleEmitter") then
				v_u_15.Enabled = false
				local v_u_16 = v_u_15:GetAttribute("EmitCount") or 30
				local v_u_17 = v_u_15:GetAttribute("EmitDelay") or 0
				if v_u_15 and v_u_15.Parent then
					task.spawn(function()
						-- upvalues: (copy) v_u_17, (ref) v_u_9, (copy) v_u_15, (copy) v_u_16
						task.wait(v_u_17 or v_u_9.ParticleEmitDelay)
						if v_u_15 and v_u_15.Parent then
							v_u_15:Emit(v_u_16 or 1)
						end
					end)
				end
				local v18 = v_u_15.Lifetime
				if typeof(v18) == "NumberRange" then
					local v19 = v18.Max
					v_u_14 = math.max(v_u_14, v19)
				else
					local v20 = tonumber(v18) or 1
					v_u_14 = math.max(v_u_14, v20)
				end
			elseif v_u_15:IsA("Sound") then
				if v_u_11 and v_u_11:FindFirstChild("HumanoidRootPart") then
					local v21 = 1 - (v_u_11.HumanoidRootPart.Position - p12).Magnitude / v_u_9.MaxDistance
					local v22 = math.max(0.1, v21)
					v_u_15.Volume = v_u_15.Volume * v22
				end
				v_u_15:Play()
			end
		end
		local function v24()
			-- upvalues: (copy) v_u_13, (ref) v_u_4, (ref) v_u_14
			for _, v23 in ipairs(v_u_13:GetDescendants()) do
				if v23:IsA("ParticleEmitter") then
					v23.Enabled = false
				elseif v23:IsA("Sound") then
					v23:Stop()
				end
			end
			if v_u_13:IsA("BasePart") then
				v_u_4:Create(v_u_13, TweenInfo.new(0.5), {
					["Transparency"] = 1
				}):Play()
			end
			task.wait(v_u_14 + 1)
			if v_u_13 and v_u_13.Parent then
				v_u_13:Destroy()
			end
		end
		task.delay(v_u_9.VFXDuration, v24)
		v_u_3:AddItem(v_u_13, v_u_9.VFXDuration + v_u_14 + 5)
	end
end
v_u_7.OnClientEvent:Connect(function(p26)
	-- upvalues: (copy) v_u_25
	if p26 and p26:FindFirstChild("HumanoidRootPart") then
		local v_u_27 = p26.HumanoidRootPart.Position
		coroutine.wrap(function()
			-- upvalues: (ref) v_u_25, (copy) v_u_27
			v_u_25(v_u_27)
		end)()
	end
end)
local function v29(p28)
	-- upvalues: (ref) v_u_11, (ref) v_u_7
	v_u_11 = p28
	v_u_11:WaitForChild("Humanoid").Died:Connect(function()
		-- upvalues: (ref) v_u_7, (ref) v_u_11
		v_u_7:FireServer(v_u_11)
	end)
end
if v_u_10.Character then
	v_u_11 = v_u_10.Character
	v_u_11:WaitForChild("Humanoid").Died:Connect(function()
		-- upvalues: (ref) v_u_7, (ref) v_u_11
		v_u_7:FireServer(v_u_11)
	end)
end
v_u_10.CharacterAdded:Connect(v29)