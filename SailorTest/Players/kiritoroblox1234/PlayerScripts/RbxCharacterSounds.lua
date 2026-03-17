local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("SoundService")
local v_u_4 = "UserSoundsUseRelativeVelocity2"
local v5, v6 = pcall(function()
	-- upvalues: (copy) v_u_4
	return UserSettings():IsUserFeatureEnabled(v_u_4)
end)
local v_u_7 = v5 and v6
local v_u_8 = "UserNewCharacterSoundsApi3"
local v9, v10 = pcall(function()
	-- upvalues: (copy) v_u_8
	return UserSettings():IsUserFeatureEnabled(v_u_8)
end)
local v_u_11 = v9 and v10
local v_u_12 = "UserFixCharSoundsEmitters"
local v13, v14 = pcall(function()
	-- upvalues: (copy) v_u_12
	return UserSettings():IsUserFeatureEnabled(v_u_12)
end)
local v_u_15 = v13 and v14
local v_u_16 = {
	["Climbing"] = {
		["SoundId"] = "rbxasset://sounds/action_footsteps_plastic.mp3",
		["Looped"] = true
	},
	["Died"] = {
		["SoundId"] = "rbxasset://sounds/uuhhh.mp3"
	},
	["FreeFalling"] = {
		["SoundId"] = "rbxasset://sounds/action_falling.ogg",
		["Looped"] = true
	},
	["GettingUp"] = {
		["SoundId"] = "rbxasset://sounds/action_get_up.mp3"
	},
	["Jumping"] = {
		["SoundId"] = "rbxasset://sounds/action_jump.mp3"
	},
	["Landing"] = {
		["SoundId"] = "rbxasset://sounds/action_jump_land.mp3"
	},
	["Running"] = {
		["SoundId"] = "rbxasset://sounds/action_footsteps_plastic.mp3",
		["Looped"] = true,
		["Pitch"] = 1.85
	},
	["Splash"] = {
		["SoundId"] = "rbxasset://sounds/impact_water.mp3"
	},
	["Swimming"] = {
		["SoundId"] = "rbxasset://sounds/action_swim.mp3",
		["Looped"] = true,
		["Pitch"] = 1.6
	}
}
local v_u_17 = {
	["Climbing"] = {
		["AssetId"] = "rbxasset://sounds/action_footsteps_plastic.mp3",
		["Looping"] = true
	},
	["Died"] = {
		["AssetId"] = "rbxasset://sounds/uuhhh.mp3"
	},
	["FreeFalling"] = {
		["AssetId"] = "rbxasset://sounds/action_falling.ogg",
		["Looping"] = true
	},
	["GettingUp"] = {
		["AssetId"] = "rbxasset://sounds/action_get_up.mp3"
	},
	["Jumping"] = {
		["AssetId"] = "rbxasset://sounds/action_jump.mp3"
	},
	["Landing"] = {
		["AssetId"] = "rbxasset://sounds/action_jump_land.mp3"
	},
	["Running"] = {
		["AssetId"] = "rbxasset://sounds/action_footsteps_plastic.mp3",
		["Looping"] = true,
		["PlaybackSpeed"] = 1.85
	},
	["Splash"] = {
		["AssetId"] = "rbxasset://sounds/impact_water.mp3"
	},
	["Swimming"] = {
		["AssetId"] = "rbxasset://sounds/action_swim.mp3",
		["Looping"] = true,
		["PlaybackSpeed"] = 1.6
	}
}
local function v_u_21(p18, p19)
	if p18 then
		local v20 = p18.ActiveController and (not (p18.ActiveController:IsA("GroundController") and p18.GroundSensor) and p18.ActiveController:IsA("ClimbController"))
		if v20 then
			v20 = p18.ClimbSensor
		end
		if v20 and v20.SensedPart then
			return p19 - v20.SensedPart:GetVelocityAtPosition(p18.RootPart.Position)
		else
			return p19
		end
	else
		return p19
	end
end
local v_u_98 = require(script:WaitForChild("AtomicBinding")).new({
	["humanoid"] = "Humanoid",
	["rootPart"] = "HumanoidRootPart"
}, function(p22)
	-- upvalues: (copy) v_u_7, (copy) v_u_11, (copy) v_u_3, (copy) v_u_15, (copy) v_u_1, (copy) v_u_17, (copy) v_u_16, (copy) v_u_21, (copy) v_u_2
	local v_u_23 = p22.humanoid
	local v_u_24 = p22.rootPart
	local v_u_25
	if v_u_7 then
		v_u_25 = v_u_23.Parent:FindFirstChild("ControllerManager")
	else
		v_u_25 = nil
	end
	local v_u_26 = {}
	if v_u_11 and v_u_3.CharacterSoundsUseNewApi == Enum.RolloutState.Enabled then
		local v27 = nil
		local v28 = nil
		if v_u_15 then
			v28 = v_u_23.RootPart
		else
			v27 = v_u_1.LocalPlayer.Character
		end
		local v29 = 5
		local v30 = {}
		while v29 < 150 do
			v30[v29] = 5 / v29
			v29 = v29 * 1.25
		end
		v30[150] = 0
		local v31
		if v_u_15 then
			v31 = Instance.new("AudioEmitter", v28)
		else
			v31 = Instance.new("AudioEmitter", v27)
		end
		v31.Name = "RbxCharacterSoundsEmitter"
		v31:SetDistanceAttenuation(v30)
		for v32, v33 in pairs(v_u_17) do
			local v34 = Instance.new("AudioPlayer")
			local v35 = Instance.new("Wire")
			v34.Name = v32
			v35.Name = v32 .. "Wire"
			v34.Archivable = false
			v34.Volume = 0.65
			for v36, v37 in pairs(v33) do
				v34[v36] = v37
			end
			v34.Parent = v_u_24
			v35.Parent = v34
			v35.SourceInstance = v34
			v35.TargetInstance = v31
			v_u_26[v32] = v34
		end
	else
		for v38, v39 in pairs(v_u_16) do
			local v40 = Instance.new("Sound")
			v40.Name = v38
			v40.Archivable = false
			v40.RollOffMinDistance = 5
			v40.RollOffMaxDistance = 150
			v40.Volume = 0.65
			for v41, v42 in pairs(v39) do
				v40[v41] = v42
			end
			v40.Parent = v_u_24
			v_u_26[v38] = v40
		end
	end
	local v_u_43 = {}
	local function v_u_52(p44)
		-- upvalues: (copy) v_u_43, (ref) v_u_11
		local v45 = pairs
		local v46 = v_u_43
		local v47 = {}
		local v48 = p44 or nil
		for v49, v50 in pairs(v46) do
			v47[v49] = v50
		end
		for v51 in v45(v47) do
			if v51 ~= v48 then
				if v_u_11 and v51:IsA("AudioPlayer") then
					v51:Stop()
				else
					v51.Playing = false
				end
				v_u_43[v51] = nil
			end
		end
	end
	local v_u_73 = {
		[Enum.HumanoidStateType.FallingDown] = function()
			-- upvalues: (copy) v_u_52
			v_u_52()
		end,
		[Enum.HumanoidStateType.GettingUp] = function()
			-- upvalues: (copy) v_u_52, (copy) v_u_26, (ref) v_u_11
			v_u_52()
			local v53 = v_u_26.GettingUp
			v53.TimePosition = 0
			if v_u_11 and v53:IsA("AudioPlayer") then
				v53:Play()
			else
				v53.Playing = true
			end
		end,
		[Enum.HumanoidStateType.Jumping] = function()
			-- upvalues: (copy) v_u_52, (copy) v_u_26, (ref) v_u_11
			v_u_52()
			local v54 = v_u_26.Jumping
			v54.TimePosition = 0
			if v_u_11 and v54:IsA("AudioPlayer") then
				v54:Play()
			else
				v54.Playing = true
			end
		end,
		[Enum.HumanoidStateType.Swimming] = function()
			-- upvalues: (copy) v_u_24, (copy) v_u_26, (ref) v_u_11, (copy) v_u_52, (copy) v_u_43
			local v55 = v_u_24.AssemblyLinearVelocity.Y
			local v56 = math.abs(v55)
			if v56 > 0.1 then
				local v57 = v_u_26.Splash
				local v58 = (v56 - 100) * 0.72 / 250 + 0.28
				v57.Volume = math.clamp(v58, 0, 1)
				local v59 = v_u_26.Splash
				v59.TimePosition = 0
				if v_u_11 and v59:IsA("AudioPlayer") then
					v59:Play()
				else
					v59.Playing = true
				end
			end
			v_u_52(v_u_26.Swimming)
			local v60 = v_u_26.Swimming
			if v_u_11 and v60:IsA("AudioPlayer") then
				v60:Play()
			else
				v60.Playing = true
			end
			v_u_43[v_u_26.Swimming] = true
		end,
		[Enum.HumanoidStateType.Freefall] = function()
			-- upvalues: (copy) v_u_26, (copy) v_u_52, (ref) v_u_11, (copy) v_u_43
			v_u_26.FreeFalling.Volume = 0
			v_u_52(v_u_26.FreeFalling)
			local v61 = v_u_26.FreeFalling
			if v_u_11 and v61:IsA("AudioPlayer") then
				v61.Looping = true
			else
				v61.Looped = true
			end
			if v_u_26.FreeFalling:IsA("Sound") then
				v_u_26.FreeFalling.PlaybackRegionsEnabled = true
			end
			v_u_26.FreeFalling.LoopRegion = NumberRange.new(2, 9)
			local v62 = v_u_26.FreeFalling
			v62.TimePosition = 0
			if v_u_11 and v62:IsA("AudioPlayer") then
				v62:Play()
			else
				v62.Playing = true
			end
			v_u_43[v_u_26.FreeFalling] = true
		end,
		[Enum.HumanoidStateType.Landed] = function()
			-- upvalues: (copy) v_u_52, (copy) v_u_24, (copy) v_u_26, (ref) v_u_11
			v_u_52()
			local v63 = v_u_24.AssemblyLinearVelocity.Y
			local v64 = math.abs(v63)
			if v64 > 75 then
				local v65 = v_u_26.Landing
				local v66 = (v64 - 50) * 1 / 50 + 0
				v65.Volume = math.clamp(v66, 0, 1)
				local v67 = v_u_26.Landing
				v67.TimePosition = 0
				if v_u_11 and v67:IsA("AudioPlayer") then
					v67:Play()
					return
				end
				v67.Playing = true
			end
		end,
		[Enum.HumanoidStateType.Running] = function()
			-- upvalues: (copy) v_u_52, (copy) v_u_26, (ref) v_u_11, (copy) v_u_43
			v_u_52(v_u_26.Running)
			local v68 = v_u_26.Running
			if v_u_11 and v68:IsA("AudioPlayer") then
				v68:Play()
			else
				v68.Playing = true
			end
			v_u_43[v_u_26.Running] = true
		end,
		[Enum.HumanoidStateType.Climbing] = function()
			-- upvalues: (copy) v_u_26, (copy) v_u_24, (ref) v_u_7, (ref) v_u_21, (ref) v_u_25, (ref) v_u_11, (copy) v_u_52, (copy) v_u_43
			local v69 = v_u_26.Climbing
			local v70 = v_u_24.AssemblyLinearVelocity
			if v_u_7 then
				v70 = v_u_21(v_u_25, v70)
			end
			local v71 = v70.Y
			if math.abs(v71) > 0.1 then
				if v_u_11 and v69:IsA("AudioPlayer") then
					v69:Play()
				else
					v69.Playing = true
				end
				v_u_52(v69)
			else
				v_u_52()
			end
			v_u_43[v69] = true
		end,
		[Enum.HumanoidStateType.Seated] = function()
			-- upvalues: (copy) v_u_52
			v_u_52()
		end,
		[Enum.HumanoidStateType.Dead] = function()
			-- upvalues: (copy) v_u_52, (copy) v_u_26, (ref) v_u_11
			v_u_52()
			local v72 = v_u_26.Died
			v72.TimePosition = 0
			if v_u_11 and v72:IsA("AudioPlayer") then
				v72:Play()
			else
				v72.Playing = true
			end
		end
	}
	local v_u_84 = {
		[v_u_26.Climbing] = function(_, p74, p75)
			-- upvalues: (ref) v_u_7, (ref) v_u_21, (ref) v_u_25, (ref) v_u_11
			if v_u_7 then
				p75 = v_u_21(v_u_25, p75)
			end
			local v76 = p75.Magnitude > 0.1
			if v_u_11 and p74:IsA("AudioPlayer") then
				if p74.IsPlaying and not v76 then
					p74:Stop()
					return
				end
				if not p74.IsPlaying and v76 then
					p74:Play()
					return
				end
			else
				p74.Playing = v76
			end
		end,
		[v_u_26.FreeFalling] = function(p77, p78, p79)
			if p79.Magnitude > 75 then
				local v80 = p78.Volume + p77 * 0.9
				p78.Volume = math.clamp(v80, 0, 1)
			else
				p78.Volume = 0
			end
		end,
		[v_u_26.Running] = function(_, p81, p82)
			-- upvalues: (copy) v_u_23, (ref) v_u_11
			local v83
			if p82.Magnitude > 0.5 then
				v83 = v_u_23.MoveDirection.Magnitude > 0.5
			else
				v83 = false
			end
			if v_u_11 and p81:IsA("AudioPlayer") then
				if p81.IsPlaying and not v83 then
					p81:Stop()
					return
				end
				if not p81.IsPlaying and v83 then
					p81:Play()
					return
				end
			else
				p81.Playing = v83
			end
		end
	}
	local v_u_85 = {
		[Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
	}
	local v_u_86 = v_u_85[v_u_23:GetState()] or v_u_23:GetState()
	local v87 = v_u_86
	local v88 = v_u_73[v87]
	if v88 then
		v88()
	end
	v_u_86 = v87
	local v_u_92 = v_u_23.StateChanged:Connect(function(_, p89)
		-- upvalues: (copy) v_u_85, (ref) v_u_86, (copy) v_u_73
		local v90 = v_u_85[p89] or p89
		if v90 ~= v_u_86 then
			local v91 = v_u_73[v90]
			if v91 then
				v91()
			end
			v_u_86 = v90
		end
	end)
	local v_u_96 = v_u_2.Stepped:Connect(function(_, p93)
		-- upvalues: (copy) v_u_43, (copy) v_u_84, (copy) v_u_24
		for v94 in pairs(v_u_43) do
			local v95 = v_u_84[v94]
			if v95 then
				v95(p93, v94, v_u_24.AssemblyLinearVelocity)
			end
		end
	end)
	return function()
		-- upvalues: (copy) v_u_92, (copy) v_u_96, (copy) v_u_26
		v_u_92:Disconnect()
		v_u_96:Disconnect()
		for _, v97 in pairs(v_u_26) do
			v97:Destroy()
		end
		table.clear(v_u_26)
	end
end)
local v_u_99 = {}
local function v_u_101(p100)
	-- upvalues: (copy) v_u_98
	v_u_98:bindRoot(p100)
end
local function v_u_103(p102)
	-- upvalues: (copy) v_u_98
	v_u_98:unbindRoot(p102)
end
local function v110(p104)
	-- upvalues: (copy) v_u_99, (copy) v_u_98, (copy) v_u_101, (copy) v_u_103
	local v105 = v_u_99[p104]
	if not v105 then
		v105 = {}
		v_u_99[p104] = v105
	end
	if p104.Character then
		v_u_98:bindRoot(p104.Character)
	end
	local v106 = p104.CharacterAdded
	local v107 = v_u_101
	table.insert(v105, v106:Connect(v107))
	local v108 = p104.CharacterRemoving
	local v109 = v_u_103
	table.insert(v105, v108:Connect(v109))
end
local function v114(p111)
	-- upvalues: (copy) v_u_99, (copy) v_u_98
	local v112 = v_u_99[p111]
	if v112 then
		for _, v113 in ipairs(v112) do
			v113:Disconnect()
		end
		v_u_99[p111] = nil
	end
	if p111.Character then
		v_u_98:unbindRoot(p111.Character)
	end
end
for _, v115 in ipairs(v_u_1:GetPlayers()) do
	task.spawn(v110, v115)
end
v_u_1.PlayerAdded:Connect(v110)
v_u_1.PlayerRemoving:Connect(v114)