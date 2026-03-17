local args = {[1] = "QuestNPC1"}
game:GetService("ReplicatedStorage").RemoteEvents.QuestAccept:FireServer(unpack(args))


local args = {
    [1] = "Jungle"
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(unpack(args))




local args = {
    [1] = "Jungle"
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(unpack(args))
