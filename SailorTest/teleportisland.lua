-- [[ SAILOR PIECE: MAP & NPC CACHE SCANNER ]]
-- This script teleports to every island and uses memory scanning (getnilinstances) 
-- to find and cache NPCs, bypassing both Render Distance and StreamingEnabled.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Initialize Global Cache
getgenv().CachedNPCs = getgenv().CachedNPCs or {}

-- 1. Load Configurations (Island Centers)
-- If this fails, we will use hardcoded centers from your travelconfig.lua
local TravelConfig = nil
pcall(function()
    TravelConfig = require(game:GetService("ReplicatedStorage"):WaitForChild("TravelConfig"))
end)

local Islands = {
    ["StarterIsland"] = Vector3.new(108, 71, -234),
    ["JungleIsland"] = Vector3.new(-529, 44, 430),
    ["DesertIsland"] = Vector3.new(-919, 25, -462),
    ["SnowIsland"] = Vector3.new(-391, 64, -1195),
    ["BossIsland"] = Vector3.new(812, 23, -1133),
    ["ShibuyaStation"] = Vector3.new(1615, 184, 230),
    ["SailorIsland"] = Vector3.new(221, 68, 797),
    ["HuecoMundo"] = Vector3.new(-534, 72, 1181),
    ["DungeonIsland"] = Vector3.new(1374, 20, -907),
    ["ShinjukuIsland"] = Vector3.new(300, 50, -2126),
    ["SlimeIsland"] = Vector3.new(-1249, 41, 251),
    ["AcademyIsland"] = Vector3.new(954, 48, 1317),
    ["SoulSociety"] = Vector3.new(-1487, 1794, 1721),
    ["JudgementIsland"] = Vector3.new(-1235, 40, -1274)
}

-- Use data from travelconfig if successfully loaded
if TravelConfig and TravelConfig.Zones then
    for name, data in pairs(TravelConfig.Zones) do
        Islands[name] = data.Center
    end
end

-- 2. Scaning Function (Combined Workspace + Hidden Memory)
local function scanNPCs()
    local found = 0
    
    -- Scan standard folders
    local folders = {"NPCs", "ServiceNPCs", "StorageNPC"}
    for _, fName in ipairs(folders) do
        local folder = workspace:FindFirstChild(fName)
        if folder then
            for _, npc in ipairs(folder:GetChildren()) do
                if npc:IsA("Model") and npc.PrimaryPart then
                    getgenv().CachedNPCs[npc.Name] = npc.PrimaryPart.CFrame
                end
            end
        end
    end
    
    -- Scan Nil Instances (Roblox Memory Cache)
    if getnilinstances then
        for _, instance in pairs(getnilinstances()) do
            if instance:IsA("Model") then
                local root = instance.PrimaryPart or instance:FindFirstChild("HumanoidRootPart")
                local isNPC = instance:FindFirstChildOfClass("Humanoid") ~= nil or instance.Name:find("QuestNPC") or instance.Name:find("Trainee") or instance.Name:find("NPC")
                if root and isNPC then
                    if not getgenv().CachedNPCs[instance.Name] then
                        getgenv().CachedNPCs[instance.Name] = root.CFrame
                        found = found + 1
                    end
                end
            end
        end
    end
    return found
end

-- 3. Movement Function (Fly/Tween)
local function teleport(targetPos)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local distance = (hrp.Position - targetPos).Magnitude
    local speed = 120 -- LOWERED SPEED: 250 was too fast and triggered anti-cheat
    local duration = distance / speed
    
    -- Fly a bit higher to avoid hitting obstacles that might trigger velocity checks
    local heightOffset = Vector3.new(0, 100, 0)
    
    local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos + heightOffset)})
    tween:Play()
    tween.Completed:Wait()
    
    -- Wait longer at destination to let game state stabilize
    task.wait(3) 
end

-- 4. Main Loop
print("[SCANNER] Starting Full Map & Memory Scan (SAFE MODE)...")

for islandName, center in pairs(Islands) do
    print("[SCANNER] Traveling to: " .. islandName)
    teleport(center)
    local count = scanNPCs()
    print("[SCANNER] Found " .. count .. " new NPCs on " .. islandName)
    
    -- Randomized break between islands to look more "human"
    task.wait(math.random(2, 4))
end

print("[SCANNER] Scan Finished!")
local total = 0
for _ in pairs(getgenv().CachedNPCs) do total = total + 1 end
print("[SCANNER] Result: " .. total .. " NPCs cached and ready for Auto-Farm.")
