local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("RunService");
(function()
	local v4 = tick()
	while not _G.AssetsDownloaded do
		if tick() - v4 > 10 then
			warn("[IdleClient] Timeout waiting for assets, continuing anyway")
			return
		end
		task.wait(0.05)
	end
end)()
local v_u_5 = require(v2:WaitForChild("PlayerAnimationController"))
local v_u_6 = v1.LocalPlayer
local v_u_7 = {}
local v_u_8 = 0
local function v_u_14(p9)
	local v10 = p9:FindFirstChild("Humanoid")
	if v10 then
		local v11 = v10:FindFirstChildOfClass("Animator")
		if v11 then
			task.wait(0.15)
			local v12 = v11:GetPlayingAnimationTracks()
			for _, v_u_13 in ipairs(v12) do
				if v_u_13.Priority == Enum.AnimationPriority.Core then
					pcall(function()
						-- upvalues: (copy) v_u_13
						v_u_13:Stop(0)
					end)
				end
			end
		end
	else
		return
	end
end
local function v_u_19(p_u_15, p_u_16)
	-- upvalues: (copy) v_u_7, (copy) v_u_14, (copy) v_u_5, (copy) v_u_6
	if v_u_7[p_u_15] then
		pcall(function()
			-- upvalues: (ref) v_u_7, (copy) p_u_15
			v_u_7[p_u_15]:cleanup()
		end)
		v_u_7[p_u_15] = nil
	end
	if p_u_16:WaitForChild("Humanoid", 5) and p_u_16:WaitForChild("HumanoidRootPart", 5) then
		task.spawn(function()
			-- upvalues: (ref) v_u_14, (copy) p_u_16
			v_u_14(p_u_16)
		end)
		local v17, v_u_18 = pcall(function()
			-- upvalues: (ref) v_u_5, (copy) p_u_16
			return v_u_5.new(p_u_16)
		end)
		if v17 then
			if v_u_18 and type(v_u_18) == "table" then
				v_u_7[p_u_15] = v_u_18
				if p_u_15 == v_u_6 then
					pcall(function()
						-- upvalues: (ref) v_u_5, (copy) v_u_18
						v_u_5.registerLocalController(v_u_18)
					end)
				end
			end
		else
			warn("[IdleClient] Failed to create controller: " .. tostring(v_u_18))
			return
		end
	else
		return
	end
end
local function v27(p20)
	-- upvalues: (ref) v_u_8, (copy) v_u_6, (copy) v_u_7
	v_u_8 = v_u_8 + p20
	if v_u_8 < 0.15 then
		return
	else
		v_u_8 = 0
		if not v_u_6:GetAttribute("IsTeleporting") then
			for v21, v_u_22 in pairs(v_u_7) do
				if v21.Character and v21.Character.Parent then
					local v23 = v21.Character
					local v24
					if v_u_6.Character then
						local v25 = v_u_6.Character:FindFirstChild("HumanoidRootPart")
						local v26 = v23:FindFirstChild("HumanoidRootPart")
						v24 = not (v25 and v26) and true or (v25.Position - v26.Position).Magnitude <= 500
					else
						v24 = true
					end
					if v24 then
						pcall(function()
							-- upvalues: (copy) v_u_22
							v_u_22:update()
						end)
					end
				end
			end
		end
	end
end
local function v_u_30(p_u_28)
	-- upvalues: (copy) v_u_19
	if p_u_28.Character then
		task.spawn(function()
			-- upvalues: (ref) v_u_19, (copy) p_u_28
			v_u_19(p_u_28, p_u_28.Character)
		end)
	end
	p_u_28.CharacterAdded:Connect(function(p_u_29)
		-- upvalues: (ref) v_u_19, (copy) p_u_28
		task.spawn(function()
			-- upvalues: (ref) v_u_19, (ref) p_u_28, (copy) p_u_29
			v_u_19(p_u_28, p_u_29)
		end)
	end)
end
local function v32(p_u_31)
	-- upvalues: (copy) v_u_7
	if v_u_7[p_u_31] then
		pcall(function()
			-- upvalues: (ref) v_u_7, (copy) p_u_31
			v_u_7[p_u_31]:cleanup()
		end)
		v_u_7[p_u_31] = nil
	end
end
for _, v_u_33 in ipairs(v1:GetPlayers()) do
	task.spawn(function()
		-- upvalues: (copy) v_u_30, (copy) v_u_33
		v_u_30(v_u_33)
	end)
end
v1.PlayerAdded:Connect(v_u_30)
v1.PlayerRemoving:Connect(v32)
v3.Heartbeat:Connect(v27)