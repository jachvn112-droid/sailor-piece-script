local checkmap = require(game:GetService("ReplicatedStorage").TravelConfig)
local player = game.Players.LocalPlayer

if player and player.Character then
local hrp = player.Character:FindFirstChild("HumanoidRootPart")
local zoneid ,zoneinfo = checkmap.GetZoneAt(hrp.Position)
print(zoneid)

end