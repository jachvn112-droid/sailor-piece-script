local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = v2.LocalPlayer
local v_u_5 = require(v1:WaitForChild("MultiJumpModule"))
local v_u_6 = v1:WaitForChild("RemoteEvents"):WaitForChild("MultiJumpRemote")
require(v1:WaitForChild("Modules"):WaitForChild("SoundManager"))
local v_u_7 = require(v1:WaitForChild("VFXModule"))
v_u_7:InitializePool("MultiJump", (v1:WaitForChild("VFXAssets"):WaitForChild("MultipleJumpVFX")))
local v8 = game:GetService("SoundService")
local v9 = game:GetService("ContentProvider")
local v_u_10 = {}
local v_u_11 = 1
for v12 = 1, 3 do
	local v13 = Instance.new("Sound")
	v13.SoundId = "rbxassetid://113971697134227"
	v13.Volume = 0.75
	v13.Parent = v8
	v_u_10[v12] = v13
end
v9:PreloadAsync(v_u_10)
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = 0
local v_u_19 = 0
local v_u_20 = false
local v_u_21 = nil
local v_u_22 = nil
local function v44(p23)
	-- upvalues: (ref) v_u_21, (ref) v_u_22, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (copy) v_u_5, (ref) v_u_17, (copy) v_u_3, (copy) v_u_4, (copy) v_u_10, (ref) v_u_11, (copy) v_u_7, (copy) v_u_6
	if v_u_21 then
		v_u_21:Disconnect()
	end
	if v_u_22 then
		v_u_22:Disconnect()
	end
	v_u_18 = 0
	v_u_19 = 0
	v_u_20 = false
	v_u_14 = p23
	v_u_15 = v_u_14:WaitForChild("Humanoid")
	v_u_16 = v_u_14:WaitForChild("HumanoidRootPart")
	local v24 = v_u_15:FindFirstChildOfClass("Animator")
	if not v24 then
		v24 = Instance.new("Animator")
		v24.Parent = v_u_15
	end
	local v25 = Instance.new("Animation")
	v25.AnimationId = "rbxassetid://" .. v_u_5.Config.JumpAnimationId
	v_u_17 = v24:LoadAnimation(v25)
	v_u_17.Looped = false
	v_u_17.Priority = Enum.AnimationPriority.Action
	v_u_21 = v_u_15.StateChanged:Connect(function(_, p26)
		-- upvalues: (ref) v_u_18, (ref) v_u_20, (ref) v_u_19
		if p26 == Enum.HumanoidStateType.Landed or (p26 == Enum.HumanoidStateType.Running or p26 == Enum.HumanoidStateType.Climbing) then
			v_u_18 = 0
			v_u_20 = false
			return
		elseif p26 == Enum.HumanoidStateType.Jumping then
			v_u_20 = true
			v_u_19 = tick()
		elseif p26 == Enum.HumanoidStateType.Freefall then
			v_u_20 = true
		end
	end)
	v_u_22 = v_u_3.JumpRequest:Connect(function()
		-- upvalues: (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_20, (ref) v_u_5, (ref) v_u_19, (ref) v_u_18, (ref) v_u_4, (ref) v_u_17, (ref) v_u_10, (ref) v_u_11, (ref) v_u_7, (ref) v_u_6
		if v_u_14 and (v_u_15 and v_u_16) then
			local v27 = v_u_15:GetState()
			if v27 == Enum.HumanoidStateType.Dead or (v27 == Enum.HumanoidStateType.Seated or v27 == Enum.HumanoidStateType.Swimming) then
				return
			elseif v_u_20 then
				local v28 = tick()
				if (v_u_5.Config.JumpCooldown or 0.25) > v28 - v_u_19 then
					return
				elseif v_u_18 < v_u_5:GetMaxJumps(v_u_4) then
					v_u_19 = v28
					v_u_18 = v_u_18 + 1
					local v29 = v_u_5:GetJumpPower(v_u_4)
					local v30 = v_u_5.Config.HorizontalBoost or 0
					local v31 = v_u_16.AssemblyLinearVelocity
					local v32 = v31.X
					local v33 = v31.Z
					local v34 = Vector3.new(v32, 0, v33)
					local v35 = v34.Magnitude
					local v36
					if v35 > 1 and v30 > 0 then
						local v37 = v34 / v35 * v30
						local v38 = v31.X + v37.X
						local v39 = v31.Z + v37.Z
						v36 = Vector3.new(v38, v29, v39)
					else
						local v40 = v31.X
						local v41 = v31.Z
						v36 = Vector3.new(v40, v29, v41)
					end
					v_u_16.AssemblyLinearVelocity = v36
					if v_u_17 then
						v_u_17:Play(v_u_5.Config.AnimationFadeTime)
					end
					local v42 = v_u_10[v_u_11]
					v_u_11 = v_u_11 % 3 + 1
					if v42.IsPlaying then
						v42:Stop()
					end
					v42:Play()
					local v43 = v_u_16.Position
					if v_u_4:GetAttribute("DisableVFX") ~= true then
						v_u_7:SpawnHitEffect(v43, nil, "MultiJump")
					end
					v_u_6:FireServer(v_u_18, v_u_16.Position)
				end
			else
				return
			end
		else
			return
		end
	end)
end
v_u_6.OnClientEvent:Connect(function(p45, p46, p47)
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_5
	if p45 == "ReplicateJump" and (p46 and p46 ~= v_u_4) then
		if v_u_4:GetAttribute("DisableOtherVFX") then
			return
		else
			local v48 = p46.Character
			if v48 then
				if typeof(p47) == "Vector3" and v_u_4:GetAttribute("DisableVFX") ~= true then
					v_u_7:SpawnHitEffect(p47, nil, "MultiJump")
				end
				local v49 = v48:FindFirstChild("Humanoid")
				if v49 then
					local v50 = v49:FindFirstChildOfClass("Animator")
					if not v50 then
						v50 = Instance.new("Animator")
						v50.Parent = v49
					end
					local v51 = Instance.new("Animation")
					v51.AnimationId = "rbxassetid://" .. v_u_5.Config.JumpAnimationId
					local v_u_52 = v50:LoadAnimation(v51)
					v_u_52.Priority = Enum.AnimationPriority.Action
					v_u_52:Play()
					task.delay(1, function()
						-- upvalues: (copy) v_u_52
						if v_u_52 then
							v_u_52:Stop()
							v_u_52:Destroy()
						end
					end)
				end
			end
		end
	else
		return
	end
end)
v_u_4.CharacterAdded:Connect(v44)
if v_u_4.Character then
	v44(v_u_4.Character)
end