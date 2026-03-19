local v1 = game:GetService("Players")
local v2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = v1.LocalPlayer
local v_u_5 = {
	["Quake"] = true,
	["Invisible"] = true,
	["Flame"] = true,
	["Bomb"] = true,
	["Light"] = true
}
local v6 = v_u_3:WaitForChild("Modules")
local v_u_7 = require(v6:WaitForChild("InputManager")):Init()
local v_u_8 = v_u_3:WaitForChild("RemoteEvents")
local v_u_9 = v_u_3:WaitForChild("AbilitySystem"):WaitForChild("Remotes")
local v_u_10 = {}
local v_u_11 = 0
local v_u_12 = 0
local function v_u_17()
	-- upvalues: (copy) v_u_4
	local v13 = v_u_4:FindFirstChild("PlayerGui")
	if not v13 then
		return false
	end
	for _, v14 in ipairs({
		"SettingsUI",
		"ShopUI",
		"StatsPanelUI",
		"AllyUI",
		"TradingUI",
		"InTradingUI",
		"InventoryUI"
	}) do
		local v15 = v13:FindFirstChild(v14)
		if v15 then
			local v16 = v15:FindFirstChild("MainFrame")
			if v16 and v16.Visible then
				return true
			end
		end
	end
	return false
end
local function v_u_33()
	-- upvalues: (copy) v_u_17, (ref) v_u_12, (ref) v_u_11, (copy) v_u_4, (copy) v_u_3, (copy) v_u_8
	if v_u_17() then
		return
	else
		local v18 = tick()
		if v18 - v_u_12 <= 0.3 then
			v_u_11 = v_u_11 + 1
		else
			v_u_11 = 1
		end
		v_u_12 = v18
		if v_u_11 == 3 then
			v_u_11 = 0
			v_u_12 = 0
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
				local v22 = v_u_3:FindFirstChild("Remotes")
				if v22 then
					v22 = v_u_3.Remotes:FindFirstChild("ConquerorHakiRemote")
				end
				if v22 then
					v22:FireServer("Activate")
				end
			end
		else
			local v_u_23 = v_u_11
			local v_u_24 = v_u_12
			task.delay(0.3, function()
				-- upvalues: (ref) v_u_12, (copy) v_u_24, (copy) v_u_23, (ref) v_u_4, (ref) v_u_8, (ref) v_u_11
				if v_u_12 == v_u_24 then
					if v_u_23 == 1 then
						local v25 = v_u_4.Character
						local v26
						if v25 then
							local v27 = v25:FindFirstChild("Humanoid")
							if v27 and v27.Health > 0 then
								v26 = not v25:GetAttribute("InCutscene")
							else
								v26 = false
							end
						else
							v26 = false
						end
						local v28 = v26 and v_u_8:FindFirstChild("HakiRemote")
						if v28 then
							v28:FireServer("Toggle")
						end
					elseif v_u_23 == 2 then
						local v29 = v_u_4.Character
						local v30
						if v29 then
							local v31 = v29:FindFirstChild("Humanoid")
							if v31 and v31.Health > 0 then
								v30 = not v29:GetAttribute("InCutscene")
							else
								v30 = false
							end
						else
							v30 = false
						end
						local v32 = v30 and v_u_8:FindFirstChild("ObservationHakiRemote")
						if v32 then
							v32:FireServer("Toggle")
						end
					end
					v_u_11 = 0
					v_u_12 = 0
				end
			end)
			return
		end
	end
end
local v_u_34 = {
	[Enum.KeyCode.ButtonR2] = true,
	[Enum.KeyCode.ButtonL2] = true,
	[Enum.KeyCode.DPadUp] = true,
	[Enum.KeyCode.DPadLeft] = true,
	[Enum.KeyCode.DPadRight] = true,
	[Enum.KeyCode.ButtonStart] = true,
	[Enum.KeyCode.ButtonSelect] = true
}
local function v50(p35, _)
	-- upvalues: (copy) v_u_7, (copy) v_u_34, (copy) v_u_17, (copy) v_u_4, (copy) v_u_5, (copy) v_u_9, (copy) v_u_33, (copy) v_u_8
	if v_u_7.IsGamepad then
		if v_u_34[p35.KeyCode] then
			if v_u_17() then
				return
			elseif p35.KeyCode == Enum.KeyCode.DPadLeft then
				v_u_4:SetAttribute("ShiftLockEnabled", not v_u_4:GetAttribute("ShiftLockEnabled"))
				return
			elseif p35.KeyCode == Enum.KeyCode.DPadUp then
				local v36 = v_u_4.Character
				if v36 then
					local v37 = v36:FindFirstChildOfClass("Tool")
					if v37 and not v_u_5[v37.Name] then
						local v38 = v_u_4.Character
						local v39
						if v38 then
							local v40 = v38:FindFirstChild("Humanoid")
							if v40 and v40.Health > 0 then
								v39 = not v38:GetAttribute("InCutscene")
							else
								v39 = false
							end
						else
							v39 = false
						end
						if v39 then
							local v41 = v_u_9:FindFirstChild("RequestAbility")
							if v41 then
								v41:FireServer(4)
							end
						end
					end
				end
				return
			elseif p35.KeyCode == Enum.KeyCode.DPadRight then
				v_u_33()
				return
			elseif p35.KeyCode == Enum.KeyCode.ButtonL2 then
				local v42 = v_u_4.Character
				local v43
				if v42 then
					local v44 = v42:FindFirstChild("Humanoid")
					if v44 and v44.Health > 0 then
						v43 = not v42:GetAttribute("InCutscene")
					else
						v43 = false
					end
				else
					v43 = false
				end
				if v43 then
					local v45 = v_u_8:FindFirstChild("DashTrigger")
					if v45 and v45:IsA("BindableEvent") then
						v45:Fire()
					end
				end
			elseif p35.KeyCode == Enum.KeyCode.ButtonR2 then
				local v46 = v_u_4.Character
				local v47
				if v46 then
					local v48 = v46:FindFirstChild("Humanoid")
					if v48 and v48.Health > 0 then
						v47 = not v46:GetAttribute("InCutscene")
					else
						v47 = false
					end
				else
					v47 = false
				end
				if v47 then
					local v49 = v_u_8:FindFirstChild("GamepadAttackTrigger")
					if v49 then
						v49:Fire()
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
v_u_4.AncestryChanged:Connect(function()
	-- upvalues: (copy) v_u_10
	for _, v51 in ipairs(v_u_10) do
		if v51.Connected then
			v51:Disconnect()
		end
	end
end)
if not v_u_8:FindFirstChild("GamepadAttackTrigger") then
	local v52 = Instance.new("BindableEvent")
	v52.Name = "GamepadAttackTrigger"
	v52.Parent = v_u_8
end
local v53 = v2.InputBegan
table.insert(v_u_10, v53:Connect(v50))