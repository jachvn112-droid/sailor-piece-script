local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("VRService")
UserSettings():GetService("UserGameSettings")
require(script.Parent:WaitForChild("CameraInput"))
require(script.Parent:WaitForChild("CameraUtils"))
local v_u_3 = require(script.Parent:WaitForChild("VRBaseCamera"))
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4.new()
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_1
	local v5 = v_u_3.new()
	local v6 = v_u_4
	local v7 = setmetatable(v5, v6)
	v7.lastUpdate = tick()
	v7.focusOffset = CFrame.new()
	v7:Reset()
	v7.controlModule = require(v_u_1.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"))
	v7.savedAutoRotate = true
	return v7
end
function v_u_4.Reset(p8)
	-- upvalues: (copy) v_u_3
	p8.needsReset = true
	p8.needsBlackout = true
	p8.motionDetTime = 0
	p8.blackOutTimer = 0
	p8.lastCameraResetPosition = nil
	v_u_3.Reset(p8)
end
function v_u_4.Update(p9, p10)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v11 = workspace.CurrentCamera
	local v12 = v11.CFrame
	local v13 = v11.Focus
	local v14 = v_u_1.LocalPlayer
	p9:GetHumanoid()
	local _ = v11.CameraSubject
	if p9.lastUpdate == nil or p10 > 1 then
		p9.lastCameraTransform = nil
	end
	p9:UpdateFadeFromBlack(p10)
	p9:UpdateEdgeBlur(v14, p10)
	local v15 = p9.lastSubjectPosition
	local v16 = p9:GetSubjectPosition()
	if p9.needsBlackout then
		p9:StartFadeFromBlack()
		local v17 = math.clamp(p10, 0.0001, 0.1)
		p9.blackOutTimer = p9.blackOutTimer + v17
		if p9.blackOutTimer > 0.1 and game:IsLoaded() then
			p9.needsBlackout = false
			p9.needsReset = true
		end
	end
	if v16 and (v14 and v11) then
		local v18 = p9:GetVRFocus(v16, p10)
		if p9:IsInFirstPerson() then
			if v_u_2.AvatarGestures then
				v12, v13 = p9:UpdateImmersionCamera(p10, v12, v18, v15, v16)
			else
				v12, v13 = p9:UpdateFirstPersonTransform(p10, v12, v18, v15, v16)
			end
		elseif v_u_2.ThirdPersonFollowCamEnabled then
			v12, v13 = p9:UpdateThirdPersonFollowTransform(p10, v12, v18, v15, v16)
		else
			v12, v13 = p9:UpdateThirdPersonComfortTransform(p10, v12, v18, v15, v16)
		end
		p9.lastCameraTransform = v12
		p9.lastCameraFocus = v13
	end
	p9.lastUpdate = tick()
	return v12, v13
end
function v_u_4.GetAvatarFeetWorldYValue(_)
	local v19 = workspace.CurrentCamera.CameraSubject
	if not v19 then
		return nil
	end
	if not (v19:IsA("Humanoid") and v19.RootPart) then
		return nil
	end
	local v20 = v19.RootPart
	return v20.Position.Y - v20.Size.Y / 2 - v19.HipHeight
end
function v_u_4.UpdateFirstPersonTransform(p21, p22, _, p23, p24, p25)
	-- upvalues: (copy) v_u_1
	if p21.needsReset then
		p21:StartFadeFromBlack()
		p21.needsReset = false
	end
	local v26 = v_u_1.LocalPlayer
	if (p24 - p25).magnitude > 0.01 then
		p21:StartVREdgeBlur(v26)
	end
	local v27 = p23.p
	local v28 = p21:GetCameraLookVector()
	local v29 = v28.X
	local v30 = v28.Z
	local v31 = Vector3.new(v29, 0, v30).Unit
	local v32 = p21:getRotation(p22)
	local v33 = p21:CalculateNewLookVectorFromArg(v31, Vector2.new(v32, 0))
	return CFrame.new(v27 - 0.5 * v33, v27), p23
end
function v_u_4.UpdateImmersionCamera(p34, p35, _, _, _, p36)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v37 = p34:GetSubjectCFrame()
	local v38 = workspace.CurrentCamera
	local v39 = v_u_1.LocalPlayer.Character
	local v40 = p34:GetHumanoid()
	if not v40 then
		return v38.CFrame, v38.Focus
	end
	local v41 = v39:FindFirstChild("HumanoidRootPart")
	if not v41 then
		return v38.CFrame, v38.Focus
	end
	p34.characterOrientation = v41:FindFirstChild("CharacterAlignOrientation")
	if not p34.characterOrientation then
		local v42 = v41:FindFirstChild("RootAttachment")
		if not v42 then
			return
		end
		p34.characterOrientation = Instance.new("AlignOrientation")
		p34.characterOrientation.Name = "CharacterAlignOrientation"
		p34.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
		p34.characterOrientation.Attachment0 = v42
		p34.characterOrientation.RigidityEnabled = true
		p34.characterOrientation.Parent = v41
	end
	if p34.characterOrientation.Enabled == false then
		p34.characterOrientation.Enabled = true
	end
	if p34.needsReset then
		p34.needsReset = false
		p34.savedAutoRotate = v40.AutoRotate
		v40.AutoRotate = false
		if p34.NoRecenter then
			p34.NoRecenter = false
			v_u_2:RecenterUserHeadCFrame()
		end
		p34:StartFadeFromBlack()
	elseif v40.Sit then
		if (v37.Position - v38.CFrame.Position).Magnitude > 0.01 then
			p34:StartVREdgeBlur(v_u_1.LocalPlayer)
		end
	else
		local v43 = p34.controlModule:GetEstimatedVRTorsoFrame()
		p34.characterOrientation.CFrame = v38.CFrame * v43
		if p34.controlModule.inputMoveVector.Magnitude > 0 then
			p34.motionDetTime = 0.1
		end
		if p34.controlModule.inputMoveVector.Magnitude > 0 or p34.motionDetTime > 0 then
			p34.motionDetTime = p34.motionDetTime - p35
			p34:StartVREdgeBlur(v_u_1.LocalPlayer)
			local v44 = v_u_2:GetUserCFrame(Enum.UserCFrame.Head)
			local v45 = v44.Rotation + v44.Position * v38.HeadScale
			local v46 = v39.HumanoidRootPart
			local v47 = -0.7 * v46.Size.Y / 2
			local v48 = v38.CFrame * v45 * CFrame.new(0, v47, 0)
			local v49 = v46.CFrame.LookVector
			local v50 = v49.X
			local v51 = v49.Z
			local v52 = p36 - (v48 - Vector3.new(v50, 0, v51).Unit * v46.Size.Y * 0.125).Position + v38.CFrame.Position
			local v53 = v52.X
			local v54 = p36.Y
			local v55 = v52.Z
			local v56 = Vector3.new(v53, v54, v55)
			v37 = v38.CFrame.Rotation + v56
		else
			local v57 = v38.CFrame.Rotation
			local v58 = v38.CFrame.Position.X
			local v59 = p36.Y
			local v60 = v38.CFrame.Position.Z
			v37 = v57 + Vector3.new(v58, v59, v60)
		end
		local v61 = p34:getRotation(p35)
		if math.abs(v61) > 0 then
			local v62 = v_u_2:GetUserCFrame(Enum.UserCFrame.Head)
			local v63 = v62.Rotation + v62.Position * v38.HeadScale
			local v64 = v37 * v63
			local v65 = CFrame.new(v64.Position)
			local v66 = CFrame.Angles
			local v67 = v61 * 90
			v37 = v65 * v66(0, -math.rad(v67), 0) * v64.Rotation * v63:Inverse()
		end
	end
	return v37, v37 * CFrame.new(0, 0, -0.5)
end
function v_u_4.UpdateThirdPersonComfortTransform(p68, p69, p70, p71, p72, p73)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v74 = p68:GetCameraToSubjectDistance()
	local v75 = v74 < 0.5 and 0.5 or v74
	if p72 ~= nil and p68.lastCameraFocus ~= nil then
		local _ = v_u_1.LocalPlayer
		local v76 = p72 - p73
		local v77 = p68.controlModule:GetMoveVector()
		local v78 = v76.magnitude > 0.01 and true or v77.magnitude > 0.01
		if v78 then
			p68.motionDetTime = 0.1
		end
		p68.motionDetTime = p68.motionDetTime - p69
		if (p68.motionDetTime > 0 and true or v78) and not p68.needsReset then
			local v79 = p68.lastCameraFocus
			p68.VRCameraFocusFrozen = true
			return p70, v79
		end
		local v80 = p68.lastCameraResetPosition == nil and true or (p73 - p68.lastCameraResetPosition).Magnitude > 1
		local v81 = p68:getRotation(p69)
		if math.abs(v81) > 0 then
			local v82 = p71:ToObjectSpace(p70)
			p70 = p71 * CFrame.Angles(0, -v81, 0) * v82
		end
		if p68.VRCameraFocusFrozen and v80 or p68.needsReset then
			v_u_2:RecenterUserHeadCFrame()
			p68.VRCameraFocusFrozen = false
			p68.needsReset = false
			p68.lastCameraResetPosition = p73
			p68:ResetZoom()
			p68:StartFadeFromBlack()
			local v83 = p68:GetHumanoid()
			local v84 = v83.Torso and v83.Torso.CFrame.lookVector or Vector3.new(1, 0, 0)
			local v85 = v84.X
			local v86 = v84.Z
			local v87 = Vector3.new(v85, 0, v86)
			local v88 = p71.Position - v87 * v75
			local v89 = p71.Position.X
			local v90 = v88.Y
			local v91 = p71.Position.Z
			local v92 = Vector3.new(v89, v90, v91)
			p70 = CFrame.new(v88, v92)
		end
	end
	return p70, p71
end
function v_u_4.UpdateThirdPersonFollowTransform(p93, p94, _, _, p95, p96)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v97 = workspace.CurrentCamera
	local v98 = p93:GetCameraToSubjectDistance()
	local v99 = p93:GetVRFocus(p96, p94)
	if p93.needsReset then
		p93.needsReset = false
		v_u_2:RecenterUserHeadCFrame()
		p93:ResetZoom()
		p93:StartFadeFromBlack()
	end
	if p93.recentered then
		local v100 = p93:GetSubjectCFrame()
		if not v100 then
			return v97.CFrame, v97.Focus
		end
		local v101 = v99 * v100.Rotation * CFrame.new(0, 0, v98)
		p93.focusOffset = v99:ToObjectSpace(v101)
		p93.recentered = false
		return v101, v99
	end
	local v102 = v99:ToWorldSpace(p93.focusOffset)
	local _ = v_u_1.LocalPlayer
	local v103 = p95 - p96
	local v104 = p93.controlModule
	local v105 = v104:GetMoveVector()
	if v103.magnitude > 0.01 or v105.magnitude > 0 then
		local v106 = v104:GetEstimatedVRTorsoFrame()
		local v107 = v106.Rotation + v106.Position * v97.HeadScale
		local v108 = v97.CFrame * v107
		local v109 = v108.LookVector
		local v110 = v109.X
		local v111 = v109.Z
		local v112 = Vector3.new(v110, 0, v111).Unit * v98
		local v113 = v99.Position - v112
		v102 = v102:Lerp(CFrame.new(v97.CFrame.Position + v113 - v108.Position) * v102.Rotation, 0.01)
	end
	local v114 = p93:getRotation(p94)
	if math.abs(v114) > 0 then
		local v115 = v99:ToObjectSpace(v102)
		v102 = v99 * CFrame.Angles(0, -v114, 0) * v115
	end
	p93.focusOffset = v99:ToObjectSpace(v102)
	local v116 = v102 * CFrame.new(0, 0, -v98)
	if (v116.Position - v97.Focus.Position).Magnitude > 0.01 then
		p93:StartVREdgeBlur(v_u_1.LocalPlayer)
	end
	return v102, v116
end
function v_u_4.LeaveFirstPerson(p117)
	-- upvalues: (copy) v_u_3
	v_u_3.LeaveFirstPerson(p117)
	p117.needsReset = true
	if p117.VRBlur then
		p117.VRBlur.Visible = false
	end
	if p117.characterOrientation then
		p117.characterOrientation.Enabled = false
	end
	local v118 = p117:GetHumanoid()
	if v118 then
		v118.AutoRotate = p117.savedAutoRotate
	end
end
return v_u_4