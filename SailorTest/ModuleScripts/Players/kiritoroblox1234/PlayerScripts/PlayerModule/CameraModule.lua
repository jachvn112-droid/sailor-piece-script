local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = {
	"CameraMinZoomDistance",
	"CameraMaxZoomDistance",
	"CameraMode",
	"DevCameraOcclusionMode",
	"DevComputerCameraMode",
	"DevTouchCameraMode",
	"DevComputerMovementMode",
	"DevTouchMovementMode",
	"DevEnableMouseLock"
}
local v_u_3 = {
	"ComputerCameraMovementMode",
	"ComputerMovementMode",
	"ControlMode",
	"GamepadCameraSensitivity",
	"MouseSensitivity",
	"RotationType",
	"TouchCameraMovementMode",
	"TouchMovementMode"
}
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("UserInputService")
local v_u_7 = game:GetService("VRService")
local v_u_8 = UserSettings():GetService("UserGameSettings")
local v9 = script.Parent:WaitForChild("CommonUtils")
local v_u_10 = require(v9:WaitForChild("ConnectionUtil"))
local v11 = require(v9:WaitForChild("FlagUtil"))
local v_u_12 = require(script:WaitForChild("CameraUtils"))
local v_u_13 = require(script:WaitForChild("CameraInput"))
local v_u_14 = require(script:WaitForChild("ClassicCamera"))
local v_u_15 = require(script:WaitForChild("OrbitalCamera"))
local v_u_16 = require(script:WaitForChild("LegacyCamera"))
local v_u_17 = require(script:WaitForChild("VehicleCamera"))
local v_u_18 = require(script:WaitForChild("VRCamera"))
local v_u_19 = require(script:WaitForChild("VRVehicleCamera"))
local v_u_20 = require(script:WaitForChild("Invisicam"))
local v_u_21 = require(script:WaitForChild("Poppercam"))
local v_u_22 = require(script:WaitForChild("TransparencyController"))
local v_u_23 = require(script:WaitForChild("MouseLockController"))
local v_u_24 = {}
local v_u_25 = {}
if not v_u_4.LocalPlayer then
	return {}
end
local v26 = v_u_4.LocalPlayer
assert(v26, "Strict typing check")
local v27 = v_u_4.LocalPlayer:WaitForChild("PlayerScripts")
v27:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
v27:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
v27:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)
v27:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
v27:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
v27:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
v27:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)
local v_u_28 = v11.getUserFlag("UserPlayerConnectionMemoryLeak")
local v_u_29 = v11.getUserFlag("UserPSFixCameraControllerReset")
function v_u_1.new()
	-- upvalues: (copy) v_u_22, (copy) v_u_28, (copy) v_u_10, (copy) v_u_1, (copy) v_u_4, (copy) v_u_23, (copy) v_u_5, (copy) v_u_2, (copy) v_u_3, (copy) v_u_8, (copy) v_u_6
	local v30 = {
		["activeTransparencyController"] = v_u_22.new()
	}
	local v31
	if v_u_28 then
		v31 = v_u_10.new()
	else
		v31 = nil
	end
	v30.connectionUtil = v31
	local v32 = v_u_1
	local v_u_33 = setmetatable(v30, v32)
	v_u_33.activeCameraController = nil
	v_u_33.activeOcclusionModule = nil
	v_u_33.activeMouseLockController = nil
	v_u_33.currentComputerCameraMovementMode = nil
	v_u_33.cameraSubjectChangedConn = nil
	v_u_33.cameraTypeChangedConn = nil
	for _, v34 in pairs(v_u_4:GetPlayers()) do
		v_u_33:OnPlayerAdded(v34)
	end
	v_u_4.PlayerAdded:Connect(function(p35)
		-- upvalues: (copy) v_u_33
		v_u_33:OnPlayerAdded(p35)
	end)
	if v_u_28 then
		v_u_4.PlayerRemoving:Connect(function(p36)
			-- upvalues: (copy) v_u_33
			v_u_33:OnPlayerRemoving(p36)
		end)
	end
	v_u_33.activeTransparencyController:Enable(true)
	v_u_33.activeMouseLockController = v_u_23.new()
	local v37 = v_u_33.activeMouseLockController
	assert(v37, "Strict typing check")
	local v38 = v_u_33.activeMouseLockController:GetBindableToggleEvent()
	if v38 then
		v38:Connect(function()
			-- upvalues: (copy) v_u_33
			v_u_33:OnMouseLockToggled()
		end)
	end
	v_u_33:ActivateCameraController()
	v_u_33:ActivateOcclusionModule(v_u_4.LocalPlayer.DevCameraOcclusionMode)
	v_u_33:OnCurrentCameraChanged()
	v_u_5:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p39)
		-- upvalues: (copy) v_u_33
		v_u_33:Update(p39)
	end)
	for _, v_u_40 in pairs(v_u_2) do
		v_u_4.LocalPlayer:GetPropertyChangedSignal(v_u_40):Connect(function()
			-- upvalues: (copy) v_u_33, (copy) v_u_40
			v_u_33:OnLocalPlayerCameraPropertyChanged(v_u_40)
		end)
	end
	for _, v_u_41 in pairs(v_u_3) do
		v_u_8:GetPropertyChangedSignal(v_u_41):Connect(function()
			-- upvalues: (copy) v_u_33, (copy) v_u_41
			v_u_33:OnUserGameSettingsPropertyChanged(v_u_41)
		end)
	end
	game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		-- upvalues: (copy) v_u_33
		v_u_33:OnCurrentCameraChanged()
	end)
	v_u_6:GetPropertyChangedSignal("PreferredInput"):Connect(function()
		-- upvalues: (copy) v_u_33
		v_u_33:OnPreferredInputChanged()
	end)
	return v_u_33
end
function v_u_1.GetCameraMovementModeFromSettings(_)
	-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_6, (copy) v_u_8
	if v_u_4.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
		return v_u_12.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic)
	else
		local v42, v43
		if v_u_6.PreferredInput == Enum.PreferredInput.Touch then
			v42 = v_u_12.ConvertCameraModeEnumToStandard(v_u_4.LocalPlayer.DevTouchCameraMode)
			v43 = v_u_12.ConvertCameraModeEnumToStandard(v_u_8.TouchCameraMovementMode)
		else
			v42 = v_u_12.ConvertCameraModeEnumToStandard(v_u_4.LocalPlayer.DevComputerCameraMode)
			v43 = v_u_12.ConvertCameraModeEnumToStandard(v_u_8.ComputerCameraMovementMode)
		end
		if v42 == Enum.DevComputerCameraMovementMode.UserChoice then
			return v43
		else
			return v42
		end
	end
end
function v_u_1.ActivateOcclusionModule(p44, p45)
	-- upvalues: (copy) v_u_21, (copy) v_u_20, (copy) v_u_25, (copy) v_u_4
	local v46
	if p45 == Enum.DevCameraOcclusionMode.Zoom then
		v46 = v_u_21
	else
		if p45 ~= Enum.DevCameraOcclusionMode.Invisicam then
			warn("CameraScript ActivateOcclusionModule called with unsupported mode")
			return
		end
		v46 = v_u_20
	end
	p44.occlusionMode = p45
	if p44.activeOcclusionModule and p44.activeOcclusionModule:GetOcclusionMode() == p45 then
		if not p44.activeOcclusionModule:GetEnabled() then
			p44.activeOcclusionModule:Enable(true)
		end
	else
		local v47 = p44.activeOcclusionModule
		p44.activeOcclusionModule = v_u_25[v46]
		if not p44.activeOcclusionModule then
			p44.activeOcclusionModule = v46.new()
			if p44.activeOcclusionModule then
				v_u_25[v46] = p44.activeOcclusionModule
			end
		end
		if p44.activeOcclusionModule then
			if p44.activeOcclusionModule:GetOcclusionMode() ~= p45 then
				warn("CameraScript ActivateOcclusionModule mismatch: ", p44.activeOcclusionModule:GetOcclusionMode(), "~=", p45)
			end
			if v47 then
				if v47 == p44.activeOcclusionModule then
					warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
				else
					v47:Enable(false)
				end
			end
			if p45 == Enum.DevCameraOcclusionMode.Invisicam then
				if v_u_4.LocalPlayer.Character then
					p44.activeOcclusionModule:CharacterAdded(v_u_4.LocalPlayer.Character, v_u_4.LocalPlayer)
				end
			else
				for _, v48 in pairs(v_u_4:GetPlayers()) do
					if v48 and v48.Character then
						p44.activeOcclusionModule:CharacterAdded(v48.Character, v48)
					end
				end
				p44.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject)
			end
			p44.activeOcclusionModule:Enable(true)
		end
	end
end
function v_u_1.ShouldUseVehicleCamera(p49)
	local v50 = workspace.CurrentCamera
	if not v50 then
		return false
	end
	local v51 = v50.CameraType
	local v52 = v50.CameraSubject
	local v53 = v51 == Enum.CameraType.Custom and true or v51 == Enum.CameraType.Follow
	local v54 = v52 and v52:IsA("VehicleSeat") or false
	local v55 = p49.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam
	if v54 then
		if not v53 then
			v55 = v53
		end
	else
		v55 = v54
	end
	return v55
end
function v_u_1.ActivateCameraController(p56)
	-- upvalues: (copy) v_u_16, (copy) v_u_7, (copy) v_u_18, (copy) v_u_14, (copy) v_u_15, (copy) v_u_19, (copy) v_u_17, (copy) v_u_24, (copy) v_u_29
	local v57 = workspace.CurrentCamera.CameraType
	local v58 = p56:GetCameraMovementModeFromSettings()
	local v59 = nil
	if v57 == Enum.CameraType.Scriptable then
		if p56.activeCameraController then
			p56.activeCameraController:Enable(false)
			p56.activeCameraController = nil
		end
	else
		if v57 == Enum.CameraType.Custom then
			v58 = p56:GetCameraMovementModeFromSettings()
		elseif v57 == Enum.CameraType.Track then
			v58 = Enum.ComputerCameraMovementMode.Classic
		elseif v57 == Enum.CameraType.Follow then
			v58 = Enum.ComputerCameraMovementMode.Follow
		elseif v57 == Enum.CameraType.Orbital then
			v58 = Enum.ComputerCameraMovementMode.Orbital
		elseif v57 == Enum.CameraType.Attach or (v57 == Enum.CameraType.Watch or v57 == Enum.CameraType.Fixed) then
			v59 = v_u_16
		else
			warn("CameraScript encountered an unhandled Camera.CameraType value: ", v57)
		end
		if not v59 then
			if v_u_7.VREnabled then
				v59 = v_u_18
			elseif v58 == Enum.ComputerCameraMovementMode.Classic or (v58 == Enum.ComputerCameraMovementMode.Follow or (v58 == Enum.ComputerCameraMovementMode.Default or v58 == Enum.ComputerCameraMovementMode.CameraToggle)) then
				v59 = v_u_14
			else
				if v58 ~= Enum.ComputerCameraMovementMode.Orbital then
					warn("ActivateCameraController did not select a module.")
					return
				end
				v59 = v_u_15
			end
		end
		if p56:ShouldUseVehicleCamera() then
			if v_u_7.VREnabled then
				v59 = v_u_19
			else
				v59 = v_u_17
			end
		end
		local v60
		if v_u_24[v59] then
			v60 = v_u_24[v59]
			if v_u_29 then
				if v60.Reset and p56.activeCameraController ~= v60 then
					v60:Reset()
				end
			elseif v60.Reset then
				v60:Reset()
			end
		else
			v60 = v59.new()
			v_u_24[v59] = v60
		end
		if p56.activeCameraController then
			if p56.activeCameraController == v60 then
				if not p56.activeCameraController:GetEnabled() then
					p56.activeCameraController:Enable(true)
				end
			else
				p56.activeCameraController:Enable(false)
				p56.activeCameraController = v60
				p56.activeCameraController:Enable(true)
			end
		elseif v60 ~= nil then
			p56.activeCameraController = v60
			local v61 = p56.activeCameraController
			assert(v61, "Strict typing check")
			p56.activeCameraController:Enable(true)
		end
		if p56.activeCameraController then
			p56.activeCameraController:SetCameraMovementMode(v58)
			p56.activeCameraController:SetCameraType(v57)
		end
	end
end
function v_u_1.OnCameraSubjectChanged(p62)
	local v63 = workspace.CurrentCamera
	local v64
	if v63 then
		v64 = v63.CameraSubject
	else
		v64 = nil
	end
	if p62.activeTransparencyController then
		p62.activeTransparencyController:SetSubject(v64)
	end
	if p62.activeOcclusionModule then
		p62.activeOcclusionModule:OnCameraSubjectChanged(v64)
	end
	p62:ActivateCameraController()
end
function v_u_1.OnCameraTypeChanged(p65, p66)
	-- upvalues: (copy) v_u_6, (copy) v_u_12
	if p66 == Enum.CameraType.Scriptable and v_u_6.MouseBehavior == Enum.MouseBehavior.LockCenter then
		v_u_12.restoreMouseBehavior()
	end
	p65:ActivateCameraController()
end
function v_u_1.OnCurrentCameraChanged(p_u_67)
	local v_u_68 = game.Workspace.CurrentCamera
	if v_u_68 then
		if p_u_67.cameraSubjectChangedConn then
			p_u_67.cameraSubjectChangedConn:Disconnect()
		end
		if p_u_67.cameraTypeChangedConn then
			p_u_67.cameraTypeChangedConn:Disconnect()
		end
		p_u_67.cameraSubjectChangedConn = v_u_68:GetPropertyChangedSignal("CameraSubject"):Connect(function()
			-- upvalues: (copy) p_u_67
			p_u_67:OnCameraSubjectChanged()
		end)
		p_u_67.cameraTypeChangedConn = v_u_68:GetPropertyChangedSignal("CameraType"):Connect(function()
			-- upvalues: (copy) p_u_67, (copy) v_u_68
			p_u_67:OnCameraTypeChanged(v_u_68.CameraType)
		end)
		p_u_67:OnCameraSubjectChanged()
		p_u_67:OnCameraTypeChanged(v_u_68.CameraType)
	end
end
function v_u_1.OnLocalPlayerCameraPropertyChanged(p69, p70)
	-- upvalues: (copy) v_u_4
	if p70 == "CameraMode" then
		if v_u_4.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
			if v_u_4.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
				p69:ActivateCameraController()
			else
				warn("Unhandled value for property player.CameraMode: ", v_u_4.LocalPlayer.CameraMode)
			end
		end
		if not p69.activeCameraController or p69.activeCameraController:GetModuleName() ~= "ClassicCamera" then
			p69:ActivateCameraController()
		end
		if p69.activeCameraController then
			p69.activeCameraController:UpdateForDistancePropertyChange()
			return
		end
	else
		if p70 == "DevComputerCameraMode" or p70 == "DevTouchCameraMode" then
			p69:ActivateCameraController()
			return
		end
		if p70 == "DevCameraOcclusionMode" then
			p69:ActivateOcclusionModule(v_u_4.LocalPlayer.DevCameraOcclusionMode)
			return
		end
		if p70 == "CameraMinZoomDistance" or p70 == "CameraMaxZoomDistance" then
			if p69.activeCameraController then
				p69.activeCameraController:UpdateForDistancePropertyChange()
				return
			end
		else
			if p70 == "DevTouchMovementMode" then
				return
			end
			if p70 == "DevComputerMovementMode" then
				return
			end
			local _ = p70 == "DevEnableMouseLock"
		end
	end
end
function v_u_1.OnUserGameSettingsPropertyChanged(p71, p72)
	if p72 == "ComputerCameraMovementMode" or p72 == "TouchCameraMovementMode" then
		p71:ActivateCameraController()
	end
end
function v_u_1.OnPreferredInputChanged(p73)
	p73:ActivateCameraController()
end
function v_u_1.Update(p74, p75)
	-- upvalues: (copy) v_u_13
	if p74.activeCameraController then
		p74.activeCameraController:UpdateMouseBehavior()
		local v76, v77 = p74.activeCameraController:Update(p75)
		if p74.activeOcclusionModule then
			v76, v77 = p74.activeOcclusionModule:Update(p75, v76, v77)
		end
		local v78 = game.Workspace.CurrentCamera
		v78.CFrame = v76
		v78.Focus = v77
		if p74.activeTransparencyController then
			p74.activeTransparencyController:Update(p75)
		end
		if v_u_13.getInputEnabled() then
			v_u_13.resetInputForFrameEnd()
		end
	end
end
function v_u_1.OnCharacterAdded(p79, p80, p81)
	if p79.activeOcclusionModule then
		p79.activeOcclusionModule:CharacterAdded(p80, p81)
	end
end
function v_u_1.OnCharacterRemoving(p82, p83, p84)
	if p82.activeOcclusionModule then
		p82.activeOcclusionModule:CharacterRemoving(p83, p84)
	end
end
function v_u_1.OnPlayerAdded(p_u_85, p_u_86)
	-- upvalues: (copy) v_u_28
	if v_u_28 then
		if p_u_85.connectionUtil then
			p_u_85.connectionUtil:trackConnection(("%*CharacterAdded"):format(p_u_86.UserId), p_u_86.CharacterAdded:Connect(function(p87)
				-- upvalues: (copy) p_u_85, (copy) p_u_86
				p_u_85:OnCharacterAdded(p87, p_u_86)
			end))
			p_u_85.connectionUtil:trackConnection(("%*CharacterRemoving"):format(p_u_86.UserId), p_u_86.CharacterRemoving:Connect(function(p88)
				-- upvalues: (copy) p_u_85, (copy) p_u_86
				p_u_85:OnCharacterRemoving(p88, p_u_86)
			end))
			return
		end
	else
		p_u_86.CharacterAdded:Connect(function(p89)
			-- upvalues: (copy) p_u_85, (copy) p_u_86
			p_u_85:OnCharacterAdded(p89, p_u_86)
		end)
		p_u_86.CharacterRemoving:Connect(function(p90)
			-- upvalues: (copy) p_u_85, (copy) p_u_86
			p_u_85:OnCharacterRemoving(p90, p_u_86)
		end)
	end
end
function v_u_1.OnPlayerRemoving(p91, p92)
	if p91.connectionUtil then
		p91.connectionUtil:disconnect((("%*CharacterAdded"):format(p92.UserId)))
		p91.connectionUtil:disconnect((("%*CharacterRemoving"):format(p92.UserId)))
	end
end
function v_u_1.OnMouseLockToggled(p93)
	if p93.activeMouseLockController then
		local v94 = p93.activeMouseLockController:GetIsMouseLocked()
		local v95 = p93.activeMouseLockController:GetMouseLockOffset()
		if p93.activeCameraController then
			p93.activeCameraController:SetIsMouseLocked(v94)
			p93.activeCameraController:SetMouseLockOffset(v95)
		end
	end
end
v_u_1.new()
return {}