local questcheck = require(game:GetService("ReplicatedStorage").Modules.QuestConfig)
local player = game:GetService("Players").LocalPlayer
local level = player.Data.Level.Value
local tween_s = game:GetService("TweenService") 
local info = TweenInfo.new(0.5) 
local checkmap = require(game:GetService("ReplicatedStorage").TravelConfig)
local hrp = player.Character:FindFirstChild("HumanoidRootPart")
local zoneid ,zoneinfo = checkmap.GetZoneAt(hrp.Position)
getgenv().IsFarm = true

function getTargetQuest()
    local bestNPC = nil
    local maxLevelFound = -1
    
    for npcName, data in pairs(questcheck.RepeatableQuests) do
        local req = tonumber(data.recommendedLevel) or 0
       
        if level >= req and req > maxLevelFound then
            maxLevelFound = req
            bestNPC = npcName
           choosenpc = table.unpack(data.requirements)["npcType"]
          
        end
    end
    return bestNPC,maxLevelFound,choosenpc
end
local targetNPC,maxLevelFound,choosenpc = getTargetQuest()

function checkhumanoidRootPart()
for i,v in pairs(game.workspace.NPCs:GetChildren()) do
if string.find(v.Name,choosenpc) then
if not v:FindFirstChild("HumanoidRootPart") then
return true
end
end
end
end



local sucess,fail = checkhumanoidRootPart()

if sucess and maxLevelFound == level then

   local args = {
    [1] = "Jungle"
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(unpack(args))


else
    print("not found")
end

while getgenv().IsFarm do wait()
if targetNPC then
    game:GetService("ReplicatedStorage").RemoteEvents.QuestAccept:FireServer(targetNPC)
end

for i,v in pairs(game.workspace.NPCs:GetChildren()) do
if string.find(v.Name,choosenpc) then
local cframe = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 0, 5))
local tween = tween_s:Create(player.Character["HumanoidRootPart"], info, {CFrame = cframe})
tween:Play()
end
end
end