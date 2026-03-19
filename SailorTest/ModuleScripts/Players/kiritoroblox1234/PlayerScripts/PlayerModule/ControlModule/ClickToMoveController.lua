local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding")
end)
local v_u_3 = v1 and v2
local v4, v5 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2")
end)
local v_u_6 = v4 and v5
local v_u_7 = game:GetService("UserInputService")
local v_u_8 = game:GetService("PathfindingService")
local v_u_9 = game:GetService("Players")
game:GetService("Debris")
local v_u_10 = game:GetService("StarterGui")
local v_u_11 = game:GetService("Workspace")
local v_u_12 = game:GetService("CollectionService")
local v_u_13 = game:GetService("GuiService")
local v14 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_15 = require(v14:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2")
local v_u_16 = true
local v_u_17 = true
local v_u_18 = false
local v_u_19 = 1
local v_u_20 = 8
local v_u_21 = {
	[Enum.KeyCode.W] = true,
	[Enum.KeyCode.A] = true,
	[Enum.KeyCode.S] = true,
	[Enum.KeyCode.D] = true,
	[Enum.KeyCode.Up] = true,
	[Enum.KeyCode.Down] = true
}
local v_u_22 = v_u_9.LocalPlayer
local v_u_23 = require(script.Parent:WaitForChild("ClickToMoveDisplay"))
local v_u_24 = RaycastParams.new()
v_u_24.FilterType = Enum.RaycastFilterType.Exclude
local v_u_25 = {}
if not v_u_15 then
	local function v_u_28(p26)
		-- upvalues: (copy) v_u_28
		if p26 then
			local v27 = p26:FindFirstChildOfClass("Humanoid")
			if v27 then
				return p26, v27
			else
				return v_u_28(p26.Parent)
			end
		else
			return
		end
	end
	v_u_25.FindCharacterAncestor = v_u_28
	local function v_u_39(p29, p30, p31)
		-- upvalues: (copy) v_u_11, (copy) v_u_28, (copy) v_u_39
		local v32 = p31 or {}
		local v33, v34, v35, v36 = v_u_11:FindPartOnRayWithIgnoreList(p29, v32)
		if not v33 then
			return nil, nil
		end
		if p30 and v33.CanCollide == false then
			local v37 = not v33 or v33:FindFirstChildOfClass("Humanoid")
			if not v37 then
				local v38
				v38, v37 = v_u_28(v33.Parent)
			end
			if v37 == nil then
				table.insert(v32, v33)
				return v_u_39(p29, p30, v32)
			end
		end
		return v33, v34, v35, v36
	end
	v_u_25.Raycast = v_u_39
end
local v_u_40 = {}
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = nil
local v_u_44 = nil
local function v_u_55(p45)
	-- upvalues: (ref) v_u_42, (ref) v_u_43, (ref) v_u_44, (ref) v_u_41, (copy) v_u_22, (copy) v_u_12
	if p45 ~= v_u_42 then
		if v_u_43 then
			v_u_43:Disconnect()
			v_u_43 = nil
		end
		if v_u_44 then
			v_u_44:Disconnect()
			v_u_44 = nil
		end
		v_u_42 = p45
		local v46 = {}
		local v47 = v_u_22
		if v47 then
			v47 = v_u_22.Character
		end
		__set_list(v46, 1, {v47})
		v_u_41 = v46
		if v_u_42 ~= nil then
			local v48 = v_u_12:GetTagged(v_u_42)
			for _, v49 in ipairs(v48) do
				local v50 = v_u_41
				table.insert(v50, v49)
			end
			v_u_43 = v_u_12:GetInstanceAddedSignal(v_u_42):Connect(function(p51)
				-- upvalues: (ref) v_u_41
				local v52 = v_u_41
				table.insert(v52, p51)
			end)
			v_u_44 = v_u_12:GetInstanceRemovedSignal(v_u_42):Connect(function(p53)
				-- upvalues: (ref) v_u_41
				for v54 = 1, #v_u_41 do
					if v_u_41[v54] == p53 then
						v_u_41[v54] = v_u_41[#v_u_41]
						table.remove(v_u_41)
						return
					end
				end
			end)
		end
	end
end
local function v_u_120(p56)
	if p56 == nil or p56.PrimaryPart == nil then
		return
	else
		assert(p56, "")
		local v57 = p56.PrimaryPart
		assert(v57, "")
		local v58 = p56.PrimaryPart.CFrame:Inverse()
		local v59 = Vector3.new(inf, inf, inf)
		local v60 = Vector3.new(-inf, -inf, -inf)
		for _, v61 in pairs(p56:GetDescendants()) do
			if v61:IsA("BasePart") and v61.CanCollide then
				local v62 = v58 * v61.CFrame
				local v63 = v61.Size.X / 2
				local v64 = v61.Size.Y / 2
				local v65 = v61.Size.Z / 2
				local v66 = Vector3.new(v63, v64, v65)
				local v67 = {}
				local v68 = v66.X
				local v69 = v66.Y
				local v70 = v66.Z
				local v71 = Vector3.new(v68, v69, v70)
				local v72 = v66.X
				local v73 = v66.Y
				local v74 = -v66.Z
				local v75 = Vector3.new(v72, v73, v74)
				local v76 = v66.X
				local v77 = -v66.Y
				local v78 = v66.Z
				local v79 = Vector3.new(v76, v77, v78)
				local v80 = v66.X
				local v81 = -v66.Y
				local v82 = -v66.Z
				local v83 = Vector3.new(v80, v81, v82)
				local v84 = -v66.X
				local v85 = v66.Y
				local v86 = v66.Z
				local v87 = Vector3.new(v84, v85, v86)
				local v88 = -v66.X
				local v89 = v66.Y
				local v90 = -v66.Z
				local v91 = Vector3.new(v88, v89, v90)
				local v92 = -v66.X
				local v93 = -v66.Y
				local v94 = v66.Z
				local v95 = Vector3.new(v92, v93, v94)
				local v96 = -v66.X
				local v97 = -v66.Y
				local v98 = -v66.Z
				__set_list(v67, 1, {v71, v75, v79, v83, v87, v91, v95, (Vector3.new(v96, v97, v98))})
				for _, v99 in ipairs(v67) do
					local v100 = v62 * v99
					local v101 = v59.X
					local v102 = v100.X
					local v103 = math.min(v101, v102)
					local v104 = v59.Y
					local v105 = v100.Y
					local v106 = math.min(v104, v105)
					local v107 = v59.Z
					local v108 = v100.Z
					local v109 = math.min(v107, v108)
					v59 = Vector3.new(v103, v106, v109)
					local v110 = v60.X
					local v111 = v100.X
					local v112 = math.max(v110, v111)
					local v113 = v60.Y
					local v114 = v100.Y
					local v115 = math.max(v113, v114)
					local v116 = v60.Z
					local v117 = v100.Z
					local v118 = math.max(v116, v117)
					v60 = Vector3.new(v112, v115, v118)
				end
			end
		end
		local v119 = v60 - v59
		if v119.X < 0 or (v119.Y < 0 or v119.Z < 0) then
			return nil
		else
			return v119
		end
	end
end
local function v_u_193(p121, p122, p123)
	-- upvalues: (ref) v_u_18, (copy) v_u_22, (copy) v_u_40, (ref) v_u_19, (copy) v_u_3, (copy) v_u_120, (copy) v_u_6, (copy) v_u_8, (ref) v_u_16, (copy) v_u_23, (ref) v_u_20, (copy) v_u_15, (copy) v_u_24, (ref) v_u_41, (copy) v_u_11
	local v_u_124 = {}
	local v125
	if p123 == nil then
		v125 = v_u_18
		p123 = true
	else
		v125 = p123
	end
	v_u_124.Cancelled = false
	v_u_124.Started = false
	v_u_124.Finished = Instance.new("BindableEvent")
	v_u_124.PathFailed = Instance.new("BindableEvent")
	v_u_124.PathComputing = false
	v_u_124.PathComputed = false
	v_u_124.OriginalTargetPoint = p121
	v_u_124.TargetPoint = p121
	v_u_124.TargetSurfaceNormal = p122
	v_u_124.DiedConn = nil
	v_u_124.SeatedConn = nil
	v_u_124.BlockedConn = nil
	v_u_124.TeleportedConn = nil
	v_u_124.CurrentPoint = 0
	v_u_124.HumanoidOffsetFromPath = Vector3.new(0, 0, 0)
	v_u_124.CurrentWaypointPosition = nil
	v_u_124.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
	v_u_124.CurrentWaypointPlaneDistance = 0
	v_u_124.CurrentWaypointNeedsJump = false
	v_u_124.CurrentHumanoidPosition = Vector3.new(0, 0, 0)
	v_u_124.CurrentHumanoidVelocity = 0
	v_u_124.NextActionMoveDirection = Vector3.new(0, 0, 0)
	v_u_124.NextActionJump = false
	v_u_124.Timeout = 0
	local v126 = v_u_22
	local v127
	if v126 then
		v127 = v126.Character
	else
		v127 = v126
	end
	local v128
	if v127 then
		v128 = v_u_40[v126]
		if not v128 or v128.Parent ~= v127 then
			v_u_40[v126] = nil
			v128 = v127:FindFirstChildOfClass("Humanoid")
			if v128 then
				v_u_40[v126] = v128
			end
		end
	else
		v128 = nil
	end
	v_u_124.Humanoid = v128
	v_u_124.OriginPoint = nil
	v_u_124.AgentCanFollowPath = false
	v_u_124.DirectPath = false
	v_u_124.DirectPathRiseFirst = false
	v_u_124.stopTraverseFunc = nil
	v_u_124.setPointFunc = nil
	v_u_124.pointList = nil
	local v129 = v_u_124.Humanoid
	if v129 then
		v129 = v_u_124.Humanoid.RootPart
	end
	if v129 then
		v_u_124.OriginPoint = v129.CFrame.Position
		local v130 = 2
		local v131 = 5
		local v132 = true
		local v133 = v_u_124.Humanoid.SeatPart
		if v133 and v133:IsA("VehicleSeat") then
			local v134 = v133:FindFirstAncestorOfClass("Model")
			if v134 then
				local v135 = v134.PrimaryPart
				v134.PrimaryPart = v133
				if p123 then
					local v136 = v134:GetExtentsSize()
					local v137 = v_u_19 * 0.5
					local v138 = v136.X * v136.X + v136.Z * v136.Z
					v130 = v137 * math.sqrt(v138)
					v131 = v_u_19 * v136.Y
					v_u_124.AgentCanFollowPath = true
					v_u_124.DirectPath = p123
					v132 = false
				end
				v134.PrimaryPart = v135
			end
		else
			local v139 = nil
			if v_u_3 then
				local v140 = v_u_22
				if v140 then
					v140 = v_u_22.Character
				end
				if v140 ~= nil then
					v139 = v_u_120(v140)
				end
			end
			if v139 == nil then
				local v141 = v_u_22
				if v141 then
					v141 = v_u_22.Character
				end
				v139 = v141:GetExtentsSize()
			end
			assert(v139, "")
			local v142 = v_u_19 * 0.5
			local v143 = v139.X * v139.X + v139.Z * v139.Z
			v130 = v142 * math.sqrt(v143)
			v131 = v_u_19 * v139.Y
			v132 = v_u_124.Humanoid.JumpPower > 0
			v_u_124.AgentCanFollowPath = true
			v_u_124.DirectPath = v125
			v_u_124.DirectPathRiseFirst = v_u_124.Humanoid.Sit
		end
		if v_u_6 then
			v_u_124.pathResult = v_u_8:CreatePath({
				["AgentRadius"] = v130,
				["AgentHeight"] = v131,
				["AgentCanJump"] = v132,
				["AgentCanClimb"] = true
			})
		else
			v_u_124.pathResult = v_u_8:CreatePath({
				["AgentRadius"] = v130,
				["AgentHeight"] = v131,
				["AgentCanJump"] = v132
			})
		end
	end
	function v_u_124.Cleanup(_)
		-- upvalues: (copy) v_u_124
		if v_u_124.stopTraverseFunc then
			v_u_124.stopTraverseFunc()
			v_u_124.stopTraverseFunc = nil
		end
		if v_u_124.BlockedConn then
			v_u_124.BlockedConn:Disconnect()
			v_u_124.BlockedConn = nil
		end
		if v_u_124.DiedConn then
			v_u_124.DiedConn:Disconnect()
			v_u_124.DiedConn = nil
		end
		if v_u_124.SeatedConn then
			v_u_124.SeatedConn:Disconnect()
			v_u_124.SeatedConn = nil
		end
		if v_u_124.TeleportedConn then
			v_u_124.TeleportedConn:Disconnect()
			v_u_124.TeleportedConn = nil
		end
		v_u_124.Started = false
	end
	function v_u_124.Cancel(_)
		-- upvalues: (copy) v_u_124
		v_u_124.Cancelled = true
		v_u_124:Cleanup()
	end
	function v_u_124.IsActive(_)
		-- upvalues: (copy) v_u_124
		local v144 = v_u_124.AgentCanFollowPath and v_u_124.Started
		if v144 then
			v144 = not v_u_124.Cancelled
		end
		return v144
	end
	function v_u_124.OnPathInterrupted(_)
		-- upvalues: (copy) v_u_124
		v_u_124.Cancelled = true
		v_u_124:OnPointReached(false)
	end
	function v_u_124.ComputePath(_)
		-- upvalues: (copy) v_u_124
		if v_u_124.OriginPoint then
			if v_u_124.PathComputed or v_u_124.PathComputing then
				return
			end
			v_u_124.PathComputing = true
			if v_u_124.AgentCanFollowPath then
				if v_u_124.DirectPath then
					v_u_124.pointList = { PathWaypoint.new(v_u_124.OriginPoint, Enum.PathWaypointAction.Walk), PathWaypoint.new(v_u_124.TargetPoint, v_u_124.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk) }
					v_u_124.PathComputed = true
				else
					v_u_124.pathResult:ComputeAsync(v_u_124.OriginPoint, v_u_124.TargetPoint)
					v_u_124.pointList = v_u_124.pathResult:GetWaypoints()
					v_u_124.BlockedConn = v_u_124.pathResult.Blocked:Connect(function(p145)
						-- upvalues: (ref) v_u_124
						v_u_124:OnPathBlocked(p145)
					end)
					v_u_124.PathComputed = v_u_124.pathResult.Status == Enum.PathStatus.Success
				end
			end
			v_u_124.PathComputing = false
		end
	end
	function v_u_124.IsValidPath(_)
		-- upvalues: (copy) v_u_124
		v_u_124:ComputePath()
		local v146 = v_u_124.PathComputed
		if v146 then
			v146 = v_u_124.AgentCanFollowPath
		end
		return v146
	end
	v_u_124.Recomputing = false
	function v_u_124.OnPathBlocked(_, p147)
		-- upvalues: (copy) v_u_124, (ref) v_u_16, (ref) v_u_23
		if v_u_124.CurrentPoint <= p147 and not v_u_124.Recomputing then
			v_u_124.Recomputing = true
			if v_u_124.stopTraverseFunc then
				v_u_124.stopTraverseFunc()
				v_u_124.stopTraverseFunc = nil
			end
			v_u_124.OriginPoint = v_u_124.Humanoid.RootPart.CFrame.p
			v_u_124.pathResult:ComputeAsync(v_u_124.OriginPoint, v_u_124.TargetPoint)
			v_u_124.pointList = v_u_124.pathResult:GetWaypoints()
			if #v_u_124.pointList > 0 then
				v_u_124.HumanoidOffsetFromPath = v_u_124.pointList[1].Position - v_u_124.OriginPoint
			end
			v_u_124.PathComputed = v_u_124.pathResult.Status == Enum.PathStatus.Success
			if v_u_16 then
				local v148 = v_u_124
				local v149 = v_u_124
				local v150, v151 = v_u_23.CreatePathDisplay(v_u_124.pointList)
				v148.stopTraverseFunc = v150
				v149.setPointFunc = v151
			end
			if v_u_124.PathComputed then
				v_u_124.CurrentPoint = 1
				v_u_124:OnPointReached(true)
			else
				v_u_124.PathFailed:Fire()
				v_u_124:Cleanup()
			end
			v_u_124.Recomputing = false
		end
	end
	function v_u_124.OnRenderStepped(_, p152)
		-- upvalues: (copy) v_u_124, (ref) v_u_20
		if v_u_124.Started and not v_u_124.Cancelled then
			v_u_124.Timeout = v_u_124.Timeout + p152
			if v_u_20 < v_u_124.Timeout then
				v_u_124:OnPointReached(false)
				return
			end
			v_u_124.CurrentHumanoidPosition = v_u_124.Humanoid.RootPart.Position + v_u_124.HumanoidOffsetFromPath
			v_u_124.CurrentHumanoidVelocity = v_u_124.Humanoid.RootPart.Velocity
			while v_u_124.Started and v_u_124:IsCurrentWaypointReached() do
				v_u_124:OnPointReached(true)
			end
			if v_u_124.Started then
				v_u_124.NextActionMoveDirection = v_u_124.CurrentWaypointPosition - v_u_124.CurrentHumanoidPosition
				if v_u_124.NextActionMoveDirection.Magnitude > 1e-6 then
					v_u_124.NextActionMoveDirection = v_u_124.NextActionMoveDirection.Unit
				else
					v_u_124.NextActionMoveDirection = Vector3.new(0, 0, 0)
				end
				if v_u_124.CurrentWaypointNeedsJump then
					v_u_124.NextActionJump = true
					v_u_124.CurrentWaypointNeedsJump = false
					return
				end
				v_u_124.NextActionJump = false
			end
		end
	end
	function v_u_124.IsCurrentWaypointReached(_)
		-- upvalues: (copy) v_u_124
		local v153
		if v_u_124.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) then
			v153 = true
		else
			local v154 = v_u_124.CurrentWaypointPlaneNormal:Dot(v_u_124.CurrentHumanoidPosition) - v_u_124.CurrentWaypointPlaneDistance
			local v155 = 0.0625 * -v_u_124.CurrentWaypointPlaneNormal:Dot(v_u_124.CurrentHumanoidVelocity)
			v153 = v154 < math.max(1, v155)
		end
		if v153 then
			v_u_124.CurrentWaypointPosition = nil
			v_u_124.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
			v_u_124.CurrentWaypointPlaneDistance = 0
		end
		return v153
	end
	function v_u_124.OnPointReached(_, p156)
		-- upvalues: (copy) v_u_124
		if p156 and not v_u_124.Cancelled then
			if v_u_124.setPointFunc then
				v_u_124.setPointFunc(v_u_124.CurrentPoint)
			end
			local v157 = v_u_124.CurrentPoint + 1
			if #v_u_124.pointList < v157 then
				if v_u_124.stopTraverseFunc then
					v_u_124.stopTraverseFunc()
				end
				v_u_124.Finished:Fire()
				v_u_124:Cleanup()
			else
				local v158 = v_u_124.pointList[v_u_124.CurrentPoint]
				local v159 = v_u_124.pointList[v157]
				local v160 = v_u_124.Humanoid:GetState()
				if (v160 == Enum.HumanoidStateType.FallingDown or v160 == Enum.HumanoidStateType.Freefall) and true or v160 == Enum.HumanoidStateType.Jumping then
					local v161 = v159.Action == Enum.PathWaypointAction.Jump
					if not v161 and v_u_124.CurrentPoint > 1 then
						local v162 = v_u_124.pointList[v_u_124.CurrentPoint - 1]
						local v163 = v158.Position - v162.Position
						local v164 = v159.Position - v158.Position
						v161 = Vector2.new(v163.x, v163.z).Unit:Dot(Vector2.new(v164.x, v164.z).Unit) < 0.996
					end
					if v161 then
						v_u_124.Humanoid.FreeFalling:Wait()
						wait(0.1)
					end
				end
				v_u_124:MoveToNextWayPoint(v158, v159, v157)
			end
		else
			v_u_124.PathFailed:Fire()
			v_u_124:Cleanup()
			return
		end
	end
	function v_u_124.MoveToNextWayPoint(_, p165, p166, p167)
		-- upvalues: (copy) v_u_124, (ref) v_u_6
		v_u_124.CurrentWaypointPlaneNormal = p165.Position - p166.Position
		if not v_u_6 or p166.Label ~= "Climb" then
			local v168 = v_u_124
			local v169 = v_u_124.CurrentWaypointPlaneNormal.X
			local v170 = v_u_124.CurrentWaypointPlaneNormal.Z
			v168.CurrentWaypointPlaneNormal = Vector3.new(v169, 0, v170)
		end
		if v_u_124.CurrentWaypointPlaneNormal.Magnitude > 1e-6 then
			v_u_124.CurrentWaypointPlaneNormal = v_u_124.CurrentWaypointPlaneNormal.Unit
			v_u_124.CurrentWaypointPlaneDistance = v_u_124.CurrentWaypointPlaneNormal:Dot(p166.Position)
		else
			v_u_124.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
			v_u_124.CurrentWaypointPlaneDistance = 0
		end
		v_u_124.CurrentWaypointNeedsJump = p166.Action == Enum.PathWaypointAction.Jump
		v_u_124.CurrentWaypointPosition = p166.Position
		v_u_124.CurrentPoint = p167
		v_u_124.Timeout = 0
	end
	function v_u_124.Start(_, p171)
		-- upvalues: (copy) v_u_124, (ref) v_u_23, (ref) v_u_16
		if v_u_124.AgentCanFollowPath then
			if v_u_124.Started then
				return
			else
				v_u_124.Started = true
				v_u_23.CancelFailureAnimation()
				if v_u_16 and (p171 == nil or p171) then
					local v172 = v_u_124
					local v173 = v_u_124
					local v174, v175 = v_u_23.CreatePathDisplay(v_u_124.pointList, v_u_124.OriginalTargetPoint)
					v172.stopTraverseFunc = v174
					v173.setPointFunc = v175
				end
				if #v_u_124.pointList > 0 then
					local v176 = v_u_124
					local v177 = v_u_124.pointList[1].Position.Y - v_u_124.OriginPoint.Y
					v176.HumanoidOffsetFromPath = Vector3.new(0, v177, 0)
					v_u_124.CurrentHumanoidPosition = v_u_124.Humanoid.RootPart.Position + v_u_124.HumanoidOffsetFromPath
					v_u_124.CurrentHumanoidVelocity = v_u_124.Humanoid.RootPart.Velocity
					v_u_124.SeatedConn = v_u_124.Humanoid.Seated:Connect(function(_, _)
						-- upvalues: (ref) v_u_124
						v_u_124:OnPathInterrupted()
					end)
					v_u_124.DiedConn = v_u_124.Humanoid.Died:Connect(function()
						-- upvalues: (ref) v_u_124
						v_u_124:OnPathInterrupted()
					end)
					v_u_124.TeleportedConn = v_u_124.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function()
						-- upvalues: (ref) v_u_124
						v_u_124:OnPathInterrupted()
					end)
					v_u_124.CurrentPoint = 1
					v_u_124:OnPointReached(true)
				else
					v_u_124.PathFailed:Fire()
					if v_u_124.stopTraverseFunc then
						v_u_124.stopTraverseFunc()
					end
				end
			end
		else
			v_u_124.PathFailed:Fire()
			return
		end
	end
	local v178 = v_u_124.TargetPoint + v_u_124.TargetSurfaceNormal * 1.5
	if v_u_15 then
		local v179 = v_u_24
		local v180
		if v_u_41 then
			v180 = v_u_41
		else
			v_u_41 = {}
			local v181 = v_u_41
			assert(v181, "")
			local v182 = v_u_41
			local v183 = v_u_22
			if v183 then
				v183 = v_u_22.Character
			end
			table.insert(v182, v183)
			v180 = v_u_41
		end
		v179.FilterDescendantsInstances = v180
		local v184 = v_u_11:Raycast(v178, Vector3.new(-0, -50, -0), v_u_24)
		if v184 then
			v_u_124.TargetPoint = v184.Position
		end
	else
		local v185 = Ray.new(v178, Vector3.new(0, -50, 0))
		local v186 = v_u_11
		local v187
		if v_u_41 then
			v187 = v_u_41
		else
			v_u_41 = {}
			local v188 = v_u_41
			assert(v188, "")
			local v189 = v_u_41
			local v190 = v_u_22
			if v190 then
				v190 = v_u_22.Character
			end
			table.insert(v189, v190)
			v187 = v_u_41
		end
		local v191, v192 = v186:FindPartOnRayWithIgnoreList(v185, v187)
		if v191 then
			v_u_124.TargetPoint = v192
		end
	end
	v_u_124:ComputePath()
	return v_u_124
end
local function v_u_196(p194)
	if p194 ~= nil then
		for _, v195 in pairs(p194:GetChildren()) do
			if v195:IsA("Tool") then
				return v195
			end
		end
	end
end
local v_u_197 = nil
local v_u_198 = nil
local v_u_199 = nil
local function v_u_208(p200, p_u_201, p_u_202, p_u_203, p_u_204)
	-- upvalues: (ref) v_u_197, (ref) v_u_198, (ref) v_u_199, (copy) v_u_196, (ref) v_u_17, (copy) v_u_23
	if v_u_197 then
		if v_u_197 then
			v_u_197:Cancel()
			v_u_197 = nil
		end
		if v_u_198 then
			v_u_198:Disconnect()
			v_u_198 = nil
		end
		if v_u_199 then
			v_u_199:Disconnect()
			v_u_199 = nil
		end
	end
	v_u_197 = p200
	p200:Start(p_u_204)
	v_u_198 = p200.Finished.Event:Connect(function()
		-- upvalues: (ref) v_u_197, (ref) v_u_198, (ref) v_u_199, (copy) p_u_202, (ref) v_u_196, (copy) p_u_203
		if v_u_197 then
			v_u_197:Cancel()
			v_u_197 = nil
		end
		if v_u_198 then
			v_u_198:Disconnect()
			v_u_198 = nil
		end
		if v_u_199 then
			v_u_199:Disconnect()
			v_u_199 = nil
		end
		local v205 = p_u_202 and v_u_196(p_u_203)
		if v205 then
			v205:Activate()
		end
	end)
	v_u_199 = p200.PathFailed.Event:Connect(function()
		-- upvalues: (ref) v_u_197, (ref) v_u_198, (ref) v_u_199, (copy) p_u_204, (ref) v_u_17, (ref) v_u_23, (copy) p_u_201
		if v_u_197 then
			v_u_197:Cancel()
			v_u_197 = nil
		end
		if v_u_198 then
			v_u_198:Disconnect()
			v_u_198 = nil
		end
		if v_u_199 then
			v_u_199:Disconnect()
			v_u_199 = nil
		end
		if p_u_204 == nil or p_u_204 then
			local v206 = v_u_17
			if v206 then
				local v207 = v_u_197
				if v207 then
					v207 = v_u_197:IsActive()
				end
				v206 = not v207
			end
			if v206 then
				v_u_23.PlayFailureAnimation()
			end
			v_u_23.DisplayFailureWaypoint(p_u_201)
		end
	end)
end
function OnTap(p209, p210, p211)
	-- upvalues: (copy) v_u_11, (copy) v_u_22, (copy) v_u_40, (copy) v_u_15, (ref) v_u_41, (copy) v_u_24, (copy) v_u_10, (copy) v_u_9, (ref) v_u_197, (ref) v_u_198, (ref) v_u_199, (copy) v_u_193, (copy) v_u_208, (ref) v_u_17, (copy) v_u_23, (copy) v_u_25, (copy) v_u_196
	local v212 = v_u_11.CurrentCamera
	local v213 = v_u_22.Character
	local v214 = v_u_22
	local v215
	if v214 then
		v215 = v214.Character
	else
		v215 = v214
	end
	local v216
	if v215 then
		v216 = v_u_40[v214]
		if not v216 or v216.Parent ~= v215 then
			v_u_40[v214] = nil
			v216 = v215:FindFirstChildOfClass("Humanoid")
			if v216 then
				v_u_40[v214] = v216
			end
		end
	else
		v216 = nil
	end
	local v217
	if v216 == nil then
		v217 = false
	else
		v217 = v216.Health > 0
	end
	if not v217 then
		return
	end
	if #p209 ~= 1 and not p210 then
		local v218 = #p209 >= 2 and (v212 and v_u_196(v213))
		if v218 then
			v218:Activate()
		end
		goto l21
	end
	if not v212 then
		::l21::
		return
	end
	local v219 = v212:ScreenPointToRay(p209[1].X, p209[1].Y)
	if not v_u_15 then
		local v220 = Ray.new(v219.Origin, v219.Direction * 1000)
		local v221 = v_u_25.Raycast
		local v222 = true
		local v223
		if v_u_41 then
			v223 = v_u_41
		else
			v_u_41 = {}
			local v224 = v_u_41
			assert(v224, "")
			local v225 = v_u_41
			local v226 = v_u_22
			if v226 then
				v226 = v_u_22.Character
			end
			table.insert(v225, v226)
			v223 = v_u_41
		end
		local v227, v228, v229 = v221(v220, v222, v223)
		local v230, v231 = v_u_25.FindCharacterAncestor(v227)
		if p211 and (v231 and (v_u_10:GetCore("AvatarContextMenuEnabled") and v_u_9:GetPlayerFromCharacter(v231.Parent))) then
			if v_u_197 then
				v_u_197:Cancel()
				v_u_197 = nil
			end
			if v_u_198 then
				v_u_198:Disconnect()
				v_u_198 = nil
			end
			if v_u_199 then
				v_u_199:Disconnect()
				v_u_199 = nil
			end
			return
		end
		if p210 then
			v230 = nil
		else
			p210 = v228
		end
		if p210 and v213 then
			if v_u_197 then
				v_u_197:Cancel()
				v_u_197 = nil
			end
			if v_u_198 then
				v_u_198:Disconnect()
				v_u_198 = nil
			end
			if v_u_199 then
				v_u_199:Disconnect()
				v_u_199 = nil
			end
			local v232 = v_u_193(p210, v229)
			if v232:IsValidPath() then
				v_u_208(v232, p210, v230, v213)
			else
				v232:Cleanup()
				if v_u_197 and v_u_197:IsActive() then
					v_u_197:Cancel()
				end
				if v_u_17 then
					v_u_23.PlayFailureAnimation()
				end
				v_u_23.DisplayFailureWaypoint(p210)
			end
		end
		goto l21
	end
	local v233 = nil
	local v234 = nil
	local v235
	if v_u_41 then
		v235 = v_u_41
	else
		v_u_41 = {}
		local v236 = v_u_41
		assert(v236, "")
		local v237 = v_u_41
		local v238 = v_u_22
		if v238 then
			v238 = v_u_22.Character
		end
		table.insert(v237, v238)
		v235 = v_u_41
	end
	if not v235 then
		v235 = {}
	end
	while true do
		local v239 = true
		v_u_24.FilterDescendantsInstances = v235
		local v240 = v_u_11:Raycast(v219.Origin, v219.Direction * 1000, v_u_24)
		if v240 then
			local v241 = v240.Instance
			if not v241.CanCollide then
				while true do
					v233 = v241:FindFirstChildOfClass("Humanoid")
					local v242 = v241.Parent
					if v233 or not v242 then
						break
					end
					v241 = v242
				end
				if v233 or not v242 then
					v234 = v241
				else
					table.insert(v235, v242)
					v239 = false
					v234 = nil
				end
				goto l32
			end
		end
		::l32::
		if v239 then
			if p211 and (v233 and (v_u_10:GetCore("AvatarContextMenuEnabled") and v_u_9:GetPlayerFromCharacter(v233.Parent))) then
				if v_u_197 then
					v_u_197:Cancel()
					v_u_197 = nil
				end
				if v_u_198 then
					v_u_198:Disconnect()
					v_u_198 = nil
				end
				if v_u_199 then
					v_u_199:Disconnect()
					v_u_199 = nil
				end
				return
			elseif v240 and v213 then
				local v243 = v240.Position
				if p210 then
					v234 = nil
				else
					p210 = v243
				end
				if v_u_197 then
					v_u_197:Cancel()
					v_u_197 = nil
				end
				if v_u_198 then
					v_u_198:Disconnect()
					v_u_198 = nil
				end
				if v_u_199 then
					v_u_199:Disconnect()
					v_u_199 = nil
				end
				local v244 = v_u_193(p210, v240.Normal)
				if v244:IsValidPath() then
					v_u_208(v244, p210, v234, v213)
				else
					v244:Cleanup()
					if v_u_197 and v_u_197:IsActive() then
						v_u_197:Cancel()
					end
					if v_u_17 then
						v_u_23.PlayFailureAnimation()
					end
					v_u_23.DisplayFailureWaypoint(p210)
				end
			else
				return
			end
		end
	end
end
local v_u_245 = require(script.Parent:WaitForChild("Keyboard"))
local v_u_246 = setmetatable({}, v_u_245)
v_u_246.__index = v_u_246
function v_u_246.new(p247)
	-- upvalues: (copy) v_u_245, (copy) v_u_246
	local v248 = v_u_245.new(p247)
	local v249 = v_u_246
	local v250 = setmetatable(v248, v249)
	v250.fingerTouches = {}
	v250.numUnsunkTouches = 0
	v250.mouse2DownTime = tick()
	v250.mouse2DownPos = Vector2.new()
	v250.mouse2UpTime = tick()
	v250.keyboardMoveVector = Vector3.new(0, 0, 0)
	v250.tapConn = nil
	v250.inputBeganConn = nil
	v250.inputChangedConn = nil
	v250.inputEndedConn = nil
	v250.humanoidDiedConn = nil
	v250.characterChildAddedConn = nil
	v250.onCharacterAddedConn = nil
	v250.characterChildRemovedConn = nil
	v250.renderSteppedConn = nil
	v250.menuOpenedConnection = nil
	v250.preferredInputChangedConnection = nil
	v250.running = false
	v250.wasdEnabled = false
	return v250
end
function v_u_246.DisconnectEvents(p251)
	local v252 = p251.tapConn
	if v252 then
		v252:Disconnect()
	end
	local v253 = p251.inputBeganConn
	if v253 then
		v253:Disconnect()
	end
	local v254 = p251.inputChangedConn
	if v254 then
		v254:Disconnect()
	end
	local v255 = p251.inputEndedConn
	if v255 then
		v255:Disconnect()
	end
	local v256 = p251.humanoidDiedConn
	if v256 then
		v256:Disconnect()
	end
	local v257 = p251.characterChildAddedConn
	if v257 then
		v257:Disconnect()
	end
	local v258 = p251.onCharacterAddedConn
	if v258 then
		v258:Disconnect()
	end
	local v259 = p251.renderSteppedConn
	if v259 then
		v259:Disconnect()
	end
	local v260 = p251.characterChildRemovedConn
	if v260 then
		v260:Disconnect()
	end
	local v261 = p251.menuOpenedConnection
	if v261 then
		v261:Disconnect()
	end
	local v262 = p251.preferredInputChangedConnection
	if v262 then
		v262:Disconnect()
	end
end
function v_u_246.OnTouchBegan(p263, p264, p265)
	if p263.fingerTouches[p264] == nil and not p265 then
		p263.numUnsunkTouches = p263.numUnsunkTouches + 1
	end
	p263.fingerTouches[p264] = p265
end
function v_u_246.OnTouchChanged(p266, p267, p268)
	if p266.fingerTouches[p267] == nil then
		p266.fingerTouches[p267] = p268
		if not p268 then
			p266.numUnsunkTouches = p266.numUnsunkTouches + 1
		end
	end
end
function v_u_246.OnTouchEnded(p269, p270, _)
	if p269.fingerTouches[p270] ~= nil and p269.fingerTouches[p270] == false then
		p269.numUnsunkTouches = p269.numUnsunkTouches - 1
	end
	p269.fingerTouches[p270] = nil
end
function v_u_246.OnPreferredInputChanged(_)
	-- upvalues: (copy) v_u_22, (copy) v_u_7
	local v271 = v_u_22.Character
	if v271 then
		local v272 = v_u_7.PreferredInput == Enum.PreferredInput.Touch
		for _, v273 in pairs(v271:GetChildren()) do
			if v273:IsA("Tool") then
				v273.ManualActivationOnly = v272
			end
		end
	end
end
function v_u_246.OnCharacterAdded(p_u_274, p275)
	-- upvalues: (copy) v_u_7, (copy) v_u_21, (ref) v_u_197, (ref) v_u_198, (ref) v_u_199, (copy) v_u_23, (copy) v_u_13
	p_u_274:DisconnectEvents()
	p_u_274.inputBeganConn = v_u_7.InputBegan:Connect(function(p276, p277)
		-- upvalues: (copy) p_u_274, (ref) v_u_21, (ref) v_u_197, (ref) v_u_198, (ref) v_u_199, (ref) v_u_23
		if p276.UserInputType == Enum.UserInputType.Touch then
			p_u_274:OnTouchBegan(p276, p277)
		end
		if p_u_274.wasdEnabled and (p277 == false and (p276.UserInputType == Enum.UserInputType.Keyboard and v_u_21[p276.KeyCode])) then
			if v_u_197 then
				v_u_197:Cancel()
				v_u_197 = nil
			end
			if v_u_198 then
				v_u_198:Disconnect()
				v_u_198 = nil
			end
			if v_u_199 then
				v_u_199:Disconnect()
				v_u_199 = nil
			end
			v_u_23.CancelFailureAnimation()
		end
		if p276.UserInputType == Enum.UserInputType.MouseButton2 then
			p_u_274.mouse2DownTime = tick()
			p_u_274.mouse2DownPos = p276.Position
		end
	end)
	p_u_274.inputChangedConn = v_u_7.InputChanged:Connect(function(p278, p279)
		-- upvalues: (copy) p_u_274
		if p278.UserInputType == Enum.UserInputType.Touch then
			p_u_274:OnTouchChanged(p278, p279)
		end
	end)
	p_u_274.inputEndedConn = v_u_7.InputEnded:Connect(function(p280, p281)
		-- upvalues: (copy) p_u_274, (ref) v_u_197
		if p280.UserInputType == Enum.UserInputType.Touch then
			p_u_274:OnTouchEnded(p280, p281)
		end
		if p280.UserInputType == Enum.UserInputType.MouseButton2 then
			p_u_274.mouse2UpTime = tick()
			local v282 = p280.Position
			local v283 = v_u_197 or p_u_274.keyboardMoveVector.Magnitude <= 0
			if p_u_274.mouse2UpTime - p_u_274.mouse2DownTime < 0.25 and ((v282 - p_u_274.mouse2DownPos).magnitude < 5 and v283) then
				OnTap({ v282 })
			end
		end
	end)
	p_u_274.tapConn = v_u_7.TouchTap:Connect(function(p284, p285)
		if not p285 then
			OnTap(p284, nil, true)
		end
	end)
	p_u_274.menuOpenedConnection = v_u_13.MenuOpened:Connect(function()
		-- upvalues: (ref) v_u_197, (ref) v_u_198, (ref) v_u_199
		if v_u_197 then
			v_u_197:Cancel()
			v_u_197 = nil
		end
		if v_u_198 then
			v_u_198:Disconnect()
			v_u_198 = nil
		end
		if v_u_199 then
			v_u_199:Disconnect()
			v_u_199 = nil
		end
	end)
	local function v_u_288(p286)
		-- upvalues: (ref) v_u_7, (copy) p_u_274
		if v_u_7.PreferredInput == Enum.PreferredInput.Touch and p286:IsA("Tool") then
			p286.ManualActivationOnly = true
		end
		if p286:IsA("Humanoid") then
			local v287 = p_u_274.humanoidDiedConn
			if v287 then
				v287:Disconnect()
			end
			p_u_274.humanoidDiedConn = p286.Died:Connect(function() end)
		end
	end
	p_u_274.characterChildAddedConn = p275.ChildAdded:Connect(function(p289)
		-- upvalues: (copy) v_u_288
		v_u_288(p289)
	end)
	p_u_274.characterChildRemovedConn = p275.ChildRemoved:Connect(function(p290)
		-- upvalues: (ref) v_u_7
		if v_u_7.PreferredInput == Enum.PreferredInput.Touch and p290:IsA("Tool") then
			p290.ManualActivationOnly = false
		end
	end)
	for _, v291 in pairs(p275:GetChildren()) do
		v_u_288(v291)
	end
	p_u_274.preferredInputChangedConnection = v_u_7:GetPropertyChangedSignal("PreferredInput"):Connect(function()
		-- upvalues: (copy) p_u_274
		p_u_274:OnPreferredInputChanged()
	end)
end
function v_u_246.Start(p292)
	p292:Enable(true)
end
function v_u_246.Stop(p293)
	p293:Enable(false)
end
function v_u_246.CleanupPath(_)
	-- upvalues: (ref) v_u_197, (ref) v_u_198, (ref) v_u_199
	if v_u_197 then
		v_u_197:Cancel()
		v_u_197 = nil
	end
	if v_u_198 then
		v_u_198:Disconnect()
		v_u_198 = nil
	end
	if v_u_199 then
		v_u_199:Disconnect()
		v_u_199 = nil
	end
end
function v_u_246.Enable(p_u_294, p295, p296, p297)
	-- upvalues: (copy) v_u_22, (ref) v_u_197, (ref) v_u_198, (ref) v_u_199, (copy) v_u_7, (copy) v_u_245
	if p295 then
		if not p_u_294.running then
			if v_u_22.Character then
				p_u_294:OnCharacterAdded(v_u_22.Character)
			end
			p_u_294.onCharacterAddedConn = v_u_22.CharacterAdded:Connect(function(p298)
				-- upvalues: (copy) p_u_294
				p_u_294:OnCharacterAdded(p298)
			end)
			p_u_294.running = true
		end
		p_u_294.touchJumpController = p297
		if p_u_294.touchJumpController then
			p_u_294.touchJumpController:Enable(p_u_294.jumpEnabled)
		end
	else
		if p_u_294.running then
			p_u_294:DisconnectEvents()
			if v_u_197 then
				v_u_197:Cancel()
				v_u_197 = nil
			end
			if v_u_198 then
				v_u_198:Disconnect()
				v_u_198 = nil
			end
			if v_u_199 then
				v_u_199:Disconnect()
				v_u_199 = nil
			end
			if v_u_7.PreferredInput == Enum.PreferredInput.Touch then
				local v299 = v_u_22.Character
				if v299 then
					for _, v300 in pairs(v299:GetChildren()) do
						if v300:IsA("Tool") then
							v300.ManualActivationOnly = false
						end
					end
				end
			end
			p_u_294.running = false
		end
		if p_u_294.touchJumpController and not p_u_294.jumpEnabled then
			p_u_294.touchJumpController:Enable(true)
		end
		p_u_294.touchJumpController = nil
	end
	v_u_245.Enable(p_u_294, p295)
	p_u_294.wasdEnabled = p295 and p296 and p296 or false
	p_u_294.enabled = p295
end
function v_u_246.OnRenderStepped(p301, p302)
	-- upvalues: (ref) v_u_197
	p301.isJumping = false
	if v_u_197 then
		v_u_197:OnRenderStepped(p302)
		if v_u_197 then
			p301.moveVector = v_u_197.NextActionMoveDirection
			p301.moveVectorIsCameraRelative = false
			if v_u_197.NextActionJump then
				p301.isJumping = true
			end
		else
			p301.moveVector = p301.keyboardMoveVector
			p301.moveVectorIsCameraRelative = true
		end
	else
		p301.moveVector = p301.keyboardMoveVector
		p301.moveVectorIsCameraRelative = true
	end
	if p301.jumpRequested then
		p301.isJumping = true
	end
end
function v_u_246.UpdateMovement(p303, p304)
	if p304 == Enum.UserInputState.Cancel then
		p303.keyboardMoveVector = Vector3.new(0, 0, 0)
	elseif p303.wasdEnabled then
		local v305 = p303.leftValue + p303.rightValue
		local v306 = p303.forwardValue + p303.backwardValue
		p303.keyboardMoveVector = Vector3.new(v305, 0, v306)
	end
end
function v_u_246.UpdateJump(_) end
function v_u_246.SetShowPath(_, p307)
	-- upvalues: (ref) v_u_16
	v_u_16 = p307
end
function v_u_246.GetShowPath(_)
	-- upvalues: (ref) v_u_16
	return v_u_16
end
function v_u_246.SetWaypointTexture(_, p308)
	-- upvalues: (copy) v_u_23
	v_u_23.SetWaypointTexture(p308)
end
function v_u_246.GetWaypointTexture(_)
	-- upvalues: (copy) v_u_23
	return v_u_23.GetWaypointTexture()
end
function v_u_246.SetWaypointRadius(_, p309)
	-- upvalues: (copy) v_u_23
	v_u_23.SetWaypointRadius(p309)
end
function v_u_246.GetWaypointRadius(_)
	-- upvalues: (copy) v_u_23
	return v_u_23.GetWaypointRadius()
end
function v_u_246.SetEndWaypointTexture(_, p310)
	-- upvalues: (copy) v_u_23
	v_u_23.SetEndWaypointTexture(p310)
end
function v_u_246.GetEndWaypointTexture(_)
	-- upvalues: (copy) v_u_23
	return v_u_23.GetEndWaypointTexture()
end
function v_u_246.SetWaypointsAlwaysOnTop(_, p311)
	-- upvalues: (copy) v_u_23
	v_u_23.SetWaypointsAlwaysOnTop(p311)
end
function v_u_246.GetWaypointsAlwaysOnTop(_)
	-- upvalues: (copy) v_u_23
	return v_u_23.GetWaypointsAlwaysOnTop()
end
function v_u_246.SetFailureAnimationEnabled(_, p312)
	-- upvalues: (ref) v_u_17
	v_u_17 = p312
end
function v_u_246.GetFailureAnimationEnabled(_)
	-- upvalues: (ref) v_u_17
	return v_u_17
end
function v_u_246.SetIgnoredPartsTag(_, p313)
	-- upvalues: (copy) v_u_55
	v_u_55(p313)
end
function v_u_246.GetIgnoredPartsTag(_)
	-- upvalues: (ref) v_u_42
	return v_u_42
end
function v_u_246.SetUseDirectPath(_, p314)
	-- upvalues: (ref) v_u_18
	v_u_18 = p314
end
function v_u_246.GetUseDirectPath(_)
	-- upvalues: (ref) v_u_18
	return v_u_18
end
function v_u_246.SetAgentSizeIncreaseFactor(_, p315)
	-- upvalues: (ref) v_u_19
	v_u_19 = p315 / 100 + 1
end
function v_u_246.GetAgentSizeIncreaseFactor(_)
	-- upvalues: (ref) v_u_19
	return (v_u_19 - 1) * 100
end
function v_u_246.SetUnreachableWaypointTimeout(_, p316)
	-- upvalues: (ref) v_u_20
	v_u_20 = p316
end
function v_u_246.GetUnreachableWaypointTimeout(_)
	-- upvalues: (ref) v_u_20
	return v_u_20
end
function v_u_246.SetUserJumpEnabled(p317, p318)
	p317.jumpEnabled = p318
	if p317.touchJumpController then
		p317.touchJumpController:Enable(p318)
	end
end
function v_u_246.GetUserJumpEnabled(p319)
	return p319.jumpEnabled
end
function v_u_246.MoveTo(_, p320, p321, p322)
	-- upvalues: (copy) v_u_22, (copy) v_u_193, (copy) v_u_208
	local v323 = v_u_22.Character
	if v323 == nil then
		return false
	end
	local v324 = v_u_193(p320, Vector3.new(0, 1, 0), p322)
	if not (v324 and v324:IsValidPath()) then
		return false
	end
	v_u_208(v324, p320, nil, v323, p321)
	return true
end
return v_u_246