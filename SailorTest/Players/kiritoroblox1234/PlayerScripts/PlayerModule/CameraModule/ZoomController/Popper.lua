local v1 = game:GetService("Players")
local v2 = script.Parent.Parent.Parent:WaitForChild("CommonUtils")
local v3 = require(v2:WaitForChild("FlagUtil"))
local v4 = require(v2:WaitForChild("CameraWrapper"))
local v5 = require(v2:WaitForChild("ConnectionUtil"))
local v_u_6 = v3.getUserFlag("UserRaycastUpdateAPI2")
local v_u_7 = v3.getUserFlag("UserCurrentCameraUpdate2")
local v_u_8 = v3.getUserFlag("UserPlayerConnectionMemoryLeak")
local v_u_9
if v_u_7 then
	v_u_9 = v4.new()
else
	v_u_9 = nil
end
local v_u_10
if v_u_7 then
	v_u_10 = nil
else
	v_u_10 = game.Workspace.CurrentCamera
end
if v_u_7 then
	v_u_9:Enable()
end
local v_u_11 = math.min
local v_u_12 = math.tan
local v_u_13 = math.rad
local v_u_14 = Ray.new
local v_u_15 = RaycastParams.new()
v_u_15.IgnoreWater = true
v_u_15.FilterType = Enum.RaycastFilterType.Exclude
v_u_15.RespectCanCollide = true
local v_u_16 = RaycastParams.new()
v_u_16.IgnoreWater = true
v_u_16.FilterType = Enum.RaycastFilterType.Include
local v_u_17
if v_u_8 then
	v_u_17 = v5.new()
else
	v_u_17 = nil
end
local v_u_18 = nil
local v_u_19 = nil
local v_u_20, v_u_21, v_u_22
if v_u_7 then
	local function v27()
		-- upvalues: (copy) v_u_9, (copy) v_u_13, (ref) v_u_19, (copy) v_u_12, (ref) v_u_18
		local v23 = v_u_9:getCamera()
		local v24 = v_u_13(v23.FieldOfView)
		local v25 = v23.ViewportSize
		local v26 = v25.X / v25.Y
		v_u_19 = v_u_12(v24 / 2) * 2
		v_u_18 = v26 * v_u_19
	end
	v_u_9:Connect("FieldOfView", v27)
	v_u_9:Connect("ViewportSize", v27)
	local v28 = v_u_9:getCamera()
	local v29 = v_u_13(v28.FieldOfView)
	local v30 = v28.ViewportSize
	local v31 = v30.X / v30.Y
	local v32 = v_u_12(v29 / 2) * 2
	local v33 = v31 * v32
	local v_u_34 = v_u_9:getCamera().NearPlaneZ
	v_u_9:Connect("NearPlaneZ", function()
		-- upvalues: (ref) v_u_34, (copy) v_u_9
		v_u_34 = v_u_9:getCamera().NearPlaneZ
	end)
	v_u_20 = v32
	v_u_21 = v33
	v_u_22 = v_u_34
else
	local function v38()
		-- upvalues: (ref) v_u_10, (copy) v_u_13, (ref) v_u_19, (copy) v_u_12, (ref) v_u_18
		local v35 = v_u_13(v_u_10.FieldOfView)
		local v36 = v_u_10.ViewportSize
		local v37 = v36.X / v36.Y
		v_u_19 = v_u_12(v35 / 2) * 2
		v_u_18 = v37 * v_u_19
	end
	v_u_10:GetPropertyChangedSignal("FieldOfView"):Connect(v38)
	v_u_10:GetPropertyChangedSignal("ViewportSize"):Connect(v38)
	local v39 = v_u_13(v_u_10.FieldOfView)
	local v40 = v_u_10.ViewportSize
	local v41 = v40.X / v40.Y
	local v42 = v_u_12(v39 / 2) * 2
	local v43 = v41 * v42
	local v_u_44 = v_u_10.NearPlaneZ
	v_u_10:GetPropertyChangedSignal("NearPlaneZ"):Connect(function()
		-- upvalues: (ref) v_u_44, (ref) v_u_10
		v_u_44 = v_u_10.NearPlaneZ
	end)
	v_u_20 = v42
	v_u_21 = v43
	v_u_22 = v_u_44
end
local v_u_45 = {}
local v_u_46 = {}
local function v57(p_u_47)
	-- upvalues: (copy) v_u_46, (ref) v_u_45, (copy) v_u_8, (copy) v_u_17
	local function v51(p48)
		-- upvalues: (ref) v_u_46, (copy) p_u_47, (ref) v_u_45
		v_u_46[p_u_47] = p48
		local v49 = 1
		v_u_45 = {}
		for _, v50 in pairs(v_u_46) do
			v_u_45[v49] = v50
			v49 = v49 + 1
		end
	end
	local function v54()
		-- upvalues: (ref) v_u_46, (copy) p_u_47, (ref) v_u_45
		v_u_46[p_u_47] = nil
		local v52 = 1
		v_u_45 = {}
		for _, v53 in pairs(v_u_46) do
			v_u_45[v52] = v53
			v52 = v52 + 1
		end
	end
	if v_u_8 then
		v_u_17:trackConnection(("%*CharacterAdded"):format(p_u_47.UserId), p_u_47.CharacterAdded:Connect(v51))
		v_u_17:trackConnection(("%*CharacterRemoving"):format(p_u_47.UserId), p_u_47.CharacterRemoving:Connect(v54))
	else
		p_u_47.CharacterAdded:Connect(v51)
		p_u_47.CharacterRemoving:Connect(v54)
	end
	if p_u_47.Character then
		v_u_46[p_u_47] = p_u_47.Character
		local v55 = 1
		v_u_45 = {}
		for _, v56 in pairs(v_u_46) do
			v_u_45[v55] = v56
			v55 = v55 + 1
		end
	end
end
local function v61(p58)
	-- upvalues: (copy) v_u_46, (ref) v_u_45, (copy) v_u_8, (copy) v_u_17
	v_u_46[p58] = nil
	local v59 = 1
	v_u_45 = {}
	for _, v60 in pairs(v_u_46) do
		v_u_45[v59] = v60
		v59 = v59 + 1
	end
	if v_u_8 then
		v_u_17:disconnect((("%*CharacterAdded"):format(p58.UserId)))
		v_u_17:disconnect((("%*CharacterRemoving"):format(p58.UserId)))
	end
end
v1.PlayerAdded:Connect(v57)
v1.PlayerRemoving:Connect(v61)
for _, v62 in ipairs(v1:GetPlayers()) do
	v57(v62)
end
local v63 = 1
v_u_45 = {}
local v_u_64 = v_u_45
for _, v65 in pairs(v_u_46) do
	v_u_64[v63] = v65
	v63 = v63 + 1
end
local v_u_66 = nil
local v_u_67 = nil
if v_u_7 then
	v_u_9:Connect("CameraSubject", function()
		-- upvalues: (copy) v_u_9, (ref) v_u_67
		local v68 = v_u_9:getCamera().CameraSubject
		if v68 and v68:IsA("Humanoid") then
			v_u_67 = v68.RootPart
			return
		elseif v68 and v68:IsA("BasePart") then
			v_u_67 = v68
		else
			v_u_67 = nil
		end
	end)
else
	v_u_10:GetPropertyChangedSignal("CameraSubject"):Connect(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_67
		local v69 = v_u_10.CameraSubject
		if v69:IsA("Humanoid") then
			v_u_67 = v69.RootPart
			return
		elseif v69:IsA("BasePart") then
			v_u_67 = v69
		else
			v_u_67 = nil
		end
	end)
end
local v_u_70 = {
	Vector2.new(0.4, 0),
	Vector2.new(-0.4, 0),
	Vector2.new(0, -0.4),
	Vector2.new(0, 0.4),
	Vector2.new(0, 0.2)
}
local function v_u_81(p71, p72)
	-- upvalues: (copy) v_u_6, (copy) v_u_15, (ref) v_u_64, (copy) v_u_14
	if v_u_6 then
		v_u_15.FilterDescendantsInstances = v_u_64
		local v73 = workspace:Raycast(p71, p72, v_u_15)
		if v73 then
			return v73.Position, true
		end
		::l4::
		return p71 + p72, false
	else
		local v74 = #v_u_64
		while true do
			local v75, v76 = workspace:FindPartOnRayWithIgnoreList(v_u_14(p71, p72), v_u_64, false, true)
			if v75 then
				if v75.CanCollide then
					local v77 = v_u_64
					for v78 = #v77, v74 + 1, -1 do
						v77[v78] = nil
					end
					return v76, true
				end
				v_u_64[#v_u_64 + 1] = v75
			end
			if not v75 then
				local v79 = v_u_64
				for v80 = #v79, v74 + 1, -1 do
					v79[v80] = nil
				end
				goto l4
			end
		end
	end
end
local function v_u_109(p82, p83, p84, p85)
	-- upvalues: (ref) v_u_64, (ref) v_u_22, (copy) v_u_6, (copy) v_u_15, (ref) v_u_66, (copy) v_u_16, (copy) v_u_14
	debug.profilebegin("queryPoint")
	local v86 = #v_u_64
	local v87 = p84 + v_u_22
	local v88 = p82 + p83 * v87
	local v89 = (1 / 0)
	local v90 = (1 / 0)
	local v91 = 0
	local v92
	if v_u_6 then
		v_u_15.FilterDescendantsInstances = v_u_64
		local v93 = p82
		while true do
			local v94 = workspace:Raycast(p82, v88 - p82, v_u_15)
			if not v94 then
				v92 = v89
				break
			end
			v91 = v91 + 1
			local v95 = v94.Instance
			local v96 = v94.Position
			v92 = (v96 - v93).Magnitude
			if v91 >= 64 then
				v90 = v92
				v92 = v89
			else
				local v97 = 1 - (1 - v95.Transparency) * (1 - v95.LocalTransparencyModifier) < 0.25 and (v_u_6 or v95.CanCollide)
				if v97 then
					if v_u_66 == (v95:GetRootPart() or v95) then
						v97 = false
					else
						v97 = not v95:IsA("TrussPart")
					end
				end
				if v97 then
					v_u_16.FilterDescendantsInstances = { v95 }
					if workspace:Raycast(v88, v96 - v88, v_u_16) then
						local v98
						if p85 then
							v98 = workspace:Raycast(p85, v88 - p85, v_u_16) or workspace:Raycast(v88, p85 - v88, v_u_16)
						else
							v98 = false
						end
						if v98 then
							v90 = v92
							v92 = v89
						elseif v87 >= v89 then
							v92 = v89
						end
					else
						v90 = v92
						v92 = v89
					end
				else
					v92 = v89
				end
			end
			v_u_15:AddToFilter(v95)
			p82 = v96 - p83 * 0.001
			if v90 < (1 / 0) or not v95 then
				break
			end
			v89 = v92
		end
	else
		local v99 = p82
		while true do
			if true then
				local v100, v101 = workspace:FindPartOnRayWithIgnoreList(v_u_14(p82, v88 - p82), v_u_64, false, true)
				v91 = v91 + 1
				if v100 then
					local v102 = v91 >= 64
					local v103 = 1 - (1 - v100.Transparency) * (1 - v100.LocalTransparencyModifier) < 0.25 and (v_u_6 or v100.CanCollide)
					if v103 then
						if v_u_66 == (v100:GetRootPart() or v100) then
							v103 = false
						else
							v103 = not v100:IsA("TrussPart")
						end
					end
					if v103 or v102 then
						local v104 = { v100 }
						local v105 = workspace:FindPartOnRayWithWhitelist(v_u_14(v88, v101 - v88), v104, true)
						v92 = (v101 - v99).Magnitude
						if v105 and not v102 then
							local v106
							if p85 then
								v106 = workspace:FindPartOnRayWithWhitelist(v_u_14(p85, v88 - p85), v104, true) or workspace:FindPartOnRayWithWhitelist(v_u_14(v88, p85 - v88), v104, true)
							else
								v106 = false
							end
							if v106 then
								v90 = v92
								v92 = v89
							elseif v87 >= v89 then
								v92 = v89
							end
						else
							v90 = v92
							v92 = v89
						end
					else
						v92 = v89
					end
					v_u_64[#v_u_64 + 1] = v100
					p82 = v101 - p83 * 0.001
				else
					v92 = v89
				end
			end
			if v90 < (1 / 0) or not v100 then
				break
			end
			v89 = v92
		end
		local v107 = v_u_64
		for v108 = #v107, v86 + 1, -1 do
			v107[v108] = nil
		end
	end
	debug.profileend()
	return v92 - v_u_22, v90 - v_u_22
end
local function v_u_125(p110, p111)
	-- upvalues: (ref) v_u_10, (copy) v_u_7, (copy) v_u_9, (ref) v_u_21, (ref) v_u_20, (ref) v_u_22, (copy) v_u_109
	debug.profilebegin("queryViewport")
	local v112 = p110.p
	local v113 = p110.rightVector
	local v114 = p110.upVector
	local v115 = -p110.lookVector
	local v116
	if v_u_7 then
		v116 = v_u_9:getCamera()
	else
		v116 = v_u_10
	end
	v_u_10 = v116
	local v117 = v_u_10.ViewportSize
	local v118 = (1 / 0)
	local v119 = (1 / 0)
	for v120 = 0, 1 do
		local v121 = v113 * ((v120 - 0.5) * v_u_21)
		for v122 = 0, 1 do
			local v123, v124 = v_u_109(v112 + v_u_22 * (v121 + v114 * ((v122 - 0.5) * v_u_20)), v115, p111, v_u_10:ViewportPointToRay(v117.x * v120, v117.y * v122).Origin)
			if v124 >= v119 then
				v124 = v119
			end
			if v123 < v118 then
				v119 = v124
				v118 = v123
			else
				v119 = v124
			end
		end
	end
	debug.profileend()
	return v118, v119
end
local function v_u_139(p126, p127, p128)
	-- upvalues: (copy) v_u_81, (copy) v_u_11, (copy) v_u_109, (copy) v_u_70
	debug.profilebegin("testPromotion")
	local v129 = p126.p
	local v130 = p126.rightVector
	local v131 = p126.upVector
	local v132 = -p126.lookVector
	debug.profilebegin("extrapolate")
	local v133 = (v_u_81(v129, p128.posVelocity * 1.25) - v129).Magnitude
	local v134 = p128.posVelocity.magnitude
	for v135 = 0, v_u_11(1.25, p128.rotVelocity.magnitude + v133 / v134), 0.0625 do
		local v136 = p128.extrapolate(v135)
		if p127 <= v_u_109(v136.p, -v136.lookVector, p127) then
			return false
		end
	end
	debug.profileend()
	debug.profilebegin("testOffsets")
	for _, v137 in ipairs(v_u_70) do
		local v138 = v_u_81(v129, v130 * v137.x + v131 * v137.y)
		if v_u_109(v138, (v129 + v132 * p127 - v138).Unit, p127) == (1 / 0) then
			return false
		end
	end
	debug.profileend()
	debug.profileend()
	return true
end
return function(p140, p141, p142)
	-- upvalues: (ref) v_u_66, (ref) v_u_67, (copy) v_u_125, (copy) v_u_139
	debug.profilebegin("popper")
	v_u_66 = v_u_67 and v_u_67:GetRootPart() or v_u_67
	local v143, v144 = v_u_125(p140, p141)
	if v144 >= p141 then
		v144 = p141
	end
	if v143 < v144 then
		if not v_u_139(p140, p141, p142) then
			v143 = v144
		end
	else
		v143 = v144
	end
	v_u_66 = nil
	debug.profileend()
	return v143
end