local v1 = game:GetService("Players")
game:GetService("UserInputService")
local v_u_2 = game:GetService("VRService")
local v_u_3 = UserSettings():GetService("UserGameSettings")
local v4 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_5 = require(v4:WaitForChild("ConnectionUtil"))
require(v4:WaitForChild("FlagUtil"))
local v_u_6 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_7 = require(script.Parent:WaitForChild("ZoomController"))
local v_u_8 = require(script.Parent:WaitForChild("CameraToggleStateController"))
local v_u_9 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_10 = require(script.Parent:WaitForChild("CameraUI"))
local v_u_11 = v1.LocalPlayer
local v12, v13 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserFixGamepadMaxZoom")
end)
local v_u_14 = v12 and v13
Vector2.new(0, 0)
local v_u_15 = {
	["CHARACTER_ADDED"] = "CHARACTER_ADDED",
	["CAMERA_MODE_CHANGED"] = "CAMERA_MODE_CHANGED",
	["CAMERA_MIN_DISTANCE_CHANGED"] = "CAMERA_MIN_DISTANCE_CHANGED",
	["CAMERA_MAX_DISTANCE_CHANGED"] = "CAMERA_MAX_DISTANCE_CHANGED"
}
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16.new()
	-- upvalues: (copy) v_u_16, (copy) v_u_5, (copy) v_u_11, (copy) v_u_3
	local v17 = v_u_16
	local v18 = setmetatable({}, v17)
	v18._connections = v_u_5.new()
	v18.gamepadZoomLevels = { 0, 10, 20 }
	v18.FIRST_PERSON_DISTANCE_THRESHOLD = 1
	v18.cameraType = nil
	v18.cameraMovementMode = nil
	v18.lastCameraTransform = nil
	v18.lastUserPanCamera = tick()
	v18.humanoidRootPart = nil
	v18.humanoidCache = {}
	v18.lastSubject = nil
	v18.lastSubjectPosition = Vector3.new(0, 5, 0)
	v18.lastSubjectCFrame = CFrame.new(v18.lastSubjectPosition)
	local v19 = v_u_11.CameraMinZoomDistance
	local v20 = v_u_11.CameraMaxZoomDistance
	v18.currentSubjectDistance = math.clamp(12.5, v19, v20)
	v18.inFirstPerson = false
	v18.inMouseLockedMode = false
	v18.resetCameraAngle = true
	v18.enabled = false
	v18.cameraChangedConn = nil
	v18.shouldUseVRRotation = false
	v18.VRRotationIntensityAvailable = false
	v18.lastVRRotationIntensityCheckTime = 0
	v18.lastVRRotationTime = 0
	v18.vrRotateKeyCooldown = {}
	v18.cameraTranslationConstraints = Vector3.new(1, 1, 1)
	v18.humanoidJumpOrigin = nil
	v18.trackingHumanoid = nil
	v18.cameraFrozen = false
	v18.subjectStateChangedConn = nil
	v18.gamepadZoomPressConnection = nil
	v18.mouseLockOffset = Vector3.new(0, 0, 0)
	v_u_3:SetCameraYInvertVisible()
	v_u_3:SetGamepadCameraSensitivityVisible()
	return v18
end
function v_u_16.GetModuleName(_)
	return "BaseCamera"
end
function v_u_16._setUpConfigurations(p_u_21)
	-- upvalues: (copy) v_u_15, (copy) v_u_11
	p_u_21._connections:trackConnection(v_u_15.CHARACTER_ADDED, v_u_11.CharacterAdded:Connect(function(p22)
		-- upvalues: (copy) p_u_21
		p_u_21:OnCharacterAdded(p22)
	end))
	p_u_21.humanoidRootPart = nil
	p_u_21._connections:trackConnection(v_u_15.CAMERA_MODE_CHANGED, v_u_11:GetPropertyChangedSignal("CameraMode"):Connect(function()
		-- upvalues: (copy) p_u_21
		p_u_21:OnPlayerCameraPropertyChange()
	end))
	p_u_21._connections:trackConnection(v_u_15.CAMERA_MIN_DISTANCE_CHANGED, v_u_11:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function()
		-- upvalues: (copy) p_u_21
		p_u_21:OnPlayerCameraPropertyChange()
	end))
	p_u_21._connections:trackConnection(v_u_15.CAMERA_MAX_DISTANCE_CHANGED, v_u_11:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
		-- upvalues: (copy) p_u_21
		p_u_21:OnPlayerCameraPropertyChange()
	end))
	p_u_21:OnPlayerCameraPropertyChange()
end
function v_u_16.OnCharacterAdded(p23, _)
	p23.resetCameraAngle = p23.resetCameraAngle or p23:GetEnabled()
	p23.humanoidRootPart = nil
end
function v_u_16.GetHumanoidRootPart(p24)
	-- upvalues: (copy) v_u_11
	local v25 = (not p24.humanoidRootPart and v_u_11.Character and true or false) and v_u_11.Character:FindFirstChildOfClass("Humanoid")
	if v25 then
		p24.humanoidRootPart = v25.RootPart
	end
	return p24.humanoidRootPart
end
function v_u_16.GetBodyPartToFollow(_, p26, _)
	if p26:GetState() == Enum.HumanoidStateType.Dead then
		local v27 = p26.Parent
		if v27 and v27:IsA("Model") then
			return v27:FindFirstChild("Head") or p26.RootPart
		end
	end
	return p26.RootPart
end
function v_u_16.GetSubjectCFrame(p28)
	local v29 = p28.lastSubjectCFrame
	local v30 = workspace.CurrentCamera
	if v30 then
		v30 = v30.CameraSubject
	end
	if not v30 then
		return v29
	end
	if v30:IsA("Humanoid") then
		local v31 = v30:GetState() == Enum.HumanoidStateType.Dead
		local v32 = v30.CameraOffset
		if p28:GetIsMouseLocked() then
			v32 = Vector3.new()
		end
		local v33 = v30.RootPart
		if v31 and (v30.Parent and v30.Parent:IsA("Model")) then
			v33 = v30.Parent:FindFirstChild("Head") or v33
		end
		if v33 and v33:IsA("BasePart") then
			local v34
			if v30.RigType == Enum.HumanoidRigType.R15 then
				if v30.AutomaticScalingEnabled then
					v34 = Vector3.new(0, 1.5, 0)
					local v35 = v30.RootPart
					if v33 == v35 then
						local v36 = (v35.Size.Y - 2) / 2
						v34 = v34 + Vector3.new(0, v36, 0)
					end
				else
					v34 = Vector3.new(0, 2, 0)
				end
			else
				v34 = Vector3.new(0, 1.5, 0)
			end
			v29 = v33.CFrame * CFrame.new((v31 and Vector3.new(0, 0, 0) or v34) + v32)
		end
	elseif v30:IsA("BasePart") then
		v29 = v30.CFrame
	elseif v30:IsA("Model") then
		if v30.PrimaryPart then
			v29 = v30:GetPrimaryPartCFrame()
		else
			v29 = CFrame.new()
		end
	end
	if v29 then
		p28.lastSubjectCFrame = v29
	end
	return v29
end
function v_u_16.GetSubjectVelocity(_)
	local v37 = workspace.CurrentCamera
	if v37 then
		v37 = v37.CameraSubject
	end
	if not v37 then
		return Vector3.new(0, 0, 0)
	end
	if v37:IsA("BasePart") then
		return v37.Velocity
	end
	if v37:IsA("Humanoid") then
		local v38 = v37.RootPart
		if v38 then
			return v38.Velocity
		end
	else
		local v39 = v37:IsA("Model") and v37.PrimaryPart
		if v39 then
			return v39.Velocity
		end
	end
	return Vector3.new(0, 0, 0)
end
function v_u_16.GetSubjectRotVelocity(_)
	local v40 = workspace.CurrentCamera
	if v40 then
		v40 = v40.CameraSubject
	end
	if not v40 then
		return Vector3.new(0, 0, 0)
	end
	if v40:IsA("BasePart") then
		return v40.RotVelocity
	end
	if v40:IsA("Humanoid") then
		local v41 = v40.RootPart
		if v41 then
			return v41.RotVelocity
		end
	else
		local v42 = v40:IsA("Model") and v40.PrimaryPart
		if v42 then
			return v42.RotVelocity
		end
	end
	return Vector3.new(0, 0, 0)
end
function v_u_16.StepZoom(p43)
	-- upvalues: (copy) v_u_9, (copy) v_u_7
	local v44 = p43.currentSubjectDistance
	local v45 = v_u_9.getZoomDelta()
	if math.abs(v45) > 0 then
		local v46
		if v45 > 0 then
			local v47 = v44 + v45 * (v44 * 0.5 + 1)
			local v48 = p43.FIRST_PERSON_DISTANCE_THRESHOLD
			v46 = math.max(v47, v48)
		else
			local v49 = (v44 + v45) / (1 - v45 * 0.5)
			v46 = math.max(v49, 0.5)
		end
		p43:SetCameraToSubjectDistance(v46 < p43.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v46)
	end
	return v_u_7.GetZoomRadius()
end
function v_u_16.GetSubjectPosition(p50)
	local v51 = p50.lastSubjectPosition
	local v52 = game.Workspace.CurrentCamera
	if v52 then
		v52 = v52.CameraSubject
	end
	if not v52 then
		return nil
	end
	if v52:IsA("Humanoid") then
		local v53 = v52:GetState() == Enum.HumanoidStateType.Dead
		local v54 = v52.CameraOffset
		if p50:GetIsMouseLocked() then
			v54 = Vector3.new()
		end
		local v55 = v52.RootPart
		if v53 and (v52.Parent and v52.Parent:IsA("Model")) then
			v55 = v52.Parent:FindFirstChild("Head") or v55
		end
		if v55 and v55:IsA("BasePart") then
			local v56
			if v52.RigType == Enum.HumanoidRigType.R15 then
				if v52.AutomaticScalingEnabled then
					v56 = Vector3.new(0, 1.5, 0)
					if v55 == v52.RootPart then
						local v57 = v52.RootPart.Size.Y / 2 - 1
						v56 = v56 + Vector3.new(0, v57, 0)
					end
				else
					v56 = Vector3.new(0, 2, 0)
				end
			else
				v56 = Vector3.new(0, 1.5, 0)
			end
			v51 = v55.CFrame.p + v55.CFrame:vectorToWorldSpace((v53 and Vector3.new(0, 0, 0) or v56) + v54)
		end
	elseif v52:IsA("VehicleSeat") then
		v51 = v52.CFrame.p + v52.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0))
	elseif v52:IsA("SkateboardPlatform") then
		v51 = v52.CFrame.p + Vector3.new(0, 5, 0)
	elseif v52:IsA("BasePart") then
		v51 = v52.CFrame.p
	elseif v52:IsA("Model") then
		if v52.PrimaryPart then
			v51 = v52:GetPrimaryPartCFrame().p
		else
			v51 = v52:GetModelCFrame().p
		end
	end
	p50.lastSubject = v52
	p50.lastSubjectPosition = v51
	return v51
end
function v_u_16.OnCurrentCameraChanged(p_u_58)
	if p_u_58.cameraSubjectChangedConn then
		p_u_58.cameraSubjectChangedConn:Disconnect()
		p_u_58.cameraSubjectChangedConn = nil
	end
	local v59 = game.Workspace.CurrentCamera
	if v59 then
		p_u_58.cameraSubjectChangedConn = v59:GetPropertyChangedSignal("CameraSubject"):Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:OnNewCameraSubject()
		end)
		p_u_58:OnNewCameraSubject()
	end
end
function v_u_16.OnPlayerCameraPropertyChange(p60)
	p60:SetCameraToSubjectDistance(p60.currentSubjectDistance)
end
function v_u_16.InputTranslationToCameraAngleChange(_, p61, p62)
	return p61 * p62
end
function v_u_16.GamepadZoomPress(p63)
	-- upvalues: (copy) v_u_11, (ref) v_u_14
	local v64 = p63:GetCameraToSubjectDistance()
	local v65 = v_u_11.CameraMaxZoomDistance
	for v66 = #p63.gamepadZoomLevels, 1, -1 do
		local v67 = p63.gamepadZoomLevels[v66]
		if v65 >= v67 then
			if v67 < v_u_11.CameraMinZoomDistance then
				v67 = v_u_11.CameraMinZoomDistance
				if v_u_14 and v65 == v67 then
					break
				end
			end
			if not v_u_14 and v65 == v67 then
				break
			end
			if v67 + (v65 - v67) / 2 < v64 then
				p63:SetCameraToSubjectDistance(v67)
				return
			end
			v65 = v67
		end
	end
	p63:SetCameraToSubjectDistance(p63.gamepadZoomLevels[#p63.gamepadZoomLevels])
end
function v_u_16.Enable(p68, p69)
	if p68.enabled ~= p69 then
		p68.enabled = p69
		p68:OnEnabledChanged()
	end
end
function v_u_16.OnEnabledChanged(p_u_70)
	-- upvalues: (copy) v_u_9, (copy) v_u_11
	if p_u_70.enabled then
		p_u_70:_setUpConfigurations()
		v_u_9.setInputEnabled(true)
		p_u_70.gamepadZoomPressConnection = v_u_9.gamepadZoomPress:Connect(function()
			-- upvalues: (copy) p_u_70
			p_u_70:GamepadZoomPress()
		end)
		if v_u_11.CameraMode == Enum.CameraMode.LockFirstPerson then
			p_u_70.currentSubjectDistance = 0.5
			if not p_u_70.inFirstPerson then
				p_u_70:EnterFirstPerson()
			end
		end
		if p_u_70.cameraChangedConn then
			p_u_70.cameraChangedConn:Disconnect()
			p_u_70.cameraChangedConn = nil
		end
		p_u_70.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			-- upvalues: (copy) p_u_70
			p_u_70:OnCurrentCameraChanged()
		end)
		p_u_70:OnCurrentCameraChanged()
	else
		p_u_70._connections:disconnectAll()
		v_u_9.setInputEnabled(false)
		if p_u_70.gamepadZoomPressConnection then
			p_u_70.gamepadZoomPressConnection:Disconnect()
			p_u_70.gamepadZoomPressConnection = nil
		end
		p_u_70:Cleanup()
	end
end
function v_u_16.GetEnabled(p71)
	return p71.enabled
end
function v_u_16.Cleanup(p72)
	-- upvalues: (copy) v_u_6
	if p72.subjectStateChangedConn then
		p72.subjectStateChangedConn:Disconnect()
		p72.subjectStateChangedConn = nil
	end
	if p72.cameraChangedConn then
		p72.cameraChangedConn:Disconnect()
		p72.cameraChangedConn = nil
	end
	p72.lastCameraTransform = nil
	p72.lastSubjectCFrame = nil
	v_u_6.restoreMouseBehavior()
end
function v_u_16.UpdateMouseBehavior(p73)
	-- upvalues: (copy) v_u_3, (copy) v_u_10, (copy) v_u_9, (copy) v_u_8, (copy) v_u_6
	local v74 = v_u_3.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
	if p73.isCameraToggle and v74 == false then
		v_u_10.setCameraModeToastEnabled(true)
		v_u_9.enableCameraToggleInput()
		v_u_8(p73.inFirstPerson)
		return
	else
		v_u_10.setCameraModeToastEnabled(false)
		v_u_9.disableCameraToggleInput()
		if p73.inFirstPerson or p73.inMouseLockedMode then
			v_u_6.setRotationTypeOverride(Enum.RotationType.CameraRelative)
			v_u_6.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
			return
		else
			v_u_6.restoreRotationType()
			if v_u_9.getRotationActivated() then
				v_u_6.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
			else
				v_u_6.restoreMouseBehavior()
			end
		end
	end
end
function v_u_16.UpdateForDistancePropertyChange(p75)
	p75:SetCameraToSubjectDistance(p75.currentSubjectDistance)
end
function v_u_16.SetCameraToSubjectDistance(p76, p77)
	-- upvalues: (copy) v_u_11, (copy) v_u_7
	local v78 = p76.currentSubjectDistance
	if v_u_11.CameraMode == Enum.CameraMode.LockFirstPerson then
		p76.currentSubjectDistance = 0.5
		if not p76.inFirstPerson then
			p76:EnterFirstPerson()
		end
	else
		local v79 = v_u_11.CameraMinZoomDistance
		local v80 = v_u_11.CameraMaxZoomDistance
		local v81 = math.clamp(p77, v79, v80)
		if v81 < 1 then
			p76.currentSubjectDistance = 0.5
			if not p76.inFirstPerson then
				p76:EnterFirstPerson()
			end
		else
			p76.currentSubjectDistance = v81
			if p76.inFirstPerson then
				p76:LeaveFirstPerson()
			end
		end
	end
	local v82 = v_u_7.SetZoomParameters
	local v83 = p76.currentSubjectDistance
	local v84 = p77 - v78
	v82(v83, (math.sign(v84)))
	return p76.currentSubjectDistance
end
function v_u_16.SetCameraType(p85, p86)
	p85.cameraType = p86
end
function v_u_16.GetCameraType(p87)
	return p87.cameraType
end
function v_u_16.SetCameraMovementMode(p88, p89)
	p88.cameraMovementMode = p89
end
function v_u_16.GetCameraMovementMode(p90)
	return p90.cameraMovementMode
end
function v_u_16.SetIsMouseLocked(p91, p92)
	p91.inMouseLockedMode = p92
end
function v_u_16.GetIsMouseLocked(p93)
	return p93.inMouseLockedMode
end
function v_u_16.SetMouseLockOffset(p94, p95)
	p94.mouseLockOffset = p95
end
function v_u_16.GetMouseLockOffset(p96)
	return p96.mouseLockOffset
end
function v_u_16.InFirstPerson(p97)
	return p97.inFirstPerson
end
function v_u_16.EnterFirstPerson(p98)
	p98.inFirstPerson = true
	p98:UpdateMouseBehavior()
end
function v_u_16.LeaveFirstPerson(p99)
	p99.inFirstPerson = false
	p99:UpdateMouseBehavior()
end
function v_u_16.GetCameraToSubjectDistance(p100)
	return p100.currentSubjectDistance
end
function v_u_16.GetMeasuredDistanceToFocus(_)
	local v101 = game.Workspace.CurrentCamera
	if v101 then
		return (v101.CoordinateFrame.p - v101.Focus.p).magnitude
	else
		return nil
	end
end
function v_u_16.GetCameraLookVector(_)
	return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1)
end
function v_u_16.CalculateNewLookCFrameFromArg(p102, p103, p104)
	local v105 = p103 or p102:GetCameraLookVector()
	local v106 = v105.Y
	local v107 = math.asin(v106)
	local v108 = p104.Y
	local v109 = v107 + -1.3962634015954636
	local v110 = v107 + 1.3962634015954636
	local v111 = math.clamp(v108, v109, v110)
	local v112 = Vector2.new(p104.X, v111)
	local v113 = CFrame.new(Vector3.new(0, 0, 0), v105)
	return CFrame.Angles(0, -v112.X, 0) * v113 * CFrame.Angles(-v112.Y, 0, 0)
end
function v_u_16.CalculateNewLookVectorFromArg(p114, p115, p116)
	return p114:CalculateNewLookCFrameFromArg(p115, p116).LookVector
end
function v_u_16.CalculateNewLookVectorVRFromArg(p117, p118)
	local v119 = ((p117:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit
	local v120 = Vector2.new(p118.X, 0)
	local v121 = CFrame.new(Vector3.new(0, 0, 0), v119)
	return ((CFrame.Angles(0, -v120.X, 0) * v121 * CFrame.Angles(-v120.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit
end
function v_u_16.GetHumanoid(p122)
	-- upvalues: (copy) v_u_11
	local v123 = v_u_11
	if v123 then
		v123 = v_u_11.Character
	end
	if not v123 then
		return nil
	end
	local v124 = p122.humanoidCache[v_u_11]
	if v124 and v124.Parent == v123 then
		return v124
	end
	p122.humanoidCache[v_u_11] = nil
	local v125 = v123:FindFirstChildOfClass("Humanoid")
	if v125 then
		p122.humanoidCache[v_u_11] = v125
	end
	return v125
end
function v_u_16.GetHumanoidPartToFollow(_, p126, p127)
	if p127 == Enum.HumanoidStateType.Dead then
		local v128 = p126.Parent
		if v128 then
			return v128:FindFirstChild("Head") or p126.Torso
		else
			return p126.Torso
		end
	else
		return p126.Torso
	end
end
function v_u_16.OnNewCameraSubject(p129)
	if p129.subjectStateChangedConn then
		p129.subjectStateChangedConn:Disconnect()
		p129.subjectStateChangedConn = nil
	end
end
function v_u_16.IsInFirstPerson(p130)
	return p130.inFirstPerson
end
function v_u_16.Update(_, _)
	error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
end
function v_u_16.GetCameraHeight(p131)
	-- upvalues: (copy) v_u_2
	return (not v_u_2.VREnabled or p131.inFirstPerson) and 0 or 0.25881904510252074 * p131.currentSubjectDistance
end
return v_u_16