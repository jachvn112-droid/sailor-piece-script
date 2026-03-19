local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2:WaitForChild("Modules"):WaitForChild("SoundManager"))
local v_u_4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v5 = v2:WaitForChild("RemoteEvents")
local v_u_6 = 0
v5:WaitForChild("LevelUp").OnClientEvent:Connect(function(_, _)
	-- upvalues: (ref) v_u_6, (copy) v_u_3
	v_u_6 = tick()
	v_u_3:Play("LevelUp")
end)
v5:WaitForChild("QuestComplete").OnClientEvent:Connect(function(_)
	-- upvalues: (copy) v_u_3
	v_u_3:Play("QuestComplete")
end)
v5:WaitForChild("NPCReward").OnClientEvent:Connect(function(_)
	-- upvalues: (ref) v_u_6, (copy) v_u_3
	if tick() - v_u_6 > 0.5 then
		v_u_3:Play("NPCKill")
	end
end)
local function v_u_15()
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v7 = v_u_4:WaitForChild("BasicStatsCurrencyAndButtonsUI"):WaitForChild("MainFrame"):WaitForChild("UIButtons")
	local v8 = {
		{ "StatsButtonFrame", "StatsButton" },
		{ "InventoryButtonFrame", "InventoryButton" },
		{ "TradeButtonFrame", "Button" },
		{ "AllyButtonFrame", "AllyButton" },
		{ "Button5", "Button" },
		{ "SettingsButtonFrame", "Button" }
	}
	local v9 = v_u_4:FindFirstChild("QuestTrackingUI")
	if v9 then
		local v_u_10 = v9:FindFirstChild("Quest")
		if v_u_10 then
			v_u_10 = v_u_10:FindFirstChild("QuestArrowButton")
		end
		if v_u_10 then
			v_u_3:AttachHover(v_u_10)
			v_u_10.MouseButton1Click:Connect(function()
				-- upvalues: (copy) v_u_10, (ref) v_u_3
				task.wait(0.05)
				local v11 = v_u_10:FindFirstChild("On")
				if v11 and v11.Visible then
					v_u_3:Play("GUIClose")
				else
					v_u_3:Play("BigGUIOpen")
				end
			end)
		end
	end
	for _, v12 in ipairs(v8) do
		local v13 = v7:FindFirstChild(v12[1])
		if v13 then
			local v14 = v13:FindFirstChild(v12[2])
			if v14 and v14:IsA("GuiButton") then
				v_u_3:AttachHover(v14)
			end
		end
	end
end
local function v_u_25()
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v16 = v_u_4:WaitForChild("StatsPanelUI"):WaitForChild("MainFrame"):WaitForChild("Frame")
	local v17 = v16:WaitForChild("Content")
	local v18 = v16:FindFirstChild("CloseButtonFrame")
	if v18 then
		v18 = v18:FindFirstChild("CloseButton")
	end
	if v18 then
		v_u_3:AttachHover(v18)
		v18.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("GUIClose")
		end)
	end
	local v19 = v17:FindFirstChild("Page2")
	if v19 then
		v19 = v19:FindFirstChild("BackButton")
	end
	if v19 then
		v_u_3:AttachHover(v19)
		v19.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("GUIClose")
		end)
	end
	local v20 = v17:FindFirstChild("SideFrame")
	if v20 then
		v20 = v20:FindFirstChild("Holder")
	end
	if v20 then
		v20 = v20:FindFirstChild("Info")
	end
	if v20 then
		v_u_3:AttachHover(v20)
		v20.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("BigGUIOpen")
		end)
	end
	local v21 = v17:FindFirstChild("InfoFrame")
	if v21 then
		v21 = v21:FindFirstChild("GroupRestats")
	end
	if v21 then
		v21 = v21:FindFirstChild("Holder")
	end
	if v21 then
		v21 = v21:FindFirstChild("ResetStatsButton")
	end
	if v21 then
		v_u_3:AttachHover(v21)
	end
	local v22 = v17:FindFirstChild("StatsFrame")
	if v22 then
		v22 = v22:FindFirstChild("Holder")
	end
	if v22 then
		for _, v23 in ipairs({
			"MeleeStatFrame",
			"DefenseStatFrame",
			"SwordStatFrame",
			"PowerStatFrame"
		}) do
			local v24 = v22:FindFirstChild(v23)
			if v24 then
				v24 = v24:FindFirstChild("Content")
			end
			if v24 then
				v24 = v24:FindFirstChild("UpgradeFrame")
			end
			if v24 then
				v24 = v24:FindFirstChild("AddPoints")
			end
			if v24 then
				v_u_3:AttachHover(v24)
				v24.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_3
					v_u_3:Play("BigGUIOpen")
				end)
			end
		end
	end
end
local function v_u_33()
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v26 = v_u_4:WaitForChild("InventoryPanelUI"):WaitForChild("MainFrame"):WaitForChild("Frame")
	local v27 = v26:WaitForChild("Content"):WaitForChild("Holder"):WaitForChild("Tabs")
	local v28 = v26:FindFirstChild("Exit")
	if v28 then
		v28 = v28:FindFirstChild("CloseButton")
	end
	if v28 then
		v_u_3:AttachHover(v28)
		v28.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("GUIClose")
		end)
	end
	for _, v29 in ipairs({
		"ItemsTab",
		"MeleeTab",
		"SwordTab",
		"PowerTab",
		"AccessoryTab"
	}) do
		local v30 = v27:FindFirstChild(v29)
		if v30 then
			local v31 = v30:FindFirstChild("ButonOn")
			local v32 = v30:FindFirstChild("ButtonOff")
			if v31 then
				v_u_3:AttachHover(v31)
				v31.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_3
					v_u_3:Play("BigGUIOpen")
				end)
			end
			if v32 then
				v_u_3:AttachHover(v32)
				v32.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_3
					v_u_3:Play("BigGUIOpen")
				end)
			end
		end
	end
end
local function v_u_52()
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v34 = v_u_4:WaitForChild("TradingUI"):WaitForChild("MainFrame"):WaitForChild("Frame")
	local v35 = v34:WaitForChild("Content"):WaitForChild("Users")
	local function v37(p36)
		-- upvalues: (ref) v_u_3
		if p36:IsA("ImageButton") and p36.Name == "UserFrame" then
			v_u_3:AttachHover(p36)
			p36.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_3
				v_u_3:Play("BigGUIOpen")
			end)
		end
	end
	for _, v38 in ipairs(v35:GetChildren()) do
		v37(v38)
	end
	v35.ChildAdded:Connect(v37)
	local v39 = v34:FindFirstChild("CloseButtonFrame")
	if v39 then
		v39 = v39:FindFirstChild("CloseButton")
	end
	if v39 then
		v_u_3:AttachHover(v39)
		v39.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("GUIClose")
		end)
	end
	local v40 = v_u_4:WaitForChild("TradeRequestUI"):WaitForChild("TradeRequest"):WaitForChild("ButtonsHolder")
	local v41 = v40:FindFirstChild("Yes")
	local v42 = v40:FindFirstChild("No")
	if v41 then
		v_u_3:AttachHover(v41)
		v41.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("BigGUIOpen")
		end)
	end
	if v42 then
		v_u_3:AttachHover(v42)
		v42.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("GUIClose")
		end)
	end
	local v43 = v_u_4:WaitForChild("InTradingUI"):WaitForChild("MainFrame"):WaitForChild("Frame")
	local v44 = v43:WaitForChild("Content")
	local v45 = v43:FindFirstChild("CloseButtonFrame")
	if v45 then
		v45 = v45:FindFirstChild("CloseButton")
	end
	if v45 then
		v_u_3:AttachHover(v45)
		v45.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("GUIClose")
		end)
	end
	local v46 = v44:FindFirstChild("Player2Side")
	if v46 then
		v46 = v46:FindFirstChild("Player2Holder")
	end
	if v46 then
		v46 = v46:FindFirstChild("Buttons")
	end
	if v46 then
		local v47 = v46:FindFirstChild("Ready")
		local v48 = v46:FindFirstChild("Decline")
		if v47 then
			v_u_3:AttachHover(v47)
			v47.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_3
				v_u_3:Play("BigGUIOpen")
			end)
		end
		if v48 then
			v_u_3:AttachHover(v48)
			v48.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_3
				v_u_3:Play("GUIClose")
			end)
		end
	end
	local v49 = v_u_4:WaitForChild("ConfirmUI"):WaitForChild("MainFrame"):WaitForChild("ButtonsHolder")
	local v50 = v49:FindFirstChild("Yes")
	local v51 = v49:FindFirstChild("No")
	if v50 then
		v_u_3:AttachHover(v50)
		v50.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("BigGUIOpen")
		end)
	end
	if v51 then
		v_u_3:AttachHover(v51)
		v51.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("GUIClose")
		end)
	end
end
local function v_u_66()
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v53 = v_u_4:WaitForChild("AllyUI"):WaitForChild("MainFrame"):WaitForChild("Frame")
	local v54 = v53:WaitForChild("Content")
	local v55 = v53:FindFirstChild("CloseButtonFrame")
	if v55 then
		v55 = v55:FindFirstChild("CloseButton")
	end
	if v55 then
		v_u_3:AttachHover(v55)
		v55.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("GUIClose")
		end)
	end
	local v56 = v54:FindFirstChild("AllyFrame")
	if v56 then
		local v57 = v56:FindFirstChild("CreateAllyScreen")
		if v57 then
			v57 = v57:FindFirstChild("Create")
		end
		if v57 then
			v_u_3:AttachHover(v57)
			v57.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_3
				v_u_3:Play("BigGUIOpen")
			end)
		end
		local v58 = v56:FindFirstChild("LeaveAlly")
		if v58 then
			v_u_3:AttachHover(v58)
			v58.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_3
				v_u_3:Play("GUIClose")
			end)
		end
		local v59 = v56:FindFirstChild("Players")
		if v59 then
			local function v61(p60)
				-- upvalues: (ref) v_u_3
				if p60:IsA("ImageButton") and p60.Name == "Player" then
					v_u_3:AttachHover(p60)
					p60.MouseButton1Click:Connect(function()
						-- upvalues: (ref) v_u_3
						v_u_3:Play("BigGUIOpen")
					end)
				end
			end
			for _, v62 in ipairs(v59:GetChildren()) do
				v61(v62)
			end
			v59.ChildAdded:Connect(v61)
		end
	end
	local v63 = v_u_4:WaitForChild("AllyRequestUI"):WaitForChild("AllyRequest"):WaitForChild("ButtonsHolder")
	local v64 = v63:FindFirstChild("Yes")
	local v65 = v63:FindFirstChild("No")
	if v64 then
		v_u_3:AttachHover(v64)
		v64.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("BigGUIOpen")
		end)
	end
	if v65 then
		v_u_3:AttachHover(v65)
		v65.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_3
			v_u_3:Play("GUIClose")
		end)
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_15, (copy) v_u_25, (copy) v_u_33, (copy) v_u_52, (copy) v_u_66
	v_u_15()
	v_u_25()
	v_u_33()
	v_u_52()
	v_u_66()
end)