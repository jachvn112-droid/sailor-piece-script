local v_u_1 = game:GetService("VRService")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("PathfindingService")
local v_u_6 = game:GetService("ContextActionService")
local v_u_7 = game:GetService("StarterGui")
local v8 = script.Parent.Parent:WaitForChild("CommonUtils")
local v9 = require(v8:WaitForChild("FlagUtil"))
local v_u_10 = nil
local v_u_11 = v4.LocalPlayer
local v_u_12 = RaycastParams.new()
v_u_12.FilterType = Enum.RaycastFilterType.Exclude
local v_u_13 = v9.getUserFlag("UserRaycastUpdateAPI2")
local v_u_14 = Instance.new("BindableEvent")
v_u_14.Name = "MovementUpdate"
v_u_14.Parent = script
coroutine.wrap(function()
	-- upvalues: (ref) v_u_10
	local v15 = script.Parent:WaitForChild("PathDisplay")
	if v15 then
		v_u_10 = require(v15)
	end
end)()
local v_u_16 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_17 = setmetatable({}, v_u_16)
v_u_17.__index = v_u_17
function v_u_17.new(p18)
	-- upvalues: (copy) v_u_16, (copy) v_u_17
	local v19 = v_u_16.new()
	local v20 = v_u_17
	local v21 = setmetatable(v19, v20)
	v21.CONTROL_ACTION_PRIORITY = p18
	v21.navigationRequestedConn = nil
	v21.heartbeatConn = nil
	v21.currentDestination = nil
	v21.currentPath = nil
	v21.currentPoints = nil
	v21.currentPointIdx = 0
	v21.expectedTimeToNextPoint = 0
	v21.timeReachedLastPoint = tick()
	v21.moving = false
	v21.isJumpBound = false
	v21.moveLatch = false
	v21.userCFrameEnabledConn = nil
	return v21
end
function v_u_17.SetLaserPointerMode(_, p_u_22)
	-- upvalues: (copy) v_u_7
	pcall(function()
		-- upvalues: (ref) v_u_7, (copy) p_u_22
		v_u_7:SetCore("VRLaserPointerMode", p_u_22)
	end)
end
function v_u_17.GetLocalHumanoid(_)
	-- upvalues: (copy) v_u_11
	local v23 = v_u_11.Character
	if v23 then
		for _, v24 in pairs(v23:GetChildren()) do
			if v24:IsA("Humanoid") then
				return v24
			end
		end
		return nil
	end
end
function v_u_17.HasBothHandControllers(_)
	-- upvalues: (copy) v_u_1
	local v25 = v_u_1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand)
	if v25 then
		v25 = v_u_1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
	end
	return v25
end
function v_u_17.HasAnyHandControllers(_)
	-- upvalues: (copy) v_u_1
	return v_u_1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or v_u_1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
end
function v_u_17.IsMobileVR(_)
	-- upvalues: (copy) v_u_2
	return v_u_2.TouchEnabled
end
function v_u_17.HasGamepad(_)
	-- upvalues: (copy) v_u_2
	return v_u_2.GamepadEnabled
end
function v_u_17.ShouldUseNavigationLaser(p26)
	if p26:IsMobileVR() then
		return true
	elseif p26:HasBothHandControllers() then
		return false
	else
		return p26:HasAnyHandControllers() and true or not p26:HasGamepad()
	end
end
function v_u_17.StartFollowingPath(p27, p28)
	-- upvalues: (copy) v_u_14
	currentPath = p28
	currentPoints = currentPath:GetPointCoordinates()
	currentPointIdx = 1
	moving = true
	timeReachedLastPoint = tick()
	local v29 = p27:GetLocalHumanoid()
	if v29 and (v29.Torso and #currentPoints >= 1) then
		expectedTimeToNextPoint = (currentPoints[1] - v29.Torso.Position).magnitude / v29.WalkSpeed
	end
	v_u_14:Fire("targetPoint", p27.currentDestination)
end
function v_u_17.GoToPoint(p30, p31)
	-- upvalues: (copy) v_u_14
	currentPath = true
	currentPoints = { p31 }
	currentPointIdx = 1
	moving = true
	local v32 = p30:GetLocalHumanoid()
	local v33 = (v32.Torso.Position - p31).magnitude / v32.WalkSpeed
	timeReachedLastPoint = tick()
	expectedTimeToNextPoint = v33
	v_u_14:Fire("targetPoint", p31)
end
function v_u_17.StopFollowingPath(p34)
	currentPath = nil
	currentPoints = nil
	currentPointIdx = 0
	moving = false
	p34.moveVector = Vector3.new(0, 0, 0)
end
function v_u_17.TryComputePath(_, p35, p36)
	-- upvalues: (copy) v_u_5
	local v37 = nil
	local v38 = 0
	while not v37 and v38 < 5 do
		v37 = v_u_5:ComputeSmoothPathAsync(p35, p36, 200)
		v38 = v38 + 1
		if v37.Status == Enum.PathStatus.ClosestNoPath or v37.Status == Enum.PathStatus.ClosestOutOfRange then
			return nil
		end
		if v37 and v37.Status == Enum.PathStatus.FailStartNotEmpty then
			p35 = p35 + (p36 - p35).Unit
			v37 = nil
		end
		if v37 and v37.Status == Enum.PathStatus.FailFinishNotEmpty then
			p36 = p36 + Vector3.new(0, 1, 0)
			v37 = nil
		end
	end
	return v37
end
function v_u_17.OnNavigationRequest(p39, p40, _)
	-- upvalues: (ref) v_u_10
	local v41 = p40.Position
	local v42 = p39.currentDestination
	local v43 = v41.x
	local v44
	if v43 == v43 and v43 ~= (1 / 0) then
		v44 = v43 ~= (-1 / 0)
	else
		v44 = false
	end
	if v44 then
		local v45 = v41.y
		if v45 == v45 and v45 ~= (1 / 0) then
			v44 = v45 ~= (-1 / 0)
		else
			v44 = false
		end
		if v44 then
			local v46 = v41.z
			if v46 == v46 and v46 ~= (1 / 0) then
				v44 = v46 ~= (-1 / 0)
			else
				v44 = false
			end
		end
	end
	if v44 then
		p39.currentDestination = v41
		local v47 = p39:GetLocalHumanoid()
		if v47 and v47.Torso then
			local v48 = v47.Torso.Position
			if (p39.currentDestination - v48).magnitude < 12 then
				p39:GoToPoint(p39.currentDestination)
			elseif v42 and (p39.currentDestination - v42).magnitude <= 4 then
				if moving then
					p39.currentPoints[#currentPoints] = p39.currentDestination
					return
				end
				p39:GoToPoint(p39.currentDestination)
			else
				local v49 = p39:TryComputePath(v48, p39.currentDestination)
				if v49 then
					p39:StartFollowingPath(v49)
					if v_u_10 then
						v_u_10.setCurrentPoints(p39.currentPoints)
						v_u_10.renderPath()
						return
					end
				else
					p39:StopFollowingPath()
					if v_u_10 then
						v_u_10.clearRenderedPath()
						return
					end
				end
			end
		else
			return
		end
	else
		return
	end
end
function v_u_17.OnJumpAction(p50, _, p51, _)
	if p51 == Enum.UserInputState.Begin then
		p50.isJumping = true
	end
	return Enum.ContextActionResult.Sink
end
function v_u_17.BindJumpAction(p_u_52, p53)
	-- upvalues: (copy) v_u_6
	if p53 then
		if not p_u_52.isJumpBound then
			p_u_52.isJumpBound = true
			v_u_6:BindActionAtPriority("VRJumpAction", function()
				-- upvalues: (copy) p_u_52
				return p_u_52:OnJumpAction()
			end, false, p_u_52.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA)
			return
		end
	elseif p_u_52.isJumpBound then
		p_u_52.isJumpBound = false
		v_u_6:UnbindAction("VRJumpAction")
	end
end
function v_u_17.ControlCharacterGamepad(p54, _, p55, p56)
	-- upvalues: (ref) v_u_10, (copy) v_u_14
	if p56.KeyCode == Enum.KeyCode.Thumbstick1 then
		if p55 ~= Enum.UserInputState.Cancel then
			if p55 == Enum.UserInputState.End then
				p54.moveVector = Vector3.new(0, 0, 0)
				if p54:ShouldUseNavigationLaser() then
					p54:BindJumpAction(false)
					p54:SetLaserPointerMode("Navigation")
				end
				if p54.moveLatch then
					p54.moveLatch = false
					v_u_14:Fire("offtrack")
				end
			else
				p54:StopFollowingPath()
				if v_u_10 then
					v_u_10.clearRenderedPath()
				end
				if p54:ShouldUseNavigationLaser() then
					p54:BindJumpAction(true)
					p54:SetLaserPointerMode("Hidden")
				end
				if p56.Position.magnitude > 0.22 then
					local v57 = p56.Position.X
					local v58 = -p56.Position.Y
					p54.moveVector = Vector3.new(v57, 0, v58)
					if p54.moveVector.magnitude > 0 then
						local v59 = p54.moveVector.unit
						local v60 = p56.Position.magnitude
						p54.moveVector = v59 * math.min(1, v60)
					end
					p54.moveLatch = true
				end
			end
			return Enum.ContextActionResult.Sink
		end
		p54.moveVector = Vector3.new(0, 0, 0)
	end
end
function v_u_17.OnHeartbeat(p61, p62)
	-- upvalues: (ref) v_u_10, (copy) v_u_13, (copy) v_u_12, (copy) v_u_14
	local v63 = p61.moveVector
	local v64 = p61:GetLocalHumanoid()
	if v64 and v64.Torso then
		if p61.moving and p61.currentPoints then
			local v65 = v64.Torso.Position
			local v66 = (currentPoints[1] - v65) * Vector3.new(1, 0, 1)
			local v67 = v66.magnitude
			local v68 = v66 / v67
			if v67 < 1 then
				local v69 = currentPoints[1]
				local v70 = 0
				for v71, v72 in pairs(currentPoints) do
					if v71 ~= 1 then
						v70 = v70 + (v72 - v69).magnitude / v64.WalkSpeed
						v69 = v72
					end
				end
				table.remove(currentPoints, 1)
				currentPointIdx = currentPointIdx + 1
				if #currentPoints == 0 then
					p61:StopFollowingPath()
					if v_u_10 then
						v_u_10.clearRenderedPath()
					end
					return
				end
				if v_u_10 then
					v_u_10.setCurrentPoints(currentPoints)
					v_u_10.renderPath()
				end
				expectedTimeToNextPoint = (currentPoints[1] - v65).magnitude / v64.WalkSpeed
				timeReachedLastPoint = tick()
			else
				if v_u_13 then
					v_u_12.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, workspace.CurrentCamera }
					local v73 = workspace:Raycast(v65 - Vector3.new(0, 1, 0), v68 * 3, v_u_12)
					if v73 then
						local v74 = workspace:Raycast(v73.Position + v68 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0), v_u_12).Position.Y - v65.Y
						if v74 < 6 and v74 > -2 then
							v64.Jump = true
						end
					end
				else
					local v75 = { game.Players.LocalPlayer.Character, workspace.CurrentCamera }
					local v76 = Ray.new(v65 - Vector3.new(0, 1, 0), v68 * 3)
					local v77, v78, _ = workspace:FindPartOnRayWithIgnoreList(v76, v75)
					if v77 then
						local v79 = Ray.new(v78 + v68 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0))
						local _, v80, _ = workspace:FindPartOnRayWithIgnoreList(v79, v75)
						local v81 = v80.Y - v65.Y
						if v81 < 6 and v81 > -2 then
							v64.Jump = true
						end
					end
				end
				if tick() - timeReachedLastPoint > expectedTimeToNextPoint + 2 then
					p61:StopFollowingPath()
					if v_u_10 then
						v_u_10.clearRenderedPath()
					end
					v_u_14:Fire("offtrack")
				end
				v63 = p61.moveVector:Lerp(v68, p62 * 10)
			end
		end
		local v82 = v63.x
		local v83
		if v82 == v82 and v82 ~= (1 / 0) then
			v83 = v82 ~= (-1 / 0)
		else
			v83 = false
		end
		if v83 then
			local v84 = v63.y
			if v84 == v84 and v84 ~= (1 / 0) then
				v83 = v84 ~= (-1 / 0)
			else
				v83 = false
			end
			if v83 then
				local v85 = v63.z
				if v85 == v85 and v85 ~= (1 / 0) then
					v83 = v85 ~= (-1 / 0)
				else
					v83 = false
				end
			end
		end
		if v83 then
			p61.moveVector = v63
		end
	end
end
function v_u_17.OnUserCFrameEnabled(p86)
	if p86:ShouldUseNavigationLaser() then
		p86:BindJumpAction(false)
		p86:SetLaserPointerMode("Navigation")
	else
		p86:BindJumpAction(true)
		p86:SetLaserPointerMode("Hidden")
	end
end
function v_u_17.Enable(p_u_87, p88)
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_6
	p_u_87.moveVector = Vector3.new(0, 0, 0)
	p_u_87.isJumping = false
	if p88 then
		p_u_87.navigationRequestedConn = v_u_1.NavigationRequested:Connect(function(p89, p90)
			-- upvalues: (copy) p_u_87
			p_u_87:OnNavigationRequest(p89, p90)
		end)
		p_u_87.heartbeatConn = v_u_3.Heartbeat:Connect(function(p91)
			-- upvalues: (copy) p_u_87
			p_u_87:OnHeartbeat(p91)
		end)
		v_u_6:BindAction("MoveThumbstick", function(p92, p93, p94)
			-- upvalues: (copy) p_u_87
			return p_u_87:ControlCharacterGamepad(p92, p93, p94)
		end, false, p_u_87.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1)
		v_u_6:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
		p_u_87.userCFrameEnabledConn = v_u_1.UserCFrameEnabled:Connect(function()
			-- upvalues: (copy) p_u_87
			p_u_87:OnUserCFrameEnabled()
		end)
		p_u_87:OnUserCFrameEnabled()
		v_u_1:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick)
		v_u_1:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY)
		p_u_87.enabled = true
	else
		p_u_87:StopFollowingPath()
		v_u_6:UnbindAction("MoveThumbstick")
		v_u_6:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
		p_u_87:BindJumpAction(false)
		p_u_87:SetLaserPointerMode("Disabled")
		if p_u_87.navigationRequestedConn then
			p_u_87.navigationRequestedConn:Disconnect()
			p_u_87.navigationRequestedConn = nil
		end
		if p_u_87.heartbeatConn then
			p_u_87.heartbeatConn:Disconnect()
			p_u_87.heartbeatConn = nil
		end
		if p_u_87.userCFrameEnabledConn then
			p_u_87.userCFrameEnabledConn:Disconnect()
			p_u_87.userCFrameEnabledConn = nil
		end
		p_u_87.enabled = false
	end
end
return v_u_17