local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2")
end)
local v_u_3 = v1 and v2
local v_u_4 = { 0, 30 }
local v_u_5 = UserSettings():GetService("UserGameSettings")
local v_u_6 = require(script.Parent:WaitForChild("VRBaseCamera"))
local v_u_7 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_8 = require(script.Parent:WaitForChild("CameraUtils"))
require(script.Parent:WaitForChild("VehicleCamera"))
local v_u_9 = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraCore"))
local v_u_10 = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraConfig"))
local v11 = game:GetService("Players")
local v_u_12 = game:GetService("RunService")
local v_u_13 = game:GetService("VRService")
local v_u_14 = v11.LocalPlayer
local v_u_15 = v_u_8.Spring
local v_u_16 = v_u_8.mapClamp
local v_u_17 = v_u_8.sanitizeAngle
local v_u_18 = 0.016666666666666666
local v_u_19 = setmetatable({}, v_u_6)
v_u_19.__index = v_u_19
function v_u_19.new()
	-- upvalues: (copy) v_u_6, (copy) v_u_19, (copy) v_u_12, (ref) v_u_18
	local v20 = v_u_6.new()
	local v21 = v_u_19
	local v22 = setmetatable(v20, v21)
	v22:Reset()
	v_u_12.Stepped:Connect(function(_, p23)
		-- upvalues: (ref) v_u_18
		v_u_18 = p23
	end)
	return v22
end
function v_u_19.Reset(p24)
	-- upvalues: (copy) v_u_9, (ref) v_u_3, (copy) v_u_15, (copy) v_u_10, (copy) v_u_8, (copy) v_u_4
	p24.vehicleCameraCore = v_u_9.new(p24:GetSubjectCFrame())
	if v_u_3 then
		p24.pitchSpring = v_u_15.new(0, 0)
	else
		local v25 = v_u_15.new
		local v26 = v_u_10.pitchBaseAngle
		p24.pitchSpring = v25(0, -math.rad(v26))
	end
	p24.yawSpring = v_u_15.new(0, 0)
	if v_u_3 then
		p24.lastPanTick = 0
		p24.currentDriftAngle = 0
		p24.needsReset = true
	end
	local v27 = workspace.CurrentCamera
	local v28
	if v27 then
		v28 = v27.CameraSubject
	else
		v28 = v27
	end
	assert(v27, "VRVehicleCamera initialization error")
	assert(v28)
	assert(v28:IsA("VehicleSeat"))
	local v29 = v28:GetConnectedParts(true)
	local v30, v31 = v_u_8.getLooseBoundingSphere(v29)
	p24.assemblyRadius = math.max(v31, 5)
	p24.assemblyOffset = v28.CFrame:Inverse() * v30
	p24.gamepadZoomLevels = {}
	for _, v32 in v_u_4 do
		local v33 = p24.gamepadZoomLevels
		local v34 = v32 * p24.headScale * p24.assemblyRadius / 10
		table.insert(v33, v34)
	end
	p24.lastCameraFocus = nil
	p24:SetCameraToSubjectDistance(p24.gamepadZoomLevels[#p24.gamepadZoomLevels])
end
function v_u_19._StepRotation(p35, p36, p37)
	-- upvalues: (copy) v_u_17, (copy) v_u_7, (copy) v_u_10, (copy) v_u_16
	local v38 = p35.yawSpring
	local v39 = p35.pitchSpring
	local v40 = -p35:getRotation(p36)
	v38.pos = v_u_17(v38.pos + v40)
	local v41 = v_u_17
	local v42 = v39.pos
	v39.pos = v41((math.clamp(v42, -1.3962634015954636, 1.3962634015954636)))
	if v_u_7.getRotationActivated() then
		p35.lastPanTick = os.clock()
	end
	local v43 = v_u_10.pitchDeadzoneAngle
	local v44 = math.rad(v43)
	if os.clock() - p35.lastPanTick > v_u_10.autocorrectDelay then
		local v45 = v_u_16(p37, v_u_10.autocorrectMinCarSpeed, v_u_10.autocorrectMaxCarSpeed, 0, v_u_10.autocorrectResponse)
		v38.freq = v45
		v39.freq = v45
		if v38.freq < 0.001 then
			v38.vel = 0
		end
		if v39.freq < 0.001 then
			v39.vel = 0
		end
		local v46 = v_u_17(0 - v39.pos)
		if math.abs(v46) <= v44 then
			v39.goal = v39.pos
		else
			v39.goal = 0
		end
	else
		v38.freq = 0
		v38.vel = 0
		v39.freq = 0
		v39.vel = 0
		v39.goal = 0
	end
	return CFrame.fromEulerAnglesYXZ(v39:step(p36), v38:step(p36), 0)
end
function v_u_19._GetThirdPersonLocalOffset(p47)
	-- upvalues: (copy) v_u_10
	local v48 = p47.assemblyOffset
	local v49 = p47.assemblyRadius * v_u_10.verticalCenterOffset
	return v48 + Vector3.new(0, v49, 0)
end
function v_u_19._GetFirstPersonLocalOffset(p50, p51)
	-- upvalues: (copy) v_u_14
	local v52 = v_u_14.Character
	if v52 and v52.Parent then
		local v53 = v52:FindFirstChild("Head")
		if v53 and v53:IsA("BasePart") then
			return p51:Inverse() * v53.Position
		end
	end
	return p50:_GetThirdPersonLocalOffset()
end
function v_u_19.Update(p54)
	-- upvalues: (ref) v_u_3, (ref) v_u_18, (copy) v_u_14, (copy) v_u_13
	if v_u_3 then
		local v55 = v_u_18
		v_u_18 = 0
		p54:UpdateFadeFromBlack(v55)
		p54:UpdateEdgeBlur(v_u_14, v55)
		if v_u_13.ThirdPersonFollowCamEnabled then
			local v56, v57 = p54:UpdateStepRotation(v55)
			return v56, v57
		else
			local v58, v59 = p54:UpdateComfortCamera(v55)
			return v58, v59
		end
	else
		return p54:UpdateComfortCamera()
	end
end
function v_u_19.addDrift(p60, p61, p62)
	-- upvalues: (copy) v_u_14, (copy) v_u_13
	local v63 = workspace.CurrentCamera
	local v64 = p60:GetCameraToSubjectDistance()
	local v65 = p60:GetSubjectVelocity()
	local v66 = p60:GetSubjectCFrame()
	require(v_u_14:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"))
	if v65.Magnitude > 0.1 then
		local v67 = v_u_13:GetUserCFrame(Enum.UserCFrame.Head)
		local v68 = v67.Rotation + v67.Position * v63.HeadScale
		local v69 = v63.CFrame * v68
		local _, v70, _ = v69:ToEulerAnglesYXZ()
		local _, v71, _ = v66:ToEulerAnglesYXZ()
		local v72 = (v70 - p60.currentDriftAngle + 12.566370614359172) % 6.283185307179586
		if v72 > 3.141592653589793 then
			v72 = v72 - 6.283185307179586
		end
		local v73 = (v71 - p60.currentDriftAngle + 12.566370614359172) % 6.283185307179586
		if v73 > 3.141592653589793 then
			v73 = v73 - 6.283185307179586
		end
		local v74 = math.min(v73, v72)
		local v75 = math.max(v73, v72)
		local v76 = 0
		if v74 > 0 then
			v75 = v74
		elseif v75 >= 0 then
			v75 = v76
		end
		p60.currentDriftAngle = v75 + p60.currentDriftAngle
		local v77 = CFrame.fromEulerAnglesYXZ(0, p60.currentDriftAngle, 0).LookVector
		local v78 = v77.X
		local v79 = v77.Z
		local v80 = Vector3.new(v78, 0, v79).Unit * v64
		local v81 = p62.Position - v80
		p61 = p61:Lerp(CFrame.new(v63.CFrame.Position + v81 - v69.Position) * v63.CFrame.Rotation, 0.01)
	end
	return p61, p62
end
function v_u_19.UpdateRotationCamera(p82, p83)
	-- upvalues: (copy) v_u_16, (copy) v_u_14
	local v84 = workspace.CurrentCamera
	local v85
	if v84 then
		v85 = v84.CameraSubject
	else
		v85 = v84
	end
	local v86 = p82.vehicleCameraCore
	assert(v84)
	assert(v85)
	assert(v85:IsA("VehicleSeat"))
	local v87 = p82:GetSubjectCFrame()
	local v88 = p82:GetSubjectVelocity()
	local v89 = p82:GetSubjectRotVelocity()
	local v90 = v88:Dot(v87.ZVector)
	local v91 = math.abs(v90)
	local v92 = v87.YVector:Dot(v89)
	local v93 = math.abs(v92)
	local v94 = v87.XVector:Dot(v89)
	local v95 = math.abs(v94)
	local v96 = p82:GetCameraToSubjectDistance()
	local v97 = v_u_16(v96, 0.5, p82.assemblyRadius, 1, 0)
	local v98 = p82:_GetThirdPersonLocalOffset():Lerp(p82:_GetFirstPersonLocalOffset(v87), v97)
	v86:setTransform(v87)
	local v99 = v86:step(p83, v95, v93, v97)
	local v100 = p82:_StepRotation(p83, v91)
	local v101 = p82:GetVRFocus(v87 * v98, p83) * v99 * v100
	local v102 = v101 * CFrame.new(0, 0, v96)
	if v88.Magnitude > 0.1 then
		p82:StartVREdgeBlur(v_u_14)
	end
	return v102, v101
end
function v_u_19.UpdateStepRotation(p103, p104)
	-- upvalues: (copy) v_u_16, (copy) v_u_5, (copy) v_u_13, (copy) v_u_14
	local v105 = workspace.CurrentCamera
	local v106 = p103.lastSubjectCFrame
	local v107 = p103:GetSubjectCFrame()
	local v108 = p103:GetSubjectVelocity()
	local v109 = p103:GetCameraToSubjectDistance()
	local v110 = v_u_16(v109, 0.5, p103.assemblyRadius, 1, 0)
	local v111 = p103:_GetThirdPersonLocalOffset():Lerp(p103:_GetFirstPersonLocalOffset(v107), v110)
	local v112 = p103:GetVRFocus(v107 * v111, p104)
	local v113, v114 = p103:addDrift(v112:ToWorldSpace(p103:GetVRFocus(v106 * v111, p104):ToObjectSpace(v105.CFrame)), v112)
	local v115 = p103:getRotation(p104)
	local v116
	if math.abs(v115) > 0 then
		local v117 = v114:ToObjectSpace(v113)
		v116 = v114 * CFrame.Angles(0, -v115, 0) * v117
		if not v_u_5.VRSmoothRotationEnabled then
			local v118 = v_u_13:GetUserCFrame(Enum.UserCFrame.Head)
			local v119 = v118.Rotation + v118.Position * v105.HeadScale
			local v120 = v114 * v107.Rotation
			local v121 = v120:ToObjectSpace(v113 * v119)
			local v122 = v121.X
			local v123 = v121.Z
			local v124 = Vector3.new(v122, 0, v123).Unit:Dot(Vector3.new(0, 0, 1))
			local v125 = math.acos(v124)
			local v126 = v120:ToObjectSpace(v116 * v119)
			local v127 = v126.X
			local v128 = v126.Z
			local v129 = Vector3.new(v127, 0, v128).Unit:Dot(Vector3.new(0, 0, 1))
			if math.acos(v129) < v125 then
				if v115 < 0 then
					v125 = v125 * -1
				end
				v116 = v114 * CFrame.Angles(0, -v125, 0) * v117
			end
		end
	else
		v116 = v113
	end
	if v108.Magnitude > 0.1 then
		p103:StartVREdgeBlur(v_u_14)
	end
	if p103.needsReset then
		p103.needsReset = false
		v_u_13:RecenterUserHeadCFrame()
		p103:StartFadeFromBlack()
		p103:ResetZoom()
	end
	if p103.recentered then
		v116 = v114 * v107.Rotation * CFrame.new(0, 0, v109)
		p103.recentered = false
	end
	return v116, v116 * CFrame.new(0, 0, -v109)
end
function v_u_19.UpdateComfortCamera(p130, p131)
	-- upvalues: (ref) v_u_3, (ref) v_u_18, (copy) v_u_16, (copy) v_u_14
	local v132 = workspace.CurrentCamera
	local v133
	if v132 then
		v133 = v132.CameraSubject
	else
		v133 = v132
	end
	local v134 = p130.vehicleCameraCore
	assert(v132)
	assert(v133)
	assert(v133:IsA("VehicleSeat"))
	if not v_u_3 then
		p131 = v_u_18
		v_u_18 = 0
	end
	local v135 = p130:GetSubjectCFrame()
	local v136 = p130:GetSubjectVelocity()
	local v137 = p130:GetSubjectRotVelocity()
	local v138 = v136:Dot(v135.ZVector)
	math.abs(v138)
	local v139 = v135.YVector:Dot(v137)
	local v140 = math.abs(v139)
	local v141 = v135.XVector:Dot(v137)
	local v142 = math.abs(v141)
	local v143 = p130:StepZoom()
	local v144 = v_u_16(v143, 0.5, p130.assemblyRadius, 1, 0)
	local v145 = p130:_GetThirdPersonLocalOffset():Lerp(p130:_GetFirstPersonLocalOffset(v135), v144)
	v134:setTransform(v135)
	local v146 = v134:step(p131, v142, v140, v144)
	if not v_u_3 then
		p130:UpdateFadeFromBlack(p131)
	end
	local v147, v148
	if p130:IsInFirstPerson() then
		local v149 = v146.LookVector.X
		local v150 = v146.LookVector.Z
		local v151 = Vector3.new(v149, 0, v150).Unit
		local v152 = CFrame.new(v146.Position, v151)
		v147 = CFrame.new(v135 * v145) * v152
		v148 = v147 * CFrame.new(0, 0, v143)
		if v_u_3 then
			if v136.Magnitude > 0.1 then
				p130:StartVREdgeBlur(v_u_14)
			end
		else
			p130:StartVREdgeBlur(v_u_14)
		end
	else
		v147 = CFrame.new(v135 * v145) * v146
		v148 = v147 * CFrame.new(0, 0, v143)
		if not p130.lastCameraFocus then
			p130.lastCameraFocus = v147
			p130.needsReset = true
		end
		local v153 = v147.Position - v132.CFrame.Position
		local v154 = v153.magnitude
		if v153.Unit:Dot(v132.CFrame.LookVector) > 0.56 and (v154 < 200 and not p130.needsReset) then
			v147 = p130.lastCameraFocus
			local v155 = v147.p
			local v156 = p130:GetCameraLookVector()
			local v157 = v156.X
			local v158 = v156.Z
			local v159 = p130:CalculateNewLookVectorFromArg(Vector3.new(v157, 0, v158).Unit, Vector2.new(0, 0))
			v148 = CFrame.new(v155 - v143 * v159, v155)
		else
			p130.lastCameraFocus = p130:GetVRFocus(v135.Position, p131)
			p130.needsReset = false
			p130:StartFadeFromBlack()
			p130:ResetZoom()
		end
		if not v_u_3 then
			p130:UpdateEdgeBlur(v_u_14, p131)
		end
	end
	return v148, v147
end
return v_u_19