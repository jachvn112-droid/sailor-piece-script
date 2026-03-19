local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1.LocalPlayer:WaitForChild("PlayerGui")
require(v2:WaitForChild("Modules"):WaitForChild("DungeonConfig"))
local v_u_4 = require(v2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v5 = v2:WaitForChild("Remotes")
local v6 = v2:WaitForChild("RemoteEvents")
local v7 = v5:WaitForChild("OpenBossRushUI")
local v_u_8 = v5:WaitForChild("RequestDungeonPortal")
v6:WaitForChild("DungeonUIUpdate")
v5:WaitForChild("LeaveDungeonPortal")
local v_u_9 = v_u_3:WaitForChild("BossRushUI"):WaitForChild("MainFrame")
local v10 = v_u_9:WaitForChild("Frame")
local v11 = v10:WaitForChild("Content"):WaitForChild("Holder")
v10:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton").MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_4
	v_u_4:Close("BossRushUI")
end)
local v12 = v11:FindFirstChild("SpawnBossRushPortalFrame")
local v13 = v12 and v12:FindFirstChild("SpawnPortalButton")
if v13 then
	v13.MouseButton1Click:Connect(function()
		-- upvalues: (copy) v_u_8, (copy) v_u_4
		v_u_8:FireServer("BossRush")
		v_u_4:Close("BossRushUI")
	end)
end
local v_u_14 = nil
v7.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_4
	v_u_4:Open("BossRushUI")
end)
task.spawn(function()
	-- upvalues: (copy) v_u_4, (copy) v_u_9, (copy) v_u_3, (ref) v_u_14
	v_u_4:Register("BossRushUI", v_u_9)
	local v15 = v_u_3:WaitForChild("DungeonPortalJoinUI", 5)
	local v16 = v15 and v15:FindFirstChild("LeaveButton")
	if v16 then
		v_u_14 = v16
	end
end)