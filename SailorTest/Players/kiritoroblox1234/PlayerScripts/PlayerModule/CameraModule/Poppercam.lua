local v1 = script.Parent.Parent:WaitForChild("CommonUtils")
local v2 = require(v1:WaitForChild("FlagUtil"))
local v_u_3 = require(script.Parent:WaitForChild("ZoomController"))
local v_u_4 = v2.getUserFlag("UserFixCameraFPError")
local v_u_5 = {}
v_u_5.__index = v_u_5
local v_u_6 = CFrame.new()
function v_u_5.new()
	-- upvalues: (copy) v_u_5
	local v7 = v_u_5
	return setmetatable({
		["lastCFrame"] = nil
	}, v7)
end
function v_u_5.Step(p8, p9, p10)
	-- upvalues: (copy) v_u_6
	local v11 = p8.lastCFrame or p10
	p8.lastCFrame = p10
	local v_u_12 = p10.Position
	local _, _, _, v13, v14, v15, v16, v17, v18, v19, v20, v21 = p10:GetComponents()
	local v_u_22 = CFrame.new(0, 0, 0, v13, v14, v15, v16, v17, v18, v19, v20, v21)
	local v23 = v11.p
	local _, _, _, v24, v25, v26, v27, v28, v29, v30, v31, v32 = v11:GetComponents()
	local v33 = CFrame.new(0, 0, 0, v24, v25, v26, v27, v28, v29, v30, v31, v32)
	local v_u_34 = (v_u_12 - v23) / p9
	local v35, v36 = (v_u_22 * v33:inverse()):ToAxisAngle()
	local v_u_37 = v35 * v36 / p9
	return {
		["extrapolate"] = function(p38)
			-- upvalues: (copy) v_u_34, (copy) v_u_12, (copy) v_u_37, (ref) v_u_6, (copy) v_u_22
			local v39 = v_u_34 * p38 + v_u_12
			local v40 = v_u_37 * p38
			local v41 = v40.Magnitude
			local v42
			if v41 > 0.00001 then
				v42 = CFrame.fromAxisAngle(v40, v41)
			else
				v42 = v_u_6
			end
			return v42 * v_u_22 + v39
		end,
		["posVelocity"] = v_u_34,
		["rotVelocity"] = v_u_37
	}
end
function v_u_5.Reset(p43)
	p43.lastCFrame = nil
end
local v_u_44 = require(script.Parent:WaitForChild("BaseOcclusion"))
local v_u_45 = setmetatable({}, v_u_44)
v_u_45.__index = v_u_45
function v_u_45.new()
	-- upvalues: (copy) v_u_44, (copy) v_u_45, (copy) v_u_5
	local v46 = v_u_44.new()
	local v47 = v_u_45
	local v48 = setmetatable(v46, v47)
	v48.focusExtrapolator = v_u_5.new()
	return v48
end
function v_u_45.GetOcclusionMode(_)
	return Enum.DevCameraOcclusionMode.Zoom
end
function v_u_45.Enable(p49, _)
	p49.focusExtrapolator:Reset()
end
function v_u_45.Update(p50, p51, p52, p53, _)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v54
	if v_u_4 then
		v54 = CFrame.lookAlong(p53.p, -p52.LookVector) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	else
		v54 = CFrame.new(p53.p, p52.p) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	end
	local v55 = p50.focusExtrapolator:Step(p51, v54)
	local v56 = v_u_3.Update(p51, v54, v55)
	return v54 * CFrame.new(0, 0, v56), p53
end
function v_u_45.CharacterAdded(_, _, _) end
function v_u_45.CharacterRemoving(_, _, _) end
function v_u_45.OnCameraSubjectChanged(_, _) end
return v_u_45