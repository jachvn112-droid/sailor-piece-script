local v_u_1 = script.Parent
local v2 = game:GetService("Players").LocalPlayer
local v3 = game:GetService("ReplicatedStorage")
local v4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("RunService")
game:GetService("TweenService")
game:GetService("Debris");
(function()
	local v6 = tick()
	while not _G.AssetsDownloaded and tick() - v6 <= 8 do
		task.wait(0.03)
	end
	while not _G.AnimationsPreloaded and tick() - v6 <= 10 do
		task.wait(0.03)
	end
end)()
local v7 = v3:WaitForChild("CombatSystem")
local v_u_8 = require(v7:WaitForChild("CombatConfig"))
local v_u_9 = require(v3:WaitForChild("CombatModule"))
local v_u_10 = require(v3:WaitForChild("HitboxVisualizer"))
local v_u_11 = require(v3:WaitForChild("PlayerAnimationController"))
local v_u_12 = v3:WaitForChild("RemoteEvents"):WaitForChild("CombatRemote")
local v13 = v3:WaitForChild("Remotes"):WaitForChild("ForceWeaponCleanup")
local v_u_14 = v2.Character or v2.CharacterAdded:Wait()
local v_u_15 = v_u_14:WaitForChild("Humanoid")
local v_u_16 = v_u_14:WaitForChild("HumanoidRootPart")
local v_u_17 = v_u_15:WaitForChild("Animator")
local v_u_18 = {}
local v_u_19 = nil
local v_u_20 = 0
local v_u_21 = 0
local v_u_22 = false
_G.CombatActive = false
local v_u_23 = nil
local v_u_24 = false
local v_u_25 = nil
local v_u_26 = nil
local function v_u_29()
	-- upvalues: (copy) v_u_11, (ref) v_u_26
	local v27, v28 = pcall(function()
		-- upvalues: (ref) v_u_11
		return v_u_11.getLocalController()
	end)
	if v27 and (v28 and type(v28) == "table") then
		v_u_26 = v28
		pcall(function()
			-- upvalues: (ref) v_u_26
			v_u_26:stop("Idle", 0.1)
		end)
	end
end
local function v_u_41()
	-- upvalues: (copy) v_u_18, (copy) v_u_8, (copy) v_u_17, (ref) v_u_19
	if #v_u_18 > 0 then
		return
	else
		local v30 = v_u_8.GetAnimationConfig("Combat")
		if v30 then
			for v31 = 1, 4 do
				local v32 = v_u_18
				local v33 = v30["Punch" .. v31]
				local v34 = v_u_8.AnimationPriorities.CombatAction
				local v35 = _G.PreloadedAnimationTracks
				if v35 then
					v35 = _G.PreloadedAnimationTracks[v33]
				end
				if v35 then
					v35.Priority = v34
					v35.Looped = false
				else
					local v36 = Instance.new("Animation")
					v36.AnimationId = "rbxassetid://" .. v33
					v35 = v_u_17:LoadAnimation(v36)
					v35.Priority = v34
					v35.Looped = false
				end
				v32[v31] = v35
			end
			local v37 = v30.CombatIdle
			local v38 = Enum.AnimationPriority.Movement
			local v39 = _G.PreloadedAnimationTracks
			if v39 then
				v39 = _G.PreloadedAnimationTracks[v37]
			end
			if v39 then
				v39.Priority = v38
				v39.Looped = true
			else
				local v40 = Instance.new("Animation")
				v40.AnimationId = "rbxassetid://" .. v37
				v39 = v_u_17:LoadAnimation(v40)
				v39.Priority = v38
				v39.Looped = true
			end
			v_u_19 = v39
		end
	end
end
local function v_u_47()
	-- upvalues: (ref) v_u_24, (ref) v_u_19, (ref) v_u_22, (copy) v_u_16, (copy) v_u_15, (copy) v_u_8
	if not (v_u_24 and v_u_19) then
		return
	end
	if v_u_22 then
		return
	end
	local v42 = v_u_16.AssemblyLinearVelocity.Magnitude
	local v43 = v_u_15:GetState()
	local v44 = {
		Enum.HumanoidStateType.Freefall,
		Enum.HumanoidStateType.Flying,
		Enum.HumanoidStateType.Climbing,
		Enum.HumanoidStateType.Swimming,
		Enum.HumanoidStateType.Dead,
		Enum.HumanoidStateType.PlatformStanding
	}
	local v45 = false
	for _, v46 in ipairs(v44) do
		if v43 == v46 then
			v45 = true
			break
		end
	end
	if v42 <= v_u_8.IDLE_VELOCITY_THRESHOLD and not v45 then
		if not v_u_19.IsPlaying then
			v_u_19:Play(0.2)
			return
		end
	elseif v_u_19.IsPlaying then
		v_u_19:Stop(0.15)
	end
end
local function v_u_55()
	-- upvalues: (copy) v_u_8, (ref) v_u_21, (ref) v_u_22, (ref) v_u_20, (ref) v_u_19, (copy) v_u_18, (copy) v_u_12, (copy) v_u_9, (copy) v_u_14, (copy) v_u_10, (copy) v_u_47, (ref) v_u_23
	local v48 = tick()
	local v49 = v_u_8.GetAttackConfig("Punch")
	if v48 - v_u_21 < v49.Cooldown then
		return
	elseif v_u_22 then
		return
	elseif not _G.AbilityActive then
		v_u_22 = true
		_G.CombatActive = true
		v_u_21 = v48
		v_u_20 = v_u_20 % 4 + 1
		if v_u_19 and v_u_19.IsPlaying then
			v_u_19:Stop(0.1)
		end
		local v50 = v_u_18[v_u_20]
		if v50 then
			for v51, v52 in ipairs(v_u_18) do
				if v51 ~= v_u_20 and v52.IsPlaying then
					v52:Stop(v49.FadeTime)
				end
			end
			v50:Play(v49.FadeTime)
			v_u_12:FireServer("PunchTrack")
			local v53 = v_u_9.DetectTargets(v_u_14, v49)
			v_u_10.ShowCombatHitbox(v_u_14, v49, 0.25)
			for _, v54 in ipairs(v53) do
				if v_u_9.IsValidTarget(v_u_14, v54) then
					v_u_12:FireServer("Punch", v54)
				end
			end
			task.delay(v50.Length * 0.6, function()
				-- upvalues: (ref) v_u_22, (ref) v_u_47
				v_u_22 = false
				_G.CombatActive = false
				v_u_47()
			end)
		else
			v_u_22 = false
			_G.CombatActive = false
		end
		if v_u_23 then
			task.cancel(v_u_23)
		end
		v_u_23 = task.delay(v_u_8.MaxComboTime, function()
			-- upvalues: (ref) v_u_20
			v_u_20 = 0
		end)
	end
end
local function v56()
	-- upvalues: (ref) v_u_24, (copy) v_u_41, (copy) v_u_29, (ref) v_u_25, (copy) v_u_5, (copy) v_u_47
	v_u_24 = true
	v_u_41()
	v_u_29()
	if v_u_25 then
		v_u_25:Disconnect()
	end
	v_u_25 = v_u_5.Heartbeat:Connect(v_u_47)
	v_u_47()
end
local function v_u_59()
	-- upvalues: (ref) v_u_24, (ref) v_u_25, (copy) v_u_18, (ref) v_u_19, (ref) v_u_26, (ref) v_u_20, (ref) v_u_22, (ref) v_u_23
	v_u_24 = false
	if v_u_25 then
		v_u_25:Disconnect()
		v_u_25 = nil
	end
	for _, v57 in ipairs(v_u_18) do
		if v57 and v57.IsPlaying then
			v57:Stop(0.1)
		end
	end
	if v_u_19 and v_u_19.IsPlaying then
		v_u_19:Stop(0.2)
	end
	if v_u_26 then
		local v58 = v_u_26
		if type(v58) == "table" then
			task.wait(0.1)
			pcall(function()
				-- upvalues: (ref) v_u_26
				v_u_26:update()
			end)
		end
	end
	v_u_26 = nil
	v_u_20 = 0
	v_u_22 = false
	_G.CombatActive = false
	if v_u_23 then
		task.cancel(v_u_23)
		v_u_23 = nil
	end
end
v_u_1.Activated:Connect(function()
	-- upvalues: (ref) v_u_24, (copy) v_u_55
	if v_u_24 then
		v_u_55()
	end
end)
v_u_1.Equipped:Connect(v56)
v_u_1.Unequipped:Connect(v_u_59)
v_u_1.AncestryChanged:Connect(function(_, p60)
	-- upvalues: (ref) v_u_24, (copy) v_u_59
	if not p60 and v_u_24 then
		v_u_59()
	end
end)
v13.OnClientEvent:Connect(function(p61)
	-- upvalues: (ref) v_u_24, (copy) v_u_59
	if p61 == "Combat" and v_u_24 then
		v_u_59()
	end
end)
if v4.TouchEnabled then
	v4.TouchTapInWorld:Connect(function()
		-- upvalues: (copy) v_u_1, (copy) v_u_14, (ref) v_u_24, (copy) v_u_55
		if v_u_1.Parent == v_u_14 and v_u_24 then
			v_u_55()
		end
	end)
end