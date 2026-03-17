local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2")
end)
local v_u_3 = v1 and v2
local v_u_4 = game:GetService("VRService")
local v_u_5 = game:GetService("Players").LocalPlayer
local v_u_6 = game:GetService("Lighting")
local v_u_7 = game:GetService("RunService")
local v_u_8 = UserSettings():GetService("UserGameSettings")
local v_u_9 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_10 = require(script.Parent:WaitForChild("ZoomController"))
local v11 = script.Parent.Parent:WaitForChild("CommonUtils")
require(v11:WaitForChild("FlagUtil"))
local v_u_12 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_13 = setmetatable({}, v_u_12)
v_u_13.__index = v_u_13
function v_u_13.new()
	-- upvalues: (copy) v_u_12, (copy) v_u_13
	local v14 = v_u_12.new()
	local v15 = v_u_13
	local v16 = setmetatable(v14, v15)
	v16.gamepadZoomLevels = { 0, 7 }
	v16.headScale = 1
	v16:SetCameraToSubjectDistance(7)
	v16.VRFadeResetTimer = 0
	v16.VREdgeBlurTimer = 0
	v16.gamepadResetConnection = nil
	v16.needsReset = true
	v16.recentered = false
	v16:Reset()
	return v16
end
function v_u_13.Reset(p17)
	p17.stepRotateTimeout = 0
end
function v_u_13.GetModuleName(_)
	return "VRBaseCamera"
end
function v_u_13.GamepadZoomPress(p18)
	-- upvalues: (copy) v_u_12
	v_u_12.GamepadZoomPress(p18)
	p18:GamepadReset()
	p18:ResetZoom()
end
function v_u_13.GamepadReset(p19)
	p19.stepRotateTimeout = 0
	p19.needsReset = true
end
function v_u_13.ResetZoom(p20)
	-- upvalues: (copy) v_u_10
	v_u_10.SetZoomParameters(p20.currentSubjectDistance, 0)
	v_u_10.ReleaseSpring()
end
function v_u_13.OnEnabledChanged(p_u_21)
	-- upvalues: (copy) v_u_12, (copy) v_u_9, (copy) v_u_4, (ref) v_u_3, (copy) v_u_5, (copy) v_u_6
	v_u_12.OnEnabledChanged(p_u_21)
	if p_u_21.enabled then
		p_u_21.gamepadResetConnection = v_u_9.gamepadReset:Connect(function()
			-- upvalues: (copy) p_u_21
			p_u_21:GamepadReset()
		end)
		p_u_21.thirdPersonOptionChanged = v_u_4:GetPropertyChangedSignal("ThirdPersonFollowCamEnabled"):Connect(function()
			-- upvalues: (ref) v_u_3, (copy) p_u_21
			if v_u_3 then
				p_u_21:Reset()
			elseif not p_u_21:IsInFirstPerson() then
				p_u_21:Reset()
			end
		end)
		p_u_21.vrRecentered = v_u_4.UserCFrameChanged:Connect(function(p22, _)
			-- upvalues: (copy) p_u_21
			if p22 == Enum.UserCFrame.Floor then
				p_u_21.recentered = true
			end
		end)
	else
		if p_u_21.inFirstPerson then
			p_u_21:GamepadZoomPress()
		end
		if p_u_21.thirdPersonOptionChanged then
			p_u_21.thirdPersonOptionChanged:Disconnect()
			p_u_21.thirdPersonOptionChanged = nil
		end
		if p_u_21.vrRecentered then
			p_u_21.vrRecentered:Disconnect()
			p_u_21.vrRecentered = nil
		end
		if p_u_21.cameraHeadScaleChangedConn then
			p_u_21.cameraHeadScaleChangedConn:Disconnect()
			p_u_21.cameraHeadScaleChangedConn = nil
		end
		if p_u_21.gamepadResetConnection then
			p_u_21.gamepadResetConnection:Disconnect()
			p_u_21.gamepadResetConnection = nil
		end
		p_u_21.VREdgeBlurTimer = 0
		p_u_21:UpdateEdgeBlur(v_u_5, 1)
		local v23 = v_u_6:FindFirstChild("VRFade")
		if v23 then
			v23.Brightness = 0
		end
	end
end
function v_u_13.OnCurrentCameraChanged(p_u_24)
	-- upvalues: (copy) v_u_12
	v_u_12.OnCurrentCameraChanged(p_u_24)
	if p_u_24.cameraHeadScaleChangedConn then
		p_u_24.cameraHeadScaleChangedConn:Disconnect()
		p_u_24.cameraHeadScaleChangedConn = nil
	end
	local v25 = workspace.CurrentCamera
	if v25 then
		p_u_24.cameraHeadScaleChangedConn = v25:GetPropertyChangedSignal("HeadScale"):Connect(function()
			-- upvalues: (copy) p_u_24
			p_u_24:OnHeadScaleChanged()
		end)
		p_u_24:OnHeadScaleChanged()
	end
end
function v_u_13.OnHeadScaleChanged(p26)
	local v27 = workspace.CurrentCamera.HeadScale
	for v28, v29 in p26.gamepadZoomLevels do
		p26.gamepadZoomLevels[v28] = v29 * v27 / p26.headScale
	end
	p26:SetCameraToSubjectDistance(p26:GetCameraToSubjectDistance() * v27 / p26.headScale)
	p26.headScale = v27
end
function v_u_13.GetVRFocus(p30, p31, p32)
	local v33 = p30.lastCameraFocus or p31
	local v34 = p30.cameraTranslationConstraints.x
	local v35 = p30.cameraTranslationConstraints.y + p32
	local v36 = math.min(1, v35)
	local v37 = p30.cameraTranslationConstraints.z
	p30.cameraTranslationConstraints = Vector3.new(v34, v36, v37)
	local v38 = p30:GetCameraHeight()
	local v39 = Vector3.new(0, v38, 0)
	local v40 = CFrame.new
	local v41 = p31.x
	local v42 = v33.y
	local v43 = p31.z
	return v40(Vector3.new(v41, v42, v43):Lerp(p31 + v39, p30.cameraTranslationConstraints.y))
end
function v_u_13.StartFadeFromBlack(p44)
	-- upvalues: (copy) v_u_8, (copy) v_u_6
	if v_u_8.VignetteEnabled ~= false then
		local v45 = v_u_6:FindFirstChild("VRFade")
		if not v45 then
			v45 = Instance.new("ColorCorrectionEffect")
			v45.Name = "VRFade"
			v45.Parent = v_u_6
		end
		v45.Brightness = -1
		p44.VRFadeResetTimer = 0.1
	end
end
function v_u_13.UpdateFadeFromBlack(p46, p47)
	-- upvalues: (copy) v_u_6
	local v48 = v_u_6:FindFirstChild("VRFade")
	if p46.VRFadeResetTimer > 0 then
		local v49 = p46.VRFadeResetTimer - p47
		p46.VRFadeResetTimer = math.max(v49, 0)
		local v50 = v_u_6:FindFirstChild("VRFade")
		if v50 and v50.Brightness < 0 then
			local v51 = v50.Brightness + p47 * 10
			v50.Brightness = math.min(v51, 0)
			return
		end
	elseif v48 then
		v48.Brightness = 0
	end
end
function v_u_13.StartVREdgeBlur(p52, p53)
	-- upvalues: (copy) v_u_8, (copy) v_u_7, (copy) v_u_4
	if v_u_8.VignetteEnabled ~= false then
		local v54 = workspace.CurrentCamera:FindFirstChild("VRBlurPart")
		if not v54 then
			local v_u_55 = Instance.new("Part")
			v_u_55.Name = "VRBlurPart"
			v_u_55.Parent = workspace.CurrentCamera
			v_u_55.CanTouch = false
			v_u_55.CanCollide = false
			v_u_55.CanQuery = false
			v_u_55.Anchored = true
			v_u_55.Size = Vector3.new(0.44, 0.47, 1)
			v_u_55.Transparency = 1
			v_u_55.CastShadow = false
			v_u_7.RenderStepped:Connect(function(_)
				-- upvalues: (ref) v_u_4, (ref) v_u_55
				local v56 = v_u_4:GetUserCFrame(Enum.UserCFrame.Head)
				local v57 = workspace.CurrentCamera.CFrame * (CFrame.new(v56.p * workspace.CurrentCamera.HeadScale) * (v56 - v56.p))
				v_u_55.CFrame = v57 * CFrame.Angles(0, 3.141592653589793, 0) + v57.LookVector * (1.05 * workspace.CurrentCamera.HeadScale)
				v_u_55.Size = Vector3.new(0.44, 0.47, 1) * workspace.CurrentCamera.HeadScale
			end)
			v54 = v_u_55
		end
		local v58 = p53.PlayerGui:FindFirstChild("VRBlurScreen")
		local v59
		if v58 then
			v59 = v58:FindFirstChild("VRBlur")
		else
			v59 = nil
		end
		if not v59 then
			local v60 = v58 or (Instance.new("SurfaceGui") or Instance.new("ScreenGui"))
			v60.Name = "VRBlurScreen"
			v60.Parent = p53.PlayerGui
			v60.Adornee = v54
			v59 = Instance.new("ImageLabel")
			v59.Name = "VRBlur"
			v59.Parent = v60
			v59.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
			v59.AnchorPoint = Vector2.new(0.5, 0.5)
			v59.Position = UDim2.new(0.5, 0, 0.5, 0)
			local v61 = workspace.CurrentCamera.ViewportSize.X * 2.3 / 512
			local v62 = workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512
			v59.Size = UDim2.fromScale(v61, v62)
			v59.BackgroundTransparency = 1
			v59.Active = true
			v59.ScaleType = Enum.ScaleType.Stretch
		end
		v59.Visible = true
		v59.ImageTransparency = 0
		p52.VREdgeBlurTimer = 0.14
	end
end
function v_u_13.UpdateEdgeBlur(p63, p64, p65)
	local v66 = p64.PlayerGui:FindFirstChild("VRBlurScreen")
	local v67
	if v66 then
		v67 = v66:FindFirstChild("VRBlur")
	else
		v67 = nil
	end
	if v67 then
		if p63.VREdgeBlurTimer > 0 then
			p63.VREdgeBlurTimer = p63.VREdgeBlurTimer - p65
			local v68 = p64.PlayerGui:FindFirstChild("VRBlurScreen")
			local v69 = v68 and v68:FindFirstChild("VRBlur")
			if v69 then
				local v70 = p63.VREdgeBlurTimer
				v69.ImageTransparency = 1 - math.clamp(v70, 0.01, 0.14) * 7.142857142857142
				return
			end
		else
			v67.Visible = false
		end
	end
end
function v_u_13.GetCameraHeight(p71)
	return p71.inFirstPerson and 0 or 0.25881904510252074 * p71.currentSubjectDistance
end
function v_u_13.GetSubjectCFrame(p72)
	-- upvalues: (copy) v_u_12
	local v73 = v_u_12.GetSubjectCFrame(p72)
	local v74 = workspace.CurrentCamera
	if v74 then
		v74 = v74.CameraSubject
	end
	if not v74 then
		return v73
	end
	if v74:IsA("Humanoid") and (v74:GetState() == Enum.HumanoidStateType.Dead and v74 == p72.lastSubject) then
		v73 = p72.lastSubjectCFrame
	end
	if v73 then
		p72.lastSubjectCFrame = v73
	end
	return v73
end
function v_u_13.GetSubjectPosition(p75)
	-- upvalues: (copy) v_u_12
	local v76 = v_u_12.GetSubjectPosition(p75)
	local v77 = game.Workspace.CurrentCamera
	if v77 then
		v77 = v77.CameraSubject
	end
	if not v77 then
		return nil
	end
	if v77:IsA("Humanoid") then
		if v77:GetState() == Enum.HumanoidStateType.Dead and v77 == p75.lastSubject then
			v76 = p75.lastSubjectPosition
		end
	elseif v77:IsA("VehicleSeat") then
		v76 = v77.CFrame.p + v77.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0))
	end
	p75.lastSubjectPosition = v76
	return v76
end
function v_u_13.getRotation(p78, p79)
	-- upvalues: (copy) v_u_9, (copy) v_u_8
	local v80 = v_u_9.getRotation(p79)
	local v81 = 0
	if v_u_8.VRSmoothRotationEnabled then
		return v80.X
	end
	local v82 = v80.X
	if math.abs(v82) > 0.03 then
		if p78.stepRotateTimeout > 0 then
			p78.stepRotateTimeout = p78.stepRotateTimeout - p79
		end
		if p78.stepRotateTimeout <= 0 then
			local v83 = (v80.X < 0 and -1 or 1) * 0.5235987755982988
			p78:StartFadeFromBlack()
			p78.stepRotateTimeout = 0.25
			return v83
		end
	else
		local v84 = v80.X
		if math.abs(v84) < 0.02 then
			p78.stepRotateTimeout = 0
		end
	end
	return v81
end
return v_u_13