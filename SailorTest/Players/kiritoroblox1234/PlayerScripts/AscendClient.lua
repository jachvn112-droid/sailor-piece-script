local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer
local v4 = v3:WaitForChild("PlayerGui")
local v_u_5 = require(v2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v6 = v2:WaitForChild("RemoteEvents")
local v7 = v6:WaitForChild("OpenAscendUI")
local v_u_8 = v6:WaitForChild("GetAscendData")
local v_u_9 = v6:WaitForChild("RequestAscend")
local v10 = v6:WaitForChild("AscendDataUpdate")
local v_u_11 = v6:WaitForChild("CloseAscendUI")
local v12 = v4:WaitForChild("AscendUI"):WaitForChild("MainFrame")
local v13 = v12:WaitForChild("Frame"):WaitForChild("Content"):WaitForChild("Holder")
local v14 = v13:WaitForChild("RankInfoReqFrame")
local v15 = v14:WaitForChild("PlayerFrame")
local v16 = v15:WaitForChild("PlayerAvatarFrame"):WaitForChild("PlayerAvatar")
local v_u_17 = v15:WaitForChild("RankIcon")
local v18 = v14:WaitForChild("RankInfoFrame")
local v_u_19 = v18:WaitForChild("RankInfo"):WaitForChild("AutoSizeHolder"):WaitForChild("CurrentRankYouHave")
local v_u_20 = v18:WaitForChild("RequirementsFrame"):WaitForChild("RequirementsHolder")
local v_u_21 = v_u_20:WaitForChild("RequirementFrame")
local v_u_22 = v13:WaitForChild("RewardsFrame"):WaitForChild("RewardsHolderFrame"):WaitForChild("RewardsThatWouldBeGainedFromRankingUpHolder")
local v_u_23 = v_u_22:WaitForChild("StatBuffGainedFromRankingUpDuplicateTheFrameForEachStatFromThisSpecificRank")
local v24 = v13:WaitForChild("ActionButtonsFrame"):WaitForChild("HolderForButtons")
local v25 = v24:WaitForChild("CancelButtonThisJustClosesUIIfClicked")
local v26 = v24:WaitForChild("AscendButton")
local v_u_27 = v26:WaitForChild("MissingRequirementFrameVisibleTrueOnlyIfYouDontMeetTheRequirements")
local v_u_28 = 0
local v_u_29 = nil
local function v_u_35(p30)
	if p30 >= 1000000000 then
		local v31 = p30 / 1000000000
		return v31 == math.floor(v31) and string.format("%dB", v31) or string.format("%.1fB", v31)
	elseif p30 >= 1000000 then
		local v32 = p30 / 1000000
		return v32 == math.floor(v32) and string.format("%dM", v32) or string.format("%.1fM", v32)
	elseif p30 >= 1000 then
		local v33 = p30 / 1000
		return v33 == math.floor(v33) and string.format("%dK", v33) or string.format("%.1fK", v33)
	else
		local v34 = math.floor(p30)
		return tostring(v34)
	end
end
v12.Visible = false
v_u_21.Visible = false
v_u_23.Visible = false
local v36 = Enum.ThumbnailType.HeadShot
local v37 = Enum.ThumbnailSize.Size150x150
v16.Image = v1:GetUserThumbnailAsync(v3.UserId, v36, v37)
v_u_5:Register("AscendUI", v12, {
	["onClose"] = function()
		-- upvalues: (copy) v_u_11
		pcall(function()
			-- upvalues: (ref) v_u_11
			v_u_11:FireServer()
		end)
	end
})
local v_u_38 = {
	["MoneyPercent"] = "+%d%% Money",
	["GemsPercent"] = "+%d%% Gems",
	["LuckPercent"] = "+%d%% Luck",
	["CooldownReduction"] = "+%d%% CDR"
}
local v_u_39 = {
	"MoneyPercent",
	"GemsPercent",
	"LuckPercent",
	"CooldownReduction"
}
local function v_u_43(p40, p41)
	for _, v42 in ipairs(p40:GetChildren()) do
		if v42:IsA("GuiObject") and (v42.Name ~= p41 and (v42.Name ~= "UIGridLayout" and v42.Name ~= "Padding")) then
			v42:Destroy()
		end
	end
end
local function v_u_74(p44)
	-- upvalues: (ref) v_u_29, (copy) v_u_19, (copy) v_u_17, (copy) v_u_43, (copy) v_u_20, (copy) v_u_21, (copy) v_u_35, (copy) v_u_22, (copy) v_u_23, (copy) v_u_39, (copy) v_u_38, (copy) v_u_27
	if p44 then
		v_u_29 = p44
		if p44.isMaxed then
			v_u_19.Text = p44.rankName .. " (MAX)"
		else
			v_u_19.Text = p44.rankName
		end
		v_u_17.Image = p44.rankIcon or ""
		v_u_43(v_u_20, v_u_21.Name)
		if p44.isMaxed then
			local v45 = v_u_21:Clone()
			v45.Name = "MaxReached"
			v45.Visible = true
			local v46 = v45:FindFirstChild("CheckFrameChangeBackgroundColorTo101, 255, 93IfThisRequirementIsDone")
			if v46 then
				v46.BackgroundColor3 = Color3.fromRGB(101, 255, 93)
				local v47 = v46:FindFirstChild("CheckIconEnableIfYouHaveDoneThisRequirement")
				if v47 then
					v47.Visible = true
				end
			end
			local v48 = v45:FindFirstChild("RequirementLabelToShowWhatYouHaveToDo")
			if v48 then
				v48.Text = "Maximum Ascend Reached!"
			end
			v45.Parent = v_u_20
		else
			for v49, v50 in ipairs(p44.requirements) do
				local v51 = v_u_21:Clone()
				v51.Name = "Req_" .. v49
				v51.Visible = true
				v51.LayoutOrder = v49
				local v52 = v51:FindFirstChild("CheckFrameChangeBackgroundColorTo101, 255, 93IfThisRequirementIsDone")
				if v52 then
					if v50.completed then
						v52.BackgroundColor3 = Color3.fromRGB(101, 255, 93)
					else
						v52.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
					end
					local v53 = v52:FindFirstChild("CheckIconEnableIfYouHaveDoneThisRequirement")
					if v53 then
						v53.Visible = v50.completed
					end
				end
				local v54 = v51:FindFirstChild("RequirementLabelToShowWhatYouHaveToDo")
				if v54 then
					local v55 = v_u_35
					local v56 = v50.current
					local v57 = v50.needed
					local v58 = " (" .. v55((math.min(v56, v57))) .. "/" .. v_u_35(v50.needed) .. ")"
					v54.Text = v50.display .. v58
				end
				v51.Parent = v_u_20
			end
		end
		task.defer(function()
			-- upvalues: (ref) v_u_20
			local v59 = v_u_20:FindFirstChild("UIGridLayout")
			if v59 then
				v_u_20.CanvasSize = UDim2.new(0, 0, 0, v59.AbsoluteContentSize.Y + 10)
			end
		end)
		v_u_43(v_u_22, v_u_23.Name)
		if p44.isMaxed then
			local v60 = p44.totalRewards or {}
			for v61, v62 in ipairs(v_u_39) do
				local v63 = v60[v62]
				if v63 and v63 > 0 then
					local v64 = v_u_23:Clone()
					v64.Name = "Reward_" .. v62
					v64.Visible = true
					v64.LayoutOrder = v61
					local v65 = v64:FindFirstChild("NameOfTheStat")
					if v65 then
						v65.Text = string.format(v_u_38[v62] or v62, v63) .. " (Total)"
					end
					v64.Parent = v_u_22
				end
			end
		elseif p44.nextRewards then
			for v66, v67 in ipairs(v_u_39) do
				local v68 = p44.nextRewards[v67]
				if v68 and v68 > 0 then
					local v69 = v_u_23:Clone()
					v69.Name = "Reward_" .. v67
					v69.Visible = true
					v69.LayoutOrder = v66
					local v70 = v69:FindFirstChild("NameOfTheStat")
					if v70 then
						v70.Text = string.format(v_u_38[v67] or v67, v68)
					end
					v69.Parent = v_u_22
				end
			end
		end
		task.defer(function()
			-- upvalues: (ref) v_u_22
			local v71 = v_u_22:FindFirstChild("UIGridLayout")
			if v71 then
				v_u_22.CanvasSize = UDim2.new(0, 0, 0, v71.AbsoluteContentSize.Y + 10)
			end
		end)
		if p44.isMaxed then
			v_u_27.Visible = true
			local v72 = v_u_27:FindFirstChild("Txt", true)
			if v72 then
				v72.Text = "Max Ascend"
				return
			end
		else
			if p44.allMet then
				v_u_27.Visible = false
				return
			end
			v_u_27.Visible = true
			local v73 = v_u_27:FindFirstChild("Txt", true)
			if v73 then
				v73.Text = "Missing Requirements"
			end
		end
	end
end
local function v77()
	-- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_74
	if not v_u_5:IsOpen("AscendUI") then
		local v75, v76 = pcall(function()
			-- upvalues: (ref) v_u_8
			return v_u_8:InvokeServer()
		end)
		if v75 and v76 then
			v_u_74(v76)
		end
		v_u_5:Open("AscendUI")
	end
end
v25.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_28, (copy) v_u_5
	local v78 = os.clock()
	if v78 - v_u_28 < 0.25 then
		return
	else
		v_u_28 = v78
		if v_u_5:IsOpen("AscendUI") then
			v_u_5:Close("AscendUI")
		end
	end
end)
local v79 = v12:FindFirstChild("Frame") and v12.Frame:FindFirstChild("CloseButtonFrame")
if v79 then
	v79 = v12.Frame.CloseButtonFrame:FindFirstChild("CloseButton")
end
if v79 then
	v79.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_28, (copy) v_u_5
		local v80 = os.clock()
		if v80 - v_u_28 < 0.25 then
			return
		else
			v_u_28 = v80
			if v_u_5:IsOpen("AscendUI") then
				v_u_5:Close("AscendUI")
			end
		end
	end)
	local v81 = v79:FindFirstChild("LocalScript")
	if v81 then
		v81:Destroy()
	end
end
v26.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_28, (ref) v_u_29, (copy) v_u_9
	local v82 = os.clock()
	if v82 - v_u_28 < 0.25 then
		return
	else
		v_u_28 = v82
		if v_u_29 and v_u_29.isMaxed then
			return
		elseif not v_u_29 or v_u_29.allMet then
			v_u_9:FireServer()
		end
	end
end)
v7.OnClientEvent:Connect(v77)
v10.OnClientEvent:Connect(function(p83)
	-- upvalues: (copy) v_u_5, (copy) v_u_74
	if p83 and v_u_5:IsOpen("AscendUI") then
		v_u_74(p83)
	end
end)