local v1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
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
local v_u_11 = v_u_7:GetControllerLayout()
local v_u_12 = 0
local v_u_13 = false
local v_u_14 = false
local v_u_15 = 0
local v_u_16 = 0
local function v_u_21()
	-- upvalues: (copy) v_u_4
	local v17 = v_u_4:FindFirstChild("PlayerGui")
	if not v17 then
		return false
	end
	for _, v18 in ipairs({
		"SettingsUI",
		"ShopUI",
		"StatsPanelUI",
		"AllyUI",
		"TradingUI",
		"InTradingUI",
		"InventoryUI"
	}) do
		local v19 = v17:FindFirstChild(v18)
		if v19 then
			local v20 = v19:FindFirstChild("MainFrame")
			if v20 and v20.Visible then
				return true
			end
		end
	end
	return false
end
local function v_u_37()
	-- upvalues: (copy) v_u_21, (ref) v_u_16, (ref) v_u_15, (copy) v_u_4, (copy) v_u_3, (copy) v_u_8
	if v_u_21() then
		return
	else
		local v22 = tick()
		if v22 - v_u_16 <= 0.3 then
			v_u_15 = v_u_15 + 1
		else
			v_u_15 = 1
		end
		v_u_16 = v22
		if v_u_15 == 3 then
			v_u_15 = 0
			v_u_16 = 0
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
				local v26 = v_u_3:FindFirstChild("Remotes")
				if v26 then
					v26 = v_u_3.Remotes:FindFirstChild("ConquerorHakiRemote")
				end
				if v26 then
					v26:FireServer("Activate")
				end
			end
		else
			local v_u_27 = v_u_15
			local v_u_28 = v_u_16
			task.delay(0.3, function()
				-- upvalues: (ref) v_u_16, (copy) v_u_28, (copy) v_u_27, (ref) v_u_4, (ref) v_u_8, (ref) v_u_15
				if v_u_16 == v_u_28 then
					if v_u_27 == 1 then
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
						local v32 = v30 and v_u_8:FindFirstChild("HakiRemote")
						if v32 then
							v32:FireServer("Toggle")
						end
					elseif v_u_27 == 2 then
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
						local v36 = v34 and v_u_8:FindFirstChild("ObservationHakiRemote")
						if v36 then
							v36:FireServer("Toggle")
						end
					end
					v_u_15 = 0
					v_u_16 = 0
				end
			end)
			return
		end
	end
end
local v_u_38 = {
	[Enum.KeyCode.ButtonR2] = true,
	[Enum.KeyCode.ButtonL2] = true,
	[Enum.KeyCode.DPadUp] = true,
	[Enum.KeyCode.DPadLeft] = true,
	[Enum.KeyCode.DPadRight] = true,
	[Enum.KeyCode.ButtonStart] = true,
	[Enum.KeyCode.ButtonSelect] = true
}
local function v_u_54(p39, _)
	-- upvalues: (copy) v_u_7, (copy) v_u_38, (copy) v_u_21, (copy) v_u_4, (copy) v_u_5, (copy) v_u_9, (copy) v_u_37, (copy) v_u_8
	if v_u_7.IsGamepad then
		if v_u_38[p39.KeyCode] then
			if v_u_21() then
				return
			elseif p39.KeyCode == Enum.KeyCode.DPadLeft then
				v_u_4:SetAttribute("ShiftLockEnabled", not v_u_4:GetAttribute("ShiftLockEnabled"))
				return
			elseif p39.KeyCode == Enum.KeyCode.DPadUp then
				local v40 = v_u_4.Character
				if v40 then
					local v41 = v40:FindFirstChildOfClass("Tool")
					if v41 and not v_u_5[v41.Name] then
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
							local v45 = v_u_9:FindFirstChild("RequestAbility")
							if v45 then
								v45:FireServer(4)
							end
						end
					end
				end
				return
			elseif p39.KeyCode == Enum.KeyCode.DPadRight then
				v_u_37()
				return
			elseif p39.KeyCode == Enum.KeyCode.ButtonL2 then
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
					local v49 = v_u_8:FindFirstChild("DashTrigger")
					if v49 and v49:IsA("BindableEvent") then
						v49:Fire()
					end
				end
			elseif p39.KeyCode == Enum.KeyCode.ButtonR2 then
				local v50 = v_u_4.Character
				local v51
				if v50 then
					local v52 = v50:FindFirstChild("Humanoid")
					if v52 and v52.Health > 0 then
						v51 = not v50:GetAttribute("InCutscene")
					else
						v51 = false
					end
				else
					v51 = false
				end
				if v51 then
					local v53 = v_u_8:FindFirstChild("GamepadAttackTrigger")
					if v53 then
						v53:Fire()
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
local v_u_55 = {
	[Enum.KeyCode.ButtonR2] = true,
	[Enum.KeyCode.ButtonR3] = true,
	[Enum.KeyCode.DPadUp] = true,
	[Enum.KeyCode.DPadDown] = true,
	[Enum.KeyCode.DPadLeft] = true,
	[Enum.KeyCode.ButtonStart] = true,
	[Enum.KeyCode.ButtonSelect] = true
}
local function v_u_74(p56, _)
	-- upvalues: (copy) v_u_7, (copy) v_u_55, (copy) v_u_21, (copy) v_u_4, (copy) v_u_8, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (copy) v_u_3
	if v_u_7.IsGamepad then
		if v_u_55[p56.KeyCode] then
			if v_u_21() then
				return
			elseif p56.KeyCode == Enum.KeyCode.DPadUp then
				local v57 = v_u_4.Character
				local v58
				if v57 then
					local v59 = v57:FindFirstChild("Humanoid")
					if v59 and v59.Health > 0 then
						v58 = not v57:GetAttribute("InCutscene")
					else
						v58 = false
					end
				else
					v58 = false
				end
				if v58 then
					local v60 = v_u_8:FindFirstChild("DashTrigger")
					if v60 and v60:IsA("BindableEvent") then
						v60:Fire()
					end
				end
			elseif p56.KeyCode == Enum.KeyCode.DPadDown then
				v_u_12 = tick()
				v_u_13 = true
				v_u_14 = false
				local v_u_61 = v_u_12
				task.delay(0.5, function()
					-- upvalues: (ref) v_u_13, (ref) v_u_12, (copy) v_u_61, (ref) v_u_14, (ref) v_u_4, (ref) v_u_3
					if v_u_13 and (v_u_12 == v_u_61 and not v_u_14) then
						v_u_14 = true
						local v62 = v_u_4.Character
						local v63
						if v62 then
							local v64 = v62:FindFirstChild("Humanoid")
							if v64 and v64.Health > 0 then
								v63 = not v62:GetAttribute("InCutscene")
							else
								v63 = false
							end
						else
							v63 = false
						end
						if not v63 then
							return
						end
						local v65 = v_u_3:FindFirstChild("Remotes")
						if v65 then
							v65 = v_u_3.Remotes:FindFirstChild("ConquerorHakiRemote")
						end
						if v65 then
							v65:FireServer("Activate")
						end
					end
				end)
				return
			elseif p56.KeyCode == Enum.KeyCode.DPadLeft then
				local v66 = v_u_4.Character
				local v67
				if v66 then
					local v68 = v66:FindFirstChild("Humanoid")
					if v68 and v68.Health > 0 then
						v67 = not v66:GetAttribute("InCutscene")
					else
						v67 = false
					end
				else
					v67 = false
				end
				if v67 then
					local v69 = v_u_8:FindFirstChild("ObservationHakiRemote")
					if v69 then
						v69:FireServer("Toggle")
					end
				end
			elseif p56.KeyCode == Enum.KeyCode.ButtonR3 then
				v_u_4:SetAttribute("ShiftLockEnabled", not v_u_4:GetAttribute("ShiftLockEnabled"))
				return
			elseif p56.KeyCode == Enum.KeyCode.ButtonR2 then
				local v70 = v_u_4.Character
				local v71
				if v70 then
					local v72 = v70:FindFirstChild("Humanoid")
					if v72 and v72.Health > 0 then
						v71 = not v70:GetAttribute("InCutscene")
					else
						v71 = false
					end
				else
					v71 = false
				end
				if v71 then
					local v73 = v_u_8:FindFirstChild("GamepadAttackTrigger")
					if v73 then
						v73:Fire()
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
local function v_u_80(p75)
	-- upvalues: (copy) v_u_7, (ref) v_u_13, (ref) v_u_12, (ref) v_u_14, (copy) v_u_4, (copy) v_u_8
	if v_u_7.IsGamepad then
		if p75.KeyCode == Enum.KeyCode.DPadDown then
			v_u_13 = false
			if tick() - v_u_12 < 0.5 and not v_u_14 then
				local v76 = v_u_4.Character
				local v77
				if v76 then
					local v78 = v76:FindFirstChild("Humanoid")
					if v78 and v78.Health > 0 then
						v77 = not v76:GetAttribute("InCutscene")
					else
						v77 = false
					end
				else
					v77 = false
				end
				if not v77 then
					return
				end
				local v79 = v_u_8:FindFirstChild("HakiRemote")
				if v79 then
					v79:FireServer("Toggle")
				end
			end
		end
	end
end
v_u_4.AncestryChanged:Connect(function()
	-- upvalues: (copy) v_u_10
	for _, v81 in ipairs(v_u_10) do
		if v81.Connected then
			v81:Disconnect()
		end
	end
end);
(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_10, (copy) v_u_2, (copy) v_u_54, (copy) v_u_74, (copy) v_u_80
	if not v_u_8:FindFirstChild("GamepadAttackTrigger") then
		local v82 = Instance.new("BindableEvent")
		v82.Name = "GamepadAttackTrigger"
		v82.Parent = v_u_8
	end
	if v_u_11 == "Xbox" then
		local v83 = v_u_10
		local v84 = v_u_2.InputBegan
		local v85 = v_u_54
		table.insert(v83, v84:Connect(v85))
	else
		local v86 = v_u_10
		local v87 = v_u_2.InputBegan
		local v88 = v_u_74
		table.insert(v86, v87:Connect(v88))
		local v89 = v_u_10
		local v90 = v_u_2.InputEnded
		local v91 = v_u_80
		table.insert(v89, v90:Connect(v91))
	end
end)()