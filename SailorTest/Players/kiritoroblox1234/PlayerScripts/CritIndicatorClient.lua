local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = v1.LocalPlayer
local v5 = v2:WaitForChild("RemoteEvents"):WaitForChild("CritIndicator")
local v_u_6 = Color3.fromRGB(200, 30, 30)
local v_u_7 = Color3.fromRGB(60, 0, 0)
v5.OnClientEvent:Connect(function(p8)
	-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_7, (copy) v_u_3
	if p8 then
		if v_u_4:GetAttribute("DisableCritIndicator") then
			return
		else
			local v9 = p8:FindFirstChild("Head")
			if v9 then
				local v10 = (math.random() - 0.5) * 2 * 3
				local v11 = (math.random() - 0.5) * 2 * 3
				local v_u_12 = Instance.new("BillboardGui")
				v_u_12.Name = "CritLabel"
				v_u_12.Adornee = v9
				v_u_12.Size = UDim2.new(4, 0, 1.5, 0)
				v_u_12.StudsOffset = Vector3.new(0, 3, 0)
				v_u_12.AlwaysOnTop = true
				v_u_12.MaxDistance = 80
				v_u_12.LightInfluence = 0
				v_u_12.Parent = v9
				local v13 = Instance.new("TextLabel")
				v13.Name = "CritText"
				v13.Size = UDim2.new(1, 0, 1, 0)
				v13.BackgroundTransparency = 1
				v13.Text = "CRIT!"
				v13.TextColor3 = v_u_6
				v13.TextScaled = true
				v13.Font = Enum.Font.GothamBold
				v13.TextTransparency = 0
				v13.Parent = v_u_12
				local v14 = Instance.new("UIStroke")
				v14.Color = v_u_7
				v14.Thickness = 2
				v14.Transparency = 0
				v14.Parent = v13
				local v15 = Instance.new("UIScale")
				v15.Scale = 1.4
				v15.Parent = v13
				local v16 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				v_u_3:Create(v_u_12, v16, {
					["StudsOffset"] = Vector3.new(v10, 7, v11)
				}):Play()
				v_u_3:Create(v13, v16, {
					["TextTransparency"] = 1
				}):Play()
				v_u_3:Create(v14, v16, {
					["Transparency"] = 1
				}):Play()
				v_u_3:Create(v15, v16, {
					["Scale"] = 0.7
				}):Play()
				task.delay(0.9, function()
					-- upvalues: (copy) v_u_12
					if v_u_12 and v_u_12.Parent then
						v_u_12:Destroy()
					end
				end)
			end
		end
	else
		return
	end
end)