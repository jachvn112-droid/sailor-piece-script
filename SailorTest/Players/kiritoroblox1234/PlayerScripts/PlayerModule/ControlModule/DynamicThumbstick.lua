local v_u_1 = Enum.ContextActionPriority.High.Value
local v_u_2 = {
	0.10999999999999999,
	0.30000000000000004,
	0.4,
	0.5,
	0.6,
	0.7,
	0.75
}
local v_u_3 = #v_u_2
local v_u_4 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local v5 = game:GetService("Players")
local v_u_6 = game:GetService("GuiService")
local v_u_7 = game:GetService("UserInputService")
local v_u_8 = game:GetService("ContextActionService")
local v_u_9 = game:GetService("RunService")
local v_u_10 = game:GetService("TweenService")
local v11, v12 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
end)
local v_u_13 = v11 and v12
local v_u_14 = v5.LocalPlayer
if not v_u_14 then
	v5:GetPropertyChangedSignal("LocalPlayer"):Wait()
	v_u_14 = v5.LocalPlayer
end
local v_u_15 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_16 = setmetatable({}, v_u_15)
v_u_16.__index = v_u_16
function v_u_16.new()
	-- upvalues: (copy) v_u_15, (copy) v_u_16
	local v17 = v_u_15.new()
	local v18 = v_u_16
	local v19 = setmetatable(v17, v18)
	v19.moveTouchObject = nil
	v19.moveTouchLockedIn = false
	v19.moveTouchFirstChanged = false
	v19.moveTouchStartPosition = nil
	v19.startImage = nil
	v19.endImage = nil
	v19.middleImages = {}
	v19.startImageFadeTween = nil
	v19.endImageFadeTween = nil
	v19.middleImageFadeTweens = {}
	v19.isFirstTouch = true
	v19.thumbstickFrame = nil
	v19.onRenderSteppedConn = nil
	v19.fadeInAndOutBalance = 0.5
	v19.fadeInAndOutHalfDuration = 0.3
	v19.hasFadedBackgroundInPortrait = false
	v19.hasFadedBackgroundInLandscape = false
	v19.tweenInAlphaStart = nil
	v19.tweenOutAlphaStart = nil
	return v19
end
function v_u_16.GetIsJumping(p20)
	local v21 = p20.isJumping
	p20.isJumping = false
	return v21
end
function v_u_16.Enable(p22, p23, p24)
	if p23 == nil then
		return false
	end
	local v25 = p23 and true or false
	if p22.enabled == v25 then
		return true
	end
	if v25 then
		if not p22.thumbstickFrame then
			p22:Create(p24)
		end
		p22:BindContextActions()
	else
		p22:UnbindContextActions()
		p22:OnInputEnded()
	end
	p22.enabled = v25
	p22.thumbstickFrame.Visible = v25
	return nil
end
function v_u_16.OnInputEnded(p26)
	p26.moveTouchObject = nil
	p26.moveVector = Vector3.new(0, 0, 0)
	p26:FadeThumbstick(false)
end
function v_u_16.FadeThumbstick(p27, p28)
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_2
	if p28 or not p27.moveTouchObject then
		if p27.isFirstTouch then
			return
		else
			if p27.startImageFadeTween then
				p27.startImageFadeTween:Cancel()
			end
			if p27.endImageFadeTween then
				p27.endImageFadeTween:Cancel()
			end
			for v29 = 1, #p27.middleImages do
				if p27.middleImageFadeTweens[v29] then
					p27.middleImageFadeTweens[v29]:Cancel()
				end
			end
			if p28 then
				p27.startImageFadeTween = v_u_10:Create(p27.startImage, v_u_4, {
					["ImageTransparency"] = 0
				})
				p27.startImageFadeTween:Play()
				p27.endImageFadeTween = v_u_10:Create(p27.endImage, v_u_4, {
					["ImageTransparency"] = 0.2
				})
				p27.endImageFadeTween:Play()
				for v30 = 1, #p27.middleImages do
					p27.middleImageFadeTweens[v30] = v_u_10:Create(p27.middleImages[v30], v_u_4, {
						["ImageTransparency"] = v_u_2[v30]
					})
					p27.middleImageFadeTweens[v30]:Play()
				end
			else
				p27.startImageFadeTween = v_u_10:Create(p27.startImage, v_u_4, {
					["ImageTransparency"] = 1
				})
				p27.startImageFadeTween:Play()
				p27.endImageFadeTween = v_u_10:Create(p27.endImage, v_u_4, {
					["ImageTransparency"] = 1
				})
				p27.endImageFadeTween:Play()
				for v31 = 1, #p27.middleImages do
					p27.middleImageFadeTweens[v31] = v_u_10:Create(p27.middleImages[v31], v_u_4, {
						["ImageTransparency"] = 1
					})
					p27.middleImageFadeTweens[v31]:Play()
				end
			end
		end
	else
		return
	end
end
function v_u_16.FadeThumbstickFrame(p32, p33, p34)
	p32.fadeInAndOutHalfDuration = p33 * 0.5
	p32.fadeInAndOutBalance = p34
	p32.tweenInAlphaStart = tick()
end
function v_u_16.InputInFrame(p35, p36)
	local v37 = p35.thumbstickFrame.AbsolutePosition
	local v38 = v37 + p35.thumbstickFrame.AbsoluteSize
	local v39 = p36.Position
	return v39.X >= v37.X and (v39.Y >= v37.Y and (v39.X <= v38.X and v39.Y <= v38.Y))
end
function v_u_16.DoFadeInBackground(p40)
	-- upvalues: (ref) v_u_14
	local v41 = v_u_14:FindFirstChildOfClass("PlayerGui")
	local v42 = false
	if v41 then
		if v41.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v41.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
			v42 = p40.hasFadedBackgroundInLandscape
			p40.hasFadedBackgroundInLandscape = true
		elseif v41.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
			v42 = p40.hasFadedBackgroundInPortrait
			p40.hasFadedBackgroundInPortrait = true
		end
	end
	if not v42 then
		p40.fadeInAndOutHalfDuration = 0.3
		p40.fadeInAndOutBalance = 0.5
		p40.tweenInAlphaStart = tick()
	end
end
function v_u_16.DoMove(p43, p44)
	local v45
	if p44.Magnitude < p43.radiusOfDeadZone then
		v45 = Vector3.new(0, 0, 0)
	else
		local v46 = p44.Unit
		local v47 = (p43.radiusOfMaxSpeed - p44.Magnitude) / p43.radiusOfMaxSpeed
		local v48 = v46 * (1 - math.max(0, v47))
		local v49 = v48.X
		local v50 = v48.Y
		v45 = Vector3.new(v49, 0, v50)
	end
	p43.moveVector = v45
end
function v_u_16.LayoutMiddleImages(p51, p52, p53)
	-- upvalues: (copy) v_u_3
	local v54 = p51.thumbstickSize / 2 + p51.middleSize
	local v55 = p53 - p52
	local v56 = v55.Magnitude - p51.thumbstickRingSize / 2 - p51.middleSize
	local v57 = v55.Unit
	local v58 = p51.middleSpacing * v_u_3
	local v59 = p51.middleSpacing
	if v58 < v56 then
		v59 = v56 / v_u_3
	end
	for v60 = 1, v_u_3 do
		local v61 = p51.middleImages[v60]
		local v62 = v54 + v59 * (v60 - 2)
		local v63 = v54 + v59 * (v60 - 1)
		if v62 < v56 then
			local v64 = p53 - v57 * v63
			local v65 = 1 - (v63 - v56) / v59
			local v66 = math.clamp(v65, 0, 1)
			v61.Visible = true
			v61.Position = UDim2.new(0, v64.X, 0, v64.Y)
			v61.Size = UDim2.new(0, p51.middleSize * v66, 0, p51.middleSize * v66)
		else
			v61.Visible = false
		end
	end
end
function v_u_16.MoveStick(p67, p68)
	local v69 = Vector2.new(p67.moveTouchStartPosition.X, p67.moveTouchStartPosition.Y) - p67.thumbstickFrame.AbsolutePosition
	local v70 = Vector2.new(p68.X, p68.Y) - p67.thumbstickFrame.AbsolutePosition
	p67.endImage.Position = UDim2.new(0, v70.X, 0, v70.Y)
	p67:LayoutMiddleImages(v69, v70)
end
function v_u_16.BindContextActions(p_u_71)
	-- upvalues: (copy) v_u_10, (copy) v_u_8, (copy) v_u_1, (copy) v_u_7
	local function v_u_74(p72)
		-- upvalues: (copy) p_u_71, (ref) v_u_10
		if p_u_71.moveTouchObject then
			return Enum.ContextActionResult.Pass
		end
		if not p_u_71:InputInFrame(p72) then
			return Enum.ContextActionResult.Pass
		end
		if p_u_71.isFirstTouch then
			p_u_71.isFirstTouch = false
			local v73 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
			v_u_10:Create(p_u_71.startImage, v73, {
				["Size"] = UDim2.new(0, 0, 0, 0)
			}):Play()
			v_u_10:Create(p_u_71.endImage, v73, {
				["Size"] = UDim2.new(0, p_u_71.thumbstickSize, 0, p_u_71.thumbstickSize),
				["ImageColor3"] = Color3.new(0, 0, 0)
			}):Play()
		end
		p_u_71.moveTouchLockedIn = false
		p_u_71.moveTouchObject = p72
		p_u_71.moveTouchStartPosition = p72.Position
		p_u_71.moveTouchFirstChanged = true
		p_u_71:DoFadeInBackground()
		return Enum.ContextActionResult.Pass
	end
	local function v_u_80(p75)
		-- upvalues: (copy) p_u_71
		if p75 ~= p_u_71.moveTouchObject then
			return Enum.ContextActionResult.Pass
		end
		if p_u_71.moveTouchFirstChanged then
			p_u_71.moveTouchFirstChanged = false
			local v76 = Vector2.new(p75.Position.X - p_u_71.thumbstickFrame.AbsolutePosition.X, p75.Position.Y - p_u_71.thumbstickFrame.AbsolutePosition.Y)
			p_u_71.startImage.Visible = true
			p_u_71.startImage.Position = UDim2.new(0, v76.X, 0, v76.Y)
			p_u_71.endImage.Visible = true
			p_u_71.endImage.Position = p_u_71.startImage.Position
			p_u_71:FadeThumbstick(true)
			p_u_71:MoveStick(p75.Position)
		end
		p_u_71.moveTouchLockedIn = true
		local v77 = Vector2.new(p75.Position.X - p_u_71.moveTouchStartPosition.X, p75.Position.Y - p_u_71.moveTouchStartPosition.Y)
		local v78 = v77.X
		if math.abs(v78) <= 0 then
			local v79 = v77.Y
			if math.abs(v79) <= 0 then
				::l7::
				return Enum.ContextActionResult.Sink
			end
		end
		p_u_71:DoMove(v77)
		p_u_71:MoveStick(p75.Position)
		goto l7
	end
	v_u_8:BindActionAtPriority("DynamicThumbstickAction", function(_, p81, p82)
		-- upvalues: (copy) v_u_74, (copy) p_u_71
		if p81 == Enum.UserInputState.Begin then
			return v_u_74(p82)
		elseif p81 == Enum.UserInputState.Change then
			if p82 == p_u_71.moveTouchObject then
				return Enum.ContextActionResult.Sink
			else
				return Enum.ContextActionResult.Pass
			end
		else
			if p81 == Enum.UserInputState.End then
				if p82 == p_u_71.moveTouchObject then
					p_u_71:OnInputEnded()
					if p_u_71.moveTouchLockedIn then
						return Enum.ContextActionResult.Sink
					end
				end
				return Enum.ContextActionResult.Pass
			end
			if p81 == Enum.UserInputState.Cancel then
				p_u_71:OnInputEnded()
			end
			return
		end
	end, false, v_u_1, Enum.UserInputType.Touch)
	p_u_71.TouchMovedCon = v_u_7.TouchMoved:Connect(function(p83, _)
		-- upvalues: (copy) v_u_80
		v_u_80(p83)
	end)
end
function v_u_16.UnbindContextActions(p84)
	-- upvalues: (copy) v_u_8
	v_u_8:UnbindAction("DynamicThumbstickAction")
	if p84.TouchMovedCon then
		p84.TouchMovedCon:Disconnect()
	end
end
function v_u_16.Create(p_u_85, p_u_86)
	-- upvalues: (ref) v_u_13, (copy) v_u_3, (copy) v_u_2, (copy) v_u_9, (copy) v_u_7, (copy) v_u_6, (ref) v_u_14
	if p_u_85.thumbstickFrame then
		p_u_85.thumbstickFrame:Destroy()
		p_u_85.thumbstickFrame = nil
		if p_u_85.onRenderSteppedConn then
			p_u_85.onRenderSteppedConn:Disconnect()
			p_u_85.onRenderSteppedConn = nil
		end
		if p_u_85.absoluteSizeChangedConn then
			p_u_85.absoluteSizeChangedConn:Disconnect()
			p_u_85.absoluteSizeChangedConn = nil
		end
	end
	local v_u_87 = v_u_13 and 100 or 0
	p_u_85.thumbstickFrame = Instance.new("Frame")
	p_u_85.thumbstickFrame.BorderSizePixel = 0
	p_u_85.thumbstickFrame.Name = "DynamicThumbstickFrame"
	p_u_85.thumbstickFrame.Visible = false
	p_u_85.thumbstickFrame.BackgroundTransparency = 1
	p_u_85.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	p_u_85.thumbstickFrame.Active = false
	p_u_85.thumbstickFrame.Size = UDim2.new(0.4, v_u_87, 0.6666666666666666, v_u_87)
	p_u_85.thumbstickFrame.Position = UDim2.new(0, -v_u_87, 0.3333333333333333, 0)
	p_u_85.startImage = Instance.new("ImageLabel")
	p_u_85.startImage.Name = "ThumbstickStart"
	p_u_85.startImage.Visible = true
	p_u_85.startImage.BackgroundTransparency = 1
	p_u_85.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
	p_u_85.startImage.ImageRectOffset = Vector2.new(1, 1)
	p_u_85.startImage.ImageRectSize = Vector2.new(144, 144)
	p_u_85.startImage.ImageColor3 = Color3.new(0, 0, 0)
	p_u_85.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
	p_u_85.startImage.ZIndex = 10
	p_u_85.startImage.Parent = p_u_85.thumbstickFrame
	p_u_85.endImage = Instance.new("ImageLabel")
	p_u_85.endImage.Name = "ThumbstickEnd"
	p_u_85.endImage.Visible = true
	p_u_85.endImage.BackgroundTransparency = 1
	p_u_85.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
	p_u_85.endImage.ImageRectOffset = Vector2.new(1, 1)
	p_u_85.endImage.ImageRectSize = Vector2.new(144, 144)
	p_u_85.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
	p_u_85.endImage.ZIndex = 10
	p_u_85.endImage.Parent = p_u_85.thumbstickFrame
	local function v_u_89(p88)
		-- upvalues: (copy) p_u_85, (copy) v_u_87
		if p88 then
			p_u_85.thumbstickFrame.Size = UDim2.new(1, v_u_87, 0.4, v_u_87)
			p_u_85.thumbstickFrame.Position = UDim2.new(0, -v_u_87, 0.6, 0)
		else
			p_u_85.thumbstickFrame.Size = UDim2.new(0.4, v_u_87, 0.6666666666666666, v_u_87)
			p_u_85.thumbstickFrame.Position = UDim2.new(0, -v_u_87, 0.3333333333333333, 0)
		end
	end
	for v90 = 1, v_u_3 do
		p_u_85.middleImages[v90] = Instance.new("ImageLabel")
		p_u_85.middleImages[v90].Name = "ThumbstickMiddle"
		p_u_85.middleImages[v90].Visible = false
		p_u_85.middleImages[v90].BackgroundTransparency = 1
		p_u_85.middleImages[v90].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
		p_u_85.middleImages[v90].ImageRectOffset = Vector2.new(1, 1)
		p_u_85.middleImages[v90].ImageRectSize = Vector2.new(144, 144)
		p_u_85.middleImages[v90].ImageTransparency = v_u_2[v90]
		p_u_85.middleImages[v90].AnchorPoint = Vector2.new(0.5, 0.5)
		p_u_85.middleImages[v90].ZIndex = 9
		p_u_85.middleImages[v90].Parent = p_u_85.thumbstickFrame
	end
	local function v94()
		-- upvalues: (copy) p_u_86, (copy) p_u_85, (copy) v_u_87
		local v91 = p_u_86.AbsoluteSize
		local v92 = v91.X
		local v93 = v91.Y
		if math.min(v92, v93) > 500 then
			p_u_85.thumbstickSize = 90
			p_u_85.thumbstickRingSize = 40
			p_u_85.middleSize = 20
			p_u_85.middleSpacing = 28
			p_u_85.radiusOfDeadZone = 4
			p_u_85.radiusOfMaxSpeed = 40
		else
			p_u_85.thumbstickSize = 45
			p_u_85.thumbstickRingSize = 20
			p_u_85.middleSize = 10
			p_u_85.middleSpacing = 14
			p_u_85.radiusOfDeadZone = 2
			p_u_85.radiusOfMaxSpeed = 20
		end
		p_u_85.startImage.Position = UDim2.new(0, p_u_85.thumbstickRingSize * 3.3 + v_u_87, 1, -p_u_85.thumbstickRingSize * 2.8 - v_u_87)
		p_u_85.startImage.Size = UDim2.new(0, p_u_85.thumbstickRingSize * 3.7, 0, p_u_85.thumbstickRingSize * 3.7)
		p_u_85.endImage.Position = p_u_85.startImage.Position
		p_u_85.endImage.Size = UDim2.new(0, p_u_85.thumbstickSize * 0.8, 0, p_u_85.thumbstickSize * 0.8)
	end
	v94()
	p_u_85.absoluteSizeChangedConn = p_u_86:GetPropertyChangedSignal("AbsoluteSize"):Connect(v94)
	local v_u_95 = nil
	local function v100()
		-- upvalues: (ref) v_u_95, (copy) v_u_89
		if v_u_95 then
			v_u_95:Disconnect()
			v_u_95 = nil
		end
		local v_u_96 = workspace.CurrentCamera
		if v_u_96 then
			local function v98()
				-- upvalues: (copy) v_u_96, (ref) v_u_89
				local v97 = v_u_96.ViewportSize
				v_u_89(v97.X < v97.Y)
			end
			v_u_95 = v_u_96:GetPropertyChangedSignal("ViewportSize"):Connect(v98)
			local v99 = v_u_96.ViewportSize
			v_u_89(v99.X < v99.Y)
		end
	end
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(v100)
	if workspace.CurrentCamera then
		v100()
	end
	p_u_85.moveTouchStartPosition = nil
	p_u_85.startImageFadeTween = nil
	p_u_85.endImageFadeTween = nil
	p_u_85.middleImageFadeTweens = {}
	p_u_85.onRenderSteppedConn = v_u_9.RenderStepped:Connect(function()
		-- upvalues: (copy) p_u_85
		if p_u_85.tweenInAlphaStart == nil then
			if p_u_85.tweenOutAlphaStart ~= nil then
				local v101 = tick() - p_u_85.tweenOutAlphaStart
				local v102 = p_u_85.fadeInAndOutHalfDuration * 2 - p_u_85.fadeInAndOutHalfDuration * 2 * p_u_85.fadeInAndOutBalance
				local v103 = p_u_85.thumbstickFrame
				local v104 = v101 / v102
				v103.BackgroundTransparency = math.min(v104, 1) * 0.35 + 0.65
				if v102 < v101 then
					p_u_85.tweenOutAlphaStart = nil
				end
			end
		else
			local v105 = tick() - p_u_85.tweenInAlphaStart
			local v106 = p_u_85.fadeInAndOutHalfDuration * 2 * p_u_85.fadeInAndOutBalance
			local v107 = p_u_85.thumbstickFrame
			local v108 = v105 / v106
			v107.BackgroundTransparency = 1 - math.min(v108, 1) * 0.35
			if v106 < v105 then
				p_u_85.tweenOutAlphaStart = tick()
				p_u_85.tweenInAlphaStart = nil
				return
			end
		end
	end)
	p_u_85.onTouchEndedConn = v_u_7.TouchEnded:connect(function(p109)
		-- upvalues: (copy) p_u_85
		if p109 == p_u_85.moveTouchObject then
			p_u_85:OnInputEnded()
		end
	end)
	v_u_6.MenuOpened:connect(function()
		-- upvalues: (copy) p_u_85
		if p_u_85.moveTouchObject then
			p_u_85:OnInputEnded()
		end
	end)
	local v_u_110 = v_u_14:FindFirstChildOfClass("PlayerGui")
	while not v_u_110 do
		v_u_14.ChildAdded:wait()
		v_u_110 = v_u_14:FindFirstChildOfClass("PlayerGui")
	end
	local v_u_111 = nil
	local v_u_112 = v_u_110.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or v_u_110.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight
	local _ = v_u_110:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function()
		-- upvalues: (copy) v_u_112, (ref) v_u_110, (ref) v_u_111, (copy) p_u_85
		if v_u_112 and v_u_110.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait or not v_u_112 and v_u_110.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
			v_u_111:disconnect()
			p_u_85.fadeInAndOutHalfDuration = 2.5
			p_u_85.fadeInAndOutBalance = 0.05
			p_u_85.tweenInAlphaStart = tick()
			if v_u_112 then
				p_u_85.hasFadedBackgroundInPortrait = true
				return
			end
			p_u_85.hasFadedBackgroundInLandscape = true
		end
	end)
	p_u_85.thumbstickFrame.Parent = p_u_86
	if game:IsLoaded() then
		p_u_85.fadeInAndOutHalfDuration = 2.5
		p_u_85.fadeInAndOutBalance = 0.05
		p_u_85.tweenInAlphaStart = tick()
	else
		coroutine.wrap(function()
			-- upvalues: (copy) p_u_85
			game.Loaded:Wait()
			p_u_85.fadeInAndOutHalfDuration = 2.5
			p_u_85.fadeInAndOutBalance = 0.05
			p_u_85.tweenInAlphaStart = tick()
		end)()
	end
end
return v_u_16