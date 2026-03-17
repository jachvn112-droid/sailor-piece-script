local v_u_1 = script.Parent
local v2 = v_u_1:WaitForChild("Torso")
local v_u_3 = v2:WaitForChild("Right Shoulder")
local v_u_4 = v2:WaitForChild("Left Shoulder")
local v_u_5 = v2:WaitForChild("Right Hip")
local v_u_6 = v2:WaitForChild("Left Hip")
v2:WaitForChild("Neck")
local v_u_7 = v_u_1:WaitForChild("Humanoid")
local v_u_8 = "Standing"
local v9, v10 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v_u_11 = v9 and v10
local v_u_12 = ""
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = 1
local v_u_17 = {}
local v_u_18 = {
	["idle"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=180435571",
			["weight"] = 9
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=180435792",
			["weight"] = 1
		}
	},
	["walk"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=180426354",
			["weight"] = 10
		}
	},
	["run"] = {
		{
			["id"] = "run.xml",
			["weight"] = 10
		}
	},
	["jump"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=125750702",
			["weight"] = 10
		}
	},
	["fall"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=180436148",
			["weight"] = 10
		}
	},
	["climb"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=180436334",
			["weight"] = 10
		}
	},
	["sit"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=178130996",
			["weight"] = 10
		}
	},
	["toolnone"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=182393478",
			["weight"] = 10
		}
	},
	["toolslash"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=129967390",
			["weight"] = 10
		}
	},
	["toollunge"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=129967478",
			["weight"] = 10
		}
	},
	["wave"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=128777973",
			["weight"] = 10
		}
	},
	["point"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=128853357",
			["weight"] = 10
		}
	},
	["dance1"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=182435998",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491037",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491065",
			["weight"] = 10
		}
	},
	["dance2"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=182436842",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491248",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491277",
			["weight"] = 10
		}
	},
	["dance3"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=182436935",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491368",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491423",
			["weight"] = 10
		}
	},
	["laugh"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=129423131",
			["weight"] = 10
		}
	},
	["cheer"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=129423030",
			["weight"] = 10
		}
	}
}
local v_u_19 = { "dance1", "dance2", "dance3" }
local v_u_20 = {
	["wave"] = false,
	["point"] = false,
	["dance1"] = true,
	["dance2"] = true,
	["dance3"] = true,
	["laugh"] = false,
	["cheer"] = false
}
function configureAnimationSet(p_u_21, p_u_22)
	-- upvalues: (copy) v_u_17
	if v_u_17[p_u_21] ~= nil then
		for _, v23 in pairs(v_u_17[p_u_21].connections) do
			v23:disconnect()
		end
	end
	v_u_17[p_u_21] = {}
	v_u_17[p_u_21].count = 0
	v_u_17[p_u_21].totalWeight = 0
	v_u_17[p_u_21].connections = {}
	local v24 = script:FindFirstChild(p_u_21)
	if v24 ~= nil then
		local v25 = v_u_17[p_u_21].connections
		local v26 = v24.ChildAdded
		table.insert(v25, v26:connect(function(_)
			-- upvalues: (copy) p_u_21, (copy) p_u_22
			configureAnimationSet(p_u_21, p_u_22)
		end))
		local v27 = v_u_17[p_u_21].connections
		local v28 = v24.ChildRemoved
		table.insert(v27, v28:connect(function(_)
			-- upvalues: (copy) p_u_21, (copy) p_u_22
			configureAnimationSet(p_u_21, p_u_22)
		end))
		local v29 = 1
		for _, v30 in pairs(v24:GetChildren()) do
			if v30:IsA("Animation") then
				local v31 = v_u_17[p_u_21].connections
				local v32 = v30.Changed
				table.insert(v31, v32:connect(function(_)
					-- upvalues: (copy) p_u_21, (copy) p_u_22
					configureAnimationSet(p_u_21, p_u_22)
				end))
				v_u_17[p_u_21][v29] = {}
				v_u_17[p_u_21][v29].anim = v30
				local v33 = v30:FindFirstChild("Weight")
				if v33 == nil then
					v_u_17[p_u_21][v29].weight = 1
				else
					v_u_17[p_u_21][v29].weight = v33.Value
				end
				v_u_17[p_u_21].count = v_u_17[p_u_21].count + 1
				v_u_17[p_u_21].totalWeight = v_u_17[p_u_21].totalWeight + v_u_17[p_u_21][v29].weight
				v29 = v29 + 1
			end
		end
	end
	if v_u_17[p_u_21].count <= 0 then
		for v34, v35 in pairs(p_u_22) do
			v_u_17[p_u_21][v34] = {}
			v_u_17[p_u_21][v34].anim = Instance.new("Animation")
			v_u_17[p_u_21][v34].anim.Name = p_u_21
			v_u_17[p_u_21][v34].anim.AnimationId = v35.id
			v_u_17[p_u_21][v34].weight = v35.weight
			v_u_17[p_u_21].count = v_u_17[p_u_21].count + 1
			v_u_17[p_u_21].totalWeight = v_u_17[p_u_21].totalWeight + v35.weight
		end
	end
end
function scriptChildModified(p36)
	-- upvalues: (copy) v_u_18
	local v37 = v_u_18[p36.Name]
	if v37 ~= nil then
		configureAnimationSet(p36.Name, v37)
	end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
local v38
if v_u_7 then
	v38 = v_u_7:FindFirstChildOfClass("Animator")
else
	v38 = nil
end
if v38 then
	local v39 = v38:GetPlayingAnimationTracks()
	for _, v40 in ipairs(v39) do
		v40:Stop(0)
		v40:Destroy()
	end
end
for v41, v42 in pairs(v_u_18) do
	configureAnimationSet(v41, v42)
end
local v_u_43 = "None"
local v_u_44 = 0
local v_u_45 = 0
function stopAllAnimations()
	-- upvalues: (ref) v_u_12, (copy) v_u_20, (ref) v_u_13, (ref) v_u_15, (ref) v_u_14
	local v46 = v_u_12
	local v47 = v_u_20[v46] ~= nil and v_u_20[v46] == false and "idle" or v46
	v_u_12 = ""
	v_u_13 = nil
	if v_u_15 ~= nil then
		v_u_15:disconnect()
	end
	if v_u_14 ~= nil then
		v_u_14:Stop()
		v_u_14:Destroy()
		v_u_14 = nil
	end
	return v47
end
function setAnimationSpeed(p48)
	-- upvalues: (ref) v_u_16, (ref) v_u_14
	if p48 ~= v_u_16 then
		v_u_16 = p48
		v_u_14:AdjustSpeed(v_u_16)
	end
end
function keyFrameReachedFunc(p49)
	-- upvalues: (ref) v_u_12, (copy) v_u_20, (ref) v_u_16, (copy) v_u_7
	if p49 == "End" then
		local v50 = v_u_12
		local v51 = v_u_20[v50] ~= nil and v_u_20[v50] == false and "idle" or v50
		local v52 = v_u_16
		playAnimation(v51, 0, v_u_7)
		setAnimationSpeed(v52)
	end
end
function playAnimation(p53, p54, p55)
	-- upvalues: (copy) v_u_17, (ref) v_u_13, (ref) v_u_14, (ref) v_u_16, (ref) v_u_12, (ref) v_u_15
	local v56 = math.random(1, v_u_17[p53].totalWeight)
	local v57 = 1
	while v_u_17[p53][v57].weight < v56 do
		v56 = v56 - v_u_17[p53][v57].weight
		v57 = v57 + 1
	end
	local v58 = v_u_17[p53][v57].anim
	if v58 ~= v_u_13 then
		if v_u_14 ~= nil then
			v_u_14:Stop(p54)
			v_u_14:Destroy()
		end
		v_u_16 = 1
		v_u_14 = p55:LoadAnimation(v58)
		v_u_14.Priority = Enum.AnimationPriority.Core
		v_u_14:Play(p54)
		v_u_12 = p53
		v_u_13 = v58
		if v_u_15 ~= nil then
			v_u_15:disconnect()
		end
		v_u_15 = v_u_14.KeyframeReached:connect(keyFrameReachedFunc)
	end
end
local v_u_59 = ""
local v_u_60 = nil
local v_u_61 = nil
local v_u_62 = nil
function toolKeyFrameReachedFunc(p63)
	-- upvalues: (ref) v_u_59, (copy) v_u_7
	if p63 == "End" then
		playToolAnimation(v_u_59, 0, v_u_7)
	end
end
function playToolAnimation(p64, p65, p66, p67)
	-- upvalues: (copy) v_u_17, (ref) v_u_61, (ref) v_u_60, (ref) v_u_59, (ref) v_u_62
	local v68 = math.random(1, v_u_17[p64].totalWeight)
	local v69 = 1
	while v_u_17[p64][v69].weight < v68 do
		v68 = v68 - v_u_17[p64][v69].weight
		v69 = v69 + 1
	end
	local v70 = v_u_17[p64][v69].anim
	if v_u_61 ~= v70 then
		if v_u_60 ~= nil then
			v_u_60:Stop()
			v_u_60:Destroy()
			p65 = 0
		end
		v_u_60 = p66:LoadAnimation(v70)
		if p67 then
			v_u_60.Priority = p67
		end
		v_u_60:Play(p65)
		v_u_59 = p64
		v_u_61 = v70
		v_u_62 = v_u_60.KeyframeReached:connect(toolKeyFrameReachedFunc)
	end
end
function stopToolAnimations()
	-- upvalues: (ref) v_u_59, (ref) v_u_62, (ref) v_u_61, (ref) v_u_60
	local v71 = v_u_59
	if v_u_62 ~= nil then
		v_u_62:disconnect()
	end
	v_u_59 = ""
	v_u_61 = nil
	if v_u_60 ~= nil then
		v_u_60:Stop()
		v_u_60:Destroy()
		v_u_60 = nil
	end
	return v71
end
function onRunning(p72)
	-- upvalues: (copy) v_u_11, (copy) v_u_1, (copy) v_u_7, (ref) v_u_13, (ref) v_u_8, (copy) v_u_20, (ref) v_u_12
	local v73 = p72 / (not v_u_11 and 1 or v_u_1:GetScale())
	if v73 > 0.01 then
		playAnimation("walk", 0.1, v_u_7)
		if v_u_13 and v_u_13.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
			setAnimationSpeed(v73 / 14.5)
		end
		v_u_8 = "Running"
	elseif v_u_20[v_u_12] == nil then
		playAnimation("idle", 0.1, v_u_7)
		v_u_8 = "Standing"
	end
end
function onDied()
	-- upvalues: (ref) v_u_8
	v_u_8 = "Dead"
end
function onJumping()
	-- upvalues: (copy) v_u_7, (ref) v_u_45, (ref) v_u_8
	playAnimation("jump", 0.1, v_u_7)
	v_u_45 = 0.3
	v_u_8 = "Jumping"
end
function onClimbing(p74)
	-- upvalues: (copy) v_u_11, (copy) v_u_1, (copy) v_u_7, (ref) v_u_8
	local v75 = p74 / (not v_u_11 and 1 or v_u_1:GetScale())
	playAnimation("climb", 0.1, v_u_7)
	setAnimationSpeed(v75 / 12)
	v_u_8 = "Climbing"
end
function onGettingUp()
	-- upvalues: (ref) v_u_8
	v_u_8 = "GettingUp"
end
function onFreeFall()
	-- upvalues: (ref) v_u_45, (copy) v_u_7, (ref) v_u_8
	if v_u_45 <= 0 then
		playAnimation("fall", 0.3, v_u_7)
	end
	v_u_8 = "FreeFall"
end
function onFallingDown()
	-- upvalues: (ref) v_u_8
	v_u_8 = "FallingDown"
end
function onSeated()
	-- upvalues: (ref) v_u_8
	v_u_8 = "Seated"
end
function onPlatformStanding()
	-- upvalues: (ref) v_u_8
	v_u_8 = "PlatformStanding"
end
function onSwimming(p76)
	-- upvalues: (ref) v_u_8
	if p76 > 0 then
		v_u_8 = "Running"
	else
		v_u_8 = "Standing"
	end
end
function getTool()
	-- upvalues: (copy) v_u_1
	for _, v77 in ipairs(v_u_1:GetChildren()) do
		if v77.className == "Tool" then
			return v77
		end
	end
	return nil
end
function getToolAnim(p78)
	for _, v79 in ipairs(p78:GetChildren()) do
		if v79.Name == "toolanim" and v79.className == "StringValue" then
			return v79
		end
	end
	return nil
end
function animateTool()
	-- upvalues: (ref) v_u_43, (copy) v_u_7
	if v_u_43 == "None" then
		playToolAnimation("toolnone", 0.1, v_u_7, Enum.AnimationPriority.Idle)
		return
	elseif v_u_43 == "Slash" then
		playToolAnimation("toolslash", 0, v_u_7, Enum.AnimationPriority.Action)
		return
	elseif v_u_43 == "Lunge" then
		playToolAnimation("toollunge", 0, v_u_7, Enum.AnimationPriority.Action)
	end
end
function moveSit()
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6
	v_u_3.MaxVelocity = 0.15
	v_u_4.MaxVelocity = 0.15
	v_u_3:SetDesiredAngle(1.57)
	v_u_4:SetDesiredAngle(-1.57)
	v_u_5:SetDesiredAngle(1.57)
	v_u_6:SetDesiredAngle(-1.57)
end
local v_u_80 = 0
function move(p81)
	-- upvalues: (ref) v_u_80, (ref) v_u_45, (ref) v_u_8, (copy) v_u_7, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (ref) v_u_43, (ref) v_u_44, (ref) v_u_61
	local v82 = 1
	local v83 = 1
	local v84 = p81 - v_u_80
	v_u_80 = p81
	local v85 = false
	if v_u_45 > 0 then
		v_u_45 = v_u_45 - v84
	end
	if v_u_8 == "FreeFall" and v_u_45 <= 0 then
		playAnimation("fall", 0.3, v_u_7)
	else
		if v_u_8 == "Seated" then
			playAnimation("sit", 0.5, v_u_7)
			return
		end
		if v_u_8 == "Running" then
			playAnimation("walk", 0.1, v_u_7)
		elseif v_u_8 == "Dead" or (v_u_8 == "GettingUp" or (v_u_8 == "FallingDown" or (v_u_8 == "Seated" or v_u_8 == "PlatformStanding"))) then
			stopAllAnimations()
			v85 = true
			v83 = 1
			v82 = 0.1
		end
	end
	if v85 then
		local v86 = p81 * v83
		local v87 = v82 * math.sin(v86)
		v_u_3:SetDesiredAngle(v87 + 0)
		v_u_4:SetDesiredAngle(v87 - 0)
		v_u_5:SetDesiredAngle(-v87)
		v_u_6:SetDesiredAngle(-v87)
	end
	local v88 = getTool()
	if v88 and v88:FindFirstChild("Handle") then
		local v89 = getToolAnim(v88)
		if v89 then
			v_u_43 = v89.Value
			v89.Parent = nil
			v_u_44 = p81 + 0.3
		end
		if v_u_44 < p81 then
			v_u_44 = 0
			v_u_43 = "None"
		end
		animateTool()
	else
		stopToolAnimations()
		v_u_43 = "None"
		v_u_61 = nil
		v_u_44 = 0
	end
end
v_u_7.Died:connect(onDied)
v_u_7.Running:connect(onRunning)
v_u_7.Jumping:connect(onJumping)
v_u_7.Climbing:connect(onClimbing)
v_u_7.GettingUp:connect(onGettingUp)
v_u_7.FreeFalling:connect(onFreeFall)
v_u_7.FallingDown:connect(onFallingDown)
v_u_7.Seated:connect(onSeated)
v_u_7.PlatformStanding:connect(onPlatformStanding)
v_u_7.Swimming:connect(onSwimming)
game:GetService("Players").LocalPlayer.Chatted:connect(function(p90)
	-- upvalues: (copy) v_u_19, (ref) v_u_8, (copy) v_u_20, (copy) v_u_7
	local v91 = ""
	if p90 == "/e dance" then
		v91 = v_u_19[math.random(1, #v_u_19)]
	elseif string.sub(p90, 1, 3) == "/e " then
		v91 = string.sub(p90, 4)
	elseif string.sub(p90, 1, 7) == "/emote " then
		v91 = string.sub(p90, 8)
	end
	if v_u_8 == "Standing" and v_u_20[v91] ~= nil then
		playAnimation(v91, 0.1, v_u_7)
	end
end)
script:WaitForChild("PlayEmote").OnInvoke = function(p92)
	-- upvalues: (ref) v_u_8, (copy) v_u_20, (copy) v_u_7, (ref) v_u_14
	if v_u_8 == "Standing" then
		if v_u_20[p92] == nil then
			return false
		end
		playAnimation(p92, 0.1, v_u_7)
		return true, v_u_14
	end
end
playAnimation("idle", 0.1, v_u_7)
local _ = "Standing"
while v_u_1.Parent ~= nil do
	local _, v93 = wait(0.1)
	move(v93)
end