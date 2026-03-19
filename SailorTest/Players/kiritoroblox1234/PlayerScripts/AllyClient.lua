local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_3 = v_u_1.LocalPlayer
local v4 = v_u_3:WaitForChild("PlayerGui")
local v5 = v2:WaitForChild("Modules")
local v_u_6 = require(v5:WaitForChild("UIManager"))
local v_u_7 = v4:WaitForChild("AllyUI"):WaitForChild("MainFrame")
local v8 = v_u_7:WaitForChild("Frame"):WaitForChild("Content")
local v9 = v8:WaitForChild("AllyFrame")
local v10 = v8:WaitForChild("UserList")
local v_u_11 = v9:WaitForChild("CreateAllyScreen")
local v12 = v_u_11:WaitForChild("Create")
local v_u_13 = v9:WaitForChild("Players")
local v_u_14 = v_u_13:WaitForChild("Host")
local v_u_15 = v_u_13:WaitForChild("Player")
local v_u_16 = v9:WaitForChild("LeaveAlly")
local v_u_17 = v10:WaitForChild("Users")
local v_u_18 = v_u_17:WaitForChild("UserFrame")
local v_u_19 = v4:WaitForChild("AllyRequestUI"):WaitForChild("AllyRequest")
local v20 = v_u_19:WaitForChild("ButtonsHolder"):WaitForChild("Yes")
local v21 = v_u_19:WaitForChild("ButtonsHolder"):WaitForChild("No")
local v_u_22 = v_u_19:WaitForChild("InfoHolder"):WaitForChild("Txt")
local v23 = v4:WaitForChild("BasicStatsCurrencyAndButtonsUI"):WaitForChild("MainFrame"):WaitForChild("UIButtons"):WaitForChild("AllyButtonFrame"):WaitForChild("AllyButton")
local v24 = v_u_7:WaitForChild("Frame"):WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v25 = v2:WaitForChild("RemoteEvents")
local v_u_26 = v25:WaitForChild("AllyRemote")
local v_u_27 = v25:WaitForChild("AllyRequestRemote")
local v28 = v25:WaitForChild("AllyStateRemote")
local v_u_29 = false
local v_u_30 = false
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = 0
local v_u_36 = false
local v_u_37 = {}
local function v_u_39()
	-- upvalues: (copy) v_u_17
	for _, v38 in ipairs(v_u_17:GetChildren()) do
		if v38:IsA("Frame") and (v38.Name ~= "EndPadding" and v38.Name ~= "UserFrame") then
			v38:Destroy()
		end
	end
end
local function v_u_41()
	-- upvalues: (copy) v_u_13
	for _, v40 in ipairs(v_u_13:GetChildren()) do
		if v40:IsA("ImageButton") and v40.Name ~= "Player" then
			v40:Destroy()
		end
	end
end
local function v_u_43()
	-- upvalues: (copy) v_u_6, (ref) v_u_35, (ref) v_u_36, (copy) v_u_26
	if v_u_6:IsOpen("Party") then
		local v42 = tick()
		if v42 - v_u_35 < 0.3 then
			if not v_u_36 then
				v_u_36 = true
				task.delay(0.3, function()
					-- upvalues: (ref) v_u_36, (ref) v_u_6, (ref) v_u_35, (ref) v_u_26
					v_u_36 = false
					if v_u_6:IsOpen("Party") then
						v_u_35 = tick()
						v_u_26:FireServer("GetPlayerList")
					end
				end)
			end
		else
			v_u_35 = v42
			v_u_26:FireServer("GetPlayerList")
		end
	else
		return
	end
end
local function v_u_65(p44)
	-- upvalues: (copy) v_u_39, (ref) v_u_31, (copy) v_u_3, (copy) v_u_18, (copy) v_u_1, (ref) v_u_29, (ref) v_u_30, (copy) v_u_37, (copy) v_u_26, (copy) v_u_17
	v_u_39()
	local v45 = p44.list or p44
	local v46 = p44.myPartyHostId or v_u_31
	if v45 and type(v45) == "table" then
		local v47 = {}
		for _, v_u_48 in ipairs(v45) do
			if v_u_48.UserId ~= v_u_3.UserId and (not v47[v_u_48.UserId] and (not v46 or (not v_u_48.PartyHostId or v_u_48.PartyHostId ~= v46))) then
				v47[v_u_48.UserId] = true
				local v_u_49 = v_u_18:Clone()
				v_u_49.Name = "User_" .. v_u_48.UserId
				v_u_49.Visible = true
				local v50 = v_u_49:FindFirstChild("Holder")
				if v50 then
					local v51 = v50:FindFirstChild("Username")
					local v52 = v50:FindFirstChild("Display")
					if v51 then
						v51.Text = v_u_48.Name
					end
					if v52 then
						v52.Text = v_u_48.DisplayName
					end
				end
				local v53 = v_u_49:FindFirstChild("PlayerAvatar")
				local v_u_54 = v53 and v53:FindFirstChild("PlayerAvatar")
				if v_u_54 then
					task.spawn(function()
						-- upvalues: (ref) v_u_1, (copy) v_u_48, (copy) v_u_49, (copy) v_u_54
						local v55, v56 = pcall(function()
							-- upvalues: (ref) v_u_1, (ref) v_u_48
							return v_u_1:GetUserThumbnailAsync(v_u_48.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
						end)
						if v55 and v_u_49.Parent then
							v_u_54.Image = v56
						end
					end)
				end
				local v57 = v_u_49:FindFirstChild("ButtonHolder")
				local v58 = v57 and v57:FindFirstChild("Request")
				if v58 then
					local v59 = v_u_29 and v_u_30
					if v59 then
						v59 = not v_u_48.InParty
					end
					v58.ImageTransparency = v59 and 0 or 0.5
					local v_u_60 = v_u_48.UserId
					local v_u_61 = v_u_48.InParty
					v58.Activated:Connect(function()
						-- upvalues: (copy) v_u_60, (ref) v_u_37, (ref) v_u_29, (ref) v_u_30, (copy) v_u_61, (ref) v_u_26
						local v62 = "SendRequest_" .. v_u_60
						local v63 = v_u_37[v62]
						local v64
						if v63 then
							v64 = tick() - v63 < (v_u_37[v62 .. "_time"] or 0.5)
						else
							v64 = false
						end
						if v64 then
							return
						elseif v_u_29 then
							if v_u_30 then
								if not v_u_61 then
									v_u_37[v62] = tick()
									v_u_37[v62 .. "_time"] = 0.35
									v_u_26:FireServer("SendRequest", v_u_60)
								end
							else
								return
							end
						else
							return
						end
					end)
				end
				v_u_49.Parent = v_u_17
			end
		end
	end
end
local function v_u_77(p66)
	-- upvalues: (copy) v_u_41, (ref) v_u_32, (ref) v_u_30, (ref) v_u_31, (copy) v_u_14, (copy) v_u_15, (copy) v_u_37, (copy) v_u_26, (copy) v_u_13
	v_u_41()
	if not p66 then
		return
	end
	v_u_32 = p66
	v_u_30 = p66.isHost
	v_u_31 = p66.host
	local v67 = v_u_14:FindFirstChild("Display")
	for _, v68 in ipairs(p66.members) do
		if v68.IsHost then
			if v67 then
				v67.Text = v68.DisplayName
			end
			break
		end
	end
	local v69 = {}
	for _, v70 in ipairs(p66.members) do
		if not (v70.IsHost or v69[v70.UserId]) then
			v69[v70.UserId] = true
			local v71 = v_u_15:Clone()
			v71.Name = "Member_" .. v70.UserId
			v71.Visible = true
			local v72 = v71:FindFirstChild("Display")
			if v72 then
				v72.Text = v70.DisplayName
			end
			if v_u_30 then
				local v_u_73 = v70.UserId
				v71.Activated:Connect(function()
					-- upvalues: (copy) v_u_73, (ref) v_u_37, (ref) v_u_26
					local v74 = "Kick_" .. v_u_73
					local v75 = v_u_37[v74]
					local v76
					if v75 then
						v76 = tick() - v75 < (v_u_37[v74 .. "_time"] or 0.5)
					else
						v76 = false
					end
					if not v76 then
						v_u_37[v74] = tick()
						v_u_37[v74 .. "_time"] = 0.35
						v_u_26:FireServer("KickMember", v_u_73)
					end
				end)
			end
			v71.Parent = v_u_13
		end
	end
end
local function v_u_79(p78)
	-- upvalues: (ref) v_u_33, (copy) v_u_22, (copy) v_u_19, (ref) v_u_34, (copy) v_u_27
	if not v_u_33 then
		v_u_33 = p78
		v_u_22.Text = p78.FromDisplayName .. " wants to ally with you!"
		v_u_19.Visible = true
		if v_u_34 then
			task.cancel(v_u_34)
		end
		v_u_34 = task.delay(10, function()
			-- upvalues: (ref) v_u_33, (ref) v_u_27, (ref) v_u_19, (ref) v_u_34
			if v_u_33 then
				v_u_27:FireServer("RespondAlly", false)
				v_u_19.Visible = false
				v_u_33 = nil
				v_u_34 = nil
			end
		end)
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	task.wait(0.1)
	v_u_6:Register("Party", v_u_7)
end)
local function v80()
	-- upvalues: (copy) v_u_6, (ref) v_u_35, (copy) v_u_26, (ref) v_u_29
	if not v_u_6:IsOnCooldown() then
		v_u_6:Toggle("Party")
		if v_u_6:IsOpen("Party") then
			v_u_35 = tick()
			v_u_26:FireServer("GetPlayerList")
			if v_u_29 then
				v_u_26:FireServer("GetPartyInfo")
			end
		end
	end
end
v23.Activated:Connect(v80)
v24.Activated:Connect(function()
	-- upvalues: (copy) v_u_6
	v_u_6:Close("Party")
end)
v12.Activated:Connect(function()
	-- upvalues: (copy) v_u_37, (copy) v_u_26
	local v81 = v_u_37.CreateParty
	local v82
	if v81 then
		v82 = tick() - v81 < (v_u_37.CreateParty_time or 0.5)
	else
		v82 = false
	end
	if not v82 then
		v_u_37.CreateParty = tick()
		v_u_37.CreateParty_time = 0.5
		v_u_26:FireServer("CreateParty")
	end
end)
v_u_16.Activated:Connect(function()
	-- upvalues: (copy) v_u_37, (copy) v_u_26
	local v83 = v_u_37.LeaveParty
	local v84
	if v83 then
		v84 = tick() - v83 < (v_u_37.LeaveParty_time or 0.5)
	else
		v84 = false
	end
	if not v84 then
		v_u_37.LeaveParty = tick()
		v_u_37.LeaveParty_time = 0.5
		v_u_26:FireServer("LeaveParty")
	end
end)
v20.Activated:Connect(function()
	-- upvalues: (copy) v_u_37, (ref) v_u_33, (copy) v_u_27, (copy) v_u_19, (ref) v_u_34
	local v85 = v_u_37.RespondRequest
	local v86
	if v85 then
		v86 = tick() - v85 < (v_u_37.RespondRequest_time or 0.5)
	else
		v86 = false
	end
	if not v86 then
		if v_u_33 then
			v_u_37.RespondRequest = tick()
			v_u_37.RespondRequest_time = 0.5
			v_u_27:FireServer("RespondAlly", true)
			v_u_19.Visible = false
			v_u_33 = nil
			if v_u_34 then
				task.cancel(v_u_34)
				v_u_34 = nil
			end
		end
	end
end)
v21.Activated:Connect(function()
	-- upvalues: (copy) v_u_37, (ref) v_u_33, (copy) v_u_27, (copy) v_u_19, (ref) v_u_34
	local v87 = v_u_37.RespondRequest
	local v88
	if v87 then
		v88 = tick() - v87 < (v_u_37.RespondRequest_time or 0.5)
	else
		v88 = false
	end
	if not v88 then
		if v_u_33 then
			v_u_37.RespondRequest = tick()
			v_u_37.RespondRequest_time = 0.5
			v_u_27:FireServer("RespondAlly", false)
			v_u_19.Visible = false
			v_u_33 = nil
			if v_u_34 then
				task.cancel(v_u_34)
				v_u_34 = nil
			end
		end
	end
end)
v28.OnClientEvent:Connect(function(p89, p90)
	-- upvalues: (copy) v_u_65, (ref) v_u_29, (ref) v_u_30, (ref) v_u_31, (copy) v_u_3, (copy) v_u_11, (copy) v_u_13, (copy) v_u_16, (copy) v_u_77, (copy) v_u_43, (ref) v_u_32, (copy) v_u_41
	if p89 == "PlayerList" then
		v_u_65(p90)
		return
	elseif p89 == "PartyCreated" then
		v_u_29 = true
		v_u_30 = true
		v_u_31 = v_u_3.UserId
		v_u_11.Visible = not v_u_29
		v_u_13.Visible = v_u_29
		v_u_16.Visible = v_u_29
		v_u_77(p90)
		v_u_43()
		return
	elseif p89 == "PartyUpdate" then
		if p90 then
			v_u_29 = true
			v_u_31 = p90.host
			v_u_77(p90)
			v_u_43()
		else
			v_u_29 = false
			v_u_30 = false
			v_u_31 = nil
			v_u_32 = nil
		end
		v_u_11.Visible = not v_u_29
		v_u_13.Visible = v_u_29
		v_u_16.Visible = v_u_29
		return
	elseif p89 == "JoinedParty" then
		v_u_29 = true
		local v91
		if p90 then
			v91 = p90.host or nil
		else
			v91 = nil
		end
		v_u_31 = v91
		v_u_11.Visible = not v_u_29
		v_u_13.Visible = v_u_29
		v_u_16.Visible = v_u_29
		v_u_77(p90)
		v_u_43()
		return
	elseif p89 == "LeftParty" or p89 == "Kicked" then
		v_u_29 = false
		v_u_30 = false
		v_u_31 = nil
		v_u_32 = nil
		v_u_11.Visible = not v_u_29
		v_u_13.Visible = v_u_29
		v_u_16.Visible = v_u_29
		v_u_41()
		v_u_43()
		return
	elseif p89 == "PartyDisbanded" then
		v_u_29 = false
		v_u_30 = false
		v_u_31 = nil
		v_u_32 = nil
		v_u_11.Visible = not v_u_29
		v_u_13.Visible = v_u_29
		v_u_16.Visible = v_u_29
		v_u_41()
		v_u_43()
	elseif p89 == "Error" then
		warn("[AllyClient] Error:", p90)
	end
end)
v_u_27.OnClientEvent:Connect(function(p92, p93)
	-- upvalues: (copy) v_u_79
	if p92 == "AllyRequest" then
		v_u_79(p93)
	end
end)
v_u_11.Visible = not v_u_29
v_u_13.Visible = v_u_29
v_u_16.Visible = v_u_29
v_u_19.Visible = false
v_u_33 = nil
if v_u_34 then
	task.cancel(v_u_34)
	v_u_34 = nil
end
v_u_7.Visible = false