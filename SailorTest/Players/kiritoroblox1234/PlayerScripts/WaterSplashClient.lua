local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1:WaitForChild("PlaceConfig"))
local v3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v5 = game:GetService("UserInputService")
local v_u_6 = v4.LocalPlayer
local v_u_7 = v_u_6.Character or v_u_6.CharacterAdded:Wait()
local v_u_8 = v_u_7:WaitForChild("Humanoid")
local v_u_9 = v_u_7:WaitForChild("HumanoidRootPart")
local v_u_10 = v_u_8:WaitForChild("Animator")
local v_u_11 = v1:WaitForChild("VFXAssets"):WaitForChild("WaterSplashVFX")
local v_u_12 = v1:WaitForChild("SwimEvent")
if not v2.IsDungeon() then
	local v13 = workspace:WaitForChild("Sea")
	local v14 = v13:WaitForChild("Mesh")
	local v15 = v13.Size.X * v14.Scale.X
	local v16 = v13.Size.Z * v14.Scale.Z
	local v_u_17 = v13.Position.Y
	local v18 = v13.Position
	local v_u_19 = v18.X - v15 / 2
	local v_u_20 = v18.X + v15 / 2
	local v_u_21 = v18.Z - v16 / 2
	local v_u_22 = v18.Z + v16 / 2
	local v_u_23 = v_u_17 + 0.5
	local v_u_24 = v_u_17 + 3.5
	local v_u_25 = Instance.new("Animation")
	v_u_25.AnimationId = "rbxassetid://98289079776164"
	local v_u_26 = v_u_10:LoadAnimation(v_u_25)
	v_u_26.Looped = true
	local v_u_27 = false
	local v_u_28 = nil
	local v_u_29 = 0
	local v_u_30 = false
	v5.JumpRequest:Connect(function()
		-- upvalues: (ref) v_u_27, (ref) v_u_30, (ref) v_u_28
		if v_u_27 and not v_u_30 then
			v_u_30 = true
			if v_u_28 then
				v_u_28.MaxForce = Vector3.new(0, 0, 0)
			end
			task.delay(0.4, function()
				-- upvalues: (ref) v_u_30
				v_u_30 = false
			end)
		end
	end)
	local v_u_31 = false
	v3.Heartbeat:Connect(function()
		-- upvalues: (copy) v_u_6, (ref) v_u_7, (ref) v_u_9, (copy) v_u_19, (copy) v_u_20, (copy) v_u_21, (copy) v_u_22, (ref) v_u_27, (copy) v_u_24, (copy) v_u_23, (ref) v_u_31, (ref) v_u_29, (copy) v_u_11, (copy) v_u_17, (ref) v_u_26, (ref) v_u_28, (copy) v_u_12, (ref) v_u_30
		if not v_u_6:GetAttribute("IsTeleporting") then
			local v32
			if v_u_7:GetAttribute("IsLightFlight") then
				v32 = false
			else
				local v33 = v_u_9.Position
				if v33.X < v_u_19 or (v_u_20 < v33.X or (v33.Z < v_u_21 or v_u_22 < v33.Z)) then
					v32 = false
				elseif v_u_27 then
					v32 = v33.Y < v_u_24
				else
					v32 = v33.Y < v_u_23
				end
			end
			if v32 ~= v_u_31 then
				if v32 then
					if not v_u_27 then
						v_u_27 = true
						local v_u_34 = v_u_9.Position
						if v_u_6:GetAttribute("DisableVFX") ~= true then
							local v35 = tick()
							if v35 - v_u_29 >= 0.5 then
								v_u_29 = v35
								pcall(function()
									-- upvalues: (ref) v_u_11, (copy) v_u_34, (ref) v_u_17
									local v_u_36 = v_u_11:Clone()
									local v37 = v_u_36:FindFirstChild("Part")
									if v37 then
										v37.CFrame = CFrame.new(v_u_34.X, v_u_17, v_u_34.Z)
										v37.Anchored = true
										v_u_36.Parent = workspace
										for _, v38 in pairs(v_u_36:GetDescendants()) do
											if v38:IsA("ParticleEmitter") then
												v38:Emit(10)
											end
										end
										task.delay(3, function()
											-- upvalues: (copy) v_u_36
											v_u_36:Destroy()
										end)
									end
								end)
							end
						end
						v_u_26:Play(0.3)
						v_u_28 = Instance.new("BodyPosition")
						v_u_28.MaxForce = Vector3.new(0, 0, 0)
						v_u_28.D = 500
						v_u_28.P = 10000
						v_u_28.Parent = v_u_9
						v_u_12:FireServer("EnterWater")
					end
				elseif v_u_27 then
					v_u_27 = false
					local v_u_39 = v_u_9.Position
					if v_u_6:GetAttribute("DisableVFX") ~= true then
						local v40 = tick()
						if v40 - v_u_29 >= 0.5 then
							v_u_29 = v40
							pcall(function()
								-- upvalues: (ref) v_u_11, (copy) v_u_39, (ref) v_u_17
								local v_u_41 = v_u_11:Clone()
								local v42 = v_u_41:FindFirstChild("Part")
								if v42 then
									v42.CFrame = CFrame.new(v_u_39.X, v_u_17, v_u_39.Z)
									v42.Anchored = true
									v_u_41.Parent = workspace
									for _, v43 in pairs(v_u_41:GetDescendants()) do
										if v43:IsA("ParticleEmitter") then
											v43:Emit(10)
										end
									end
									task.delay(3, function()
										-- upvalues: (copy) v_u_41
										v_u_41:Destroy()
									end)
								end
							end)
						end
					end
					v_u_26:Stop(0.3)
					if v_u_28 then
						v_u_28:Destroy()
						v_u_28 = nil
					end
					v_u_12:FireServer("ExitWater")
				end
				v_u_31 = v32
			end
			if v_u_27 and (v_u_28 and v_u_9.Parent) then
				local v44 = v_u_9.Position
				local v45 = v44.Y
				local v46 = v_u_17 + 1.25
				local v47 = math.max(v45, v46)
				local v48 = v_u_28
				local v49 = v44.X
				local v50 = v44.Z
				v48.Position = Vector3.new(v49, v47, v50)
				if v_u_30 then
					v_u_28.MaxForce = Vector3.new(0, 0, 0)
					return
				end
				v_u_28.MaxForce = Vector3.new(0, inf, 0)
			end
		end
	end)
	v_u_6.CharacterAdded:Connect(function(p51)
		-- upvalues: (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_10, (ref) v_u_26, (copy) v_u_25, (ref) v_u_27, (ref) v_u_28, (ref) v_u_31, (ref) v_u_30
		v_u_7 = p51
		v_u_8 = v_u_7:WaitForChild("Humanoid")
		v_u_9 = v_u_7:WaitForChild("HumanoidRootPart")
		v_u_10 = v_u_8:WaitForChild("Animator")
		v_u_26 = v_u_10:LoadAnimation(v_u_25)
		v_u_26.Looped = true
		v_u_27 = false
		v_u_28 = nil
		v_u_31 = false
		v_u_30 = false
	end)
end