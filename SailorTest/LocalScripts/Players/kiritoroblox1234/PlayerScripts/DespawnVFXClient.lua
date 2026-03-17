local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("Debris")
game:GetService("TweenService")
local v4 = v1:WaitForChild("RemoteEvents")
local v5 = v1:WaitForChild("VFXAssets")
local v6 = v4:WaitForChild("DespawnVFX", 10)
if not v6 then
	v6 = Instance.new("RemoteEvent")
	v6.Name = "DespawnVFX"
	v6.Parent = v4
end
local v_u_7 = v5:WaitForChild("Despawn")
local v_u_8 = {
	["VFXDuration"] = 2.5,
	["MaxDistance"] = 300
}
local v_u_9 = v2.LocalPlayer
local v_u_10 = v_u_9.Character or v_u_9.CharacterAdded:Wait()
local function v_u_22(p11)
	-- upvalues: (copy) v_u_9, (ref) v_u_10, (copy) v_u_8, (copy) v_u_7, (copy) v_u_3
	if v_u_9:GetAttribute("DisableVFX") == true then
		return
	elseif not (v_u_10 and v_u_10:FindFirstChild("HumanoidRootPart")) and true or (v_u_10.HumanoidRootPart.Position - p11).Magnitude <= v_u_8.MaxDistance then
		local v_u_12 = v_u_7:Clone()
		if v_u_12:IsA("Model") then
			if v_u_12:FindFirstChild("mainpart") then
				v_u_12:PivotTo(CFrame.new(p11))
			end
		elseif v_u_12:IsA("BasePart") then
			v_u_12.CFrame = CFrame.new(p11)
			v_u_12.Anchored = true
			v_u_12.CanCollide = false
		end
		for _, v13 in v_u_12:GetDescendants() do
			if v13:IsA("BasePart") then
				v13.Transparency = 1
				v13.CanCollide = false
				v13.Anchored = true
			end
		end
		v_u_12.Parent = workspace
		local v_u_14 = 0
		for _, v_u_15 in v_u_12:GetDescendants() do
			if v_u_15:IsA("ParticleEmitter") then
				v_u_15.Enabled = false
				local v_u_16 = v_u_15:GetAttribute("EmitCount") or 25
				local v_u_17 = v_u_15:GetAttribute("EmitDelay") or 0
				if v_u_15 and v_u_15.Parent then
					task.spawn(function()
						-- upvalues: (copy) v_u_17, (copy) v_u_15, (copy) v_u_16
						task.wait(v_u_17 or 0.05)
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
				v_u_15:Play()
			end
		end
		task.delay(v_u_8.VFXDuration, function()
			-- upvalues: (copy) v_u_12, (ref) v_u_14
			for _, v21 in v_u_12:GetDescendants() do
				if v21:IsA("ParticleEmitter") then
					v21.Enabled = false
				elseif v21:IsA("Sound") then
					v21:Stop()
				end
			end
			task.wait(v_u_14 + 1)
			if v_u_12 and v_u_12.Parent then
				v_u_12:Destroy()
			end
		end)
		v_u_3:AddItem(v_u_12, v_u_8.VFXDuration + v_u_14 + 5)
	end
end
v6.OnClientEvent:Connect(function(p_u_23)
	-- upvalues: (copy) v_u_22
	task.spawn(function()
		-- upvalues: (ref) v_u_22, (copy) p_u_23
		v_u_22(p_u_23)
	end)
end)
v_u_9.CharacterAdded:Connect(function(p24)
	-- upvalues: (ref) v_u_10
	v_u_10 = p24
end)