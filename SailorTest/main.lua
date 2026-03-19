-- [[ SAILOR PIECE COMPLETE AUTO-FARM SCRIPT ]]
-- Optimized with Render Distance Bypass

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remotes
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local QuestAccept = RemoteEvents:WaitForChild("QuestAccept")
local CombatRemotes = ReplicatedStorage:WaitForChild("CombatSystem"):WaitForChild("Remotes")
local RequestHit = CombatRemotes:WaitForChild("RequestHit")

-- Try to load TravelConfig for render distance bypass
local TravelConfig
pcall(function()
    TravelConfig = require(ReplicatedStorage:WaitForChild("TravelConfig"))
end)

-- Configuration
_G.AutoFarm = true
_G.AutoStats = true
_G.StatPriority = "Melee"

-- [[ ISLAND DATA ]]
local IslandData = {
    {
        Name = "SlimeIsland", 
        QuestNPC = "QuestNPC2", 
        TargetMob = "Slime", 
        MinLevel = 1,
    },
    {
        Name = "AcademyIsland", 
        QuestNPC = "QuestNPC15", 
        TargetMob = "Trainee", 
        MinLevel = 15,
    },
}

-- Helpers
function log(msg)
    print("[AUTO-FARM] " .. tostring(msg))
end

function getPlayerRoot()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

function getPlayerLevel()
    local data = LocalPlayer:FindFirstChild("Data")
    if data and data:FindFirstChild("Level") then return data.Level.Value end
    local stats = LocalPlayer:FindFirstChild("stats") or LocalPlayer:FindFirstChild("Stats")
    if stats and stats:FindFirstChild("Level") then return stats.Level.Value end
    return 1
end

function hasActiveQuest()
    local questTracking = PlayerGui:FindFirstChild("QuestTrackingUI")
    if questTracking and questTracking:FindFirstChild("Quest") then
        return questTracking.Quest.Visible
    end
    local questUI = PlayerGui:FindFirstChild("QuestUI")
    if questUI and questUI:FindFirstChild("Quest") then
        return questUI.Quest.Visible
    end
    return false
end

function getBestIsland()
    local level = getPlayerLevel()
    local best = IslandData[1]
    for _, island in ipairs(IslandData) do
        if level >= island.MinLevel then
            best = island
        end
    end
    return best
end

function getIslandCenter(islandName)
    -- Use decompiled TravelConfig Zones if available
    if TravelConfig and TravelConfig.Zones and TravelConfig.Zones[islandName] then
        return CFrame.new(TravelConfig.Zones[islandName].Center)
    end
    -- Fallback to workspace Model
    local folder = workspace:FindFirstChild(islandName)
    if folder then
        local part = folder:FindFirstChildWhichIsA("BasePart", true)
        if part then return part.CFrame end
    end
    return nil
end

function findNPC(name)
    -- Search in NPCs, ServiceNPCs, and StorageNPC
    for _, folderName in ipairs({"NPCs", "ServiceNPCs", "StorageNPC"}) do
        local folder = workspace:FindFirstChild(folderName)
        if folder then
            local npc = folder:FindFirstChild(name, true)
            if npc then return npc end
        end
    end
    return workspace:FindFirstChild(name, true)
end

function findNPCCFrame(name)
    local npc = findNPC(name)
    if npc and (npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart) then
        return npc:FindFirstChild("HumanoidRootPart").CFrame or npc.PrimaryPart.CFrame
    end
    if getgenv().CachedNPCs and getgenv().CachedNPCs[name] then
        return getgenv().CachedNPCs[name]
    end
    return nil
end

function teleport(targetCFrame)
    local root = getPlayerRoot()
    if not root or not targetCFrame then return end
    
    local distance = (root.Position - targetCFrame.Position).Magnitude
    if distance < 5 then return end
    
    local speed = 150
    local info = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(root, info, {CFrame = targetCFrame})
    
    -- Sync with bypass script
    getgenv().IsTeleporting = true
    tween:Play()
    
    -- Cleanup after teleport
    task.spawn(function()
        tween.Completed:Wait()
        getgenv().IsTeleporting = false
    end)
    
    return tween
end

-- Core Systems
-- 1. Auto Attack
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm then
            local root = getPlayerRoot()
            local island = getBestIsland()
            local target = findNPC(island.TargetMob)
            if root and target then
                local tRoot = target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart
                local humanoid = target:FindFirstChild("Humanoid")
                if tRoot and humanoid and humanoid.Health > 0 then
                    if (root.Position - tRoot.Position).Magnitude < 30 then
                        RequestHit:FireServer(tRoot.Position)
                    end
                end
            end
        end
    end
end)

-- 2. Auto Quest & Farm Loop
task.spawn(function()
    log("Farm Loop Active")
    while task.wait(1) do
        if not _G.AutoFarm then continue end
        
        local root = getPlayerRoot()
        if not root then continue end
        
        local island = getBestIsland()
        local activeQuest = hasActiveQuest()
        
        if not activeQuest then
            local qCF = findNPCCFrame(island.QuestNPC)
            if qCF then
                log("Heading to Quest NPC: " .. island.QuestNPC)
                local tw = teleport(qCF * CFrame.new(0, 0, 4))
                if tw then tw.Completed:Wait() end
                QuestAccept:FireServer(island.QuestNPC)
                task.wait(1)
            else
                log("Quest NPC " .. island.QuestNPC .. " not found. Bypassing Render Distance...")
                local islandPos = getIslandCenter(island.Name)
                if islandPos then
                    teleport(islandPos)
                else
                    log("Cannot find coordinates for " .. island.Name)
                end
            end
        else
            -- Farm mobs
            local target = findNPC(island.TargetMob)
            if target then
                local tRoot = target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart
                local humanoid = target:FindFirstChild("Humanoid")
                if tRoot and humanoid and humanoid.Health > 0 then
                    local farmPos = tRoot.CFrame * CFrame.new(0, 8, 0)
                    local distance = (root.Position - tRoot.Position).Magnitude
                    if distance > 12 then
                        teleport(farmPos)
                    end
                end
            else
                log("Looking for mobs: " .. island.TargetMob .. ". Flying to island...")
                local islandPos = getIslandCenter(island.Name)
                if islandPos then
                    teleport(islandPos)
                end
            end
        end
    end
end)

-- 3. Auto Stats
task.spawn(function()
    local allocate = RemoteEvents:FindFirstChild("AllocateStat")
    while task.wait(5) do
        if _G.AutoFarm and _G.AutoStats and allocate then
            allocate:FireServer(_G.StatPriority, 1)
        end
    end
end)

log("SAILOR PIECE SCRIPT UPDATED WITH RENDER BYPASS!")
