local v_u_1 = game:GetService("ContextActionService")
local v_u_2 = game:GetService("UserInputService")
local v3 = game:GetService("Players")
game:GetService("RunService")
local v_u_4 = UserSettings():GetService("UserGameSettings")
local v_u_5 = game:GetService("VRService")
local v_u_6 = game:GetService("GuiService")
local v7 = script.Parent.Parent:WaitForChild("CommonUtils")
local v8 = require(v7:WaitForChild("FlagUtil"))
local v_u_9 = v8.getUserFlag("UserPSSinkUnknownTouchEvents")
local v10 = v8.getUserFlag("UserPSTextboxResetCameraInput")
local v_u_11 = v3.LocalPlayer
local v_u_12 = Enum.ContextActionPriority.Medium.Value
local v_u_13 = Vector2.new(1, 0.77) * 0.06981317007977318 * 60
local v_u_14 = Vector2.new(1, 0.77) * 0.008726646259971648
local v_u_15 = Vector2.new(1, 0.77) * 0.12217304763960307
local v_u_16 = Vector2.new(1, 0.66) * 0.017453292519943295
local v_u_17 = Instance.new("BindableEvent")
local v_u_18 = Instance.new("BindableEvent")
local v_u_19 = v_u_17.Event
local v_u_20 = v_u_18.Event
v_u_2.InputBegan:Connect(function(p21, p22)
	-- upvalues: (copy) v_u_17
	if not p22 and p21.UserInputType == Enum.UserInputType.MouseButton2 then
		v_u_17:Fire()
	end
end)
v_u_2.InputEnded:Connect(function(p23, _)
	-- upvalues: (copy) v_u_18
	if p23.UserInputType == Enum.UserInputType.MouseButton2 then
		v_u_18:Fire()
	end
end)
local function v_u_27(p24)
	local v25 = (math.abs(p24) - 0.1) / 0.9 * 2
	local v26 = (math.exp(v25) - 1) / 6.38905609893065
	return math.sign(p24) * math.clamp(v26, 0, 1)
end
local function v_u_32(p28)
	local v29 = workspace.CurrentCamera
	if not v29 then
		return p28
	end
	local v30 = v29.CFrame:ToEulerAnglesYXZ()
	if p28.Y * v30 >= 0 then
		return p28
	end
	local v31 = (1 - (math.abs(v30) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25
	return Vector2.new(1, v31) * p28
end
local function v_u_39(p33)
	-- upvalues: (copy) v_u_11
	local v34 = v_u_11:FindFirstChildOfClass("PlayerGui")
	if v34 then
		v34 = v34:FindFirstChild("TouchGui")
	end
	local v35
	if v34 then
		v35 = v34:FindFirstChild("TouchControlFrame")
	else
		v35 = v34
	end
	if v35 then
		v35 = v35:FindFirstChild("DynamicThumbstickFrame")
	end
	if not v35 then
		return false
	end
	if not v34.Enabled then
		return false
	end
	local v36 = v35.AbsolutePosition
	local v37 = v36 + v35.AbsoluteSize
	local v38
	if p33.X >= v36.X and (p33.Y >= v36.Y and p33.X <= v37.X) then
		v38 = p33.Y <= v37.Y
	else
		v38 = false
	end
	return v38
end
local v40 = {}
local v_u_41 = {}
local v_u_42 = 0
local v_u_43 = {
	["Thumbstick2"] = Vector2.new()
}
local v_u_44 = {
	["Left"] = 0,
	["Right"] = 0,
	["I"] = 0,
	["O"] = 0
}
local v_u_45 = {
	["Movement"] = Vector2.new(),
	["Wheel"] = 0,
	["Pan"] = Vector2.new(),
	["Pinch"] = 0
}
local v_u_46 = {
	["Move"] = Vector2.new(),
	["Pinch"] = 0
}
local v_u_47 = Instance.new("BindableEvent")
v40.gamepadZoomPress = v_u_47.Event
local v_u_48 = v_u_5.VREnabled and Instance.new("BindableEvent") or nil
if v_u_5.VREnabled then
	v40.gamepadReset = v_u_48.Event
end
function v40.getRotationActivated()
	-- upvalues: (ref) v_u_42, (copy) v_u_43
	return v_u_42 > 0 and true or v_u_43.Thumbstick2.Magnitude > 0
end
function v40.getRotation(p49, p50)
	-- upvalues: (copy) v_u_4, (copy) v_u_44, (copy) v_u_43, (copy) v_u_45, (copy) v_u_32, (copy) v_u_46, (copy) v_u_13, (copy) v_u_14, (copy) v_u_15, (copy) v_u_16
	local v51 = Vector2.new(1, v_u_4:GetCameraYInvertValue())
	local v52 = Vector2.new(v_u_44.Right - v_u_44.Left, 0) * p49
	local v53 = v_u_43.Thumbstick2 * v_u_4.GamepadCameraSensitivity * p49
	local v54 = v_u_45.Movement
	local v55 = v_u_45.Pan
	local v56 = v_u_32(v_u_46.Move)
	if p50 then
		v52 = Vector2.new()
	end
	return (v52 * 2.0943951023931953 + v53 * v_u_13 + v54 * v_u_14 + v55 * v_u_15 + v56 * v_u_16) * v51
end
function v40.getZoomDelta()
	-- upvalues: (copy) v_u_44, (copy) v_u_45, (copy) v_u_46
	local v57 = v_u_44.O - v_u_44.I
	local v58 = -v_u_45.Wheel + v_u_45.Pinch
	local v59 = -v_u_46.Pinch
	return v57 * 0.1 + v58 * 1 + v59 * 0.04
end
local function v_u_62(_, _, p60)
	-- upvalues: (copy) v_u_43, (ref) v_u_27
	local v61 = p60.Position
	v_u_43[p60.KeyCode.Name] = Vector2.new(v_u_27(v61.X), -v_u_27(v61.Y))
	return Enum.ContextActionResult.Pass
end
local function v_u_65(_, p63, p64)
	-- upvalues: (copy) v_u_44
	v_u_44[p64.KeyCode.Name] = p63 == Enum.UserInputState.Begin and 1 or 0
end
local function v_u_67(_, p66, _)
	-- upvalues: (copy) v_u_47
	if p66 == Enum.UserInputState.Begin then
		v_u_47:Fire()
	end
end
local function v_u_69(_, p68, _)
	-- upvalues: (copy) v_u_48
	if p68 == Enum.UserInputState.Begin then
		v_u_48:Fire()
	end
end
local function v_u_74()
	-- upvalues: (copy) v_u_43, (copy) v_u_44, (copy) v_u_45, (copy) v_u_46, (ref) v_u_42
	local v70 = {
		v_u_43,
		v_u_44,
		v_u_45,
		v_u_46
	}
	for _, v71 in pairs(v70) do
		for v72, v73 in pairs(v71) do
			if type(v73) == "boolean" then
				v71[v72] = false
			else
				v71[v72] = v71[v72] * 0
			end
		end
	end
	v_u_42 = 0
end
local v_u_75 = {}
local v_u_76 = nil
local v_u_77 = nil
local function v_u_83(p78, p79)
	-- upvalues: (ref) v_u_76, (copy) v_u_39, (ref) v_u_42, (ref) v_u_75
	local v80 = p78.UserInputType == Enum.UserInputType.Touch
	assert(v80)
	local v81 = p78.UserInputState == Enum.UserInputState.Begin
	assert(v81)
	if v_u_76 == nil and (v_u_39(p78.Position) and not p79) then
		v_u_76 = p78
	else
		if not p79 then
			local v82 = v_u_42 + 1
			v_u_42 = math.max(0, v82)
		end
		v_u_75[p78] = p79
	end
end
local function v_u_88(p84, _)
	-- upvalues: (ref) v_u_76, (ref) v_u_75, (ref) v_u_77, (ref) v_u_42
	local v85 = p84.UserInputType == Enum.UserInputType.Touch
	assert(v85)
	local v86 = p84.UserInputState == Enum.UserInputState.End
	assert(v86)
	if p84 == v_u_76 then
		v_u_76 = nil
	end
	if v_u_75[p84] == false then
		v_u_77 = nil
		local v87 = v_u_42 - 1
		v_u_42 = math.max(0, v87)
	end
	v_u_75[p84] = nil
end
local function v_u_100(p89, p90)
	-- upvalues: (ref) v_u_76, (ref) v_u_75, (copy) v_u_9, (copy) v_u_46, (ref) v_u_77
	local v91 = p89.UserInputType == Enum.UserInputType.Touch
	assert(v91)
	local v92 = p89.UserInputState == Enum.UserInputState.Change
	assert(v92)
	if p89 == v_u_76 then
		return
	else
		if v_u_75[p89] == nil then
			if v_u_9 then
				v_u_75[p89] = true
			else
				v_u_75[p89] = p90
			end
		end
		local v93 = {}
		for v94, v95 in pairs(v_u_75) do
			if not v95 then
				table.insert(v93, v94)
			end
		end
		if #v93 == 1 and v_u_75[p89] == false then
			local v96 = p89.Delta
			local v97 = v_u_46
			v97.Move = v97.Move + Vector2.new(v96.X, v96.Y)
		end
		if #v93 == 2 then
			local v98 = (v93[1].Position - v93[2].Position).Magnitude
			if v_u_77 then
				local v99 = v_u_46
				v99.Pinch = v99.Pinch + (v98 - v_u_77)
			end
			v_u_77 = v98
		else
			v_u_77 = nil
		end
	end
end
local function v_u_101()
	-- upvalues: (ref) v_u_75, (ref) v_u_76, (ref) v_u_77, (ref) v_u_42
	v_u_75 = {}
	v_u_76 = nil
	v_u_77 = nil
	v_u_42 = 0
end
local function v_u_106(p102, p103, p104, p105)
	-- upvalues: (copy) v_u_45
	if not p105 then
		v_u_45.Wheel = p102
		v_u_45.Pan = p103
		v_u_45.Pinch = -p104
	end
end
local function v_u_110(p107, p108)
	-- upvalues: (ref) v_u_83, (ref) v_u_42
	if p107.UserInputType == Enum.UserInputType.Touch then
		v_u_83(p107, p108)
	elseif p107.UserInputType == Enum.UserInputType.MouseButton2 and not p108 then
		local v109 = v_u_42 + 1
		v_u_42 = math.max(0, v109)
	end
end
local function v_u_114(p111, p112)
	-- upvalues: (ref) v_u_100, (copy) v_u_45
	if p111.UserInputType == Enum.UserInputType.Touch then
		v_u_100(p111, p112)
	elseif p111.UserInputType == Enum.UserInputType.MouseMovement then
		local v113 = p111.Delta
		v_u_45.Movement = Vector2.new(v113.X, v113.Y)
	end
end
local function v_u_118(p115, p116)
	-- upvalues: (ref) v_u_88, (ref) v_u_42
	if p115.UserInputType == Enum.UserInputType.Touch then
		v_u_88(p115, p116)
	elseif p115.UserInputType == Enum.UserInputType.MouseButton2 then
		local v117 = v_u_42 - 1
		v_u_42 = math.max(0, v117)
	end
end
local v_u_119 = false
function v40.setInputEnabled(p120)
	-- upvalues: (ref) v_u_119, (copy) v_u_74, (ref) v_u_101, (copy) v_u_1, (copy) v_u_62, (copy) v_u_12, (copy) v_u_65, (copy) v_u_5, (copy) v_u_69, (copy) v_u_67, (ref) v_u_41, (copy) v_u_2, (copy) v_u_110, (copy) v_u_114, (copy) v_u_118, (copy) v_u_106, (copy) v_u_6
	if v_u_119 == p120 then
		return
	else
		v_u_119 = p120
		v_u_74()
		v_u_101()
		if v_u_119 then
			v_u_1:BindActionAtPriority("RbxCameraThumbstick", v_u_62, false, v_u_12, Enum.KeyCode.Thumbstick2)
			v_u_1:BindActionAtPriority("RbxCameraKeypress", v_u_65, false, v_u_12, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O)
			if v_u_5.VREnabled then
				v_u_1:BindAction("RbxCameraGamepadReset", v_u_69, false, Enum.KeyCode.ButtonL3)
			end
			v_u_1:BindAction("RbxCameraGamepadZoom", v_u_67, false, Enum.KeyCode.ButtonR3)
			local v121 = v_u_41
			local v122 = v_u_2.InputBegan
			local v123 = v_u_110
			table.insert(v121, v122:Connect(v123))
			local v124 = v_u_41
			local v125 = v_u_2.InputChanged
			local v126 = v_u_114
			table.insert(v124, v125:Connect(v126))
			local v127 = v_u_41
			local v128 = v_u_2.InputEnded
			local v129 = v_u_118
			table.insert(v127, v128:Connect(v129))
			local v130 = v_u_41
			local v131 = v_u_2.PointerAction
			local v132 = v_u_106
			table.insert(v130, v131:Connect(v132))
			local v133 = v_u_41
			local v134 = v_u_6.MenuOpened
			local v135 = v_u_101
			table.insert(v133, v134:connect(v135))
		else
			v_u_1:UnbindAction("RbxCameraThumbstick")
			v_u_1:UnbindAction("RbxCameraMouseMove")
			v_u_1:UnbindAction("RbxCameraMouseWheel")
			v_u_1:UnbindAction("RbxCameraKeypress")
			v_u_1:UnbindAction("RbxCameraGamepadZoom")
			if v_u_5.VREnabled then
				v_u_1:UnbindAction("RbxCameraGamepadReset")
			end
			for _, v136 in pairs(v_u_41) do
				v136:Disconnect()
			end
			v_u_41 = {}
		end
	end
end
function v40.getInputEnabled()
	-- upvalues: (ref) v_u_119
	return v_u_119
end
function v40.resetInputForFrameEnd()
	-- upvalues: (copy) v_u_45, (copy) v_u_46
	v_u_45.Movement = Vector2.new()
	v_u_46.Move = Vector2.new()
	v_u_46.Pinch = 0
	v_u_45.Wheel = 0
	v_u_45.Pan = Vector2.new()
	v_u_45.Pinch = 0
end
v_u_2.WindowFocused:Connect(v_u_74)
v_u_2.WindowFocusReleased:Connect(v_u_74)
if v10 then
	v_u_2.TextBoxFocusReleased:Connect(v_u_74)
end
local v_u_137 = false
local v_u_138 = false
local v_u_139 = 0
function v40.getHoldPan()
	-- upvalues: (ref) v_u_137
	return v_u_137
end
function v40.getTogglePan()
	-- upvalues: (ref) v_u_138
	return v_u_138
end
function v40.getPanning()
	-- upvalues: (ref) v_u_138, (ref) v_u_137
	return v_u_138 or v_u_137
end
function v40.setTogglePan(p140)
	-- upvalues: (ref) v_u_138
	v_u_138 = p140
end
local v_u_141 = false
local v_u_142 = nil
local v_u_143 = nil
function v40.enableCameraToggleInput()
	-- upvalues: (ref) v_u_141, (ref) v_u_137, (ref) v_u_138, (ref) v_u_142, (ref) v_u_143, (ref) v_u_19, (ref) v_u_139, (ref) v_u_20, (copy) v_u_2
	if not v_u_141 then
		v_u_141 = true
		v_u_137 = false
		v_u_138 = false
		if v_u_142 then
			v_u_142:Disconnect()
		end
		if v_u_143 then
			v_u_143:Disconnect()
		end
		v_u_142 = v_u_19:Connect(function()
			-- upvalues: (ref) v_u_137, (ref) v_u_139
			v_u_137 = true
			v_u_139 = tick()
		end)
		v_u_143 = v_u_20:Connect(function()
			-- upvalues: (ref) v_u_137, (ref) v_u_139, (ref) v_u_138, (ref) v_u_2
			v_u_137 = false
			if tick() - v_u_139 < 0.3 and (v_u_138 or v_u_2:GetMouseDelta().Magnitude < 2) then
				v_u_138 = not v_u_138
			end
		end)
	end
end
function v40.disableCameraToggleInput()
	-- upvalues: (ref) v_u_141, (ref) v_u_142, (ref) v_u_143
	if v_u_141 then
		v_u_141 = false
		if v_u_142 then
			v_u_142:Disconnect()
			v_u_142 = nil
		end
		if v_u_143 then
			v_u_143:Disconnect()
			v_u_143 = nil
		end
	end
end
return v40