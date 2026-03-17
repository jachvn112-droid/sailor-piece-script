local v_u_1 = script.Parent
local v2 = v_u_1:WaitForChild("Torso")
local v_u_3 = v2:WaitForChild("Right Shoulder")
local v_u_4 = v2:WaitForChild("Left Shoulder")
local v_u_5 = v2:WaitForChild("Right Hip")
local v_u_6 = v2:WaitForChild("Left Hip")
v2:WaitForChild("Neck")
local v_u_7 = v_u_1:WaitForChild("Humanoid")
local v_u_8 = "Standing"
local v_u_9 = ""
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = 1
local v_u_14 = {}
local v_u_15 = {
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
local v_u_16 = { "dance1", "dance2", "dance3" }
local v_u_17 = {
	["wave"] = false,
	["point"] = false,
	["dance1"] = true,
	["dance2"] = true,
	["dance3"] = true,
	["laugh"] = false,
	["cheer"] = false
}
function configureAnimationSet(p_u_18, p_u_19)
	-- upvalues: (copy) v_u_14
	if v_u_14[p_u_18] ~= nil then
		for _, v20 in pairs(v_u_14[p_u_18].connections) do
			v20:disconnect()
		end
	end
	v_u_14[p_u_18] = {}
	v_u_14[p_u_18].count = 0
	v_u_14[p_u_18].totalWeight = 0
	v_u_14[p_u_18].connections = {}
	local v21 = script:FindFirstChild(p_u_18)
	if v21 ~= nil then
		local v22 = v_u_14[p_u_18].connections
		local v23 = v21.ChildAdded
		table.insert(v22, v23:connect(function(_)
			-- upvalues: (copy) p_u_18, (copy) p_u_19
			configureAnimationSet(p_u_18, p_u_19)
		end))
		local v24 = v_u_14[p_u_18].connections
		local v25 = v21.ChildRemoved
		table.insert(v24, v25:connect(function(_)
			-- upvalues: (copy) p_u_18, (copy) p_u_19
			configureAnimationSet(p_u_18, p_u_19)
		end))
		local v26 = 1
		for _, v27 in pairs(v21:GetChildren()) do
			if v27:IsA("Animation") then
				local v28 = v_u_14[p_u_18].connections
				local v29 = v27.Changed
				table.insert(v28, v29:connect(function(_)
					-- upvalues: (copy) p_u_18, (copy) p_u_19
					configureAnimationSet(p_u_18, p_u_19)
				end))
				v_u_14[p_u_18][v26] = {}
				v_u_14[p_u_18][v26].anim = v27
				local v30 = v27:FindFirstChild("Weight")
				if v30 == nil then
					v_u_14[p_u_18][v26].weight = 1
				else
					v_u_14[p_u_18][v26].weight = v30.Value
				end
				v_u_14[p_u_18].count = v_u_14[p_u_18].count + 1
				v_u_14[p_u_18].totalWeight = v_u_14[p_u_18].totalWeight + v_u_14[p_u_18][v26].weight
				v26 = v26 + 1
			end
		end
	end
	if v_u_14[p_u_18].count <= 0 then
		for v31, v32 in pairs(p_u_19) do
			v_u_14[p_u_18][v31] = {}
			v_u_14[p_u_18][v31].anim = Instance.new("Animation")
			v_u_14[p_u_18][v31].anim.Name = p_u_18
			v_u_14[p_u_18][v31].anim.AnimationId = v32.id
			v_u_14[p_u_18][v31].weight = v32.weight
			v_u_14[p_u_18].count = v_u_14[p_u_18].count + 1
			v_u_14[p_u_18].totalWeight = v_u_14[p_u_18].totalWeight + v32.weight
		end
	end
end
function scriptChildModified(p33)
	-- upvalues: (copy) v_u_15
	local v34 = v_u_15[p33.Name]
	if v34 ~= nil then
		configureAnimationSet(p33.Name, v34)
	end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
local v35
if v_u_7 then
	v35 = v_u_7:FindFirstChildOfClass("Animator")
else
	v35 = nil
end
if v35 then
	local v36 = v35:GetPlayingAnimationTracks()
	for _, v37 in ipairs(v36) do
		v37:Stop(0)
		v37:Destroy()
	end
end
for v38, v39 in pairs(v_u_15) do
	configureAnimationSet(v38, v39)
end
local v_u_40 = "None"
local v_u_41 = 0
local v_u_42 = 0
function stopAllAnimations()
	-- upvalues: (ref) v_u_9, (copy) v_u_17, (ref) v_u_10, (ref) v_u_12, (ref) v_u_11
	local v43 = v_u_9
	local v44 = v_u_17[v43] ~= nil and v_u_17[v43] == false and "idle" or v43
	v_u_9 = ""
	v_u_10 = nil
	if v_u_12 ~= nil then
		v_u_12:disconnect()
	end
	if v_u_11 ~= nil then
		v_u_11:Stop()
		v_u_11:Destroy()
		v_u_11 = nil
	end
	return v44
end
function setAnimationSpeed(p45)
	-- upvalues: (ref) v_u_13, (ref) v_u_11
	if p45 ~= v_u_13 then
		v_u_13 = p45
		v_u_11:AdjustSpeed(v_u_13)
	end
end
function keyFrameReachedFunc(p46)
	-- upvalues: (ref) v_u_9, (copy) v_u_17, (ref) v_u_13, (copy) v_u_7
	if p46 == "End" then
		local v47 = v_u_9
		local v48 = v_u_17[v47] ~= nil and v_u_17[v47] == false and "idle" or v47
		local v49 = v_u_13
		playAnimation(v48, 0, v_u_7)
		setAnimationSpeed(v49)
	end
end
function playAnimation(p50, p51, p52)
	-- upvalues: (copy) v_u_14, (ref) v_u_10, (ref) v_u_11, (ref) v_u_13, (ref) v_u_9, (ref) v_u_12
	local v53 = math.random(1, v_u_14[p50].totalWeight)
	local v54 = 1
	while v_u_14[p50][v54].weight < v53 do
		v53 = v53 - v_u_14[p50][v54].weight
		v54 = v54 + 1
	end
	local v55 = v_u_14[p50][v54].anim
	if v55 ~= v_u_10 then
		if v_u_11 ~= nil then
			v_u_11:Stop(p51)
			v_u_11:Destroy()
		end
		v_u_13 = 1
		v_u_11 = p52:LoadAnimation(v55)
		v_u_11.Priority = Enum.AnimationPriority.Core
		v_u_11:Play(p51)
		v_u_9 = p50
		v_u_10 = v55
		if v_u_12 ~= nil then
			v_u_12:disconnect()
		end
		v_u_12 = v_u_11.KeyframeReached:connect(keyFrameReachedFunc)
	end
end
local v_u_56 = ""
local v_u_57 = nil
local v_u_58 = nil
local v_u_59 = nil
function toolKeyFrameReachedFunc(p60)
	-- upvalues: (ref) v_u_56, (copy) v_u_7
	if p60 == "End" then
		playToolAnimation(v_u_56, 0, v_u_7)
	end
end
function playToolAnimation(p61, p62, p63, p64)
	-- upvalues: (copy) v_u_14, (ref) v_u_58, (ref) v_u_57, (ref) v_u_56, (ref) v_u_59
	local v65 = math.random(1, v_u_14[p61].totalWeight)
	local v66 = 1
	while v_u_14[p61][v66].weight < v65 do
		v65 = v65 - v_u_14[p61][v66].weight
		v66 = v66 + 1
	end
	local v67 = v_u_14[p61][v66].anim
	if v_u_58 ~= v67 then
		if v_u_57 ~= nil then
			v_u_57:Stop()
			v_u_57:Destroy()
			p62 = 0
		end
		v_u_57 = p63:LoadAnimation(v67)
		if p64 then
			v_u_57.Priority = p64
		end
		v_u_57:Play(p62)
		v_u_56 = p61
		v_u_58 = v67
		v_u_59 = v_u_57.KeyframeReached:connect(toolKeyFrameReachedFunc)
	end
end
function stopToolAnimations()
	-- upvalues: (ref) v_u_56, (ref) v_u_59, (ref) v_u_58, (ref) v_u_57
	local v68 = v_u_56
	if v_u_59 ~= nil then
		v_u_59:disconnect()
	end
	v_u_56 = ""
	v_u_58 = nil
	if v_u_57 ~= nil then
		v_u_57:Stop()
		v_u_57:Destroy()
		v_u_57 = nil
	end
	return v68
end
function onRunning(p69)
	-- upvalues: (copy) v_u_1, (copy) v_u_7, (ref) v_u_10, (ref) v_u_8, (copy) v_u_17, (ref) v_u_9
	local v70 = p69 / v_u_1:GetScale()
	if v70 > 0.01 then
		playAnimation("walk", 0.1, v_u_7)
		if v_u_10 and v_u_10.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
			setAnimationSpeed(v70 / 14.5)
		end
		v_u_8 = "Running"
	elseif v_u_17[v_u_9] == nil then
		playAnimation("idle", 0.1, v_u_7)
		v_u_8 = "Standing"
	end
end
function onDied()
	-- upvalues: (ref) v_u_8
	v_u_8 = "Dead"
end
function onJumping()
	-- upvalues: (copy) v_u_7, (ref) v_u_42, (ref) v_u_8
	playAnimation("jump", 0.1, v_u_7)
	v_u_42 = 0.3
	v_u_8 = "Jumping"
end
function onClimbing(p71)
	-- upvalues: (copy) v_u_1, (copy) v_u_7, (ref) v_u_8
	local v72 = p71 / v_u_1:GetScale()
	playAnimation("climb", 0.1, v_u_7)
	setAnimationSpeed(v72 / 12)
	v_u_8 = "Climbing"
end
function onGettingUp()
	-- upvalues: (ref) v_u_8
	v_u_8 = "GettingUp"
end
function onFreeFall()
	-- upvalues: (ref) v_u_42, (copy) v_u_7, (ref) v_u_8
	if v_u_42 <= 0 then
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
function onSwimming(p73)
	-- upvalues: (ref) v_u_8
	if p73 > 0 then
		v_u_8 = "Running"
	else
		v_u_8 = "Standing"
	end
end
function getTool()
	-- upvalues: (copy) v_u_1
	for _, v74 in ipairs(v_u_1:GetChildren()) do
		if v74.className == "Tool" then
			return v74
		end
	end
	return nil
end
function getToolAnim(p75)
	for _, v76 in ipairs(p75:GetChildren()) do
		if v76.Name == "toolanim" and v76.className == "StringValue" then
			return v76
		end
	end
	return nil
end
function animateTool()
	-- upvalues: (ref) v_u_40, (copy) v_u_7
	if v_u_40 == "None" then
		playToolAnimation("toolnone", 0.1, v_u_7, Enum.AnimationPriority.Idle)
		return
	elseif v_u_40 == "Slash" then
		playToolAnimation("toolslash", 0, v_u_7, Enum.AnimationPriority.Action)
		return
	elseif v_u_40 == "Lunge" then
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
local v_u_77 = 0
function move(p78)
	-- upvalues: (ref) v_u_77, (ref) v_u_42, (ref) v_u_8, (copy) v_u_7, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (ref) v_u_40, (ref) v_u_41, (ref) v_u_58
	local v79 = 1
	local v80 = 1
	local v81 = p78 - v_u_77
	v_u_77 = p78
	local v82 = false
	if v_u_42 > 0 then
		v_u_42 = v_u_42 - v81
	end
	if v_u_8 == "FreeFall" and v_u_42 <= 0 then
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
			v82 = true
			v80 = 1
			v79 = 0.1
		end
	end
	if v82 then
		local v83 = p78 * v80
		local v84 = v79 * math.sin(v83)
		v_u_3:SetDesiredAngle(v84 + 0)
		v_u_4:SetDesiredAngle(v84 - 0)
		v_u_5:SetDesiredAngle(-v84)
		v_u_6:SetDesiredAngle(-v84)
	end
	local v85 = getTool()
	if v85 and v85:FindFirstChild("Handle") then
		local v86 = getToolAnim(v85)
		if v86 then
			v_u_40 = v86.Value
			v86.Parent = nil
			v_u_41 = p78 + 0.3
		end
		if v_u_41 < p78 then
			v_u_41 = 0
			v_u_40 = "None"
		end
		animateTool()
	else
		stopToolAnimations()
		v_u_40 = "None"
		v_u_58 = nil
		v_u_41 = 0
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
game:GetService("Players").LocalPlayer.Chatted:connect(function(p87)
	-- upvalues: (copy) v_u_16, (ref) v_u_8, (copy) v_u_17, (copy) v_u_7
	local v88 = ""
	if p87 == "/e dance" then
		v88 = v_u_16[math.random(1, #v_u_16)]
	elseif string.sub(p87, 1, 3) == "/e " then
		v88 = string.sub(p87, 4)
	elseif string.sub(p87, 1, 7) == "/emote " then
		v88 = string.sub(p87, 8)
	end
	if v_u_8 == "Standing" and v_u_17[v88] ~= nil then
		playAnimation(v88, 0.1, v_u_7)
	end
end)
script:WaitForChild("PlayEmote").OnInvoke = function(p89)
	-- upvalues: (ref) v_u_8, (copy) v_u_17, (copy) v_u_7, (ref) v_u_11
	if v_u_8 == "Standing" then
		if v_u_17[p89] == nil then
			return false
		end
		playAnimation(p89, 0.1, v_u_7)
		return true, v_u_11
	end
end
playAnimation("idle", 0.1, v_u_7)
local _ = "Standing"
while v_u_1.Parent ~= nil do
	local _, v90 = wait(0.1)
	move(v90)
end