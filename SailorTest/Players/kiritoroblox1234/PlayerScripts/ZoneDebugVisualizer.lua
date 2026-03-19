game:GetService("Players")
local v1 = game:GetService("UserInputService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2:WaitForChild("TravelConfig"))
local v_u_4 = false
local v_u_5 = Color3.fromRGB(0, 255, 100)
local v_u_6 = nil
local function v_u_14(p7, p8)
	-- upvalues: (copy) v_u_5, (ref) v_u_6
	local v9 = Instance.new("Part")
	v9.Name = "Debug_" .. p7
	v9.Anchored = true
	v9.CanCollide = false
	v9.CanQuery = false
	v9.CanTouch = false
	v9.Size = p8.Size
	v9.CFrame = CFrame.new(p8.Center)
	v9.Transparency = 0.85
	v9.Color = v_u_5
	v9.Material = Enum.Material.ForceField
	v9.Parent = v_u_6
	local v10 = Instance.new("SelectionBox")
	v10.Adornee = v9
	v10.Color3 = v_u_5
	v10.LineThickness = 0.15
	v10.SurfaceTransparency = 1
	v10.Parent = v9
	local v11 = Instance.new("BillboardGui")
	v11.Size = UDim2.new(0, 200, 0, 50)
	local v12 = p8.Size.Y / 2 + 5
	v11.StudsOffset = Vector3.new(0, v12, 0)
	v11.AlwaysOnTop = true
	v11.Parent = v9
	local v13 = Instance.new("TextLabel")
	v13.Size = UDim2.new(1, 0, 1, 0)
	v13.BackgroundTransparency = 0.5
	v13.BackgroundColor3 = Color3.new(0, 0, 0)
	v13.TextColor3 = v_u_5
	v13.TextScaled = true
	v13.Font = Enum.Font.GothamBold
	v13.Text = p7
	v13.Parent = v11
end
local function v_u_18()
	-- upvalues: (ref) v_u_6, (copy) v_u_3, (copy) v_u_14
	if v_u_6 then
		v_u_6:Destroy()
	end
	v_u_6 = Instance.new("Folder")
	v_u_6.Name = "_ZoneDebug"
	v_u_6.Parent = workspace
	local v15 = 0
	for v16, v17 in pairs(v_u_3.Zones) do
		v_u_14(v16, v17)
		v15 = v15 + 1
	end
end
local function v19()
	-- upvalues: (ref) v_u_4, (copy) v_u_18, (ref) v_u_6
	v_u_4 = not v_u_4
	if v_u_4 then
		v_u_18()
	elseif v_u_6 then
		v_u_6:Destroy()
		v_u_6 = nil
	end
end
_G.toggleZoneDebug = v19
v1.InputBegan:Connect(function(p20, p21)
	-- upvalues: (ref) v_u_4, (copy) v_u_18, (ref) v_u_6
	if not p21 and p20.KeyCode == Enum.KeyCode.F9 then
		v_u_4 = not v_u_4
		if v_u_4 then
			v_u_18()
			return
		end
		if v_u_6 then
			v_u_6:Destroy()
			v_u_6 = nil
		end
	end
end)
task.wait(1)
if v_u_4 then
	v_u_18()
end