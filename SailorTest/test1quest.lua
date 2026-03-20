--lv 1-100 stater island

local args = {
	"QuestNPC1"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("QuestAccept"):FireServer(unpack(args))
workspace.NPCs.Thief1 
local args = {
	"Starter"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(unpack(args))


--lv 100-249 stater island
local args = {
	"QuestNPC2"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("QuestAccept"):FireServer(unpack(args))
workspace.NPCs.ThiefBoss



--workspace of npc
workspace.NPCs