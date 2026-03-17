local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v3 = game:GetService("SoundService")
local v_u_4 = game:GetService("StarterGui")
local v_u_5 = game:GetService("Lighting")
local v_u_6 = v_u_1.LocalPlayer
local v_u_7 = v_u_6:WaitForChild("PlayerGui")
local v_u_8 = require(v_u_2:WaitForChild("SettingsConfig"))
local v_u_9 = require(v_u_2:WaitForChild("Modules"):WaitForChild("SoundManager"))
local v_u_10 = require(v_u_2:WaitForChild("Modules"):WaitForChild("NotificationService"))
local v_u_11 = require(v_u_2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v12 = v_u_2:WaitForChild("RemoteEvents")
local v_u_13 = v12:WaitForChild("SettingsToggle")
local v_u_14 = v12:WaitForChild("CodeRedeem")
local v15 = v12:WaitForChild("SettingsSync")
local v_u_16 = v_u_7:WaitForChild("SettingsUI")
local v17 = v_u_16:WaitForChild("MainFrame")
local v18 = v17:WaitForChild("Frame")
local v_u_19 = v18:WaitForChild("Content"):WaitForChild("Settings")
local v_u_20 = v_u_7:WaitForChild("NotificationSettingsUI")
local v21 = v_u_20:WaitForChild("MainFrame")
local v22 = v21:WaitForChild("Frame")
local v23 = v22:WaitForChild("Content"):WaitForChild("Settings")
local v24 = v_u_19:WaitForChild("Button_DisableNotifications"):WaitForChild("OpenButton")
local v25 = v22:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_26 = v_u_7:WaitForChild("AccessorySettingsUI")
local v27 = v_u_26:WaitForChild("MainFrame")
local v28 = v27:WaitForChild("Frame")
local v29 = v28:WaitForChild("Content"):WaitForChild("Settings")
local v30 = v_u_19:WaitForChild("Button_AccessorySettings"):WaitForChild("OpenButton")
local v31 = v28:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_32 = v_u_7:WaitForChild("RaceRerollSettingsUI")
local v33 = v_u_32:WaitForChild("MainFrame")
local v34 = v33:WaitForChild("Frame")
local v35 = v34:WaitForChild("Content"):WaitForChild("Settings")
local v36 = v_u_19:WaitForChild("Button_RaceRerollSettings"):WaitForChild("OpenButton")
local v37 = v34:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_38 = v_u_7:WaitForChild("ClanRerollSettingsUI")
local v39 = v_u_38:WaitForChild("MainFrame")
local v40 = v39:WaitForChild("Frame")
local v41 = v40:WaitForChild("Content"):WaitForChild("Settings")
local v42 = v_u_19:WaitForChild("Button_ClanRerollSettings"):WaitForChild("OpenButton")
local v43 = v40:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_44 = v_u_7:WaitForChild("RestoreUIScreenGui")
local v45 = v_u_44:WaitForChild("RestoreButton")
local v_u_46 = false
local v_u_47 = {}
local v48 = v_u_7:WaitForChild("BasicStatsCurrencyAndButtonsUI").MainFrame:WaitForChild("UIButtons"):WaitForChild("SettingsButtonFrame"):WaitForChild("Button")
local v_u_49 = {}
local v_u_50 = {}
local v_u_51 = {}
local v_u_52 = 0
local v_u_53 = {}
local v_u_54 = {}
local v_u_55 = false
local v_u_56 = false
local v_u_57 = nil
local function v_u_60(p58)
	local v59 = p58.Parent
	while v59 and v59 ~= workspace do
		if v59.Name:match("^Portal_") or (v59.Name:match("DungeonPortal") or v59.Name == "ActiveDungeonPortal") then
			return true
		end
		v59 = v59.Parent
	end
	return false
end
local function v_u_64()
	-- upvalues: (ref) v_u_56, (copy) v_u_60, (ref) v_u_57
	if not v_u_56 then
		v_u_56 = true
		task.spawn(function()
			-- upvalues: (ref) v_u_56, (ref) v_u_60
			local v61 = 0
			for _, v62 in ipairs(workspace:GetDescendants()) do
				if not v_u_56 then
					return
				end
				if (v62:IsA("ParticleEmitter") or (v62:IsA("Beam") or v62:IsA("Trail"))) and not v_u_60(v62) then
					v62.Enabled = false
					v61 = v61 + 1
					if v61 % 50 == 0 then
						task.wait()
					end
				end
			end
		end)
		if v_u_57 then
			v_u_57:Disconnect()
		end
		v_u_57 = workspace.DescendantAdded:Connect(function(p63)
			-- upvalues: (ref) v_u_56, (ref) v_u_60
			if v_u_56 then
				if p63:IsA("ParticleEmitter") or (p63:IsA("Beam") or p63:IsA("Trail")) then
					if v_u_60(p63) then
						return
					end
					p63.Enabled = false
				end
			end
		end)
	end
end
local v_u_65 = v_u_56
local v_u_66 = v_u_57
for _, v67 in ipairs(v_u_8.Settings) do
	v_u_49[v67.Key] = false
end
local function v80(p68, p69)
	-- upvalues: (copy) v_u_8, (copy) v_u_50, (copy) v_u_51, (copy) v_u_49, (copy) v_u_9, (copy) v_u_13
	local v70 = v_u_8.GetSubMenuSettings(p68)
	for _, v_u_71 in ipairs(v70) do
		local v72 = p69:FindFirstChild("Toggle_" .. v_u_71.Key)
		if v72 then
			v_u_50[v_u_71.Key] = v72
			local v73 = v72:FindFirstChild("SettingsHolder")
			if v73 then
				local v_u_74 = v73:FindFirstChild("On")
				local v_u_75 = v73:FindFirstChild("Off")
				if v_u_74 and v_u_75 then
					local function v78()
						-- upvalues: (ref) v_u_51, (copy) v_u_71, (ref) v_u_49, (copy) v_u_74, (copy) v_u_75, (ref) v_u_9, (ref) v_u_13
						local v76 = tick()
						if not v_u_51[v_u_71.Key] or v76 - v_u_51[v_u_71.Key] >= 0.3 then
							v_u_51[v_u_71.Key] = v76
							local v77 = not v_u_49[v_u_71.Key]
							v_u_49[v_u_71.Key] = v77
							v_u_74.Visible = v77
							v_u_75.Visible = not v77
							if v77 then
								v_u_9:Play("SettingEnable")
							else
								v_u_9:Play("SettingDisable")
							end
							v_u_13:FireServer(v_u_71.Key, v77)
							ApplySetting(v_u_71.Key, v77)
						end
					end
					v73.Activated:Connect(v78)
					v_u_74.Activated:Connect(v78)
					v_u_75.Activated:Connect(v78)
					local v79 = v_u_49[v_u_71.Key] or false
					v_u_74.Visible = v79
					v_u_75.Visible = not v79
				end
			end
		else
			warn("[SettingsClient] Missing sub-menu toggle: Toggle_" .. v_u_71.Key)
		end
	end
end
local v_u_81 = Enum.Material.SmoothPlastic
local function v_u_85()
	-- upvalues: (ref) v_u_55, (copy) v_u_53, (copy) v_u_54, (copy) v_u_81
	if not v_u_55 then
		v_u_55 = true
		local v82 = workspace:FindFirstChild("Sea")
		for _, v83 in ipairs(workspace:GetDescendants()) do
			if not v82 or v83 ~= v82 and not v83:IsDescendantOf(v82) then
				if v83:IsA("Texture") then
					if not v_u_53[v83] then
						v_u_53[v83] = {
							["Transparency"] = v83.Transparency
						}
					end
					v83.Transparency = 1
				elseif v83:IsA("Decal") then
					if not v_u_53[v83] then
						v_u_53[v83] = {
							["Transparency"] = v83.Transparency
						}
					end
					v83.Transparency = 1
				elseif v83:IsA("SurfaceAppearance") then
					if not v_u_53[v83] then
						v_u_53[v83] = {
							["Parent"] = v83.Parent
						}
						v83.Parent = nil
					end
				elseif v83:IsA("BasePart") then
					local v84 = v83.Parent
					if v84 and (not v84:FindFirstChildOfClass("Humanoid") and (not v83:IsDescendantOf(game.Players) and (not v83.Name:find("VFX") and (v83.Material ~= Enum.Material.Neon and v83.Material ~= Enum.Material.Water)))) then
						if not v_u_54[v83] then
							v_u_54[v83] = v83.Material
						end
						v83.Material = v_u_81
					end
				end
			end
		end
	end
end
local function v_u_90()
	-- upvalues: (ref) v_u_55, (copy) v_u_53, (copy) v_u_54
	if v_u_55 then
		v_u_55 = false
		for v86, v87 in pairs(v_u_53) do
			if v86 and v86.Parent ~= nil or v87.Parent then
				if v86:IsA("SurfaceAppearance") and v87.Parent then
					v86.Parent = v87.Parent
				elseif v87.Transparency then
					v86.Transparency = v87.Transparency
				end
			end
		end
		for v88, v89 in pairs(v_u_54) do
			if v88 and v88.Parent then
				v88.Material = v89
			end
		end
	end
end
local v_u_91 = v3:FindFirstChild("MusicGroup")
local v_u_92 = v3:FindFirstChild("SFXGroup")
local function v_u_96()
	-- upvalues: (ref) v_u_46, (ref) v_u_47, (copy) v_u_44, (copy) v_u_7, (copy) v_u_4
	if not v_u_46 then
		v_u_46 = true
		v_u_47 = {}
		local v93 = {
			[v_u_44] = true,
			[v_u_7:FindFirstChild("MobileButtonsUI")] = true
		}
		for _, v94 in ipairs(v_u_7:GetChildren()) do
			if v94:IsA("ScreenGui") and (not v93[v94] and v94.Enabled) then
				local v95 = v_u_47
				table.insert(v95, v94)
				v94.Enabled = false
			end
		end
		pcall(function()
			-- upvalues: (ref) v_u_4
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
		end)
		v_u_44.Enabled = true
	end
end
local function v_u_98()
	-- upvalues: (ref) v_u_46, (copy) v_u_44, (ref) v_u_47, (copy) v_u_4
	if v_u_46 then
		v_u_46 = false
		for _, v97 in ipairs(v_u_47) do
			if v97 and v97:IsA("ScreenGui") then
				v97.Enabled = true
			end
		end
		v_u_47 = {}
		pcall(function()
			-- upvalues: (ref) v_u_4
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Health, true)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, true)
		end)
		v_u_44.Enabled = false
	else
		v_u_44.Enabled = false
	end
end
function ApplySetting(p99, p100)
	-- upvalues: (copy) v_u_91, (copy) v_u_92, (copy) v_u_6, (copy) v_u_64, (ref) v_u_65, (ref) v_u_66, (copy) v_u_85, (copy) v_u_90, (copy) v_u_5, (copy) v_u_2, (copy) v_u_96, (copy) v_u_98, (copy) v_u_44
	if p99 == "MuteMusic" then
		if v_u_91 then
			v_u_91.Volume = p100 and 0 or 1
			return
		end
	elseif p99 == "MuteSFX" then
		if v_u_92 then
			v_u_92.Volume = p100 and 0 or 1
			return
		end
	elseif p99 == "DisableVFX" then
		v_u_6:SetAttribute("DisableVFX", p100)
		if p100 then
			v_u_64()
			return
		end
		if not v_u_65 then
			return
		end
		v_u_65 = false
		if v_u_66 then
			v_u_66:Disconnect()
			v_u_66 = nil
			return
		end
	else
		if p99 == "DisableOtherVFX" then
			v_u_6:SetAttribute("DisableOtherVFX", p100)
			return
		end
		if p99 == "DisableScreenShake" then
			v_u_6:SetAttribute("DisableScreenShake", p100)
			return
		end
		if p99 == "RemoveTexture" then
			v_u_6:SetAttribute("RemoveTexture", p100)
			if p100 then
				v_u_85()
			else
				v_u_90()
			end
		end
		if p99 == "RemoveShadows" then
			v_u_6:SetAttribute("RemoveShadows", p100)
			v_u_5.GlobalShadows = not p100
			return
		end
		if p99 == "HideAccessories" then
			v_u_6:SetAttribute("HideAccessories", p100)
			ApplyAccessoryVisibility(p100)
			return
		end
		if p99 == "HideAura" then
			v_u_6:SetAttribute("HideAura", p100)
			ApplyAuraVisibility(p100)
			return
		end
		if p99 == "HideRaceAccessory" then
			v_u_6:SetAttribute("HideRaceAccessory", p100)
			ApplyRaceAccessoryVisibility(p100)
			return
		end
		if p99 == "ShowHitbox" then
			v_u_6:SetAttribute("ShowHitbox", p100)
			return
		end
		if p99 == "HideBossHealthBar" then
			v_u_6:SetAttribute("HideBossHealthBar", p100)
			return
		end
		if p99 == "HideDamageCounter" then
			v_u_6:SetAttribute("HideDamageCounter", p100)
			return
		end
		if p99 == "HideQuestUI" then
			v_u_6:SetAttribute("HideQuestUI", p100)
			return
		end
		if p99 == "HideCooldownBar" then
			v_u_6:SetAttribute("HideCooldownBar", p100)
			local v101 = require(v_u_2:WaitForChild("CooldownUIManager"))
			if v101 and v101.SetHidden then
				v101:SetHidden(p100)
				return
			end
		else
			if p99 == "DisableCritIndicator" then
				v_u_6:SetAttribute("DisableCritIndicator", p100)
				return
			end
			if p99 == "DisableTradeRequests" then
				v_u_6:SetAttribute("DisableTradeRequests", p100)
				return
			end
			if p99 == "DisablePvP" then
				v_u_6:SetAttribute("DisablePvP", p100)
				return
			end
			if p99 == "EnableQuestRepeat" then
				v_u_6:SetAttribute("EnableQuestRepeat", p100)
				return
			end
			if p99 == "AutoQuestRepeat" then
				v_u_6:SetAttribute("AutoQuestRepeat", p100)
				return
			end
			if p99 == "DisableCoinsNotif" then
				v_u_6:SetAttribute("DisableCoinsNotif", p100)
				return
			end
			if p99 == "DisableGemsNotif" then
				v_u_6:SetAttribute("DisableGemsNotif", p100)
				return
			end
			if p99 == "DisableExpNotif" then
				v_u_6:SetAttribute("DisableExpNotif", p100)
				return
			end
			if p99 == "SkipEpicReroll" then
				v_u_6:SetAttribute("SkipEpicReroll", p100)
				return
			end
			if p99 == "SkipLegendaryReroll" then
				v_u_6:SetAttribute("SkipLegendaryReroll", p100)
				return
			end
			if p99 == "SkipEpicClan" then
				v_u_6:SetAttribute("SkipEpicClan", p100)
				return
			end
			if p99 == "SkipLegendaryClan" then
				v_u_6:SetAttribute("SkipLegendaryClan", p100)
				return
			end
			if p99 == "DisableAllUI" then
				v_u_6:SetAttribute("DisableAllUI", p100)
				if p100 then
					v_u_96()
				else
					v_u_98()
				end
				v_u_44.Enabled = p100
			end
		end
	end
end
function ApplyAccessoryVisibility(p102)
	-- upvalues: (copy) v_u_1
	for _, v103 in ipairs(v_u_1:GetPlayers()) do
		local v104 = v103.Character
		if v104 then
			for _, v105 in ipairs(v104:GetChildren()) do
				local v106 = v105:GetAttribute("GameAccessory")
				local v107 = v105:GetAttribute("RaceAccessory")
				if (v105:IsA("Accessory") or (v105:IsA("Model") or v105:IsA("Folder"))) and (v106 and not v107) then
					for _, v108 in ipairs(v105:GetDescendants()) do
						if v108:IsA("BasePart") then
							v108.Transparency = p102 and 1 or 0
						end
					end
				end
			end
		end
	end
end
function ApplyAuraVisibility(p109)
	-- upvalues: (copy) v_u_1
	for _, v110 in ipairs(v_u_1:GetPlayers()) do
		local v111 = v110.Character
		if v111 then
			for _, v112 in ipairs(v111:GetDescendants()) do
				if v112:GetAttribute("ShadowAura") and (v112:IsA("ParticleEmitter") or (v112:IsA("Beam") or v112:IsA("Trail"))) then
					v112.Enabled = not p109
				end
			end
		end
	end
end
function ApplyRaceAccessoryVisibility(p113)
	-- upvalues: (copy) v_u_1
	for _, v114 in ipairs(v_u_1:GetPlayers()) do
		local v115 = v114.Character
		if v115 then
			for _, v116 in ipairs(v115:GetChildren()) do
				if v116:IsA("Accessory") and v116:GetAttribute("RaceAccessory") then
					for _, v117 in ipairs(v116:GetDescendants()) do
						if v117:IsA("BasePart") then
							v117.Transparency = p113 and 1 or 0
						end
					end
				end
			end
		end
	end
end
function _G.ReapplyAccessorySettings()
	-- upvalues: (copy) v_u_49
	if v_u_49.HideAccessories then
		ApplyAccessoryVisibility(true)
	end
	if v_u_49.HideAura then
		ApplyAuraVisibility(true)
	end
	if v_u_49.HideRaceAccessory then
		ApplyRaceAccessoryVisibility(true)
	end
end
local function v_u_125()
	-- upvalues: (copy) v_u_49, (copy) v_u_50
	for v118, v119 in pairs(v_u_49) do
		ApplySetting(v118, v119)
	end
	for v120, v121 in pairs(v_u_50) do
		local v122 = v121:FindFirstChild("SettingsHolder")
		if v122 then
			local v123 = v122:FindFirstChild("On")
			local v124 = v122:FindFirstChild("Off")
			if v123 and v124 then
				v123.Visible = v_u_49[v120] or false
				v124.Visible = not v_u_49[v120]
			end
		end
	end
end
v_u_11:Register("Settings", v17)
v_u_11:Register("NotificationSettings", v21)
v_u_11:Register("AccessorySettings", v27)
v_u_11:Register("RaceRerollSettings", v33)
v_u_11:Register("ClanRerollSettings", v39)
v48.Activated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_16
	if not v_u_11:IsOnCooldown() then
		v_u_16.Enabled = true
		v_u_11:Toggle("Settings")
		if not v_u_11:IsOpen("Settings") then
			task.delay(v_u_11.AnimationDuration + 0.05, function()
				-- upvalues: (ref) v_u_11, (ref) v_u_16
				if not v_u_11:IsOpen("Settings") then
					v_u_16.Enabled = false
				end
			end)
		end
	end
end)
v18.CloseButtonFrame.CloseButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_16
	v_u_11:Close("Settings")
	task.delay(v_u_11.AnimationDuration + 0.05, function()
		-- upvalues: (ref) v_u_11, (ref) v_u_16
		if not v_u_11:IsOpen("Settings") then
			v_u_16.Enabled = false
		end
	end)
end)
v24.Activated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_20
	if not v_u_11:IsOnCooldown() then
		v_u_20.Enabled = true
		v_u_11:Open("NotificationSettings")
	end
end)
v25.Activated:Connect(function()
	-- upvalues: (copy) v_u_16, (copy) v_u_11
	v_u_16.Enabled = true
	v_u_11:Open("Settings")
end)
v30.Activated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_26
	if not v_u_11:IsOnCooldown() then
		v_u_26.Enabled = true
		v_u_11:Open("AccessorySettings")
	end
end)
v31.Activated:Connect(function()
	-- upvalues: (copy) v_u_16, (copy) v_u_11
	v_u_16.Enabled = true
	v_u_11:Open("Settings")
end)
v36.Activated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_32
	if not v_u_11:IsOnCooldown() then
		v_u_32.Enabled = true
		v_u_11:Open("RaceRerollSettings")
	end
end)
v37.Activated:Connect(function()
	-- upvalues: (copy) v_u_16, (copy) v_u_11
	v_u_16.Enabled = true
	v_u_11:Open("Settings")
end)
v42.Activated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_38
	if not v_u_11:IsOnCooldown() then
		v_u_38.Enabled = true
		v_u_11:Open("ClanRerollSettings")
	end
end)
v43.Activated:Connect(function()
	-- upvalues: (copy) v_u_16, (copy) v_u_11
	v_u_16.Enabled = true
	v_u_11:Open("Settings")
end)
v15.OnClientEvent:Connect(function(p126)
	-- upvalues: (copy) v_u_49, (copy) v_u_125
	if type(p126) == "table" then
		for v127, v128 in pairs(p126) do
			v_u_49[v127] = v128
		end
		v_u_125()
	end
end)
v_u_16.Enabled = false
v17.Visible = false
v_u_20.Enabled = false
v21.Visible = false
v_u_26.Enabled = false
v27.Visible = false
v_u_32.Enabled = false
v33.Visible = false
v_u_38.Enabled = false
v39.Visible = false
(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_19, (copy) v_u_50, (copy) v_u_51, (ref) v_u_52, (copy) v_u_10, (copy) v_u_49, (copy) v_u_9, (copy) v_u_13
	for _, v_u_129 in ipairs(v_u_8.Settings) do
		if not v_u_129.SubMenu then
			local v130 = v_u_19:FindFirstChild("Toggle_" .. v_u_129.Key)
			if v130 then
				v_u_50[v_u_129.Key] = v130
				local v131 = v130:FindFirstChild("SettingsHolder")
				if v131 then
					local v_u_132 = v131:FindFirstChild("On")
					local v_u_133 = v131:FindFirstChild("Off")
					if v_u_132 and v_u_133 then
						local function v141()
							-- upvalues: (ref) v_u_51, (copy) v_u_129, (ref) v_u_52, (ref) v_u_10, (ref) v_u_49, (copy) v_u_132, (copy) v_u_133, (ref) v_u_9, (ref) v_u_13, (ref) v_u_50
							local v134 = tick()
							if v_u_51[v_u_129.Key] and v134 - v_u_51[v_u_129.Key] < 0.3 then
								return
							else
								v_u_51[v_u_129.Key] = v134
								if v_u_129.Key == "DisablePvP" then
									if v134 - v_u_52 < 15 then
										local v135 = 15 - (v134 - v_u_52)
										v_u_10:ShowAlly("Wait " .. math.ceil(v135) .. "s before toggling PvP again")
										return
									end
									v_u_52 = v134
								end
								local v136 = not v_u_49[v_u_129.Key]
								if v_u_129.Key == "AutoQuestRepeat" and (v136 == true and not v_u_49.EnableQuestRepeat) then
									v_u_10:ShowAlly("Enable \'Enable Quest Repeat\' first!")
								else
									v_u_49[v_u_129.Key] = v136
									v_u_132.Visible = v136
									v_u_133.Visible = not v136
									if v136 then
										v_u_9:Play("SettingEnable")
									else
										v_u_9:Play("SettingDisable")
									end
									v_u_13:FireServer(v_u_129.Key, v136)
									ApplySetting(v_u_129.Key, v136)
									if v_u_129.Key == "EnableQuestRepeat" and (v136 == false and v_u_49.AutoQuestRepeat) then
										v_u_49.AutoQuestRepeat = false
										local v137 = v_u_50.AutoQuestRepeat
										local v138 = v137 and v137:FindFirstChild("SettingsHolder")
										if v138 then
											local v139 = v138:FindFirstChild("On")
											local v140 = v138:FindFirstChild("Off")
											if v139 and v140 then
												v139.Visible = false
												v140.Visible = true
											end
										end
										v_u_13:FireServer("AutoQuestRepeat", false)
										ApplySetting("AutoQuestRepeat", false)
									end
								end
							end
						end
						v131.Activated:Connect(v141)
						v_u_132.Activated:Connect(v141)
						v_u_133.Activated:Connect(v141)
						local v142 = v_u_49[v_u_129.Key] or false
						v_u_132.Visible = v142
						v_u_133.Visible = not v142
					end
				end
			else
				warn("[SettingsClient] Missing toggle: Toggle_" .. v_u_129.Key)
			end
		end
	end
end)()
v80("Notifications", v23)
v80("Accessories", v29)
v80("RaceReroll", v35)
v80("ClanReroll", v41);
(function()
	-- upvalues: (copy) v_u_19, (copy) v_u_14, (copy) v_u_10
	local v143 = v_u_19:FindFirstChild("SettingCodes")
	if v143 then
		local v_u_144 = v143.Holder.CodesBox.CodeBox
		local v145 = v143.Holder.Holder.Redeem
		local v_u_146 = v143.Description
		local v_u_147 = false
		v145.Activated:Connect(function()
			-- upvalues: (ref) v_u_147, (copy) v_u_144, (copy) v_u_146, (ref) v_u_14, (ref) v_u_10
			if v_u_147 then
				return
			else
				v_u_147 = true
				local v148 = v_u_144.Text
				if #v148 < 1 then
					v_u_146.Text = "Enter a code!"
					v_u_147 = false
				else
					v_u_146.Text = "Redeeming..."
					local v149, v150 = v_u_14:InvokeServer(v148)
					v_u_146.Text = v150 or (v149 and "Success!" or "Error")
					if v149 then
						v_u_144.Text = ""
						v_u_10:Show("Quest", {
							["message"] = v150 or "Code redeemed!"
						})
					elseif v150 == "Already redeemed" then
						v_u_10:Show("Quest", {
							["message"] = "Code already redeemed!"
						})
					elseif v150 == "Invalid code" then
						v_u_10:Show("Quest", {
							["message"] = "Invalid code!"
						})
					else
						v_u_10:Show("Quest", {
							["message"] = v150 or "Error!"
						})
					end
					task.wait(2)
					v_u_146.Text = "Enter a code to redeem"
					v_u_147 = false
				end
			end
		end)
	end
end)()
v45.Activated:Connect(function()
	-- upvalues: (copy) v_u_49, (copy) v_u_98, (copy) v_u_9, (copy) v_u_13, (copy) v_u_50
	v_u_49.DisableAllUI = false
	v_u_98()
	v_u_9:Play("SettingDisable")
	v_u_13:FireServer("DisableAllUI", false)
	local v151 = v_u_50.DisableAllUI
	local v152 = v151 and v151:FindFirstChild("SettingsHolder")
	if v152 then
		local v153 = v152:FindFirstChild("On")
		local v154 = v152:FindFirstChild("Off")
		if v153 and v154 then
			v153.Visible = false
			v154.Visible = true
		end
	end
end)
v_u_44.Enabled = false
workspace.DescendantAdded:Connect(function(p_u_155)
	-- upvalues: (ref) v_u_55, (copy) v_u_53, (copy) v_u_54, (copy) v_u_81
	if v_u_55 then
		local v156 = workspace:FindFirstChild("Sea")
		if not v156 or p_u_155 ~= v156 and not p_u_155:IsDescendantOf(v156) then
			task.defer(function()
				-- upvalues: (copy) p_u_155, (ref) v_u_53, (ref) v_u_54, (ref) v_u_81
				if p_u_155:IsA("Texture") or p_u_155:IsA("Decal") then
					if not v_u_53[p_u_155] then
						v_u_53[p_u_155] = {
							["Transparency"] = p_u_155.Transparency
						}
					end
					p_u_155.Transparency = 1
				elseif p_u_155:IsA("SurfaceAppearance") then
					if not v_u_53[p_u_155] then
						v_u_53[p_u_155] = {
							["Parent"] = p_u_155.Parent
						}
						p_u_155.Parent = nil
						return
					end
				elseif p_u_155:IsA("BasePart") then
					local v157 = p_u_155.Parent
					if v157 and (not v157:FindFirstChildOfClass("Humanoid") and (not p_u_155:IsDescendantOf(game.Players) and (not p_u_155.Name:find("VFX") and (p_u_155.Material ~= Enum.Material.Neon and p_u_155.Material ~= Enum.Material.Water)))) then
						if not v_u_54[p_u_155] then
							v_u_54[p_u_155] = p_u_155.Material
						end
						p_u_155.Material = v_u_81
					end
				end
			end)
		end
	else
		return
	end
end)
local function v_u_169(p158)
	-- upvalues: (copy) v_u_49
	if p158 then
		local function v_u_161(p159)
			for _, v160 in ipairs(p159:GetDescendants()) do
				if v160:IsA("BasePart") then
					v160.Transparency = 1
				end
			end
		end
		local function v_u_165(p_u_162)
			-- upvalues: (ref) v_u_49, (copy) v_u_161
			if p_u_162:IsA("Accessory") or (p_u_162:IsA("Model") or p_u_162:IsA("Folder")) then
				local v163 = p_u_162:GetAttribute("GameAccessory")
				local v164 = p_u_162:GetAttribute("RaceAccessory")
				if v163 and (not v164 and v_u_49.HideAccessories) then
					task.defer(function()
						-- upvalues: (ref) v_u_161, (copy) p_u_162
						v_u_161(p_u_162)
					end)
				end
				if v164 and v_u_49.HideRaceAccessory then
					task.defer(function()
						-- upvalues: (ref) v_u_161, (copy) p_u_162
						v_u_161(p_u_162)
					end)
				end
			end
		end
		p158.DescendantAdded:Connect(function(p166)
			-- upvalues: (ref) v_u_49
			if p166:GetAttribute("ShadowAura") and (v_u_49.HideAura and (p166:IsA("ParticleEmitter") or (p166:IsA("Beam") or p166:IsA("Trail")))) then
				p166.Enabled = false
			end
		end)
		p158.ChildAdded:Connect(function(p_u_167)
			-- upvalues: (copy) v_u_165, (ref) v_u_49, (copy) v_u_161
			if p_u_167:IsA("Accessory") or (p_u_167:IsA("Model") or p_u_167:IsA("Folder")) then
				v_u_165(p_u_167)
				task.delay(0.2, function()
					-- upvalues: (copy) p_u_167, (ref) v_u_165
					if p_u_167 and p_u_167.Parent then
						v_u_165(p_u_167)
					end
				end)
				p_u_167:GetAttributeChangedSignal("GameAccessory"):Connect(function()
					-- upvalues: (copy) p_u_167, (ref) v_u_49, (ref) v_u_161
					if p_u_167:GetAttribute("GameAccessory") and (not p_u_167:GetAttribute("RaceAccessory") and v_u_49.HideAccessories) then
						task.defer(function()
							-- upvalues: (ref) v_u_161, (ref) p_u_167
							v_u_161(p_u_167)
						end)
					end
				end)
				p_u_167:GetAttributeChangedSignal("RaceAccessory"):Connect(function()
					-- upvalues: (copy) p_u_167, (ref) v_u_49, (ref) v_u_161
					if p_u_167:GetAttribute("RaceAccessory") and v_u_49.HideRaceAccessory then
						task.defer(function()
							-- upvalues: (ref) v_u_161, (ref) p_u_167
							v_u_161(p_u_167)
						end)
					end
				end)
			end
		end)
		for _, v168 in ipairs(p158:GetChildren()) do
			v_u_165(v168)
		end
	end
end
v_u_1.PlayerAdded:Connect(function(p170)
	-- upvalues: (copy) v_u_169
	p170.CharacterAdded:Connect(v_u_169)
	if p170.Character then
		v_u_169(p170.Character)
	end
end)
for _, v171 in ipairs(v_u_1:GetPlayers()) do
	v171.CharacterAdded:Connect(v_u_169)
	if v171.Character then
		v_u_169(v171.Character)
	end
end