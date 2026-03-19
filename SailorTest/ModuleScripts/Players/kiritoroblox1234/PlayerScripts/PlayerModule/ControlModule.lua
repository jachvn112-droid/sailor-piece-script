local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("GuiService")
local v_u_6 = game:GetService("Workspace")
local v_u_7 = UserSettings():GetService("UserGameSettings")
local v_u_8 = game:GetService("VRService")
script.Parent:WaitForChild("CommonUtils")
local v_u_9 = require(script:WaitForChild("Keyboard"))
local v_u_10 = require(script:WaitForChild("Gamepad"))
local v_u_11 = require(script:WaitForChild("DynamicThumbstick"))
local v12, v13 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
end)
local v_u_14 = v12 and v13
local v_u_15 = require(script:WaitForChild("TouchThumbstick"))
local v_u_16 = require(script:WaitForChild("ClickToMoveController"))
local v_u_17 = require(script:WaitForChild("TouchJump"))
local v_u_18 = require(script:WaitForChild("VehicleController"))
local v_u_19 = Enum.ContextActionPriority.Medium.Value
local v_u_20 = {
	[Enum.TouchMovementMode.DPad] = v_u_11,
	[Enum.DevTouchMovementMode.DPad] = v_u_11,
	[Enum.TouchMovementMode.Thumbpad] = v_u_11,
	[Enum.DevTouchMovementMode.Thumbpad] = v_u_11,
	[Enum.TouchMovementMode.Thumbstick] = v_u_15,
	[Enum.DevTouchMovementMode.Thumbstick] = v_u_15,
	[Enum.TouchMovementMode.DynamicThumbstick] = v_u_11,
	[Enum.DevTouchMovementMode.DynamicThumbstick] = v_u_11,
	[Enum.TouchMovementMode.ClickToMove] = v_u_16,
	[Enum.DevTouchMovementMode.ClickToMove] = v_u_16,
	[Enum.TouchMovementMode.Default] = v_u_11,
	[Enum.ComputerMovementMode.Default] = v_u_9,
	[Enum.ComputerMovementMode.KeyboardMouse] = v_u_9,
	[Enum.DevComputerMovementMode.KeyboardMouse] = v_u_9,
	[Enum.DevComputerMovementMode.Scriptable] = nil,
	[Enum.ComputerMovementMode.ClickToMove] = v_u_16,
	[Enum.DevComputerMovementMode.ClickToMove] = v_u_16
}
function v_u_1.new()
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_18, (copy) v_u_19, (copy) v_u_3, (copy) v_u_7, (copy) v_u_5, (copy) v_u_4
	local v21 = v_u_1
	local v_u_22 = setmetatable({}, v21)
	v_u_22.controllers = {}
	v_u_22.activeControlModule = nil
	v_u_22.activeController = nil
	v_u_22.touchJumpController = nil
	v_u_22.moveFunction = v_u_2.LocalPlayer.Move
	v_u_22.humanoid = nil
	v_u_22.controlsEnabled = true
	v_u_22.humanoidSeatedConn = nil
	v_u_22.vehicleController = nil
	v_u_22.touchControlFrame = nil
	v_u_22.currentTorsoAngle = 0
	v_u_22.inputMoveVector = Vector3.new(0, 0, 0)
	v_u_22.vehicleController = v_u_18.new(v_u_19)
	v_u_2.LocalPlayer.CharacterAdded:Connect(function(p23)
		-- upvalues: (copy) v_u_22
		v_u_22:OnCharacterAdded(p23)
	end)
	v_u_2.LocalPlayer.CharacterRemoving:Connect(function(p24)
		-- upvalues: (copy) v_u_22
		v_u_22:OnCharacterRemoving(p24)
	end)
	if v_u_2.LocalPlayer.Character then
		v_u_22:OnCharacterAdded(v_u_2.LocalPlayer.Character)
	end
	v_u_3:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p25)
		-- upvalues: (copy) v_u_22
		v_u_22:OnRenderStepped(p25)
	end)
	v_u_7:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
		-- upvalues: (copy) v_u_22
		v_u_22:UpdateMovementMode()
	end)
	v_u_2.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
		-- upvalues: (copy) v_u_22
		v_u_22:UpdateMovementMode()
	end)
	v_u_7:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function()
		-- upvalues: (copy) v_u_22
		v_u_22:UpdateMovementMode()
	end)
	v_u_2.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
		-- upvalues: (copy) v_u_22
		v_u_22:UpdateMovementMode()
	end)
	v_u_22.playerGui = nil
	v_u_22.touchGui = nil
	v_u_22.playerGuiAddedConn = nil
	v_u_5:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function()
		-- upvalues: (copy) v_u_22
		v_u_22:UpdateMovementMode()
		v_u_22:UpdateActiveControlModuleEnabled()
	end)
	v_u_4:GetPropertyChangedSignal("PreferredInput"):Connect(function()
		-- upvalues: (copy) v_u_22
		v_u_22:UpdateMovementMode()
	end)
	v_u_22.playerGui = v_u_2.LocalPlayer:FindFirstChildOfClass("PlayerGui")
	if not v_u_22.playerGui then
		v_u_22.playerGuiAddedConn = v_u_2.LocalPlayer.ChildAdded:Connect(function(p26)
			-- upvalues: (copy) v_u_22
			if p26:IsA("PlayerGui") then
				v_u_22.playerGui = p26
				v_u_22.playerGuiAddedConn:Disconnect()
				v_u_22.playerGuiAddedConn = nil
				v_u_22:UpdateMovementMode()
			end
		end)
	end
	v_u_22:UpdateMovementMode()
	return v_u_22
end
function v_u_1.GetMoveVector(p27)
	return not p27.activeController and Vector3.new(0, 0, 0) or p27.activeController:GetMoveVector()
end
function v_u_1.GetEstimatedVRTorsoFrame(p28)
	-- upvalues: (copy) v_u_8
	local v29 = v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
	local _, v30, _ = v29:ToEulerAnglesYXZ()
	local v31 = -v30
	if v_u_8:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and v_u_8:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
		local v32 = v_u_8:GetUserCFrame(Enum.UserCFrame.LeftHand)
		local v33 = v_u_8:GetUserCFrame(Enum.UserCFrame.RightHand)
		local v34 = v29.Position - v32.Position
		local v35 = v29.Position - v33.Position
		local v36 = v34.X
		local v37 = v34.Z
		local v38 = -math.atan2(v36, v37)
		local v39 = v35.X
		local v40 = v35.Z
		local v41 = (-math.atan2(v39, v40) - v38 + 12.566370614359172) % 6.283185307179586
		if v41 > 3.141592653589793 then
			v41 = v41 - 6.283185307179586
		end
		local v42 = (v38 + v41 / 2 + 12.566370614359172) % 6.283185307179586
		if v42 > 3.141592653589793 then
			v42 = v42 - 6.283185307179586
		end
		local v43 = (v31 - p28.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
		if v43 > 3.141592653589793 then
			v43 = v43 - 6.283185307179586
		end
		local v44 = (v42 - p28.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
		if v44 > 3.141592653589793 then
			v44 = v44 - 6.283185307179586
		end
		local v45
		if v44 > -1.5707963267948966 then
			v45 = v44 < 1.5707963267948966
		else
			v45 = false
		end
		if not v45 then
			v44 = v43
		end
		local v46 = math.min(v44, v43)
		local v47 = math.max(v44, v43)
		local v48 = 0
		if v46 > 0 then
			v47 = v46
		elseif v47 >= 0 then
			v47 = v48
		end
		p28.currentTorsoAngle = v47 + p28.currentTorsoAngle
	else
		p28.currentTorsoAngle = v31
	end
	return CFrame.new(v29.Position) * CFrame.fromEulerAnglesYXZ(0, -p28.currentTorsoAngle, 0)
end
function v_u_1.GetActiveController(p49)
	return p49.activeController
end
function v_u_1.UpdateActiveControlModuleEnabled(p_u_50)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_16, (copy) v_u_15, (copy) v_u_11, (copy) v_u_17, (copy) v_u_5
	local function v51()
		-- upvalues: (copy) p_u_50, (ref) v_u_4, (ref) v_u_16, (ref) v_u_15, (ref) v_u_11, (ref) v_u_17, (ref) v_u_2
		if p_u_50.touchControlFrame and (v_u_4.PreferredInput == Enum.PreferredInput.Touch and (p_u_50.activeControlModule == v_u_16 or (p_u_50.activeControlModule == v_u_15 or p_u_50.activeControlModule == v_u_11))) then
			if not p_u_50.controllers[v_u_17] then
				p_u_50.controllers[v_u_17] = v_u_17.new()
			end
			p_u_50.touchJumpController = p_u_50.controllers[v_u_17]
			p_u_50.touchJumpController:Enable(true, p_u_50.touchControlFrame)
		elseif p_u_50.touchJumpController then
			p_u_50.touchJumpController:Enable(false)
		end
		if p_u_50.activeControlModule == v_u_16 then
			p_u_50.activeController:Enable(true, v_u_2.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, p_u_50.touchJumpController)
			return
		elseif p_u_50.touchControlFrame then
			p_u_50.activeController:Enable(true, p_u_50.touchControlFrame)
		else
			p_u_50.activeController:Enable(true)
		end
	end
	if p_u_50.activeController then
		if p_u_50.controlsEnabled then
			if v_u_5.TouchControlsEnabled or (v_u_4.PreferredInput ~= Enum.PreferredInput.Touch or p_u_50.activeControlModule ~= v_u_16 and (p_u_50.activeControlModule ~= v_u_15 and p_u_50.activeControlModule ~= v_u_11)) then
				v51()
			else
				p_u_50.activeController:Enable(false)
				if p_u_50.touchJumpController then
					p_u_50.touchJumpController:Enable(false)
				end
				if p_u_50.moveFunction then
					p_u_50.moveFunction(v_u_2.LocalPlayer, Vector3.new(0, 0, 0), true)
				end
			end
		else
			p_u_50.activeController:Enable(false)
			if p_u_50.touchJumpController then
				p_u_50.touchJumpController:Enable(false)
			end
			if p_u_50.moveFunction then
				p_u_50.moveFunction(v_u_2.LocalPlayer, Vector3.new(0, 0, 0), true)
			end
			return
		end
	else
		return
	end
end
function v_u_1.Enable(p52, p53)
	local v54 = p53 == nil and true or p53
	if p52.controlsEnabled == v54 then
		return
	else
		p52.controlsEnabled = v54
		if p52.activeController then
			p52:UpdateActiveControlModuleEnabled()
		end
	end
end
function v_u_1.Disable(p55)
	p55:Enable(false)
end
function v_u_1.SelectComputerMovementModule(_)
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_10, (copy) v_u_9, (copy) v_u_7, (copy) v_u_16, (copy) v_u_20
	if v_u_4.KeyboardEnabled or v_u_4.GamepadEnabled then
		local v56 = nil
		local v57 = v_u_2.LocalPlayer.DevComputerMovementMode
		if v57 == Enum.DevComputerMovementMode.UserChoice then
			if v_u_4.PreferredInput == Enum.PreferredInput.Gamepad then
				v56 = v_u_10
			elseif v_u_4.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
				v56 = v_u_9
			end
			if v_u_7.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v56 == v_u_9 then
				v56 = v_u_16
			end
		else
			v56 = v_u_20[v57]
			if not v56 and v57 ~= Enum.DevComputerMovementMode.Scriptable then
				warn("No character control module is associated with DevComputerMovementMode ", v57)
			end
		end
		if v56 then
			return v56, true
		elseif v57 == Enum.DevComputerMovementMode.Scriptable then
			return nil, true
		else
			return nil, false
		end
	else
		return nil, false
	end
end
function v_u_1.SelectTouchModule(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_20, (copy) v_u_7
	local v58 = v_u_2.LocalPlayer.DevTouchMovementMode
	local v59
	if v58 == Enum.DevTouchMovementMode.UserChoice then
		v59 = v_u_20[v_u_7.TouchMovementMode]
	else
		if v58 == Enum.DevTouchMovementMode.Scriptable then
			return nil, true
		end
		v59 = v_u_20[v58]
	end
	return v59, true
end
local function v_u_62()
	-- upvalues: (copy) v_u_4
	local v60 = v_u_4:GetGamepadState(Enum.UserInputType.Gamepad1)
	for _, v61 in pairs(v60) do
		if v61.KeyCode == Enum.KeyCode.Thumbstick2 then
			return v61.Position
		end
	end
	return Vector3.new(0, 0, 0)
end
function v_u_1.calculateRawMoveVector(p63, p64, p65)
	-- upvalues: (copy) v_u_6, (copy) v_u_8, (copy) v_u_62
	local v66 = v_u_6.CurrentCamera
	if not v66 then
		return p65
	end
	local v67 = v66.CFrame
	if v_u_8.VREnabled and p64.RootPart then
		v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
		local v68 = p63:GetEstimatedVRTorsoFrame()
		if (v66.Focus.Position - v67.Position).Magnitude < 3 then
			v67 = v67 * v68
		else
			v67 = v66.CFrame * (v68.Rotation + v68.Position * v66.HeadScale)
		end
	end
	if p64:GetState() ~= Enum.HumanoidStateType.Swimming then
		local _, _, _, v73, v70, v71, _, _, v72, _, _, v73 = v67:GetComponents()
		if v72 >= 1 or v72 <= -1 then
			v71 = -v70 * math.sign(v72)
		end
		local v74 = v73 * v73 + v71 * v71
		local v75 = math.sqrt(v74)
		local v76 = (v73 * p65.X + v71 * p65.Z) / v75
		local v77 = (v73 * p65.Z - v71 * p65.X) / v75
		return Vector3.new(v76, 0, v77)
	end
	if not v_u_8.VREnabled then
		return v67:VectorToWorldSpace(p65)
	end
	local v78 = p65.X
	local v79 = p65.Z
	local v80 = Vector3.new(v78, 0, v79)
	if v80.Magnitude < 0.01 then
		return Vector3.new(0, 0, 0)
	end
	local v81 = -v_u_62().Y * 1.3962634015954636
	local v82 = -v80.X
	local v83 = -v80.Z
	local v84 = math.atan2(v82, v83)
	local _, v85, _ = v67:ToEulerAnglesYXZ()
	local v86 = v84 + v85
	return CFrame.fromEulerAnglesYXZ(v81, v86, 0).LookVector
end
function v_u_1.OnRenderStepped(p87, p88)
	-- upvalues: (copy) v_u_10, (copy) v_u_8, (copy) v_u_2
	if p87.activeController and (p87.activeController.enabled and p87.humanoid) then
		local v89 = p87.activeController:GetMoveVector()
		local v90 = p87.activeController:IsMoveVectorCameraRelative()
		local v91 = p87:GetClickToMoveController()
		if p87.activeController == v91 then
			v91:OnRenderStepped(p88)
		elseif v89.magnitude > 0 then
			v91:CleanupPath()
		else
			v91:OnRenderStepped(p88)
			v89 = v91:GetMoveVector()
			v90 = v91:IsMoveVectorCameraRelative()
		end
		if p87.vehicleController then
			local v92
			v89, v92 = p87.vehicleController:Update(v89, v90, p87.activeControlModule == v_u_10)
		end
		if v90 then
			v89 = p87:calculateRawMoveVector(p87.humanoid, v89)
		end
		p87.inputMoveVector = v89
		if v_u_8.VREnabled then
			v89 = p87:updateVRMoveVector(v89)
		end
		p87.moveFunction(v_u_2.LocalPlayer, v89, false)
		local v93 = p87.humanoid
		local v94 = not p87.activeController:GetIsJumping() and p87.touchJumpController
		if v94 then
			v94 = p87.touchJumpController:GetIsJumping()
		end
		v93.Jump = v94
	end
end
function v_u_1.updateVRMoveVector(p95, p96)
	-- upvalues: (copy) v_u_8
	local v97 = workspace.CurrentCamera
	local v98 = (v97.Focus.Position - v97.CFrame.Position).Magnitude < 5
	if p96.Magnitude ~= 0 or (not v98 or (not v_u_8.AvatarGestures or (not p95.humanoid or p95.humanoid.Sit))) then
		return p96
	end
	local v99 = v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
	local v100 = v99.Rotation + v99.Position * v97.HeadScale
	local v101 = -0.7 * p95.humanoid.RootPart.Size.Y / 2
	local v102 = (v97.CFrame * v100 * CFrame.new(0, v101, 0)).Position - p95.humanoid.RootPart.CFrame.Position
	local v103 = v102.x
	local v104 = v102.z
	return Vector3.new(v103, 0, v104)
end
function v_u_1.OnHumanoidSeated(p105, p106, p107)
	-- upvalues: (copy) v_u_19
	if p106 then
		if p107 and p107:IsA("VehicleSeat") then
			if not p105.vehicleController then
				p105.vehicleController = p105.vehicleController.new(v_u_19)
			end
			p105.vehicleController:Enable(true, p107)
			return
		end
	elseif p105.vehicleController then
		p105.vehicleController:Enable(false, p107)
	end
end
function v_u_1.OnCharacterAdded(p_u_108, p109)
	p_u_108.humanoid = p109:FindFirstChildOfClass("Humanoid")
	while not p_u_108.humanoid do
		p109.ChildAdded:wait()
		p_u_108.humanoid = p109:FindFirstChildOfClass("Humanoid")
	end
	if p_u_108.humanoidSeatedConn then
		p_u_108.humanoidSeatedConn:Disconnect()
		p_u_108.humanoidSeatedConn = nil
	end
	p_u_108.humanoidSeatedConn = p_u_108.humanoid.Seated:Connect(function(p110, p111)
		-- upvalues: (copy) p_u_108
		p_u_108:OnHumanoidSeated(p110, p111)
	end)
	p_u_108:UpdateMovementMode()
end
function v_u_1.OnCharacterRemoving(p112, _)
	p112.humanoid = nil
	p112:UpdateMovementMode()
end
function v_u_1.UpdateTouchGuiVisibility(p113)
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	local v114 = p113.humanoid and v_u_5.TouchControlsEnabled
	if v114 then
		v114 = v_u_4.PreferredInput == Enum.PreferredInput.Touch
	end
	if v114 and not p113.touchGui then
		p113:CreateTouchGuiContainer()
	end
	if p113.touchGui then
		p113.touchGui.Enabled = v114 and true or false
	end
end
function v_u_1.SwitchToController(p115, p116)
	-- upvalues: (copy) v_u_19
	if p116 then
		if not p115.controllers[p116] then
			p115.controllers[p116] = p116.new(v_u_19)
		end
		if p115.activeController ~= p115.controllers[p116] then
			if p115.activeController then
				p115.activeController:Enable(false)
			end
			p115.activeController = p115.controllers[p116]
			p115.activeControlModule = p116
			p115:UpdateActiveControlModuleEnabled()
		end
	else
		if p115.activeController then
			p115.activeController:Enable(false)
		end
		p115.activeController = nil
		p115.activeControlModule = nil
	end
end
function v_u_1.UpdateMovementMode(p117)
	-- upvalues: (copy) v_u_4
	p117:UpdateTouchGuiVisibility()
	if v_u_4.PreferredInput == Enum.PreferredInput.Touch then
		local v118, v119 = p117:SelectTouchModule()
		if v119 and p117.touchControlFrame then
			p117:SwitchToController(v118)
			return
		end
	else
		p117:SwitchToController((p117:SelectComputerMovementModule()))
	end
end
function v_u_1.CreateTouchGuiContainer(p120)
	-- upvalues: (ref) v_u_14
	if p120.playerGui then
		if p120.touchGui then
			p120.touchGui:Destroy()
		end
		p120.touchGui = Instance.new("ScreenGui")
		p120.touchGui.Name = "TouchGui"
		p120.touchGui.ResetOnSpawn = false
		p120.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		if v_u_14 then
			p120.touchGui.ClipToDeviceSafeArea = false
		end
		p120.touchControlFrame = Instance.new("Frame")
		p120.touchControlFrame.Name = "TouchControlFrame"
		p120.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
		p120.touchControlFrame.BackgroundTransparency = 1
		p120.touchControlFrame.Parent = p120.touchGui
		p120.touchGui.Parent = p120.playerGui
	end
end
function v_u_1.GetClickToMoveController(p121)
	-- upvalues: (copy) v_u_16, (copy) v_u_19
	if not p121.controllers[v_u_16] then
		p121.controllers[v_u_16] = v_u_16.new(v_u_19)
	end
	return p121.controllers[v_u_16]
end
return v_u_1.new()