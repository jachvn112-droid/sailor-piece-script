Vector2.new(0, 0)
local v_u_1 = 0
local v_u_2 = CFrame.fromOrientation(-0.2617993877991494, 0, 0)
local v3 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_4 = require(v3:WaitForChild("FlagUtil")).getUserFlag("UserFixCameraFPError")
local v_u_5 = game:GetService("Players")
local v_u_6 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_7 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_8 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_9 = setmetatable({}, v_u_8)
v_u_9.__index = v_u_9
function v_u_9.new()
	-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) v_u_7
	local v10 = v_u_8.new()
	local v11 = v_u_9
	local v12 = setmetatable(v10, v11)
	v12.isFollowCamera = false
	v12.isCameraToggle = false
	v12.lastUpdate = tick()
	v12.cameraToggleSpring = v_u_7.Spring.new(5, 0)
	return v12
end
function v_u_9.GetCameraToggleOffset(p13, p14)
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	if not p13.isCameraToggle then
		return Vector3.new()
	end
	local v15 = p13.currentSubjectDistance
	if v_u_6.getTogglePan() then
		local v16 = p13.cameraToggleSpring
		local v17 = v_u_7.map(v15, 0.5, p13.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1)
		v16.goal = math.clamp(v17, 0, 1)
	else
		p13.cameraToggleSpring.goal = 0
	end
	local v18 = v_u_7.map(v15, 0.5, 64, 0, 1)
	local v19 = math.clamp(v18, 0, 1) + 1
	local v20 = p13.cameraToggleSpring:step(p14) * v19
	return Vector3.new(0, v20, 0)
end
function v_u_9.SetCameraMovementMode(p21, p22)
	-- upvalues: (copy) v_u_8
	v_u_8.SetCameraMovementMode(p21, p22)
	p21.isFollowCamera = p22 == Enum.ComputerCameraMovementMode.Follow
	p21.isCameraToggle = p22 == Enum.ComputerCameraMovementMode.CameraToggle
end
function v_u_9.Update(p23, p24)
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_6, (ref) v_u_1, (copy) v_u_7, (copy) v_u_4
	local v25 = tick()
	local v26 = workspace.CurrentCamera
	local v27 = v26.CFrame
	local v28 = v26.Focus
	local v29
	if p23.resetCameraAngle then
		local v30 = p23:GetHumanoidRootPart()
		if v30 then
			v29 = (v30.CFrame * v_u_2).lookVector
		else
			v29 = v_u_2.lookVector
		end
		p23.resetCameraAngle = false
	else
		v29 = nil
	end
	local v31 = v_u_5.LocalPlayer
	local v32 = p23:GetHumanoid()
	local v33 = v26.CameraSubject
	local v34
	if v33 then
		v34 = v33:IsA("VehicleSeat")
	else
		v34 = v33
	end
	local v35
	if v33 then
		v35 = v33:IsA("SkateboardPlatform")
	else
		v35 = v33
	end
	local v36
	if v32 then
		v36 = v32:GetState() == Enum.HumanoidStateType.Climbing
	else
		v36 = v32
	end
	if p23.lastUpdate == nil or p24 > 1 then
		p23.lastCameraTransform = nil
	end
	local v37 = v_u_6.getRotation(p24)
	p23:StepZoom()
	local v38 = p23:GetCameraHeight()
	if v37 ~= Vector2.new() then
		v_u_1 = 0
		p23.lastUserPanCamera = tick()
	end
	local v39 = v25 - p23.lastUserPanCamera < 2
	local v40 = p23:GetSubjectPosition()
	if v40 and (v31 and v26) then
		local v41 = p23:GetCameraToSubjectDistance()
		local v42 = v41 < 0.5 and 0.5 or v41
		if p23:GetIsMouseLocked() and not p23:IsInFirstPerson() then
			local v43 = p23:CalculateNewLookCFrameFromArg(v29, v37)
			local v44 = p23:GetMouseLockOffset()
			if v32 then
				v44 = v44 + v32.CameraOffset
			end
			local v45 = v44.X * v43.RightVector + v44.Y * v43.UpVector + v44.Z * v43.LookVector
			if v_u_7.IsFiniteVector3(v45) then
				v40 = v40 + v45
			end
		elseif v37 == Vector2.new() and p23.lastCameraTransform then
			local v46 = p23:IsInFirstPerson()
			if (v34 or (v35 or p23.isFollowCamera and v36)) and (p23.lastUpdate and (v32 and v32.Torso)) then
				if v46 then
					if p23.lastSubjectCFrame and (v34 or v35) and v33:IsA("BasePart") then
						local v47 = -v_u_7.GetAngleBetweenXZVectors(p23.lastSubjectCFrame.lookVector, v33.CFrame.lookVector)
						if v_u_7.IsFinite(v47) then
							v37 = v37 + Vector2.new(v47, 0)
						end
						v_u_1 = 0
					end
				elseif not v39 then
					local v48 = v32.Torso.CFrame.lookVector
					local v49 = v_u_1 + 3.839724354387525 * p24
					v_u_1 = math.clamp(v49, 0, 4.363323129985824)
					local v50 = v_u_1 * p24
					local v51 = math.clamp(v50, 0, 1)
					local v52 = p23:IsInFirstPerson() and not (p23.isFollowCamera and p23.isClimbing) and 1 or v51
					local v53 = v_u_7.GetAngleBetweenXZVectors(v48, p23:GetCameraLookVector())
					if v_u_7.IsFinite(v53) and math.abs(v53) > 0.0001 then
						v37 = v37 + Vector2.new(v53 * v52, 0)
					end
				end
			elseif p23.isFollowCamera and not (v46 or v39) then
				local v54 = -(p23.lastCameraTransform.p - v40)
				local v55 = v_u_7.GetAngleBetweenXZVectors(v54, p23:GetCameraLookVector())
				if v_u_7.IsFinite(v55) and (math.abs(v55) > 0.0001 and math.abs(v55) > 0.4 * p24) then
					v37 = v37 + Vector2.new(v55, 0)
				end
			end
		end
		local v56, v57
		if p23.isFollowCamera then
			local v58 = p23:CalculateNewLookVectorFromArg(v29, v37)
			v56 = CFrame.new(v40)
			if v_u_4 then
				v57 = CFrame.lookAlong(v56.p - v42 * v58, v58)
			else
				v57 = CFrame.new(v56.p - v42 * v58, v56.p) + Vector3.new(0, v38, 0)
			end
		else
			v56 = CFrame.new(v40)
			local v59 = v56.p
			local v60 = p23:CalculateNewLookVectorFromArg(v29, v37)
			if v_u_4 then
				v57 = CFrame.lookAlong(v59 - v42 * v60, v60)
			else
				v57 = CFrame.new(v59 - v42 * v60, v59)
			end
		end
		local v61 = p23:GetCameraToggleOffset(p24)
		v28 = v56 + v61
		v27 = v57 + v61
		p23.lastCameraTransform = v27
		p23.lastCameraFocus = v28
		if (v34 or v35) and v33:IsA("BasePart") then
			p23.lastSubjectCFrame = v33.CFrame
		else
			p23.lastSubjectCFrame = nil
		end
	end
	p23.lastUpdate = v25
	return v27, v28
end
return v_u_9