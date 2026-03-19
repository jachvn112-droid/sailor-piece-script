local v1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = v1.LocalPlayer
local v5 = v_u_3:WaitForChild("Modules")
local v_u_6 = require(v5:WaitForChild("InputManager")):Init()
local v_u_7 = v_u_3:WaitForChild("RemoteEvents")
local v_u_8 = {}
local v_u_9 = 0
local v_u_10 = false
local v_u_11 = false
local function v_u_16()
	-- upvalues: (copy) v_u_4
	local v12 = v_u_4:FindFirstChild("PlayerGui")
	if not v12 then
		return false
	end
	for _, v13 in ipairs({
		"SettingsUI",
		"ShopUI",
		"StatsPanelUI",
		"AllyUI",
		"TradingUI",
		"InTradingUI",
		"InventoryUI"
	}) do
		local v14 = v12:FindFirstChild(v13)
		if v14 then
			local v15 = v14:FindFirstChild("MainFrame")
			if v15 and v15.Visible then
				return true
			end
		end
	end
	return false
end
local v_u_17 = {
	[Enum.KeyCode.ButtonR2] = true,
	[Enum.KeyCode.ButtonX] = true,
	[Enum.KeyCode.ButtonY] = true,
	[Enum.KeyCode.ButtonB] = true,
	[Enum.KeyCode.ButtonL2] = true,
	[Enum.KeyCode.DPadUp] = true,
	[Enum.KeyCode.DPadDown] = true,
	[Enum.KeyCode.DPadLeft] = true,
	[Enum.KeyCode.ButtonR3] = true
}
local function v_u_37(p18, _)
	-- upvalues: (copy) v_u_6, (copy) v_u_17, (copy) v_u_16, (copy) v_u_4, (copy) v_u_7, (ref) v_u_9, (ref) v_u_10, (ref) v_u_11, (copy) v_u_3
	if v_u_6.IsGamepad then
		if v_u_17[p18.KeyCode] then
			if v_u_16() then
				return
			elseif p18.KeyCode == Enum.KeyCode.DPadUp then
				local v19 = v_u_4.Character
				local v20
				if v19 then
					local v21 = v19:FindFirstChild("Humanoid")
					if v21 and v21.Health > 0 then
						v20 = not v19:GetAttribute("InCutscene")
					else
						v20 = false
					end
				else
					v20 = false
				end
				if v20 then
					local v22 = v_u_7:FindFirstChild("DashTrigger")
					if v22 and v22:IsA("BindableEvent") then
						v22:Fire()
					end
				end
			elseif p18.KeyCode == Enum.KeyCode.DPadDown then
				v_u_9 = tick()
				v_u_10 = true
				v_u_11 = false
				local v_u_23 = v_u_9
				task.delay(0.5, function()
					-- upvalues: (ref) v_u_10, (ref) v_u_9, (copy) v_u_23, (ref) v_u_11, (ref) v_u_4, (ref) v_u_3
					if v_u_10 and (v_u_9 == v_u_23 and not v_u_11) then
						v_u_11 = true
						local v24 = v_u_4.Character
						local v25
						if v24 then
							local v26 = v24:FindFirstChild("Humanoid")
							if v26 and v26.Health > 0 then
								v25 = not v24:GetAttribute("InCutscene")
							else
								v25 = false
							end
						else
							v25 = false
						end
						if not v25 then
							return
						end
						local v27 = v_u_3:FindFirstChild("Remotes")
						if v27 then
							v27 = v_u_3.Remotes:FindFirstChild("ConquerorHakiRemote")
						end
						if v27 then
							v27:FireServer("Activate")
						end
					end
				end)
				return
			elseif p18.KeyCode == Enum.KeyCode.DPadLeft then
				local v28 = v_u_4.Character
				local v29
				if v28 then
					local v30 = v28:FindFirstChild("Humanoid")
					if v30 and v30.Health > 0 then
						v29 = not v28:GetAttribute("InCutscene")
					else
						v29 = false
					end
				else
					v29 = false
				end
				if v29 then
					local v31 = v_u_7:FindFirstChild("ObservationHakiRemote")
					if v31 then
						v31:FireServer("Toggle")
					end
				end
			elseif p18.KeyCode == Enum.KeyCode.ButtonR3 then
				v_u_4:SetAttribute("ShiftLockEnabled", not v_u_4:GetAttribute("ShiftLockEnabled"))
			else
				for v32, _ in pairs(v_u_6.Config.Actions) do
					if v_u_6:IsAction(v32, p18) then
						if v32 == "Attack" then
							local v33 = v_u_4.Character
							local v34
							if v33 then
								local v35 = v33:FindFirstChild("Humanoid")
								if v35 and v35.Health > 0 then
									v34 = not v33:GetAttribute("InCutscene")
								else
									v34 = false
								end
							else
								v34 = false
							end
							local v36 = v34 and v_u_7:FindFirstChild("GamepadAttackTrigger")
							if v36 then
								v36:Fire()
							end
						end
						return
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
local function v_u_43(p38)
	-- upvalues: (copy) v_u_6, (ref) v_u_10, (ref) v_u_9, (ref) v_u_11, (copy) v_u_4, (copy) v_u_7
	if v_u_6.IsGamepad then
		if p38.KeyCode == Enum.KeyCode.DPadDown then
			v_u_10 = false
			if tick() - v_u_9 < 0.5 and not v_u_11 then
				local v39 = v_u_4.Character
				local v40
				if v39 then
					local v41 = v39:FindFirstChild("Humanoid")
					if v41 and v41.Health > 0 then
						v40 = not v39:GetAttribute("InCutscene")
					else
						v40 = false
					end
				else
					v40 = false
				end
				if not v40 then
					return
				end
				local v42 = v_u_7:FindFirstChild("HakiRemote")
				if v42 then
					v42:FireServer("Toggle")
				end
			end
		end
	end
end
v_u_4.AncestryChanged:Connect(function()
	-- upvalues: (copy) v_u_8
	for _, v44 in ipairs(v_u_8) do
		if v44.Connected then
			v44:Disconnect()
		end
	end
end);
(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_2, (copy) v_u_37, (copy) v_u_43, (copy) v_u_7
	local v45 = v_u_8
	local v46 = v_u_2.InputBegan
	local v47 = v_u_37
	table.insert(v45, v46:Connect(v47))
	local v48 = v_u_8
	local v49 = v_u_2.InputEnded
	local v50 = v_u_43
	table.insert(v48, v49:Connect(v50))
	if not v_u_7:FindFirstChild("GamepadAttackTrigger") then
		local v51 = Instance.new("BindableEvent")
		v51.Name = "GamepadAttackTrigger"
		v51.Parent = v_u_7
	end
end)()