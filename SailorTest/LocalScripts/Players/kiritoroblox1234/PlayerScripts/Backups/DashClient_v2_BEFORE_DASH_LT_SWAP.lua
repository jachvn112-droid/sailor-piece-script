local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("UserInputService")
local v4 = game:GetService("ContextActionService")
game:GetService("RunService")
local v_u_5 = v2.LocalPlayer
local v_u_6 = v_u_5.Character or v_u_5.CharacterAdded:Wait()
local v_u_7 = v_u_6:WaitForChild("Humanoid")
local v_u_8 = v_u_6:WaitForChild("HumanoidRootPart")
local v_u_9 = require(v1:WaitForChild("DashModule"))
local v_u_10 = v1:WaitForChild("RemoteEvents"):WaitForChild("DashRemote")
local v_u_11 = require(v1:WaitForChild("Modules"):WaitForChild("SoundManager"))
local v_u_12 = v1:WaitForChild("VFXAssets"):WaitForChild("DashVFX")
local v_u_13 = {}
local function v_u_17()
	-- upvalues: (copy) v_u_13, (copy) v_u_12
	for _, v14 in ipairs(v_u_13) do
		if not v14.Parent then
			return v14
		end
	end
	if #v_u_13 >= 20 then
		return v_u_12:Clone()
	end
	local v15 = v_u_12:Clone()
	local v16 = v_u_13
	table.insert(v16, v15)
	return v15
end
local function v_u_23(p18, p19)
	-- upvalues: (copy) v_u_5, (copy) v_u_17, (copy) v_u_9
	if v_u_5:GetAttribute("DisableVFX") ~= true then
		local v_u_20 = v_u_17()
		v_u_20.CFrame = CFrame.new(p18, p18 + p19)
		v_u_20.Parent = workspace:FindFirstChild("Effects") or workspace
		for _, v21 in ipairs(v_u_20:GetDescendants()) do
			if v21:IsA("ParticleEmitter") then
				local v22 = v21:GetAttribute("EmitCount") or 10
				v21.Enabled = true
				v21:Emit(v22)
				v21.Enabled = false
			end
		end
		task.delay(v_u_9.Config.VFXDuration, function()
			-- upvalues: (copy) v_u_20
			if v_u_20 and v_u_20.Parent then
				v_u_20.Parent = nil
			end
		end)
	end
end
local v_u_24 = true
local v_u_25 = 0
local v_u_26 = 1
local v_u_27 = {}
local function v_u_35()
	-- upvalues: (ref) v_u_7, (ref) v_u_27, (copy) v_u_9
	local v28 = v_u_7:FindFirstChildOfClass("Animator")
	if not v28 then
		v28 = Instance.new("Animator")
		v28.Parent = v_u_7
	end
	v_u_27 = {}
	for v29, v30 in ipairs(v_u_9.Config.ForwardDashAnims) do
		local v31 = Instance.new("Animation")
		v31.AnimationId = "rbxassetid://" .. v30
		local v32 = v28:LoadAnimation(v31)
		v32.Priority = Enum.AnimationPriority.Action
		v32.Looped = false
		v_u_27["ForwardDash" .. v29] = v32
	end
	local v33 = Instance.new("Animation")
	v33.AnimationId = "rbxassetid://" .. v_u_9.Config.BackwardDashAnim
	local v34 = v28:LoadAnimation(v33)
	v34.Priority = Enum.AnimationPriority.Action
	v34.Looped = false
	v_u_27.BackwardDash = v34
end
local function v_u_48()
	-- upvalues: (copy) v_u_3, (ref) v_u_7, (ref) v_u_8
	local v36 = Vector3.new(0, 0, 0)
	local v37 = workspace.CurrentCamera
	if v37 then
		local v38 = v37.CFrame
		if v_u_3:IsKeyDown(Enum.KeyCode.W) then
			v36 = v36 + v38.LookVector
		end
		if v_u_3:IsKeyDown(Enum.KeyCode.S) then
			v36 = v36 - v38.LookVector
		end
		if v_u_3:IsKeyDown(Enum.KeyCode.A) then
			v36 = v36 - v38.RightVector
		end
		if v_u_3:IsKeyDown(Enum.KeyCode.D) then
			v36 = v36 + v38.RightVector
		end
	end
	if v36.Magnitude < 0.1 then
		v36 = v_u_7.MoveDirection
	end
	if v36.Magnitude < 0.1 then
		if not v_u_8 then
			return nil
		end
		local v39 = v_u_8.CFrame.LookVector
		local v40 = v39.X
		local v41 = v39.Z
		return Vector3.new(v40, 0, v41).Unit
	end
	local v42 = v36.X
	local v43 = v36.Z
	local v44 = Vector3.new(v42, 0, v43)
	if v44.Magnitude >= 0.1 then
		return v44.Unit
	end
	if not v_u_8 then
		return nil
	end
	local v45 = v_u_8.CFrame.LookVector
	local v46 = v45.X
	local v47 = v45.Z
	return Vector3.new(v46, 0, v47).Unit
end
local function v_u_61(p49, p50)
	-- upvalues: (ref) v_u_8, (ref) v_u_7, (copy) v_u_9, (ref) v_u_6
	if v_u_8 then
		local v51 = v_u_7.FloorMaterial ~= Enum.Material.Air
		local v52 = v_u_8.AssemblyLinearVelocity
		local v53
		if v_u_9.Config.OverrideGravity and not v51 then
			v53 = v_u_9.Config.VerticalLift
		else
			v53 = v52.Y
		end
		local v_u_54 = Instance.new("BodyVelocity")
		if v_u_9.Config.OverrideGravity and not v51 then
			v_u_54.MaxForce = Vector3.new(50000, 50000, 50000)
		else
			v_u_54.MaxForce = Vector3.new(50000, 0, 50000)
		end
		v_u_54.P = 5000
		v_u_54.Velocity = p49 * v_u_9.Config.DashSpeed + Vector3.new(0, v53, 0)
		v_u_54.Parent = v_u_8
		local v_u_55
		if v51 or (not v_u_9.Config.GravityReduction or v_u_9.Config.GravityReduction <= 0) then
			v_u_55 = nil
		else
			local v56 = 0
			for _, v57 in pairs(v_u_6:GetDescendants()) do
				if v57:IsA("BasePart") then
					v56 = v56 + v57:GetMass()
				end
			end
			local v58 = v56 * workspace.Gravity * v_u_9.Config.GravityReduction
			v_u_55 = Instance.new("BodyForce")
			v_u_55.Force = Vector3.new(0, v58, 0)
			v_u_55.Parent = v_u_8
		end
		local v59 = p50 / v_u_9.Config.DashSpeed
		local v60 = v59 + 0.2
		task.delay(v59, function()
			-- upvalues: (copy) v_u_54
			if v_u_54 and v_u_54.Parent then
				v_u_54:Destroy()
			end
		end)
		task.delay(v60, function()
			-- upvalues: (ref) v_u_55
			if v_u_55 and v_u_55.Parent then
				v_u_55:Destroy()
			end
		end)
	end
end
local function v_u_69()
	-- upvalues: (ref) v_u_24, (ref) v_u_7, (ref) v_u_25, (copy) v_u_9, (copy) v_u_48, (ref) v_u_6, (ref) v_u_27, (ref) v_u_26, (copy) v_u_23, (ref) v_u_8, (copy) v_u_11, (copy) v_u_61, (copy) v_u_10
	if v_u_24 then
		if v_u_7 and v_u_7.Health > 0 then
			local v62 = tick()
			if v62 - v_u_25 < v_u_9.Config.DashCooldown then
				return
			else
				local v63 = v_u_48()
				if v63 then
					local v64 = v_u_9.IsBackwardDash(v_u_6, v63)
					local v65, v66 = v_u_9.CheckDashPath(v_u_6, v63, v_u_9.Config.DashDistance)
					if v65 and v66 > 0 then
						v_u_24 = false
						v_u_25 = v62
						local v67
						if v64 then
							v67 = v_u_27.BackwardDash
						else
							v67 = v_u_27["ForwardDash" .. v_u_26]
							v_u_26 = v_u_26 == 1 and 2 or 1
						end
						if v67 then
							local v68 = v_u_9.CalculateAnimationSpeed(v_u_9.Config.DashSpeed)
							v67:Play(0.1)
							v67:AdjustSpeed(v68)
						end
						v_u_23(v_u_8.Position, v63)
						v_u_11:Play("Dash")
						v_u_61(v63, v66)
						v_u_10:FireServer(v63, v66, v64)
						task.delay(v_u_9.Config.DashCooldown, function()
							-- upvalues: (ref) v_u_24
							v_u_24 = true
						end)
					end
				else
					return
				end
			end
		else
			return
		end
	else
		return
	end
end
v_u_10.OnClientEvent:Connect(function(p70, p71, p72, p73)
	-- upvalues: (copy) v_u_5, (copy) v_u_23, (ref) v_u_8, (copy) v_u_11, (copy) v_u_9
	if p70 == "ReplicateDash" then
		if p71 and p71.Character then
			if v_u_5:GetAttribute("DisableOtherVFX") then
				return
			else
				local v74 = p71.Character
				local v75 = v74:FindFirstChild("Humanoid")
				local v76 = v74:FindFirstChild("HumanoidRootPart")
				if v75 and v76 then
					if typeof(p72) == "Vector3" and p72.Magnitude > 0.1 then
						v_u_23(v76.Position, p72.Unit)
					end
					local v77 = v76.Position
					local v78 = v_u_8
					if v78 then
						local v79 = (v78.Position - v77).Magnitude
						if v79 <= 75 then
							local v80 = 1 - v79 / 75
							v_u_11:Play("Dash", (math.clamp(v80, 0.1, 1)))
						end
					end
					local v81 = v75:FindFirstChildOfClass("Animator")
					local v82 = v81 and (p73 and v_u_9.Config.BackwardDashAnim or v_u_9.Config.ForwardDashAnims[1])
					if v82 then
						local v83 = Instance.new("Animation")
						v83.AnimationId = "rbxassetid://" .. v82
						local v_u_84 = v81:LoadAnimation(v83)
						v_u_84.Priority = Enum.AnimationPriority.Action
						local v85 = v_u_9.CalculateAnimationSpeed(v_u_9.Config.DashSpeed)
						v_u_84:Play()
						v_u_84:AdjustSpeed(v85)
						task.delay(1, function()
							-- upvalues: (copy) v_u_84
							if v_u_84 then
								v_u_84:Stop()
								v_u_84:Destroy()
							end
						end)
					end
				end
			end
		else
			return
		end
	else
		return
	end
end)
v1:WaitForChild("RemoteEvents"):WaitForChild("NPCDashRemote").OnClientEvent:Connect(function(p86, p87, p88, p89)
	-- upvalues: (copy) v_u_23, (ref) v_u_8, (copy) v_u_11, (copy) v_u_9
	if p86 and p86.Parent then
		local v90 = p86:FindFirstChild("Humanoid")
		local v91 = p86:FindFirstChild("HumanoidRootPart")
		if v90 and v91 then
			if typeof(p87) == "Vector3" and p87.Magnitude > 0.1 then
				v_u_23(v91.Position, p87.Unit)
			end
			local v92 = v91.Position
			local v93 = v_u_8
			if v93 then
				local v94 = (v93.Position - v92).Magnitude
				if v94 <= 75 then
					local v95 = 1 - v94 / 75
					v_u_11:Play("Dash", (math.clamp(v95, 0.1, 1)))
				end
			end
			local v96 = v90:FindFirstChildOfClass("Animator")
			if not v96 then
				v96 = Instance.new("Animator")
				v96.Parent = v90
			end
			local v97 = p88 and v_u_9.Config.BackwardDashAnim or v_u_9.Config.ForwardDashAnims[1]
			if v97 then
				local v98 = Instance.new("Animation")
				v98.AnimationId = "rbxassetid://" .. v97
				local v_u_99 = v96:LoadAnimation(v98)
				v_u_99:Play()
				v_u_99:AdjustSpeed(v_u_9.CalculateAnimationSpeed(p89 or v_u_9.Config.NPCDashSpeed))
				task.delay(1, function()
					-- upvalues: (copy) v_u_99
					if v_u_99 then
						v_u_99:Stop()
						v_u_99:Destroy()
					end
				end)
			end
		end
	else
		return
	end
end)
v_u_3.InputBegan:Connect(function(p100, p101)
	-- upvalues: (copy) v_u_69
	if not p101 then
		if p100.KeyCode == Enum.KeyCode.Q then
			v_u_69()
		end
	end
end)
v4:BindAction("GamepadDash", function(_, p102, _)
	-- upvalues: (copy) v_u_69
	if p102 == Enum.UserInputState.Begin then
		v_u_69()
	end
	return Enum.ContextActionResult.Pass
end, false, Enum.KeyCode.DPadUp)
local v103 = v1:WaitForChild("RemoteEvents"):WaitForChild("DashTrigger", 10)
if v103 then
	v103.Event:Connect(function()
		-- upvalues: (copy) v_u_69
		v_u_69()
	end)
end
v_u_5.CharacterAdded:Connect(function(p104)
	-- upvalues: (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_24, (ref) v_u_25, (ref) v_u_26, (copy) v_u_35
	v_u_6 = p104
	v_u_7 = v_u_6:WaitForChild("Humanoid")
	v_u_8 = v_u_6:WaitForChild("HumanoidRootPart")
	v_u_24 = true
	v_u_25 = 0
	v_u_26 = 1
	v_u_35()
end)
v_u_35()