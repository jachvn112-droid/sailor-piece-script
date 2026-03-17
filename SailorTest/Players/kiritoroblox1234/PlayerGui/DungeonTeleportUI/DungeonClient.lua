local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1.LocalPlayer:WaitForChild("PlayerGui")
require(v2:WaitForChild("Modules"):WaitForChild("DungeonConfig"))
local v_u_4 = require(v2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v5 = v2:WaitForChild("Remotes")
local v6 = v2:WaitForChild("RemoteEvents")
local v7 = v5:WaitForChild("OpenDungeonUI")
local v_u_8 = v5:WaitForChild("RequestDungeonPortal")
v5:WaitForChild("JoinDungeonPortal")
local v_u_9 = v5:WaitForChild("LeaveDungeonPortal")
local v10 = v6:WaitForChild("DungeonPortalUpdate")
local v11 = v6:WaitForChild("DungeonUIUpdate")
local v_u_12 = v_u_3:WaitForChild("DungeonTeleportUI"):WaitForChild("MainFrame")
local v13 = v_u_12:WaitForChild("Frame")
local v_u_14 = v13:WaitForChild("Content"):WaitForChild("Holder")
local v_u_15 = v13:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_16 = false
local v_u_17 = nil
local function v_u_33()
	-- upvalues: (copy) v_u_14, (copy) v_u_8, (copy) v_u_4
	local v18 = v_u_14:FindFirstChild("SpawnCidDungeonPortalFrame")
	if v18 then
		local v19 = v18:FindFirstChild("SpawnPortalButton")
		if v19 then
			v19.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_8, (ref) v_u_4
				v_u_8:FireServer("CidDungeon")
				v_u_4:Close("DungeonUI")
			end)
		end
		local v20 = v18:FindFirstChild("Holder")
		if v20 then
			local v21 = v20:FindFirstChild("TeleportPlace")
			local v22 = v20:FindFirstChild("Txt")
			if v21 then
				v21.Text = "Cid Dungeon"
			end
			if v22 then
				v22.Text = "Face Cid boss!"
			end
		end
	end
	local v23 = v_u_14:FindFirstChild("SpawnRuneDungeonPortalFrame")
	if v23 then
		local v24 = v23:FindFirstChild("SpawnPortalButton")
		if v24 then
			v24.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_8, (ref) v_u_4
				v_u_8:FireServer("RuneDungeon")
				v_u_4:Close("DungeonUI")
			end)
		end
		local v25 = v23:FindFirstChild("Holder")
		if v25 then
			local v26 = v25:FindFirstChild("TeleportPlace")
			local v27 = v25:FindFirstChild("Txt")
			if v26 then
				v26.Text = "Rune Dungeon"
			end
			if v27 then
				v27.Text = "Obtain runes!"
			end
		end
	end
	local v28 = v_u_14:FindFirstChild("SpawnDoubleDungeonPortalFrame")
	if v28 then
		local v29 = v28:FindFirstChild("SpawnPortalButton")
		if v29 then
			v29.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_8, (ref) v_u_4
				v_u_8:FireServer("DoubleDungeon")
				v_u_4:Close("DungeonUI")
			end)
		end
		local v30 = v28:FindFirstChild("Holder")
		if v30 then
			local v31 = v30:FindFirstChild("TeleportPlace")
			local v32 = v30:FindFirstChild("Txt")
			if v31 then
				v31.Text = "Double Dungeon"
			end
			if v32 then
				v32.Text = "Arise."
			end
		end
	end
end
local v_u_34 = nil
local function v_u_40()
	-- upvalues: (ref) v_u_34, (copy) v_u_3, (copy) v_u_9
	if v_u_34 then
		return
	else
		local v35 = v_u_3:WaitForChild("DungeonPortalJoinUI", 5)
		local v36 = v35 and v35:FindFirstChild("LeaveButton")
		if v36 then
			v36.Visible = false
			v36.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_9
				v_u_9:FireServer()
			end)
			v_u_34 = v36
		else
			local v37 = Instance.new("ScreenGui")
			v37.Name = "DungeonPortalJoinUI"
			v37.ResetOnSpawn = false
			v37.Parent = v_u_3
			local v38 = Instance.new("TextButton")
			v38.Name = "LeaveButton"
			v38.Size = UDim2.new(0, 180, 0, 55)
			v38.Position = UDim2.new(0.5, 0, 0.75, 0)
			v38.AnchorPoint = Vector2.new(0.5, 0.5)
			v38.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
			v38.Text = "Leave Portal"
			v38.TextColor3 = Color3.fromRGB(255, 255, 255)
			v38.TextScaled = true
			v38.Font = Enum.Font.GothamBold
			v38.Visible = false
			v38.Parent = v37
			local v39 = Instance.new("UICorner")
			v39.CornerRadius = UDim.new(0.15, 0)
			v39.Parent = v38
			v38.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_9
				v_u_9:FireServer()
			end)
			v_u_34 = v38
		end
	end
end
v7.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_4
	v_u_4:Open("DungeonUI")
end)
v11.OnClientEvent:Connect(function(p41)
	-- upvalues: (ref) v_u_16, (ref) v_u_17, (ref) v_u_34, (copy) v_u_40
	if p41.inPortal then
		v_u_16 = true
		v_u_17 = p41.dungeonId
		if not v_u_34 then
			v_u_40()
		end
		v_u_34.Visible = true
	else
		v_u_16 = false
		v_u_17 = nil
		if v_u_34 then
			v_u_34.Visible = false
		end
	end
end)
v10.OnClientEvent:Connect(function(_) end)
task.spawn(function()
	-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_15, (copy) v_u_33, (copy) v_u_40
	v_u_4:Register("DungeonUI", v_u_12)
	v_u_15.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_4
		v_u_4:Close("DungeonUI")
	end)
	v_u_33()
	v_u_40()
end)