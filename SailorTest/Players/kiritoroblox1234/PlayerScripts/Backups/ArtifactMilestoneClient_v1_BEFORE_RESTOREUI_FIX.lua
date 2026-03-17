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
			v_u_31 = v34 or v_u_31
			if v35 then
				v_u_30 = v35
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
local function v_u_49()
	-- upvalues: (copy) v_u_4, (ref) v_u_42
	for _, v48 in ipairs(v_u_4:GetChildren()) do
		if v48:IsA("ScreenGui") and v48.Name ~= "ArtifactMilestoneUI" then
			v48.Enabled = true
		end
	end
	v_u_42 = {}
end
local v_u_50 = 1
local v_u_51 = {}
local v_u_52 = 0
local v_u_53 = #{
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
local function v_u_60()
	-- upvalues: (ref) v_u_41, (copy) v_u_5, (copy) v_u_17
	if v_u_41 then
		local v54 = v_u_41.RarityChances or v_u_5:GetRarityChances(0)
		for _, v55 in ipairs({
			"Common",
			"Rare",
			"Epic",
			"Legendary"
		}) do
			local v56 = v_u_17:FindFirstChild(v55 .. "RarityFrame")
			if v56 then
				local v57 = v56:FindFirstChild("RarityChanceOfArtifactToDrop")
				if v57 then
					local v58 = v54[v55] or 0
					v57.Text = string.format("%.1f%%", v58)
				end
				for _, v59 in ipairs(v56:GetDescendants()) do
					if v59:IsA("UIGradient") then
						v59.Enabled = v59.Name == v55
					end
				end
			end
		end
	end
end
local function v_u_70()
	-- upvalues: (ref) v_u_41, (copy) v_u_26, (copy) v_u_27, (copy) v_u_53, (copy) v_u_29, (ref) v_u_31, (ref) v_u_30, (copy) v_u_36, (copy) v_u_3
	if v_u_41 then
		local v61 = v_u_41.Level or 0
		local v62 = v_u_41.CurrentXP or 0
		local v63 = v_u_41.XPNeeded or 1
		local _ = v_u_41.TotalXP or 0
		local v64 = v_u_41.MaxLevel or 25
		local v65 = v_u_41.UniqueArtifactsCollected or 0
		v_u_26.Text = "Level <font face=\"SourceSansBold\">" .. v61 .. "</font>"
		v_u_27.Text = "Artifact Collection Progress: <font face=\"SourceSansBold\">" .. v65 .. "/" .. v_u_53 .. "</font>"
		if v64 <= v61 then
			v_u_29.Text = "MAX LEVEL"
			if v_u_31 then
				v_u_31.Text = tostring(v61)
			end
			if v_u_30 then
				v_u_30.Text = "MAX"
			end
			v_u_36.Size = UDim2.new(1, 0, 1, 0)
		else
			v_u_29.Text = v62 .. "/" .. v63
			if v_u_31 then
				v_u_31.Text = tostring(v61)
			end
			if v_u_30 then
				local v66 = v_u_30
				local v67 = v61 + 1
				v66.Text = tostring(v67)
			end
			local v68 = v63 > 0 and v62 / v63 or 0
			local v69 = math.clamp(v68, 0, 1)
			v_u_3:Create(v_u_36, TweenInfo.new(0.3), {
				["Size"] = UDim2.new(v69, 0, 1, 0)
			}):Play()
		end
	else
		return
	end
end
local function v_u_77()
	-- upvalues: (copy) v_u_37, (ref) v_u_51, (copy) v_u_38, (copy) v_u_5
	for _, v71 in ipairs(v_u_37:GetChildren()) do
		if v71:IsA("Frame") and (v71.Name ~= "DuplicateThisFrameForEachLevel" and v71.Name ~= "PaddingEnd") then
			v71:Destroy()
		end
	end
	v_u_51 = {}
	if v_u_38 then
		for v72 = 1, v_u_5.MaxLevel do
			local v73 = v_u_38:Clone()
			v73.Name = "Level_" .. v72
			v73.Visible = true
			v73.LayoutOrder = v72
			v73.Parent = v_u_37
			local v74 = v73:FindFirstChild("MilestonePart")
			if v74 then
				local v75 = v74:FindFirstChild("Step")
				local v76 = v75 and v75:FindFirstChild("LevelNumberOfThisMilestone")
				if v76 then
					v76.Text = tostring(v72)
				end
			end
			v_u_51[v72] = v73
		end
		v_u_38.Visible = false
	end
end
local function v_u_97(p78)
	-- upvalues: (ref) v_u_51, (ref) v_u_41
	if v_u_51[p78] then
		if v_u_41 then
			local v79 = v_u_51[p78]
			local v80 = v79:FindFirstChild("MilestonePart")
			if v80 then
				local v81 = v_u_41.Level or 0
				local v82 = v_u_41.ClaimedLevels or {}
				local v83 = p78 <= v81
				local v84 = v82[p78] == true
				local v85 = v80:FindFirstChild("BackgroundVisibleOnForUnreachedLevels")
				local v86 = v80:FindFirstChild("BackgroundVisibleOnForWhenYouReachedThisLevel")
				local v87 = v80:FindFirstChild("FrameGlowVisibleOnForUnreachedLevels")
				local v88 = v80:FindFirstChild("FrameGlowVisibleOnWhenYouReachedThisLevel")
				local v89 = v79:FindFirstChild("SegmentOnLoaderVisibleOnForUnreachedLevels")
				local v90 = v79:FindFirstChild("SegmentOnLoaderVisibleOnForWhenYouReachedThisLevel")
				local v91 = v79:FindFirstChild("CheckedFrameVisibleOnForUnreachedLevels")
				local v92 = v79:FindFirstChild("CheckedFrameVisibleOnForWhenYouReachedThisLevel")
				local v93 = v79:FindFirstChild("HitboxVisibleOnForUnreachedLevels")
				local v94 = v79:FindFirstChild("HitboxVisibleOnForWhenYouReachedThisLevel")
				if v85 then
					v85.Visible = not v83
				end
				if v86 then
					v86.Visible = v83
				end
				if v87 then
					v87.Visible = not v83
				end
				if v88 then
					v88.Visible = v83
				end
				if v89 then
					v89.Visible = not v83
				end
				if v90 then
					v90.Visible = v83
				end
				if v91 then
					v91.Visible = not v83
				end
				if v92 then
					v92.Visible = v83
				end
				if v93 then
					v93.Visible = not v83
				end
				if v94 then
					v94.Visible = v83
				end
				local v95 = v92 and v92:FindFirstChild("Icon")
				if v95 then
					v95.Visible = v84
				end
				local v96 = v91 and v91:FindFirstChild("IconVisibleOnForWhenYouReachedThisLevel")
				if v96 then
					v96.Visible = v84
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_103(p_u_98)
	-- upvalues: (ref) v_u_51, (ref) v_u_52, (ref) v_u_50
	if v_u_51[p_u_98] then
		local v99 = v_u_51[p_u_98]
		for _, v100 in ipairs(v99:GetDescendants()) do
			if v100:IsA("ImageButton") or v100:IsA("TextButton") then
				v100.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_52, (ref) v_u_50, (copy) p_u_98
					local v101 = tick()
					local v102
					if v101 - v_u_52 < 0.25 then
						v102 = false
					else
						v_u_52 = v101
						v102 = true
					end
					if v102 then
						v_u_50 = p_u_98
						updateRewardsDisplay()
					end
				end)
			end
		end
	end
end
function updateRewardsDisplay()
	-- upvalues: (ref) v_u_41, (copy) v_u_19, (ref) v_u_50, (copy) v_u_21, (copy) v_u_22, (copy) v_u_23, (copy) v_u_39, (copy) v_u_6, (copy) v_u_7
	if v_u_41 then
		for _, v104 in ipairs(v_u_19:GetChildren()) do
			if v104:IsA("Frame") and v104.Name ~= "ItemFrameDuplicateDependingOnHowManyItemsThisMilestoneLevelAwards" then
				v104:Destroy()
			end
		end
		local v105 = v_u_41.AllRewards and v_u_41.AllRewards[v_u_50] or {}
		local v106 = v_u_41.ClaimedLevels or {}
		local v107 = v_u_41.Level or 0
		local v108 = v106[v_u_50] == true
		local v109
		if v_u_50 <= v107 then
			v109 = not v108
		else
			v109 = false
		end
		v_u_21.Visible = v108
		v_u_22.Visible = not v108
		if v108 or v109 then
			v_u_23.ImageTransparency = 0
		else
			v_u_23.ImageTransparency = 0.5
		end
		if v_u_39 then
			for v110, v111 in ipairs(v105) do
				local v112 = v_u_39:Clone()
				v112.Name = "Reward_" .. v110
				v112.Visible = true
				v112.LayoutOrder = v110
				v112.Parent = v_u_19
				local v113 = v112:FindFirstChild("SlotsHolder")
				if v113 then
					for _, v114 in ipairs(v113:GetChildren()) do
						if v114:IsA("ImageLabel") then
							v114.Visible = false
						end
					end
					local v115 = "Common"
					local v116 = ""
					local v117 = ""
					local v118 = ""
					if v111.Type == "Artifact" then
						v115 = v111.Rarity or "Common"
						v116 = v111.Set .. " " .. v111.Category
						v117 = ""
						local v119 = v111.Set .. " " .. v111.Category
						if v_u_6.Images and v_u_6.Images[v119] then
							v118 = v_u_6.Images[v119]
						else
							v118 = "rbxasset://textures/ui/GuiImagePlaceholder.png"
						end
					elseif v111.Type == "Currency" then
						if v111.Currency == "ArtifactDust" then
							local v120 = v111.Amount
							v117 = "x" .. tostring(v120)
							v118 = v_u_6.Images and v_u_6.Images["Artifact Dust"] or "rbxassetid://0"
							v115 = "Rare"
							v116 = "Artifact Dust"
						else
							v115 = v_u_7.Items and (v_u_7.Items[v111.Currency] or "Common") or "Common"
							v116 = v111.Currency
							local v121 = v111.Amount
							v117 = "x" .. tostring(v121)
							v118 = v_u_6.Images and v_u_6.Images[v111.Currency] or "rbxassetid://0"
						end
					elseif v111.Type == "Item" then
						v115 = v111.Rarity or (v_u_7.Items and (v_u_7.Items[v111.ItemName] or "Common") or "Common")
						v116 = v111.ItemName or "Item"
						local v122 = v111.Quantity or 1
						v117 = "x" .. tostring(v122)
						v118 = v_u_6.Images and v_u_6.Images[v111.ItemName] or "rbxassetid://0"
					end
					local v123 = v113:FindFirstChild("Slot" .. v115 .. "RarityItem") or v113:FindFirstChild("SlotCommonRarityItem")
					if v123 then
						v123.Visible = true
						local v124 = v123:FindFirstChild("Slot")
						if v124 then
							v124 = v124:FindFirstChild("Holder")
						end
						if v124 then
							local v125 = v124:FindFirstChild("ItemName")
							if v125 then
								v125.Text = v116
							end
							local v126 = v124:FindFirstChild("Quantity")
							if v126 then
								v126.Text = v117
								v126.Visible = v117 ~= ""
							end
							local v127 = v124:FindFirstChild("Placeholder")
							if v127 then
								v127.Image = v118
							end
						end
					end
					local v128 = v112:FindFirstChild("ClaimedLabelVisibleOnIfYouClaimedThisMilestoneLevel")
					if v128 then
						v128.Visible = v108
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
local function v135()
	-- upvalues: (copy) v_u_40, (ref) v_u_52, (ref) v_u_43, (copy) v_u_14, (copy) v_u_47, (copy) v_u_23, (ref) v_u_41, (ref) v_u_50, (copy) v_u_13, (copy) v_u_77, (copy) v_u_5, (copy) v_u_103
	v_u_40.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_52, (ref) v_u_43, (ref) v_u_14, (ref) v_u_47
		local v129 = tick()
		local v130
		if v129 - v_u_52 < 0.25 then
			v130 = false
		else
			v_u_52 = v129
			v130 = true
		end
		if v130 then
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
		-- upvalues: (ref) v_u_52, (ref) v_u_41, (ref) v_u_50, (ref) v_u_13
		local v131 = tick()
		local v132
		if v131 - v_u_52 < 0.25 then
			v132 = false
		else
			v_u_52 = v131
			v132 = true
		end
		if v132 then
			if v_u_41 then
				local v133 = v_u_41.Level or 0
				if (v_u_41.ClaimedLevels or {})[v_u_50] then
					return
				elseif v133 >= v_u_50 then
					v_u_13:FireServer(v_u_50)
				end
			else
				return
			end
		else
			return
		end
	end)
	v_u_77()
	for v134 = 1, v_u_5.MaxLevel do
		v_u_103(v134)
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
	-- upvalues: (copy) v_u_14, (copy) v_u_49, (ref) v_u_43
	if not v_u_14.Enabled then
		v_u_49()
	end
	v_u_43 = false
end)
v12.OnClientEvent:Connect(function(p136)
	-- upvalues: (ref) v_u_41, (ref) v_u_50, (copy) v_u_5, (copy) v_u_60, (copy) v_u_70, (copy) v_u_97
	v_u_41 = p136
	local v137 = (p136.Level or 0) + 1
	local v138 = v_u_5.MaxLevel
	v_u_50 = math.clamp(v137, 1, v138)
	v_u_60()
	v_u_70()
	for v139 = 1, v_u_5.MaxLevel do
		v_u_97(v139)
	end
	updateRewardsDisplay()
end)
v135()