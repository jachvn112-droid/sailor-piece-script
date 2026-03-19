local v1 = {}
local v_u_2 = "rbxasset://textures/ui/traildot.png"
local v_u_3 = "rbxasset://textures/ui/waypoint.png"
local v_u_4 = false
local v_u_5 = UDim2.new(0, 42, 0, 50)
local v_u_6 = Vector2.new(0, 0.5)
local v_u_7 = Vector2.new(0, 1)
local v_u_8 = Vector2.new(0, 0.5)
local v_u_9 = Vector2.new(0.1, 0.5)
local v_u_10 = Vector2.new(-0.1, 0.5)
local v_u_11 = Vector2.new(1.5, 1.5)
local v_u_12 = RaycastParams.new()
v_u_12.FilterType = Enum.RaycastFilterType.Exclude
local v13 = game:GetService("Players")
local v_u_14 = game:GetService("TweenService")
local v_u_15 = game:GetService("RunService")
local v_u_16 = game:GetService("Workspace")
local v17 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_18 = require(v17:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2")
local v_u_19 = v13.LocalPlayer
local function v_u_31()
	-- upvalues: (ref) v_u_11, (ref) v_u_4, (ref) v_u_2, (copy) v_u_5, (copy) v_u_6, (ref) v_u_3, (copy) v_u_8
	local v20 = Instance.new("Part")
	v20.Size = Vector3.new(1, 1, 1)
	v20.Anchored = true
	v20.CanCollide = false
	v20.Name = "TrailDot"
	v20.Transparency = 1
	local v21 = Instance.new("ImageHandleAdornment")
	v21.Name = "TrailDotImage"
	v21.Size = v_u_11
	v21.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
	v21.AlwaysOnTop = v_u_4
	v21.Image = v_u_2
	v21.Adornee = v20
	v21.Parent = v20
	local v22 = Instance.new("Part")
	v22.Size = Vector3.new(2, 2, 2)
	v22.Anchored = true
	v22.CanCollide = false
	v22.Name = "EndWaypoint"
	v22.Transparency = 1
	local v23 = Instance.new("ImageHandleAdornment")
	v23.Name = "TrailDotImage"
	v23.Size = v_u_11
	v23.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
	v23.AlwaysOnTop = v_u_4
	v23.Image = v_u_2
	v23.Adornee = v22
	v23.Parent = v22
	local v24 = Instance.new("BillboardGui")
	v24.Name = "EndWaypointBillboard"
	v24.Size = v_u_5
	v24.LightInfluence = 0
	v24.SizeOffset = v_u_6
	v24.AlwaysOnTop = true
	v24.Adornee = v22
	v24.Parent = v22
	local v25 = Instance.new("ImageLabel")
	v25.Image = v_u_3
	v25.BackgroundTransparency = 1
	v25.Size = UDim2.new(1, 0, 1, 0)
	v25.Parent = v24
	local v26 = Instance.new("Part")
	v26.Size = Vector3.new(2, 2, 2)
	v26.Anchored = true
	v26.CanCollide = false
	v26.Name = "FailureWaypoint"
	v26.Transparency = 1
	local v27 = Instance.new("ImageHandleAdornment")
	v27.Name = "TrailDotImage"
	v27.Size = v_u_11
	v27.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
	v27.AlwaysOnTop = v_u_4
	v27.Image = v_u_2
	v27.Adornee = v26
	v27.Parent = v26
	local v28 = Instance.new("BillboardGui")
	v28.Name = "FailureWaypointBillboard"
	v28.Size = v_u_5
	v28.LightInfluence = 0
	v28.SizeOffset = v_u_8
	v28.AlwaysOnTop = true
	v28.Adornee = v26
	v28.Parent = v26
	local v29 = Instance.new("Frame")
	v29.BackgroundTransparency = 1
	v29.Size = UDim2.new(0, 0, 0, 0)
	v29.Position = UDim2.new(0.5, 0, 1, 0)
	v29.Parent = v28
	local v30 = Instance.new("ImageLabel")
	v30.Image = v_u_3
	v30.BackgroundTransparency = 1
	v30.Position = UDim2.new(0, -v_u_5.X.Offset / 2, 0, -v_u_5.Y.Offset)
	v30.Size = v_u_5
	v30.Parent = v29
	return v20, v22, v26
end
local v_u_32, v_u_33, v_u_34 = v_u_31()
local function v_u_45(p35, p36)
	-- upvalues: (copy) v_u_18, (copy) v_u_12, (copy) v_u_16, (copy) v_u_19
	if v_u_18 then
		v_u_12.FilterDescendantsInstances = { v_u_16.CurrentCamera, v_u_19.Character }
		local v37 = v_u_16:Raycast(p36 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), v_u_12)
		if v37 then
			p35.CFrame = CFrame.lookAlong(v37.Position, v37.Normal)
			local v38 = v_u_16.CurrentCamera
			local v39 = v38:FindFirstChild("ClickToMoveDisplay")
			if not v39 then
				v39 = Instance.new("Model")
				v39.Name = "ClickToMoveDisplay"
				v39.Parent = v38
			end
			p35.Parent = v39
			return
		end
	else
		local v40, v41, v42 = v_u_16:FindPartOnRayWithIgnoreList(Ray.new(p36 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { v_u_16.CurrentCamera, v_u_19.Character })
		if v40 then
			p35.CFrame = CFrame.new(v41, v41 + v42)
			local v43 = v_u_16.CurrentCamera
			local v44 = v43:FindFirstChild("ClickToMoveDisplay")
			if not v44 then
				v44 = Instance.new("Model")
				v44.Name = "ClickToMoveDisplay"
				v44.Parent = v43
			end
			p35.Parent = v44
		end
	end
end
local v_u_46 = {}
v_u_46.__index = v_u_46
function v_u_46.Destroy(p47)
	p47.DisplayModel:Destroy()
end
function v_u_46.NewDisplayModel(_, p48)
	-- upvalues: (ref) v_u_32, (copy) v_u_45
	local v49 = v_u_32:Clone()
	v_u_45(v49, p48)
	return v49
end
function v_u_46.new(p50, p51)
	-- upvalues: (copy) v_u_46
	local v52 = v_u_46
	local v53 = setmetatable({}, v52)
	v53.DisplayModel = v53:NewDisplayModel(p50)
	v53.ClosestWayPoint = p51
	return v53
end
local v_u_54 = {}
v_u_54.__index = v_u_54
function v_u_54.Destroy(p55)
	p55.Destroyed = true
	p55.Tween:Cancel()
	p55.DisplayModel:Destroy()
end
function v_u_54.NewDisplayModel(_, p56)
	-- upvalues: (ref) v_u_33, (copy) v_u_45
	local v57 = v_u_33:Clone()
	v_u_45(v57, p56)
	return v57
end
function v_u_54.CreateTween(p58)
	-- upvalues: (copy) v_u_14, (copy) v_u_7
	local v59 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true)
	local v60 = {
		["SizeOffset"] = v_u_7
	}
	local v61 = v_u_14:Create(p58.DisplayModel.EndWaypointBillboard, v59, v60)
	v61:Play()
	return v61
end
function v_u_54.TweenInFrom(p62, p63)
	-- upvalues: (copy) v_u_14
	local v64 = p63 - p62.DisplayModel.Position
	local v65 = p62.DisplayModel.EndWaypointBillboard
	local v66 = v64.Y
	v65.StudsOffset = Vector3.new(0, v66, 0)
	local v67 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local v68 = v_u_14:Create(p62.DisplayModel.EndWaypointBillboard, v67, {
		["StudsOffset"] = Vector3.new(0, 0, 0)
	})
	v68:Play()
	return v68
end
function v_u_54.new(p69, p70, p71)
	-- upvalues: (copy) v_u_54
	local v72 = v_u_54
	local v_u_73 = setmetatable({}, v72)
	v_u_73.DisplayModel = v_u_73:NewDisplayModel(p69)
	v_u_73.Destroyed = false
	if p71 and (p71 - p69).Magnitude > 5 then
		v_u_73.Tween = v_u_73:TweenInFrom(p71)
		coroutine.wrap(function()
			-- upvalues: (copy) v_u_73
			v_u_73.Tween.Completed:Wait()
			if not v_u_73.Destroyed then
				v_u_73.Tween = v_u_73:CreateTween()
			end
		end)()
	else
		v_u_73.Tween = v_u_73:CreateTween()
	end
	v_u_73.ClosestWayPoint = p70
	return v_u_73
end
local v_u_74 = {}
v_u_74.__index = v_u_74
function v_u_74.Hide(p75)
	p75.DisplayModel.Parent = nil
end
function v_u_74.Destroy(p76)
	p76.DisplayModel:Destroy()
end
function v_u_74.NewDisplayModel(_, p77)
	-- upvalues: (ref) v_u_34, (copy) v_u_45, (copy) v_u_18, (copy) v_u_12, (copy) v_u_16, (copy) v_u_19
	local v78 = v_u_34:Clone()
	v_u_45(v78, p77)
	if v_u_18 then
		v_u_12.FilterDescendantsInstances = { v_u_16.CurrentCamera, v_u_19.Character }
		local v79 = v_u_16:Raycast(p77 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), v_u_12)
		if v79 then
			v78.CFrame = CFrame.lookAlong(v79.Position, v79.Normal)
			local v80 = v_u_16.CurrentCamera
			local v81 = v80:FindFirstChild("ClickToMoveDisplay")
			if not v81 then
				v81 = Instance.new("Model")
				v81.Name = "ClickToMoveDisplay"
				v81.Parent = v80
			end
			v78.Parent = v81
			return v78
		end
	else
		local v82, v83, v84 = v_u_16:FindPartOnRayWithIgnoreList(Ray.new(p77 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { v_u_16.CurrentCamera, v_u_19.Character })
		if v82 then
			v78.CFrame = CFrame.new(v83, v83 + v84)
			local v85 = v_u_16.CurrentCamera
			local v86 = v85:FindFirstChild("ClickToMoveDisplay")
			if not v86 then
				v86 = Instance.new("Model")
				v86.Name = "ClickToMoveDisplay"
				v86.Parent = v85
			end
			v78.Parent = v86
		end
	end
	return v78
end
function v_u_74.RunFailureTween(p87)
	-- upvalues: (copy) v_u_14, (copy) v_u_9, (copy) v_u_10, (copy) v_u_8
	wait(0.125)
	local v88 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local v89 = {
		["SizeOffset"] = v_u_9
	}
	local v90 = v_u_14:Create(p87.DisplayModel.FailureWaypointBillboard, v88, v89)
	v90:Play()
	v_u_14:Create(p87.DisplayModel.FailureWaypointBillboard.Frame, v88, {
		["Rotation"] = 10
	}):Play()
	v90.Completed:wait()
	local v91 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
	local v92 = {
		["SizeOffset"] = v_u_10
	}
	local v93 = v_u_14:Create(p87.DisplayModel.FailureWaypointBillboard, v91, v92)
	v93:Play()
	local v94 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
	v_u_14:Create(p87.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, v94, {
		["ImageColor3"] = Color3.new(0.75, 0.75, 0.75)
	}):Play()
	v_u_14:Create(p87.DisplayModel.FailureWaypointBillboard.Frame, v94, {
		["Rotation"] = -10
	}):Play()
	v93.Completed:wait()
	local v95 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local v96 = {
		["SizeOffset"] = v_u_8
	}
	local v97 = v_u_14:Create(p87.DisplayModel.FailureWaypointBillboard, v95, v96)
	v97:Play()
	v_u_14:Create(p87.DisplayModel.FailureWaypointBillboard.Frame, v95, {
		["Rotation"] = 0
	}):Play()
	v97.Completed:wait()
	wait(0.125)
end
function v_u_74.new(p98)
	-- upvalues: (copy) v_u_74
	local v99 = v_u_74
	local v100 = setmetatable({}, v99)
	v100.DisplayModel = v100:NewDisplayModel(p98)
	return v100
end
local v_u_101 = Instance.new("Animation")
v_u_101.AnimationId = "rbxassetid://2874840706"
local v_u_102 = nil
local function v_u_114(p103, p104)
	-- upvalues: (copy) v_u_46, (copy) v_u_54
	local v105 = {}
	local v106 = 1
	for v107 = 1, #p103 - 1 do
		local v108 = (p103[v107].Position - p103[#p103].Position).Magnitude < 3
		local v109
		if v107 % 2 == 0 then
			v109 = not v108
		else
			v109 = false
		end
		if v109 then
			v105[v106] = v_u_46.new(p103[v107].Position, v107)
			v106 = v106 + 1
		end
	end
	local v110 = v_u_54.new(p103[#p103].Position, #p103, p104)
	table.insert(v105, v110)
	local v111 = {}
	local v112 = 1
	for v113 = #v105, 1, -1 do
		v111[v112] = v105[v113]
		v112 = v112 + 1
	end
	return v111
end
local v_u_115 = 0
function v1.CreatePathDisplay(p_u_116, p117)
	-- upvalues: (ref) v_u_115, (copy) v_u_114, (copy) v_u_15, (copy) v_u_16, (ref) v_u_11
	v_u_115 = v_u_115 + 1
	local v_u_118 = v_u_114(p_u_116, p117)
	local function v_u_122(p119)
		-- upvalues: (copy) v_u_118
		for v120 = #v_u_118, 1, -1 do
			local v121 = v_u_118[v120]
			if v121.ClosestWayPoint > p119 then
				break
			end
			v121:Destroy()
			v_u_118[v120] = nil
		end
	end
	local v_u_123 = "ClickToMoveResizeTrail" .. v_u_115
	local function v129()
		-- upvalues: (copy) v_u_118, (ref) v_u_15, (copy) v_u_123, (ref) v_u_16, (ref) v_u_11
		if #v_u_118 == 0 then
			v_u_15:UnbindFromRenderStep(v_u_123)
		else
			local v124 = v_u_16.CurrentCamera.CFrame.p
			for v125 = 1, #v_u_118 do
				local v126 = v_u_118[v125].DisplayModel:FindFirstChild("TrailDotImage")
				if v126 then
					local v127 = v_u_11
					local v128 = (v_u_118[v125].DisplayModel.Position - v124).Magnitude - 10
					v126.Size = v127 * (math.clamp(v128, 0, 90) / 90 * 1.5 + 1)
				end
			end
		end
	end
	v_u_15:BindToRenderStep(v_u_123, Enum.RenderPriority.Camera.Value - 1, v129)
	return function()
		-- upvalues: (copy) v_u_122, (copy) p_u_116
		v_u_122(#p_u_116)
	end, v_u_122
end
local v_u_130 = nil
function v1.DisplayFailureWaypoint(p131)
	-- upvalues: (ref) v_u_130, (copy) v_u_74
	if v_u_130 then
		v_u_130:Hide()
	end
	local v_u_132 = v_u_74.new(p131)
	v_u_130 = v_u_132
	coroutine.wrap(function()
		-- upvalues: (ref) v_u_132
		v_u_132:RunFailureTween()
		v_u_132:Destroy()
		v_u_132 = nil
	end)()
end
function v1.CreateEndWaypoint(p133)
	-- upvalues: (copy) v_u_54
	return v_u_54.new(p133)
end
function v1.PlayFailureAnimation()
	-- upvalues: (copy) v_u_19, (ref) v_u_102, (copy) v_u_101
	local v134 = v_u_19.Character
	local v135
	if v134 then
		v135 = v134:FindFirstChildOfClass("Humanoid")
	else
		v135 = nil
	end
	if v135 then
		local v136
		if v135 == nil then
			v136 = v_u_102
		else
			v_u_102 = v135:LoadAnimation(v_u_101)
			local v137 = v_u_102
			assert(v137, "")
			v_u_102.Priority = Enum.AnimationPriority.Action
			v_u_102.Looped = false
			v136 = v_u_102
		end
		v136:Play()
	end
end
function v1.CancelFailureAnimation()
	-- upvalues: (ref) v_u_102
	if v_u_102 ~= nil and v_u_102.IsPlaying then
		v_u_102:Stop()
	end
end
function v1.SetWaypointTexture(p138)
	-- upvalues: (ref) v_u_2, (ref) v_u_32, (ref) v_u_33, (ref) v_u_34, (copy) v_u_31
	v_u_2 = p138
	local v139, v140, v141 = v_u_31()
	v_u_32 = v139
	v_u_33 = v140
	v_u_34 = v141
end
function v1.GetWaypointTexture()
	-- upvalues: (ref) v_u_2
	return v_u_2
end
function v1.SetWaypointRadius(p142)
	-- upvalues: (ref) v_u_11, (ref) v_u_32, (ref) v_u_33, (ref) v_u_34, (copy) v_u_31
	v_u_11 = Vector2.new(p142, p142)
	local v143, v144, v145 = v_u_31()
	v_u_32 = v143
	v_u_33 = v144
	v_u_34 = v145
end
function v1.GetWaypointRadius()
	-- upvalues: (ref) v_u_11
	return v_u_11.X
end
function v1.SetEndWaypointTexture(p146)
	-- upvalues: (ref) v_u_3, (ref) v_u_32, (ref) v_u_33, (ref) v_u_34, (copy) v_u_31
	v_u_3 = p146
	local v147, v148, v149 = v_u_31()
	v_u_32 = v147
	v_u_33 = v148
	v_u_34 = v149
end
function v1.GetEndWaypointTexture()
	-- upvalues: (ref) v_u_3
	return v_u_3
end
function v1.SetWaypointsAlwaysOnTop(p150)
	-- upvalues: (ref) v_u_4, (ref) v_u_32, (ref) v_u_33, (ref) v_u_34, (copy) v_u_31
	v_u_4 = p150
	local v151, v152, v153 = v_u_31()
	v_u_32 = v151
	v_u_33 = v152
	v_u_34 = v153
end
function v1.GetWaypointsAlwaysOnTop()
	-- upvalues: (ref) v_u_4
	return v_u_4
end
return v1