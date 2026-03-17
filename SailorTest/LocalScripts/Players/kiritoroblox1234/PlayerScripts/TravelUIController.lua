local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("RunService")
local v_u_5 = v1.LocalPlayer
local v6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = require(v2:WaitForChild("TravelConfig"))
local v_u_8 = v6:WaitForChild("TravelUI"):WaitForChild("LocationUnlock")
local v9 = v_u_8:WaitForChild("Holder")
local v_u_10 = v9:WaitForChild("LocationTitle"):WaitForChild("Txt")
local v_u_11 = v9:WaitForChild("Txt")
local v_u_12 = v9:FindFirstChild("IconHolder")
if v_u_12 then
	v_u_12 = v_u_12:FindFirstChild("Icon")
end
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = false
local v_u_16 = {}
local v_u_17 = {}
local v_u_18 = 0
local v_u_19 = v_u_7.Settings.CheckInterval or 3
local function v26()
	-- upvalues: (ref) v_u_17, (copy) v_u_8
	v_u_17 = {}
	for _, v20 in v_u_8:GetDescendants() do
		if v20:IsA("TextLabel") then
			local v21 = v_u_17
			table.insert(v21, {
				["obj"] = v20,
				["prop"] = "TextTransparency",
				["start"] = 1,
				["target"] = 0
			})
		elseif v20:IsA("ImageLabel") then
			local v22 = v_u_17
			table.insert(v22, {
				["obj"] = v20,
				["prop"] = "ImageTransparency",
				["start"] = 1,
				["target"] = 0
			})
		elseif v20:IsA("UIStroke") then
			local v23 = v_u_17
			table.insert(v23, {
				["obj"] = v20,
				["prop"] = "Transparency",
				["start"] = 1,
				["target"] = 0
			})
		elseif v20:IsA("Frame") and v20.BackgroundTransparency < 1 then
			local v24 = v_u_17
			local v25 = {
				["obj"] = v20,
				["prop"] = "BackgroundTransparency",
				["start"] = 1,
				["target"] = v20.BackgroundTransparency
			}
			table.insert(v24, v25)
		end
	end
end
local function v_u_31(p27, p28)
	-- upvalues: (ref) v_u_17, (copy) v_u_3
	local v29 = TweenInfo.new(p28, Enum.EasingStyle.Quad, p27 and Enum.EasingDirection.Out or Enum.EasingDirection.In)
	for _, v30 in v_u_17 do
		v_u_3:Create(v30.obj, v29, {
			[v30.prop] = p27 and v30.target or v30.start
		}):Play()
	end
end
local function v_u_36(p32, p33)
	-- upvalues: (copy) v_u_16, (copy) v_u_7, (ref) v_u_15, (ref) v_u_14, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12, (copy) v_u_8, (copy) v_u_31
	if p33 then
		local v34 = tick()
		local v_u_35 = p32 or "_sea"
		if v_u_16[v_u_35] and v34 - v_u_16[v_u_35] < v_u_7.Settings.Cooldown then
			return
		elseif not v_u_15 or v_u_14 ~= v_u_35 then
			v_u_15 = true
			v_u_14 = v_u_35
			v_u_16[v_u_35] = v34
			v_u_10.Text = p33.DisplayName
			v_u_11.Text = p33.Description
			if v_u_12 and (p33.Icon and p33.Icon ~= "") then
				v_u_12.Image = p33.Icon
				v_u_12.Visible = true
			elseif v_u_12 then
				v_u_12.Visible = false
			end
			v_u_8.Visible = true
			v_u_31(true, v_u_7.Settings.FadeInTime)
			task.delay(v_u_7.Settings.DisplayTime, function()
				-- upvalues: (ref) v_u_14, (copy) v_u_35, (ref) v_u_31, (ref) v_u_7, (ref) v_u_8, (ref) v_u_15
				if v_u_14 == v_u_35 then
					v_u_31(false, v_u_7.Settings.FadeOutTime)
					task.delay(v_u_7.Settings.FadeOutTime, function()
						-- upvalues: (ref) v_u_14, (ref) v_u_35, (ref) v_u_8, (ref) v_u_15
						if v_u_14 == v_u_35 then
							v_u_8.Visible = false
							v_u_15 = false
						end
					end)
				end
			end)
		end
	else
		return
	end
end
local v_u_37 = nil
local function v42()
	-- upvalues: (ref) v_u_18, (copy) v_u_19, (copy) v_u_5, (ref) v_u_37, (copy) v_u_7, (ref) v_u_13, (copy) v_u_36
	v_u_18 = v_u_18 + 1
	if v_u_18 < v_u_19 then
		return
	else
		v_u_18 = 0
		local v38 = v_u_5.Character
		if v38 then
			if not v_u_37 or v_u_37.Parent ~= v38 then
				v_u_37 = v38:FindFirstChild("HumanoidRootPart")
			end
			if v_u_37 then
				local v39, v40 = v_u_7.GetZoneAt(v_u_37.Position)
				local v41 = v39 or "_sea"
				if v41 ~= v_u_13 then
					v_u_36(v39, v40)
				end
				v_u_13 = v41
			end
		else
			return
		end
	end
end
v26()
v_u_8.Visible = false
local v_u_43 = v_u_37
local v_u_44 = v_u_13
for _, v45 in v_u_17 do
	v45.obj[v45.prop] = v45.start
end
v4.Heartbeat:Connect(v42)
v_u_5.CharacterAdded:Connect(function()
	-- upvalues: (ref) v_u_44, (ref) v_u_43
	v_u_44 = nil
	v_u_43 = nil
	task.wait(1)
end)