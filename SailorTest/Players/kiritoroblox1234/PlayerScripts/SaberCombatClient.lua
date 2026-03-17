WOAH COPY SHARING
WOAH COPY SHARING
local v_u_1 = game:GetService("Players")
local v2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("Debris")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = v_u_1.LocalPlayer
local v8 = v_u_3:WaitForChild("CombatSystem")
local v_u_9 = require(v8:WaitForChild("CombatConfig"))
local v10 = v8:WaitForChild("Remotes")
local v_u_11 = v8:WaitForChild("Animations")
local v_u_12 = v8:WaitForChild("VFX")
local v_u_13 = require(v_u_3:WaitForChild("PlayerAnimationController"))
local v_u_14 = require(v_u_3:WaitForChild("Modules"):WaitForChild("SoundManager"))
local v_u_15 = require(v_u_3:WaitForChild("Modules"):WaitForChild("VFXPreloader"))
local v_u_16 = v10.RequestHit
local v17 = v10.CombatFeedback
local v_u_18 = v10:WaitForChild("GilgameshSwingFeedback")
local v_u_19 = false
local v20 = v_u_3:FindFirstChild("AbilitySystem")
if v20 then
	local v21 = v20:FindFirstChild("Remotes")
	local v22 = v21 and v21:WaitForChild("AbilityStateChanged", 5)
	if v22 then
		v22.OnClientEvent:Connect(function(p23)
			-- upvalues: (ref) v_u_19
			v_u_19 = p23
		end)
	end
end
local v_u_24 = {
	["ComboIndex"] = 0,
	["LastHitTime"] = 0,
	["LastWeapon"] = nil,
	["CurrentTrack"] = nil,
	["CurrentWeapon"] = nil,
	["IsAttacking"] = false
}
local v_u_25 = nil
local v_u_26 = {}
local v_u_27 = {}
local v_u_28 = nil
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = nil
local v_u_44 = nil
local v_u_45 = nil
local v_u_46 = nil
local v_u_47 = nil
local v_u_48 = nil
local v_u_49 = nil
local v_u_50 = {}
local v_u_51 = 1
local v_u_52 = 1
local v_u_53 = 1
local function v_u_58()
	-- upvalues: (copy) v_u_7, (copy) v_u_9
	local v54 = v_u_7.Character
	if not v54 then
		return nil
	end
	local v55 = v54:FindFirstChildOfClass("Tool")
	if not v55 then
		return nil
	end
	for v56, v57 in pairs(v_u_9.Weapons) do
		if v57.ToolName == v55.Name then
			return v56, v57
		end
	end
	return nil
end
local function v_u_61()
	-- upvalues: (copy) v_u_13, (ref) v_u_30
	local v59, v_u_60 = pcall(function()
		-- upvalues: (ref) v_u_13
		return v_u_13.getLocalController()
	end)
	if v59 and (v_u_60 and type(v_u_60) == "table") then
		v_u_30 = v_u_60
		pcall(function()
			-- upvalues: (copy) v_u_60
			v_u_60:stop("Idle", 0.1)
		end)
	end
end
local function v_u_69(p62, p63)
	-- upvalues: (copy) v_u_7, (ref) v_u_27
	local v64 = p63.IdleAnimationId
	if p62 == "Gilgamesh" and v_u_7:GetAttribute("GilgameshFUnlocked") == true then
		v64 = p63.GilgameshFIdleAnimationId or v64
		p62 = "Gilgamesh_FIdle"
	end
	if v_u_27[p62] then
		return v_u_27[p62]
	end
	if not v64 or v64 == 0 then
		return nil
	end
	local v65 = v_u_7.Character
	if v65 then
		v65 = v65:FindFirstChild("Humanoid")
	end
	if not v65 then
		return nil
	end
	local v66 = v65:FindFirstChild("Animator")
	if not v66 then
		return nil
	end
	local v67 = Instance.new("Animation")
	v67.AnimationId = "rbxassetid://" .. v64
	local v68 = v66:LoadAnimation(v67)
	v68.Looped = true
	v68.Priority = Enum.AnimationPriority.Movement
	v_u_27[p62] = v68
	return v68
end
local function v_u_77()
	-- upvalues: (copy) v_u_58, (ref) v_u_28, (copy) v_u_24, (copy) v_u_7
	local v70, _ = v_u_58()
	if v70 and v_u_28 then
		if v_u_24.IsAttacking then
			return
		elseif v_u_7:GetAttribute("InCutscene") then
			if v_u_28 and v_u_28.IsPlaying then
				v_u_28:Stop(0)
			end
			return
		else
			local v71 = v_u_7.Character
			local v72
			if v71 then
				v72 = v71:FindFirstChild("HumanoidRootPart")
			else
				v72 = v71
			end
			if v71 then
				v71 = v71:FindFirstChild("Humanoid")
			end
			if v72 and v71 then
				local v73 = v72.AssemblyLinearVelocity.Magnitude
				local v74 = v71:GetState()
				local v75 = {
					Enum.HumanoidStateType.Freefall,
					Enum.HumanoidStateType.Flying,
					Enum.HumanoidStateType.Climbing,
					Enum.HumanoidStateType.Swimming,
					Enum.HumanoidStateType.Dead
				}
				for _, v76 in ipairs(v75) do
					if v74 == v76 then
						if v_u_28.IsPlaying then
							v_u_28:Stop(0.15)
						end
						return
					end
				end
				if v73 <= 0.5 then
					if not v_u_28.IsPlaying then
						v_u_28:Play(0.2)
						return
					end
				elseif v_u_28.IsPlaying then
					v_u_28:Stop(0.15)
				end
			end
		end
	else
		return
	end
end
local function v_u_78()
	-- upvalues: (ref) v_u_33, (ref) v_u_32, (ref) v_u_31
	if v_u_33 then
		pcall(function()
			-- upvalues: (ref) v_u_33
			v_u_33:Stop()
		end)
		v_u_33 = nil
	end
	if v_u_32 and v_u_32.Parent then
		v_u_32:Destroy()
	end
	v_u_32 = nil
	if v_u_31 and v_u_31.Parent then
		v_u_31:Destroy()
	end
	v_u_31 = nil
end
local function v_u_79()
	-- upvalues: (ref) v_u_39, (ref) v_u_41, (ref) v_u_38, (ref) v_u_40
	if v_u_39 and v_u_39.Parent then
		v_u_39:Destroy()
	end
	v_u_39 = nil
	if v_u_41 and v_u_41.Parent then
		v_u_41:Destroy()
	end
	v_u_41 = nil
	if v_u_38 and v_u_38.Parent then
		v_u_38:Destroy()
	end
	v_u_38 = nil
	if v_u_40 and v_u_40.Parent then
		v_u_40:Destroy()
	end
	v_u_40 = nil
end
local function v_u_80()
	-- upvalues: (ref) v_u_48, (ref) v_u_49, (ref) v_u_46, (ref) v_u_47
	if v_u_48 and v_u_48.Parent then
		v_u_48:Destroy()
	end
	v_u_48 = nil
	if v_u_49 and v_u_49.Parent then
		v_u_49:Destroy()
	end
	v_u_49 = nil
	if v_u_46 and v_u_46.Parent then
		v_u_46:Destroy()
	end
	v_u_46 = nil
	if v_u_47 and v_u_47.Parent then
		v_u_47:Destroy()
	end
	v_u_47 = nil
end
local function v_u_159(p81, p_u_82)
	-- upvalues: (copy) v_u_61, (copy) v_u_78, (ref) v_u_35, (ref) v_u_34, (ref) v_u_37, (ref) v_u_36, (ref) v_u_43, (ref) v_u_42, (ref) v_u_45, (ref) v_u_44, (copy) v_u_79, (copy) v_u_80, (ref) v_u_28, (copy) v_u_69, (ref) v_u_29, (copy) v_u_77, (ref) v_u_19, (copy) v_u_7, (copy) v_u_3, (ref) v_u_38, (ref) v_u_40, (ref) v_u_39, (ref) v_u_41, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_49, (ref) v_u_31, (ref) v_u_32, (ref) v_u_33, (copy) v_u_13
	v_u_61()
	v_u_78()
	if v_u_35 and v_u_35.Parent then
		v_u_35:Destroy()
	end
	v_u_35 = nil
	if v_u_34 and v_u_34.Parent then
		v_u_34:Destroy()
	end
	v_u_34 = nil
	if v_u_37 and v_u_37.Parent then
		v_u_37:Destroy()
	end
	v_u_37 = nil
	if v_u_36 and v_u_36.Parent then
		v_u_36:Destroy()
	end
	v_u_36 = nil
	if v_u_43 and v_u_43.Parent then
		v_u_43:Destroy()
	end
	v_u_43 = nil
	if v_u_42 and v_u_42.Parent then
		v_u_42:Destroy()
	end
	v_u_42 = nil
	if v_u_45 and v_u_45.Parent then
		v_u_45:Destroy()
	end
	v_u_45 = nil
	if v_u_44 and v_u_44.Parent then
		v_u_44:Destroy()
	end
	v_u_44 = nil
	v_u_79()
	v_u_80()
	v_u_28 = v_u_69(p81, p_u_82)
	if v_u_29 then
		v_u_29:Disconnect()
	end
	v_u_29 = game:GetService("RunService").Heartbeat:Connect(v_u_77)
	v_u_77()
	if p81 == "Anos" and not v_u_19 then
		local v83 = v_u_7.Character
		if v83 then
			local v84 = v83:FindFirstChild("Right Arm") or v83:FindFirstChild("RightHand")
			if v84 then
				local v85 = v_u_3:FindFirstChild("AbilitySystem")
				if v85 then
					v85 = v85:FindFirstChild("VFX")
				end
				if v85 then
					v85 = v85:FindFirstChild("Anos")
				end
				if v85 then
					v85 = v85:FindFirstChild("Handle")
				end
				if v85 then
					local v86 = v85:Clone()
					if v86:IsA("BasePart") and v86:IsA("BasePart") then
						v86.Anchored = false
						v86.CanCollide = false
						v86.CanQuery = false
						v86.CanTouch = false
						v86.CastShadow = false
						v86.Massless = true
					end
					for _, v87 in v86:GetDescendants() do
						if v87:IsA("BasePart") then
							v87.Anchored = false
							v87.CanCollide = false
							v87.CanQuery = false
							v87.CanTouch = false
							v87.CastShadow = false
							v87.Massless = true
						end
					end
					v86.Parent = v83
					v_u_34 = v86
					local v88 = v86:IsA("BasePart") and v86 and v86 or v86:FindFirstChildWhichIsA("BasePart")
					if v88 then
						local v89 = Instance.new("Motor6D")
						v89.Name = "AnosHandle"
						v89.Part0 = v84
						v89.Part1 = v88
						v89.C0 = CFrame.new(0.02, -0.866, 0.02) * CFrame.Angles(-1.5707963267948966, 0, 0)
						v89.C1 = CFrame.new(0, -2.2, 0)
						v89.Parent = v84
						v_u_35 = v89
					end
					for _, v90 in v86:GetDescendants() do
						if v90:IsA("ParticleEmitter") then
							v90.Enabled = true
						end
						if v90:IsA("Trail") then
							v90.Enabled = true
						end
					end
				end
			end
		end
	end
	if p81 == "Escanor" and not v_u_19 then
		local v91 = v_u_7.Character
		if v91 then
			local v92 = v91:FindFirstChild("Right Arm") or v91:FindFirstChild("RightHand")
			if v92 then
				local v93 = v_u_3:FindFirstChild("AbilitySystem")
				if v93 then
					v93 = v93:FindFirstChild("VFX")
				end
				if v93 then
					v93 = v93:FindFirstChild("Escanor")
				end
				if v93 then
					v93 = v93:FindFirstChild("Handle")
				end
				if v93 then
					local v94 = v93:Clone()
					if v94:IsA("BasePart") and v94:IsA("BasePart") then
						v94.Anchored = false
						v94.CanCollide = false
						v94.CanQuery = false
						v94.CanTouch = false
						v94.CastShadow = false
						v94.Massless = true
					end
					for _, v95 in v94:GetDescendants() do
						if v95:IsA("BasePart") then
							v95.Anchored = false
							v95.CanCollide = false
							v95.CanQuery = false
							v95.CanTouch = false
							v95.CastShadow = false
							v95.Massless = true
						end
					end
					v94.Parent = v91
					v_u_36 = v94
					local v96 = v94:IsA("BasePart") and v94 and v94 or v94:FindFirstChildWhichIsA("BasePart")
					if v96 then
						local v97 = Instance.new("Motor6D")
						v97.Name = "EscanorHandle"
						v97.Part0 = v92
						v97.Part1 = v96
						v97.C0 = CFrame.new(0, 0, 0)
						v97.C1 = CFrame.new(0, 1.61, 2.18)
						v97.Parent = v92
						v_u_37 = v97
					end
					for _, v98 in v94:GetDescendants() do
						if v98:IsA("ParticleEmitter") then
							v98.Enabled = true
						end
						if v98:IsA("Trail") then
							v98.Enabled = true
						end
					end
				end
			end
		end
	end
	if p81 == "True Aizen" then
		local v99 = v_u_7.Character
		if v99 then
			local v100 = v99:FindFirstChild("Right Arm") or v99:FindFirstChild("RightHand")
			if v100 then
				local v101 = v_u_3:FindFirstChild("AbilitySystem")
				if v101 then
					v101 = v101:FindFirstChild("VFX")
				end
				if v101 then
					v101 = v101:FindFirstChild("True Aizen")
				end
				if v101 then
					v101 = v101:FindFirstChild("Handle")
				end
				if v101 then
					local v102 = v101:Clone()
					if v102:IsA("BasePart") and v102:IsA("BasePart") then
						v102.Anchored = false
						v102.CanCollide = false
						v102.CanQuery = false
						v102.CanTouch = false
						v102.CastShadow = false
						v102.Massless = true
					end
					for _, v103 in v102:GetDescendants() do
						if v103:IsA("BasePart") then
							v103.Anchored = false
							v103.CanCollide = false
							v103.CanQuery = false
							v103.CanTouch = false
							v103.CastShadow = false
							v103.Massless = true
						end
					end
					v102.Parent = v99
					v_u_44 = v102
					local v104 = v102:IsA("BasePart") and v102 and v102 or v102:FindFirstChildWhichIsA("BasePart")
					if v104 then
						local v105 = Instance.new("Motor6D")
						v105.Name = "Handle"
						v105.Part0 = v100
						v105.Part1 = v104
						v105.C0 = CFrame.new(-0.125, -1.136, 0.06) * CFrame.Angles(0.2617993877991494, 0, 0)
						v105.C1 = CFrame.new(0, 0.28, 2.203)
						v105.Parent = v100
						v_u_45 = v105
					end
					for _, v106 in v102:GetDescendants() do
						if v106:IsA("ParticleEmitter") then
							v106.Enabled = true
						end
						if v106:IsA("Trail") then
							v106.Enabled = true
						end
					end
				end
			end
		end
	end
	if p81 == "Blessed Maiden" then
		local v107 = v_u_7.Character
		if v107 then
			local v108 = v107:FindFirstChild("Right Arm") or v107:FindFirstChild("RightHand")
			if v108 then
				local v109 = v_u_3:FindFirstChild("AbilitySystem")
				if v109 then
					v109 = v109:FindFirstChild("VFX")
				end
				if v109 then
					v109 = v109:FindFirstChild("BlessedMaiden")
				end
				if v109 then
					v109 = v109:FindFirstChild("Handle")
				end
				if v109 then
					local v110 = v109:Clone()
					if v110:IsA("BasePart") and v110:IsA("BasePart") then
						v110.Anchored = false
						v110.CanCollide = false
						v110.CanQuery = false
						v110.CanTouch = false
						v110.CastShadow = false
						v110.Massless = true
					end
					for _, v111 in v110:GetDescendants() do
						if v111:IsA("BasePart") then
							v111.Anchored = false
							v111.CanCollide = false
							v111.CanQuery = false
							v111.CanTouch = false
							v111.CastShadow = false
							v111.Massless = true
						end
					end
					v110.Parent = v107
					v_u_42 = v110
					local v112 = v110:IsA("BasePart") and v110 and v110 or v110:FindFirstChildWhichIsA("BasePart")
					if v112 then
						local v113 = Instance.new("Motor6D")
						v113.Name = "Handle"
						v113.Part0 = v108
						v113.Part1 = v112
						v113.C0 = CFrame.new(-0.336, -0.904, -0.182) * CFrame.fromOrientation(0.14755013496360064, -1.6850804862154853, -2.4370555944372425)
						v113.C1 = CFrame.new(-0.094, 1.984, 0.453) * CFrame.fromOrientation(0.17210691753916085, 0.12185888837424409, -0.8055916228430227)
						v113.Parent = v108
						v_u_43 = v113
					end
					for _, v114 in v110:GetDescendants() do
						if v114:IsA("ParticleEmitter") then
							v114.Enabled = true
						end
						if v114:IsA("Trail") then
							v114.Enabled = true
						end
					end
				end
			end
		end
	end
	if p81 == "Yamato" then
		local v115 = v_u_7.Character
		if v115 then
			local v116 = v115:FindFirstChild("Left Arm") or v115:FindFirstChild("LeftHand")
			local v117 = v115:FindFirstChild("Right Arm") or v115:FindFirstChild("RightHand")
			if v116 and v117 then
				local v118 = v_u_3:FindFirstChild("AbilitySystem")
				if v118 then
					v118 = v118:FindFirstChild("VFX")
				end
				if v118 then
					v118 = v118:FindFirstChild("Vergil")
				end
				local v119
				if v118 then
					v119 = v118:FindFirstChild("yamato sheeth")
				else
					v119 = v118
				end
				if v118 then
					v118 = v118:FindFirstChild("yamato sword")
				end
				if v119 and v118 then
					local v120 = v119:Clone()
					local v121 = v118:Clone()
					if v120:IsA("BasePart") then
						v120.Anchored = false
						v120.CanCollide = false
						v120.CanQuery = false
						v120.CanTouch = false
						v120.CastShadow = false
						v120.Massless = true
					end
					for _, v122 in v120:GetDescendants() do
						if v122:IsA("BasePart") then
							v122.Anchored = false
							v122.CanCollide = false
							v122.CanQuery = false
							v122.CanTouch = false
							v122.CastShadow = false
							v122.Massless = true
						end
					end
					if v121:IsA("BasePart") then
						v121.Anchored = false
						v121.CanCollide = false
						v121.CanQuery = false
						v121.CanTouch = false
						v121.CastShadow = false
						v121.Massless = true
					end
					for _, v123 in v121:GetDescendants() do
						if v123:IsA("BasePart") then
							v123.Anchored = false
							v123.CanCollide = false
							v123.CanQuery = false
							v123.CanTouch = false
							v123.CastShadow = false
							v123.Massless = true
						end
					end
					v120.Parent = v115
					v121.Parent = v115
					v_u_38 = v120
					v_u_40 = v121
					local v124 = Instance.new("Motor6D")
					v124.Name = "yamato sheeth"
					v124.Part0 = v116
					v124.Part1 = v120
					v124.C0 = CFrame.new(-0.067, -1.093, 0.068) * CFrame.fromOrientation(-1.5350519837140526, 2.0177053350605645, -2.0904332049911685)
					v124.C1 = CFrame.new(-0.066, 0.897, 0.014)
					v124.Parent = v116
					v_u_39 = v124
					local v125 = Instance.new("Motor6D")
					v125.Name = "yamato sword"
					v125.Part0 = v117
					v125.Part1 = v121
					v125.C0 = CFrame.new(0.103, -0.973, -0.154) * CFrame.fromOrientation(1.5707963267948966, -0.13962634015954636, 0)
					v125.C1 = CFrame.new(0.08, 2.008, 0)
					v125.Parent = v117
					v_u_41 = v125
					for _, v126 in v120:GetDescendants() do
						if v126:IsA("ParticleEmitter") or v126:IsA("Trail") then
							v126.Enabled = true
						end
					end
					for _, v127 in v121:GetDescendants() do
						if v127:IsA("ParticleEmitter") or v127:IsA("Trail") then
							v127.Enabled = true
						end
					end
				end
			end
		end
	end
	if p81 == "ShadowMonarch" then
		local v128 = v_u_7.Character
		if v128 then
			local v129 = v128:FindFirstChild("Left Arm") or v128:FindFirstChild("LeftHand")
			local v130 = v128:FindFirstChild("Right Arm") or v128:FindFirstChild("RightHand")
			if v129 and v130 then
				local v131 = v_u_3:FindFirstChild("AbilitySystem")
				if v131 then
					v131 = v131:FindFirstChild("VFX")
				end
				if v131 then
					v131 = v131:FindFirstChild("ShadowMonarch")
				end
				local v132
				if v131 then
					v132 = v131:FindFirstChild("LeftDagger")
				else
					v132 = v131
				end
				if v131 then
					v131 = v131:FindFirstChild("Right Dagger")
				end
				if v132 and v131 then
					local v133 = v132:Clone()
					local v134 = v131:Clone()
					if v133:IsA("BasePart") then
						v133.Anchored = false
						v133.CanCollide = false
						v133.CanQuery = false
						v133.CanTouch = false
						v133.CastShadow = false
						v133.Massless = true
					end
					for _, v135 in v133:GetDescendants() do
						if v135:IsA("BasePart") then
							v135.Anchored = false
							v135.CanCollide = false
							v135.CanQuery = false
							v135.CanTouch = false
							v135.CastShadow = false
							v135.Massless = true
						end
					end
					if v134:IsA("BasePart") then
						v134.Anchored = false
						v134.CanCollide = false
						v134.CanQuery = false
						v134.CanTouch = false
						v134.CastShadow = false
						v134.Massless = true
					end
					for _, v136 in v134:GetDescendants() do
						if v136:IsA("BasePart") then
							v136.Anchored = false
							v136.CanCollide = false
							v136.CanQuery = false
							v136.CanTouch = false
							v136.CastShadow = false
							v136.Massless = true
						end
					end
					for _, v137 in v133:GetDescendants() do
						if v137:IsA("BasePart") and v137 ~= v133 then
							local v138 = Instance.new("WeldConstraint")
							v138.Part0 = v133
							v138.Part1 = v137
							v138.Parent = v137
						end
					end
					for _, v139 in v134:GetDescendants() do
						if v139:IsA("BasePart") and v139 ~= v134 then
							local v140 = Instance.new("WeldConstraint")
							v140.Part0 = v134
							v140.Part1 = v139
							v140.Parent = v139
						end
					end
					v133.Parent = v128
					v134.Parent = v128
					v_u_46 = v133
					v_u_47 = v134
					local v141 = Instance.new("Motor6D")
					v141.Name = "LeftDagger"
					v141.Part0 = v129
					v141.Part1 = v133
					v141.C0 = CFrame.new(0.039, -1.02, -0.306) * CFrame.Angles(0.22689280275926285, 0, 0)
					v141.C1 = CFrame.new(0, 0.487, 1.222)
					v141.Parent = v129
					v_u_48 = v141
					local v142 = Instance.new("Motor6D")
					v142.Name = "RightDagger"
					v142.Part0 = v130
					v142.Part1 = v134
					v142.C0 = CFrame.new(0.102, -0.895, 0.013) * CFrame.Angles(0.29255208921928955, 0.03675663404700058, 0.23479914427079715)
					v142.C1 = CFrame.new(0.05, 0.462, 1.531)
					v142.Parent = v130
					v_u_49 = v142
					for _, v143 in v133:GetDescendants() do
						if v143:IsA("ParticleEmitter") or v143:IsA("Trail") then
							v143.Enabled = true
						end
					end
					for _, v144 in v134:GetDescendants() do
						if v144:IsA("ParticleEmitter") or v144:IsA("Trail") then
							v144.Enabled = true
						end
					end
				end
			end
		end
	end
	if p81 == "Gilgamesh" and v_u_7:GetAttribute("GilgameshFUnlocked") == true then
		local v145 = v_u_7.Character
		if not v145 then
			return
		end
		local v146 = v145:FindFirstChild("HumanoidRootPart")
		if not v146 then
			return
		end
		local v147 = v_u_3:FindFirstChild("AbilitySystem")
		if v147 then
			v147 = v147:FindFirstChild("VFX")
		end
		if v147 then
			v147 = v147:FindFirstChild("Gilgamesh")
		end
		if v147 then
			v147 = v147:FindFirstChild("C")
		end
		if v147 then
			v147 = v147:FindFirstChild("gilgameshsword")
		end
		if not v147 then
			return
		end
		local v148 = v147:Clone()
		local v149 = v145:FindFirstChild("Right Arm") or v145:FindFirstChild("RightHand") or v146
		local v150 = v148:FindFirstChild("Cylinder") or (v148.PrimaryPart or v148:FindFirstChildWhichIsA("BasePart"))
		if v150 then
			if v150:IsA("BasePart") then
				v150.Anchored = false
				v150.CanCollide = false
				v150.CanQuery = false
				v150.CanTouch = false
				v150.CastShadow = false
				v150.Massless = true
			end
			for _, v151 in v150:GetDescendants() do
				if v151:IsA("BasePart") then
					v151.Anchored = false
					v151.CanCollide = false
					v151.CanQuery = false
					v151.CanTouch = false
					v151.CastShadow = false
					v151.Massless = true
				end
			end
			v148.Parent = v145
			v_u_31 = v148
			local v152 = Instance.new("Motor6D")
			v152.Name = "GilgaIdleCylinder"
			v152.Part0 = v149
			v152.Part1 = v150
			v152.C0 = CFrame.new(-0.101, -1.13, -0.208) * CFrame.Angles(-1.5707963267948966, 0, 0)
			v152.C1 = CFrame.new(-0.094, -2.6, -0.344)
			v152.Parent = v149
			v_u_32 = v152
			for _, v153 in v150:GetDescendants() do
				if v153:IsA("ParticleEmitter") then
					v153.Enabled = true
				end
			end
			local v154 = v148:FindFirstChildOfClass("AnimationController")
			if v154 then
				local v_u_155 = v154:FindFirstChildOfClass("Animator")
				if not v_u_155 then
					v_u_155 = Instance.new("Animator")
					v_u_155.Parent = v154
				end
				task.defer(function()
					-- upvalues: (ref) v_u_155, (copy) p_u_82, (ref) v_u_33
					if v_u_155 and v_u_155.Parent then
						local v_u_156 = Instance.new("Animation")
						v_u_156.AnimationId = "rbxassetid://" .. (p_u_82.GilgameshFIdleAnimationId or 123739442641752)
						pcall(function()
							-- upvalues: (ref) v_u_155, (copy) v_u_156, (ref) v_u_33
							local v157 = v_u_155:LoadAnimation(v_u_156)
							v157.Priority = Enum.AnimationPriority.Action4
							v157.Looped = true
							v157:Play()
							v_u_33 = v157
						end)
					end
				end)
			end
		else
			v148:Destroy()
		end
	end
	local v_u_158 = p_u_82.RunAnimationId and v_u_13.getLocalController()
	if v_u_158 then
		pcall(function()
			-- upvalues: (copy) v_u_158, (copy) p_u_82
			v_u_158:setCustomRunAnimation(p_u_82.RunAnimationId)
		end)
	end
end
local function v_u_162()
	-- upvalues: (ref) v_u_29, (ref) v_u_28, (copy) v_u_78, (ref) v_u_35, (ref) v_u_34, (ref) v_u_37, (ref) v_u_36, (ref) v_u_43, (ref) v_u_42, (ref) v_u_45, (ref) v_u_44, (copy) v_u_79, (copy) v_u_80, (copy) v_u_13, (ref) v_u_30
	if v_u_29 then
		v_u_29:Disconnect()
		v_u_29 = nil
	end
	if v_u_28 and v_u_28.IsPlaying then
		v_u_28:Stop(0.2)
	end
	v_u_28 = nil
	v_u_78()
	if v_u_35 and v_u_35.Parent then
		v_u_35:Destroy()
	end
	v_u_35 = nil
	if v_u_34 and v_u_34.Parent then
		v_u_34:Destroy()
	end
	v_u_34 = nil
	if v_u_37 and v_u_37.Parent then
		v_u_37:Destroy()
	end
	v_u_37 = nil
	if v_u_36 and v_u_36.Parent then
		v_u_36:Destroy()
	end
	v_u_36 = nil
	if v_u_43 and v_u_43.Parent then
		v_u_43:Destroy()
	end
	v_u_43 = nil
	if v_u_42 and v_u_42.Parent then
		v_u_42:Destroy()
	end
	v_u_42 = nil
	if v_u_45 and v_u_45.Parent then
		v_u_45:Destroy()
	end
	v_u_45 = nil
	if v_u_44 and v_u_44.Parent then
		v_u_44:Destroy()
	end
	v_u_44 = nil
	v_u_79()
	v_u_80()
	local v_u_160 = v_u_13.getLocalController()
	if v_u_160 then
		pcall(function()
			-- upvalues: (copy) v_u_160
			v_u_160:clearCustomRunAnimation()
		end)
	end
	if v_u_30 then
		local v161 = v_u_30
		if type(v161) == "table" then
			task.wait(0.1)
			pcall(function()
				-- upvalues: (ref) v_u_30
				v_u_30:update()
			end)
		end
	end
	v_u_30 = nil
end
local function v_u_173(p163, p164)
	-- upvalues: (ref) v_u_26, (copy) v_u_7, (copy) v_u_9, (copy) v_u_11
	if v_u_26[p163] and v_u_26[p163][p164] then
		return v_u_26[p163][p164]
	end
	local v165 = v_u_7.Character
	if v165 then
		v165 = v165:FindFirstChild("Humanoid")
	end
	if not v165 then
		return nil
	end
	local v166 = v165:FindFirstChild("Animator")
	if not v166 then
		return nil
	end
	local v167 = nil
	local v168 = v_u_9.Weapons[p163]
	if v168 and v168.Combo then
		local v169 = v168.Combo[p164]
		if v169 and v169.AnimationId then
			local v170 = Instance.new("Animation")
			v170.AnimationId = "rbxassetid://" .. v169.AnimationId
			v167 = v166:LoadAnimation(v170)
		end
	end
	if not v167 then
		local v171 = v_u_11:FindFirstChild(p163)
		if not v171 and p163 == "Strongest Of Today" then
			v171 = v_u_11:FindFirstChild("Gojo")
		end
		if not v171 and p163 == "Ichigo" then
			v171 = v_u_11:FindFirstChild("Saber")
		end
		if not v171 and p163 == "Rimuru" then
			v171 = v_u_11:FindFirstChild("Saber")
		end
		if not v171 and p163 == "Madoka" then
			v171 = v_u_11:FindFirstChild("Combat")
		end
		if not v171 and p163 == "Gilgamesh" then
			v171 = v_u_11:FindFirstChild("Combat")
		end
		if not v171 and p163 == "Yamato" then
			v171 = v_u_11:FindFirstChild("Saber")
		end
		if not v171 then
			return nil
		end
		local v172 = v171:FindFirstChild("M" .. p164)
		if not v172 then
			return nil
		end
		v167 = v166:LoadAnimation(v172)
	end
	v167.Looped = false
	v167.Priority = Enum.AnimationPriority.Action
	if not v_u_26[p163] then
		v_u_26[p163] = {}
	end
	v_u_26[p163][p164] = v167
	return v167
end
local function v_u_440(p174, p_u_175)
	-- upvalues: (copy) v_u_7, (copy) v_u_12, (copy) v_u_4, (copy) v_u_3, (copy) v_u_1, (copy) v_u_16, (copy) v_u_14, (copy) v_u_6, (copy) v_u_5, (copy) v_u_9
	local v176 = v_u_7:GetAttribute("DisableVFX") == true
	if v176 and (p174 ~= "Gilgamesh" or p_u_175 ~= 1 and p_u_175 ~= 3) then
		return
	end
	local v_u_177 = v_u_7.Character
	local v_u_178
	if v_u_177 then
		v_u_178 = v_u_177:FindFirstChild("HumanoidRootPart")
	else
		v_u_178 = v_u_177
	end
	if not v_u_178 then
		return
	end
	if p174 == "Alucard" then
		local v179 = v_u_12:FindFirstChild("Alucard")
		if v179 then
			local v180 = v179:FindFirstChild("Punch" .. p_u_175)
			if v180 then
				local v_u_181 = v180:Clone()
				v_u_181.CFrame = v_u_178.CFrame * CFrame.new(0, 0, -5.5) * CFrame.Angles(0, 1.5707963267948966, 0)
				v_u_181.Anchored = false
				v_u_181.CanCollide = false
				v_u_181.CanQuery = false
				v_u_181.CanTouch = false
				v_u_181.Massless = true
				v_u_181.CastShadow = false
				v_u_181.Transparency = 1
				v_u_181.Parent = workspace
				local v182 = Instance.new("WeldConstraint")
				v182.Part0 = v_u_178
				v182.Part1 = v_u_181
				v182.Parent = v_u_181
				local v_u_183 = Color3.fromRGB(0, 133, 200)
				local v_u_184 = Color3.fromRGB(255, 50, 50)
				if p_u_175 == 1 then
					v_u_184 = v_u_183
				elseif p_u_175 == 2 then
					v_u_183 = v_u_184
				end
				local function v213()
					-- upvalues: (copy) v_u_181, (ref) v_u_183, (ref) v_u_184, (copy) p_u_175
					for _, v185 in v_u_181:GetDescendants() do
						if v185:IsA("ParticleEmitter") then
							local v186 = v185.Color
							local v187 = {}
							for _, v188 in ipairs(v186.Keypoints) do
								local v189 = v_u_183:Lerp(v_u_184, v188.Time)
								local v190 = ColorSequenceKeypoint.new
								local v191 = v188.Time
								table.insert(v187, v190(v191, v189))
							end
							v185.Color = ColorSequence.new(v187)
							local v192 = v185.Size
							local v193 = {}
							for _, v194 in ipairs(v192.Keypoints) do
								local v195 = NumberSequenceKeypoint.new
								local v196 = v194.Time
								local v197 = v194.Value * 0.6
								local v198 = v194.Envelope * 0.6
								table.insert(v193, v195(v196, v197, v198))
							end
							v185.Size = NumberSequence.new(v193)
							if p_u_175 == 3 then
								v185.Lifetime = NumberRange.new(v185.Lifetime.Min * 1.5, v185.Lifetime.Max * 1.5)
							end
							v185:Emit(v185:GetAttribute("EmitCount") or 1)
						end
					end
					for _, v199 in v_u_181:GetChildren() do
						if v199:IsA("ParticleEmitter") then
							local v200 = v199.Color
							local v201 = {}
							for _, v202 in ipairs(v200.Keypoints) do
								local v203 = v_u_183:Lerp(v_u_184, v202.Time)
								local v204 = ColorSequenceKeypoint.new
								local v205 = v202.Time
								table.insert(v201, v204(v205, v203))
							end
							v199.Color = ColorSequence.new(v201)
							local v206 = v199.Size
							local v207 = {}
							for _, v208 in ipairs(v206.Keypoints) do
								local v209 = NumberSequenceKeypoint.new
								local v210 = v208.Time
								local v211 = v208.Value * 0.6
								local v212 = v208.Envelope * 0.6
								table.insert(v207, v209(v210, v211, v212))
							end
							v199.Size = NumberSequence.new(v207)
							if p_u_175 == 3 then
								v199.Lifetime = NumberRange.new(v199.Lifetime.Min * 1.5, v199.Lifetime.Max * 1.5)
							end
							v199:Emit(v199:GetAttribute("EmitCount") or 1)
						end
					end
				end
				local v214
				if p_u_175 == 1 then
					v214 = 0.45
				else
					local _ = p_u_175 == 2
					v214 = 0.45
				end
				task.delay(v214, v213)
				v_u_4:AddItem(v_u_181, p_u_175 == 3 and 4.45 or 2 + v214)
			end
		else
			return
		end
	end
	if p174 == "Strongest Of Today" then
		local v215 = v_u_12:FindFirstChild("Gojo")
		if not v215 then
			return
		end
		weaponVFX = v215
	else
		weaponVFX = v_u_12:FindFirstChild(p174)
	end
	if not weaponVFX then
		return
	end
	if p174 == "Qin Shi" then
		local v216 = weaponVFX:FindFirstChild("Punch" .. p_u_175)
		if v216 then
			local v217 = v216:Clone()
			v217.CFrame = v_u_178.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0)
			v217.Anchored = true
			v217.CanCollide = false
			v217.CanQuery = false
			v217.CanTouch = false
			v217.Transparency = 1
			v217.Parent = workspace
			for _, v218 in v217:GetDescendants() do
				if v218:IsA("ParticleEmitter") then
					v218:Emit(v218:GetAttribute("EmitCount") or 1)
				end
			end
			for _, v219 in v217:GetChildren() do
				if v219:IsA("ParticleEmitter") then
					v219:Emit(v219:GetAttribute("EmitCount") or 1)
				end
			end
			v_u_4:AddItem(v217, 2)
		end
	end
	if p174 == "Madoka" then
		local v220 = weaponVFX:FindFirstChild("Punch" .. p_u_175)
		if v220 then
			local v221 = v220:Clone()
			v221.CFrame = v_u_178.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0)
			v221.Anchored = true
			v221.CanCollide = false
			v221.CanQuery = false
			v221.CanTouch = false
			v221.Transparency = 1
			v221.Parent = workspace
			for _, v222 in v221:GetDescendants() do
				if v222:IsA("ParticleEmitter") then
					v222:Emit(v222:GetAttribute("EmitCount") or 1)
				end
			end
			for _, v223 in v221:GetChildren() do
				if v223:IsA("ParticleEmitter") then
					v223:Emit(v223:GetAttribute("EmitCount") or 1)
				end
			end
			v_u_4:AddItem(v221, 2)
		end
	end
	if p174 == "Gilgamesh" then
		local v_u_224 = v_u_12:FindFirstChild("Gilgamesh")
		if not v_u_224 then
			return
		end
		local v_u_225 = CFrame.new(-437.6, 3, -192.8)
		local function v_u_234(p226)
			-- upvalues: (copy) v_u_224, (copy) v_u_225, (copy) v_u_178
			local v227 = v_u_224:FindFirstChild(p226)
			if not v227 then
				return nil
			end
			local v228 = v227:Clone()
			local v229 = {}
			if v228:IsA("BasePart") then
				table.insert(v229, v228)
			end
			for _, v230 in v228:GetDescendants() do
				if v230:IsA("BasePart") then
					table.insert(v229, v230)
				end
			end
			for _, v231 in ipairs(v229) do
				local v232 = v_u_225:Inverse() * v231.CFrame
				v231.CFrame = v_u_178.CFrame * v232
				v231.Anchored = true
				v231.CanCollide = false
				v231.CanQuery = false
				v231.CanTouch = false
				v231.CastShadow = false
				v231.Massless = true
			end
			for _, v233 in v228:GetDescendants() do
				if v233:IsA("ParticleEmitter") then
					v233.Enabled = false
				end
			end
			v228.Parent = workspace
			return v228
		end
		local function v_u_239(p235)
			-- upvalues: (ref) v_u_7
			if not p235 or p235 == v_u_7 then
				return true
			end
			if _G.Allies and _G.Allies[v_u_7.UserId] then
				for _, v236 in pairs(_G.Allies[v_u_7.UserId]) do
					if v236 == p235.UserId then
						return true
					end
				end
			end
			local v237 = v_u_7:GetAttribute("PartyId") or v_u_7:GetAttribute("CrewId")
			local v238 = p235:GetAttribute("PartyId") or p235:GetAttribute("CrewId")
			return v237 and (v238 and v237 == v238) and true or false
		end
		local function v_u_242(p_u_240)
			-- upvalues: (ref) v_u_3, (copy) v_u_239
			if p_u_240 then
				if p_u_240:GetAttribute("DisablePvP") then
					return false
				else
					pcall(function()
						-- upvalues: (ref) v_u_3, (ref) p_u_240
						local v241 = require(v_u_3:FindFirstChild("SafeZoneModule"))
						if v241 and (v241.IsPlayerSafe and v241.IsPlayerSafe(p_u_240)) then
							p_u_240 = nil
						end
					end)
					if p_u_240 then
						return not v_u_239(p_u_240)
					else
						return false
					end
				end
			else
				return false
			end
		end
		local function v260(p243)
			-- upvalues: (copy) v_u_178, (ref) v_u_7, (ref) v_u_3, (ref) v_u_1, (copy) v_u_242, (copy) v_u_177
			local v244 = nil
			local v245 = p243 or 150
			local v246 = v_u_178.CFrame.LookVector
			local v247 = v_u_7:GetAttribute("DisablePvP")
			local v_u_248 = false
			pcall(function()
				-- upvalues: (ref) v_u_3, (ref) v_u_7, (ref) v_u_248
				local v249 = require(v_u_3:FindFirstChild("SafeZoneModule"))
				if v249 and (v249.IsPlayerSafe and v249.IsPlayerSafe(v_u_7)) then
					v_u_248 = true
				end
			end)
			if not (v247 or v_u_248) then
				for _, v250 in v_u_1:GetPlayers() do
					if v250 ~= v_u_7 and v_u_242(v250) then
						local v251 = v250.Character
						if v251 then
							local v252 = v251:FindFirstChild("HumanoidRootPart")
							local v253 = v251:FindFirstChildOfClass("Humanoid")
							if v252 and (v253 and v253.Health > 0) then
								local v254 = (v252.Position - v_u_178.Position).Magnitude
								if v254 < v245 and v246:Dot((v252.Position - v_u_178.Position).Unit) >= 0.5000000000000001 then
									v244 = v252
									v245 = v254
								end
							end
						end
					end
				end
			end
			local v255 = workspace:FindFirstChild("NPCs")
			if v255 then
				for _, v256 in v255:GetChildren() do
					if v256:IsA("Model") and v256 ~= v_u_177 then
						local v257 = v256:FindFirstChild("HumanoidRootPart")
						local v258 = v256:FindFirstChildOfClass("Humanoid")
						if v257 and (v258 and v258.Health > 0) then
							local v259 = (v257.Position - v_u_178.Position).Magnitude
							if v259 < v245 and v246:Dot((v257.Position - v_u_178.Position).Unit) >= 0.5000000000000001 then
								v244 = v257
								v245 = v259
							end
						end
					end
				end
			end
			return v244
		end
		if p_u_175 == 1 then
			local v_u_261 = v_u_178.CFrame.LookVector
			local v_u_262 = v260(150)
			if v176 then
				local v_u_263
				if v_u_262 and v_u_262.Parent then
					v_u_263 = v_u_262.Position
				else
					v_u_263 = v_u_178.Position + v_u_261 * 80
				end
				local v264 = (v_u_263 - v_u_178.Position).Magnitude / 250
				local v265 = math.min(v264, 2)
				task.delay(v265, function()
					-- upvalues: (ref) v_u_16, (ref) v_u_263
					v_u_16:FireServer(v_u_263)
				end)
				return
			end
			local v266 = v_u_234("Gate2")
			local v_u_267 = v_u_178.Position + Vector3.new(0, 2, 0)
			if v266 then
				if v266:IsA("BasePart") then
					v_u_267 = v266.Position
				elseif v266:IsA("Model") then
					local v268 = v266.PrimaryPart or v266:FindFirstChildWhichIsA("BasePart")
					if v268 then
						v_u_267 = v268.Position
					end
				else
					for _, v269 in v266:GetDescendants() do
						if v269:IsA("BasePart") then
							v_u_267 = v269.Position
							break
						end
					end
				end
				for _, v_u_270 in v266:GetDescendants() do
					if v_u_270:IsA("ParticleEmitter") then
						v_u_270.Enabled = true
						task.delay(0.4, function()
							-- upvalues: (copy) v_u_270
							if v_u_270 and v_u_270.Parent then
								v_u_270.Enabled = false
							end
						end)
					end
				end
				v_u_4:AddItem(v266, 3)
				if v_u_14 then
					pcall(function()
						-- upvalues: (ref) v_u_14, (ref) v_u_267
						v_u_14:PlayAt("GilgameshZ_GateSpawn", v_u_267)
					end)
				end
			end
			local v271 = v_u_224:FindFirstChild("Trail")
			if v271 then
				if v_u_262 and v_u_262.Parent then
					local v272 = v_u_262.Position - v_u_267
					if v272.Magnitude > 1 then
						local v273 = v272.Unit
					end
				end
				local v_u_274 = v271:Clone()
				if v_u_274:IsA("BasePart") then
					v_u_274.CFrame = CFrame.new(v_u_267, v_u_267 + v273)
					v_u_274.Anchored = true
					v_u_274.CanCollide = false
					v_u_274.CanQuery = false
					v_u_274.CanTouch = false
					v_u_274.CastShadow = false
				elseif v_u_274:IsA("Model") then
					v_u_274:PivotTo(CFrame.new(v_u_267, v_u_267 + v273))
					for _, v275 in v_u_274:GetDescendants() do
						if v275:IsA("BasePart") then
							v275.Anchored = true
							v275.CanCollide = false
							v275.CanQuery = false
							v275.CanTouch = false
							v275.CastShadow = false
						end
					end
				end
				v_u_274.Parent = workspace
				for _, v276 in v_u_274:GetDescendants() do
					if v276:IsA("ParticleEmitter") then
						v276.Enabled = true
						local v277 = v276:GetAttribute("EmitCount")
						if v277 and v277 > 0 then
							v276:Emit(v277)
						end
					elseif v276:IsA("Beam") or v276:IsA("Trail") then
						v276.Enabled = true
					end
				end
				if v_u_14 then
					pcall(function()
						-- upvalues: (ref) v_u_14, (copy) v_u_274
						v_u_14:PlayAt("GilgameshZ_Shot1", v_u_274:IsA("BasePart") and v_u_274.Position or v_u_274:GetPivot().Position)
					end)
				end
				local function v_u_281(p278, p279)
					-- upvalues: (ref) v_u_6, (ref) v_u_4
					if p278 and p278.Parent then
						for _, v280 in p278:GetDescendants() do
							if v280:IsA("BasePart") then
								v_u_6:Create(v280, TweenInfo.new(p279, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
									["Transparency"] = 1
								}):Play()
							elseif v280:IsA("ParticleEmitter") then
								v280.Enabled = false
							elseif v280:IsA("Beam") or v280:IsA("Trail") then
								v280.Enabled = false
							end
						end
						v_u_4:AddItem(p278, p279 + 0.5)
					end
				end
				local v_u_282 = 0
				local v_u_283 = false
				local v_u_284 = {}
				local v_u_285
				if v_u_274:IsA("Model") then
					v_u_285 = v_u_274.PrimaryPart or v_u_274:FindFirstChildWhichIsA("BasePart")
					if v_u_285 then
						for _, v286 in v_u_274:GetDescendants() do
							if v286:IsA("BasePart") and v286 ~= v_u_285 then
								v_u_284[v286] = v_u_285.CFrame:Inverse() * v286.CFrame
							end
						end
					end
				else
					v_u_285 = v_u_274
				end
				if v_u_285 then
					local v_u_287 = nil
					v_u_287 = v_u_5.Heartbeat:Connect(function(p288)
						-- upvalues: (ref) v_u_283, (ref) v_u_285, (ref) v_u_287, (ref) v_u_282, (copy) v_u_281, (copy) v_u_274, (copy) v_u_262, (copy) v_u_261, (ref) v_u_16, (ref) v_u_14, (copy) v_u_224, (ref) v_u_4, (copy) v_u_284
						if v_u_283 or not (v_u_285 and v_u_285.Parent) then
							if v_u_287 then
								v_u_287:Disconnect()
							end
							return
						else
							v_u_282 = v_u_282 + p288
							if v_u_282 >= 2 then
								v_u_283 = true
								v_u_287:Disconnect()
								v_u_281(v_u_274, 0.3)
								return
							else
								local v289
								if v_u_262 and v_u_262.Parent then
									local v290 = v_u_262.Parent:FindFirstChildOfClass("Humanoid")
									if v290 and v290.Health > 0 then
										v289 = v_u_262.Position
									else
										v289 = v_u_262.Position
									end
								else
									v289 = v_u_285.Position + v_u_261 * 80
								end
								local v291 = v289 - v_u_285.Position
								local v292 = v291.Magnitude
								if v292 < 2 then
									v_u_16:FireServer(v289)
									if v_u_14 then
										pcall(function()
											-- upvalues: (ref) v_u_14, (ref) v_u_285
											v_u_14:PlayAt("GilgameshZ_Hit", v_u_285.Position)
										end)
									end
									local v293 = v_u_224:FindFirstChild("Explosion")
									if v293 then
										local v294 = v293:Clone()
										if v294:IsA("BasePart") then
											v294.CFrame = CFrame.new(v289)
											v294.Anchored = true
											v294.CanCollide = false
											v294.CanQuery = false
											v294.CanTouch = false
											v294.CastShadow = false
										elseif v294:IsA("Model") then
											v294:PivotTo(CFrame.new(v289))
											for _, v295 in v294:GetDescendants() do
												if v295:IsA("BasePart") then
													v295.Anchored = true
													v295.CanCollide = false
													v295.CanQuery = false
													v295.CanTouch = false
													v295.CastShadow = false
												end
											end
										end
										v294.Parent = workspace
										for _, v296 in v294:GetDescendants() do
											if v296:IsA("ParticleEmitter") then
												v296:Emit(v296:GetAttribute("EmitCount") or v296.Rate)
											end
										end
										v_u_4:AddItem(v294, 3)
									end
									v_u_283 = true
									v_u_287:Disconnect()
									v_u_281(v_u_274, 0.3)
								else
									local v297 = v291.Unit
									local v298 = 250 * p288
									local v299 = v_u_285.Position + v297 * math.min(v298, v292)
									local v300 = CFrame.new(v299, v299 + v297)
									v_u_285.CFrame = v300
									for v301, v302 in pairs(v_u_284) do
										if v301 and v301.Parent then
											v301.CFrame = v300 * v302
										end
									end
									if v_u_282 >= 1.4 and not v_u_283 then
										v_u_283 = true
										v_u_287:Disconnect()
										v_u_281(v_u_274, 0.3)
									end
								end
							end
						end
					end)
				end
			end
			return
		end
		if p_u_175 == 2 then
			local v303 = v_u_224:FindFirstChild("gilgameshsword")
			if v303 then
				local v304 = v303:Clone()
				local v305 = v_u_177:FindFirstChild("Right Arm") or v_u_177:FindFirstChild("RightHand") or v_u_178
				local v_u_306 = v304:FindFirstChild("Cylinder") or (v304.PrimaryPart or v304:FindFirstChildWhichIsA("BasePart"))
				if v_u_306 then
					if v_u_306:IsA("BasePart") then
						v_u_306.Anchored = false
						v_u_306.CanCollide = false
						v_u_306.CanQuery = false
						v_u_306.CanTouch = false
						v_u_306.CastShadow = false
						v_u_306.Massless = true
					end
					for _, v307 in v_u_306:GetDescendants() do
						if v307:IsA("BasePart") then
							v307.Anchored = false
							v307.CanCollide = false
							v307.CanQuery = false
							v307.CanTouch = false
							v307.CastShadow = false
							v307.Massless = true
						end
					end
					v_u_306.Transparency = 1
					v304.Parent = v_u_177
					local v_u_308 = Instance.new("Motor6D")
					v_u_308.Name = "GilgaM2Cylinder"
					v_u_308.Part0 = v305
					v_u_308.Part1 = v_u_306
					v_u_308.C0 = CFrame.new(-0.101, -1.13, -0.208) * CFrame.Angles(-1.5707963267948966, 0, 0)
					v_u_308.C1 = CFrame.new(-0.094, -2.6, -0.344)
					v_u_308.Parent = v305
					local v309 = v304:FindFirstChildOfClass("AnimationController")
					if v309 then
						local v_u_310 = v309:FindFirstChildOfClass("Animator")
						if not v_u_310 then
							v_u_310 = Instance.new("Animator")
							v_u_310.Parent = v309
						end
						task.defer(function()
							-- upvalues: (ref) v_u_310, (ref) v_u_9
							if v_u_310 and v_u_310.Parent then
								local v311 = v_u_9.Weapons.Gilgamesh
								local v312 = v311 and (v311.Combo and v311.Combo[2])
								if v312 then
									v312 = v311.Combo[2].AnimationId
								end
								if v312 then
									local v_u_313 = Instance.new("Animation")
									v_u_313.AnimationId = "rbxassetid://" .. v312
									pcall(function()
										-- upvalues: (ref) v_u_310, (copy) v_u_313
										local v314 = v_u_310:LoadAnimation(v_u_313)
										v314.Priority = Enum.AnimationPriority.Action4
										v314.Looped = false
										v314:Play()
									end)
								end
							end
						end)
					end
					task.delay(0.25, function()
						-- upvalues: (copy) v_u_306
						if v_u_306 and v_u_306.Parent then
							v_u_306.Transparency = 0
						end
					end)
					v_u_4:AddItem(v304, 3)
					task.delay(3, function()
						-- upvalues: (copy) v_u_308
						if v_u_308 and v_u_308.Parent then
							v_u_308:Destroy()
						end
					end)
				else
					v304:Destroy()
				end
			end
			task.delay(0.16666666666666666, function()
				-- upvalues: (copy) v_u_178, (copy) v_u_234, (ref) v_u_4
				if v_u_178 and v_u_178.Parent then
					local v315 = v_u_234("Gate")
					if v315 then
						for _, v_u_316 in ipairs(v315:GetDescendants()) do
							if v_u_316:IsA("ParticleEmitter") then
								v_u_316.Enabled = true
								task.delay(0.3, function()
									-- upvalues: (copy) v_u_316
									if v_u_316 and v_u_316.Parent then
										v_u_316.Enabled = false
									end
								end)
							end
						end
						v_u_4:AddItem(v315, 3)
					end
				end
			end)
			task.delay(0.5666666666666667, function()
				-- upvalues: (copy) v_u_178, (copy) v_u_234, (ref) v_u_4
				if v_u_178 and v_u_178.Parent then
					local v317 = v_u_234("SlashVFX")
					if v317 then
						for _, v318 in ipairs(v317:GetDescendants()) do
							if v318:IsA("ParticleEmitter") then
								v318:Emit(v318:GetAttribute("EmitCount") or 1)
							end
						end
						v_u_4:AddItem(v317, 3)
					end
				end
			end)
			return
		end
		if p_u_175 == 3 then
			local v_u_319 = v_u_178.CFrame.LookVector
			local v_u_320 = v260(150)
			if v176 then
				for v321 = 1, 3 do
					task.delay((v321 - 1) * 0.15, function()
						-- upvalues: (copy) v_u_178, (copy) v_u_320, (copy) v_u_319, (ref) v_u_16
						if v_u_178 and v_u_178.Parent then
							local v_u_322
							if v_u_320 and v_u_320.Parent then
								v_u_322 = v_u_320.Position
							else
								v_u_322 = v_u_178.Position + v_u_319 * 80
							end
							local v323 = (v_u_322 - v_u_178.Position).Magnitude / 250
							local v324 = math.min(v323, 2)
							task.delay(v324, function()
								-- upvalues: (ref) v_u_16, (ref) v_u_322
								v_u_16:FireServer(v_u_322)
							end)
						end
					end)
				end
			else
				local v_u_325 = v_u_224:FindFirstChild("Trail")
				for v_u_326, v_u_327 in ipairs({ "Gate3", "Gate4", "Gate5" }) do
					task.delay((v_u_326 - 1) * 0.15, function()
						-- upvalues: (copy) v_u_178, (copy) v_u_234, (copy) v_u_327, (ref) v_u_4, (ref) v_u_14, (copy) v_u_325, (copy) v_u_319, (copy) v_u_320, (copy) v_u_326, (ref) v_u_6, (ref) v_u_5, (ref) v_u_16, (copy) v_u_224
						if v_u_178 and v_u_178.Parent then
							local v328 = v_u_234(v_u_327)
							local v_u_329 = v_u_178.Position + Vector3.new(0, 2, 0)
							if v328 then
								if v328:IsA("BasePart") then
									v_u_329 = v328.Position
								elseif v328:IsA("Model") then
									local v330 = v328.PrimaryPart or v328:FindFirstChildWhichIsA("BasePart")
									if v330 then
										v_u_329 = v330.Position
									end
								end
								for _, v_u_331 in v328:GetDescendants() do
									if v_u_331:IsA("ParticleEmitter") then
										v_u_331.Enabled = true
										task.delay(0.4, function()
											-- upvalues: (copy) v_u_331
											if v_u_331 and v_u_331.Parent then
												v_u_331.Enabled = false
											end
										end)
									end
								end
								v_u_4:AddItem(v328, 3)
								if v_u_14 then
									pcall(function()
										-- upvalues: (ref) v_u_14, (ref) v_u_329
										v_u_14:PlayAt("GilgameshZ_GateSpawn", v_u_329)
									end)
								end
							end
							if v_u_325 then
								local v332 = v_u_319
								if v_u_320 and v_u_320.Parent then
									local v333 = v_u_320.Position - v_u_329
									if v333.Magnitude > 1 then
										v332 = v333.Unit
									end
								end
								local v_u_334 = v_u_325:Clone()
								if v_u_334:IsA("BasePart") then
									v_u_334.CFrame = CFrame.new(v_u_329, v_u_329 + v332)
									v_u_334.Anchored = true
									v_u_334.CanCollide = false
									v_u_334.CanQuery = false
									v_u_334.CanTouch = false
									v_u_334.CastShadow = false
								elseif v_u_334:IsA("Model") then
									v_u_334:PivotTo(CFrame.new(v_u_329, v_u_329 + v332))
									for _, v335 in v_u_334:GetDescendants() do
										if v335:IsA("BasePart") then
											v335.Anchored = true
											v335.CanCollide = false
											v335.CanQuery = false
											v335.CanTouch = false
											v335.CastShadow = false
										end
									end
								end
								v_u_334.Parent = workspace
								for _, v336 in v_u_334:GetDescendants() do
									if v336:IsA("ParticleEmitter") then
										v336.Enabled = true
										local v337 = v336:GetAttribute("EmitCount")
										if v337 and v337 > 0 then
											v336:Emit(v337)
										end
									elseif v336:IsA("Beam") or v336:IsA("Trail") then
										v336.Enabled = true
									end
								end
								if v_u_14 then
									local v338 = { "GilgameshZ_Shot1", "GilgameshZ_Shot2", "GilgameshZ_Shot3" }
									local v_u_339 = v338[(v_u_326 - 1) % #v338 + 1]
									pcall(function()
										-- upvalues: (ref) v_u_14, (copy) v_u_339, (copy) v_u_334
										v_u_14:PlayAt(v_u_339, v_u_334:IsA("BasePart") and v_u_334.Position or v_u_334:GetPivot().Position)
									end)
								end
								local function v_u_343(p340, p341)
									-- upvalues: (ref) v_u_6, (ref) v_u_4
									if p340 and p340.Parent then
										for _, v342 in p340:GetDescendants() do
											if v342:IsA("BasePart") then
												v_u_6:Create(v342, TweenInfo.new(p341, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
													["Transparency"] = 1
												}):Play()
											elseif v342:IsA("ParticleEmitter") then
												v342.Enabled = false
											elseif v342:IsA("Beam") or v342:IsA("Trail") then
												v342.Enabled = false
											end
										end
										v_u_4:AddItem(p340, p341 + 0.5)
									end
								end
								local v_u_344 = 0
								local v_u_345 = false
								local v_u_346 = {}
								local v_u_347
								if v_u_334:IsA("Model") then
									v_u_347 = v_u_334.PrimaryPart or v_u_334:FindFirstChildWhichIsA("BasePart")
									if v_u_347 then
										for _, v348 in v_u_334:GetDescendants() do
											if v348:IsA("BasePart") and v348 ~= v_u_347 then
												v_u_346[v348] = v_u_347.CFrame:Inverse() * v348.CFrame
											end
										end
									end
								else
									v_u_347 = v_u_334
								end
								if v_u_347 then
									local v_u_349 = nil
									v_u_349 = v_u_5.Heartbeat:Connect(function(p350)
										-- upvalues: (ref) v_u_345, (ref) v_u_347, (ref) v_u_349, (ref) v_u_344, (copy) v_u_343, (copy) v_u_334, (ref) v_u_320, (ref) v_u_319, (ref) v_u_16, (ref) v_u_14, (ref) v_u_224, (ref) v_u_4, (copy) v_u_346
										if v_u_345 or not (v_u_347 and v_u_347.Parent) then
											if v_u_349 then
												v_u_349:Disconnect()
											end
											return
										else
											v_u_344 = v_u_344 + p350
											if v_u_344 >= 2 then
												v_u_345 = true
												v_u_349:Disconnect()
												v_u_343(v_u_334, 0.3)
												return
											else
												local v351
												if v_u_320 and v_u_320.Parent then
													v351 = v_u_320.Position
												else
													v351 = v_u_347.Position + v_u_319 * 80
												end
												local v352 = v351 - v_u_347.Position
												local v353 = v352.Magnitude
												if v353 < 2 then
													v_u_16:FireServer(v351)
													if v_u_14 then
														pcall(function()
															-- upvalues: (ref) v_u_14, (ref) v_u_347
															v_u_14:PlayAt("GilgameshZ_Hit", v_u_347.Position)
														end)
													end
													local v354 = v_u_224:FindFirstChild("Explosion")
													if v354 then
														local v355 = v354:Clone()
														if v355:IsA("BasePart") then
															v355.CFrame = CFrame.new(v351)
															v355.Anchored = true
															v355.CanCollide = false
															v355.CanQuery = false
															v355.CanTouch = false
															v355.CastShadow = false
														elseif v355:IsA("Model") then
															v355:PivotTo(CFrame.new(v351))
															for _, v356 in v355:GetDescendants() do
																if v356:IsA("BasePart") then
																	v356.Anchored = true
																	v356.CanCollide = false
																	v356.CanQuery = false
																	v356.CanTouch = false
																	v356.CastShadow = false
																end
															end
														end
														v355.Parent = workspace
														for _, v357 in v355:GetDescendants() do
															if v357:IsA("ParticleEmitter") then
																v357:Emit(v357:GetAttribute("EmitCount") or v357.Rate)
															end
														end
														v_u_4:AddItem(v355, 3)
													end
													v_u_345 = true
													v_u_349:Disconnect()
													v_u_343(v_u_334, 0.3)
												else
													local v358 = v352.Unit
													local v359 = 250 * p350
													local v360 = v_u_347.Position + v358 * math.min(v359, v353)
													local v361 = CFrame.new(v360, v360 + v358)
													v_u_347.CFrame = v361
													for v362, v363 in pairs(v_u_346) do
														if v362 and v362.Parent then
															v362.CFrame = v361 * v363
														end
													end
													if v_u_344 >= 1.4 and not v_u_345 then
														v_u_345 = true
														v_u_349:Disconnect()
														v_u_343(v_u_334, 0.3)
													end
												end
											end
										end
									end)
								end
							end
						end
					end)
				end
			end
		end
		if p_u_175 == 4 then
			local v364 = v_u_234("Gate1")
			if v364 then
				for _, v_u_365 in ipairs(v364:GetDescendants()) do
					if v_u_365:IsA("ParticleEmitter") then
						v_u_365.Enabled = true
						task.delay(0.3, function()
							-- upvalues: (copy) v_u_365
							if v_u_365 and v_u_365.Parent then
								v_u_365.Enabled = false
							end
						end)
					end
				end
				v_u_4:AddItem(v364, 3)
			end
			task.delay(0.43333333333333335, function()
				-- upvalues: (copy) v_u_178, (copy) v_u_234, (ref) v_u_4
				if v_u_178 and v_u_178.Parent then
					local v366 = v_u_234("Punch1")
					if v366 then
						for _, v367 in ipairs(v366:GetDescendants()) do
							if v367:IsA("ParticleEmitter") then
								v367:Emit(v367:GetAttribute("EmitCount") or 1)
							end
						end
						v_u_4:AddItem(v366, 3)
					end
				end
			end)
			return
		end
	end
	if p174 == "Strongest In History" then
		local v368 = weaponVFX:FindFirstChild("Punch" .. p_u_175)
		if v368 then
			local v369 = v368:Clone()
			v369.CFrame = v_u_178.CFrame * CFrame.new(0, 0, -10.5) * CFrame.Angles(0, 1.5707963267948966, 0)
			v369.Anchored = true
			v369.CanCollide = false
			v369.CanQuery = false
			v369.CanTouch = false
			v369.Transparency = 1
			v369.Parent = workspace
			for _, v370 in v369:GetDescendants() do
				if v370:IsA("ParticleEmitter") then
					v370:Emit(v370:GetAttribute("EmitCount") or 1)
				end
			end
			for _, v371 in v369:GetChildren() do
				if v371:IsA("ParticleEmitter") then
					v371:Emit(v371:GetAttribute("EmitCount") or 1)
				end
			end
			v_u_4:AddItem(v369, 2)
		end
	elseif p174 == "ShadowMonarch" then
		local v372 = weaponVFX:FindFirstChild("M" .. p_u_175)
		if v372 then
			local v373 = v372:Clone()
			local _, _, v374 = v372.CFrame:ToEulerAnglesXYZ()
			local v375 = v372.CFrame
			local v376 = v_u_178.CFrame * CFrame.Angles(0, 3.141592653589793, v374)
			v373.CFrame = v376
			v373.Anchored = true
			v373.CanCollide = false
			v373.CanQuery = false
			v373.CanTouch = false
			v373.Transparency = 1
			for _, v377 in v373:GetDescendants() do
				if v377:IsA("BasePart") then
					v377.CFrame = v376 * (v375:Inverse() * v377.CFrame)
					v377.Anchored = true
					v377.CanCollide = false
					v377.CanQuery = false
					v377.CanTouch = false
				end
			end
			v373.Parent = workspace
			for _, v378 in v373:GetDescendants() do
				if v378:IsA("ParticleEmitter") then
					v378:Emit(v378:GetAttribute("EmitCount") or 1)
				end
			end
			for _, v379 in v373:GetChildren() do
				if v379:IsA("ParticleEmitter") then
					v379:Emit(v379:GetAttribute("EmitCount") or 1)
				end
			end
			v_u_4:AddItem(v373, 2)
		end
	elseif p174 == "Rimuru" then
		local v380 = weaponVFX:FindFirstChild("SlashVFX")
		if v380 then
			local v381 = ({ 30, -30, 0 })[p_u_175] or 0
			local v382 = v380:Clone()
			v382.CFrame = v_u_178.CFrame * CFrame.Angles(0, 3.141592653589793, (math.rad(v381)))
			v382.Anchored = false
			v382.CanCollide = false
			v382.CanQuery = false
			v382.CanTouch = false
			v382.Massless = true
			v382.Transparency = 1
			v382.Parent = workspace
			local v383 = Instance.new("WeldConstraint")
			v383.Part0 = v382
			v383.Part1 = v_u_178
			v383.Parent = v382
			for v384 = 1, 3 do
				local v385 = v382:FindFirstChild("Slash" .. v384)
				if v385 then
					for _, v386 in v385:GetDescendants() do
						if v386:IsA("ParticleEmitter") then
							v386:Emit(v386:GetAttribute("EmitCount") or 1)
						end
					end
				end
			end
			v_u_4:AddItem(v382, 2)
		end
	elseif p174 == "Escanor" then
		local v387 = v_u_12:FindFirstChild("Escanor")
		if v387 then
			local v388 = v387:FindFirstChild("M" .. p_u_175)
			if v388 then
				local v_u_397 = (function(p389, p390)
					-- upvalues: (copy) v_u_178
					local v391 = p389:Clone()
					for _, v392 in v391:GetDescendants() do
						if v392:IsA("BasePart") then
							local v393 = p390:Inverse() * v392.CFrame
							v392.CFrame = v_u_178.CFrame * v393
							v392.Anchored = false
							v392.CanCollide = false
							v392.CanQuery = false
							v392.CanTouch = false
							v392.CastShadow = false
							v392.Massless = true
						end
					end
					for _, v394 in v391:GetDescendants() do
						if v394:IsA("ParticleEmitter") then
							v394.Enabled = false
						end
					end
					v391.Parent = workspace
					for _, v395 in v391:GetDescendants() do
						if v395:IsA("BasePart") then
							local v396 = Instance.new("WeldConstraint")
							v396.Part0 = v_u_178
							v396.Part1 = v395
							v396.Parent = v395
						end
					end
					return v391
				end)(v388, ({
					CFrame.new(-6.119, 3.012, -4.999),
					CFrame.new(-54.119, 3.012, -4.999),
					CFrame.new(-104.119, 3.012, -4.999),
					CFrame.new(-166.119, 3.012, -4.999)
				})[p_u_175])
				if p_u_175 == 1 then
					task.delay(0.4666666666666667, function()
						-- upvalues: (copy) v_u_178, (copy) v_u_397
						if v_u_178 and v_u_178.Parent then
							local v398 = v_u_397:FindFirstChild("mid")
							if v398 then
								for _, v399 in v398:GetDescendants() do
									if v399:IsA("ParticleEmitter") then
										v399:Emit(v399:GetAttribute("EmitCount") or 1)
									end
								end
							end
						end
					end)
					v_u_4:AddItem(v_u_397, 3.466666666666667)
					return
				elseif p_u_175 == 2 then
					local v400 = v_u_397:FindFirstChild("mid2")
					if v400 then
						for _, v401 in v400:GetDescendants() do
							if v401:IsA("ParticleEmitter") then
								v401:Emit(v401:GetAttribute("EmitCount") or 1)
							end
						end
					end
					task.delay(0.4, function()
						-- upvalues: (copy) v_u_178, (copy) v_u_397
						if v_u_178 and v_u_178.Parent then
							local v402 = v_u_397:FindFirstChild("mid22")
							if v402 then
								for _, v403 in v402:GetDescendants() do
									if v403:IsA("ParticleEmitter") then
										v403:Emit(v403:GetAttribute("EmitCount") or 1)
									end
								end
							end
						end
					end)
					task.delay(0.43333333333333335, function()
						-- upvalues: (copy) v_u_178, (copy) v_u_397
						if v_u_178 and v_u_178.Parent then
							local v404 = v_u_397:FindFirstChild("mid33")
							if v404 then
								for _, v405 in v404:GetDescendants() do
									if v405:IsA("ParticleEmitter") then
										v405:Emit(v405:GetAttribute("EmitCount") or 1)
									end
								end
							end
						end
					end)
					v_u_4:AddItem(v_u_397, 3.4333333333333336)
					return
				elseif p_u_175 == 3 then
					local v406 = v_u_397:FindFirstChild("charge")
					if v406 then
						for _, v_u_407 in v406:GetDescendants() do
							if v_u_407:IsA("ParticleEmitter") then
								v_u_407.Enabled = true
								task.delay(0.15, function()
									-- upvalues: (copy) v_u_407
									if v_u_407 and v_u_407.Parent then
										v_u_407.Enabled = false
									end
								end)
							end
						end
					end
					local v408 = v_u_397:FindFirstChild("aira")
					if v408 then
						for _, v_u_409 in v408:GetDescendants() do
							if v_u_409:IsA("ParticleEmitter") then
								v_u_409.Enabled = true
								task.delay(0.45, function()
									-- upvalues: (copy) v_u_409
									if v_u_409 and v_u_409.Parent then
										v_u_409.Enabled = false
									end
								end)
							end
						end
					end
					local v410 = v_u_397:FindFirstChild("kick1")
					if v410 then
						for _, v_u_411 in v410:GetDescendants() do
							if v_u_411:IsA("ParticleEmitter") then
								v_u_411.Enabled = true
								task.delay(0.45, function()
									-- upvalues: (copy) v_u_411
									if v_u_411 and v_u_411.Parent then
										v_u_411.Enabled = false
									end
								end)
							end
						end
					end
					task.delay(0.3333333333333333, function()
						-- upvalues: (copy) v_u_178, (copy) v_u_397
						if v_u_178 and v_u_178.Parent then
							local v412 = v_u_397:FindFirstChild("Kick")
							if v412 then
								for _, v413 in v412:GetDescendants() do
									if v413:IsA("ParticleEmitter") then
										v413:Emit(v413:GetAttribute("EmitCount") or 1)
									end
								end
							end
						end
					end)
					v_u_4:AddItem(v_u_397, 3.3333333333333335)
				elseif p_u_175 == 4 then
					local v414 = v_u_397:FindFirstChild("startdur")
					if v414 then
						for _, v_u_415 in v414:GetDescendants() do
							if v_u_415:IsA("ParticleEmitter") then
								v_u_415.Enabled = true
								task.delay(0.5, function()
									-- upvalues: (copy) v_u_415
									if v_u_415 and v_u_415.Parent then
										v_u_415.Enabled = false
									end
								end)
							end
						end
					end
					task.delay(0.3, function()
						-- upvalues: (copy) v_u_178, (copy) v_u_397
						if v_u_178 and v_u_178.Parent then
							local v416 = v_u_397:FindFirstChild("dura")
							if v416 then
								for _, v_u_417 in v416:GetDescendants() do
									if v_u_417:IsA("ParticleEmitter") then
										v_u_417.Enabled = true
										task.delay(0.35, function()
											-- upvalues: (copy) v_u_417
											if v_u_417 and v_u_417.Parent then
												v_u_417.Enabled = false
											end
										end)
									end
								end
							end
						end
					end)
					v_u_4:AddItem(v_u_397, 3.65)
				end
			else
				return
			end
		else
			return
		end
	else
		local v418 = weaponVFX:FindFirstChild("SlashVFX") or weaponVFX:FindFirstChild("EffSlash")
		if v418 then
			local v419 = v418:Clone()
			v419.CFrame = v_u_178.CFrame
			v419.Anchored = false
			v419.CanCollide = false
			v419.CanQuery = false
			v419.CanTouch = false
			v419.Massless = true
			v419.Transparency = 1
			v419.Parent = workspace
			local v420 = Instance.new("WeldConstraint")
			v420.Part0 = v419
			v420.Part1 = v_u_178
			v420.Parent = v419
			local v421 = v419:FindFirstChild("Slash" .. p_u_175) or v419:FindFirstChild("Eff" .. p_u_175)
			if v421 then
				for _, v422 in v421:GetDescendants() do
					if v422:IsA("ParticleEmitter") then
						v422:Emit(v422:GetAttribute("EmitCount") or 1)
					end
				end
			end
			if p174 == "Ichigo" and p_u_175 >= 2 then
				local v423 = p_u_175 == 2 and 0.9 or 0.8
				for _, v424 in v419:GetDescendants() do
					if v424:IsA("ParticleEmitter") then
						local v425 = v424.Size
						local v426 = {}
						for _, v427 in ipairs(v425.Keypoints) do
							local v428 = NumberSequenceKeypoint.new
							local v429 = v427.Time
							local v430 = v427.Value * v423
							local v431 = v427.Envelope * v423
							table.insert(v426, v428(v429, v430, v431))
						end
						v424.Size = NumberSequence.new(v426)
						v424.Speed = NumberRange.new(v424.Speed.Min * v423, v424.Speed.Max * v423)
					elseif v424:IsA("Attachment") then
						v424.Position = v424.Position * v423
					end
				end
			end
			if p174 == "Strongest Of Today" then
				v419.Size = v419.Size * 1.3
				for _, v432 in v419:GetDescendants() do
					if v432:IsA("ParticleEmitter") then
						local v433 = v432.Size
						local v434 = {}
						for _, v435 in ipairs(v433.Keypoints) do
							local v436 = NumberSequenceKeypoint.new
							local v437 = v435.Time
							local v438 = v435.Value * 1.3
							local v439 = v435.Envelope * 1.3
							table.insert(v434, v436(v437, v438, v439))
						end
						v432.Size = NumberSequence.new(v434)
					elseif v432:IsA("Attachment") then
						v432.Position = v432.Position * 1.3
					end
				end
			end
			v_u_4:AddItem(v419, 2)
		end
	end
end
local function v_u_445(p441, p442, p443)
	-- upvalues: (ref) v_u_28, (copy) v_u_24, (ref) v_u_25, (copy) v_u_173, (copy) v_u_77
	if v_u_28 and v_u_28.IsPlaying then
		v_u_28:Stop(0.1)
	end
	if v_u_24.CurrentTrack and v_u_24.CurrentTrack.IsPlaying then
		v_u_24.CurrentTrack:Stop(0.1)
	end
	if v_u_25 then
		v_u_25:Disconnect()
		v_u_25 = nil
	end
	local v444 = v_u_173(p441, p442)
	if v444 then
		v444:Play(0.1)
		v444:AdjustSpeed(p443 or 1)
		v_u_24.CurrentTrack = v444
		v_u_25 = v444.Ended:Once(function()
			-- upvalues: (ref) v_u_24, (ref) v_u_25, (ref) v_u_77
			v_u_24.IsAttacking = false
			v_u_25 = nil
			v_u_77()
		end)
	end
end
local function v_u_448()
	-- upvalues: (ref) v_u_25, (ref) v_u_26, (copy) v_u_24
	if v_u_25 then
		v_u_25:Disconnect()
		v_u_25 = nil
	end
	for _, v446 in pairs(v_u_26) do
		for _, v447 in pairs(v446) do
			if v447 then
				v447:Stop()
				v447:Destroy()
			end
		end
	end
	v_u_26 = {}
	v_u_24.CurrentTrack = nil
end
local function v504(p449, p450)
	-- upvalues: (copy) v_u_7, (ref) v_u_19, (copy) v_u_58, (copy) v_u_9, (copy) v_u_24, (copy) v_u_445, (copy) v_u_77, (copy) v_u_440, (copy) v_u_14, (ref) v_u_51, (copy) v_u_12, (copy) v_u_4, (copy) v_u_16, (copy) v_u_18
	if p450 then
		return
	elseif _G.YujiCharging == true then
		return
	else
		local v451 = v_u_7.Character
		local v452
		if v451 then
			v452 = v451:FindFirstChild("Humanoid")
		else
			v452 = v451
		end
		if v451 and (v452 and v452.Health > 0) then
			if v_u_19 then
				return
			elseif v451 and v451:GetAttribute("InArtifactUI") then
				return
			elseif v451 and v451:GetAttribute("InCutscene") then
				return
			elseif (p449.UserInputType == Enum.UserInputType.MouseButton1 or p449.UserInputType == Enum.UserInputType.Touch) and true or p449.KeyCode == Enum.KeyCode.ButtonR2 then
				local v453, v454 = v_u_58()
				if v453 then
					if v454.Combo then
						local v455 = tick()
						if (v454.HitCooldown or v_u_9.Settings.HitCooldown) > v455 - v_u_24.LastHitTime then
							return
						else
							local v456 = v455 - v_u_24.LastHitTime
							local v457 = v_u_24.LastWeapon ~= v453
							v_u_24.LastWeapon = v453
							local v458
							if v457 or ((v454.ComboResetTime or v_u_9.Settings.ComboResetTime) < v456 or v_u_24.ComboIndex == 0) then
								v458 = 1
							else
								local v459 = v_u_24.ComboIndex + 1
								v458 = v454.ComboCount < v459 and 1 or v459
							end
							v_u_24.ComboIndex = v458
							v_u_24.LastHitTime = v455
							v_u_24.IsAttacking = true
							local v460 = v454.Combo[v458]
							if v453 == "Gilgamesh" and (v458 == 1 or v458 == 3) then
								task.delay(0.3, function()
									-- upvalues: (ref) v_u_24, (ref) v_u_77
									if v_u_24.IsAttacking then
										v_u_24.IsAttacking = false
										v_u_77()
									end
								end)
							else
								v_u_445(v453, v458, v460 and v460.AnimationSpeed or 1)
							end
							v_u_440(v453, v458)
							if v453 == "Combat" then
								v_u_14:Play("CombatSwing" .. v_u_51)
								v_u_51 = v_u_51 % 4 + 1
							elseif v453 == "Katana" then
								v_u_14:Play(({ "KatanaM1_1", "KatanaM1_2", "KatanaM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Saber" then
								v_u_14:Play(v458 % 2 == 1 and "SaberSlash1" or "SaberSlash2")
							elseif v453 == "Gojo" or v453 == "Strongest Of Today" then
								v_u_14:Play(({ "GojoM1_Blue", "GojoM1_Red", "GojoM1_Purple" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Sukuna" then
								v_u_14:Play(({ "SukunaM1_1", "SukunaM1_2", "SukunaM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Jinwoo" then
								v_u_14:Play(({ "JinwooM1_1", "JinwooM1_2", "JinwooM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Light" then
								v_u_14:Play(({ "LightM1_1", "LightM1_2", "LightM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "DarkBlade" then
								v_u_14:Play(({ "DarkBladeM1_1", "DarkBladeM1_2", "DarkBladeM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Ragna" then
								v_u_14:Play(v458 % 2 == 1 and "RagnaM1_1" or "RagnaM1_2")
							elseif v453 == "Aizen" then
								v_u_14:Play(({ "AizenM1_1", "AizenM1_2", "AizenM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Qin Shi" then
								v_u_14:Play(({ "QinShiM1_1", "QinShiM1_2", "QinShiM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Yuji" then
								v_u_14:Play(({ "YujiM1_1", "YujiM1_2", "YujiM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Shadow" then
								v_u_14:Play(({ "ShadowM1_1", "ShadowM1_2", "ShadowM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Alucard" then
								local v_u_461 = { "AlucardM1_1", "AlucardM1_2", "AlucardM1_3" }
								local v_u_462 = (v458 - 1) % 3 + 1
								task.delay(0.45, function()
									-- upvalues: (ref) v_u_14, (copy) v_u_461, (copy) v_u_462
									v_u_14:Play(v_u_461[v_u_462])
								end)
							elseif v453 == "Strongest In History" then
								v_u_14:Play(({ "StrongestInHistoryM1_1", "StrongestInHistoryM1_2", "StrongestInHistoryM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Ichigo" then
								v_u_14:Play(({ "IchigoM1_1", "IchigoM1_2", "IchigoM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Rimuru" then
								v_u_14:Play(({ "RimuruM1_1", "RimuruM1_2", "RimuruM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Madoka" then
								v_u_14:Play(({ "MadokaM1_1", "MadokaM1_2", "MadokaM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "Gilgamesh" then
								v_u_14:Play(({
									"GilgameshM1_1",
									"GilgameshM1_2",
									"GilgameshM1_3",
									"GilgameshM1_4"
								})[(v458 - 1) % 4 + 1])
							elseif v453 == "Anos" then
								v_u_14:Play(({ "AnosM1_1", "AnosM1_2", "AnosM1_3" })[(v458 - 1) % 3 + 1])
							elseif v453 == "ShadowMonarch" then
								v_u_14:Play(({
									"ShadowMonarchM1_1",
									"ShadowMonarchM1_2",
									"ShadowMonarchM1_3",
									"ShadowMonarchM1_4"
								})[(v458 - 1) % 4 + 1])
							elseif v453 == "Escanor" then
								v_u_14:Play(({
									"EscanorM1_1",
									"EscanorM1_2",
									"EscanorM1_3",
									"EscanorM1_4"
								})[(v458 - 1) % 4 + 1])
							elseif v453 == "True Aizen" then
								v_u_14:Play(({
									"TrueAizenM1_1",
									"TrueAizenM1_2",
									"TrueAizenM1_3",
									"TrueAizenM1_4"
								})[(v458 - 1) % 4 + 1])
							elseif v453 == "Yamato" then
								v_u_14:Play(({
									"YamatoM1_1",
									"YamatoM1_2",
									"YamatoM1_3",
									"YamatoM1_4"
								})[(v458 - 1) % 4 + 1])
							elseif v453 == "Blessed Maiden" then
								v_u_14:Play(({
									"BlessedMaidenM1_1",
									"BlessedMaidenM1_2",
									"BlessedMaidenM1_3",
									"BlessedMaidenM1_4"
								})[(v458 - 1) % 4 + 1])
							end
							if v453 == "Blessed Maiden" and v_u_7:GetAttribute("DisableVFX") ~= true then
								local v463 = v_u_7.Character
								if v463 then
									v463 = v463:FindFirstChild("HumanoidRootPart")
								end
								if v463 then
									local v464 = v_u_12:FindFirstChild("BlessedMaiden") or v_u_12:FindFirstChild("Blessed Maiden")
									if v464 then
										local v465 = (v458 - 1) % 4 + 1
										local v466 = ({
											{
												["template"] = "m1/4",
												["delay"] = 0.13333333333333333
											},
											{
												["template"] = "m2/4",
												["delay"] = 0.11666666666666667
											},
											{
												["template"] = "m3/4",
												["delay"] = 0.08333333333333333
											},
											{
												["template"] = "m4/4",
												["delay"] = 0.16666666666666666
											}
										})[v465]
										if v466 then
											local v467 = v464:FindFirstChild(v466.template)
											if v467 then
												local v_u_468 = v467:Clone()
												local v469 = CFrame.new(-73.2, 2.49, 1.48)
												local v470 = {}
												if v_u_468:IsA("BasePart") then
													table.insert(v470, v_u_468)
												end
												for _, v471 in v_u_468:GetDescendants() do
													if v471:IsA("BasePart") then
														table.insert(v470, v471)
													end
												end
												for _, v472 in ipairs(v470) do
													local v473 = v469:Inverse() * v472.CFrame
													v472.CFrame = v463.CFrame * v473
													v472.Anchored = true
													v472.CanCollide = false
													v472.CanQuery = false
													v472.CanTouch = false
													v472.CastShadow = false
													v472.Massless = true
												end
												for _, v474 in v_u_468:GetDescendants() do
													if v474:IsA("ParticleEmitter") then
														v474.Enabled = false
													end
												end
												v_u_468.Parent = workspace
												task.delay(v466.delay, function()
													-- upvalues: (copy) v_u_468
													if v_u_468 and v_u_468.Parent then
														if shared.vfx and shared.vfx.emit then
															pcall(function()
																-- upvalues: (ref) v_u_468
																shared.vfx.emit(v_u_468)
															end)
														end
													end
												end)
												v_u_4:AddItem(v_u_468, 3)
												if v465 == 2 then
													local v475 = v464:FindFirstChild("m2/4.2")
													if v475 then
														local v_u_476 = v475:Clone()
														local v477 = {}
														if v_u_476:IsA("BasePart") then
															table.insert(v477, v_u_476)
														end
														for _, v478 in v_u_476:GetDescendants() do
															if v478:IsA("BasePart") then
																table.insert(v477, v478)
															end
														end
														for _, v479 in ipairs(v477) do
															local v480 = v469:Inverse() * v479.CFrame
															v479.CFrame = v463.CFrame * v480
															v479.Anchored = true
															v479.CanCollide = false
															v479.CanQuery = false
															v479.CanTouch = false
															v479.CastShadow = false
															v479.Massless = true
														end
														for _, v481 in v_u_476:GetDescendants() do
															if v481:IsA("ParticleEmitter") then
																v481.Enabled = false
															end
														end
														v_u_476.Parent = workspace
														task.delay(0.36666666666666664, function()
															-- upvalues: (copy) v_u_476
															if v_u_476 and v_u_476.Parent then
																if shared.vfx and shared.vfx.emit then
																	pcall(function()
																		-- upvalues: (ref) v_u_476
																		shared.vfx.emit(v_u_476)
																	end)
																end
															end
														end)
														v_u_4:AddItem(v_u_476, 3)
													end
												end
											end
										end
									end
								end
							end
							if v453 == "True Aizen" and v_u_7:GetAttribute("DisableVFX") ~= true then
								local v482 = v_u_7.Character
								if v482 then
									v482 = v482:FindFirstChild("HumanoidRootPart")
								end
								if v482 then
									local v483 = v_u_12:FindFirstChild("TrueAizen") or v_u_12:FindFirstChild("True Aizen")
									if v483 then
										local v484 = ({
											{
												["template"] = "m1/4",
												["delay"] = 0.11666666666666667
											},
											{
												["template"] = "m2/4",
												["delay"] = 0.08333333333333333
											},
											{
												["template"] = "m3/4",
												["delay"] = 0.1
											},
											{
												["template"] = "m4/4",
												["delay"] = 0.11666666666666667
											}
										})[(v458 - 1) % 4 + 1]
										if v484 then
											local v485 = v483:FindFirstChild(v484.template)
											if v485 then
												local v_u_486 = v485:Clone()
												local v487 = CFrame.new(-108.95, 2.49, 0.59)
												local v488 = {}
												if v_u_486:IsA("BasePart") then
													table.insert(v488, v_u_486)
												end
												for _, v489 in v_u_486:GetDescendants() do
													if v489:IsA("BasePart") then
														table.insert(v488, v489)
													end
												end
												for _, v490 in ipairs(v488) do
													local v491 = v487:Inverse() * v490.CFrame
													v490.CFrame = v482.CFrame * v491
													v490.Anchored = true
													v490.CanCollide = false
													v490.CanQuery = false
													v490.CanTouch = false
													v490.CastShadow = false
													v490.Massless = true
												end
												for _, v492 in v_u_486:GetDescendants() do
													if v492:IsA("ParticleEmitter") then
														v492.Enabled = false
													end
												end
												v_u_486.Parent = workspace
												task.delay(v484.delay, function()
													-- upvalues: (copy) v_u_486
													if v_u_486 and v_u_486.Parent then
														if shared.vfx and shared.vfx.emit then
															pcall(function()
																-- upvalues: (ref) v_u_486
																shared.vfx.emit(v_u_486)
															end)
														end
													end
												end)
												v_u_4:AddItem(v_u_486, 3)
											end
										end
									end
								end
							end
							if v453 == "Yamato" and v_u_7:GetAttribute("DisableVFX") ~= true then
								local v493 = v_u_7.Character
								if v493 then
									v493 = v493:FindFirstChild("HumanoidRootPart")
								end
								if v493 then
									local v494 = v_u_12:FindFirstChild("Yamato")
									if v494 then
										local v495 = ({
											{
												["template"] = "m1/4",
												["delay"] = 0.11666666666666667
											},
											{
												["template"] = "m2/4",
												["delay"] = 0.1
											},
											{
												["template"] = "m3/4",
												["delay"] = 0.1
											},
											{
												["template"] = "m4/4",
												["delay"] = 0.11666666666666667
											}
										})[(v458 - 1) % 4 + 1]
										if v495 then
											local v496 = v494:FindFirstChild(v495.template)
											if v496 then
												local v_u_497 = v496:Clone()
												local v498 = CFrame.new(-150.69, 2.49, -5.51)
												local v499 = {}
												if v_u_497:IsA("BasePart") then
													table.insert(v499, v_u_497)
												end
												for _, v500 in v_u_497:GetDescendants() do
													if v500:IsA("BasePart") then
														table.insert(v499, v500)
													end
												end
												for _, v501 in ipairs(v499) do
													local v502 = v498:Inverse() * v501.CFrame
													v501.CFrame = v493.CFrame * v502
													v501.Anchored = true
													v501.CanCollide = false
													v501.CanQuery = false
													v501.CanTouch = false
													v501.CastShadow = false
													v501.Massless = true
												end
												for _, v503 in v_u_497:GetDescendants() do
													if v503:IsA("ParticleEmitter") then
														v503.Enabled = false
													end
												end
												v_u_497.Parent = workspace
												task.delay(v495.delay, function()
													-- upvalues: (copy) v_u_497
													if v_u_497 and v_u_497.Parent then
														if shared.vfx and shared.vfx.emit then
															pcall(function()
																-- upvalues: (ref) v_u_497
																shared.vfx.emit(v_u_497)
															end)
														end
													end
												end)
												v_u_4:AddItem(v_u_497, 3)
											end
										end
									end
								end
							end
							if v453 == "Gilgamesh" and (v458 == 1 or v458 == 3) then
								v_u_18:FireServer(v458)
							else
								v_u_16:FireServer()
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
		else
			return
		end
	end
end
v17.OnClientEvent:Connect(function(p505)
	-- upvalues: (copy) v_u_7, (copy) v_u_14, (ref) v_u_52, (ref) v_u_53, (copy) v_u_11, (copy) v_u_50, (copy) v_u_12, (copy) v_u_4
	local v_u_506 = p505.Caster
	if v_u_506 then
		if v_u_506 == v_u_7 then
			if p505.HitCount and p505.HitCount > 0 then
				if p505.WeaponName == "Combat" or (p505.WeaponName == "Qin Shi" or (p505.WeaponName == "Yuji" or (p505.WeaponName == "Strongest In History" or (p505.WeaponName == "Madoka" or (p505.WeaponName == "Gilgamesh" or (p505.WeaponName == "Anos" or p505.WeaponName == "Escanor")))))) then
					v_u_14:Play("CombatHit" .. v_u_52)
					v_u_52 = v_u_52 % 7 + 1
					return
				end
				if p505.WeaponName == "Katana" or (p505.WeaponName == "Saber" or (p505.WeaponName == "DarkBlade" or (p505.WeaponName == "Ragna" or (p505.WeaponName == "Aizen" or (p505.WeaponName == "Shadow" or (p505.WeaponName == "Ichigo" or p505.WeaponName == "Rimuru")))))) then
					v_u_14:Play("SwordHit" .. v_u_53)
					v_u_53 = v_u_53 % 2 + 1
				end
			end
			return
		else
			local v507 = v_u_506.Character
			if v507 then
				local v_u_508 = v507:FindFirstChild("HumanoidRootPart")
				local v509 = v507:FindFirstChild("Humanoid")
				if v_u_508 and v509 then
					local v510 = p505.WeaponName
					local v511 = p505.ComboIndex
					local v512 = v509:FindFirstChild("Animator")
					if v512 then
						local v513 = v_u_11:FindFirstChild(v510)
						local v514 = v513 and v513:FindFirstChild("M" .. v511)
						if v514 then
							local v515 = v_u_50[v_u_506]
							if v515 then
								if v515.connection then
									v515.connection:Disconnect()
								end
								if v515.track then
									v515.track:Stop(0.05)
									v515.track:Destroy()
								end
							end
							local v_u_516 = v512:LoadAnimation(v514)
							v_u_516.Looped = false
							v_u_516.Priority = Enum.AnimationPriority.Action
							v_u_516:Play(0.1)
							v_u_50[v_u_506] = {
								["track"] = v_u_516,
								["connection"] = v_u_516.Ended:Once(function()
									-- upvalues: (ref) v_u_50, (copy) v_u_506, (copy) v_u_516
									if v_u_50[v_u_506] and v_u_50[v_u_506].track == v_u_516 then
										v_u_50[v_u_506] = nil
									end
									v_u_516:Destroy()
								end)
							}
						end
					end
					if v510 == "Combat" then
						if p505.HitCount and p505.HitCount > 0 then
							v_u_14:PlayAt("CombatHit1", v_u_508.Position)
						else
							v_u_14:PlayAt("CombatSwing1", v_u_508.Position)
						end
					elseif v510 == "Katana" then
						v_u_14:PlayAt(({ "KatanaM1_1", "KatanaM1_2", "KatanaM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Saber" then
						v_u_14:PlayAt("SaberSlash1", v_u_508.Position)
					elseif v510 == "Gojo" or v510 == "Strongest Of Today" then
						v_u_14:PlayAt(({ "GojoM1_Blue", "GojoM1_Red", "GojoM1_Purple" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Sukuna" then
						v_u_14:PlayAt(({ "SukunaM1_1", "SukunaM1_2", "SukunaM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Jinwoo" then
						v_u_14:PlayAt(({ "JinwooM1_1", "JinwooM1_2", "JinwooM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "DarkBlade" then
						v_u_14:PlayAt(({ "DarkBladeM1_1", "DarkBladeM1_2", "DarkBladeM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Ragna" then
						v_u_14:PlayAt(v511 % 2 == 1 and "RagnaM1_1" or "RagnaM1_2", v_u_508.Position)
					elseif v510 == "Aizen" then
						v_u_14:PlayAt(({ "AizenM1_1", "AizenM1_2", "AizenM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Qin Shi" then
						v_u_14:PlayAt(({ "QinShiM1_1", "QinShiM1_2", "QinShiM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Strongest In History" then
						v_u_14:PlayAt(({ "StrongestInHistoryM1_1", "StrongestInHistoryM1_2", "StrongestInHistoryM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Yuji" then
						v_u_14:PlayAt(({ "YujiM1_1", "YujiM1_2", "YujiM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Shadow" then
						v_u_14:PlayAt(({ "ShadowM1_1", "ShadowM1_2", "ShadowM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Ichigo" then
						v_u_14:PlayAt(({ "IchigoM1_1", "IchigoM1_2", "IchigoM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Rimuru" then
						v_u_14:PlayAt(({ "RimuruM1_1", "RimuruM1_2", "RimuruM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Madoka" then
						v_u_14:PlayAt(({ "MadokaM1_1", "MadokaM1_2", "MadokaM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "Gilgamesh" then
						v_u_14:PlayAt(({
							"GilgameshM1_1",
							"GilgameshM1_2",
							"GilgameshM1_3",
							"GilgameshM1_4"
						})[(v511 - 1) % 4 + 1], v_u_508.Position)
					elseif v510 == "Anos" then
						v_u_14:PlayAt(({ "AnosM1_1", "AnosM1_2", "AnosM1_3" })[(v511 - 1) % 3 + 1], v_u_508.Position)
					elseif v510 == "ShadowMonarch" then
						v_u_14:PlayAt(({
							"ShadowMonarchM1_1",
							"ShadowMonarchM1_2",
							"ShadowMonarchM1_3",
							"ShadowMonarchM1_4"
						})[(v511 - 1) % 4 + 1], v_u_508.Position)
					elseif v510 == "Escanor" then
						v_u_14:PlayAt(({
							"EscanorM1_1",
							"EscanorM1_2",
							"EscanorM1_3",
							"EscanorM1_4"
						})[(v511 - 1) % 4 + 1], v_u_508.Position)
					elseif v510 == "True Aizen" then
						v_u_14:PlayAt(({
							"TrueAizenM1_1",
							"TrueAizenM1_2",
							"TrueAizenM1_3",
							"TrueAizenM1_4"
						})[(v511 - 1) % 4 + 1], v_u_508.Position)
					elseif v510 == "Yamato" then
						v_u_14:PlayAt(({
							"YamatoM1_1",
							"YamatoM1_2",
							"YamatoM1_3",
							"YamatoM1_4"
						})[(v511 - 1) % 4 + 1], v_u_508.Position)
					elseif v510 == "Blessed Maiden" then
						v_u_14:PlayAt(({
							"BlessedMaidenM1_1",
							"BlessedMaidenM1_2",
							"BlessedMaidenM1_3",
							"BlessedMaidenM1_4"
						})[(v511 - 1) % 4 + 1], v_u_508.Position)
					end
					if v_u_7:GetAttribute("DisableVFX") == true then
						return
					elseif v_u_7:GetAttribute("DisableOtherVFX") then
						return
					else
						local v_u_517 = v_u_12:FindFirstChild(v510)
						if v_u_517 then
							if v510 == "Qin Shi" then
								local v518 = v_u_517:FindFirstChild("Punch" .. v511)
								if v518 then
									local v519 = v518:Clone()
									v519.CFrame = v_u_508.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0)
									v519.Anchored = true
									v519.CanCollide = false
									v519.CanQuery = false
									v519.CanTouch = false
									v519.Transparency = 1
									v519.Parent = workspace
									for _, v520 in v519:GetDescendants() do
										if v520:IsA("ParticleEmitter") then
											v520:Emit(v520:GetAttribute("EmitCount") or 1)
										end
									end
									for _, v521 in v519:GetChildren() do
										if v521:IsA("ParticleEmitter") then
											v521:Emit(v521:GetAttribute("EmitCount") or 1)
										end
									end
									v_u_4:AddItem(v519, 2)
								end
								return
							elseif v510 == "Strongest In History" then
								local v522 = v_u_517:FindFirstChild("Punch" .. v511)
								if v522 then
									local v523 = v522:Clone()
									v523.CFrame = v_u_508.CFrame * CFrame.new(0, 0, -10.5) * CFrame.Angles(0, 1.5707963267948966, 0)
									v523.Anchored = true
									v523.CanCollide = false
									v523.CanQuery = false
									v523.CanTouch = false
									v523.Transparency = 1
									v523.Parent = workspace
									for _, v524 in v523:GetDescendants() do
										if v524:IsA("ParticleEmitter") then
											v524:Emit(v524:GetAttribute("EmitCount") or 1)
										end
									end
									for _, v525 in v523:GetChildren() do
										if v525:IsA("ParticleEmitter") then
											v525:Emit(v525:GetAttribute("EmitCount") or 1)
										end
									end
									v_u_4:AddItem(v523, 2)
								end
								return
							elseif v510 == "Madoka" then
								local v526 = v_u_517:FindFirstChild("Punch" .. v511)
								if v526 then
									local v527 = v526:Clone()
									v527.CFrame = v_u_508.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0)
									v527.Anchored = true
									v527.CanCollide = false
									v527.CanQuery = false
									v527.CanTouch = false
									v527.Transparency = 1
									v527.Parent = workspace
									for _, v528 in v527:GetDescendants() do
										if v528:IsA("ParticleEmitter") then
											v528:Emit(v528:GetAttribute("EmitCount") or 1)
										end
									end
									for _, v529 in v527:GetChildren() do
										if v529:IsA("ParticleEmitter") then
											v529:Emit(v529:GetAttribute("EmitCount") or 1)
										end
									end
									v_u_4:AddItem(v527, 2)
								end
								return
							elseif v510 == "Gilgamesh" then
								local v_u_530 = CFrame.new(-437.6, 3, -192.8)
								local function v_u_539(p531, p532)
									-- upvalues: (copy) v_u_517, (copy) v_u_530
									local v533 = v_u_517:FindFirstChild(p531)
									if not v533 then
										return nil
									end
									local v534 = v533:Clone()
									local v535 = {}
									if v534:IsA("BasePart") then
										table.insert(v535, v534)
									end
									for _, v536 in v534:GetDescendants() do
										if v536:IsA("BasePart") then
											table.insert(v535, v536)
										end
									end
									for _, v537 in ipairs(v535) do
										v537.CFrame = p532 * (v_u_530:Inverse() * v537.CFrame)
										v537.Anchored = true
										v537.CanCollide = false
										v537.CanQuery = false
										v537.CanTouch = false
										v537.CastShadow = false
										v537.Massless = true
									end
									for _, v538 in v534:GetDescendants() do
										if v538:IsA("ParticleEmitter") then
											v538.Enabled = false
										end
									end
									v534.Parent = workspace
									return v534
								end
								if v511 == 2 then
									task.delay(0.16666666666666666, function()
										-- upvalues: (copy) v_u_508, (copy) v_u_539, (ref) v_u_4
										if v_u_508 and v_u_508.Parent then
											local v540 = v_u_539("Gate", v_u_508.CFrame)
											if v540 then
												for _, v_u_541 in v540:GetDescendants() do
													if v_u_541:IsA("ParticleEmitter") then
														v_u_541.Enabled = true
														task.delay(0.3, function()
															-- upvalues: (copy) v_u_541
															if v_u_541 and v_u_541.Parent then
																v_u_541.Enabled = false
															end
														end)
													end
												end
												v_u_4:AddItem(v540, 3)
											end
										end
									end)
									task.delay(0.5666666666666667, function()
										-- upvalues: (copy) v_u_508, (copy) v_u_539, (ref) v_u_4
										if v_u_508 and v_u_508.Parent then
											local v542 = v_u_539("SlashVFX", v_u_508.CFrame)
											if v542 then
												for _, v543 in v542:GetDescendants() do
													if v543:IsA("ParticleEmitter") then
														v543:Emit(v543:GetAttribute("EmitCount") or 1)
													end
												end
												v_u_4:AddItem(v542, 3)
											end
										end
									end)
								end
								if v511 == 4 then
									local v544 = v_u_539("Gate1", v_u_508.CFrame)
									if v544 then
										for _, v_u_545 in v544:GetDescendants() do
											if v_u_545:IsA("ParticleEmitter") then
												v_u_545.Enabled = true
												task.delay(0.3, function()
													-- upvalues: (copy) v_u_545
													if v_u_545 and v_u_545.Parent then
														v_u_545.Enabled = false
													end
												end)
											end
										end
										v_u_4:AddItem(v544, 3)
									end
									task.delay(0.43333333333333335, function()
										-- upvalues: (copy) v_u_508, (copy) v_u_539, (ref) v_u_4
										if v_u_508 and v_u_508.Parent then
											local v546 = v_u_539("Punch1", v_u_508.CFrame)
											if v546 then
												for _, v547 in v546:GetDescendants() do
													if v547:IsA("ParticleEmitter") then
														v547:Emit(v547:GetAttribute("EmitCount") or 1)
													end
												end
												v_u_4:AddItem(v546, 3)
											end
										end
									end)
								end
								local v548 = v_u_517:FindFirstChild("Punch" .. v511)
								if v548 then
									local v549 = v548:Clone()
									v549.CFrame = v_u_508.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0)
									v549.Anchored = true
									v549.CanCollide = false
									v549.CanQuery = false
									v549.CanTouch = false
									v549.Transparency = 1
									v549.Parent = workspace
									for _, v550 in v549:GetDescendants() do
										if v550:IsA("ParticleEmitter") then
											v550:Emit(v550:GetAttribute("EmitCount") or 1)
										end
									end
									for _, v551 in v549:GetChildren() do
										if v551:IsA("ParticleEmitter") then
											v551:Emit(v551:GetAttribute("EmitCount") or 1)
										end
									end
									v_u_4:AddItem(v549, 2)
								end
								return
							elseif v510 == "Alucard" then
								local v552 = v_u_12:FindFirstChild("Alucard")
								local v553 = v552 and v552:FindFirstChild("Punch" .. v511)
								if v553 then
									local v554 = v553:Clone()
									v554.CFrame = v_u_508.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0)
									v554.Anchored = false
									v554.CanCollide = false
									v554.CanQuery = false
									v554.CanTouch = false
									v554.Massless = true
									v554.CastShadow = false
									v554.Transparency = 1
									v554.Parent = workspace
									local v555 = Instance.new("WeldConstraint")
									v555.Part0 = v_u_508
									v555.Part1 = v554
									v555.Parent = v554
									local v556 = Color3.fromRGB(0, 170, 255)
									local v557 = Color3.fromRGB(255, 50, 50)
									if v511 == 1 then
										v557 = v556
									elseif v511 == 2 then
										v556 = v557
									end
									for _, v558 in v554:GetDescendants() do
										if v558:IsA("ParticleEmitter") then
											local v559 = v558.Color
											local v560 = {}
											for _, v561 in ipairs(v559.Keypoints) do
												local v562 = v556:Lerp(v557, v561.Time)
												local v563 = ColorSequenceKeypoint.new
												local v564 = v561.Time
												table.insert(v560, v563(v564, v562))
											end
											v558.Color = ColorSequence.new(v560)
											local v565 = v558.Size
											local v566 = {}
											for _, v567 in ipairs(v565.Keypoints) do
												local v568 = NumberSequenceKeypoint.new
												local v569 = v567.Time
												local v570 = v567.Value * 0.6
												local v571 = v567.Envelope * 0.6
												table.insert(v566, v568(v569, v570, v571))
											end
											v558.Size = NumberSequence.new(v566)
											if v511 == 3 then
												v558.Lifetime = NumberRange.new(v558.Lifetime.Min * 1.5, v558.Lifetime.Max * 1.5)
											end
											v558:Emit(v558:GetAttribute("EmitCount") or 1)
										end
									end
									for _, v572 in v554:GetChildren() do
										if v572:IsA("ParticleEmitter") then
											local v573 = v572.Color
											local v574 = {}
											for _, v575 in ipairs(v573.Keypoints) do
												local v576 = v556:Lerp(v557, v575.Time)
												local v577 = ColorSequenceKeypoint.new
												local v578 = v575.Time
												table.insert(v574, v577(v578, v576))
											end
											v572.Color = ColorSequence.new(v574)
											local v579 = v572.Size
											local v580 = {}
											for _, v581 in ipairs(v579.Keypoints) do
												local v582 = NumberSequenceKeypoint.new
												local v583 = v581.Time
												local v584 = v581.Value * 0.6
												local v585 = v581.Envelope * 0.6
												table.insert(v580, v582(v583, v584, v585))
											end
											v572.Size = NumberSequence.new(v580)
											if v511 == 3 then
												v572.Lifetime = NumberRange.new(v572.Lifetime.Min * 1.5, v572.Lifetime.Max * 1.5)
											end
											v572:Emit(v572:GetAttribute("EmitCount") or 1)
										end
									end
									v_u_4:AddItem(v554, v511 == 3 and 4 or 2)
								end
								return
							elseif v510 == "Rimuru" then
								local v586 = v_u_517:FindFirstChild("SlashVFX")
								if v586 then
									local v587 = v586:Clone()
									v587.CFrame = v_u_508.CFrame
									v587.Anchored = false
									v587.CanCollide = false
									v587.CanQuery = false
									v587.CanTouch = false
									v587.Massless = true
									v587.Transparency = 1
									v587.Parent = workspace
									local v588 = Instance.new("WeldConstraint")
									v588.Part0 = v587
									v588.Part1 = v_u_508
									v588.Parent = v587
									for v589 = 1, 3 do
										local v590 = v587:FindFirstChild("Slash" .. v589)
										if v590 then
											for _, v591 in v590:GetDescendants() do
												if v591:IsA("ParticleEmitter") then
													v591:Emit(v591:GetAttribute("EmitCount") or 1)
												end
											end
										end
									end
									v_u_4:AddItem(v587, 2)
								end
								return
							elseif v510 == "Yamato" then
								local v592 = v_u_12:FindFirstChild("Yamato")
								if v592 then
									local v593 = ({
										{
											["template"] = "m1/4"
										},
										{
											["template"] = "m2/4"
										},
										{
											["template"] = "m3/4"
										},
										{
											["template"] = "m4/4"
										}
									})[(v511 - 1) % 4 + 1]
									local v594 = v593 and v592:FindFirstChild(v593.template)
									if v594 then
										local v_u_595 = v594:Clone()
										local v596 = CFrame.new(-150.69, 2.49, -5.51)
										local v597 = {}
										if v_u_595:IsA("BasePart") then
											table.insert(v597, v_u_595)
										end
										for _, v598 in v_u_595:GetDescendants() do
											if v598:IsA("BasePart") then
												table.insert(v597, v598)
											end
										end
										for _, v599 in ipairs(v597) do
											local v600 = v596:Inverse() * v599.CFrame
											v599.CFrame = v_u_508.CFrame * v600
											v599.Anchored = true
											v599.CanCollide = false
											v599.CanQuery = false
											v599.CanTouch = false
											v599.CastShadow = false
											v599.Massless = true
										end
										for _, v601 in v_u_595:GetDescendants() do
											if v601:IsA("ParticleEmitter") then
												v601.Enabled = false
											end
										end
										v_u_595.Parent = workspace
										if shared.vfx and shared.vfx.emit then
											pcall(function()
												-- upvalues: (copy) v_u_595
												shared.vfx.emit(v_u_595)
											end)
										end
										v_u_4:AddItem(v_u_595, 3)
									end
								end
								return
							else
								local v602 = v_u_517:FindFirstChild("SlashVFX") or v_u_517:FindFirstChild("EffSlash")
								if v602 then
									local v603 = v602:Clone()
									v603.CFrame = v_u_508.CFrame
									v603.Anchored = false
									v603.CanCollide = false
									v603.CanQuery = false
									v603.CanTouch = false
									v603.Massless = true
									v603.Transparency = 1
									v603.Parent = workspace
									local v604 = Instance.new("WeldConstraint")
									v604.Part0 = v603
									v604.Part1 = v_u_508
									v604.Parent = v603
									local v605 = v603:FindFirstChild("Slash" .. v511) or v603:FindFirstChild("Eff" .. (v510 == "Ichigo" and 1 or v511))
									if v605 then
										for _, v606 in v605:GetDescendants() do
											if v606:IsA("ParticleEmitter") then
												v606:Emit(v606:GetAttribute("EmitCount") or 1)
											end
										end
									end
									v_u_4:AddItem(v603, 2)
								end
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
	else
		return
	end
end)
local function v_u_613(p607)
	-- upvalues: (copy) v_u_15, (copy) v_u_58, (copy) v_u_24, (copy) v_u_159
	if p607:IsA("Tool") then
		v_u_15:PreloadTool(p607)
		local v608, v609 = v_u_58()
		local v610 = {
			["Yamato"] = true,
			["Anos"] = true,
			["Escanor"] = true,
			["ShadowMonarch"] = true
		}
		local v611 = v609 and v609.IdleAnimationId
		if v611 then
			v611 = v609.IdleAnimationId > 0
		end
		local v612
		if v608 then
			v612 = v610[v608]
		else
			v612 = v608
		end
		if v608 and (v609 and (v611 or v612)) then
			v_u_24.CurrentWeapon = v608
			v_u_159(v608, v609)
		end
	end
end
local function v_u_615(p614)
	-- upvalues: (copy) v_u_24, (copy) v_u_162
	if p614:IsA("Tool") then
		if v_u_24.CurrentWeapon then
			v_u_24.CurrentWeapon = nil
			v_u_24.ComboIndex = 0
			v_u_24.IsAttacking = false
			v_u_162()
		end
	end
end
local function v619(p616)
	-- upvalues: (copy) v_u_448, (ref) v_u_27, (ref) v_u_28, (copy) v_u_24, (ref) v_u_29, (copy) v_u_162, (copy) v_u_613, (copy) v_u_615
	v_u_448()
	v_u_27 = {}
	v_u_28 = nil
	v_u_24.ComboIndex = 0
	v_u_24.LastHitTime = 0
	v_u_24.CurrentWeapon = nil
	v_u_24.IsAttacking = false
	if v_u_29 then
		v_u_29:Disconnect()
		v_u_29 = nil
	end
	local v617 = p616:WaitForChild("Humanoid", 10)
	if v617 then
		v617.Died:Connect(function()
			-- upvalues: (ref) v_u_448, (ref) v_u_162
			v_u_448()
			v_u_162()
		end)
	end
	p616.ChildAdded:Connect(v_u_613)
	p616.ChildRemoved:Connect(v_u_615)
	for _, v618 in ipairs(p616:GetChildren()) do
		if v618:IsA("Tool") then
			v_u_613(v618)
			return
		end
	end
end
if v_u_7.Character then
	v619(v_u_7.Character)
end
v_u_7.CharacterAdded:Connect(v619)
v_u_7:GetAttributeChangedSignal("GilgameshFUnlocked"):Connect(function()
	-- upvalues: (copy) v_u_58, (ref) v_u_27, (copy) v_u_162, (copy) v_u_159
	local v620, v621 = v_u_58()
	if v620 == "Gilgamesh" and v621 then
		if v_u_27.Gilgamesh then
			pcall(function()
				-- upvalues: (ref) v_u_27
				v_u_27.Gilgamesh:Stop()
				v_u_27.Gilgamesh:Destroy()
			end)
			v_u_27.Gilgamesh = nil
		end
		if v_u_27.Gilgamesh_FIdle then
			pcall(function()
				-- upvalues: (ref) v_u_27
				v_u_27.Gilgamesh_FIdle:Stop()
				v_u_27.Gilgamesh_FIdle:Destroy()
			end)
			v_u_27.Gilgamesh_FIdle = nil
		end
		v_u_162()
		v_u_159(v620, v621)
	end
end)
local v622 = v_u_3:FindFirstChild("AbilitySystem")
if v622 then
	local v623 = v622:FindFirstChild("Remotes")
	local v624 = v623 and v623:FindFirstChild("AbilityStateChanged")
	if v624 then
		v624.OnClientEvent:Connect(function(p625)
			-- upvalues: (copy) v_u_58, (ref) v_u_34, (copy) v_u_159, (ref) v_u_36, (ref) v_u_38, (copy) v_u_7, (ref) v_u_31
			if p625 == false then
				local v626 = v_u_58()
				if v626 == "Anos" and not v_u_34 then
					local _, v627 = v_u_58()
					if v627 then
						v_u_159(v626, v627)
					end
				end
				if v626 == "Escanor" and not v_u_36 then
					local _, v628 = v_u_58()
					if v628 then
						v_u_159(v626, v628)
					end
				end
				if v626 == "Yamato" and not v_u_38 then
					local _, v629 = v_u_58()
					if v629 then
						v_u_159(v626, v629)
					end
				end
				if v626 == "Gilgamesh" and (v_u_7:GetAttribute("GilgameshFUnlocked") == true and not v_u_31) then
					local _, v630 = v_u_58()
					if v630 then
						v_u_159(v626, v630)
					end
				end
			end
		end)
	end
end
local v_u_631 = {}
local function v_u_634(p632)
	-- upvalues: (copy) v_u_631
	local v_u_633 = v_u_631[p632]
	if v_u_633 then
		if v_u_633.animTrack then
			pcall(function()
				-- upvalues: (copy) v_u_633
				v_u_633.animTrack:Stop()
			end)
		end
		if v_u_633.motor and v_u_633.motor.Parent then
			v_u_633.motor:Destroy()
		end
		if v_u_633.clone and v_u_633.clone.Parent then
			v_u_633.clone:Destroy()
		end
		v_u_631[p632] = nil
	end
end
local function v_u_652(p_u_635)
	-- upvalues: (copy) v_u_7, (copy) v_u_634, (copy) v_u_631, (copy) v_u_3
	if p_u_635 == v_u_7 then
		return
	end
	if p_u_635:GetAttribute("GilgameshFUnlocked") ~= true then
		v_u_634(p_u_635)
		return
	end
	local v636 = p_u_635.Character
	if not v636 then
		v_u_634(p_u_635)
		return
	end
	local v637 = false
	for _, v638 in v636:GetChildren() do
		if v638:IsA("Tool") and v638.Name == "Gilgamesh" then
			v637 = true
			break
		end
	end
	if v637 then
		if v_u_631[p_u_635] and (v_u_631[p_u_635].clone and v_u_631[p_u_635].clone.Parent) then
			if v_u_631[p_u_635].clone.Parent == v636 then
				return
			end
			v_u_634(p_u_635)
		end
		v_u_634(p_u_635)
		local v639 = v_u_3:FindFirstChild("AbilitySystem")
		if v639 then
			v639 = v639:FindFirstChild("VFX")
		end
		if v639 then
			v639 = v639:FindFirstChild("Gilgamesh")
		end
		if v639 then
			v639 = v639:FindFirstChild("C")
		end
		if v639 then
			v639 = v639:FindFirstChild("gilgameshsword")
		end
		if v639 then
			local v640 = v636:FindFirstChild("HumanoidRootPart")
			if v640 then
				local v641 = v639:Clone()
				local v642 = v636:FindFirstChild("Right Arm") or v636:FindFirstChild("RightHand") or v640
				local v643 = v641:FindFirstChild("Cylinder") or (v641.PrimaryPart or v641:FindFirstChildWhichIsA("BasePart"))
				if v643 then
					if v643:IsA("BasePart") then
						v643.Anchored = false
						v643.CanCollide = false
						v643.CanQuery = false
						v643.CanTouch = false
						v643.CastShadow = false
						v643.Massless = true
					end
					for _, v644 in v643:GetDescendants() do
						if v644:IsA("BasePart") then
							v644.Anchored = false
							v644.CanCollide = false
							v644.CanQuery = false
							v644.CanTouch = false
							v644.CastShadow = false
							v644.Massless = true
						end
					end
					v641.Parent = v636
					local v645 = Instance.new("Motor6D")
					v645.Name = "GilgaIdleCylinder"
					v645.Part0 = v642
					v645.Part1 = v643
					v645.C0 = CFrame.new(-0.101, -1.13, -0.208) * CFrame.Angles(-1.5707963267948966, 0, 0)
					v645.C1 = CFrame.new(-0.094, -2.6, -0.344)
					v645.Parent = v642
					for _, v646 in v643:GetDescendants() do
						if v646:IsA("ParticleEmitter") then
							v646.Enabled = true
						end
					end
					local v_u_647 = nil
					local v648 = v641:FindFirstChildOfClass("AnimationController")
					if v648 then
						local v_u_649 = v648:FindFirstChildOfClass("Animator")
						if not v_u_649 then
							v_u_649 = Instance.new("Animator")
							v_u_649.Parent = v648
						end
						task.defer(function()
							-- upvalues: (ref) v_u_649, (ref) v_u_647, (ref) v_u_631, (copy) p_u_635
							if v_u_649 and v_u_649.Parent then
								local v_u_650 = Instance.new("Animation")
								v_u_650.AnimationId = "rbxassetid://123739442641752"
								pcall(function()
									-- upvalues: (ref) v_u_649, (copy) v_u_650, (ref) v_u_647, (ref) v_u_631, (ref) p_u_635
									local v651 = v_u_649:LoadAnimation(v_u_650)
									v651.Priority = Enum.AnimationPriority.Action4
									v651.Looped = true
									v651:Play()
									v_u_647 = v651
									if v_u_631[p_u_635] then
										v_u_631[p_u_635].animTrack = v651
									end
								end)
							end
						end)
					end
					v_u_631[p_u_635] = v_u_631[p_u_635] or {}
					v_u_631[p_u_635].clone = v641
					v_u_631[p_u_635].motor = v645
					v_u_631[p_u_635].animTrack = v_u_647
				else
					v641:Destroy()
				end
			else
				return
			end
		else
			return
		end
	else
		v_u_634(p_u_635)
		return
	end
end
local function v_u_665(p_u_653)
	-- upvalues: (copy) v_u_7, (copy) v_u_652, (copy) v_u_631
	if p_u_653 ~= v_u_7 then
		local v654 = {}
		local v655 = p_u_653:GetAttributeChangedSignal("GilgameshFUnlocked")
		local function v656()
			-- upvalues: (ref) v_u_652, (copy) p_u_653
			v_u_652(p_u_653)
		end
		table.insert(v654, v655:Connect(v656))
		local v657 = p_u_653.CharacterAdded
		local function v661(p_u_658)
			-- upvalues: (ref) v_u_652, (copy) p_u_653
			if p_u_658:WaitForChild("Humanoid", 10) then
				task.defer(function()
					-- upvalues: (ref) v_u_652, (ref) p_u_653, (copy) p_u_658
					v_u_652(p_u_653)
					p_u_658.ChildAdded:Connect(function(p659)
						-- upvalues: (ref) v_u_652, (ref) p_u_653
						if p659:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_652, (ref) p_u_653
								v_u_652(p_u_653)
							end)
						end
					end)
					p_u_658.ChildRemoved:Connect(function(p660)
						-- upvalues: (ref) v_u_652, (ref) p_u_653
						if p660:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_652, (ref) p_u_653
								v_u_652(p_u_653)
							end)
						end
					end)
				end)
			end
		end
		table.insert(v654, v657:Connect(v661))
		local v662 = p_u_653.Character
		if v662 then
			v662.ChildAdded:Connect(function(p663)
				-- upvalues: (ref) v_u_652, (copy) p_u_653
				if p663:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_652, (ref) p_u_653
						v_u_652(p_u_653)
					end)
				end
			end)
			v662.ChildRemoved:Connect(function(p664)
				-- upvalues: (ref) v_u_652, (copy) p_u_653
				if p664:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_652, (ref) p_u_653
						v_u_652(p_u_653)
					end)
				end
			end)
			task.defer(function()
				-- upvalues: (ref) v_u_652, (copy) p_u_653
				v_u_652(p_u_653)
			end)
		end
		v_u_631[p_u_653] = v_u_631[p_u_653] or {}
		v_u_631[p_u_653].connections = v654
	end
end
for _, v666 in v_u_1:GetPlayers() do
	if v666 ~= v_u_7 then
		v_u_665(v666)
	end
end
v_u_1.PlayerAdded:Connect(function(p667)
	-- upvalues: (copy) v_u_7, (copy) v_u_665
	if p667 ~= v_u_7 then
		v_u_665(p667)
	end
end)
v_u_1.PlayerRemoving:Connect(function(p668)
	-- upvalues: (copy) v_u_631, (copy) v_u_634
	local v669 = v_u_631[p668]
	if v669 then
		if v669.connections then
			for _, v670 in ipairs(v669.connections) do
				v670:Disconnect()
			end
		end
		v_u_634(p668)
		v_u_631[p668] = nil
	end
end)
local v671 = v_u_3:FindFirstChild("AbilitySystem")
if v671 then
	local v672 = v671:FindFirstChild("Remotes")
	local v673 = v672 and v672:FindFirstChild("AbilityFeedback")
	if v673 then
		v673.OnClientEvent:Connect(function(p_u_674)
			-- upvalues: (copy) v_u_7, (copy) v_u_652
			if p_u_674 then
				p_u_674 = p_u_674.Caster
			end
			if p_u_674 and p_u_674 ~= v_u_7 then
				task.delay(0.5, function()
					-- upvalues: (ref) v_u_652, (copy) p_u_674
					v_u_652(p_u_674)
				end)
			end
		end)
	end
end
local v_u_675 = {}
local function v_u_691(p676)
	-- upvalues: (copy) v_u_7, (copy) v_u_675, (copy) v_u_3
	if p676 == v_u_7 then
		return
	end
	local v677 = p676.Character
	if not v677 then
		local v678 = v_u_675[p676]
		if v678 then
			if v678.motor and v678.motor.Parent then
				v678.motor:Destroy()
			end
			if v678.clone and v678.clone.Parent then
				v678.clone:Destroy()
			end
			v_u_675[p676] = nil
		end
	end
	local v679 = false
	for _, v680 in v677:GetChildren() do
		if v680:IsA("Tool") and v680.Name == "Anos" then
			v679 = true
			break
		end
	end
	if v679 then
		if v_u_675[p676] and (v_u_675[p676].clone and v_u_675[p676].clone.Parent) then
			return
		else
			local v681 = v_u_675[p676]
			if v681 then
				if v681.motor and v681.motor.Parent then
					v681.motor:Destroy()
				end
				if v681.clone and v681.clone.Parent then
					v681.clone:Destroy()
				end
				v_u_675[p676] = nil
			end
			local v682 = v_u_3:FindFirstChild("AbilitySystem")
			if v682 then
				v682 = v682:FindFirstChild("VFX")
			end
			if v682 then
				v682 = v682:FindFirstChild("Anos")
			end
			if v682 then
				v682 = v682:FindFirstChild("Handle")
			end
			if v682 then
				local v683 = v677:FindFirstChild("HumanoidRootPart")
				if v683 then
					local v684 = v682:Clone()
					local v685 = v677:FindFirstChild("Right Arm") or v677:FindFirstChild("RightHand") or v683
					if v684:IsA("BasePart") and v684:IsA("BasePart") then
						v684.Anchored = false
						v684.CanCollide = false
						v684.CanQuery = false
						v684.CanTouch = false
						v684.CastShadow = false
						v684.Massless = true
					end
					for _, v686 in v684:GetDescendants() do
						if v686:IsA("BasePart") then
							v686.Anchored = false
							v686.CanCollide = false
							v686.CanQuery = false
							v686.CanTouch = false
							v686.CastShadow = false
							v686.Massless = true
						end
					end
					v684.Parent = v677
					local v687 = v684:IsA("BasePart") and v684 and v684 or v684:FindFirstChildWhichIsA("BasePart")
					if v687 then
						local v688 = Instance.new("Motor6D")
						v688.Name = "AnosHandle"
						v688.Part0 = v685
						v688.Part1 = v687
						v688.C0 = CFrame.new(0.02, -0.866, 0.02) * CFrame.Angles(-1.5707963267948966, 0, 0)
						v688.C1 = CFrame.new(0, -2.2, 0)
						v688.Parent = v685
						for _, v689 in v684:GetDescendants() do
							if v689:IsA("ParticleEmitter") then
								v689.Enabled = true
							end
							if v689:IsA("Trail") then
								v689.Enabled = true
							end
						end
						v_u_675[p676] = v_u_675[p676] or {}
						v_u_675[p676].clone = v684
						v_u_675[p676].motor = v688
					else
						v684:Destroy()
					end
				else
					return
				end
			else
				return
			end
		end
	else
		local v690 = v_u_675[p676]
		if v690 then
			if v690.motor and v690.motor.Parent then
				v690.motor:Destroy()
			end
			if v690.clone and v690.clone.Parent then
				v690.clone:Destroy()
			end
			v_u_675[p676] = nil
		end
	end
end
local function v_u_702(p_u_692)
	-- upvalues: (copy) v_u_7, (copy) v_u_691, (copy) v_u_675
	if p_u_692 ~= v_u_7 then
		local v693 = {}
		local v694 = p_u_692.CharacterAdded
		local function v698(p_u_695)
			-- upvalues: (ref) v_u_691, (copy) p_u_692
			if p_u_695:WaitForChild("Humanoid", 10) then
				task.defer(function()
					-- upvalues: (ref) v_u_691, (ref) p_u_692, (copy) p_u_695
					v_u_691(p_u_692)
					p_u_695.ChildAdded:Connect(function(p696)
						-- upvalues: (ref) v_u_691, (ref) p_u_692
						if p696:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_691, (ref) p_u_692
								v_u_691(p_u_692)
							end)
						end
					end)
					p_u_695.ChildRemoved:Connect(function(p697)
						-- upvalues: (ref) v_u_691, (ref) p_u_692
						if p697:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_691, (ref) p_u_692
								v_u_691(p_u_692)
							end)
						end
					end)
				end)
			end
		end
		table.insert(v693, v694:Connect(v698))
		local v699 = p_u_692.Character
		if v699 then
			v699.ChildAdded:Connect(function(p700)
				-- upvalues: (ref) v_u_691, (copy) p_u_692
				if p700:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_691, (ref) p_u_692
						v_u_691(p_u_692)
					end)
				end
			end)
			v699.ChildRemoved:Connect(function(p701)
				-- upvalues: (ref) v_u_691, (copy) p_u_692
				if p701:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_691, (ref) p_u_692
						v_u_691(p_u_692)
					end)
				end
			end)
			task.defer(function()
				-- upvalues: (ref) v_u_691, (copy) p_u_692
				v_u_691(p_u_692)
			end)
		end
		v_u_675[p_u_692] = v_u_675[p_u_692] or {}
		v_u_675[p_u_692].connections = v693
	end
end
for _, v703 in v_u_1:GetPlayers() do
	if v703 ~= v_u_7 then
		v_u_702(v703)
	end
end
v_u_1.PlayerAdded:Connect(function(p704)
	-- upvalues: (copy) v_u_7, (copy) v_u_702
	if p704 ~= v_u_7 then
		v_u_702(p704)
	end
end)
v_u_1.PlayerRemoving:Connect(function(p705)
	-- upvalues: (copy) v_u_675
	local v706 = v_u_675[p705]
	if v706 then
		if v706.connections then
			for _, v707 in ipairs(v706.connections) do
				v707:Disconnect()
			end
		end
		local v708 = v_u_675[p705]
		if v708 then
			if v708.motor and v708.motor.Parent then
				v708.motor:Destroy()
			end
			if v708.clone and v708.clone.Parent then
				v708.clone:Destroy()
			end
			v_u_675[p705] = nil
		end
		v_u_675[p705] = nil
	end
end)
local v_u_709 = {}
local function v_u_712(p710)
	-- upvalues: (copy) v_u_709
	local v711 = v_u_709[p710]
	if v711 then
		if v711.leftMotor and v711.leftMotor.Parent then
			v711.leftMotor:Destroy()
		end
		if v711.rightMotor and v711.rightMotor.Parent then
			v711.rightMotor:Destroy()
		end
		if v711.leftClone and v711.leftClone.Parent then
			v711.leftClone:Destroy()
		end
		if v711.rightClone and v711.rightClone.Parent then
			v711.rightClone:Destroy()
		end
		v_u_709[p710] = nil
	end
end
local function v_u_733(p713)
	-- upvalues: (copy) v_u_7, (copy) v_u_712, (copy) v_u_709, (copy) v_u_3
	if p713 == v_u_7 then
		return
	end
	local v714 = p713.Character
	if not v714 then
		v_u_712(p713)
		return
	end
	local v715 = false
	for _, v716 in v714:GetChildren() do
		if v716:IsA("Tool") and v716.Name == "Shadow Monarch" then
			v715 = true
			break
		end
	end
	if v715 then
		if v_u_709[p713] and (v_u_709[p713].leftClone and v_u_709[p713].leftClone.Parent) then
			return
		else
			v_u_712(p713)
			local v717 = v_u_3:FindFirstChild("AbilitySystem")
			if v717 then
				v717 = v717:FindFirstChild("VFX")
			end
			if v717 then
				v717 = v717:FindFirstChild("ShadowMonarch")
			end
			local v718
			if v717 then
				v718 = v717:FindFirstChild("LeftDagger")
			else
				v718 = v717
			end
			if v717 then
				v717 = v717:FindFirstChild("Right Dagger")
			end
			if v718 and v717 then
				local v719 = v714:FindFirstChild("Left Arm") or v714:FindFirstChild("LeftHand")
				local v720 = v714:FindFirstChild("Right Arm") or v714:FindFirstChild("RightHand")
				if v719 and v720 then
					local v721 = v718:Clone()
					local v722 = v717:Clone()
					if v721:IsA("BasePart") then
						v721.Anchored = false
						v721.CanCollide = false
						v721.CanQuery = false
						v721.CanTouch = false
						v721.CastShadow = false
						v721.Massless = true
					end
					for _, v723 in v721:GetDescendants() do
						if v723:IsA("BasePart") then
							v723.Anchored = false
							v723.CanCollide = false
							v723.CanQuery = false
							v723.CanTouch = false
							v723.CastShadow = false
							v723.Massless = true
						end
					end
					if v722:IsA("BasePart") then
						v722.Anchored = false
						v722.CanCollide = false
						v722.CanQuery = false
						v722.CanTouch = false
						v722.CastShadow = false
						v722.Massless = true
					end
					for _, v724 in v722:GetDescendants() do
						if v724:IsA("BasePart") then
							v724.Anchored = false
							v724.CanCollide = false
							v724.CanQuery = false
							v724.CanTouch = false
							v724.CastShadow = false
							v724.Massless = true
						end
					end
					for _, v725 in v721:GetDescendants() do
						if v725:IsA("BasePart") and v725 ~= v721 then
							local v726 = Instance.new("WeldConstraint")
							v726.Part0 = v721
							v726.Part1 = v725
							v726.Parent = v725
						end
					end
					for _, v727 in v722:GetDescendants() do
						if v727:IsA("BasePart") and v727 ~= v722 then
							local v728 = Instance.new("WeldConstraint")
							v728.Part0 = v722
							v728.Part1 = v727
							v728.Parent = v727
						end
					end
					v721.Parent = v714
					v722.Parent = v714
					local v729 = Instance.new("Motor6D")
					v729.Name = "LeftDagger"
					v729.Part0 = v719
					v729.Part1 = v721
					v729.C0 = CFrame.new(0.039, -1.02, -0.306) * CFrame.Angles(0.22689280275926285, 0, 0)
					v729.C1 = CFrame.new(0, 0.487, 1.222)
					v729.Parent = v719
					local v730 = Instance.new("Motor6D")
					v730.Name = "RightDagger"
					v730.Part0 = v720
					v730.Part1 = v722
					v730.C0 = CFrame.new(0.102, -0.895, 0.013) * CFrame.Angles(0.29255208921928955, 0.03675663404700058, 0.23479914427079715)
					v730.C1 = CFrame.new(0.05, 0.462, 1.531)
					v730.Parent = v720
					for _, v731 in v721:GetDescendants() do
						if v731:IsA("ParticleEmitter") or v731:IsA("Trail") then
							v731.Enabled = true
						end
					end
					for _, v732 in v722:GetDescendants() do
						if v732:IsA("ParticleEmitter") or v732:IsA("Trail") then
							v732.Enabled = true
						end
					end
					v_u_709[p713] = v_u_709[p713] or {}
					v_u_709[p713].leftClone = v721
					v_u_709[p713].rightClone = v722
					v_u_709[p713].leftMotor = v729
					v_u_709[p713].rightMotor = v730
				end
			else
				return
			end
		end
	else
		v_u_712(p713)
		return
	end
end
local function v_u_744(p_u_734)
	-- upvalues: (copy) v_u_7, (copy) v_u_733, (copy) v_u_709
	if p_u_734 ~= v_u_7 then
		local v735 = {}
		local v736 = p_u_734.CharacterAdded
		local function v740(p_u_737)
			-- upvalues: (ref) v_u_733, (copy) p_u_734
			if p_u_737:WaitForChild("Humanoid", 10) then
				task.defer(function()
					-- upvalues: (ref) v_u_733, (ref) p_u_734, (copy) p_u_737
					v_u_733(p_u_734)
					p_u_737.ChildAdded:Connect(function(p738)
						-- upvalues: (ref) v_u_733, (ref) p_u_734
						if p738:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_733, (ref) p_u_734
								v_u_733(p_u_734)
							end)
						end
					end)
					p_u_737.ChildRemoved:Connect(function(p739)
						-- upvalues: (ref) v_u_733, (ref) p_u_734
						if p739:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_733, (ref) p_u_734
								v_u_733(p_u_734)
							end)
						end
					end)
				end)
			end
		end
		table.insert(v735, v736:Connect(v740))
		local v741 = p_u_734.Character
		if v741 then
			v741.ChildAdded:Connect(function(p742)
				-- upvalues: (ref) v_u_733, (copy) p_u_734
				if p742:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_733, (ref) p_u_734
						v_u_733(p_u_734)
					end)
				end
			end)
			v741.ChildRemoved:Connect(function(p743)
				-- upvalues: (ref) v_u_733, (copy) p_u_734
				if p743:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_733, (ref) p_u_734
						v_u_733(p_u_734)
					end)
				end
			end)
			task.defer(function()
				-- upvalues: (ref) v_u_733, (copy) p_u_734
				v_u_733(p_u_734)
			end)
		end
		v_u_709[p_u_734] = v_u_709[p_u_734] or {}
		v_u_709[p_u_734].connections = v735
	end
end
for _, v745 in v_u_1:GetPlayers() do
	if v745 ~= v_u_7 then
		v_u_744(v745)
	end
end
v_u_1.PlayerAdded:Connect(function(p746)
	-- upvalues: (copy) v_u_7, (copy) v_u_744
	if p746 ~= v_u_7 then
		v_u_744(p746)
	end
end)
v_u_1.PlayerRemoving:Connect(function(p747)
	-- upvalues: (copy) v_u_709, (copy) v_u_712
	local v748 = v_u_709[p747]
	if v748 then
		if v748.connections then
			for _, v749 in ipairs(v748.connections) do
				v749:Disconnect()
			end
		end
		v_u_712(p747)
		v_u_709[p747] = nil
	end
end)
local v_u_750 = {}
local function v_u_766(p751)
	-- upvalues: (copy) v_u_7, (copy) v_u_750, (copy) v_u_3
	if p751 == v_u_7 then
		return
	end
	local v752 = p751.Character
	if not v752 then
		local v753 = v_u_750[p751]
		if v753 then
			if v753.motor and v753.motor.Parent then
				v753.motor:Destroy()
			end
			if v753.clone and v753.clone.Parent then
				v753.clone:Destroy()
			end
			v_u_750[p751] = nil
		end
	end
	local v754 = false
	for _, v755 in v752:GetChildren() do
		if v755:IsA("Tool") and v755.Name == "Escanor" then
			v754 = true
			break
		end
	end
	if v754 then
		if v_u_750[p751] and (v_u_750[p751].clone and v_u_750[p751].clone.Parent) then
			return
		else
			local v756 = v_u_750[p751]
			if v756 then
				if v756.motor and v756.motor.Parent then
					v756.motor:Destroy()
				end
				if v756.clone and v756.clone.Parent then
					v756.clone:Destroy()
				end
				v_u_750[p751] = nil
			end
			local v757 = v_u_3:FindFirstChild("AbilitySystem")
			if v757 then
				v757 = v757:FindFirstChild("VFX")
			end
			if v757 then
				v757 = v757:FindFirstChild("Escanor")
			end
			if v757 then
				v757 = v757:FindFirstChild("Handle")
			end
			if v757 then
				local v758 = v752:FindFirstChild("HumanoidRootPart")
				if v758 then
					local v759 = v757:Clone()
					local v760 = v752:FindFirstChild("Right Arm") or v752:FindFirstChild("RightHand") or v758
					if v759:IsA("BasePart") and v759:IsA("BasePart") then
						v759.Anchored = false
						v759.CanCollide = false
						v759.CanQuery = false
						v759.CanTouch = false
						v759.CastShadow = false
						v759.Massless = true
					end
					for _, v761 in v759:GetDescendants() do
						if v761:IsA("BasePart") then
							v761.Anchored = false
							v761.CanCollide = false
							v761.CanQuery = false
							v761.CanTouch = false
							v761.CastShadow = false
							v761.Massless = true
						end
					end
					v759.Parent = v752
					local v762 = v759:IsA("BasePart") and v759 and v759 or v759:FindFirstChildWhichIsA("BasePart")
					if v762 then
						local v763 = Instance.new("Motor6D")
						v763.Name = "EscanorHandle"
						v763.Part0 = v760
						v763.Part1 = v762
						v763.C0 = CFrame.new(0, 0, 0)
						v763.C1 = CFrame.new(0, 1.61, 2.18)
						v763.Parent = v760
						for _, v764 in v759:GetDescendants() do
							if v764:IsA("ParticleEmitter") then
								v764.Enabled = true
							end
							if v764:IsA("Trail") then
								v764.Enabled = true
							end
						end
						v_u_750[p751] = v_u_750[p751] or {}
						v_u_750[p751].clone = v759
						v_u_750[p751].motor = v763
					else
						v759:Destroy()
					end
				else
					return
				end
			else
				return
			end
		end
	else
		local v765 = v_u_750[p751]
		if v765 then
			if v765.motor and v765.motor.Parent then
				v765.motor:Destroy()
			end
			if v765.clone and v765.clone.Parent then
				v765.clone:Destroy()
			end
			v_u_750[p751] = nil
		end
	end
end
local function v_u_777(p_u_767)
	-- upvalues: (copy) v_u_7, (copy) v_u_766, (copy) v_u_750
	if p_u_767 ~= v_u_7 then
		local v768 = {}
		local v769 = p_u_767.CharacterAdded
		local function v773(p_u_770)
			-- upvalues: (ref) v_u_766, (copy) p_u_767
			if p_u_770:WaitForChild("Humanoid", 10) then
				task.defer(function()
					-- upvalues: (ref) v_u_766, (ref) p_u_767, (copy) p_u_770
					v_u_766(p_u_767)
					p_u_770.ChildAdded:Connect(function(p771)
						-- upvalues: (ref) v_u_766, (ref) p_u_767
						if p771:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_766, (ref) p_u_767
								v_u_766(p_u_767)
							end)
						end
					end)
					p_u_770.ChildRemoved:Connect(function(p772)
						-- upvalues: (ref) v_u_766, (ref) p_u_767
						if p772:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_766, (ref) p_u_767
								v_u_766(p_u_767)
							end)
						end
					end)
				end)
			end
		end
		table.insert(v768, v769:Connect(v773))
		local v774 = p_u_767.Character
		if v774 then
			v774.ChildAdded:Connect(function(p775)
				-- upvalues: (ref) v_u_766, (copy) p_u_767
				if p775:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_766, (ref) p_u_767
						v_u_766(p_u_767)
					end)
				end
			end)
			v774.ChildRemoved:Connect(function(p776)
				-- upvalues: (ref) v_u_766, (copy) p_u_767
				if p776:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_766, (ref) p_u_767
						v_u_766(p_u_767)
					end)
				end
			end)
			task.defer(function()
				-- upvalues: (ref) v_u_766, (copy) p_u_767
				v_u_766(p_u_767)
			end)
		end
		v_u_750[p_u_767] = v_u_750[p_u_767] or {}
		v_u_750[p_u_767].connections = v768
	end
end
for _, v778 in v_u_1:GetPlayers() do
	if v778 ~= v_u_7 then
		v_u_777(v778)
	end
end
v_u_1.PlayerAdded:Connect(function(p779)
	-- upvalues: (copy) v_u_7, (copy) v_u_777
	if p779 ~= v_u_7 then
		v_u_777(p779)
	end
end)
v_u_1.PlayerRemoving:Connect(function(p780)
	-- upvalues: (copy) v_u_750
	local v781 = v_u_750[p780]
	if v781 then
		if v781.connections then
			for _, v782 in ipairs(v781.connections) do
				v782:Disconnect()
			end
		end
		local v783 = v_u_750[p780]
		if v783 then
			if v783.motor and v783.motor.Parent then
				v783.motor:Destroy()
			end
			if v783.clone and v783.clone.Parent then
				v783.clone:Destroy()
			end
			v_u_750[p780] = nil
		end
		v_u_750[p780] = nil
	end
end)
local v_u_784 = {}
local function v_u_787(p785)
	-- upvalues: (copy) v_u_784
	local v786 = v_u_784[p785]
	if v786 then
		if v786.sheethMotor and v786.sheethMotor.Parent then
			v786.sheethMotor:Destroy()
		end
		if v786.swordMotor and v786.swordMotor.Parent then
			v786.swordMotor:Destroy()
		end
		if v786.sheethClone and v786.sheethClone.Parent then
			v786.sheethClone:Destroy()
		end
		if v786.swordClone and v786.swordClone.Parent then
			v786.swordClone:Destroy()
		end
		v_u_784[p785] = nil
	end
end
local function v_u_804(p788)
	-- upvalues: (copy) v_u_7, (copy) v_u_787, (copy) v_u_784, (copy) v_u_3
	if p788 == v_u_7 then
		return
	end
	local v789 = p788.Character
	if not v789 then
		v_u_787(p788)
		return
	end
	local v790 = false
	for _, v791 in v789:GetChildren() do
		if v791:IsA("Tool") and v791.Name == "Yamato" then
			v790 = true
			break
		end
	end
	if v790 then
		if v_u_784[p788] and (v_u_784[p788].sheethClone and v_u_784[p788].sheethClone.Parent) then
			return
		else
			v_u_787(p788)
			local v792 = v_u_3:FindFirstChild("AbilitySystem")
			if v792 then
				v792 = v792:FindFirstChild("VFX")
			end
			if v792 then
				v792 = v792:FindFirstChild("Vergil")
			end
			local v793
			if v792 then
				v793 = v792:FindFirstChild("yamato sheeth")
			else
				v793 = v792
			end
			if v792 then
				v792 = v792:FindFirstChild("yamato sword")
			end
			if v793 and v792 then
				local v794 = v789:FindFirstChild("Left Arm") or v789:FindFirstChild("LeftHand")
				local v795 = v789:FindFirstChild("Right Arm") or v789:FindFirstChild("RightHand")
				if v794 and v795 then
					local v796 = v793:Clone()
					local v797 = v792:Clone()
					if v796:IsA("BasePart") then
						v796.Anchored = false
						v796.CanCollide = false
						v796.CanQuery = false
						v796.CanTouch = false
						v796.CastShadow = false
						v796.Massless = true
					end
					for _, v798 in v796:GetDescendants() do
						if v798:IsA("BasePart") then
							v798.Anchored = false
							v798.CanCollide = false
							v798.CanQuery = false
							v798.CanTouch = false
							v798.CastShadow = false
							v798.Massless = true
						end
					end
					if v797:IsA("BasePart") then
						v797.Anchored = false
						v797.CanCollide = false
						v797.CanQuery = false
						v797.CanTouch = false
						v797.CastShadow = false
						v797.Massless = true
					end
					for _, v799 in v797:GetDescendants() do
						if v799:IsA("BasePart") then
							v799.Anchored = false
							v799.CanCollide = false
							v799.CanQuery = false
							v799.CanTouch = false
							v799.CastShadow = false
							v799.Massless = true
						end
					end
					v796.Parent = v789
					v797.Parent = v789
					local v800 = Instance.new("Motor6D")
					v800.Name = "yamato sheeth"
					v800.Part0 = v794
					v800.Part1 = v796
					v800.C0 = CFrame.new(-0.067, -1.093, 0.068) * CFrame.fromOrientation(-1.5350519837140526, 2.0177053350605645, -2.0904332049911685)
					v800.C1 = CFrame.new(-0.066, 0.897, 0.014)
					v800.Parent = v794
					local v801 = Instance.new("Motor6D")
					v801.Name = "yamato sword"
					v801.Part0 = v795
					v801.Part1 = v797
					v801.C0 = CFrame.new(0.103, -0.973, -0.154) * CFrame.fromOrientation(1.5707963267948966, -0.13962634015954636, 0)
					v801.C1 = CFrame.new(0.08, 2.008, 0)
					v801.Parent = v795
					for _, v802 in v796:GetDescendants() do
						if v802:IsA("ParticleEmitter") or v802:IsA("Trail") then
							v802.Enabled = true
						end
					end
					for _, v803 in v797:GetDescendants() do
						if v803:IsA("ParticleEmitter") or v803:IsA("Trail") then
							v803.Enabled = true
						end
					end
					v_u_784[p788] = v_u_784[p788] or {}
					v_u_784[p788].sheethClone = v796
					v_u_784[p788].swordClone = v797
					v_u_784[p788].sheethMotor = v800
					v_u_784[p788].swordMotor = v801
				end
			else
				return
			end
		end
	else
		v_u_787(p788)
		return
	end
end
local function v_u_815(p_u_805)
	-- upvalues: (copy) v_u_7, (copy) v_u_804, (copy) v_u_784
	if p_u_805 ~= v_u_7 then
		local v806 = {}
		local v807 = p_u_805.CharacterAdded
		local function v811(p_u_808)
			-- upvalues: (ref) v_u_804, (copy) p_u_805
			if p_u_808:WaitForChild("Humanoid", 10) then
				task.defer(function()
					-- upvalues: (ref) v_u_804, (ref) p_u_805, (copy) p_u_808
					v_u_804(p_u_805)
					p_u_808.ChildAdded:Connect(function(p809)
						-- upvalues: (ref) v_u_804, (ref) p_u_805
						if p809:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_804, (ref) p_u_805
								v_u_804(p_u_805)
							end)
						end
					end)
					p_u_808.ChildRemoved:Connect(function(p810)
						-- upvalues: (ref) v_u_804, (ref) p_u_805
						if p810:IsA("Tool") then
							task.defer(function()
								-- upvalues: (ref) v_u_804, (ref) p_u_805
								v_u_804(p_u_805)
							end)
						end
					end)
				end)
			end
		end
		table.insert(v806, v807:Connect(v811))
		local v812 = p_u_805.Character
		if v812 then
			v812.ChildAdded:Connect(function(p813)
				-- upvalues: (ref) v_u_804, (copy) p_u_805
				if p813:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_804, (ref) p_u_805
						v_u_804(p_u_805)
					end)
				end
			end)
			v812.ChildRemoved:Connect(function(p814)
				-- upvalues: (ref) v_u_804, (copy) p_u_805
				if p814:IsA("Tool") then
					task.defer(function()
						-- upvalues: (ref) v_u_804, (ref) p_u_805
						v_u_804(p_u_805)
					end)
				end
			end)
			task.defer(function()
				-- upvalues: (ref) v_u_804, (copy) p_u_805
				v_u_804(p_u_805)
			end)
		end
		v_u_784[p_u_805] = v_u_784[p_u_805] or {}
		v_u_784[p_u_805].connections = v806
	end
end
for _, v816 in v_u_1:GetPlayers() do
	if v816 ~= v_u_7 then
		v_u_815(v816)
	end
end
v_u_1.PlayerAdded:Connect(function(p817)
	-- upvalues: (copy) v_u_7, (copy) v_u_815
	if p817 ~= v_u_7 then
		v_u_815(p817)
	end
end)
v_u_1.PlayerRemoving:Connect(function(p818)
	-- upvalues: (copy) v_u_784, (copy) v_u_787
	local v819 = v_u_784[p818]
	if v819 then
		if v819.connections then
			for _, v820 in ipairs(v819.connections) do
				v820:Disconnect()
			end
		end
		v_u_787(p818)
		v_u_784[p818] = nil
	end
end)
v_u_18.OnClientEvent:Connect(function(p821)
	-- upvalues: (copy) v_u_7, (copy) v_u_11, (copy) v_u_50, (copy) v_u_14, (copy) v_u_12, (copy) v_u_5, (copy) v_u_4
	local v_u_822 = p821.Caster
	if v_u_822 and v_u_822 ~= v_u_7 then
		if v_u_7:GetAttribute("DisableVFX") == true then
			return
		elseif v_u_7:GetAttribute("DisableOtherVFX") then
			return
		else
			local v823 = v_u_822.Character
			if v823 then
				local v_u_824 = v823:FindFirstChild("HumanoidRootPart")
				local v825 = v823:FindFirstChild("Humanoid")
				if v_u_824 and v825 then
					local v826 = p821.ComboIndex
					local v_u_827 = p821.CFrame or v_u_824.CFrame
					local v_u_828 = v_u_827.LookVector
					local v829 = v825:FindFirstChild("Animator")
					if v829 then
						local v830 = v_u_11:FindFirstChild("Gilgamesh")
						local v831 = v830 and v830:FindFirstChild("M" .. v826)
						if v831 then
							local v832 = v_u_50[v_u_822]
							if v832 then
								if v832.connection then
									v832.connection:Disconnect()
								end
								if v832.track then
									v832.track:Stop(0.05)
									v832.track:Destroy()
								end
							end
							local v_u_833 = v829:LoadAnimation(v831)
							v_u_833.Looped = false
							v_u_833.Priority = Enum.AnimationPriority.Action
							v_u_833:Play(0.1)
							v_u_50[v_u_822] = {
								["track"] = v_u_833,
								["connection"] = v_u_833.Ended:Once(function()
									-- upvalues: (ref) v_u_50, (copy) v_u_822, (copy) v_u_833
									if v_u_50[v_u_822] and v_u_50[v_u_822].track == v_u_833 then
										v_u_50[v_u_822] = nil
									end
									v_u_833:Destroy()
								end)
							}
						end
					end
					v_u_14:PlayAt(({
						"GilgameshM1_1",
						"GilgameshM1_2",
						"GilgameshM1_3",
						"GilgameshM1_4"
					})[(v826 - 1) % 4 + 1], v_u_824.Position)
					local v_u_834 = v_u_12:FindFirstChild("Gilgamesh")
					if v_u_834 then
						local v_u_835 = CFrame.new(-437.6, 3, -192.8)
						local function v_u_843(p836)
							-- upvalues: (copy) v_u_834, (copy) v_u_835, (copy) v_u_827
							local v837 = v_u_834:FindFirstChild(p836)
							if not v837 then
								return nil
							end
							local v838 = v837:Clone()
							local v839 = {}
							if v838:IsA("BasePart") then
								table.insert(v839, v838)
							end
							for _, v840 in v838:GetDescendants() do
								if v840:IsA("BasePart") then
									table.insert(v839, v840)
								end
							end
							for _, v841 in ipairs(v839) do
								v841.CFrame = v_u_827 * (v_u_835:Inverse() * v841.CFrame)
								v841.Anchored = true
								v841.CanCollide = false
								v841.CanQuery = false
								v841.CanTouch = false
								v841.CastShadow = false
								v841.Massless = true
							end
							for _, v842 in v838:GetDescendants() do
								if v842:IsA("ParticleEmitter") then
									v842.Enabled = false
								end
							end
							v838.Parent = workspace
							return v838
						end
						local function v_u_865(p_u_844, p_u_845)
							-- upvalues: (copy) v_u_834, (ref) v_u_14, (ref) v_u_5, (ref) v_u_4
							local v846 = v_u_834:FindFirstChild("Trail")
							if v846 then
								local v_u_847 = v846:Clone()
								if v_u_847:IsA("BasePart") then
									v_u_847.CFrame = CFrame.new(p_u_844, p_u_844 + p_u_845)
									v_u_847.Anchored = true
									v_u_847.CanCollide = false
									v_u_847.CanQuery = false
									v_u_847.CanTouch = false
									v_u_847.CastShadow = false
								elseif v_u_847:IsA("Model") then
									v_u_847:PivotTo(CFrame.new(p_u_844, p_u_844 + p_u_845))
									for _, v848 in v_u_847:GetDescendants() do
										if v848:IsA("BasePart") then
											v848.Anchored = true
											v848.CanCollide = false
											v848.CanQuery = false
											v848.CanTouch = false
											v848.CastShadow = false
										end
									end
								end
								v_u_847.Parent = workspace
								for _, v849 in v_u_847:GetDescendants() do
									if v849:IsA("ParticleEmitter") then
										v849.Enabled = true
										local v850 = v849:GetAttribute("EmitCount")
										if v850 and v850 > 0 then
											v849:Emit(v850)
										end
									elseif v849:IsA("Beam") or v849:IsA("Trail") then
										v849.Enabled = true
									end
								end
								pcall(function()
									-- upvalues: (ref) v_u_14, (copy) p_u_844
									v_u_14:PlayAt("GilgameshZ_Shot1", p_u_844)
								end)
								local v_u_851 = {}
								local v_u_852
								if v_u_847:IsA("Model") then
									v_u_852 = v_u_847.PrimaryPart or v_u_847:FindFirstChildWhichIsA("BasePart")
									if v_u_852 then
										for _, v853 in v_u_847:GetDescendants() do
											if v853:IsA("BasePart") and v853 ~= v_u_852 then
												v_u_851[v853] = v_u_852.CFrame:Inverse() * v853.CFrame
											end
										end
									end
								else
									v_u_852 = v_u_847
								end
								if v_u_852 then
									local v_u_854 = 0
									local v_u_855 = false
									local v_u_856 = nil
									v_u_856 = v_u_5.Heartbeat:Connect(function(p857)
										-- upvalues: (ref) v_u_855, (ref) v_u_852, (ref) v_u_856, (ref) v_u_854, (copy) v_u_847, (ref) v_u_4, (copy) p_u_845, (copy) v_u_851
										if v_u_855 or not (v_u_852 and v_u_852.Parent) then
											if v_u_856 then
												v_u_856:Disconnect()
											end
											return
										else
											v_u_854 = v_u_854 + p857
											if v_u_854 >= 2 then
												v_u_855 = true
												v_u_856:Disconnect()
												for _, v858 in v_u_847:GetDescendants() do
													if v858:IsA("ParticleEmitter") then
														v858.Enabled = false
													elseif v858:IsA("Beam") or v858:IsA("Trail") then
														v858.Enabled = false
													end
												end
												v_u_4:AddItem(v_u_847, 0.8)
											else
												local v859 = 250 * p857
												local v860 = v_u_852.Position + p_u_845 * v859
												local v861 = CFrame.new(v860, v860 + p_u_845)
												v_u_852.CFrame = v861
												for v862, v863 in pairs(v_u_851) do
													if v862 and v862.Parent then
														v862.CFrame = v861 * v863
													end
												end
												if v_u_854 >= 1.4 and not v_u_855 then
													v_u_855 = true
													v_u_856:Disconnect()
													for _, v864 in v_u_847:GetDescendants() do
														if v864:IsA("ParticleEmitter") then
															v864.Enabled = false
														elseif v864:IsA("Beam") or v864:IsA("Trail") then
															v864.Enabled = false
														end
													end
													v_u_4:AddItem(v_u_847, 0.8)
												end
											end
										end
									end)
								end
							end
						end
						if v826 == 1 then
							local v866 = v_u_843("Gate2")
							local v_u_867 = v_u_824.Position + Vector3.new(0, 2, 0)
							if v866 then
								if v866:IsA("BasePart") then
									v_u_867 = v866.Position
								elseif v866:IsA("Model") then
									local v868 = v866.PrimaryPart or v866:FindFirstChildWhichIsA("BasePart")
									if v868 then
										v_u_867 = v868.Position
									end
								end
								for _, v_u_869 in v866:GetDescendants() do
									if v_u_869:IsA("ParticleEmitter") then
										v_u_869.Enabled = true
										task.delay(0.4, function()
											-- upvalues: (copy) v_u_869
											if v_u_869 and v_u_869.Parent then
												v_u_869.Enabled = false
											end
										end)
									end
								end
								v_u_4:AddItem(v866, 3)
								pcall(function()
									-- upvalues: (ref) v_u_14, (ref) v_u_867
									v_u_14:PlayAt("GilgameshZ_GateSpawn", v_u_867)
								end)
							end
							v_u_865(v_u_867, v_u_828)
						elseif v826 == 3 then
							for v870, v_u_871 in ipairs({ "Gate3", "Gate4", "Gate5" }) do
								task.delay((v870 - 1) * 0.15, function()
									-- upvalues: (copy) v_u_824, (copy) v_u_843, (copy) v_u_871, (ref) v_u_4, (ref) v_u_14, (copy) v_u_865, (copy) v_u_828
									if v_u_824 and v_u_824.Parent then
										local v872 = v_u_843(v_u_871)
										local v_u_873 = v_u_824.Position + Vector3.new(0, 2, 0)
										if v872 then
											if v872:IsA("BasePart") then
												v_u_873 = v872.Position
											elseif v872:IsA("Model") then
												local v874 = v872.PrimaryPart or v872:FindFirstChildWhichIsA("BasePart")
												if v874 then
													v_u_873 = v874.Position
												end
											end
											for _, v_u_875 in v872:GetDescendants() do
												if v_u_875:IsA("ParticleEmitter") then
													v_u_875.Enabled = true
													task.delay(0.4, function()
														-- upvalues: (copy) v_u_875
														if v_u_875 and v_u_875.Parent then
															v_u_875.Enabled = false
														end
													end)
												end
											end
											v_u_4:AddItem(v872, 3)
											pcall(function()
												-- upvalues: (ref) v_u_14, (ref) v_u_873
												v_u_14:PlayAt("GilgameshZ_GateSpawn", v_u_873)
											end)
										end
										v_u_865(v_u_873, v_u_828)
									end
								end)
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
	else
		return
	end
end)
v2.InputBegan:Connect(v504)
v_u_1.PlayerRemoving:Connect(function(p876)
	-- upvalues: (copy) v_u_50
	local v877 = v_u_50[p876]
	if v877 then
		if v877.connection then
			v877.connection:Disconnect()
		end
		if v877.track then
			v877.track:Stop()
			v877.track:Destroy()
		end
		v_u_50[p876] = nil
	end
end)