local v1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = v1.LocalPlayer
local function v_u_9()
	-- upvalues: (copy) v_u_4
	local v5 = v_u_4:FindFirstChild("PlayerGui")
	if not v5 then
		return false
	end
	for _, v6 in ipairs({
		"SettingsUI",
		"ShopUI",
		"StatsPanelUI",
		"AllyUI",
		"TradingUI",
		"InTradingUI",
		"InventoryUI"
	}) do
		local v7 = v5:FindFirstChild(v6)
		if v7 then
			local v8 = v7:FindFirstChild("MainFrame")
			if v8 and v8.Visible then
				return true
			end
		end
	end
	return false
end
local v10 = v_u_3:WaitForChild("Modules")
local v_u_11 = require(v10:WaitForChild("InputManager")):Init()
local v_u_12 = v_u_3:WaitForChild("RemoteEvents")
local v_u_13 = v_u_3:WaitForChild("AbilitySystem"):WaitForChild("Remotes")
local v_u_14 = {}
local v_u_66 = {
	["Dash"] = function(p15)
		-- upvalues: (copy) v_u_4, (copy) v_u_12
		if p15 then
			local v16 = v_u_4.Character
			local v17
			if v16 then
				local v18 = v16:FindFirstChild("Humanoid")
				if v18 and v18.Health > 0 then
					v17 = not v16:GetAttribute("InCutscene")
				else
					v17 = false
				end
			else
				v17 = false
			end
			if v17 then
				local v19 = v_u_12:FindFirstChild("DashTrigger")
				if v19 and v19:IsA("BindableEvent") then
					v19:Fire()
				end
				return
			end
		end
	end,
	["Haki"] = function(p20)
		-- upvalues: (copy) v_u_4, (copy) v_u_12
		if p20 then
			local v21 = v_u_4.Character
			local v22
			if v21 then
				local v23 = v21:FindFirstChild("Humanoid")
				if v23 and v23.Health > 0 then
					v22 = not v21:GetAttribute("InCutscene")
				else
					v22 = false
				end
			else
				v22 = false
			end
			if v22 then
				local v24 = v_u_12:FindFirstChild("HakiRemote")
				if v24 then
					v24:FireServer("Toggle")
				end
				return
			end
		end
	end,
	["ObservationHaki"] = function(p25)
		-- upvalues: (copy) v_u_4, (copy) v_u_12
		if p25 then
			local v26 = v_u_4.Character
			local v27
			if v26 then
				local v28 = v26:FindFirstChild("Humanoid")
				if v28 and v28.Health > 0 then
					v27 = not v26:GetAttribute("InCutscene")
				else
					v27 = false
				end
			else
				v27 = false
			end
			if v27 then
				local v29 = v_u_12:FindFirstChild("ObservationHakiRemote")
				if v29 then
					v29:FireServer("Toggle")
				end
				return
			end
		end
	end,
	["ConquerorHaki"] = function(p30)
		-- upvalues: (copy) v_u_4, (copy) v_u_3
		if p30 then
			local v31 = v_u_4.Character
			local v32
			if v31 then
				local v33 = v31:FindFirstChild("Humanoid")
				if v33 and v33.Health > 0 then
					v32 = not v31:GetAttribute("InCutscene")
				else
					v32 = false
				end
			else
				v32 = false
			end
			if v32 then
				local v34 = v_u_3:FindFirstChild("Remotes")
				if v34 then
					v34 = v_u_3.Remotes:FindFirstChild("ConquerorHakiRemote")
				end
				if v34 then
					v34:FireServer("Activate")
				end
				return
			end
		end
	end,
	["AbilityZ"] = function(p35)
		-- upvalues: (copy) v_u_4, (copy) v_u_13
		if p35 then
			local v36 = v_u_4.Character
			local v37
			if v36 then
				local v38 = v36:FindFirstChild("Humanoid")
				if v38 and v38.Health > 0 then
					v37 = not v36:GetAttribute("InCutscene")
				else
					v37 = false
				end
			else
				v37 = false
			end
			if not v37 then
				return
			end
			local v39 = v_u_13:FindFirstChild("RequestAbility")
			if v39 then
				v39:FireServer(1)
			end
		end
	end,
	["AbilityX"] = function(p40)
		-- upvalues: (copy) v_u_4, (copy) v_u_13
		if p40 then
			local v41 = v_u_4.Character
			local v42
			if v41 then
				local v43 = v41:FindFirstChild("Humanoid")
				if v43 and v43.Health > 0 then
					v42 = not v41:GetAttribute("InCutscene")
				else
					v42 = false
				end
			else
				v42 = false
			end
			if not v42 then
				return
			end
			local v44 = v_u_13:FindFirstChild("RequestAbility")
			if v44 then
				v44:FireServer(2)
			end
		end
	end,
	["AbilityC"] = function(p45)
		-- upvalues: (copy) v_u_4, (copy) v_u_13
		if p45 then
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
			if not v47 then
				return
			end
			local v49 = v_u_13:FindFirstChild("RequestAbility")
			if v49 then
				v49:FireServer(3)
			end
		end
	end,
	["AbilityV"] = function(p50)
		-- upvalues: (copy) v_u_4, (copy) v_u_13
		if p50 then
			local v51 = v_u_4.Character
			local v52
			if v51 then
				local v53 = v51:FindFirstChild("Humanoid")
				if v53 and v53.Health > 0 then
					v52 = not v51:GetAttribute("InCutscene")
				else
					v52 = false
				end
			else
				v52 = false
			end
			if not v52 then
				return
			end
			local v54 = v_u_13:FindFirstChild("RequestAbility")
			if v54 then
				v54:FireServer(4)
			end
		end
	end,
	["AbilityF"] = function(p55)
		-- upvalues: (copy) v_u_4, (copy) v_u_13
		if p55 then
			local v56 = v_u_4.Character
			local v57
			if v56 then
				local v58 = v56:FindFirstChild("Humanoid")
				if v58 and v58.Health > 0 then
					v57 = not v56:GetAttribute("InCutscene")
				else
					v57 = false
				end
			else
				v57 = false
			end
			if not v57 then
				return
			end
			local v59 = v_u_13:FindFirstChild("RequestAbility")
			if v59 then
				v59:FireServer(5)
			end
		end
	end,
	["Attack"] = function(p60)
		-- upvalues: (copy) v_u_4, (copy) v_u_12
		if p60 then
			local v61 = v_u_4.Character
			local v62
			if v61 then
				local v63 = v61:FindFirstChild("Humanoid")
				if v63 and v63.Health > 0 then
					v62 = not v61:GetAttribute("InCutscene")
				else
					v62 = false
				end
			else
				v62 = false
			end
			if v62 then
				local v64 = v_u_12:FindFirstChild("GamepadAttackTrigger")
				if v64 then
					v64:Fire()
				end
				return
			end
		end
	end,
	["ShiftLock"] = function(p65)
		-- upvalues: (copy) v_u_4
		if p65 then
			v_u_4:SetAttribute("ShiftLockEnabled", not v_u_4:GetAttribute("ShiftLockEnabled"))
		end
	end
}
local v_u_67 = 0
local v_u_68 = 0
local v_u_69 = false
local v_u_70 = nil
local function v_u_74()
	-- upvalues: (ref) v_u_69, (ref) v_u_70, (copy) v_u_9, (ref) v_u_68, (ref) v_u_67, (copy) v_u_66
	if v_u_69 then
		v_u_69 = false
		if v_u_70 then
			task.cancel(v_u_70)
			v_u_70 = nil
		end
		if not v_u_9() then
			local v71 = tick()
			if v71 - v_u_68 <= 0.3 then
				v_u_67 = v_u_67 + 1
			else
				v_u_67 = 1
			end
			v_u_68 = v71
			local v_u_72 = v_u_67
			local v_u_73 = v_u_68
			task.delay(0.3, function()
				-- upvalues: (ref) v_u_68, (copy) v_u_73, (copy) v_u_72, (ref) v_u_66, (ref) v_u_67
				if v_u_68 == v_u_73 then
					if v_u_72 == 1 then
						v_u_66.Haki(true)
					elseif v_u_72 == 2 then
						v_u_66.ObservationHaki(true)
					end
					v_u_67 = 0
					v_u_68 = 0
				end
			end)
		end
	else
		return
	end
end
local v_u_75 = {
	[Enum.KeyCode.ButtonR2] = "Attack",
	[Enum.KeyCode.ButtonX] = "AbilityZ",
	[Enum.KeyCode.ButtonY] = "AbilityX",
	[Enum.KeyCode.ButtonB] = "AbilityC",
	[Enum.KeyCode.ButtonL2] = "AbilityV",
	[Enum.KeyCode.DPadRight] = "AbilityF",
	[Enum.KeyCode.DPadUp] = "Dash",
	[Enum.KeyCode.DPadLeft] = "ShiftLock"
}
local v_u_76 = v_u_68
local v_u_77 = v_u_67
local v_u_78 = v_u_70
local v_u_79 = v_u_69
local v_u_80 = {}
for v81, _ in pairs(v_u_75) do
	v_u_80[v81] = true
end
v_u_80[Enum.KeyCode.DPadDown] = true
v_u_80[Enum.KeyCode.ButtonStart] = true
v_u_80[Enum.KeyCode.ButtonSelect] = true
local function v_u_84(p82, _)
	-- upvalues: (copy) v_u_11, (copy) v_u_80, (copy) v_u_9, (ref) v_u_79, (ref) v_u_78, (ref) v_u_77, (ref) v_u_76, (copy) v_u_66, (copy) v_u_75
	if v_u_11.IsGamepad then
		if v_u_80[p82.KeyCode] then
			if p82.KeyCode == Enum.KeyCode.DPadDown then
				if not v_u_9() then
					v_u_79 = true
					if v_u_78 then
						task.cancel(v_u_78)
						v_u_78 = nil
					end
					v_u_78 = task.delay(0.5, function()
						-- upvalues: (ref) v_u_79, (ref) v_u_77, (ref) v_u_76, (ref) v_u_66, (ref) v_u_78
						if v_u_79 then
							v_u_77 = 0
							v_u_76 = 0
							v_u_66.ConquerorHaki(true)
						end
						v_u_78 = nil
					end)
				end
			elseif not v_u_9() then
				local v83 = v_u_75[p82.KeyCode]
				if v83 and v_u_66[v83] then
					v_u_66[v83](true)
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_86(p85, _)
	-- upvalues: (copy) v_u_11, (copy) v_u_74
	if v_u_11.IsGamepad then
		if p85.KeyCode == Enum.KeyCode.DPadDown then
			v_u_74()
		end
	end
end
v_u_4.AncestryChanged:Connect(function()
	-- upvalues: (copy) v_u_14
	for _, v87 in ipairs(v_u_14) do
		if v87.Connected then
			v87:Disconnect()
		end
	end
end);
(function()
	-- upvalues: (copy) v_u_14, (copy) v_u_2, (copy) v_u_84, (copy) v_u_86, (copy) v_u_12
	local v88 = v_u_14
	local v89 = v_u_2.InputBegan
	local v90 = v_u_84
	table.insert(v88, v89:Connect(v90))
	local v91 = v_u_14
	local v92 = v_u_2.InputEnded
	local v93 = v_u_86
	table.insert(v91, v92:Connect(v93))
	if not v_u_12:FindFirstChild("GamepadAttackTrigger") then
		local v94 = Instance.new("BindableEvent")
		v94.Name = "GamepadAttackTrigger"
		v94.Parent = v_u_12
	end
end)()