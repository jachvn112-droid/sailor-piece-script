local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = v1.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = workspace.CurrentCamera
local v_u_8 = v2:WaitForChild("RemoteEvents")
local v_u_9 = v_u_8:WaitForChild("GetQuestArrowTarget")
local v10 = v_u_8:WaitForChild("QuestArrowUpdate")
local v_u_11 = {
	["pingColor"] = Color3.fromRGB(180, 100, 220),
	["edgeMargin"] = 60,
	["hideDistance"] = 5,
	["fadeStartDistance"] = 25,
	["targetHeightOffset"] = 0,
	["updateInterval"] = 2,
	["pulseSpeed"] = 1.5,
	["pulseScale"] = 0.1,
	["arrowOrbitRadius"] = 28,
	["pingIconSize"] = 36,
	["edgeIconSize"] = 36,
	["hoverScale"] = 1.1,
	["clickScale"] = 0.9,
	["animDuration"] = 0.15
}
local v12 = v_u_6:WaitForChild("QuestPingUI")
local v_u_13 = v12:WaitForChild("PingMarker")
local v_u_14 = v12:WaitForChild("EdgeIndicator")
local v_u_15 = v_u_13:WaitForChild("IconBackground")
local v_u_16 = v_u_13:WaitForChild("DistanceLabel")
local v_u_17 = v_u_14:WaitForChild("IconBackground")
local v_u_18 = v_u_14:WaitForChild("Arrow")
local v_u_19 = v_u_14:WaitForChild("DistanceLabel")
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = {}
local function v_u_24()
	-- upvalues: (ref) v_u_22
	for _, v23 in ipairs(v_u_22) do
		if v23 and v23.Connected then
			v23:Disconnect()
		end
	end
	v_u_22 = {}
end
local v_u_25 = false
local v_u_26 = false
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = 0
local v_u_30 = 0
local v_u_31 = false
local function v_u_42(p32, p33)
	-- upvalues: (copy) v_u_11
	local v34 = v_u_11.edgeMargin
	local v35 = p33.X / 2
	local v36 = p33.Y / 2
	local v37 = p32.X - v35
	local v38 = p32.Y - v36
	local v39 = (1 / 0)
	local v40 = (1 / 0)
	if v37 > 0 then
		v39 = (p33.X - v34 - v35) / v37
	elseif v37 < 0 then
		v39 = (v34 - v35) / v37
	end
	if v38 > 0 then
		v40 = (p33.Y - v34 - v36) / v38
	elseif v38 < 0 then
		v40 = (v34 - v36) / v38
	end
	local v41 = math.min(v39, v40, 1)
	return Vector2.new(v35 + v37 * v41, v36 + v38 * v41)
end
local function v_u_52(p43)
	local v44 = workspace:FindFirstChild("NPCs")
	local v45 = v44 and v44:FindFirstChild(p43)
	local v46 = v45 and (v45:FindFirstChild("HumanoidRootPart") or (v45:FindFirstChild("Torso") or v45.PrimaryPart))
	if v46 then
		return v46.Position
	else
		local v47 = workspace:FindFirstChild("ServiceNPCs")
		local v48 = v47 and v47:FindFirstChild(p43)
		local v49 = v48 and (v48:FindFirstChild("HumanoidRootPart") or (v48:FindFirstChild("Torso") or v48.PrimaryPart))
		if v49 then
			return v49.Position
		else
			local v50 = workspace:FindFirstChild(p43)
			local v51 = v50 and (v50:FindFirstChild("HumanoidRootPart") or (v50:FindFirstChild("Torso") or v50.PrimaryPart))
			if v51 then
				return v51.Position
			else
				return nil
			end
		end
	end
end
local function v_u_72()
	-- upvalues: (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (copy) v_u_13, (copy) v_u_14, (copy) v_u_5, (copy) v_u_11, (copy) v_u_7, (copy) v_u_16, (copy) v_u_42, (copy) v_u_19, (copy) v_u_18, (copy) v_u_17
	if v_u_25 and (v_u_26 and v_u_27) then
		local v53 = v_u_5.Character
		if v53 then
			local v54 = v53:FindFirstChild("HumanoidRootPart")
			if v54 then
				local v55 = (v54.Position - v_u_27).Magnitude
				local v56 = math.floor(v55) .. "m"
				local v57 = 1
				if v55 < v_u_11.hideDistance then
					v57 = 0
				elseif v55 < v_u_11.fadeStartDistance then
					v57 = (v55 - v_u_11.hideDistance) / (v_u_11.fadeStartDistance - v_u_11.hideDistance)
				end
				if v57 <= 0 then
					v_u_13.Visible = false
					v_u_14.Visible = false
					return
				else
					local v58 = v_u_27
					local v59 = v_u_11.targetHeightOffset
					local v60, v61 = v_u_7:WorldToViewportPoint(v58 + Vector3.new(0, v59, 0))
					local v62 = Vector2.new(v60.X, v60.Y)
					local v63 = v60.Z
					local v64 = v_u_7.ViewportSize
					local v65 = v63 < 0
					if v61 and not v65 then
						v_u_13.Visible = true
						v_u_14.Visible = false
						v_u_13.Position = UDim2.new(0, v62.X, 0, v62.Y)
						v_u_16.Text = v56
						v_u_13.GroupTransparency = 1 - v57
					else
						v_u_13.Visible = false
						v_u_14.Visible = true
						if v65 then
							v62 = Vector2.new(v64.X - v62.X, v64.Y - v62.Y)
						end
						local v66 = v_u_42(v62, v64)
						v_u_14.Position = UDim2.new(0, v66.X, 0, v66.Y)
						v_u_19.Text = v56
						local v67 = v62 - v66
						local v68 = v67.Y
						local v69 = v67.X
						local v70 = math.atan2(v68, v69)
						local v71 = v_u_11.arrowOrbitRadius
						v_u_18.Position = UDim2.new(0.5, math.cos(v70) * v71, 0.5, math.sin(v70) * v71)
						v_u_18.Rotation = math.deg(v70) - 90
						v_u_17.BackgroundTransparency = 1 - v57
						v_u_18.ImageTransparency = 1 - v57
						v_u_19.TextTransparency = 1 - v57
						v_u_19.BackgroundTransparency = (1 - v57) * 0.7 + 0.3
					end
				end
			else
				return
			end
		else
			return
		end
	else
		v_u_13.Visible = false
		v_u_14.Visible = false
		return
	end
end
local function v_u_76(p73)
	-- upvalues: (ref) v_u_25, (ref) v_u_26, (ref) v_u_30, (copy) v_u_11, (copy) v_u_15, (copy) v_u_17
	if v_u_25 and v_u_26 then
		v_u_30 = v_u_30 + p73 * v_u_11.pulseSpeed
		local v74 = v_u_30 * 3.141592653589793 * 2
		local v75 = 1 + math.sin(v74) * v_u_11.pulseScale
		v_u_15.Size = UDim2.new(0, v_u_11.pingIconSize * v75, 0, v_u_11.pingIconSize * v75)
		v_u_17.Size = UDim2.new(0, v_u_11.edgeIconSize * v75, 0, v_u_11.edgeIconSize * v75)
	end
end
local function v_u_85()
	-- upvalues: (ref) v_u_25, (ref) v_u_20, (copy) v_u_9, (copy) v_u_52, (ref) v_u_28, (ref) v_u_27, (ref) v_u_26, (copy) v_u_13, (copy) v_u_14
	v_u_25 = not v_u_25
	if v_u_20 then
		local v77 = v_u_20:FindFirstChild("On")
		local v78 = v_u_20:FindFirstChild("Off")
		if v77 and v78 then
			v77.Visible = v_u_25
			v78.Visible = not v_u_25
		end
	end
	if v_u_25 then
		local v79 = v_u_9:InvokeServer()
		if v79 and (type(v79) == "table" and v79.npcName) then
			local v80 = v79.npcName
			local v81 = v79.position or v_u_52(v79.npcName)
			v_u_28 = v80
			v_u_27 = v81
			local v82
			if v80 == nil then
				v82 = false
			else
				v82 = v81 ~= nil
			end
			v_u_26 = v82
			return
		elseif v79 and type(v79) == "string" then
			local v83 = v_u_52(v79)
			v_u_28 = v79
			v_u_27 = v83
			local v84
			if v79 == nil then
				v84 = false
			else
				v84 = v83 ~= nil
			end
			v_u_26 = v84
		else
			v_u_26 = false
		end
	else
		v_u_13.Visible = false
		v_u_14.Visible = false
		return
	end
end
local function v_u_98()
	-- upvalues: (copy) v_u_24, (copy) v_u_6, (ref) v_u_20, (ref) v_u_21, (ref) v_u_25, (copy) v_u_4, (copy) v_u_11, (ref) v_u_22, (copy) v_u_85, (ref) v_u_31
	v_u_24()
	local v86 = v_u_6:WaitForChild("QuestTrackingUI", 10)
	if not v86 then
		warn("[QuestPingClient] QuestTrackingUI not found after 10s")
		return false
	end
	local v87 = v86:WaitForChild("Quest", 5)
	if not v87 then
		warn("[QuestPingClient] Quest frame not found")
		return false
	end
	v_u_20 = v87:WaitForChild("QuestArrowButton", 5)
	if not v_u_20 then
		warn("[QuestPingClient] QuestArrowButton not found")
		return false
	end
	v_u_21 = v_u_20.Size
	if v_u_20 then
		local v88 = v_u_20:FindFirstChild("On")
		local v89 = v_u_20:FindFirstChild("Off")
		if v88 and v89 then
			v88.Visible = v_u_25
			v89.Visible = not v_u_25
		end
	end
	local v90 = v_u_20.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_4, (ref) v_u_20, (ref) v_u_11, (ref) v_u_21
		v_u_4:Create(v_u_20, TweenInfo.new(v_u_11.animDuration), {
			["Size"] = UDim2.new(v_u_21.X.Scale * v_u_11.hoverScale, 0, v_u_21.Y.Scale * v_u_11.hoverScale, 0)
		}):Play()
	end)
	local v91 = v_u_22
	table.insert(v91, v90)
	local v93 = v_u_20.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_4, (ref) v_u_20, (ref) v_u_11, (ref) v_u_21
		local v92 = {
			["Size"] = v_u_21
		}
		v_u_4:Create(v_u_20, TweenInfo.new(v_u_11.animDuration), v92):Play()
	end)
	local v94 = v_u_22
	table.insert(v94, v93)
	local v96 = v_u_20.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_4, (ref) v_u_20, (ref) v_u_21, (ref) v_u_11, (ref) v_u_85
		v_u_4:Create(v_u_20, TweenInfo.new(0.1), {
			["Size"] = UDim2.new(v_u_21.X.Scale * v_u_11.clickScale, 0, v_u_21.Y.Scale * v_u_11.clickScale, 0)
		}):Play()
		task.wait(0.1)
		local v95 = {
			["Size"] = v_u_21
		}
		v_u_4:Create(v_u_20, TweenInfo.new(0.1), v95):Play()
		v_u_85()
	end)
	local v97 = v_u_22
	table.insert(v97, v96)
	v_u_31 = true
	return true
end
local function v_u_99()
	-- upvalues: (copy) v_u_98
	for _ = 1, 10 do
		if v_u_98() then
			return true
		end
		task.wait(0.5)
	end
	warn("[QuestPingClient] Failed to setup button after " .. 10 .. " attempts")
	return false
end
v10.OnClientEvent:Connect(function(p100)
	-- upvalues: (ref) v_u_25, (copy) v_u_52, (ref) v_u_28, (ref) v_u_27, (ref) v_u_26, (copy) v_u_13, (copy) v_u_14
	if v_u_25 then
		if p100 and (type(p100) == "table" and p100.npcName) then
			local v101 = p100.npcName
			local v102 = p100.position or v_u_52(p100.npcName)
			v_u_28 = v101
			v_u_27 = v102
			local v103
			if v101 == nil then
				v103 = false
			else
				v103 = v102 ~= nil
			end
			v_u_26 = v103
			return
		elseif p100 and type(p100) == "string" then
			local v104 = v_u_52(p100)
			v_u_28 = p100
			v_u_27 = v104
			local v105
			if p100 == nil then
				v105 = false
			else
				v105 = v104 ~= nil
			end
			v_u_26 = v105
		else
			v_u_26 = false
			v_u_27 = nil
			v_u_28 = nil
			v_u_13.Visible = false
			v_u_14.Visible = false
		end
	else
		return
	end
end)
v3.RenderStepped:Connect(function(p106)
	-- upvalues: (copy) v_u_5, (ref) v_u_29, (ref) v_u_25, (ref) v_u_28, (copy) v_u_52, (ref) v_u_27, (copy) v_u_11, (copy) v_u_72, (copy) v_u_76
	if not v_u_5:GetAttribute("IsTeleporting") then
		v_u_29 = v_u_29 + 1
		local v107 = v_u_29 % 30 == 0 and (v_u_25 and v_u_28) and v_u_52(v_u_28)
		if v107 then
			v_u_27 = v107
		end
		if v_u_29 % v_u_11.updateInterval == 0 then
			v_u_72()
		end
		v_u_76(p106)
	end
end);
(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_85
	local v108 = v_u_8:FindFirstChild("GamepadQuestTrackerToggle")
	if not v108 then
		v108 = Instance.new("BindableEvent")
		v108.Name = "GamepadQuestTrackerToggle"
		v108.Parent = v_u_8
	end
	v108.Event:Connect(function()
		-- upvalues: (ref) v_u_85
		v_u_85()
	end)
end)()
v_u_5.CharacterAdded:Connect(function()
	-- upvalues: (ref) v_u_25, (copy) v_u_9, (copy) v_u_52, (ref) v_u_28, (ref) v_u_27, (ref) v_u_26
	task.wait(0.5)
	if v_u_25 then
		local v109 = v_u_9:InvokeServer()
		if v109 and (type(v109) == "table" and v109.npcName) then
			local v110 = v109.npcName
			local v111 = v109.position or v_u_52(v109.npcName)
			v_u_28 = v110
			v_u_27 = v111
			local v112
			if v110 == nil then
				v112 = false
			else
				v112 = v111 ~= nil
			end
			v_u_26 = v112
		end
	end
end)
v_u_13.Visible = false
v_u_14.Visible = false
v_u_25 = false
task.spawn(function()
	-- upvalues: (copy) v_u_99
	v_u_99()
end)