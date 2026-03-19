local v_u_1 = game:GetService("Players")
local v2 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_3 = require(v2:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2")
local v_u_4 = {
	["LIMBS"] = 2,
	["MOVEMENT"] = 3,
	["CORNERS"] = 4,
	["CIRCLE1"] = 5,
	["CIRCLE2"] = 6,
	["LIMBMOVE"] = 7,
	["SMART_CIRCLE"] = 8,
	["CHAR_OUTLINE"] = 9
}
local v_u_5 = {
	["Head"] = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true,
	["LeftLowerArm"] = true,
	["RightLowerArm"] = true,
	["LeftUpperLeg"] = true,
	["RightUpperLeg"] = true
}
local v_u_6 = {
	Vector3.new(1, 1, -1),
	Vector3.new(1, -1, -1),
	Vector3.new(-1, -1, -1),
	Vector3.new(-1, 1, -1)
}
local v_u_7 = RaycastParams.new()
v_u_7.FilterType = Enum.RaycastFilterType.Exclude
local v_u_8 = RaycastParams.new()
v_u_8.FilterType = Enum.RaycastFilterType.Include
local function v_u_16(p9, ...)
	local v10 = {}
	local v11 = ""
	for _, v12 in pairs({ ... }) do
		v10[v12] = true
		v11 = v11 .. (v11 == "" and "" or " or ") .. v12
	end
	local v13 = type(p9)
	local v14 = v10[v13]
	local v15 = v11 .. " type expected, got: " .. v13
	assert(v14, v15)
end
local function v_u_52(p17, p18, p19, p20)
	local v21 = p18:Cross(p20)
	local v22 = p19.X - p17.X
	local v23 = p19.Y - p17.Y
	local v24 = p19.Z - p17.Z
	local v25 = p18.X
	local v26 = -p20.X
	local v27 = v21.X
	local v28 = p18.Y
	local v29 = -p20.Y
	local v30 = v21.Y
	local v31 = p18.Z
	local v32 = -p20.Z
	local v33 = v21.Z
	local v34 = v25 * (v29 * v33 - v30 * v32) - v26 * (v28 * v33 - v30 * v31) + v27 * (v28 * v32 - v29 * v31)
	if v34 == 0 then
		return Vector3.new(0, 0, 0)
	end
	local v35 = -p20.X
	local v36 = v21.X
	local v37 = -p20.Y
	local v38 = v21.Y
	local v39 = -p20.Z
	local v40 = v21.Z
	local v41 = (v22 * (v37 * v40 - v38 * v39) - v35 * (v23 * v40 - v38 * v24) + v36 * (v23 * v39 - v37 * v24)) / v34
	local v42 = p18.X
	local v43 = v21.X
	local v44 = p18.Y
	local v45 = v21.Y
	local v46 = p18.Z
	local v47 = v21.Z
	local v48 = (v42 * (v23 * v47 - v45 * v24) - v22 * (v44 * v47 - v45 * v46) + v43 * (v44 * v24 - v23 * v46)) / v34
	local v49 = p17 + v41 * p18
	local v50 = p19 + v48 * p20
	local v51 = v49 + (v50 - v49) * 0.5
	return (v50 - v49).Magnitude >= 0.25 and Vector3.new(0, 0, 0) or v51
end
local v_u_53 = require(script.Parent:WaitForChild("BaseOcclusion"))
local v_u_54 = setmetatable({}, v_u_53)
v_u_54.__index = v_u_54
function v_u_54.new()
	-- upvalues: (copy) v_u_53, (copy) v_u_54, (copy) v_u_4
	local v55 = v_u_53.new()
	local v56 = v_u_54
	local v57 = setmetatable(v55, v56)
	v57.char = nil
	v57.humanoidRootPart = nil
	v57.torsoPart = nil
	v57.headPart = nil
	v57.childAddedConn = nil
	v57.childRemovedConn = nil
	v57.behaviors = {}
	v57.behaviors[v_u_4.LIMBS] = v57.LimbBehavior
	v57.behaviors[v_u_4.MOVEMENT] = v57.MoveBehavior
	v57.behaviors[v_u_4.CORNERS] = v57.CornerBehavior
	v57.behaviors[v_u_4.CIRCLE1] = v57.CircleBehavior
	v57.behaviors[v_u_4.CIRCLE2] = v57.CircleBehavior
	v57.behaviors[v_u_4.LIMBMOVE] = v57.LimbMoveBehavior
	v57.behaviors[v_u_4.SMART_CIRCLE] = v57.SmartCircleBehavior
	v57.behaviors[v_u_4.CHAR_OUTLINE] = v57.CharacterOutlineBehavior
	v57.mode = v_u_4.SMART_CIRCLE
	v57.behaviorFunction = v57.SmartCircleBehavior
	v57.savedHits = {}
	v57.trackedLimbs = {}
	v57.camera = game.Workspace.CurrentCamera
	v57.enabled = false
	return v57
end
function v_u_54.Enable(p58, p59)
	p58.enabled = p59
	if not p59 then
		p58:Cleanup()
	end
end
function v_u_54.GetOcclusionMode(_)
	return Enum.DevCameraOcclusionMode.Invisicam
end
function v_u_54.LimbBehavior(p60, p61)
	for v62, _ in pairs(p60.trackedLimbs) do
		p61[#p61 + 1] = v62.Position
	end
end
function v_u_54.MoveBehavior(p63, p64)
	for v65 = 1, 3 do
		local v66 = p63.humanoidRootPart.Position
		local v67 = p63.humanoidRootPart.Velocity
		local v68 = v67.X
		local v69 = v67.Z
		local v70 = Vector3.new(v68, 0, v69).Magnitude / 2
		local v71 = (v65 - 1) * p63.humanoidRootPart.CFrame.lookVector * v70
		p64[#p64 + 1] = v66 + v71
	end
end
function v_u_54.CornerBehavior(p72, p73)
	-- upvalues: (copy) v_u_6
	local v74 = p72.humanoidRootPart.CFrame
	local v75 = v74.Position
	local v76 = v74 - v75
	local v77 = p72.char:GetExtentsSize() / 2
	p73[#p73 + 1] = v75
	for v78 = 1, #v_u_6 do
		p73[#p73 + 1] = v75 + v76 * (v77 * v_u_6[v78])
	end
end
function v_u_54.CircleBehavior(p79, p80)
	-- upvalues: (copy) v_u_4
	local v81
	if p79.mode == v_u_4.CIRCLE1 then
		v81 = p79.humanoidRootPart.CFrame
	else
		local v82 = p79.camera.CoordinateFrame
		v81 = v82 - v82.Position + p79.humanoidRootPart.Position
	end
	p80[#p80 + 1] = v81.Position
	for v83 = 0, 9 do
		local v84 = 0.6283185307179586 * v83
		local v85 = math.cos(v84)
		local v86 = math.sin(v84)
		local v87 = Vector3.new(v85, v86, 0) * 3
		p80[#p80 + 1] = v81 * v87
	end
end
function v_u_54.LimbMoveBehavior(p88, p89)
	p88:LimbBehavior(p89)
	p88:MoveBehavior(p89)
end
function v_u_54.CharacterOutlineBehavior(p90, p91)
	-- upvalues: (copy) v_u_3, (copy) v_u_8
	local v92 = p90.torsoPart.CFrame.upVector.unit
	local v93 = p90.torsoPart.CFrame.rightVector.unit
	p91[#p91 + 1] = p90.torsoPart.CFrame.p
	p91[#p91 + 1] = p90.torsoPart.CFrame.p + v92
	p91[#p91 + 1] = p90.torsoPart.CFrame.p - v92
	p91[#p91 + 1] = p90.torsoPart.CFrame.p + v93
	p91[#p91 + 1] = p90.torsoPart.CFrame.p - v93
	if p90.headPart then
		p91[#p91 + 1] = p90.headPart.CFrame.p
	end
	local v94 = CFrame.new
	local v95 = p90.camera.CoordinateFrame.lookVector.X
	local v96 = p90.camera.CoordinateFrame.lookVector.Z
	local v97 = v94(Vector3.new(0, 0, 0), (Vector3.new(v95, 0, v96)))
	local v98 = p90.torsoPart and p90.torsoPart.Position or p90.humanoidRootPart.Position
	local v99 = { p90.torsoPart }
	if p90.headPart then
		v99[#v99 + 1] = p90.headPart
	end
	for v100 = 1, 24 do
		local v101 = 6.283185307179586 * v100 / 24
		local v102 = math.cos(v101)
		local v103 = math.sin(v101)
		local v104 = v97 * (Vector3.new(v102, v103, 0) * 3)
		local v105 = v104.X
		local v106 = v104.Y
		local v107 = math.max(v106, -2.25)
		local v108 = v104.Z
		local v109 = Vector3.new(v105, v107, v108)
		if v_u_3 then
			v_u_8.FilterDescendantsInstances = v99
			local v110 = game.Workspace:Raycast(v98 + v109, -3 * v109, v_u_8)
			if v110 then
				local v111 = v110.Position
				p91[#p91 + 1] = v111 + 0.2 * (v98 - v111).unit
			end
		else
			local v112 = Ray.new(v98 + v109, -3 * v109)
			local v113, v114 = game.Workspace:FindPartOnRayWithWhitelist(v112, v99, false)
			if v113 then
				p91[#p91 + 1] = v114 + 0.2 * (v98 - v114).unit
			end
		end
	end
end
function v_u_54.SmartCircleBehavior(p115, p116)
	-- upvalues: (copy) v_u_3, (copy) v_u_7, (copy) v_u_52
	local v117 = p115.torsoPart.CFrame.upVector.unit
	local v118 = p115.torsoPart.CFrame.rightVector.unit
	p116[#p116 + 1] = p115.torsoPart.CFrame.p
	p116[#p116 + 1] = p115.torsoPart.CFrame.p + v117
	p116[#p116 + 1] = p115.torsoPart.CFrame.p - v117
	p116[#p116 + 1] = p115.torsoPart.CFrame.p + v118
	p116[#p116 + 1] = p115.torsoPart.CFrame.p - v118
	if p115.headPart then
		p116[#p116 + 1] = p115.headPart.CFrame.p
	end
	local v119 = p115.camera.CFrame - p115.camera.CFrame.p
	local v120 = Vector3.new(0, 0.5, 0) + (p115.torsoPart and p115.torsoPart.Position or p115.humanoidRootPart.Position)
	for v121 = 1, 24 do
		local v122 = 0.2617993877991494 * v121 - 1.5707963267948966
		local v123 = math.cos(v122)
		local v124 = math.sin(v122)
		local v125 = v120 + v119 * (Vector3.new(v123, v124, 0) * 2.5)
		local v126 = v125 - p115.camera.CFrame.p
		if v_u_3 then
			v_u_7.FilterDescendantsInstances = { p115.char }
			local v127 = game.Workspace:Raycast(v120, v125 - v120, v_u_7)
			if v127 then
				local v128 = v127.Position
				local v129 = v127.Normal
				local v130 = v128 + 0.1 * v129.unit
				local v131 = v130 - v120
				local v132 = v131:Cross(v126).unit:Cross(v129).unit
				local v133 = (v130 - p115.camera.CFrame.p).unit
				if v131.unit:Dot(-v132) < v131.unit:Dot(v133) then
					v125 = v_u_52(v130, v132, v125, v126)
					if v125.Magnitude > 0 then
						local v134 = game.Workspace:Raycast(v130, v125 - v130, v_u_7)
						if v134 then
							v125 = v134.Position + 0.1 * v134.Normal.Unit
						end
					else
						v125 = v130
					end
				else
					v125 = v130
				end
				local v135 = game.Workspace:Raycast(v120, v125 - v120, v_u_7)
				if v135 then
					v125 = v135.Position - 0.1 * (v125 - v120).unit
				end
			end
			p116[#p116 + 1] = v125
		else
			local v136 = Ray.new(v120, v125 - v120)
			local v137, v138, v139 = game.Workspace:FindPartOnRayWithIgnoreList(v136, { p115.char }, false, false)
			if v137 then
				local v140 = v138 + 0.1 * v139.unit
				local v141 = v140 - v120
				local v142 = v141:Cross(v126).unit:Cross(v139).unit
				local v143 = (v140 - p115.camera.CFrame.p).unit
				if v141.unit:Dot(-v142) < v141.unit:Dot(v143) then
					v125 = v_u_52(v140, v142, v125, v126)
					if v125.Magnitude > 0 then
						local v144 = Ray.new(v140, v125 - v140)
						local v145, v146, v147 = game.Workspace:FindPartOnRayWithIgnoreList(v144, { p115.char }, false, false)
						if v145 then
							v125 = v146 + 0.1 * v147.unit
						end
					else
						v125 = v140
					end
				else
					v125 = v140
				end
				local v148 = Ray.new(v120, v125 - v120)
				local v149, v150, _ = game.Workspace:FindPartOnRayWithIgnoreList(v148, { p115.char }, false, false)
				if v149 then
					v125 = v150 - 0.1 * (v125 - v120).unit
				end
			end
			p116[#p116 + 1] = v125
		end
	end
end
function v_u_54.CheckTorsoReference(p151)
	if p151.char then
		p151.torsoPart = p151.char:FindFirstChild("Torso")
		if not p151.torsoPart then
			p151.torsoPart = p151.char:FindFirstChild("UpperTorso")
			if not p151.torsoPart then
				p151.torsoPart = p151.char:FindFirstChild("HumanoidRootPart")
			end
		end
		p151.headPart = p151.char:FindFirstChild("Head")
	end
end
function v_u_54.CharacterAdded(p_u_152, p153, p154)
	-- upvalues: (copy) v_u_1, (copy) v_u_5
	if p154 == v_u_1.LocalPlayer then
		if p_u_152.childAddedConn then
			p_u_152.childAddedConn:Disconnect()
			p_u_152.childAddedConn = nil
		end
		if p_u_152.childRemovedConn then
			p_u_152.childRemovedConn:Disconnect()
			p_u_152.childRemovedConn = nil
		end
		p_u_152.char = p153
		p_u_152.trackedLimbs = {}
		local function v156(p155)
			-- upvalues: (ref) v_u_5, (copy) p_u_152
			if p155:IsA("BasePart") then
				if v_u_5[p155.Name] then
					p_u_152.trackedLimbs[p155] = true
				end
				if p155.Name == "Torso" or p155.Name == "UpperTorso" then
					p_u_152.torsoPart = p155
				end
				if p155.Name == "Head" then
					p_u_152.headPart = p155
				end
			end
		end
		p_u_152.childAddedConn = p153.ChildAdded:Connect(v156)
		p_u_152.childRemovedConn = p153.ChildRemoved:Connect(function(p157)
			-- upvalues: (copy) p_u_152
			p_u_152.trackedLimbs[p157] = nil
			p_u_152:CheckTorsoReference()
		end)
		for _, v158 in pairs(p_u_152.char:GetChildren()) do
			if v158:IsA("BasePart") then
				if v_u_5[v158.Name] then
					p_u_152.trackedLimbs[v158] = true
				end
				if v158.Name == "Torso" or v158.Name == "UpperTorso" then
					p_u_152.torsoPart = v158
				end
				if v158.Name == "Head" then
					p_u_152.headPart = v158
				end
			end
		end
	end
end
function v_u_54.SetMode(p159, p160)
	-- upvalues: (copy) v_u_16, (copy) v_u_4
	v_u_16(p160, "number")
	for _, v161 in pairs(v_u_4) do
		if v161 == p160 then
			p159.mode = p160
			p159.behaviorFunction = p159.behaviors[p159.mode]
			return
		end
	end
	error("Invalid mode number")
end
function v_u_54.GetObscuredParts(p162)
	return p162.savedHits
end
function v_u_54.Cleanup(p163)
	for v164, v165 in pairs(p163.savedHits) do
		v164.LocalTransparencyModifier = v165
	end
end
function v_u_54.Update(p_u_166, _, p167, p168)
	if not (p_u_166.enabled and p_u_166.char) then
		return p167, p168
	end
	p_u_166.camera = game.Workspace.CurrentCamera
	if not p_u_166.humanoidRootPart then
		local v169 = p_u_166.char:FindFirstChildOfClass("Humanoid")
		if v169 and v169.RootPart then
			p_u_166.humanoidRootPart = v169.RootPart
		else
			p_u_166.humanoidRootPart = p_u_166.char:FindFirstChild("HumanoidRootPart")
			if not p_u_166.humanoidRootPart then
				return p167, p168
			end
		end
		local v_u_170 = nil
		v_u_170 = p_u_166.humanoidRootPart.AncestryChanged:Connect(function(p171, p172)
			-- upvalues: (copy) p_u_166, (ref) v_u_170
			if p171 == p_u_166.humanoidRootPart and not p172 then
				p_u_166.humanoidRootPart = nil
				if v_u_170 and v_u_170.Connected then
					v_u_170:Disconnect()
					v_u_170 = nil
				end
			end
		end)
	end
	if not p_u_166.torsoPart then
		p_u_166:CheckTorsoReference()
		if not p_u_166.torsoPart then
			return p167, p168
		end
	end
	local v173 = {}
	p_u_166.behaviorFunction(p_u_166, v173)
	local v174 = { p_u_166.char }
	local v175 = p_u_166.headPart and p_u_166.headPart.CFrame.p or v173[1]
	local v176 = p_u_166.torsoPart and p_u_166.torsoPart.CFrame.p or v173[2]
	local v177 = p_u_166.camera:GetPartsObscuringTarget({ v175, v176 }, v174)
	local v178 = 0
	local v179 = {}
	local v180 = 0.75
	local v181 = {}
	local v182 = 0.75
	for v183 = 1, #v177 do
		local v184 = v177[v183]
		v178 = v178 + 1
		v179[v184] = true
		for _, v185 in pairs(v184:GetChildren()) do
			if v185:IsA("Decal") or v185:IsA("Texture") then
				v178 = v178 + 1
				break
			end
		end
	end
	if v178 > 0 then
		local v186 = 0.375 / v178 + 0.375
		local v187 = 1 / v178
		v180 = math.pow(v186, v187)
		local v188 = 0.25 / v178 + 0.25
		local v189 = 1 / v178
		v182 = math.pow(v188, v189)
	end
	local v190 = p_u_166.camera:GetPartsObscuringTarget(v173, v174)
	local v191 = {}
	for v192 = 1, #v190 do
		local v193 = v190[v192]
		v191[v193] = v179[v193] and v180 and v180 or v182
		if v193.Transparency < v191[v193] then
			v181[v193] = true
			if not p_u_166.savedHits[v193] then
				p_u_166.savedHits[v193] = v193.LocalTransparencyModifier
			end
		end
		for _, v194 in pairs(v193:GetChildren()) do
			if (v194:IsA("Decal") or v194:IsA("Texture")) and v194.Transparency < v191[v193] then
				v191[v194] = v191[v193]
				v181[v194] = true
				if not p_u_166.savedHits[v194] then
					p_u_166.savedHits[v194] = v194.LocalTransparencyModifier
				end
			end
		end
	end
	for v195, v196 in pairs(p_u_166.savedHits) do
		if v181[v195] then
			v195.LocalTransparencyModifier = v195.Transparency < 1 and ((v191[v195] - v195.Transparency) / (1 - v195.Transparency) or 0) or 0
		else
			v195.LocalTransparencyModifier = v196
			p_u_166.savedHits[v195] = nil
		end
	end
	return p167, p168
end
return v_u_54