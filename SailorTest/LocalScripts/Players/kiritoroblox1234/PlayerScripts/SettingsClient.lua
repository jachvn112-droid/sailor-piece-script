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
local v_u_44 = v_u_7:WaitForChild("AutoSkillSettingsUI")
local v45 = v_u_44:WaitForChild("MainFrame")
local v46 = v45:WaitForChild("Frame")
local v47 = v46:WaitForChild("Content"):WaitForChild("Settings")
local v48 = v_u_19:WaitForChild("Button_AutoSkillSettings"):WaitForChild("OpenButton")
local v49 = v46:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_50 = v_u_7:WaitForChild("RestoreUIScreenGui")
local v51 = v_u_50:WaitForChild("RestoreButton")
local v_u_52 = false
local v_u_53 = {}
local v_u_54 = nil
local v55 = v_u_7:WaitForChild("BasicStatsCurrencyAndButtonsUI").MainFrame:WaitForChild("UIButtons"):WaitForChild("SettingsButtonFrame"):WaitForChild("Button")
local v_u_56 = {}
local v_u_57 = {}
local v_u_58 = {}
local v_u_59 = 0
local v_u_60 = {}
local v_u_61 = {}
local v_u_62 = false
local v_u_63 = false
local v_u_64 = nil
local function v_u_67(p65)
	local v66 = p65.Parent
	while v66 and v66 ~= workspace do
		if v66.Name:match("^Portal_") or (v66.Name:match("DungeonPortal") or v66.Name == "ActiveDungeonPortal") then
			return true
		end
		v66 = v66.Parent
	end
	return false
end
local function v_u_71()
	-- upvalues: (ref) v_u_63, (copy) v_u_67, (ref) v_u_64
	if not v_u_63 then
		v_u_63 = true
		task.spawn(function()
			-- upvalues: (ref) v_u_63, (ref) v_u_67
			local v68 = 0
			for _, v69 in ipairs(workspace:GetDescendants()) do
				if not v_u_63 then
					return
				end
				if (v69:IsA("ParticleEmitter") or (v69:IsA("Beam") or v69:IsA("Trail"))) and not v_u_67(v69) then
					v69.Enabled = false
					v68 = v68 + 1
					if v68 % 50 == 0 then
						task.wait()
					end
				end
			end
		end)
		if v_u_64 then
			v_u_64:Disconnect()
		end
		v_u_64 = workspace.DescendantAdded:Connect(function(p70)
			-- upvalues: (ref) v_u_63, (ref) v_u_67
			if v_u_63 then
				if p70:IsA("ParticleEmitter") or (p70:IsA("Beam") or p70:IsA("Trail")) then
					if v_u_67(p70) then
						return
					end
					p70.Enabled = false
				end
			end
		end)
	end
end
local v_u_72 = v_u_64
local v_u_73 = v_u_63
for _, v74 in ipairs(v_u_8.Settings) do
	v_u_56[v74.Key] = false
end
local function v87(p75, p76)
	-- upvalues: (copy) v_u_8, (copy) v_u_57, (copy) v_u_58, (copy) v_u_56, (copy) v_u_9, (copy) v_u_13
	local v77 = v_u_8.GetSubMenuSettings(p75)
	for _, v_u_78 in ipairs(v77) do
		local v79 = p76:FindFirstChild("Toggle_" .. v_u_78.Key)
		if v79 then
			v_u_57[v_u_78.Key] = v79
			local v80 = v79:FindFirstChild("SettingsHolder")
			if v80 then
				local v_u_81 = v80:FindFirstChild("On")
				local v_u_82 = v80:FindFirstChild("Off")
				if v_u_81 and v_u_82 then
					local function v85()
						-- upvalues: (ref) v_u_58, (copy) v_u_78, (ref) v_u_56, (copy) v_u_81, (copy) v_u_82, (ref) v_u_9, (ref) v_u_13
						local v83 = tick()
						if not v_u_58[v_u_78.Key] or v83 - v_u_58[v_u_78.Key] >= 0.3 then
							v_u_58[v_u_78.Key] = v83
							local v84 = not v_u_56[v_u_78.Key]
							v_u_56[v_u_78.Key] = v84
							v_u_81.Visible = v84
							v_u_82.Visible = not v84
							if v84 then
								v_u_9:Play("SettingEnable")
							else
								v_u_9:Play("SettingDisable")
							end
							v_u_13:FireServer(v_u_78.Key, v84)
							ApplySetting(v_u_78.Key, v84)
						end
					end
					v80.Activated:Connect(v85)
					v_u_81.Activated:Connect(v85)
					v_u_82.Activated:Connect(v85)
					local v86 = v_u_56[v_u_78.Key] or false
					v_u_81.Visible = v86
					v_u_82.Visible = not v86
				end
			end
		else
			warn("[SettingsClient] Missing sub-menu toggle: Toggle_" .. v_u_78.Key)
		end
	end
end
local v_u_88 = Enum.Material.SmoothPlastic
local function v_u_92()
	-- upvalues: (ref) v_u_62, (copy) v_u_60, (copy) v_u_61, (copy) v_u_88
	if not v_u_62 then
		v_u_62 = true
		local v89 = workspace:FindFirstChild("Sea")
		for _, v90 in ipairs(workspace:GetDescendants()) do
			if not v89 or v90 ~= v89 and not v90:IsDescendantOf(v89) then
				if v90:IsA("Texture") then
					if not v_u_60[v90] then
						v_u_60[v90] = {
							["Transparency"] = v90.Transparency
						}
					end
					v90.Transparency = 1
				elseif v90:IsA("Decal") then
					if not v_u_60[v90] then
						v_u_60[v90] = {
							["Transparency"] = v90.Transparency
						}
					end
					v90.Transparency = 1
				elseif v90:IsA("SurfaceAppearance") then
					if not v_u_60[v90] then
						v_u_60[v90] = {
							["Parent"] = v90.Parent
						}
						v90.Parent = nil
					end
				elseif v90:IsA("BasePart") then
					local v91 = v90.Parent
					if v91 and (not v91:FindFirstChildOfClass("Humanoid") and (not v90:IsDescendantOf(game.Players) and (not v90.Name:find("VFX") and (v90.Material ~= Enum.Material.Neon and v90.Material ~= Enum.Material.Water)))) then
						if not v_u_61[v90] then
							v_u_61[v90] = v90.Material
						end
						v90.Material = v_u_88
					end
				end
			end
		end
	end
end
local function v_u_97()
	-- upvalues: (ref) v_u_62, (copy) v_u_60, (copy) v_u_61
	if v_u_62 then
		v_u_62 = false
		for v93, v94 in pairs(v_u_60) do
			if v93 and v93.Parent ~= nil or v94.Parent then
				if v93:IsA("SurfaceAppearance") and v94.Parent then
					v93.Parent = v94.Parent
				elseif v94.Transparency then
					v93.Transparency = v94.Transparency
				end
			end
		end
		for v95, v96 in pairs(v_u_61) do
			if v95 and v95.Parent then
				v95.Material = v96
			end
		end
	end
end
local v_u_98 = v3:FindFirstChild("MusicGroup")
local v_u_99 = v3:FindFirstChild("SFXGroup")
local function v_u_108()
	-- upvalues: (ref) v_u_52, (ref) v_u_53, (copy) v_u_7, (ref) v_u_54, (copy) v_u_4, (copy) v_u_50
	if not v_u_52 then
		v_u_52 = true
		v_u_53 = {}
		local v_u_100 = {
			["RestoreUIScreenGui"] = true,
			["MobileButtonsUI"] = true,
			["SkillTreeUI"] = true
		}
		for _, v101 in ipairs(v_u_7:GetChildren()) do
			if v101:IsA("ScreenGui") and (not v_u_100[v101.Name] and v101.Enabled) then
				local v102 = v_u_53
				table.insert(v102, v101)
				v101.Enabled = false
			end
		end
		if v_u_54 then
			v_u_54:Disconnect()
		end
		v_u_54 = v_u_7.ChildAdded:Connect(function(p_u_103)
			-- upvalues: (ref) v_u_52, (copy) v_u_100, (ref) v_u_53
			if v_u_52 then
				if p_u_103:IsA("ScreenGui") and not v_u_100[p_u_103.Name] then
					task.defer(function()
						-- upvalues: (copy) p_u_103, (ref) v_u_52, (ref) v_u_53
						if p_u_103.Enabled and v_u_52 then
							local v104 = v_u_53
							local v105 = p_u_103
							table.insert(v104, v105)
							p_u_103.Enabled = false
						end
					end)
				end
			end
		end)
		task.spawn(function()
			-- upvalues: (ref) v_u_52, (ref) v_u_7, (copy) v_u_100, (ref) v_u_53
			for _ = 1, 6 do
				task.wait(0.5)
				if not v_u_52 then
					return
				end
				for _, v106 in ipairs(v_u_7:GetChildren()) do
					if v106:IsA("ScreenGui") and (not v_u_100[v106.Name] and v106.Enabled) then
						local v107 = v_u_53
						table.insert(v107, v106)
						v106.Enabled = false
					end
				end
			end
		end)
		pcall(function()
			-- upvalues: (ref) v_u_4
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
		end)
		v_u_50.Enabled = true
	end
end
local function v_u_110()
	-- upvalues: (ref) v_u_52, (copy) v_u_50, (ref) v_u_54, (ref) v_u_53, (copy) v_u_4
	if v_u_52 then
		v_u_52 = false
		if v_u_54 then
			v_u_54:Disconnect()
			v_u_54 = nil
		end
		for _, v109 in ipairs(v_u_53) do
			if v109 and v109:IsA("ScreenGui") then
				v109.Enabled = true
			end
		end
		v_u_53 = {}
		pcall(function()
			-- upvalues: (ref) v_u_4
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Health, true)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
			v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, true)
		end)
		v_u_50.Enabled = false
	else
		v_u_50.Enabled = false
	end
end
function ApplySetting(p111, p112)
	-- upvalues: (copy) v_u_98, (copy) v_u_99, (copy) v_u_6, (copy) v_u_71, (ref) v_u_73, (ref) v_u_72, (copy) v_u_92, (copy) v_u_97, (copy) v_u_5, (copy) v_u_2, (copy) v_u_108, (copy) v_u_110, (copy) v_u_50
	if p111 == "MuteMusic" then
		if v_u_98 then
			v_u_98.Volume = p112 and 0 or 1
			return
		end
	elseif p111 == "MuteSFX" then
		if v_u_99 then
			v_u_99.Volume = p112 and 0 or 1
			return
		end
	elseif p111 == "DisableVFX" then
		v_u_6:SetAttribute("DisableVFX", p112)
		if p112 then
			v_u_71()
			return
		end
		if not v_u_73 then
			return
		end
		v_u_73 = false
		if v_u_72 then
			v_u_72:Disconnect()
			v_u_72 = nil
			return
		end
	else
		if p111 == "DisableOtherVFX" then
			v_u_6:SetAttribute("DisableOtherVFX", p112)
			return
		end
		if p111 == "DisableScreenShake" then
			v_u_6:SetAttribute("DisableScreenShake", p112)
			return
		end
		if p111 == "DisableCutscene" then
			v_u_6:SetAttribute("DisableCutscene", p112)
			return
		end
		if p111 == "RemoveTexture" then
			v_u_6:SetAttribute("RemoveTexture", p112)
			if p112 then
				v_u_92()
			else
				v_u_97()
			end
		end
		if p111 == "RemoveShadows" then
			v_u_6:SetAttribute("RemoveShadows", p112)
			v_u_5.GlobalShadows = not p112
			return
		end
		if p111 == "HideAccessories" then
			v_u_6:SetAttribute("HideAccessories", p112)
			ApplyAccessoryVisibility(p112)
			return
		end
		if p111 == "HideAura" then
			v_u_6:SetAttribute("HideAura", p112)
			ApplyAuraVisibility(p112)
			return
		end
		if p111 == "HideRaceAccessory" then
			v_u_6:SetAttribute("HideRaceAccessory", p112)
			ApplyRaceAccessoryVisibility(p112)
			return
		end
		if p111 == "ShowHitbox" then
			v_u_6:SetAttribute("ShowHitbox", p112)
			return
		end
		if p111 == "HideBossHealthBar" then
			v_u_6:SetAttribute("HideBossHealthBar", p112)
			return
		end
		if p111 == "HideDamageCounter" then
			v_u_6:SetAttribute("HideDamageCounter", p112)
			return
		end
		if p111 == "HideQuestUI" then
			v_u_6:SetAttribute("HideQuestUI", p112)
			return
		end
		if p111 == "HideCooldownBar" then
			v_u_6:SetAttribute("HideCooldownBar", p112)
			local v113 = require(v_u_2:WaitForChild("CooldownUIManager"))
			if v113 and v113.SetHidden then
				v113:SetHidden(p112)
				return
			end
		else
			if p111 == "DisableCritIndicator" then
				v_u_6:SetAttribute("DisableCritIndicator", p112)
				return
			end
			if p111 == "DisableTradeRequests" then
				v_u_6:SetAttribute("DisableTradeRequests", p112)
				return
			end
			if p111 == "DisablePvP" then
				v_u_6:SetAttribute("DisablePvP", p112)
				return
			end
			if p111 == "EnableQuestRepeat" then
				v_u_6:SetAttribute("EnableQuestRepeat", p112)
				return
			end
			if p111 == "AutoQuestRepeat" then
				v_u_6:SetAttribute("AutoQuestRepeat", p112)
				return
			end
			if p111 == "DisableCoinsNotif" then
				v_u_6:SetAttribute("DisableCoinsNotif", p112)
				return
			end
			if p111 == "DisableGemsNotif" then
				v_u_6:SetAttribute("DisableGemsNotif", p112)
				return
			end
			if p111 == "DisableExpNotif" then
				v_u_6:SetAttribute("DisableExpNotif", p112)
				return
			end
			if p111 == "HideCommonNotif" then
				v_u_6:SetAttribute("HideCommonNotif", p112)
				return
			end
			if p111 == "HideUncommonNotif" then
				v_u_6:SetAttribute("HideUncommonNotif", p112)
				return
			end
			if p111 == "HideRareNotif" then
				v_u_6:SetAttribute("HideRareNotif", p112)
				return
			end
			if p111 == "HideEpicNotif" then
				v_u_6:SetAttribute("HideEpicNotif", p112)
				return
			end
			if p111 == "HideLegendaryNotif" then
				v_u_6:SetAttribute("HideLegendaryNotif", p112)
				return
			end
			if p111 == "HideMythicalNotif" then
				v_u_6:SetAttribute("HideMythicalNotif", p112)
				return
			end
			if p111 == "SkipEpicReroll" then
				v_u_6:SetAttribute("SkipEpicReroll", p112)
				return
			end
			if p111 == "SkipLegendaryReroll" then
				v_u_6:SetAttribute("SkipLegendaryReroll", p112)
				return
			end
			if p111 == "SkipEpicClan" then
				v_u_6:SetAttribute("SkipEpicClan", p112)
				return
			end
			if p111 == "SkipLegendaryClan" then
				v_u_6:SetAttribute("SkipLegendaryClan", p112)
				return
			end
			if p111 == "DisableAllUI" then
				v_u_6:SetAttribute("DisableAllUI", p112)
				if p112 then
					v_u_108()
				else
					v_u_110()
				end
				v_u_50.Enabled = p112
			end
		end
	end
end
function ApplyAccessoryVisibility(p114)
	-- upvalues: (copy) v_u_1
	for _, v115 in ipairs(v_u_1:GetPlayers()) do
		local v116 = v115.Character
		if v116 then
			for _, v117 in ipairs(v116:GetChildren()) do
				local v118 = v117:GetAttribute("GameAccessory")
				local v119 = v117:GetAttribute("RaceAccessory")
				if (v117:IsA("Accessory") or (v117:IsA("Model") or v117:IsA("Folder"))) and (v118 and not v119) then
					for _, v120 in ipairs(v117:GetDescendants()) do
						if v120:IsA("BasePart") then
							v120.Transparency = p114 and 1 or 0
						end
					end
				end
			end
		end
	end
end
function ApplyAuraVisibility(p121)
	-- upvalues: (copy) v_u_1
	for _, v122 in ipairs(v_u_1:GetPlayers()) do
		local v123 = v122.Character
		if v123 then
			for _, v124 in ipairs(v123:GetDescendants()) do
				if v124:GetAttribute("ShadowAura") and (v124:IsA("ParticleEmitter") or (v124:IsA("Beam") or v124:IsA("Trail"))) then
					v124.Enabled = not p121
				end
			end
		end
	end
end
function ApplyRaceAccessoryVisibility(p125)
	-- upvalues: (copy) v_u_1
	for _, v126 in ipairs(v_u_1:GetPlayers()) do
		local v127 = v126.Character
		if v127 then
			for _, v128 in ipairs(v127:GetChildren()) do
				if v128:IsA("Accessory") and v128:GetAttribute("RaceAccessory") then
					for _, v129 in ipairs(v128:GetDescendants()) do
						if v129:IsA("BasePart") then
							v129.Transparency = p125 and 1 or 0
						end
					end
				end
			end
		end
	end
end
function _G.ReapplyAccessorySettings()
	-- upvalues: (copy) v_u_56
	if v_u_56.HideAccessories then
		ApplyAccessoryVisibility(true)
	end
	if v_u_56.HideAura then
		ApplyAuraVisibility(true)
	end
	if v_u_56.HideRaceAccessory then
		ApplyRaceAccessoryVisibility(true)
	end
end
local function v_u_137()
	-- upvalues: (copy) v_u_56, (copy) v_u_57
	for v130, v131 in pairs(v_u_56) do
		ApplySetting(v130, v131)
	end
	for v132, v133 in pairs(v_u_57) do
		local v134 = v133:FindFirstChild("SettingsHolder")
		if v134 then
			local v135 = v134:FindFirstChild("On")
			local v136 = v134:FindFirstChild("Off")
			if v135 and v136 then
				v135.Visible = v_u_56[v132] or false
				v136.Visible = not v_u_56[v132]
			end
		end
	end
end
v_u_11:Register("Settings", v17)
v_u_11:Register("NotificationSettings", v21)
v_u_11:Register("AccessorySettings", v27)
v_u_11:Register("RaceRerollSettings", v33)
v_u_11:Register("ClanRerollSettings", v39)
v_u_11:Register("AutoSkillSettings", v45)
v55.Activated:Connect(function()
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
v48.Activated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_44
	if not v_u_11:IsOnCooldown() then
		v_u_44.Enabled = true
		v_u_11:Open("AutoSkillSettings")
	end
end)
v49.Activated:Connect(function()
	-- upvalues: (copy) v_u_16, (copy) v_u_11
	v_u_16.Enabled = true
	v_u_11:Open("Settings")
end)
v15.OnClientEvent:Connect(function(p138)
	-- upvalues: (copy) v_u_56, (copy) v_u_137
	if type(p138) == "table" then
		for v139, v140 in pairs(p138) do
			v_u_56[v139] = v140
		end
		v_u_137()
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
	-- upvalues: (copy) v_u_8, (copy) v_u_19, (copy) v_u_57, (copy) v_u_58, (ref) v_u_59, (copy) v_u_10, (copy) v_u_56, (copy) v_u_9, (copy) v_u_13
	for _, v_u_141 in ipairs(v_u_8.Settings) do
		if not v_u_141.SubMenu then
			local v142 = v_u_19:FindFirstChild("Toggle_" .. v_u_141.Key)
			if v142 then
				v_u_57[v_u_141.Key] = v142
				local v143 = v142:FindFirstChild("SettingsHolder")
				if v143 then
					local v_u_144 = v143:FindFirstChild("On")
					local v_u_145 = v143:FindFirstChild("Off")
					if v_u_144 and v_u_145 then
						local function v153()
							-- upvalues: (ref) v_u_58, (copy) v_u_141, (ref) v_u_59, (ref) v_u_10, (ref) v_u_56, (copy) v_u_144, (copy) v_u_145, (ref) v_u_9, (ref) v_u_13, (ref) v_u_57
							local v146 = tick()
							if v_u_58[v_u_141.Key] and v146 - v_u_58[v_u_141.Key] < 0.3 then
								return
							else
								v_u_58[v_u_141.Key] = v146
								if v_u_141.Key == "DisablePvP" then
									if v146 - v_u_59 < 15 then
										local v147 = 15 - (v146 - v_u_59)
										v_u_10:ShowAlly("Wait " .. math.ceil(v147) .. "s before toggling PvP again")
										return
									end
									v_u_59 = v146
								end
								local v148 = not v_u_56[v_u_141.Key]
								if v_u_141.Key == "AutoQuestRepeat" and (v148 == true and not v_u_56.EnableQuestRepeat) then
									v_u_10:ShowAlly("Enable \'Enable Quest Repeat\' first!")
								else
									v_u_56[v_u_141.Key] = v148
									v_u_144.Visible = v148
									v_u_145.Visible = not v148
									if v148 then
										v_u_9:Play("SettingEnable")
									else
										v_u_9:Play("SettingDisable")
									end
									v_u_13:FireServer(v_u_141.Key, v148)
									ApplySetting(v_u_141.Key, v148)
									if v_u_141.Key == "EnableQuestRepeat" and (v148 == false and v_u_56.AutoQuestRepeat) then
										v_u_56.AutoQuestRepeat = false
										local v149 = v_u_57.AutoQuestRepeat
										local v150 = v149 and v149:FindFirstChild("SettingsHolder")
										if v150 then
											local v151 = v150:FindFirstChild("On")
											local v152 = v150:FindFirstChild("Off")
											if v151 and v152 then
												v151.Visible = false
												v152.Visible = true
											end
										end
										v_u_13:FireServer("AutoQuestRepeat", false)
										ApplySetting("AutoQuestRepeat", false)
									end
								end
							end
						end
						v143.Activated:Connect(v153)
						v_u_144.Activated:Connect(v153)
						v_u_145.Activated:Connect(v153)
						local v154 = v_u_56[v_u_141.Key] or false
						v_u_144.Visible = v154
						v_u_145.Visible = not v154
					end
				end
			else
				warn("[SettingsClient] Missing toggle: Toggle_" .. v_u_141.Key)
			end
		end
	end
end)()
v87("Notifications", v23)
v87("Accessories", v29)
v87("RaceReroll", v35)
v87("ClanReroll", v41)
v87("AutoSkill", v47);
(function()
	-- upvalues: (copy) v_u_19, (copy) v_u_14, (copy) v_u_10
	local v155 = v_u_19:FindFirstChild("SettingCodes")
	if v155 then
		local v_u_156 = v155.Holder.CodesBox.CodeBox
		local v157 = v155.Holder.Holder.Redeem
		local v_u_158 = v155.Description
		local v_u_159 = false
		v157.Activated:Connect(function()
			-- upvalues: (ref) v_u_159, (copy) v_u_156, (copy) v_u_158, (ref) v_u_14, (ref) v_u_10
			if v_u_159 then
				return
			else
				v_u_159 = true
				local v160 = v_u_156.Text
				if #v160 < 1 then
					v_u_158.Text = "Enter a code!"
					v_u_159 = false
				else
					v_u_158.Text = "Redeeming..."
					local v161, v162 = v_u_14:InvokeServer(v160)
					v_u_158.Text = v162 or (v161 and "Success!" or "Error")
					if v161 then
						v_u_156.Text = ""
						v_u_10:Show("Quest", {
							["message"] = v162 or "Code redeemed!"
						})
					elseif v162 == "Already redeemed" then
						v_u_10:Show("Quest", {
							["message"] = "Code already redeemed!"
						})
					elseif v162 == "Invalid code" then
						v_u_10:Show("Quest", {
							["message"] = "Invalid code!"
						})
					else
						v_u_10:Show("Quest", {
							["message"] = v162 or "Error!"
						})
					end
					task.wait(2)
					v_u_158.Text = "Enter a code to redeem"
					v_u_159 = false
				end
			end
		end)
	end
end)()
v51.Activated:Connect(function()
	-- upvalues: (copy) v_u_56, (copy) v_u_110, (copy) v_u_9, (copy) v_u_13, (copy) v_u_57
	v_u_56.DisableAllUI = false
	v_u_110()
	v_u_9:Play("SettingDisable")
	v_u_13:FireServer("DisableAllUI", false)
	local v163 = v_u_57.DisableAllUI
	local v164 = v163 and v163:FindFirstChild("SettingsHolder")
	if v164 then
		local v165 = v164:FindFirstChild("On")
		local v166 = v164:FindFirstChild("Off")
		if v165 and v166 then
			v165.Visible = false
			v166.Visible = true
		end
	end
end)
v_u_50.Enabled = false
workspace.DescendantAdded:Connect(function(p_u_167)
	-- upvalues: (ref) v_u_62, (copy) v_u_60, (copy) v_u_61, (copy) v_u_88
	if v_u_62 then
		local v168 = workspace:FindFirstChild("Sea")
		if not v168 or p_u_167 ~= v168 and not p_u_167:IsDescendantOf(v168) then
			task.defer(function()
				-- upvalues: (copy) p_u_167, (ref) v_u_60, (ref) v_u_61, (ref) v_u_88
				if p_u_167:IsA("Texture") or p_u_167:IsA("Decal") then
					if not v_u_60[p_u_167] then
						v_u_60[p_u_167] = {
							["Transparency"] = p_u_167.Transparency
						}
					end
					p_u_167.Transparency = 1
				elseif p_u_167:IsA("SurfaceAppearance") then
					if not v_u_60[p_u_167] then
						v_u_60[p_u_167] = {
							["Parent"] = p_u_167.Parent
						}
						p_u_167.Parent = nil
						return
					end
				elseif p_u_167:IsA("BasePart") then
					local v169 = p_u_167.Parent
					if v169 and (not v169:FindFirstChildOfClass("Humanoid") and (not p_u_167:IsDescendantOf(game.Players) and (not p_u_167.Name:find("VFX") and (p_u_167.Material ~= Enum.Material.Neon and p_u_167.Material ~= Enum.Material.Water)))) then
						if not v_u_61[p_u_167] then
							v_u_61[p_u_167] = p_u_167.Material
						end
						p_u_167.Material = v_u_88
					end
				end
			end)
		end
	else
		return
	end
end)
local function v_u_181(p170)
	-- upvalues: (copy) v_u_56
	if p170 then
		local function v_u_173(p171)
			for _, v172 in ipairs(p171:GetDescendants()) do
				if v172:IsA("BasePart") then
					v172.Transparency = 1
				end
			end
		end
		local function v_u_177(p_u_174)
			-- upvalues: (ref) v_u_56, (copy) v_u_173
			if p_u_174:IsA("Accessory") or (p_u_174:IsA("Model") or p_u_174:IsA("Folder")) then
				local v175 = p_u_174:GetAttribute("GameAccessory")
				local v176 = p_u_174:GetAttribute("RaceAccessory")
				if v175 and (not v176 and v_u_56.HideAccessories) then
					task.defer(function()
						-- upvalues: (ref) v_u_173, (copy) p_u_174
						v_u_173(p_u_174)
					end)
				end
				if v176 and v_u_56.HideRaceAccessory then
					task.defer(function()
						-- upvalues: (ref) v_u_173, (copy) p_u_174
						v_u_173(p_u_174)
					end)
				end
			end
		end
		p170.DescendantAdded:Connect(function(p178)
			-- upvalues: (ref) v_u_56
			if p178:GetAttribute("ShadowAura") and (v_u_56.HideAura and (p178:IsA("ParticleEmitter") or (p178:IsA("Beam") or p178:IsA("Trail")))) then
				p178.Enabled = false
			end
		end)
		p170.ChildAdded:Connect(function(p_u_179)
			-- upvalues: (copy) v_u_177, (ref) v_u_56, (copy) v_u_173
			if p_u_179:IsA("Accessory") or (p_u_179:IsA("Model") or p_u_179:IsA("Folder")) then
				v_u_177(p_u_179)
				task.delay(0.2, function()
					-- upvalues: (copy) p_u_179, (ref) v_u_177
					if p_u_179 and p_u_179.Parent then
						v_u_177(p_u_179)
					end
				end)
				p_u_179:GetAttributeChangedSignal("GameAccessory"):Connect(function()
					-- upvalues: (copy) p_u_179, (ref) v_u_56, (ref) v_u_173
					if p_u_179:GetAttribute("GameAccessory") and (not p_u_179:GetAttribute("RaceAccessory") and v_u_56.HideAccessories) then
						task.defer(function()
							-- upvalues: (ref) v_u_173, (ref) p_u_179
							v_u_173(p_u_179)
						end)
					end
				end)
				p_u_179:GetAttributeChangedSignal("RaceAccessory"):Connect(function()
					-- upvalues: (copy) p_u_179, (ref) v_u_56, (ref) v_u_173
					if p_u_179:GetAttribute("RaceAccessory") and v_u_56.HideRaceAccessory then
						task.defer(function()
							-- upvalues: (ref) v_u_173, (ref) p_u_179
							v_u_173(p_u_179)
						end)
					end
				end)
			end
		end)
		for _, v180 in ipairs(p170:GetChildren()) do
			v_u_177(v180)
		end
	end
end
v_u_1.PlayerAdded:Connect(function(p182)
	-- upvalues: (copy) v_u_181
	p182.CharacterAdded:Connect(v_u_181)
	if p182.Character then
		v_u_181(p182.Character)
	end
end)
for _, v183 in ipairs(v_u_1:GetPlayers()) do
	v183.CharacterAdded:Connect(v_u_181)
	if v183.Character then
		v_u_181(v183.Character)
	end
end