game:GetService("Players")
game:GetService("UserInputService")
UserSettings():GetService("UserGameSettings")
local v_u_1 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_2 = require(script.Parent:WaitForChild("CameraUI"))
local v_u_3 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_4 = false
local v_u_5 = tick()
local v_u_6 = false
local v_u_7 = false
local v_u_8 = false
v_u_2.setCameraModeToastEnabled(false)
return function(p9)
	-- upvalues: (copy) v_u_1, (ref) v_u_4, (ref) v_u_6, (ref) v_u_5, (copy) v_u_2, (ref) v_u_8, (ref) v_u_7, (copy) v_u_3
	local v10 = v_u_1.getTogglePan()
	if p9 and v10 ~= v_u_4 then
		v_u_6 = true
	end
	if v_u_4 ~= v10 or tick() - v_u_5 > 3 then
		local v11
		if v10 then
			v11 = tick() - v_u_5 < 3
		else
			v11 = v10
		end
		v_u_2.setCameraModeToastOpen(v11)
		if v10 then
			v_u_6 = false
		end
		v_u_5 = tick()
		v_u_4 = v10
	end
	if p9 ~= v_u_8 then
		if p9 then
			v_u_7 = v_u_1.getTogglePan()
			v_u_1.setTogglePan(true)
		elseif not v_u_6 then
			v_u_1.setTogglePan(v_u_7)
		end
	end
	if p9 then
		if v_u_1.getTogglePan() then
			v_u_3.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
			v_u_3.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
			v_u_3.setRotationTypeOverride(Enum.RotationType.CameraRelative)
		else
			v_u_3.restoreMouseIcon()
			v_u_3.restoreMouseBehavior()
			v_u_3.setRotationTypeOverride(Enum.RotationType.CameraRelative)
		end
	elseif v_u_1.getTogglePan() then
		v_u_3.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
		v_u_3.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
		v_u_3.setRotationTypeOverride(Enum.RotationType.MovementRelative)
	elseif v_u_1.getHoldPan() then
		v_u_3.restoreMouseIcon()
		v_u_3.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
		v_u_3.setRotationTypeOverride(Enum.RotationType.MovementRelative)
	else
		v_u_3.restoreMouseIcon()
		v_u_3.restoreMouseBehavior()
		v_u_3.restoreRotationType()
	end
	v_u_8 = p9
end