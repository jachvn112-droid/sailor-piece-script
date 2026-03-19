local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("ReplicatedStorage")
if not game:IsLoaded() then
	game.Loaded:Wait()
end
local v_u_5 = require(v4:WaitForChild("NPCProximityConfig", 10))
local v_u_6 = v1.LocalPlayer
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = 0
local function v_u_11(p10)
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	if p10.Parent then
		v_u_3:Create(p10, TweenInfo.new(v_u_5.FadeInTime), {
			["OutlineTransparency"] = v_u_5.OutlineTransparency,
			["FillTransparency"] = v_u_5.FillTransparency
		}):Play()
	end
end
local function v_u_13(p12)
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	if p12.Parent then
		v_u_3:Create(p12, TweenInfo.new(v_u_5.FadeOutTime), {
			["OutlineTransparency"] = 1,
			["FillTransparency"] = 1
		}):Play()
	end
end
local function v_u_17(p_u_14)
	-- upvalues: (copy) v_u_5, (copy) v_u_3
	if v_u_5.ShineEnabled and p_u_14.Parent then
		local v_u_15 = TweenInfo.new(v_u_5.ShineDuration / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		local v16 = v_u_3:Create(p_u_14, v_u_15, {
			["FillTransparency"] = v_u_5.ShinePeakTransparency
		})
		v16:Play()
		v16.Completed:Once(function()
			-- upvalues: (copy) p_u_14, (ref) v_u_3, (copy) v_u_15, (ref) v_u_5
			if p_u_14.Parent then
				v_u_3:Create(p_u_14, v_u_15, {
					["FillTransparency"] = v_u_5.FillTransparency
				}):Play()
			end
		end)
	end
end
local function v_u_24(p18, p19)
	-- upvalues: (copy) v_u_7, (copy) v_u_5, (ref) v_u_9, (copy) v_u_8
	if v_u_7[p18] then
		return
	elseif not table.find(v_u_5.ExcludedNPCs, p18.Name) then
		local v20 = p18:FindFirstChild("ProximityHighlight")
		if v20 then
			v20:Destroy()
		end
		local v21 = v_u_7
		local v22 = {}
		local v23 = Instance.new("Highlight")
		v23.Name = "ProximityHighlight"
		v23.Adornee = p18
		v23.OutlineColor = v_u_5.OutlineColor
		v23.OutlineTransparency = 1
		v23.FillColor = v_u_5.FillColor
		v23.FillTransparency = 1
		v23.DepthMode = Enum.HighlightDepthMode.Occluded
		v23.Parent = p18
		v22.highlight = v23
		v22.hrp = p19
		v22.initialCF = p19.CFrame
		v22.inRange = false
		v22.returning = false
		v22.shineTime = 0
		v21[p18] = v22
		v_u_9 = v_u_9 + 1
		if v_u_8[p18] then
			v_u_8[p18]:Disconnect()
			v_u_8[p18] = nil
		end
	end
end
local function v_u_27(p25)
	-- upvalues: (copy) v_u_7, (ref) v_u_9, (copy) v_u_8
	local v26 = v_u_7[p25]
	if v26 then
		if v26.highlight then
			v26.highlight:Destroy()
		end
		v_u_7[p25] = nil
		v_u_9 = v_u_9 - 1
	end
	if v_u_8[p25] then
		v_u_8[p25]:Disconnect()
		v_u_8[p25] = nil
	end
end
local function v_u_31(p_u_28)
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_5, (copy) v_u_24
	if v_u_7[p_u_28] or v_u_8[p_u_28] then
		return
	elseif p_u_28:IsA("Model") then
		if table.find(v_u_5.ExcludedNPCs, p_u_28.Name) then
			return
		else
			local v29 = p_u_28:FindFirstChild("HumanoidRootPart")
			if v29 then
				v_u_24(p_u_28, v29)
			else
				v_u_8[p_u_28] = p_u_28.ChildAdded:Connect(function(p30)
					-- upvalues: (ref) v_u_24, (copy) p_u_28
					if p30.Name == "HumanoidRootPart" then
						v_u_24(p_u_28, p30)
					end
				end)
			end
		end
	else
		return
	end
end
local function v38()
	-- upvalues: (copy) v_u_5, (copy) v_u_31, (copy) v_u_7, (ref) v_u_9, (copy) v_u_8
	local v_u_32 = {}
	for _, v33 in ipairs(v_u_5.IndividualNPCs) do
		v_u_32[v33] = true
		local v34 = workspace:FindFirstChild(v33)
		if v34 then
			v_u_31(v34)
		end
	end
	workspace.ChildAdded:Connect(function(p35)
		-- upvalues: (copy) v_u_32, (ref) v_u_31
		if v_u_32[p35.Name] then
			v_u_31(p35)
		end
	end)
	workspace.ChildRemoved:Connect(function(p36)
		-- upvalues: (copy) v_u_32, (ref) v_u_7, (ref) v_u_9, (ref) v_u_8
		if v_u_32[p36.Name] then
			local v37 = v_u_7[p36]
			if v37 then
				if v37.highlight then
					v37.highlight:Destroy()
				end
				v_u_7[p36] = nil
				v_u_9 = v_u_9 - 1
			end
			if v_u_8[p36] then
				v_u_8[p36]:Disconnect()
				v_u_8[p36] = nil
			end
		end
	end)
end
local function v42(p39)
	-- upvalues: (copy) v_u_31, (copy) v_u_27
	local v40 = workspace:WaitForChild(p39, 10)
	if v40 then
		for _, v41 in ipairs(v40:GetChildren()) do
			v_u_31(v41)
		end
		v40.ChildAdded:Connect(v_u_31)
		v40.ChildRemoved:Connect(v_u_27)
	end
end
local function v59(p43)
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_7, (copy) v_u_11, (copy) v_u_13, (copy) v_u_17
	local v44 = v_u_6.Character
	if v44 then
		local v45 = v44:FindFirstChild("HumanoidRootPart")
		if v45 then
			if not v_u_6:GetAttribute("IsTeleporting") then
				local v46 = v45.Position
				local v47 = tick()
				local v48 = v_u_5.DetectionRadius
				local v49 = v_u_5.RotationSpeed * p43
				local v50 = math.clamp(v49, 0, 1)
				local v51 = (v_u_5.ReturnSpeed or 3) * p43
				local v52 = math.clamp(v51, 0, 1)
				for _, v53 in pairs(v_u_7) do
					local v54 = v53.hrp
					if v54 and v54.Parent then
						local v55 = v53.initialCF.Position
						local v56 = (v55 - v46).Magnitude <= v48
						if v56 and not v53.inRange then
							v53.inRange = true
							v53.returning = false
							v_u_11(v53.highlight)
							v53.shineTime = v47 + 0.5
						elseif not v56 and v53.inRange then
							v53.inRange = false
							v53.returning = true
							v_u_13(v53.highlight)
						end
						if v53.inRange then
							if v_u_5.RotationEnabled then
								local v57 = (v46 - v55) * Vector3.new(1, 0, 1)
								if v57.Magnitude > 0.1 then
									local v58 = CFrame.lookAt(v55, v55 + v57.Unit)
									v54.CFrame = v54.CFrame:Lerp(v58, v50)
								end
							end
							if v53.shineTime <= v47 then
								task.spawn(v_u_17, v53.highlight)
								v53.shineTime = v47 + v_u_5.ShineInterval
							end
						elseif v53.returning then
							v54.CFrame = v54.CFrame:Lerp(v53.initialCF, v52)
							if v54.CFrame.LookVector:Dot(v53.initialCF.LookVector) > 0.999 then
								v53.returning = false
								v54.CFrame = v53.initialCF
							end
						end
					end
				end
			end
		else
			return
		end
	else
		return
	end
end
for _, v60 in ipairs(v_u_5.NPCFolders) do
	v42(v60)
end
v38()
v2.Heartbeat:Connect(v59)