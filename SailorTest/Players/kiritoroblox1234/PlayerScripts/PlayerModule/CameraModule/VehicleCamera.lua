local v_u_1 = { 0, 15, 30 }
local v2 = game:GetService("Players")
local v3 = game:GetService("RunService")
local v_u_4 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_5 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_6 = require(script.Parent:WaitForChild("CameraUtils"))
require(script.Parent:WaitForChild("ZoomController"))
local v_u_7 = require(script:WaitForChild("VehicleCameraCore"))
local v_u_8 = require(script:WaitForChild("VehicleCameraConfig"))
local v_u_9 = v2.LocalPlayer
local _ = v_u_6.map
local v_u_10 = v_u_6.Spring
local v_u_11 = v_u_6.mapClamp
local v_u_12 = v_u_6.sanitizeAngle
local v_u_13 = 0.016666666666666666
v3.Stepped:Connect(function(_, p14)
	-- upvalues: (ref) v_u_13
	v_u_13 = p14
end)
local v_u_15 = setmetatable({}, v_u_4)
v_u_15.__index = v_u_15
function v_u_15.new()
	-- upvalues: (copy) v_u_4, (copy) v_u_15
	local v16 = v_u_4.new()
	local v17 = v_u_15
	local v18 = setmetatable(v16, v17)
	v18:Reset()
	return v18
end
function v_u_15.Reset(p19)
	-- upvalues: (copy) v_u_7, (copy) v_u_10, (copy) v_u_8, (copy) v_u_6, (copy) v_u_1
	p19.vehicleCameraCore = v_u_7.new(p19:GetSubjectCFrame())
	local v20 = v_u_10.new
	local v21 = v_u_8.pitchBaseAngle
	p19.pitchSpring = v20(0, -math.rad(v21))
	p19.yawSpring = v_u_10.new(0, 0)
	p19.lastPanTick = 0
	local v22 = workspace.CurrentCamera
	local v23
	if v22 then
		v23 = v22.CameraSubject
	else
		v23 = v22
	end
	assert(v22)
	assert(v23)
	assert(v23:IsA("VehicleSeat"))
	local v24 = v23:GetConnectedParts(true)
	local v25, v26 = v_u_6.getLooseBoundingSphere(v24)
	p19.assemblyRadius = math.max(v26, 5)
	p19.assemblyOffset = v23.CFrame:Inverse() * v25
	p19.gamepadZoomLevels = {}
	for _, v27 in v_u_1 do
		local v28 = p19.gamepadZoomLevels
		local v29 = v27 * p19.assemblyRadius / 10
		table.insert(v28, v29)
	end
	p19:SetCameraToSubjectDistance(p19.gamepadZoomLevels[#p19.gamepadZoomLevels])
end
function v_u_15._StepRotation(p30, p31, p32)
	-- upvalues: (copy) v_u_5, (copy) v_u_12, (copy) v_u_8, (copy) v_u_11
	local v33 = p30.yawSpring
	local v34 = p30.pitchSpring
	local v35 = v_u_5.getRotation(p31, true)
	local v36 = -v35.X
	local v37 = -v35.Y
	v33.pos = v_u_12(v33.pos + v36)
	local v38 = v_u_12
	local v39 = v34.pos + v37
	v34.pos = v38((math.clamp(v39, -1.3962634015954636, 1.3962634015954636)))
	if v_u_5.getRotationActivated() then
		p30.lastPanTick = os.clock()
	end
	local v40 = v_u_8.pitchBaseAngle
	local v41 = -math.rad(v40)
	local v42 = v_u_8.pitchDeadzoneAngle
	local v43 = math.rad(v42)
	if os.clock() - p30.lastPanTick > v_u_8.autocorrectDelay then
		local v44 = v_u_11(p32, v_u_8.autocorrectMinCarSpeed, v_u_8.autocorrectMaxCarSpeed, 0, v_u_8.autocorrectResponse)
		v33.freq = v44
		v34.freq = v44
		if v33.freq < 0.001 then
			v33.vel = 0
		end
		if v34.freq < 0.001 then
			v34.vel = 0
		end
		local v45 = v_u_12(v41 - v34.pos)
		if math.abs(v45) <= v43 then
			v34.goal = v34.pos
		else
			v34.goal = v41
		end
	else
		v33.freq = 0
		v33.vel = 0
		v34.freq = 0
		v34.vel = 0
		v34.goal = v41
	end
	return CFrame.fromEulerAnglesYXZ(v34:step(p31), v33:step(p31), 0)
end
function v_u_15._GetThirdPersonLocalOffset(p46)
	-- upvalues: (copy) v_u_8
	local v47 = p46.assemblyOffset
	local v48 = p46.assemblyRadius * v_u_8.verticalCenterOffset
	return v47 + Vector3.new(0, v48, 0)
end
function v_u_15._GetFirstPersonLocalOffset(p49, p50)
	-- upvalues: (copy) v_u_9
	local v51 = v_u_9.Character
	if v51 and v51.Parent then
		local v52 = v51:FindFirstChild("Head")
		if v52 and v52:IsA("BasePart") then
			return p50:Inverse() * v52.Position
		end
	end
	return p49:_GetThirdPersonLocalOffset()
end
function v_u_15.Update(p53)
	-- upvalues: (ref) v_u_13, (copy) v_u_11
	local v54 = workspace.CurrentCamera
	local v55
	if v54 then
		v55 = v54.CameraSubject
	else
		v55 = v54
	end
	local v56 = p53.vehicleCameraCore
	assert(v54)
	assert(v55)
	assert(v55:IsA("VehicleSeat"))
	local v57 = v_u_13
	v_u_13 = 0
	local v58 = p53:GetSubjectCFrame()
	local v59 = p53:GetSubjectVelocity()
	local v60 = p53:GetSubjectRotVelocity()
	local v61 = v59:Dot(v58.ZVector)
	local v62 = math.abs(v61)
	local v63 = v58.YVector:Dot(v60)
	local v64 = math.abs(v63)
	local v65 = v58.XVector:Dot(v60)
	local v66 = math.abs(v65)
	local v67 = p53:StepZoom()
	local v68 = p53:_StepRotation(v57, v62)
	local v69 = v_u_11(v67, 0.5, p53.assemblyRadius, 1, 0)
	local v70 = p53:_GetThirdPersonLocalOffset():Lerp(p53:_GetFirstPersonLocalOffset(v58), v69)
	v56:setTransform(v58)
	local v71 = v56:step(v57, v66, v64, v69)
	local v72 = CFrame.new(v58 * v70) * v71 * v68
	return v72 * CFrame.new(0, 0, v67), v72
end
function v_u_15.ApplyVRTransform(_) end
return v_u_15