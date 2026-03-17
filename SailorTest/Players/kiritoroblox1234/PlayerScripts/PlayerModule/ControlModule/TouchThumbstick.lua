game:GetService("Players")
local v_u_1 = game:GetService("GuiService")
local v_u_2 = game:GetService("UserInputService")
UserSettings():GetService("UserGameSettings")
local v_u_3 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4.new()
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v5 = v_u_3.new()
	local v6 = v_u_4
	local v7 = setmetatable(v5, v6)
	v7.isFollowStick = false
	v7.thumbstickFrame = nil
	v7.moveTouchObject = nil
	v7.onTouchMovedConn = nil
	v7.onTouchEndedConn = nil
	v7.screenPos = nil
	v7.stickImage = nil
	v7.thumbstickSize = nil
	return v7
end
function v_u_4.Enable(p8, p9, p10)
	if p9 == nil then
		return false
	end
	local v11 = p9 and true or false
	if p8.enabled == v11 then
		return true
	end
	p8.moveVector = Vector3.new(0, 0, 0)
	p8.isJumping = false
	if v11 then
		if not p8.thumbstickFrame then
			p8:Create(p10)
		end
		p8.thumbstickFrame.Visible = true
	else
		p8.thumbstickFrame.Visible = false
		p8:OnInputEnded()
	end
	p8.enabled = v11
end
function v_u_4.OnInputEnded(p12)
	p12.thumbstickFrame.Position = p12.screenPos
	p12.stickImage.Position = UDim2.new(0, p12.thumbstickFrame.Size.X.Offset / 2 - p12.thumbstickSize / 4, 0, p12.thumbstickFrame.Size.Y.Offset / 2 - p12.thumbstickSize / 4)
	p12.moveVector = Vector3.new(0, 0, 0)
	p12.isJumping = false
	p12.thumbstickFrame.Position = p12.screenPos
	p12.moveTouchObject = nil
end
function v_u_4.Create(p_u_13, p_u_14)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	if p_u_13.thumbstickFrame then
		p_u_13.thumbstickFrame:Destroy()
		p_u_13.thumbstickFrame = nil
		if p_u_13.onTouchMovedConn then
			p_u_13.onTouchMovedConn:Disconnect()
			p_u_13.onTouchMovedConn = nil
		end
		if p_u_13.onTouchEndedConn then
			p_u_13.onTouchEndedConn:Disconnect()
			p_u_13.onTouchEndedConn = nil
		end
		if p_u_13.absoluteSizeChangedConn then
			p_u_13.absoluteSizeChangedConn:Disconnect()
			p_u_13.absoluteSizeChangedConn = nil
		end
	end
	p_u_13.thumbstickFrame = Instance.new("Frame")
	p_u_13.thumbstickFrame.Name = "ThumbstickFrame"
	p_u_13.thumbstickFrame.Active = true
	p_u_13.thumbstickFrame.Visible = false
	p_u_13.thumbstickFrame.BackgroundTransparency = 1
	local v_u_15 = Instance.new("ImageLabel")
	v_u_15.Name = "OuterImage"
	v_u_15.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
	v_u_15.ImageRectOffset = Vector2.new()
	v_u_15.ImageRectSize = Vector2.new(220, 220)
	v_u_15.BackgroundTransparency = 1
	v_u_15.Position = UDim2.new(0, 0, 0, 0)
	p_u_13.stickImage = Instance.new("ImageLabel")
	p_u_13.stickImage.Name = "StickImage"
	p_u_13.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
	p_u_13.stickImage.ImageRectOffset = Vector2.new(220, 0)
	p_u_13.stickImage.ImageRectSize = Vector2.new(111, 111)
	p_u_13.stickImage.BackgroundTransparency = 1
	p_u_13.stickImage.ZIndex = 2
	local function v19()
		-- upvalues: (copy) p_u_14, (copy) p_u_13, (copy) v_u_15
		local v16 = p_u_14.AbsoluteSize.X
		local v17 = p_u_14.AbsoluteSize.Y
		local v18 = math.min(v16, v17) <= 500
		p_u_13.thumbstickSize = v18 and 70 or 120
		p_u_13.screenPos = v18 and UDim2.new(0, p_u_13.thumbstickSize / 2 - 10, 1, -p_u_13.thumbstickSize - 20) or UDim2.new(0, p_u_13.thumbstickSize / 2, 1, -p_u_13.thumbstickSize * 1.75)
		p_u_13.thumbstickFrame.Size = UDim2.new(0, p_u_13.thumbstickSize, 0, p_u_13.thumbstickSize)
		p_u_13.thumbstickFrame.Position = p_u_13.screenPos
		v_u_15.Size = UDim2.new(0, p_u_13.thumbstickSize, 0, p_u_13.thumbstickSize)
		p_u_13.stickImage.Size = UDim2.new(0, p_u_13.thumbstickSize / 2, 0, p_u_13.thumbstickSize / 2)
		p_u_13.stickImage.Position = UDim2.new(0, p_u_13.thumbstickSize / 2 - p_u_13.thumbstickSize / 4, 0, p_u_13.thumbstickSize / 2 - p_u_13.thumbstickSize / 4)
	end
	v19()
	p_u_13.absoluteSizeChangedConn = p_u_14:GetPropertyChangedSignal("AbsoluteSize"):Connect(v19)
	v_u_15.Parent = p_u_13.thumbstickFrame
	p_u_13.stickImage.Parent = p_u_13.thumbstickFrame
	local v_u_20 = nil
	local function v_u_27(p21)
		-- upvalues: (ref) v_u_20, (copy) p_u_13
		local v22 = Vector2.new(p21.X - v_u_20.X, p21.Y - v_u_20.Y)
		local v23 = v22.magnitude
		local v24 = p_u_13.thumbstickFrame.AbsoluteSize.X / 2
		if p_u_13.isFollowStick and v24 < v23 then
			local v25 = v22.unit * v24
			p_u_13.thumbstickFrame.Position = UDim2.new(0, p21.X - p_u_13.thumbstickFrame.AbsoluteSize.X / 2 - v25.X, 0, p21.Y - p_u_13.thumbstickFrame.AbsoluteSize.Y / 2 - v25.Y)
		else
			local v26 = math.min(v23, v24)
			v22 = v22.unit * v26
		end
		p_u_13.stickImage.Position = UDim2.new(0, v22.X + p_u_13.stickImage.AbsoluteSize.X / 2, 0, v22.Y + p_u_13.stickImage.AbsoluteSize.Y / 2)
	end
	p_u_13.thumbstickFrame.InputBegan:Connect(function(p28)
		-- upvalues: (copy) p_u_13, (ref) v_u_20
		if not p_u_13.moveTouchObject and (p28.UserInputType == Enum.UserInputType.Touch and p28.UserInputState == Enum.UserInputState.Begin) then
			p_u_13.moveTouchObject = p28
			p_u_13.thumbstickFrame.Position = UDim2.new(0, p28.Position.X - p_u_13.thumbstickFrame.Size.X.Offset / 2, 0, p28.Position.Y - p_u_13.thumbstickFrame.Size.Y.Offset / 2)
			v_u_20 = Vector2.new(p_u_13.thumbstickFrame.AbsolutePosition.X + p_u_13.thumbstickFrame.AbsoluteSize.X / 2, p_u_13.thumbstickFrame.AbsolutePosition.Y + p_u_13.thumbstickFrame.AbsoluteSize.Y / 2)
			Vector2.new(p28.Position.X - v_u_20.X, p28.Position.Y - v_u_20.Y)
		end
	end)
	p_u_13.onTouchMovedConn = v_u_2.TouchMoved:Connect(function(p29, _)
		-- upvalues: (copy) p_u_13, (ref) v_u_20, (copy) v_u_27
		if p29 == p_u_13.moveTouchObject then
			v_u_20 = Vector2.new(p_u_13.thumbstickFrame.AbsolutePosition.X + p_u_13.thumbstickFrame.AbsoluteSize.X / 2, p_u_13.thumbstickFrame.AbsolutePosition.Y + p_u_13.thumbstickFrame.AbsoluteSize.Y / 2)
			local v30 = Vector2.new(p29.Position.X - v_u_20.X, p29.Position.Y - v_u_20.Y) / (p_u_13.thumbstickSize / 2)
			local v31 = v30.magnitude
			local v32
			if v31 < 0.05 then
				v32 = Vector3.new()
			else
				local v33 = v30.unit
				local v34 = (v31 - 0.05) / 0.95
				local v35 = v33 * math.min(1, v34)
				local v36 = v35.X
				local v37 = v35.Y
				v32 = Vector3.new(v36, 0, v37)
			end
			p_u_13.moveVector = v32
			v_u_27(p29.Position)
		end
	end)
	p_u_13.onTouchEndedConn = v_u_2.TouchEnded:Connect(function(p38, _)
		-- upvalues: (copy) p_u_13
		if p38 == p_u_13.moveTouchObject then
			p_u_13:OnInputEnded()
		end
	end)
	v_u_1.MenuOpened:Connect(function()
		-- upvalues: (copy) p_u_13
		if p_u_13.moveTouchObject then
			p_u_13:OnInputEnded()
		end
	end)
	p_u_13.thumbstickFrame.Parent = p_u_14
end
return v_u_4