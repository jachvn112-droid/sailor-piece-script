local v1 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_2 = require(v1:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2")
local v_u_3 = RaycastParams.new()
v_u_3.FilterType = Enum.RaycastFilterType.Exclude
local v_u_4 = {
	["spacing"] = 8,
	["image"] = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
	["imageSize"] = Vector2.new(2, 2)
}
local v_u_5 = Instance.new("Model")
v_u_5.Name = "PathDisplayPoints"
local v6 = Instance.new("Part")
v6.Anchored = true
v6.CanCollide = false
v6.Transparency = 1
v6.Name = "PathDisplayAdornee"
v6.CFrame = CFrame.new(0, 0, 0)
v6.Parent = v_u_5
local v_u_7 = 30
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = {}
for v11 = 1, v_u_7 do
	local v12 = Instance.new("ImageHandleAdornment")
	v12.Archivable = false
	v12.Adornee = v6
	v12.Image = v_u_4.image
	v12.Size = v_u_4.imageSize
	v_u_8[v11] = v12
end
local function v_u_22(p13, _)
	-- upvalues: (ref) v_u_7, (copy) v_u_8, (copy) v_u_2, (copy) v_u_3, (copy) v_u_5
	if v_u_7 == 0 then
		return nil
	else
		local v14 = v_u_8[1]
		if v14 then
			local v15 = v_u_8
			local v16 = v_u_7
			v_u_8[1] = v_u_8[v_u_7]
			v15[v16] = nil
			v_u_7 = v_u_7 - 1
		else
			v14 = nil
		end
		if v_u_2 then
			v_u_3.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, workspace.CurrentCamera }
			local v17 = workspace:Raycast(p13 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0), v_u_3)
			if not v17 then
				return nil
			end
			v14.CFrame = CFrame.lookAlong(v17.Position, v17.Normal)
			v14.Parent = v_u_5
			return v14
		else
			local v18 = Ray.new(p13 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0))
			local v19, v20, v21 = workspace:FindPartOnRayWithIgnoreList(v18, { game.Players.LocalPlayer.Character, workspace.CurrentCamera })
			if not v19 then
				return nil
			end
			v14.CFrame = CFrame.new(v20, v20 + v21)
			v14.Parent = v_u_5
			return v14
		end
	end
end
function v_u_4.setCurrentPoints(p23)
	-- upvalues: (ref) v_u_9
	if typeof(p23) == "table" then
		v_u_9 = p23
	else
		v_u_9 = {}
	end
end
function v_u_4.clearRenderedPath()
	-- upvalues: (ref) v_u_10, (ref) v_u_7, (copy) v_u_8, (copy) v_u_5
	for _, v24 in ipairs(v_u_10) do
		v24.Parent = nil
		v_u_7 = v_u_7 + 1
		v_u_8[v_u_7] = v24
	end
	v_u_10 = {}
	v_u_5.Parent = nil
end
function v_u_4.renderPath()
	-- upvalues: (copy) v_u_4, (ref) v_u_9, (ref) v_u_10, (copy) v_u_22, (copy) v_u_5
	v_u_4.clearRenderedPath()
	if v_u_9 and #v_u_9 ~= 0 then
		local v25 = #v_u_9
		v_u_10[1] = v_u_22(v_u_9[v25], true)
		if v_u_10[1] then
			local v26 = 0
			while true do
				local v27 = v_u_9[v25]
				local v28 = v_u_9[v25 - 1]
				if v25 < 2 then
					break
				end
				local v29 = v28 - v27
				local v30 = v29.magnitude
				if v30 < v26 then
					v26 = v26 - v30
					v25 = v25 - 1
				else
					local v31 = v_u_22(v27 + v29.unit * v26, false)
					if v31 then
						v_u_10[#v_u_10 + 1] = v31
					end
					v26 = v26 + v_u_4.spacing
				end
			end
			v_u_5.Parent = workspace.CurrentCamera
		end
	else
		return
	end
end
return v_u_4