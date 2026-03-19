Vector2.new()
require(script.Parent:WaitForChild("CameraUtils"))
local v_u_1 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_2 = game:GetService("Players")
local v_u_3 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4.new()
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v5 = v_u_3.new()
	local v6 = v_u_4
	local v7 = setmetatable(v5, v6)
	v7.cameraType = Enum.CameraType.Fixed
	v7.lastUpdate = tick()
	v7.lastDistanceToSubject = nil
	return v7
end
function v_u_4.GetModuleName(_)
	return "LegacyCamera"
end
function v_u_4.SetCameraToSubjectDistance(p8, p9)
	-- upvalues: (copy) v_u_3
	return v_u_3.SetCameraToSubjectDistance(p8, p9)
end
function v_u_4.Update(p10, p11)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	if not p10.cameraType then
		return nil, nil
	end
	local v12 = tick()
	local v13 = v12 - p10.lastUpdate
	local v14 = workspace.CurrentCamera
	local v15 = v14.CFrame
	local v16 = v14.Focus
	local v17 = v_u_2.LocalPlayer
	local v18 = v_u_1.getRotation(p11)
	if p10.lastUpdate == nil or v13 > 1 then
		p10.lastDistanceToSubject = nil
	end
	local v19 = p10:GetSubjectPosition()
	if p10.cameraType == Enum.CameraType.Fixed then
		if v19 and (v17 and v14) then
			local v20 = p10:GetCameraToSubjectDistance()
			local v21 = p10:CalculateNewLookVectorFromArg(nil, v18)
			v16 = v14.Focus
			v15 = CFrame.new(v14.CFrame.p, v14.CFrame.p + v20 * v21)
		end
	elseif p10.cameraType == Enum.CameraType.Attach then
		local v22 = p10:GetSubjectCFrame()
		local v23 = v14.CFrame:ToEulerAnglesYXZ()
		local _, v24 = v22:ToEulerAnglesYXZ()
		local v25 = v23 - v18.Y
		local v26 = math.clamp(v25, -1.3962634015954636, 1.3962634015954636)
		v16 = CFrame.new(v22.p) * CFrame.fromEulerAnglesYXZ(v26, v24, 0)
		v15 = v16 * CFrame.new(0, 0, p10:StepZoom())
	else
		if p10.cameraType ~= Enum.CameraType.Watch then
			return v14.CFrame, v14.Focus
		end
		if v19 and (v17 and v14) then
			local v27 = nil
			if v19 == v14.CFrame.p then
				warn("Camera cannot watch subject in same position as itself")
				return v14.CFrame, v14.Focus
			end
			local v28 = p10:GetHumanoid()
			if v28 and v28.RootPart then
				local v29 = v19 - v14.CFrame.p
				v27 = v29.unit
				if p10.lastDistanceToSubject and p10.lastDistanceToSubject == p10:GetCameraToSubjectDistance() then
					p10:SetCameraToSubjectDistance(v29.magnitude)
				end
			end
			local v30 = p10:GetCameraToSubjectDistance()
			local v31 = p10:CalculateNewLookVectorFromArg(v27, v18)
			v16 = CFrame.new(v19)
			v15 = CFrame.new(v19 - v30 * v31, v19)
			p10.lastDistanceToSubject = v30
		end
	end
	p10.lastUpdate = v12
	return v15, v16
end
return v_u_4