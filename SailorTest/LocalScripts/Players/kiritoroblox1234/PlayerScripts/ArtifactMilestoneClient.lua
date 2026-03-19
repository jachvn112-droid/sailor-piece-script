local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_5 = require(v2:WaitForChild("Modules"):WaitForChild("ArtifactMilestoneConfig"))
require(v2:WaitForChild("Modules"):WaitForChild("ArtifactConfig"))
local v_u_6 = require(v2:WaitForChild("Modules"):WaitForChild("ItemImageConfig"))
local v_u_7 = require(v2:WaitForChild("Modules"):WaitForChild("ItemRarityConfig"))
local v8 = v2:WaitForChild("RemoteEvents")
local v9 = v2:WaitForChild("RemoteFunctions")
local v10 = v8:WaitForChild("ArtifactMilestoneOpenUI")
local v11 = v8:WaitForChild("ArtifactMilestoneCloseUI")
local v12 = v8:WaitForChild("ArtifactMilestoneDataSync")
local v_u_13 = v8:WaitForChild("ArtifactMilestoneClaimReward")
v9:WaitForChild("GetArtifactMilestoneData")
local v_u_14 = v_u_4:WaitForChild("ArtifactMilestoneUI")
local v15 = v_u_14:WaitForChild("MilestoneFrame")
local v16 = v15:WaitForChild("MilestoneFrame")
local v_u_17 = v16:WaitForChild("DataFrame"):WaitForChild("StatsFrame")
local v18 = v16:WaitForChild("RewardsFrame")
local v_u_19 = v18:WaitForChild("RewardsFrame")
local v20 = v18:WaitForChild("ClaimInfo")
local v_u_21 = v20:WaitForChild("AlreadyClaimedForThisMilestoneLevelVisibleOnIfClaimed")
local v_u_22 = v20:WaitForChild("ClaimFrameVisibleOnIfUnclaimedThisMilestoneLevel")
local v_u_23 = v_u_22:WaitForChild("Claim")
local v24 = v16:WaitForChild("MilestoneHolder")
local v25 = v24:WaitForChild("InfoHolder"):WaitForChild("LevelInfo")
local v_u_26 = v25:WaitForChild("CurrentLevelOfYourMilestone")
local v_u_27 = v25:WaitForChild("ArtifactCollectionProgress")
local v28 = v24:WaitForChild("XPBarProgressFrame")
local v_u_29 = v28:WaitForChild("InfoHolder"):WaitForChild("CurrentExpAndWhatYouNeedForTheNextLevel")
local v_u_30 = nil
local v_u_31 = nil
for _, v32 in ipairs(v28:GetChildren()) do
	if v32.Name == "MilestoneFrame" and v32:IsA("Frame") then
		local v33 = v32:FindFirstChild("InfoHolder")
		if v33 then
			local v34 = v33:FindFirstChild("CurrentLevelNumber")
			local v35 = v33:FindFirstChild("NextLevelNumber")
			v_u_30 = v34 or v_u_30
			if v35 then
				v_u_31 = v35
			end
		end
	end
end
local v_u_36 = v28:WaitForChild("Loader")
local v_u_37 = v24:WaitForChild("RewardsHolder"):WaitForChild("MilestonesHolder"):WaitForChild("Milestones")
local v_u_38 = v_u_37:FindFirstChild("DuplicateThisFrameForEachLevel")
local v_u_39 = v_u_19:FindFirstChild("ItemFrameDuplicateDependingOnHowManyItemsThisMilestoneLevelAwards")
local v_u_40 = v15:WaitForChild("CloseButtonFrameHolder"):WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_41 = nil
local v_u_42 = {}
local v_u_43 = false
local function v_u_45()
	-- upvalues: (copy) v_u_4, (ref) v_u_42
	for _, v44 in ipairs(v_u_4:GetChildren()) do
		if v44:IsA("ScreenGui") and (v44.Name ~= "ArtifactMilestoneUI" and (v44.Enabled and not v_u_42[v44])) then
			v_u_42[v44] = true
			v44.Enabled = false
		end
	end
end
local function v_u_47()
	-- upvalues: (ref) v_u_42
	for v46, _ in pairs(v_u_42) do
		if v46 and v46.Parent then
			v46.Enabled = true
		end
	end
	v_u_42 = {}
end
local v_u_48 = 1
local v_u_49 = {}
local v_u_50 = 0
local v_u_51 = #{
	"Ashen Chronicles",
	"Crownless Regalia",
	"Black Horizon",
	"Celestial Rupture",
	"Abyssal Sovereign"
} * #{
	"Helmet",
	"Body",
	"Gloves",
	"Boots"
}
local function v_u_58()
	-- upvalues: (ref) v_u_41, (copy) v_u_5, (copy) v_u_17
	if v_u_41 then
		local v52 = v_u_41.RarityChances or v_u_5:GetRarityChances(0)
		for _, v53 in ipairs({
			"Common",
			"Rare",
			"Epic",
			"Legendary"
		}) do
			local v54 = v_u_17:FindFirstChild(v53 .. "RarityFrame")
			if v54 then
				local v55 = v54:FindFirstChild("RarityChanceOfArtifactToDrop")
				if v55 then
					local v56 = v52[v53] or 0
					v55.Text = string.format("%.1f%%", v56)
				end
				for _, v57 in ipairs(v54:GetDescendants()) do
					if v57:IsA("UIGradient") then
						v57.Enabled = v57.Name == v53
					end
				end
			end
		end
	end
end
local function v_u_68()
	-- upvalues: (ref) v_u_41, (copy) v_u_26, (copy) v_u_27, (copy) v_u_51, (copy) v_u_29, (ref) v_u_30, (ref) v_u_31, (copy) v_u_36, (copy) v_u_3
	if v_u_41 then
		local v59 = v_u_41.Level or 0
		local v60 = v_u_41.CurrentXP or 0
		local v61 = v_u_41.XPNeeded or 1
		local _ = v_u_41.TotalXP or 0
		local v62 = v_u_41.MaxLevel or 25
		local v63 = v_u_41.UniqueArtifactsCollected or 0
		v_u_26.Text = "Level <font face=\"SourceSansBold\">" .. v59 .. "</font>"
		v_u_27.Text = "Artifact Collection Progress: <font face=\"SourceSansBold\">" .. v63 .. "/" .. v_u_51 .. "</font>"
		if v62 <= v59 then
			v_u_29.Text = "MAX LEVEL"
			if v_u_30 then
				v_u_30.Text = tostring(v59)
			end
			if v_u_31 then
				v_u_31.Text = "MAX"
			end
			v_u_36.Size = UDim2.new(1, 0, 1, 0)
		else
			v_u_29.Text = v60 .. "/" .. v61
			if v_u_30 then
				v_u_30.Text = tostring(v59)
			end
			if v_u_31 then
				local v64 = v_u_31
				local v65 = v59 + 1
				v64.Text = tostring(v65)
			end
			local v66 = v61 > 0 and v60 / v61 or 0
			local v67 = math.clamp(v66, 0, 1)
			v_u_3:Create(v_u_36, TweenInfo.new(0.3), {
				["Size"] = UDim2.new(v67, 0, 1, 0)
			}):Play()
		end
	else
		return
	end
end
local function v_u_75()
	-- upvalues: (copy) v_u_37, (ref) v_u_49, (copy) v_u_38, (copy) v_u_5
	for _, v69 in ipairs(v_u_37:GetChildren()) do
		if v69:IsA("Frame") and (v69.Name ~= "DuplicateThisFrameForEachLevel" and v69.Name ~= "PaddingEnd") then
			v69:Destroy()
		end
	end
	v_u_49 = {}
	if v_u_38 then
		for v70 = 1, v_u_5.MaxLevel do
			local v71 = v_u_38:Clone()
			v71.Name = "Level_" .. v70
			v71.Visible = true
			v71.LayoutOrder = v70
			v71.Parent = v_u_37
			local v72 = v71:FindFirstChild("MilestonePart")
			if v72 then
				local v73 = v72:FindFirstChild("Step")
				local v74 = v73 and v73:FindFirstChild("LevelNumberOfThisMilestone")
				if v74 then
					v74.Text = tostring(v70)
				end
			end
			v_u_49[v70] = v71
		end
		v_u_38.Visible = false
	end
end
local function v_u_95(p76)
	-- upvalues: (ref) v_u_49, (ref) v_u_41
	if v_u_49[p76] then
		if v_u_41 then
			local v77 = v_u_49[p76]
			local v78 = v77:FindFirstChild("MilestonePart")
			if v78 then
				local v79 = v_u_41.Level or 0
				local v80 = v_u_41.ClaimedLevels or {}
				local v81 = p76 <= v79
				local v82 = v80[p76] == true
				local v83 = v78:FindFirstChild("BackgroundVisibleOnForUnreachedLevels")
				local v84 = v78:FindFirstChild("BackgroundVisibleOnForWhenYouReachedThisLevel")
				local v85 = v78:FindFirstChild("FrameGlowVisibleOnForUnreachedLevels")
				local v86 = v78:FindFirstChild("FrameGlowVisibleOnWhenYouReachedThisLevel")
				local v87 = v77:FindFirstChild("SegmentOnLoaderVisibleOnForUnreachedLevels")
				local v88 = v77:FindFirstChild("SegmentOnLoaderVisibleOnForWhenYouReachedThisLevel")
				local v89 = v77:FindFirstChild("CheckedFrameVisibleOnForUnreachedLevels")
				local v90 = v77:FindFirstChild("CheckedFrameVisibleOnForWhenYouReachedThisLevel")
				local v91 = v77:FindFirstChild("HitboxVisibleOnForUnreachedLevels")
				local v92 = v77:FindFirstChild("HitboxVisibleOnForWhenYouReachedThisLevel")
				if v83 then
					v83.Visible = not v81
				end
				if v84 then
					v84.Visible = v81
				end
				if v85 then
					v85.Visible = not v81
				end
				if v86 then
					v86.Visible = v81
				end
				if v87 then
					v87.Visible = not v81
				end
				if v88 then
					v88.Visible = v81
				end
				if v89 then
					v89.Visible = not v81
				end
				if v90 then
					v90.Visible = v81
				end
				if v91 then
					v91.Visible = not v81
				end
				if v92 then
					v92.Visible = v81
				end
				local v93 = v90 and v90:FindFirstChild("Icon")
				if v93 then
					v93.Visible = v82
				end
				local v94 = v89 and v89:FindFirstChild("IconVisibleOnForWhenYouReachedThisLevel")
				if v94 then
					v94.Visible = v82
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_101(p_u_96)
	-- upvalues: (ref) v_u_49, (ref) v_u_50, (ref) v_u_48
	if v_u_49[p_u_96] then
		local v97 = v_u_49[p_u_96]
		for _, v98 in ipairs(v97:GetDescendants()) do
			if v98:IsA("ImageButton") or v98:IsA("TextButton") then
				v98.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_50, (ref) v_u_48, (copy) p_u_96
					local v99 = tick()
					local v100
					if v99 - v_u_50 < 0.25 then
						v100 = false
					else
						v_u_50 = v99
						v100 = true
					end
					if v100 then
						v_u_48 = p_u_96
						updateRewardsDisplay()
					end
				end)
			end
		end
	end
end
function updateRewardsDisplay()
	-- upvalues: (ref) v_u_41, (copy) v_u_19, (ref) v_u_48, (copy) v_u_21, (copy) v_u_22, (copy) v_u_23, (copy) v_u_39, (copy) v_u_6, (copy) v_u_7
	if v_u_41 then
		for _, v102 in ipairs(v_u_19:GetChildren()) do
			if v102:IsA("Frame") and v102.Name ~= "ItemFrameDuplicateDependingOnHowManyItemsThisMilestoneLevelAwards" then
				v102:Destroy()
			end
		end
		local v103 = v_u_41.AllRewards and v_u_41.AllRewards[v_u_48] or {}
		local v104 = v_u_41.ClaimedLevels or {}
		local v105 = v_u_41.Level or 0
		local v106 = v104[v_u_48] == true
		local v107
		if v_u_48 <= v105 then
			v107 = not v106
		else
			v107 = false
		end
		v_u_21.Visible = v106
		v_u_22.Visible = not v106
		if v106 or v107 then
			v_u_23.ImageTransparency = 0
		else
			v_u_23.ImageTransparency = 0.5
		end
		if v_u_39 then
			for v108, v109 in ipairs(v103) do
				local v110 = v_u_39:Clone()
				v110.Name = "Reward_" .. v108
				v110.Visible = true
				v110.LayoutOrder = v108
				v110.Parent = v_u_19
				local v111 = v110:FindFirstChild("SlotsHolder")
				if v111 then
					for _, v112 in ipairs(v111:GetChildren()) do
						if v112:IsA("ImageLabel") then
							v112.Visible = false
						end
					end
					local v113 = "Common"
					local v114 = ""
					local v115 = ""
					local v116 = ""
					if v109.Type == "Artifact" then
						v113 = v109.Rarity or "Common"
						v114 = v109.Set .. " " .. v109.Category
						v115 = ""
						local v117 = v109.Set .. " " .. v109.Category
						if v_u_6.Images and v_u_6.Images[v117] then
							v116 = v_u_6.Images[v117]
						else
							v116 = "rbxasset://textures/ui/GuiImagePlaceholder.png"
						end
					elseif v109.Type == "Currency" then
						if v109.Currency == "ArtifactDust" then
							local v118 = v109.Amount
							v115 = "x" .. tostring(v118)
							v116 = v_u_6.Images and v_u_6.Images["Artifact Dust"] or "rbxassetid://0"
							v113 = "Rare"
							v114 = "Artifact Dust"
						else
							v113 = v_u_7.Items and (v_u_7.Items[v109.Currency] or "Common") or "Common"
							v114 = v109.Currency
							local v119 = v109.Amount
							v115 = "x" .. tostring(v119)
							v116 = v_u_6.Images and v_u_6.Images[v109.Currency] or "rbxassetid://0"
						end
					elseif v109.Type == "Item" then
						v113 = v109.Rarity or (v_u_7.Items and (v_u_7.Items[v109.ItemName] or "Common") or "Common")
						v114 = v109.ItemName or "Item"
						local v120 = v109.Quantity or 1
						v115 = "x" .. tostring(v120)
						v116 = v_u_6.Images and v_u_6.Images[v109.ItemName] or "rbxassetid://0"
					end
					local v121 = v111:FindFirstChild("Slot" .. v113 .. "RarityItem") or v111:FindFirstChild("SlotCommonRarityItem")
					if v121 then
						v121.Visible = true
						local v122 = v121:FindFirstChild("Slot")
						if v122 then
							v122 = v122:FindFirstChild("Holder")
						end
						if v122 then
							local v123 = v122:FindFirstChild("ItemName")
							if v123 then
								v123.Text = v114
							end
							local v124 = v122:FindFirstChild("Quantity")
							if v124 then
								v124.Text = v115
								v124.Visible = v115 ~= ""
							end
							local v125 = v122:FindFirstChild("Placeholder")
							if v125 then
								v125.Image = v116
							end
						end
					end
					local v126 = v110:FindFirstChild("ClaimedLabelVisibleOnIfYouClaimedThisMilestoneLevel")
					if v126 then
						v126.Visible = v106
					end
				end
			end
			if v_u_39 then
				v_u_39.Visible = false
			end
		end
	else
		return
	end
end
local function v133()
	-- upvalues: (copy) v_u_40, (ref) v_u_50, (ref) v_u_43, (copy) v_u_14, (copy) v_u_47, (copy) v_u_23, (ref) v_u_41, (ref) v_u_48, (copy) v_u_13, (copy) v_u_75, (copy) v_u_5, (copy) v_u_101
	v_u_40.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_50, (ref) v_u_43, (ref) v_u_14, (ref) v_u_47
		local v127 = tick()
		local v128
		if v127 - v_u_50 < 0.25 then
			v128 = false
		else
			v_u_50 = v127
			v128 = true
		end
		if v128 then
			if not v_u_43 then
				v_u_43 = true
				v_u_14.Enabled = false
				v_u_47()
				task.delay(0.3, function()
					-- upvalues: (ref) v_u_43
					v_u_43 = false
				end)
			end
		else
			return
		end
	end)
	v_u_23.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_50, (ref) v_u_41, (ref) v_u_48, (ref) v_u_13
		local v129 = tick()
		local v130
		if v129 - v_u_50 < 0.25 then
			v130 = false
		else
			v_u_50 = v129
			v130 = true
		end
		if v130 then
			if v_u_41 then
				local v131 = v_u_41.Level or 0
				if (v_u_41.ClaimedLevels or {})[v_u_48] then
					return
				elseif v131 >= v_u_48 then
					v_u_13:FireServer(v_u_48)
				end
			else
				return
			end
		else
			return
		end
	end)
	v_u_75()
	for v132 = 1, v_u_5.MaxLevel do
		v_u_101(v132)
	end
	v_u_14.Enabled = false
end
v10.OnClientEvent:Connect(function()
	-- upvalues: (ref) v_u_43, (copy) v_u_45, (copy) v_u_14
	if not v_u_43 then
		v_u_43 = true
		v_u_45()
		v_u_14.Enabled = true
		task.delay(0.3, function()
			-- upvalues: (ref) v_u_43
			v_u_43 = false
		end)
	end
end)
v11.OnClientEvent:Connect(function()
	-- upvalues: (ref) v_u_43, (copy) v_u_14, (copy) v_u_47
	if not v_u_43 then
		v_u_43 = true
		v_u_14.Enabled = false
		v_u_47()
		task.delay(0.3, function()
			-- upvalues: (ref) v_u_43
			v_u_43 = false
		end)
	end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_14, (copy) v_u_47, (ref) v_u_42, (ref) v_u_43
	if v_u_14.Enabled then
		v_u_14.Enabled = false
		v_u_47()
	elseif next(v_u_42) then
		v_u_47()
	end
	v_u_43 = false
end)
v12.OnClientEvent:Connect(function(p134)
	-- upvalues: (ref) v_u_41, (ref) v_u_48, (copy) v_u_5, (copy) v_u_58, (copy) v_u_68, (copy) v_u_95
	v_u_41 = p134
	local v135 = (p134.Level or 0) + 1
	local v136 = v_u_5.MaxLevel
	v_u_48 = math.clamp(v135, 1, v136)
	v_u_58()
	v_u_68()
	for v137 = 1, v_u_5.MaxLevel do
		v_u_95(v137)
	end
	updateRewardsDisplay()
end)
v133()