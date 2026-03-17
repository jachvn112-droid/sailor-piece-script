local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = v1.LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui"):WaitForChild("DamageCounterUI"):WaitForChild("DamageFrame")
local v6 = v_u_5:WaitForChild("Holder")
local v_u_7 = v6:FindFirstChild("Holder")
if v_u_7 then
	v_u_7 = v_u_7:FindFirstChild("Loader")
end
local v_u_8 = v6:FindFirstChild("StatFrame")
local v_u_9
if v_u_8 then
	v_u_9 = v_u_8:FindFirstChild("DamageLabel")
else
	v_u_9 = v_u_8
end
local v10 = v2:WaitForChild("RemoteEvents"):WaitForChild("DamageCounter")
local v_u_11 = {
	["EXPIRE_TIME"] = 3,
	["BASE_POSITION_X"] = 0.093,
	["BASE_POSITION_Y"] = 0.6,
	["POSITION_VARIANCE_X"] = 0.02,
	["POSITION_VARIANCE_Y"] = 0.05,
	["BAR_TWEEN_STYLE"] = Enum.EasingStyle.Linear,
	["POSITION_TWEEN_TIME"] = 0.1,
	["NUMBER_BUMP_SCALE"] = 1.1
}
local v_u_12 = 0
local v_u_13 = false
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local function v_u_21(p17)
	local v18 = math.floor(p17)
	local v19 = tostring(v18)
	repeat
		local v20
		v19, v20 = v19:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
	until v20 == 0
	return v19
end
local function v_u_24()
	-- upvalues: (copy) v_u_11
	local v22 = (math.random() - 0.5) * v_u_11.POSITION_VARIANCE_X * 2
	local v23 = (math.random() - 0.5) * v_u_11.POSITION_VARIANCE_Y * 2
	return UDim2.new(v_u_11.BASE_POSITION_X + v22, 0, v_u_11.BASE_POSITION_Y + v23, 0)
end
local function v_u_26()
	-- upvalues: (ref) v_u_14, (ref) v_u_15, (copy) v_u_7, (copy) v_u_3, (copy) v_u_11, (ref) v_u_13, (copy) v_u_5, (copy) v_u_4, (ref) v_u_12, (copy) v_u_24, (copy) v_u_9
	if v_u_14 then
		task.cancel(v_u_14)
		v_u_14 = nil
	end
	if v_u_15 then
		v_u_15:Cancel()
		v_u_15 = nil
	end
	if v_u_7 then
		v_u_7.Size = UDim2.new(1, 0, 1.5, 0)
		v_u_15 = v_u_3:Create(v_u_7, TweenInfo.new(v_u_11.EXPIRE_TIME, v_u_11.BAR_TWEEN_STYLE), {
			["Size"] = UDim2.new(0, 0, 1.5, 0)
		})
		v_u_15:Play()
	end
	v_u_14 = task.delay(v_u_11.EXPIRE_TIME, function()
		-- upvalues: (ref) v_u_13, (ref) v_u_5, (ref) v_u_4, (ref) v_u_12, (ref) v_u_14, (ref) v_u_24, (ref) v_u_9, (ref) v_u_15
		if v_u_13 then
			v_u_5.Visible = false
			v_u_4:GetAttributeChangedSignal("HideDamageCounter"):Connect(function()
				-- upvalues: (ref) v_u_4, (ref) v_u_13, (ref) v_u_5, (ref) v_u_12, (ref) v_u_14, (ref) v_u_24
				local v25 = v_u_4:GetAttribute("HideDamageCounter")
				if v25 and v_u_13 then
					v_u_5.Visible = false
					v_u_13 = false
				elseif not v25 and (v_u_12 > 0 and (not v_u_13 and v_u_14)) then
					v_u_13 = true
					v_u_5.Position = v_u_24()
					v_u_5.Visible = true
				end
			end)
			v_u_13 = false
			v_u_12 = 0
			if v_u_9 then
				v_u_9.Text = "0"
			end
		end
		v_u_14 = nil
		v_u_15 = nil
	end)
end
local function v_u_30(p27)
	-- upvalues: (copy) v_u_4, (ref) v_u_12, (copy) v_u_9, (copy) v_u_21, (ref) v_u_13, (copy) v_u_5, (copy) v_u_24, (copy) v_u_7, (copy) v_u_3, (copy) v_u_11, (copy) v_u_8, (ref) v_u_16, (copy) v_u_26
	if p27 and p27 > 0 then
		if not v_u_4:GetAttribute("HideDamageCounter") then
			v_u_12 = v_u_12 + p27
			if v_u_9 then
				v_u_9.Text = v_u_21(v_u_12)
			end
			if v_u_13 then
				local v28 = {
					["Position"] = v_u_24()
				}
				v_u_3:Create(v_u_5, TweenInfo.new(v_u_11.POSITION_TWEEN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v28):Play()
			elseif not (v_u_13 or v_u_4:GetAttribute("HideDamageCounter")) then
				v_u_13 = true
				v_u_5.Position = v_u_24()
				v_u_5.Visible = true
				if v_u_7 then
					v_u_7.Size = UDim2.new(1, 0, 1.5, 0)
				end
			end
			if v_u_8 and v_u_16 then
				v_u_8.Size = UDim2.new(v_u_16.X.Scale * v_u_11.NUMBER_BUMP_SCALE, v_u_16.X.Offset, v_u_16.Y.Scale * v_u_11.NUMBER_BUMP_SCALE, v_u_16.Y.Offset)
				local v29 = {
					["Size"] = v_u_16
				}
				v_u_3:Create(v_u_8, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v29):Play()
			end
			v_u_26()
		end
	else
		return
	end
end
v10.OnClientEvent:Connect(function(p31)
	-- upvalues: (copy) v_u_30
	v_u_30(p31)
end)
v_u_4.CharacterAdded:Connect(function()
	-- upvalues: (ref) v_u_12, (ref) v_u_13, (copy) v_u_5, (copy) v_u_4, (ref) v_u_14, (copy) v_u_24, (ref) v_u_15
	v_u_12 = 0
	v_u_13 = false
	v_u_5.Visible = false
	v_u_4:GetAttributeChangedSignal("HideDamageCounter"):Connect(function()
		-- upvalues: (ref) v_u_4, (ref) v_u_13, (ref) v_u_5, (ref) v_u_12, (ref) v_u_14, (ref) v_u_24
		local v32 = v_u_4:GetAttribute("HideDamageCounter")
		if v32 and v_u_13 then
			v_u_5.Visible = false
			v_u_13 = false
		elseif not v32 and (v_u_12 > 0 and (not v_u_13 and v_u_14)) then
			v_u_13 = true
			v_u_5.Position = v_u_24()
			v_u_5.Visible = true
		end
	end)
	if v_u_14 then
		task.cancel(v_u_14)
		v_u_14 = nil
	end
	if v_u_15 then
		v_u_15:Cancel()
		v_u_15 = nil
	end
end)
if v_u_8 then
	v_u_16 = v_u_8.Size
end
v_u_5.Visible = false
v_u_4:GetAttributeChangedSignal("HideDamageCounter"):Connect(function()
	-- upvalues: (copy) v_u_4, (ref) v_u_13, (copy) v_u_5, (ref) v_u_12, (ref) v_u_14, (copy) v_u_24
	local v33 = v_u_4:GetAttribute("HideDamageCounter")
	if v33 and v_u_13 then
		v_u_5.Visible = false
		v_u_13 = false
	elseif not v33 and (v_u_12 > 0 and (not v_u_13 and v_u_14)) then
		v_u_13 = true
		v_u_5.Position = v_u_24()
		v_u_5.Visible = true
	end
end)