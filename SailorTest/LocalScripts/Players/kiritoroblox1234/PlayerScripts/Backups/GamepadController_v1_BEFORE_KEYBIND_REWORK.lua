local v1 = game:GetService("Players")
local v2 = game:GetService("UserInputService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = v1.LocalPlayer
local v_u_5 = {
	["Quake"] = true,
	["Invisible"] = true,
	["Flame"] = true,
	["Bomb"] = true,
	["Light"] = true
}
local function v_u_10()
	-- upvalues: (copy) v_u_4
	local v6 = v_u_4:FindFirstChild("PlayerGui")
	if not v6 then
		return false
	end
	for _, v7 in ipairs({
		"SettingsUI",
		"ShopUI",
		"StatsPanelUI",
		"AllyUI",
		"TradingUI",
		"InTradingUI",
		"InventoryUI"
	}) do
		local v8 = v6:FindFirstChild(v7)
		if v8 then
			local v9 = v8:FindFirstChild("MainFrame")
			if v9 and v9.Visible then
				return true
			end
		end
	end
	return false
end
local v11 = v3:WaitForChild("Modules")
local v_u_12 = require(v11:WaitForChild("InputManager")):Init()
local v_u_13 = v3:WaitForChild("RemoteEvents")
local v_u_14 = v3:WaitForChild("AbilitySystem"):WaitForChild("Remotes")
local v_u_15 = {}
local function v_u_16(...) end
local v_u_66 = {
	["Dash"] = function(p17)
		-- upvalues: (copy) v_u_4, (copy) v_u_13
		if p17 then
			local v18 = v_u_4.Character
			local v19
			if v18 then
				local v20 = v18:FindFirstChild("Humanoid")
				if v20 and v20.Health > 0 then
					v19 = not v18:GetAttribute("InCutscene")
				else
					v19 = false
				end
			else
				v19 = false
			end
			if v19 then
				local v21 = v_u_13:FindFirstChild("DashTrigger")
				if v21 and v21:IsA("BindableEvent") then
					v21:Fire()
				end
				return
			end
		end
	end,
	["Haki"] = function(p22)
		-- upvalues: (copy) v_u_4, (copy) v_u_13
		if p22 then
			local v23 = v_u_4.Character
			local v24
			if v23 then
				local v25 = v23:FindFirstChild("Humanoid")
				if v25 and v25.Health > 0 then
					v24 = not v23:GetAttribute("InCutscene")
				else
					v24 = false
				end
			else
				v24 = false
			end
			if v24 then
				local v26 = v_u_13:FindFirstChild("HakiRemote")
				if v26 then
					v26:FireServer("Toggle")
				end
				return
			end
		end
	end,
	["ObservationHaki"] = function(p27)
		-- upvalues: (copy) v_u_4, (copy) v_u_16, (copy) v_u_13
		if p27 then
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
				v_u_16("Observation Haki triggered")
				local v31 = v_u_13:FindFirstChild("ObservationHakiRemote")
				if v31 then
					v31:FireServer("Toggle")
				end
				return
			end
		end
	end,
	["DropFruit"] = function(p32)
		-- upvalues: (copy) v_u_4, (copy) v_u_13
		if p32 then
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
			if v34 then
				local v36 = v_u_4.Character
				if v36 then
					local v37 = v36:FindFirstChildOfClass("Tool")
					if v37 and v37:FindFirstChild("FruitData") then
						local v38 = v37:FindFirstChild("FruitID")
						local v39 = v38 and v_u_13:FindFirstChild("DropFruit")
						if v39 then
							v39:FireServer(v38.Value)
						end
					end
				end
			end
		end
	end,
	["AbilityZ"] = function(p40)
		-- upvalues: (copy) v_u_4, (copy) v_u_14
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
			local v44 = v_u_14:FindFirstChild("RequestAbility")
			if v44 then
				v44:FireServer(1)
			end
		end
	end,
	["AbilityX"] = function(p45)
		-- upvalues: (copy) v_u_4, (copy) v_u_14
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
			local v49 = v_u_14:FindFirstChild("RequestAbility")
			if v49 then
				v49:FireServer(2)
			end
		end
	end,
	["AbilityC"] = function(p50)
		-- upvalues: (copy) v_u_4, (copy) v_u_14
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
			local v54 = v_u_14:FindFirstChild("RequestAbility")
			if v54 then
				v54:FireServer(3)
			end
		end
	end,
	["AbilityV"] = function(p55)
		-- upvalues: (copy) v_u_4, (copy) v_u_14
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
			local v59 = v_u_14:FindFirstChild("RequestAbility")
			if v59 then
				v59:FireServer(4)
			end
		end
	end,
	["Attack"] = function(p60)
		-- upvalues: (copy) v_u_4, (copy) v_u_13
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
				local v64 = v_u_13:FindFirstChild("GamepadAttackTrigger")
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
local function v_u_73()
	-- upvalues: (copy) v_u_10, (ref) v_u_68, (ref) v_u_67, (copy) v_u_16, (copy) v_u_66
	if v_u_10() then
		return
	else
		local v69 = tick()
		if v69 - v_u_68 <= 0.3 then
			v_u_67 = v_u_67 + 1
		else
			v_u_67 = 1
		end
		v_u_68 = v69
		if v_u_67 == 3 then
			v_u_16("DPadRight TRIPLE TAP -> Conqueror Haki")
			v_u_67 = 0
			v_u_68 = 0
			local v70 = game.ReplicatedStorage:FindFirstChild("Remotes")
			if v70 then
				v70 = game.ReplicatedStorage.Remotes:FindFirstChild("ConquerorHakiRemote")
			end
			if v70 then
				v70:FireServer("Activate")
			end
		else
			local v_u_71 = v_u_67
			local v_u_72 = v_u_68
			task.delay(0.3, function()
				-- upvalues: (ref) v_u_68, (copy) v_u_72, (copy) v_u_71, (ref) v_u_16, (ref) v_u_66, (ref) v_u_67
				if v_u_68 == v_u_72 then
					if v_u_71 == 1 then
						v_u_16("DPadRight SINGLE TAP -> Armament Haki")
						v_u_66.Haki(true)
					elseif v_u_71 == 2 then
						v_u_16("DPadRight DOUBLE TAP -> Observation Haki")
						v_u_66.ObservationHaki(true)
					end
					v_u_67 = 0
					v_u_68 = 0
				end
			end)
		end
	end
end
local v_u_74 = {
	[Enum.KeyCode.ButtonB] = true,
	[Enum.KeyCode.ButtonX] = true,
	[Enum.KeyCode.ButtonY] = true,
	[Enum.KeyCode.ButtonL2] = true,
	[Enum.KeyCode.DPadUp] = true,
	[Enum.KeyCode.DPadLeft] = true,
	[Enum.KeyCode.ButtonR2] = true,
	[Enum.KeyCode.DPadRight] = true,
	[Enum.KeyCode.ButtonStart] = true,
	[Enum.KeyCode.ButtonSelect] = true
}
v_u_4.AncestryChanged:Connect(function()
	-- upvalues: (copy) v_u_15
	for _, v75 in ipairs(v_u_15) do
		if v75.Connected then
			v75:Disconnect()
		end
	end
end)
local v76 = v2.InputBegan
table.insert(v_u_15, v76:Connect(function(p77, _)
	-- upvalues: (copy) v_u_12, (copy) v_u_74, (copy) v_u_10, (copy) v_u_66, (copy) v_u_4, (copy) v_u_5, (copy) v_u_73
	if v_u_12.IsGamepad then
		if v_u_74[p77.KeyCode] then
			if p77.KeyCode == Enum.KeyCode.DPadLeft and not v_u_10() then
				v_u_66.ShiftLock(true)
				return
			else
				local v78 = p77.KeyCode == Enum.KeyCode.DPadUp and not v_u_10() and v_u_4.Character
				if v78 then
					local v79 = v78:FindFirstChildOfClass("Tool")
					if v79 and not v_u_5[v79.Name] then
						v_u_66.AbilityV(true)
						return
					end
				end
				if p77.KeyCode == Enum.KeyCode.DPadRight then
					v_u_73()
				else
					for v80, v81 in pairs(v_u_66) do
						if v80 ~= "Haki" and (v80 ~= "ObservationHaki" and v_u_12:IsAction(v80, p77)) then
							v81(true)
							return
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
end))
if not v_u_13:FindFirstChild("GamepadAttackTrigger") then
	local v82 = Instance.new("BindableEvent")
	v82.Name = "GamepadAttackTrigger"
	v82.Parent = v_u_13
end